package macro;

import haxe.macro.Context;
import haxe.macro.Expr;

class RenameNilMacro {
    public static function run() {
        var types = Context.getTypes();

        for (t in types) {
            var td = t.get();
            if (td.pack.length == 1 && td.pack[0] == "thx" && td.name == "Nil") {
                // Rename the class
                Context.renameType(t, "ThxNil");
                Context.warning("Renaming thx.Nil → thx.ThxNil to avoid Obj-C++ Nil keyword conflict", td.pos);
            }
        }
    }
}
