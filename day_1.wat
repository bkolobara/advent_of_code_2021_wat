(module
  (memory 1)

  (func (export "part_1") (result i32)
    (local $i i32)
    (local $previous i32)
    (local $increases i32)

    ;; Load first value onto the stack
    i32.const 0
    i32.load
    ;; Save it inside the $previous local
    local.set $previous
    (block $loop_break
      (loop $loop
        ;; increase $i by 4 (bytes)
        local.get $i
        i32.const 4
        i32.add
        local.set $i
        ;; Load the memory location at $i
        local.get $i
        i32.load
        ;; Check if it's equal 0 (reached end of the input)
        i32.const 0
        i32.eq
        br_if $loop_break
        ;; Load again the memory location at $i
        local.get $i
        i32.load
        ;; Compare if it's bigger than the $previous value
        local.get $previous
        i32.gt_u ;; Greater than unsigned
        (if 
          (then
            ;; Increment $increases
            local.get $increases
            i32.const 1
            i32.add
            local.set $increases))
        ;; Load once again the memory location at $i and
        ;; save it under $previous for the next iteration
        local.get $i
        i32.load
        local.set $previous
        ;; Jump to beginning of the loop
        br $loop
      )
    )
    ;; Return the value inside the $increases local
    local.get $increases
  )

  (func (export "part_2") (result i32)
    (local $i i32)
    (local $previous i32)
    (local $current i32)
    (local $increases i32)

    ;; Load first value onto the stack
    i32.const 0
    i32.load
    ;; Load second value onto the stack
    i32.const 4
    i32.load
    ;; Load third value onto the stack
    i32.const 8
    i32.load
    ;; Add them together
    i32.add
    i32.add
    ;; Save it inside the $previous local
    local.set $previous
    (block $loop_break
      (loop $loop
        ;; increase $i by 4 (bytes)
        local.get $i
        i32.const 4
        i32.add
        local.set $i
        ;; Add values at $i, $i+4 & $i+8 together
        ;; and save them inside of current
        local.get $i
        i32.load
        ;; $i+4
        local.get $i
        i32.const 4
        i32.add
        i32.load
        ;; $i+8
        local.get $i
        i32.const 8
        i32.add
        i32.load

        i32.add
        i32.add
        local.set $current

        ;; Check if $i+8 is equal to 0 (reached end of the input)
        local.get $i
        i32.const 8
        i32.add
        i32.load
        i32.const 0
        i32.eq
        br_if $loop_break
        local.get $current
        ;; Compare if it's bigger than the $previous sum
        local.get $previous
        i32.gt_u ;; Greater than unsigned
        (if 
          (then
            ;; Increment $increases
            local.get $increases
            i32.const 1
            i32.add
            local.set $increases))
        local.get $current
        local.set $previous
        ;; Jump to beginning of the loop
        br $loop
      )
    )
    ;; Return the value inside the $increases local
    local.get $increases
  )

  (data (i32.const 0) "\c7\00\00\00\c8\00\00\00\d0\00\00\00\d2\00\00\00\c8\00\00\00\cf\00\00\00\f0\00\00\00\0d\01\00\00\04\01\00\00\07\01\00\00"))