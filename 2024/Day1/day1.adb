pragma Ada_2022;

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Day1 is
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   package Natural_Vectors_Sorting is new Natural_Vectors.Generic_Sorting;
   use Natural_Vectors;
   use Natural_Vectors_Sorting;

   procedure Skip_Whitespace is
      C        : Character;
      Line_End : Boolean;
   begin
      Look_Ahead (C, Line_End);
      if Line_End then
         Skip_Line;
      elsif C = ' ' then
         Get (C);
         Skip_Whitespace;
      end if;
   end Skip_Whitespace;

   Left, Right      : Vector;
   Buffer           : Unbounded_String;
   C                : Character;
   Distance_Sum     : Natural := 0;
   Similarity_Score : Natural := 0;
begin
   while not End_Of_File loop
      loop
         Get (C);
         exit when C = ' ';
         Append (Buffer, C);
         exit when End_Of_Line;
      end loop;

      -- when end of line -> right number, else left number
      if End_Of_Line then
         Right.Append (Natural'Value (To_String (Buffer)));
      else
         Left.Append (Natural'Value (To_String (Buffer)));
      end if;

      Delete (Buffer, 1, Length (Buffer));
      Skip_Whitespace;
   end loop;

   Sort (Left);
   Sort (Right);

   for I in Left.First_Index .. Left.Last_Index loop
      -- a)
      Distance_Sum := @ + abs (Left (I) - Right (I));

      -- b)
      declare
         Cur : Cursor := No_Element;
      begin
         loop
            Cur := Find (Right, Left (I), Next (Cur));
            exit when Cur = No_Element;
            Similarity_Score := @ + Left (I);
         end loop;
      end;
   end loop;

   Put_Line ("a) total distance: " & Distance_Sum'Image);
   Put_Line ("b) similarity score: " & Similarity_Score'Image);
end Day1;
