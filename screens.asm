.data

#this screen should not be used, it is only here for copy/paste reasons
.globl screen_blank
screen_blank:                                    ## <-- CENTER
.ascii  "                                                                                " #line 1
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                " #line 5
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                " #line 10
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                " #line 15
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                " #line 20
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.asciiz "                                                                                " #line 25
#                                                ## <-- CENTER

.globl screen_gameover_pit
screen_gameover_pit:                             ## <-- CENTER
.ascii  "################$$$$$$$$$$$$$**********************$$$$$$$$$$$$$################" #line 1
.ascii  "###########$$$$$$$$$************                ************$$$$$$$$$###########"
.ascii  "######$$$$$******                                              ******$$$$$######"
.ascii  "###$$$***                                                              ***$$$###"
.ascii  "##$$**                                                                    **$$##" #line 5
.ascii  "#$*                                                                          *$#"
.ascii  "$*                                                                            *$"
.ascii  "*                                                                              *"
.ascii  "                                _____----------______                           "
.ascii  "                          _____/#####################\\______                    " #line 10
.ascii  "                     ____/##################################\\_____              "
.ascii  "                    /#############################################\\             "
.ascii  "                    \\#############################################/             "
.ascii  "                          ###################################                   "
.ascii  "                                ######################                          " #line 15
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "*                                                                              *"
.ascii  "$*                                                                            *$"
.ascii  "#$*                       You fell down a pit and died.                      *$#" #line 20
.ascii  "##$$**                                                                    **$$##"
.ascii  "###$$$***                                                              ***$$$###"
.ascii  "######$$$$$******                   GAME OVER                  ******$$$$$######"
.ascii  "###########$$$$$$$$$************                ************$$$$$$$$$###########"
.asciiz "################$$$$$$$$$$$$$**********************$$$$$$$$$$$$$################" #line 25
#                                                ## <-- CENTER

.globl screen_gameover_eaten
screen_gameover_eaten:                           ## <-- CENTER
.ascii  "                                     ____                                       " #line 1
.ascii  "                              __,---'     `--.__                                "
.ascii  "                           ,-'                ; `.                              "
.ascii  "                          ,'                  `--.`--.                          "
.ascii  "                         ,'                       `._ `-.                       " #line 5
.ascii  "                         ;                     ;     `-- ;                      "
.ascii  "                       ,-'-_       _,-~~-.      ,--      `.                     "
.ascii  "                       ;;   `-,;    ,'~`.__    ,;;;    ;  ;                     "
.ascii  "                       ;;    ;,'  ,;;      `,  ;;;     `. ;                     "
.ascii  "                       `:   ,'    `:;     __/  `.;      ; ;                     " #line 10
.ascii  "                        ;~~^.   `.   `---'~~    ;;      ; ;                     "
.ascii  "                        `,' `.   `.            .;;;     ;'                      "
.ascii  "                        ,',^. `.  `._    __    `:;     ,'                       "
.ascii  "                        `-' `--'    ~`--'~~`--.  ~    ,'                        "
.ascii  "                       /;`-;_ ; ;. /. /   ; ~~`-.     ;                         " #line 15
.ascii  "-._                   ; ;  ; `,;`-;__;---;      `----'                          "
.ascii  "   `--.__             ``-`-;__;:  ;  ;__;                                       "
.ascii  " ...     `--.__                `-- `-'                                          "
.ascii  "`--.:::...     `--.__                ____         You were eaten by a Wumpus    "
.ascii  "    `--:::::--.      `--.__    __,--'    `.                                     " #line 20
.ascii  "        `--:::`;....       `--'       ___  `.                                   "
.ascii  "            `--`-:::...     __           )  ;             GAME OVER             "
.ascii  "                  ~`-:::...   `---.      ( ,'                                   "
.ascii  "                      ~`-:::::::::`--.   `-.                                    "
.asciiz "                          ~`-::::::::`.    ;                                    " #line 25
        #                              ~`--:::,'   ,'
        #                                   ~~`--'~
#                                                ## <-- CENTER

.globl screen_gameover_win
screen_gameover_win:                             ## <-- CENTER
.ascii  "                                                                                " #line 1
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                              You found the treasure and made your escape!      "
.ascii  "                                                                                " #line 5
.ascii  "                                                                                "
.ascii  "                      _.--.                                                     "
.ascii  "                  _.-'_:-'||                                                    "
.ascii  "              _.-'_.-::::'||                                                    "
.ascii  "         _.-:'_.-::::::'  ||                                                    " #line 10
.ascii  "       .'`-.-:::::::'     ||                         YOU WIN!                   "
.ascii  "      /.'`;|:::::::'      ||_                                                   "
.ascii  "     ||   ||::::::'     _.;._'-._                                               "
.ascii  "     ||   ||:::::'  _.-!oo @.!-._'-.                                            "
.ascii  "     \\'.  ||:::::.-!()oo @!()@.-'_.|                                            " #line 15
.ascii  "      '.'-;|:.-'.&$@.& ()$%-'o.'\\U||                                            "
.ascii  "        `>'-.!@%()@'@_%-'_.-o _.|'||                                            "
.ascii  "         ||-._'-.@.-'_.-' _.-o  |'||                                            "
.ascii  "         ||=[ '-._.-\\U/.-'    o |'||                                            "
.ascii  "         || '-.]=|| |'|      o  |'||                                            " #line 20
.ascii  "         ||      || |'|        _| ';                                            "
.ascii  "         ||      || |'|    _.-'_.-'                                             "
.ascii  "         |'-._   || |'|_.-'_.-'                                                 "
.ascii  "          '-._'-.|| |' `_.-'                                                    "
.asciiz "              '-.||_/.-'                                                        " #line 25


.globl screen_logo
screen_logo: 
.ascii  "--------------------------------------------------------------------------------" #line 1
.ascii  "                                                                                "
.ascii  "        #     # #     # #     # ######  #     #    #    ######  #######         "
.ascii  "        #  #  # #     # ##   ## #     # ##    #   # #   #     # #     #         "
.ascii  "        #  #  # #     # # # # # #     # # #   #  #   #  #     # #     #         " #line 5
.ascii  "        #  #  # #     # #  #  # ######  #  #  # #     # #     # #     #         "
.ascii  "        #  #  # #     # #     # #       #   # # ####### #     # #     #         "
.ascii  "        #  #  # #     # #     # #       #    ## #     # #     # #     #         "
.ascii  "         ## ##   #####  #     # #       #     # #     # ######  #######         "
.ascii  "                                                                                " #line 10
.ascii  "--------------------------------------------------------------------------------"
.ascii  "                                                                                "
.ascii  "                  A work of true art by Todd Frazier Studios.                   "
.ascii  "                                                                                "
.ascii  "--------------------------------------------------------------------------------" #line 15
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                       _________________________________                        "
.ascii  "                      |                                 |                       "
.ascii  "                      |                                 |                       " #line 20
.ascii  "                      |_________________________________|                       "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.asciiz "                                                        Press h for how to play " #line 25

.globl screen_help
screen_help:                                     ## <-- CENTER
.ascii  "                                                                                " #line 1
.ascii  "                                   How to Play                                  "
.ascii  "                                                                                "
.ascii  "  In your endless quest for treasure, you find yourself in the dreaded Wumpus   "
.ascii  " Caves.  The Wumpus Caves are the dark and mysterious home of the deadly        " #line 5
.ascii  " and extremely smelly Wumpus.  You know that somewhere within the pitch-black   "
.ascii  " rooms of the Wumpus Caves, an amazing treasure sleeps, just waiting for you to "
.ascii  " get it.                                                                        "
.ascii  "                                                                                "
.ascii  "  Your goal is simple: get the treasure and get back outside safely.  The       " #line 10
.ascii  " Wumpus Caves are made up of several connected rooms.  At each room, you will   "
.ascii  " able to move north, south, east, or west, but beware, some rooms contain       "
.ascii  " deadly bottomless pits of death, or if you're really unlucky, a Wumpus.  There "
.ascii  " are also tales of the Wumpnado, a force of nature so strong, it can rearrange  "
.ascii  " the very rooms of the cave around you!                                         " #line 15
.ascii  "                                                                                "
.ascii  "  You will enter the caves from the northwest corner, if you manage to find the "
.ascii  " treasure and make it back to the entrance, you win!                            "
.ascii  "                                                                                "
.ascii  "                                                                                " #line 20
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.asciiz "                                                                                " #line 25
#                                                ## <-- CENTER
