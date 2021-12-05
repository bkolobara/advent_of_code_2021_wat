(module
  (memory 1)

  (func (export "part_1") (result i32)
    (local $i i32)
    (local $j i32)
    (local $value i32)
    (local $gamma i32)

    ;; Start looping from position 64 in memory
    i32.const 64
    local.set $i
    (block $loop_break
      (loop $loop
        ;; increase $i by 2 (bytes)
        local.get $i
        i32.const 2
        i32.add
        local.tee $i
        ;; Load the memory location at $i
        i32.load16_u
        local.tee $value
        ;; Check if it's equal 0 (reached end of the input)
        i32.const 0
        i32.eq
        br_if $loop_break

        ;; Reset $j to 0
        i32.const 0
        local.set $j
        (block $loop_bits_break
          (loop $loop_bits
            ;; If bit $j is set inside of $value increment the counter
            i32.const 1
            local.get $j
            i32.shl
            local.get $value
            i32.and
            i32.const 0
            i32.ne
            (if (then
                  local.get $j
                  call $inc))
            ;; Increase $j by 1 and stop when 16 is reached
            local.get $j
            i32.const 1
            i32.add
            local.tee $j
            i32.const 16
            i32.eq
            br_if $loop_bits_break
            br $loop_bits))
        
        br $loop))

      ;; Reset $j to 0
      i32.const 0
      local.set $j
      (block $loop_bits_break
        (loop $loop_bits
          ;; If bit $j is set more times than the number
          ;; of iterations add it to $gamma.
          local.get $j
          call $count
          ;; Convert the value to a f32
          f32.convert_i32_u
          ;; ($i - 64 offset) / 4 bytes
          local.get $i
          i32.const 64
          i32.sub
          i32.const 2
          i32.div_u
          f32.convert_i32_u
          f32.div
          ;; If the division is greater than 0.5 set the bit
          f32.const 0.5
          f32.gt
          (if (then
                ;; Get a number with just the bit $j set
                i32.const 1
                local.get $j
                i32.shl
                local.get $gamma
                i32.add
                local.set $gamma))

          ;; Increase $j by 1 and stop when 16 is reached
          local.get $j
          i32.const 1
          i32.add
          local.tee $j
          i32.const 16
          i32.eq
          br_if $loop_bits_break
          br $loop_bits))
    ;; Calculate epsilon
    local.get $gamma
    i32.const 31 ;; 31 -> 11111
    i32.xor
    local.get $gamma
    i32.mul)
  
  ;; Load i32 value at position 4 * $bit in memory, add 1
  ;; to it and store the value back at the same position.
  (func $inc (param $bit i32)
    (local $location i32)
    
    local.get $bit
    i32.const 4
    i32.mul
    local.tee $location
    local.get $location
    i32.load
    i32.const 1
    i32.add
    i32.store)
  
  ;; Return i32 value at position 4 * $bit in memory.
  (func $count (param $bit i32) (result i32)
    local.get $bit
    i32.const 4
    i32.mul
    i32.load)
  
  (data (i32.const 64) "\04\00\1e\00\16\00\17\00\15\00\0f\00\07\00\1c\00\10\00\19\00\02\00\0a\00"))