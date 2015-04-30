package mars.mips.instructions.syscalls;

import java.util.LinkedList;
import java.util.Observable;
import java.util.Observer;
import java.util.Queue;

import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.RegisterFile;
import mars.simulator.Simulator;
import mars.simulator.SimulatorNotice;

public class SyscallClassicConsoleReadChar extends AbstractSyscall {
	private static SyscallClassicConsoleReadChar instance;
	
	private Queue<Integer> charQueue = new LinkedList<Integer>();
	
	private boolean simulatorRunning = false;
	
	
	public SyscallClassicConsoleReadChar(){
		super(100, "ClassicConsoleReadChar");
		instance = this;
		Simulator.getInstance().addObserver(new Observer() {
			
			@Override
			public void update(Observable o, Object arg) {
				SimulatorNotice notice = (SimulatorNotice)arg;
				if(notice.getAction() == SimulatorNotice.SIMULATOR_START)simulatorRunning = true;
				if(notice.getAction() == SimulatorNotice.SIMULATOR_STOP) simulatorRunning = false;
			}
		});
	}

	@Override
	public void simulate(ProgramStatement statement) throws ProcessingException {
		int retChar;
		if(charQueue.isEmpty()){
			retChar = 0;
		} else {
			retChar = charQueue.poll();
		}
		
		RegisterFile.updateRegister(2, retChar);
	}
	
	public void addChar(char c){
		if(simulatorRunning){
			charQueue.add(c & 0xFF);
		}
	}
	
	public static SyscallClassicConsoleReadChar getInstance(){
		return instance;
	}

	public void clearInputBuffer() {
		charQueue.clear();
		
	}

}
