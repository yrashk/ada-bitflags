with Bitflags;
private package Bitflags_SPARK_Test with
  SPARK_Mode
is

   type Option is (Test, This) with
     Size => 8;
   for Option use (Test => 2#01#, This => 2#10#);

   type Flags_Type is mod 2**8 with
     Size => 8;

   package Test_Flag is new Bitflags (Flags_Type => Flags_Type, Option_Type => Option);
end Bitflags_SPARK_Test;
