with ada.containers.vectors;
package asm is

  private package instructions is
    type instruction is (jmp, mov);
  end instructions;

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

end asm;
