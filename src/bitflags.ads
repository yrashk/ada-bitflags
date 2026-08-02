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

   function Valid_Configuration return Boolean is
     (Flags_Type'Modulus = 2**Flags_Type'Size
      and then Option'Pos (Option'Last) < Flags_Type'Size)
   with Ghost;

   function Mask (Value : Option) return Flags_Type is
     (Flags_Type (2) ** Option'Pos (Value))
   with Inline_Always, Global => null, Pre => Valid_Configuration;

   function Empty return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  => Empty'Result.Value = 0;

   function Complete return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  => (for all Opt in Option => Contains (Complete'Result, Opt));

   function "+" (Left, Right : Option) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Mask (Left) or Mask (Right))) = Flags_Type (0);

   function "+" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Left.Value or Mask (Right))) = Flags_Type (0);

   function "+" (Left : Option; Right : Options) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Right.Value or Mask (Left))) = Flags_Type (0);

   function "+" (Left, Right : Options) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      Contains ("+"'Result, Left) and then Contains ("+"'Result, Right)
      and then ("+"'Result.Value xor (Left.Value or Right.Value)) = Flags_Type (0);

   function "-" (Left : Options; Right : Option) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      ("-"'Result.Value and Mask (Right)) = Flags_Type (0)
      and then
      (if Contains (Left, Right) then
         ("-"'Result.Value or Mask (Right)) = Left.Value
       else True);

   function "-" (Left, Right : Options) return Options with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      ("-"'Result.Value and Right.Value) = Flags_Type (0)
      and then
      (if (Left.Value and Right.Value) = Right.Value then
         ("-"'Result.Value or Right.Value) = Left.Value
       else True);

   function Contains (Left : Options; Right : Option) return Boolean with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  =>
      Contains'Result = ((Left.Value and Mask (Right)) = Mask (Right));

   function Contains (Left, Right : Options) return Boolean with
     Inline_Always, Global => null, Pre => Valid_Configuration,
     Post                  => Contains'Result = ((Left.Value and Right.Value) = Right.Value);

private

   pragma Assert
     (Flags_Type'Modulus = 2**Flags_Type'Size,
      "Flags_Type must have a binary modulus matching its size");
   pragma Assert
     (Option'Pos (Option'Last) < Flags_Type'Size,
      "Flags_Type must have at least one bit per option");

end Bitflags;
