generic
   type Flags_Type is mod <>;
   type Option_Type is (<>);
package Bitflags with
  SPARK_Mode
is

   subtype Option is Option_Type;
   type Options is record
      Value : Flags_Type;
   end record;

   function Empty return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  => Empty'Result.Value = 0;

   function Complete return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  => (for all Opt in Option => Contains (Complete'Result, Opt));

   function "+" (Left, Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Option'Enum_Rep (Left) or Option'Enum_Rep (Right))) =
        Flags_Type (0);

   function "+" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Left.Value or Option'Enum_Rep (Right))) = Flags_Type (0);

   function "+" (Left : Option; Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Right.Value or Option'Enum_Rep (Left))) = Flags_Type (0);

   function "+" (Left, Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Left.Value or Right.Value)) = Flags_Type (0);

   function "-" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      ("-"'Result.Value and Flags_Type (Option'Enum_Rep (Right))) = Flags_Type (0)
      and then
      (if Contains (Left, Right) then
         ("-"'Result.Value or Flags_Type (Option'Enum_Rep (Right))) = Left.Value
       else True);

   function "-" (Left, Right : Options) return Options with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      ("-"'Result.Value and Right.Value) = Flags_Type (0)
      and then
      (if (Left.Value and Right.Value) = Right.Value then
         ("-"'Result.Value or Right.Value) = Left.Value
       else True);

   function Contains (Left : Options; Right : Option) return Boolean with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  =>
      Contains'Result =
      ((Left.Value and Flags_Type (Option'Enum_Rep (Right))) =
       Flags_Type (Option'Enum_Rep (Right)));

   function Contains (Left, Right : Options) return Boolean with
     Inline_Always, Global => null, Pre => Flags_Type'Size = Option_Type'Size,
     Post                  => Contains'Result = ((Left.Value and Right.Value) = Right.Value);

private

   pragma Assert (Flags_Type'Size = Option_Type'Size);

end Bitflags;
