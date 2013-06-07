package brickbreaker

import javafx.collections.ObservableList
import java.util.Arrays
import javafx.collections.FXCollections

class LevelData {
	private static final String NEXT_LEVEL = "---"

    private static final String[] LEVELS_DATA = #[
        "",
        "",
        "",
        "",
        "WWWWWWWWWWWWWWW",
        "WYYWYYWYWYYWYYW",
        "WWWWWWWWWWWWWWW",
        "WWWWWWWWWWWWWWW",
        "RWRWRWRWRWRWRWR",
        "WRWRWRWRWRWRWRW",
        "WWWWWWWWWWWWWWW",
        "LLLLLLLLLLLLLLL",

        NEXT_LEVEL,

        "",
        "",
        "",
        "",
        "",
        "W              ",
        "WO             ",
        "WOG            ",
        "WOGR           ",
        "WOGRB          ",
        "WOGRBC         ",
        "WOGRBCL        ",
        "WOGRBCLV       ",
        "WOGRBCLVY      ",
        "WOGRBCLVYM     ",
        "WOGRBCLVYMW    ",
        "WOGRBCLVYMWO   ",
        "WOGRBCLVYMWOG  ",
        "WOGRBCLVYMWOGR ",
        "22222222222222B",

        NEXT_LEVEL,

        "",
        "",
        "",
        "00    000000000",
        "",
        "    222 222 222",
        "    2G2 2G2 2G2",
        "    222 222 222",
        "",
        "  222 222 222  ",
        "  2R2 2R2 2R2  ",
        "  222 222 222  ",
        "",
        "222 222 222    ",
        "2L2 2L2 2L2    ",
        "222 222 222    ",

        NEXT_LEVEL,

        "RRRRRRRRRRRRRRR",
        "RWWWWWWWWWWWWWR",
        "RWRRRRRRRRRRRWR",
        "RWRWWWWWWWWWRWR",
        "RWRWRRRRRRRWRWR",
        "RWRWR     RWRWR",
        "RWRWR     RWRWR",
        "RWRWR     RWRWR",
        "RWRWR     RWRWR",
        "RWRWR     RWRWR",
        "RWRW2222222WRWR",
        "",
        "",
        "222222222222222",

        NEXT_LEVEL,

        "",
        "    Y     Y    ",
        "    Y     Y    ",
        "     Y   Y     ",
        "     Y   Y     ",
        "    2222222    ",
        "   222222222   ",
        "   22R222R22   ",
        "  222R222R222  ",
        " 2222222222222 ",
        " 2222222222222 ",
        " 2222222222222 ",
        " 2 222222222 2 ",
        " 2 2       2 2 ",
        " 2 2       2 2 ",
        "    222 222    ",
        "    222 222    ",

        NEXT_LEVEL,

        "OOOOOOOOOOOOOOO",
        "OOOOOOOOOOOOOOO",
        "OOOOOOOOOOOOOOO",
        "",
        "",
        "GGGGGGGGGGGGGGG",
        "GGGGGGGGGGGGGGG",
        "GGGGGGGGGGGGGGG",
        "",
        "",
        "YYYYYYWWWYYYYYY",
        "222222WWW222222",
        "YYYYYYWWWYYYYYY",
        "YYY0       0YYY",
        "YY           YY",
        "Y             Y",

        NEXT_LEVEL,

        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "R O Y W G B C M",
        "2 2 2 2 2 2 2 2",

        NEXT_LEVEL,

        "",
        "",
        "RRR YYY G G RRR",
        "  R Y Y G G R R",
        "  R Y Y G G R R",
        "  R YYY G G RRR",
        "  R Y Y G G R R",
        "  R Y Y G G R R",
        "RR  Y Y  G  R R",
        "               ",
        "    222 2 2    ",
        "    2   2 2    ",
        "    2   2 2    ",
        "    222  2     ",
        "    2   2 2    ",
        "    2   2 2    ",
        "    2   2 2    "
    ]

    private static ObservableList<Integer> levelsOffsets

    def static int getLevelsCount() {
        initLevelsOffsets()
        return levelsOffsets.size() - 1
    }

    def static String[] getLevelData(int level) {
        initLevelsOffsets()
        if (level < 1 || level > getLevelsCount()) {
            return null
        } else {
            return Arrays.copyOfRange(LEVELS_DATA, levelsOffsets.get(level - 1) + 1, levelsOffsets.get(level))
        }
    }

    def private static void initLevelsOffsets() {
        if (levelsOffsets == null) {
            levelsOffsets = FXCollections.<Integer>observableArrayList()
            levelsOffsets.add(-1)
            for (int i : 0 ..< LEVELS_DATA.length) {
                if (LEVELS_DATA.get(i).equals(NEXT_LEVEL)) {
                    levelsOffsets.add(i)
                }
            }
            levelsOffsets.add(LEVELS_DATA.length + 1)
        }
    }
	
}