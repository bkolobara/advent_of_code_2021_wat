(module
  (memory 1)

  (func (export "part_1") (result i32)
    (local $i i32)

    (local $command i32)
    (local $value i32)
  
    (local $x i32)
    (local $y i32)
  
    (block $loop_break
      (loop $loop
        ;; Load value at the memory location $i into $command
        local.get $i
        ;; Load 8 bytes (unsigned) into an i32 stack slot
        i32.load8_u
        local.set $command
        ;; Load value at the memory location $i+1 into $value
        local.get $i
        i32.const 1
        i32.add
        i32.load8_u
        local.set $value
        
        ;; Compare $command to zero & break loop if true
        local.get $command
        i32.const 0
        i32.eq
        br_if $loop_break

        ;; Load the command onto the stack
        local.get $command
        ;; If it's the letter f (utf8 value 102) update $y
        i32.const 102
        i32.eq
        (if (then
          ;; Add value to $y
          local.get $y
          local.get $value
          i32.add
          local.set $y))

        ;; Load the command onto the stack
        local.get $command
        ;; If it's the letter d (utf8 value 100) update $x
        i32.const 100
        i32.eq
        (if (then
          ;; Add value to $x
          local.get $x
          local.get $value
          i32.add
          local.set $x))
        
        ;; Load the command onto the stack
        local.get $command
        ;; If it's the letter u (utf8 value 117) update $x
        i32.const 117
        i32.eq
        (if (then
          ;; Subtract value from $x
          local.get $x
          local.get $value
          i32.sub
          local.set $x))

        ;; Increment $i by 2
        local.get $i
        i32.const 2
        i32.add
        local.set $i
        br $loop))
      
      ;; Multiply $x by $y
      local.get $x
      local.get $y
      i32.mul)

  (func (export "part_2") (result i32)
    i32.const 0
  )

  (data (i32.const 0) "f\05d\05f\08u\03d\08f\02"))