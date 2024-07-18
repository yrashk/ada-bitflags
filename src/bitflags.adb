package body Bitflags is

   function Empty return Options is (Options (Flags_Type (0)));

   function Complete return Options is
      Result : Options := Empty;
   begin
      for Opt in Option'Range loop
         Result := Result + Opt;
      end loop;
      return Result;
   end Complete;

   function "+" (Left, Right : Option) return Options is
     (Options (Flags_Type (Option'Enum_Rep (Left)) or Flags_Type (Option'Enum_Rep (Right))));

   function "+" (Left : Options; Right : Option) return Options is
     (Options (Flags_Type (Left) or Flags_Type (Option'Enum_Rep (Right))));

   function "+" (Left : Option; Right : Options) return Options is
     (Options (Flags_Type (Right) or Flags_Type (Option'Enum_Rep (Left))));

   function "+" (Left, Right : Options) return Options is
     (Options (Flags_Type (Right) or Flags_Type (Left)));

   function "-" (Left : Options; Right : Option) return Options is
     (Options (Flags_Type (Left) and (not Flags_Type (Option'Enum_Rep (Right)))));

   function "-" (Left : Options; Right : Options) return Options is
     (Options (Flags_Type (Left) and (not Flags_Type (Right))));

   function Contains (Left : Options; Right : Option) return Boolean is
     ((Flags_Type (Left) and Flags_Type (Option'Enum_Rep (Right))) =
      Flags_Type (Option'Enum_Rep (Right)));

end Bitflags;
