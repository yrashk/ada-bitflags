with Bitflags;
private package Bitflags_SPARK_Extremes with
  SPARK_Mode
is

   type Option_1 is (Only);
   type Flags_1 is mod 2**1 with
     Size => 1;
   package Test_1 is new Bitflags (Flags_Type => Flags_1, Option_Type => Option_1);

   type Option_8 is (O8_0, O8_1, O8_2, O8_3, O8_4, O8_5, O8_6, O8_7);
   type Flags_8 is mod 2**8 with
     Size => 8;
   package Test_8 is new Bitflags (Flags_Type => Flags_8, Option_Type => Option_8);

   type Option_64 is
     (O64_00, O64_01, O64_02, O64_03, O64_04, O64_05, O64_06, O64_07,
      O64_08, O64_09, O64_10, O64_11, O64_12, O64_13, O64_14, O64_15,
      O64_16, O64_17, O64_18, O64_19, O64_20, O64_21, O64_22, O64_23,
      O64_24, O64_25, O64_26, O64_27, O64_28, O64_29, O64_30, O64_31,
      O64_32, O64_33, O64_34, O64_35, O64_36, O64_37, O64_38, O64_39,
      O64_40, O64_41, O64_42, O64_43, O64_44, O64_45, O64_46, O64_47,
      O64_48, O64_49, O64_50, O64_51, O64_52, O64_53, O64_54, O64_55,
      O64_56, O64_57, O64_58, O64_59, O64_60, O64_61, O64_62, O64_63);
   type Flags_64 is mod 2**64 with
     Size => 64;
   package Test_64 is new Bitflags (Flags_Type => Flags_64, Option_Type => Option_64);

end Bitflags_SPARK_Extremes;
