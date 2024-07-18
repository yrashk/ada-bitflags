generic
   type Flags_Type is mod <>;
   type Option_Type is (<>);
package Bitflags with
  SPARK_Mode
is

   subtype Option is Option_Type;
   type Options is new Flags_Type;

   function Empty return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  => Flags_Type (Empty'Result) = 0;

   function Complete return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (for all Opt in Option =>
         (Flags_Type (Complete'Result) and Flags_Type (Option'Enum_Rep (Opt))) =
         Flags_Type (Option'Enum_Rep (Opt)));

   function "+" (Left, Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("+"'Result) and Option'Enum_Rep (Left)) = Option'Enum_Rep (Left)
      and then (Flags_Type ("+"'Result) and Option'Enum_Rep (Right)) = Option'Enum_Rep (Right)
      and then (Flags_Type ("+"'Result) xor (Option'Enum_Rep (Left) or Option'Enum_Rep (Right))) =
        Flags_Type (0);

   function "+" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("+"'Result) and Flags_Type (Left)) = Flags_Type (Left)
      and then (Flags_Type ("+"'Result) and Option'Enum_Rep (Right)) = Option'Enum_Rep (Right)
      and then (Flags_Type ("+"'Result) xor (Flags_Type (Left) or Option'Enum_Rep (Right))) =
        Flags_Type (0);

   function "+" (Left : Option; Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("+"'Result) and Flags_Type (Right)) = Flags_Type (Right)
      and then (Flags_Type ("+"'Result) and Option'Enum_Rep (Left)) = Option'Enum_Rep (Left)
      and then (Flags_Type ("+"'Result) xor (Flags_Type (Right) or Option'Enum_Rep (Left))) =
        Flags_Type (0);

   function "+" (Left, Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("+"'Result) and Flags_Type (Left)) = Flags_Type (Left)
      and then (Flags_Type ("+"'Result) and Flags_Type (Right)) = Flags_Type (Right)
      and then (Flags_Type ("+"'Result) xor (Flags_Type (Left) or Flags_Type (Right))) =
        Flags_Type (0);

   function "-" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("-"'Result) and Flags_Type (Option'Enum_Rep (Right))) = Flags_Type (0)
      and then
      (if
         (Flags_Type (Left) and Flags_Type (Option'Enum_Rep (Right))) =
         Flags_Type (Option'Enum_Rep (Right))
       then (Flags_Type ("-"'Result) or Flags_Type (Option'Enum_Rep (Right))) = Flags_Type (Left)
       else True);

   function "-" (Left : Options; Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      (Flags_Type ("-"'Result) and Flags_Type (Right)) = Flags_Type (0)
      and then
      (if (Flags_Type (Left) and Flags_Type (Right)) = Flags_Type (Right) then
         (Flags_Type ("-"'Result) or Flags_Type (Right)) = Flags_Type (Left)
       else True);

   function Includes (Left : Options; Right : Option) return Boolean with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Includes'Result =
      ((Flags_Type (Left) and Flags_Type (Option'Enum_Rep (Right))) =
       Flags_Type (Option'Enum_Rep (Right)));

end Bitflags;
