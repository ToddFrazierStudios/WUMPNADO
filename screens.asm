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
.ascii  "                             Press any key to begin                             "
.asciiz "                                                                                " #line 25
#                                                ## <-- CENTER