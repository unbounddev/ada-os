with ada.containers.vectors;
with interfaces;
with ada.strings.unbounded;
package asm is
  
  -- NOTE: label characters a-zA-Z0-9_$#@~.?
  -- legal first characters: a-zA-Z_?. (period has special meaning of local label)
  -- local labels are associated with closest non-local label

  private package instructions is
    type instruction is (jmp, mov);
  end instructions;

  private package registers is
    type register is (ax, bx, cx, dx, sp, bp, si, di, ah, al, bh, bl, ch, cl, dh, dl);
    subtype register_8_bit is register range ah .. dl;
  end registers;

  -- NOTE: Refactor as a record/interface with abstract methods
  type instruction is tagged record
    name: instructions.instruction;
  end record;

  package instruction_vectors is new
    ada.containers.vectors
      (index_type => positive,
       element_type => instruction);

  type program is tagged record
    instructions: instruction_vectors.vector;
  end record;
  
  procedure mov(self: program, register: registers.register_8_bit, immediate: interfaces.unsigned_8);
  -- NOTE: Use interfaces.unsigned_8'mod() for conversion of interfaces.integer_8
  procedure mov(self: program, register: registers.register_8_bit, immediate: interfaces.integer_8);

  procedure label(self: program, name: ada.strings.unbounded.unbounded_string);

end asm;
