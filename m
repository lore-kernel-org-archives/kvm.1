Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E353F7A9F
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855681; cv=none; b=Py1h4atAxiS9WoWpRLTllps/knNSnZYEAaZXpICseWRA+BY9X+PArmPp0IOOje9LUtc0pe9uPk9y1CGGAli5kAAVqIcA4cXqwUxcXIKFdeKBv16Lqf/wpDB9vEagYSUtUSjQfZMKl9DdEw2dKY3Kp0vgWQjeiKB+EAupeZ7DG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855681; c=relaxed/simple;
	bh=i4kh6i2BZaYouLE4tK2A8P3iVu2aviVW1LmNw6U5Xe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kbCoXYoVcQK+iry4Jq/BxFKgSazlECeRP/fRywP9mllf/OxQHnwHUWZfW3qTvuUG/h0vBx97B51DFJ9PxiSOc1GU3QpjG19psyC+x1gk0w/hM2Y3rvDFXU2A6ykNnFVunUyTHKTeMFXP3LiBqiMjsI9q0NhgnHAoS0XFcvYF47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEoR4R76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEoR4R76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C8B1F00ACA;
	Tue,  8 Sep 2026 08:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788855679;
	bh=FhBMNFzK5znGtaAWkoePm2AullCEolq7jwr4mJd2QVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEoR4R76GGVGpBQE+Zl6Rtk7DtdOtwn06DC0nrbrB6+dHkmW2tHVmj3+mqEynK3gl
	 4IymnpCK1ixE05LcSgLitlDurYSDD4G6Q7HwA+PDrkTiki1P86+MPh86VlroUw/IXZ
	 fWkbBnt1TrJwlDt5EJr70e9Vt1PtLpZ4sXhrhVAMfFMwieWNQA4VScaoQ4YkN2UvKI
	 OXU00Chbiz1zA6cqBEsFszd4sPYwuPnsH2sHjksrO2gqQqAri/8jdusd1BTTYnB0Qe
	 Sx5rMjdZHu7TlI8ao6XW4/I/OgK8tQzXVf/3Sjurp7m/SqP9T/lV2o5NVhAsPOh/OU
	 B+sdrUxVM/dfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] KVM: x86: Add support for cmpxchg16b emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260908074739.10748-3-sarunkod@amd.com>
References: <20260908074739.10748-1-sarunkod@amd.com>
 <20260908074739.10748-3-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 08:21:18 +0000
Message-Id: <20260908082118.F1C8B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing guest CPUID check for X86_FEATURE_CX16 allows guest to i=
nvoke CMPXCHG16B emulation regardless of guest capabilities.
--

commit 17ba312dad40f9de38e63207a6f7c861db26c57a
Author: Sairaj Kodilkar <sarunkod@amd.com>
Subject: KVM: x86: Add support for cmpxchg16b emulation

This commit extends cmpxchg8b emulation in KVM to support the cmpxchg16b
instruction when the destination memory is 128-bit and REX.W is set. This
addresses an emulation failure where guests, such as the AMD IOMMU driver,
use 128-bit cmpxchg operations on MMIO regions.

Link: https://github.com/AMDESE/qemu-iommu/blob/wip/for_iommufd_hw_queue-v8=
_amd_viommu_20260106/hw/i386/amd_viommu.c#L517

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..535842336d766 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c

[ ... ]

> @@ -2184,24 +2184,36 @@ static int em_call_near_abs(struct x86_emulate_ct=
xt *ctxt)

[ ... ]

>  static int em_cmpxchg8b(struct x86_emulate_ctxt *ctxt)
>  {

[ ... ]

> -	if (ctxt->dst.bytes =3D=3D 16)
> +	if (WARN_ON_ONCE(8 + !!(ctxt->rex_bits & REX_W) * 8 !=3D ctxt->dst.byte=
s))
>  		return X86EMUL_UNHANDLEABLE;
> =20
> -	if (((u32) (old >> 0) !=3D (u32) reg_read(ctxt, VCPU_REGS_RAX)) ||
> -	    ((u32) (old >> 32) !=3D (u32) reg_read(ctxt, VCPU_REGS_RDX))) {
> -		*reg_write(ctxt, VCPU_REGS_RAX) =3D (u32) (old >> 0);
> -		*reg_write(ctxt, VCPU_REGS_RDX) =3D (u32) (old >> 32);
> -		ctxt->eflags &=3D ~X86_EFLAGS_ZF;
> -	} else {
> -		ctxt->dst.val64 =3D ((u64)reg_read(ctxt, VCPU_REGS_RCX) << 32) |
> -			(u32) reg_read(ctxt, VCPU_REGS_RBX);
> -
> -		ctxt->eflags |=3D X86_EFLAGS_ZF;
> -	}
> +	if (!(ctxt->rex_bits & REX_W))
> +		em_cmpxchg8b_16b(ctxt, 32, 64);
> +#ifdef CONFIG_X86_64
> +	else
> +		em_cmpxchg8b_16b(ctxt, 64, 128);

[Severity: Medium]
Does this unconditionally allow a guest to invoke cmpxchg16b emulation
without checking if the guest CPUID actually supports X86_FEATURE_CX16?

If a hypervisor intentionally hides the CX16 CPUID feature to mimic older
hardware, it seems a guest could still execute a 128-bit cmpxchg targeting
an MMIO address, trapping to KVM and triggering this unconditional emulation
path in em_cmpxchg8b().

This appears to violate KVM guidelines requiring guest-visible features to =
be
discoverable and adhere to the guest CPUID configuration, which can break
live migration capability negotiation. Could we add a capability check for
X86_FEATURE_CX16 before performing the 128-bit emulation?

> +#endif
>  	return X86EMUL_CONTINUE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908074739.1074=
8-1-sarunkod@amd.com?part=3D2
