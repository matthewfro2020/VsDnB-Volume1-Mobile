import sys.FileSystem;
import sys.io.File;

class RenameNilFix {
    public static function main() {
        var dirs = [
            "export/cpp/obj/include/thx/",
            "export/cpp/obj/src/thx/",
            "export/mac/obj/include/thx/",
            "export/mac/obj/src/thx/"
        ];

        for (dir in dirs) {
            if (FileSystem.exists(dir)) {
                renameIfExists(dir + "Nil.h",  dir + "ThxNil.h");
                renameIfExists(dir + "Nil.cpp", dir + "ThxNil.cpp");
                
                patchIncludes(dir + "ThxNil.h");
                patchIncludes(dir + "ThxNil.cpp");
            }
        }
    }

    static function renameIfExists(oldPath:String, newPath:String) {
        if (FileSystem.exists(oldPath)) {
            FileSystem.rename(oldPath, newPath);
        }
    }

    static function patchIncludes(path:String) {
        if (!FileSystem.exists(path)) return;

        var txt = File.getContent(path);

        txt = StringTools.replace(txt, "Nil.h", "ThxNil.h");
        txt = StringTools.replace(txt, "Nil.cpp", "ThxNil.cpp");
        txt = StringTools.replace(txt, "Nil_obj", "ThxNil_obj");
        txt = StringTools.replace(txt, "Nil", "ThxNil");

        File.saveContent(path, txt);
    }
}
