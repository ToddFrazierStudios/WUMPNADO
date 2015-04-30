package mars.tools;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.Insets;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.Observable;
import java.util.Observer;

import javax.swing.JDialog;
import javax.swing.JTextArea;

import mars.mips.hardware.AccessNotice;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.Memory;
import mars.mips.hardware.MemoryAccessNotice;
import mars.mips.instructions.syscalls.SyscallClassicConsoleReadChar;
import mars.simulator.Simulator;
import mars.simulator.SimulatorNotice;

public class ClassicConsole implements MarsTool {
	
	private static final int NUMBER_OF_ROWS = 25;
	private static final int CHARACTERS_PER_ROW = 80;
	
	private static final int MARGINS = 3;
	
	private static final int FONT_SIZE = 15;
	
	private static final int STARTING_ADDRESS = 0x10020000;
	private static final int ENDING_ADDRESS = STARTING_ADDRESS + (NUMBER_OF_ROWS * CHARACTERS_PER_ROW);
	
	private static boolean isRunning = false;
	
	private char[][] charBuffer = new char[NUMBER_OF_ROWS][CHARACTERS_PER_ROW];
	
	private JDialog dialog;
	private JTextArea textArea;
	
	private static ClassicConsole instance = null;
	
	public ClassicConsole(){
		if(instance == null){
			instance = this;
			dialog = new JDialog();
			dialog.setLayout(new BorderLayout());
			
			textArea = new JTextArea(NUMBER_OF_ROWS, CHARACTERS_PER_ROW);
			textArea.setFont(new Font("Monospaced", Font.BOLD, FONT_SIZE));
			textArea.setEditable(false);
			textArea.setSelectionColor(Color.LIGHT_GRAY);
			textArea.setSelectedTextColor(Color.BLACK);
			textArea.setBackground(Color.BLACK);
			textArea.setForeground(Color.LIGHT_GRAY);
			textArea.setLineWrap(false);
			textArea.setMargin(new Insets(MARGINS, MARGINS, MARGINS, MARGINS));
			
			updateText();
			dialog.add(textArea, BorderLayout.CENTER);
			
//			JPanel bottomPanel = new JPanel();
//			bottomPanel.setLayout(new BoxLayout(bottomPanel, BoxLayout.X_AXIS));
//			bottomPanel.setBorder(new TitledBorder(new EtchedBorder(),"Classic Console Controls"));
//			JButton resetButton = new JButton("Reset");
//			resetButton.addActionListener(new ActionListener() {
//				@Override
//				public void actionPerformed(ActionEvent e) {
//					resetButtonAction();
//				}
//			});
//			bottomPanel.add(resetButton);
//			bottomPanel.add(Box.createHorizontalStrut(5));
//			bottomPanel.add(new JLabel("Press this button whenever resetting MARS"));
//			bottomPanel.add(Box.createHorizontalGlue());
//			
//			
//			dialog.add(bottomPanel, BorderLayout.SOUTH);
			
			dialog.pack();
			dialog.setResizable(false);
			dialog.setDefaultCloseOperation(JDialog.HIDE_ON_CLOSE);
	//		dialog.setAlwaysOnTop(true);
			dialog.setTitle("Classic Console");
			
	//		dialog.addKeyListener(new ClassicConsoleInputHandler());
			textArea.addKeyListener(new ClassicConsoleInputHandler());
			
			
			try {
				mars.mips.hardware.Memory.getInstance().addObserver(new Observer() {
					
					@Override
					public void update(Observable o, Object arg) {
						//System.out.println("MEMORY");
						MemoryAccessNotice man = (MemoryAccessNotice)arg;
						if(man.getAccessType()!=AccessNotice.WRITE) return;
						int index = man.getAddress() - STARTING_ADDRESS;
						int row = index / CHARACTERS_PER_ROW;
						int col = index % CHARACTERS_PER_ROW;
						for(int i = (man.getLength()-1); i >=0; i--){
							charBuffer[row][col + i] = (char)(man.getValue() >> (8*i));
						}
						updateText();
						if(!dialog.isVisible()){
							dialog.setVisible(true);
						}
						textArea.requestFocus();
					}
				}, STARTING_ADDRESS, ENDING_ADDRESS);
			} catch (AddressErrorException e) {
				e.printStackTrace();
			}
			Simulator.getInstance().addObserver(new Observer() {
				
				@Override
				public void update(Observable o, Object rawargs) {
					SimulatorNotice notice = (SimulatorNotice)rawargs;
					reloadFromMemory();
					updateText();
					if(notice.getAction() == SimulatorNotice.SIMULATOR_START)isRunning = true;
					if(notice.getAction() == SimulatorNotice.SIMULATOR_STOP)isRunning = false;
				}
			});
			
			textArea.addFocusListener(new FocusListener() {
				
				@Override
				public void focusLost(FocusEvent e) {
					if(isRunning){
						textArea.requestFocus();
					}
				}
				
				@Override
				public void focusGained(FocusEvent e) {
					//NOP
				}
			});
		}
	}
	
	private void reloadFromMemory(){
		int addr = STARTING_ADDRESS;
		for(int row = 0; row < NUMBER_OF_ROWS; row ++){
			for(int col = 0; col < CHARACTERS_PER_ROW; col++){
				try {
					charBuffer[row][col] = (char)Memory.getInstance().get(addr, 1);
					addr++;
				} catch (AddressErrorException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
//	private void resetButtonAction(){
//		reloadFromMemory();
//		updateText();
//		SyscallClassicConsoleReadChar.getInstance().clearInputBuffer();
//	}
	
	private void updateText(){
		StringBuffer buffer = new StringBuffer(NUMBER_OF_ROWS * CHARACTERS_PER_ROW + NUMBER_OF_ROWS);
		for(int row = 0; row < NUMBER_OF_ROWS; row ++){
			for(int col = 0; col < CHARACTERS_PER_ROW; col++){
				char cur = charBuffer[row][col];
				if(Character.isWhitespace(cur)) cur = ' ';
				if(cur == '\0') cur = ' ';
				buffer.append(cur);
			}
			buffer.append('\n');
		}
		textArea.setText(buffer.toString());
	}

	@Override
	public String getName() {
		return "Classic Console";
	}

	@Override
	public void action() {
//		Random rand = new Random();
//		for(int r = 0; r<NUMBER_OF_ROWS; r++)
//			for(int c = 0; c<CHARACTERS_PER_ROW; c++)
//				charBuffer[r][c] = (char)('!' + rand.nextInt('~'-'!'));
		if(instance != null && instance != this)instance.action();
		dialog.pack();
		reloadFromMemory();
		updateText();
		dialog.setVisible(true);
		textArea.requestFocus();
		
	}
	
	private class ClassicConsoleInputHandler implements KeyListener {

		@Override
		public void keyTyped(KeyEvent e) {
			if(!isRunning) return; //might fix mac problems?
			SyscallClassicConsoleReadChar.getInstance().addChar(e.getKeyChar());
			textArea.requestFocus();
			e.consume();
		}

		@Override
		public void keyPressed(KeyEvent e) {
			//NOP
		}

		@Override
		public void keyReleased(KeyEvent e) {
			//NOP
		}
		
	}

}
