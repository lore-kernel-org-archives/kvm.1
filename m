Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ACA40B6C9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887567; cv=none; b=rnYZILz4yPMKG7jeFeSGUBeziwYU04nlii88F/KhTZAJTQ5MNyc64pvxLT0A7SffgRbwCX22w4m39XsoXf5VUmHfRF70Xy2OkddNbBVMFSmvmRUlHFSnYw9cI8u6bC7HAieIS3d2Uvb48SSIfGO6n7nSdH8lPkuk1EJjcQvzvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887567; c=relaxed/simple;
	bh=J12+4nWL9PrSiCy16maSKHEjC+A702WBJSkXdwpkRuQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKZvFnpypfNKEML6I50hv/kVD7qPRxy92s28jSIw7wUdVEktY4LMPu076knflKY3Iie1c7383qPfGKLOMmS8AtzHjt6RIi0g6dEf+1mIejDGu1H/kIne03HDTDQWv4ErLkW6isJ+PHAdrDCAWpVHseTTxDzEDxtVLZY/OsNvkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa5vdnum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa5vdnum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9DA1F000E9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779887565;
	bh=7BfQon8HZ7N8lseN94AL4q+87dy7CvB2+OnlojEqRtM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Wa5vdnum2rdWidT+nZQu1TyJpvYIGOKKuC/QoJrLWoSvT1WgMOUkGf0MOVzLRO268
	 SfzwSgNH4RvM/4t3qj79vqVqBf3uWZBj8Uwdd/m+MIJzYLQDSfewEg+LamhjTWO06w
	 GzioBsaOdEa/nlkQR5hCkuKZ8DDIEAJdPyphccZ+a3SSHJ6GDCJCSHRqUZFPjNIBbK
	 NxvZGXBgwhiCI9+TBNiU9tP7Se4UY0Bil8vZmm6CeqqBVFgwWYff065SkhA04QD5RG
	 hEP5Izf8rdJJDwX2+2BJnACH9aTmCCWQwzSoH4vcLr1YMNQit1ujTqyxgmk6sTxlr1
	 b3DJgm6Mn7ZKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527120544.2903923-3-kas@kernel.org>
References: <20260527120544.2903923-3-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 13:12:43 +0000
Message-Id: <20260527131245.CD9DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] In `handle_mmio()`, the `val` variable is not fully initialize=
d before being sent to the VMM during a memory-mapped I/O write emulation, =
leading to a kernel stack memory leak.
- [High] The CPUID instruction emulation in `handle_cpuid()` fails to zero-=
extend the 32-bit results into their respective 64-bit registers.
- [High] The MMIO emulation for MOVZX and MOVSX instructions in `handle_mmi=
o()` fails to clear the upper 32 bits when the destination is a 32-bit regi=
ster.
- [High] In `write_msr()`, `regs->ax` is not masked to 32 bits before being=
 ORed to form the MSR value, which can corrupt the upper 32 bits (represent=
ing EDX) sent to the VMM.
--

commit f91083b7c0a39ded55e57262547e0ea4e29968a4
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/tdx: Fix zero-extension for 32-bit port I/O

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. Update handle_in() to zero out the entire RAX register
when the I/O size is 4 bytes to ensure correct zero-extension.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 65119362f9a25..58feca4193269 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c

[ ... ]

> static int write_msr(struct pt_regs *regs, struct ve_info *ve)
> {
> 	struct tdx_module_args args =3D {
> 		.r10 =3D TDX_HYPERCALL_STANDARD,
> 		.r11 =3D hcall_func(EXIT_REASON_MSR_WRITE),
> 		.r12 =3D regs->cx,
> 		.r13 =3D (u64)regs->dx << 32 | regs->ax,
        ^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does this correctly build the
MSR value?

Since regs->ax is a 64-bit value, it looks like any non-zero bits in the
upper 32 bits of regs->ax will not be cleared.

Will these upper bits then be logically ORed into the upper 32 bits of the
result, corrupting the EDX portion of the WRMSR value sent to the VMM?

Could a guest program with legitimately non-zero data in the upper 32 bits =
of
RAX prior to the #VE inadvertently write wrong values to MSRs?

[ ... ]

> static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
> {
> 	struct tdx_module_args args =3D {
> 		.r10 =3D TDX_HYPERCALL_STANDARD,
> 		.r11 =3D hcall_func(EXIT_REASON_CPUID),
> 		.r12 =3D regs->ax,
> 		.r13 =3D regs->cx,
> 	};

[ ... ]

> 	/*
> 	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
> 	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
> 	 * So copy the register contents back to pt_regs.
> 	 */
> 	regs->ax =3D args.r12;
> 	regs->bx =3D args.r13;
> 	regs->cx =3D args.r14;
> 	regs->dx =3D args.r15;
        ^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does this correctly handle zero-extension
for 32-bit results into 64-bit registers?

According to x86-64 architecture rules, writes to 32-bit registers must cle=
ar
the upper 32 bits of the corresponding 64-bit registers.

Because the values are copied directly from the untrusted VMM (args.r12 to
args.r15) into the registers without masking to 32 bits, could a malicious
VMM inject non-zero values into the upper 32 bits?

Can this corrupt guest user-space or kernel state if the code relies on the=
se
bits being zeroed?

[ ... ]

> static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> {
> 	unsigned long *reg, val, vaddr;
                            ^^^

[Severity: Critical]
This is a pre-existing issue, but is val fully initialized before being sent
to the VMM?

When handling an MMIO write of size smaller than 8 bytes, does memcpy only
write to the lowest size bytes, leaving the upper bytes of val uninitialized
with kernel stack data?

[ ... ]

> 	/* Handle writes first */
> 	switch (mmio) {
> 	case INSN_MMIO_WRITE:
> 		memcpy(&val, reg, size);
> 		if (!mmio_write(size, ve->gpa, val))

Because this 8-byte variable is passed to mmio_write() and forwarded to the
untrusted VMM, does this leak uninitialized kernel stack memory to the guest
hypervisor?

[ ... ]

> 	switch (mmio) {
> 	case INSN_MMIO_READ:
> 		/* Zero-extend for 32-bit operation */
> 		extend_size =3D size =3D=3D 4 ? sizeof(*reg) : 0;
> 		break;
> 	case INSN_MMIO_READ_ZERO_EXTEND:
> 		/* Zero extend based on operand size */
> 		extend_size =3D insn.opnd_bytes;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but does this properly clear the
upper 32 bits when the destination is a 32-bit register?

For MOVZX and MOVSX instructions, extend_size is set to insn.opnd_bytes.
When the destination is a 32-bit register, insn.opnd_bytes is 4.

Does memset then only clear or set 4 bytes of the 64-bit register?

Because x86-64 architecture dictates that writing to a 32-bit register alwa=
ys
zero-extends to the full 64-bit register, could compiler-generated code
relying on this zero-extension use garbage values left over in the upper
half, leading to functional regressions or out-of-bounds memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527120544.2903=
923-1-kas@kernel.org?part=3D2
