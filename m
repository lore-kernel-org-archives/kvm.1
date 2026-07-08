Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87A4315F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482733; cv=none; b=o4UvMHxFUf+4Ngdc/AKVjtB/5DEG1hlSWewBH9XF+mekJKiQk9/qQaFXFGrCTbJxg+YJidmJtiuGBQi+Gxb9HH8xgHBT68jpV4vMxuuah0nrqHlnszCCMb8cDi8pykopHGpMiYtwrb8ldTRKAFv6dJVRZD6PG0vMZqcQnBV2w9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482733; c=relaxed/simple;
	bh=CeAtY3yjkmmgRTJhl8T/3eilxu9881Oa361z9xv/wOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q55nCTqenyqbG7SWfSBte8driS+yXVZMoFqagIREsDyDoMMT+RO8kxlyK8A+A4DqtMzWUkFcrN3y1VYzKQdiW4YDVpFLb36qW/lyNICc++dpQ96s167aw2+gV7ANXu4mAnf/1vQ244XRBFlhaeyznX1IBVStFzLPHSyoAXdrMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erxEJa9r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erxEJa9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFF41F000E9;
	Wed,  8 Jul 2026 03:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482731;
	bh=bKom2Y25QLPGiVXX/hmFZX62S/kXKwiLenHSNFcQvkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erxEJa9rUIYef7gnApfyLzuzyiMkXcyK0WhB6qo/XSPSk8CTnygEGsH8FhaKCrDS5
	 JGsOAPiBeEo31SPfPo3PSowci9S66940pR58ZrhxRVWiW9A2gtlk3DfcN0oiM8zykL
	 WycN8AJI/ZBaBeh8yT+ydS3ObeAyef9Qihj7Z2V+0wpUR4XqPOM0pkb3Zt0LpzMipU
	 82Hc3IU5mzIB0P5pxncPXJPHkSMYQutBLc9cykVzLzsNJa/Yqb4Ax7FHJCpr39xU2t
	 sJvVZ/TD2WYE00UIG3SPLx66Jz1ikCAnKyAYhFnJ6jgvk/b8qyEMC66TEhWqrItnFp
	 B3LCquQuvlBzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/17] riscv: kprobes: Use generated instruction
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-5-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-5-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:52:10 +0000
Message-Id: <20260708035211.3FFF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Simulation of C.JR and C.JALR instructions fails to clear the leas=
t-significant bit (LSB) of the target address.
--

--- Patch [5]: [PATCH v3 05/17] riscv: kprobes: Use generated instruction h=
eaders ---
commit afd6227eeae883036e027b0893e434a89b21ebab
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: kprobes: Use generated instruction headers

Migrate the code that is decoding instruction for the use of kprobes to
use the generated instruction headers instead of the hand-written
instruction functions. With the more granular instruction support, split
the decoding of branches into their own functions.

> diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel=
/probes/simulate-insn.c
> index fa581590c1f8b..a443883c32370 100644
> --- a/arch/riscv/kernel/probes/simulate-insn.c
> +++ b/arch/riscv/kernel/probes/simulate-insn.c
> @@ -4,222 +4,152 @@
[ ... ]
>  bool __kprobes simulate_c_jr(u32 opcode, unsigned long addr, struct pt_r=
egs *regs)
>  {
> -	return simulate_c_jr_jalr(opcode, addr, regs, false);
> +	unsigned long next_addr;
> +	unsigned long *regs_ptr =3D (unsigned long *)regs;
> +
> +	/* xs1 =3D=3D 0 is invalid so riscv_insn_reg_get_val() isn't needed */
> +	next_addr =3D regs_ptr[riscv_insn_c_jr_extract_xs1(opcode)];
> +	instruction_pointer_set(regs, next_addr);

[Severity: High]
This is a pre-existing issue, but does this code need to clear the least
significant bit (LSB) of next_addr before updating the instruction pointer?

If a C.JR instruction executes where the source register contains an odd
address, applying it directly without masking (e.g., using & ~1) can trigger
a misaligned instruction pointer exception (a kernel Oops or userspace SIGB=
US)
upon returning from the probe.

This could allow unprivileged userspace to trigger a process crash via upro=
bes,
breaking ABI functional correctness.

It also appears the KUnit test suite explicitly asserts this behavior in
test_kprobe_simulate_riscv(), where it expects the unmasked address rather =
than
the properly aligned address.

> +
> +	return true;
>  }
> =20
>  bool __kprobes simulate_c_jalr(u32 opcode, unsigned long addr, struct pt=
_regs *regs)
>  {
> -	return simulate_c_jr_jalr(opcode, addr, regs, true);
> +	unsigned long next_addr;
> +	unsigned long *regs_ptr =3D (unsigned long *)regs;
> +
> +	/* xs1 =3D=3D 0 is invalid so riscv_insn_reg_get_val() isn't needed */
> +	next_addr =3D regs_ptr[riscv_insn_c_jalr_extract_xs1(opcode)];
> +	instruction_pointer_set(regs, next_addr);

[Severity: High]
This is a pre-existing issue, but similar to C.JR, does this target address
also need to be masked before updating the instruction pointer?

> +
> +	regs->ra =3D addr + 2;
> +	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D5
