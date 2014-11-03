set history save
set history filename ~/.gdb_history
set disassembly-flavor intel
set disassemble-next-line auto
set print demangle on
set print asm-demangle off
set print pretty on
set print array on
set print symbol-filename on

#catch syscall ptrace

define hook-quit
	set confirm off
end


define nip
	ni
	x /10i $rip
end
