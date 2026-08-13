Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C62468C33
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614371; cv=none; b=SpHXZaRa0RR7XcOwGA/Wq7WRYe638/VWOU8LEqE9ZeiUJjTzm5ZrKJ46GsDZVVKFGL9nK/SrmDbKkLuZDNurMlKWiL/g68mm5pkw3q+zkOjUJ/NfZ9bAvw2Mt/EEZSGrc1jChdQIjZkeHWib2ZPWC5rTFdLeu/pTyJbOPthcwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614371; c=relaxed/simple;
	bh=Js1yuJKDINGmwIpIKn7lqOlrDFzN78nEZYrZy8WFYIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nqDqM8WIh6ZvYbsbEBM2xtrZNf37SftsqnhCT+fxMsjo2BMz5yVZNTiAzF1EaEyW1tiMuDZ04a2cxpfEHW5CXx/EI5XwwRf4K/tA6U1ExJbM2YAFa2CNQ3zXO1clA1CQhhm4svsTOveh1C+/Lpp09wIEtYe1lwuB62rEq81NKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWWkiYTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWWkiYTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73C51F000E9;
	Thu, 13 Aug 2026 09:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614369;
	bh=2WnQQF/+fx7nsd4NJf3q3zAt6XH7bQoejdCb6s1DRjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWWkiYTFPS/sCubFg/aZgaSbtS0jn/U8ouizDv+LBexyYcJ4r2IjUWWRVDyOs/pVE
	 ulUS06UAOPBiJhJzRvgP8t4E+aKyoqVJhzYdwBIZ2T8M9+bC49eszvMx9E8aAnQNgr
	 1UQcPMCF95NBTiM60QSz+1oVDviNt056kYy1sQcJjlwKFzOaj3HHrmT49qmthVLXh9
	 pXYmNmdVhZ6hPDtZGCldEEq8MucgUeEKkuYQu+CILRILYTnjlRyiwHLKmB1Yo6oVJO
	 yxUnMykLA/EIDUZD+Gcvbq4oaf/HC5jJyKRz+4qErdGMkEwNejgsXQDsSRtuh2Dyyl
	 q3X/TSma9Mdkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <EF5308EB97ADC8DE+20260813093751.3817371-1-jinrui@haiwei.tech>
References: <733FC2542EECADE1+20260813090306.3756434-1-jinrui@haiwei.tech>
 <EF5308EB97ADC8DE+20260813093751.3817371-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:46:09 +0000
Message-Id: <20260813094609.B73C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Directly reading a 32-bit instruction from `regs->epc` can trigg=
er an unhandled Misaligned Load or Load Page Fault exception in the guest.
--

--- Patch [1]: [PATCH v11] KVM: selftests: riscv: Add lazy V extension enab=
lement for guests ---
commit 53e28f775e49a3c6cc2ff1526d5a5089a4c1c737
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit adds lazy enablement of the V (vector) extension in KVM RISC-V
guest selftests to handle compiler auto-vectorization. It updates the
exception routing to decode faulting instructions and enable the V extension
if a vector instruction is executed while VS is off.

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c

[ ... ]

> @@ -432,6 +472,27 @@ void route_exception(struct pt_regs *regs)
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
> +		/* stval is not guaranteed to hold the faulting instruction */
> +		if (!insn)
> +			insn =3D *(u32 *)regs->epc;

[Severity: Medium]
Can reading a full 32-bit value directly from regs->epc trigger an unhandled
misaligned load or load page fault in the guest?

If the faulting instruction is a compressed 16-bit instruction at a 2-byte
aligned address, this 32-bit read will be unaligned and might trap on
hardware that does not support unaligned accesses.

Additionally, if the 16-bit instruction sits exactly at the end of a mapped
page and the next page is unmapped, reading 32 bits could trigger a page
fault instead of correctly handling the illegal instruction exception.

> +
> +		if (insn_is_vector(insn)) {
> +			regs->status |=3D SR_VS_INITIAL;
> +			return;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/EF5308EB97ADC8DE+20=
260813093751.3817371-1-jinrui@haiwei.tech?part=3D1
