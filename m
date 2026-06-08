Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DC38B7C3
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949882; cv=none; b=hzi0TtrxxAGo6T2Tu5ZBD1rgHnATwXblL19UR+rwYDs+y0zWVCkLztBnhDDltK23ENhPTEfvtpTSUo/R9a/0JjT3z/XbQMGxxELSG4QbP48RZ3xFiOLDEvp2pEGpAtKQAeVdrgcoI+OfQFDXkmvurb375TiUSAfTXr2mSt0DJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949882; c=relaxed/simple;
	bh=k2PTBsN/hx3V62iZTp5D1MZ7DT8Fb3J8V1qSSukkbRU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nM/whxdZ1x74LGsClO126byWISTeYtTHtKkze7VNMkRGHlIpgTi7I8ZKThfsbAvQCLKC++5VXJVxBLFPtUBxUlKKDCsNEn0yezdaVAXtY2iRCWm8xGvf0ClPryOeuPZ3+lab0ZAO75/RTwrduXOqR/qmrSCGK9cRguCwRVVo34A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMtB+8xN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMtB+8xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CF51F0089A;
	Mon,  8 Jun 2026 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949880;
	bh=HjjbxEYqKHS0O7vK1B2lnSFAe4A7a2RqBxu9Ywenqak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMtB+8xNwGyWE9E3rglVuITFbONcqc9cuTKlv70yEPpJDLEAysQ9TCkpI8udM6b4u
	 EGZDoOrttk/z/J/xV3VDFXVBp6uDMsZEwSdBMco1JahAM355xDQszPtgJVslqqENnU
	 tI6HCtxotVv4w8fvT4Qkvl6nzG0wG7ALsdscqmeHYVnFB2grWkZoxlzX93Ua0ms4vy
	 R/bZsv4+9mioydldeTaT9kSPvKzhFFRQmIIPw0VApNWPCwZP+h70w3FcL+WMiC8qbF
	 SvekThkBY4u1pcsuwCuLuIZL/F9hvtHyNIbbDFen55Mnqb7QmFJrsdIWbUrA0EVPJ4
	 4AUTSiRaZPc5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 43/60] kvm: x86: Move CPUID state to struct
 kvm_vcpu_arch_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-44-joro@8bytes.org>
References: <20260608144252.351443-44-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:17:59 +0000
Message-Id: <20260608201800.74CF51F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Sharing `cpuid_entries` and `cpuid_dynamic_bits_dirty` across plan=
es causes dynamic CPUID bits to reflect the architectural state of the wron=
g plane, leading to cross-plane state corruption.
--

commit 696f84e84e21cbabab51dbf9bde76487e123b217
Author: Joerg Roedel <joerg.roedel@amd.com>

The CPUID state is shared across all planes, so move it to struct
kvm_vcpu_arch_common.

This commit moves cpuid state tracking from the per-plane kvm_vcpu_arch
to the shared kvm_vcpu_arch_common structure.

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..6d948d63306c 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
[ ... ]
> @@ -2089,10 +2094,11 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u=
32 *ebx,
>  	       u32 *ecx, u32 *edx, bool exact_only)
>  {
>  	u32 orig_function =3D *eax, function =3D *eax, index =3D *ecx;
> +	struct kvm_vcpu_common *common =3D vcpu->common;
>  	struct kvm_cpuid_entry2 *entry;
>  	bool exact, used_max_basic =3D false;
> =20
> -	if (vcpu->arch.cpuid_dynamic_bits_dirty)
> +	if (common->arch.cpuid_dynamic_bits_dirty)
>  		kvm_update_cpuid_runtime(vcpu);
> =20
>  	entry =3D kvm_find_cpuid_entry_index(vcpu, function, index);

[Severity: High]
Will this cause planes to observe dynamic cpuid bits from other planes?

Since cpuid_entries and cpuid_dynamic_bits_dirty are now shared across all
planes in vcpu->common->arch, kvm_update_cpuid_runtime() will modify the
shared array using per-plane state like vcpu->arch.cr4 and vcpu->arch.xcr0.

When kvm_update_cpuid_runtime() completes, it clears the shared dirty flag.
If a different plane later calls kvm_cpuid(), won't it see the dirty flag
as cleared and bypass its own update? This seems like it would return the
other plane's cached dynamic bits and xstate sizes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D43
