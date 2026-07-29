Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84743B3FF
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312209; cv=none; b=dOqTMPNvqgBYQ75+yc5dKacpCqEh4DkSAUEnYDycnC2UXDnEWs5FLP4osfyGoy6lkdLkXBOgrIKnp/u3SymZHa6+N7n3B+pTLiklUZrGtiF5kxH1NfuiA0m8YgnCjDTSd4ayYKlgCQk7hW5ZVXDmorIUMEHcjn0EvXne8aQ3WFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312209; c=relaxed/simple;
	bh=sxLz5U1xWlpSetbqv/h/BV4rfKMUZoPBLqDkDZldFpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJZgoffs5chuNPx1tHcoJkZ4tXjO9fJLYMbE5AFaDt3bEuGhSOR79ppy2z8MM0LdCeGq5KxkbdYXxFRrmzDrd+XVOVe1J5U27JQNR41vFrwfLTFcFi9EYEsH/uRne9OG9FNYN2OAt+inCTQnFeXT+MFujakmfHVLazmkKzEGu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCbnrLi/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCbnrLi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4401F00A3A;
	Wed, 29 Jul 2026 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785312207;
	bh=R2tke5l7lA3JFCxWp2jmg8vC7DAsgT6ii5UdoL8jd/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCbnrLi/xVJDGlcAY4vmVoEONIsd6Sk7tI6H3reAZZz9PYuoIj9Cn0bncHY4PIpI1
	 zV9JtySbBY890cS5JRLqb7nC/XmGJjRtr6f3byi6OztC0IvcCoTpXNPTpGFt0C/fnF
	 BU2XVcsfVxV52ITRnvTZ3663skQqMv/yBTYfVEIZ7cIQ545I2LzoOfGeXFI73l+nSn
	 akJJr10NSVX3lcalRzncXfA2P6MoOeq+1QKDr5X8yDzVDNI4n3BZyxUlV7rwILRnxw
	 ZQBHiGMEckbr97zZVXK1+25WWy43PKyBBslavApcqKCQ7mYE70MFRN2Xxdwdwm1uJF
	 6+ACCDfVW5y5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] RISC-V: KVM: Fix spurious -EEXIST and clean up
 gstage fault path types
Reply-To: sashiko-reviews@lists.linux.dev
To: Bingyu.Xian <shanbeeyoo@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729075230.743030-1-shanbeeyoo@gmail.com>
References: <20260729070749.730218-1-shanbeeyoo@gmail.com>
 <20260729075230.743030-1-shanbeeyoo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:03:26 +0000
Message-Id: <20260729080326.CF4401F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The widened 34-bit `fault_addr` on RV32 is silently truncated back=
 to 32 bits when passed to MMIO load/store handlers.
--

--- Patch [1]: [PATCH v2] RISC-V: KVM: Fix spurious -EEXIST and clean up gs=
tage fault path types ---
commit 0f1ae40b2c79a54468668b54d25a4ee2ead28522
Author: Bingyu.Xian <shanbeeyoo@gmail.com>

RISC-V: KVM: Fix spurious -EEXIST and clean up gstage fault path types

This commit treats -EEXIST from kvm_riscv_gstage_map_page() as a quiet
success, aligning RISC-V with x86 and arm64. It also widens fault_addr to
gpa_t to prevent 34-bit guest physical addresses from being truncated by
32-bit arithmetic on RV32.

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6c8530b9f29ed..28cf9b27bb07c 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -17,12 +17,13 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, s=
truct kvm_run *run,
>  {
>  	struct kvm_gstage_mapping host_map;
>  	struct kvm_memory_slot *memslot;
> -	unsigned long hva, fault_addr;
> +	unsigned long hva;
> +	gpa_t fault_addr;
>  	bool writable;
>  	gfn_t gfn;
>  	int ret;
> =20
> -	fault_addr =3D (trap->htval << 2) | (trap->stval & 0x3);
> +	fault_addr =3D ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);

[Severity: High]
This is a pre-existing issue, but since the patch explicitly widens
fault_addr to gpa_t to hold 34-bit addresses on RV32, will this address
be truncated back to 32 bits when passed to the MMIO handlers later in
this function?

Looking at arch/riscv/kvm/vcpu_insn.c, the handlers still expect an
unsigned long:

int kvm_riscv_vcpu_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run,
                             unsigned long fault_addr,
                             unsigned long htinst)

and

int kvm_riscv_vcpu_mmio_store(struct kvm_vcpu *vcpu, struct kvm_run *run,
                              unsigned long fault_addr,
                              unsigned long htinst)

Does this mean MMIO accesses to addresses above 4GB on RV32 will still be
silently aliased into the lower 4GB when gstage_page_fault() calls these
handlers?

>  	gfn =3D fault_addr >> PAGE_SHIFT;
>  	memslot =3D gfn_to_memslot(vcpu->kvm, gfn);
>  	hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729075230.7430=
30-1-shanbeeyoo@gmail.com?part=3D1
