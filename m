Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92243E9C9
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615478; cv=none; b=Cjy+BSB96eBVRD/nJy4Y7EtPJNPX6hTwAMepKZU4HoKXli+5dQUK+Uu5l+xsPaUgd/G/q9w1n7EI5xmtm/5VV2txiFLTGPx/APNMat8hyp3bP+cJD8M9LJcccvhjkzg9us04Gawz25YPufwRvsKSAfnvdsK7KkKd7D1KX1x2jn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615478; c=relaxed/simple;
	bh=FHfXOKbw4G7S1g6+dPTTIBaor8EqrIYAVdDpP3oy83I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSQ01g1D3PrDqYvuCZT8Qn5/gaFbC6k+6jgcylw6uGJG0ftKUFB+cFL1i+1ex9wqTrhenK7iRXeJ4SRJdkJpkhYUi3a7gf2fa9mUgJZfSzM247hwdLO9/NJOV2/hlsWXhZiJnCW2Y5mHsLzmunVFSPAx+dz3cQcY5B2uCAiCZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ8I5/au; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ8I5/au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E621F000E9;
	Thu, 13 Aug 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615477;
	bh=5SfqBhJto6CJlrshI0jZA2jF/upBj/8MRut/kRltKOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gJ8I5/au0XABsADj2eIPWRkKijdfZC4bGVsIEhADgdFMM6mt/gL6kFxmW1IJM1DM2
	 olvYLLkBW0GME7uuO1O7VBI3PQ7Ix3ZHoEmjhHhLrp+PyBWaNInQ3KAklD0hzUw3VW
	 g1TQv7/We7jroRqNlqJlxXUOEQ/MU+M3OA12w6SLaq2w4iKPIhJndCjUBJbyxrbQ9t
	 hKhBJ9+a2WnZUYTTGfkALWr6q723gYXGer3KF4wOWtBVWvUdcre71GlbpOwRynKB/m
	 XJ6ant6wfWi6FBArpPRqTDTOpFrLot5Q+Ku3blpnxeRPqKZ7TOKJYhbx4G6iRIgOPC
	 ESF+bLO3a4MCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <7C0512E558D1614D+20260813095615.3843757-1-jinrui@haiwei.tech>
References: <EF5308EB97ADC8DE+20260813093751.3817371-1-jinrui@haiwei.tech>
 <7C0512E558D1614D+20260813095615.3843757-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:04:36 +0000
Message-Id: <20260813100437.06E621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unaligned 32-bit memory access when decoding 32-bit instructions
--

--- Patch [1]: [PATCH v12] KVM: selftests: riscv: Add lazy V extension enab=
lement for guests ---
commit cffe485ad3478e658853f5e74fe97f4c03d20bf6
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit introduces lazy enablement of the RISC-V vector (V) extension
for guest tests. It updates the exception routing to decode faulting
instructions and re-execute vector instructions when the VS status is off.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..e677137d5e448 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -432,6 +472,37 @@ void route_exception(struct pt_regs *regs)
>  		ec =3D 0;
>  	}
> =20
> +	/*
> +	 * Lazily enable V on the first vector instruction: if the faulting
> +	 * instruction decodes as vector while VS is off, set VS to Initial
> +	 * and re-execute it, like the kernel's riscv_v_first_use_handler().
> +	 * Genuinely illegal instructions continue to the unexpected-exception
> +	 * path.
> +	 */
> +	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec =3D=3D EXC_INST_ILLEGAL &&
> +	    handlers && handlers->v_available && !(regs->status & SR_VS)) {
> +		u32 insn =3D (u32)regs->badaddr;
> +
> +		/*
> +		 * stval is not guaranteed to hold the faulting instruction.
> +		 * Vector instructions are always 32-bit, so read a 16-bit
> +		 * halfword first and only load the full 32-bit instruction when
> +		 * it is not compressed; this avoids an unaligned or cross-page
> +		 * access on a compressed instruction.
> +		 */
> +		if (!insn) {
> +			u16 half =3D *(u16 *)regs->epc;
> +
> +			if ((half & 0x3) =3D=3D 0x3)
> +				insn =3D *(u32 *)regs->epc;

[Severity: Medium]
Will this result in an unaligned 32-bit memory access on certain hardware?

If a 32-bit vector instruction is placed at a 2-byte aligned address (which
is valid when the RISC-V 'C' compressed extension is enabled), regs->epc
will only be 2-byte aligned.

Casting a potentially 2-byte aligned address to a u32 pointer is undefined
behavior in C, and the compiler typically emits a standard 32-bit word load
instruction.

On strict-alignment RISC-V hardware, won't this trap and crash the selftest
guest with a 'Load Address Misaligned' exception?

> +		}
> +
> +		if (insn_is_vector(insn)) {
> +			regs->status |=3D SR_VS_INITIAL;
> +			return;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7C0512E558D1614D+20=
260813095615.3843757-1-jinrui@haiwei.tech?part=3D1
