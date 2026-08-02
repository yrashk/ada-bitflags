package body Bitflags is

   function Empty return Options is ((Value => Flags_Type (0)));

   function Complete return Options is
      Result : Options := Empty;
   begin
      for Opt in Option loop
         Result := Result + Opt;
      end loop;
      return Result;
   end Complete;

   function "+" (Left, Right : Option) return Options is
     (Value => Mask (Left) or Mask (Right));

   function "+" (Left : Options; Right : Option) return Options is
     (Value => (Left.Value or Mask (Right)));

   function "+" (Left : Option; Right : Options) return Options is
     (Value => (Right.Value or Mask (Left)));

   function "+" (Left, Right : Options) return Options is (Value => (Right.Value or Left.Value));

   function "-" (Left : Options; Right : Option) return Options is
     (Value => (Left.Value and (not Mask (Right))));

   function "-" (Left, Right : Options) return Options is
     (Value => (Left.Value and (not Right.Value)));

   function Contains (Left : Options; Right : Option) return Boolean is
     ((Left.Value and Mask (Right)) = Mask (Right));

   function Contains (Left, Right : Options) return Boolean is
     (((Left.Value and Right.Value)) = Right.Value);

end Bitflags;
