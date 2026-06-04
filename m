Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D7747DF80
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580765; cv=none; b=ZRnEqYMfKfHxDMy/JJmW6hmSh62aeSpjzKcRg7Sw/Ln+N3eT2iiUbo79RxWi7BVFdmn59kMp9ET8H1nmifZSmwyiKv5I1I29uSoWqwzGzu3QfHmbiA9Cme9ROWdA7gT/o5DSqr74UNB0n99yiejtpkf0QULUUcAtieBmUdcPeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580765; c=relaxed/simple;
	bh=Qc7Clsh2hLAz5sETUpWrXxwkYbQmZlAQIV+VwPBmDVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTaKjdj8ZmpBetz5SHIacbrnWBP41747pzUQNF7Pvf6KCiEP5dRTb7K6t8i+VvXhZ4EBr0kTCEH8s4+sO1nxG3gqpR1ZoOokef6oWJfpA1NXwg03BVGJtal+G4zArQn+YLnTGjsEj931WcoIOaB50zUwJjYDVgGvvAuN58vXZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFiaPpJt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFiaPpJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183221F00893;
	Thu,  4 Jun 2026 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580764;
	bh=AOvcSE9HXRjCdhk1JjZrRO4/mCzdgrNoRBVtqXh7I/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OFiaPpJt5y26MLEr71r5IOR/aPR0KNGEUt/7eS4FHijeuynOEnvZCATuR2dIV8H/M
	 Owgyyv1QvCJTLjqbTagns1vgFEzrI8TOlvQ6lVomVZh6uCaODrnU2Ii7DuI51wyudg
	 +HworW3NZ5n0GOpyhr/lmvZK+4pZ2Nzv9Yc8gt6sj7v8d0rOiz5mWPzguEGUxYlxdY
	 Gfv4oOoNq/I/Imoo2QPYmgOLzMCjTOMqJek6bvonZAaubc4yMXfyBg/IAZbPOV8Ue/
	 ucWzW59N6+LJthBqDKSIzNHfqLM5if0QHyesAzJmbY3m6OKrb3K9t3xuSH/iFtmCB+
	 RnzjqShwfavOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] riscv: kexec: Add the relocate-trampoline
 wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604132418.15725-9-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-9-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:46:03 +0000
Message-Id: <20260604134604.183221F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `sfence.vma` after `csrw CSR_SATP, zero` allows unsynchron=
ized execution to use the old trampoline page table, causing page faults du=
ring kexec.
- [High] Incorrect physical address calculation for `riscv_kexec_cc_buffer_=
pa` using PC-relative `la` under `CONFIG_XIP_KERNEL`.
--

commit 6b76f586f13ebcc7aa4fa66a977acaa2bac3a894
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>
riscv: kexec: Add the relocate-trampoline wrapper

This patch adds the riscv_kexec_relocate_entry wrapper to the kexec
trampoline text section. It performs the transition to the trampoline PGD,
drops the MMU, and jumps to the physical address of the control code buffer.

> diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec=
_relocate.S
> index 8cfdf6f4032a8..6c624560c9ac0 100644
> --- a/arch/riscv/kernel/kexec_relocate.S
> +++ b/arch/riscv/kernel/kexec_relocate.S

[ ... ]

> @@ -225,6 +225,42 @@ SYM_CODE_START(riscv_kexec_norelocate)
> =20
>  SYM_CODE_END(riscv_kexec_norelocate)
> =20
> +.extern riscv_kexec_relocate_entry_pa
> +.extern riscv_kexec_cc_buffer_pa
> +.section ".kexec.tramp.text", "ax"
> +SYM_CODE_START(riscv_kexec_relocate_entry)

[ ... ]

> +1:
> +	/*
> +	 * Now executing at the PA of this wrapper with the trampoline pgd
> +	 * installed (identity-mapped). Drop the MMU; PC stays valid because
> +	 * it is already a PA.
> +	 */
> +	csrw	CSR_SATP, zero

[Severity: High]
Does dropping the MMU here require an sfence.vma instruction to synchronize
the pipeline?

Without it, the hardware might defer the translation mode switch and use the
old trampoline page table for subsequent instructions.

Since the trampoline page table only identity-maps the single trampoline
.text page, the immediate memory read from the unmapped .bss region could
trigger a Load Page Fault.

It looks like riscv_kexec_norelocate might have a similar issue where it
executes a jump to the crash kernel without an sfence.vma, which could cause
a nested Instruction Page Fault.

> +
> +	/* Jump to the PA of control_code_buffer to run the relocate body. */
> +	la	t0, riscv_kexec_cc_buffer_pa
> +	REG_L	t0, 0(t0)

[Severity: High]
Will this PC-relative physical address calculation work correctly under
CONFIG_XIP_KERNEL?

The la instruction expands to a PC-relative offset based strictly on virtual
addresses.

Under CONFIG_XIP_KERNEL, .text executes from ROM and .bss resides in RAM,
so their virtual offset does not match their physical distance.

When executed with the MMU off, adding this virtual offset to the physical
ROM PC might yield an invalid physical address, causing the REG_L
instruction to crash the kexec transition.

> +	jr	t0
> +SYM_CODE_END(riscv_kexec_relocate_entry)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132418.1572=
5-1-fangyu.yu@linux.alibaba.com?part=3D8
