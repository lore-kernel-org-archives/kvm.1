Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060ED3D1CC1
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164961; cv=none; b=FpexUjPqipUJzY7JJIZ5Jwaq6J+w+WNnozRflels8PwgTRekEMxqXhfqGt+hXFNo0eW2eJht7Y4vWleHSBdnHO6hOXMoyBheMA6eitjJCgV1EInzgTkD6m0fP5pTMz0VETks9tKC/Edru9MyNlT0sZ8UFnFKvyGPqQEIzxaWaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164961; c=relaxed/simple;
	bh=gkjjhy+R6VWyZl06847c6UO3rhGzn7NHqLi1Yaam90A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfOcvzxk4GzxXECrA33Orw6w+m+egodr6GQQF3A2PvrhTaIaVbzcK7hxdskzxz1bBpKc3jFMw9jnb9JHCfjJ6mVVXZIpr80klzL3IObieLF8ree7lODwACdxAdX/DV8czIVKc+3GvtOmD4oFabyqhlBdllzMQYV9YCCHB3Gv1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W23b6AlJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W23b6AlJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743ED1F00898;
	Fri, 11 Sep 2026 22:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164954;
	bh=U5nSWjYQhF8eiUmTXzoK+HoViHSLpBRgwJUnhlTg6WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W23b6AlJn0/jUGm7O91lDC6h9FuxMRvCW+G44OcjbiQ3C7mVe6vU+SmvBCT4kxBM2
	 5ey8vdCmnl6gDuOkECvxyFN5adOS8ldTdylBFQc3G7BHxNKgZItgcXYL1qQuTPnI19
	 gfGqiZnXk43shJH8iXCfT2PPNjE2nGbNyEF0IpDP4xcwKcaHEjJEnApTnwBGJKx1Gy
	 O7NRMhjlJhwDqc0yDEXY14W3bVeklPbdcoz38BqzTr3Ei08+WWdfQSIm6fHHIjDisJ
	 JoBFpX9zIDKKeiCxYDsRA0BhJJe20mnL8SdRA1VizoEBf8bEVJYfBaWfk0kBRJEBCz
	 vDEvXtgEuYdUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/28] KVM: x86: Handle CR4.FRED when emulating RSM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-18-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-18-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:15:54 +0000
Message-Id: <20260911221554.743ED1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] kvm_set_cr0() does not reject clearing CR0.PG when CR4.FRED is set=
, leading to an architecturally invalid vCPU state and guest-triggered VM-E=
ntry failures.

Pre-existing issues:
- [High] RSM emulation fails for guests with CR4.CET enabled if the SMM han=
dler temporarily clears CR0.WP.
--

commit 14cda06623e4685b7e725f05b0e66de0ac8e2fb9
Author: Sohil Mehta <sohil.mehta@intel.com>

KVM: x86: Handle CR4.FRED when emulating RSM

Clear CR4.FRED before CR0.PG when leaving long mode on RSM, and restore
it only after CR0.PG has been set, the same way CR4.PCIDE is already
handled in both directions.

> diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
> index 656a38dad7e7a..a504e93fc5f5f 100644
> --- a/arch/x86/kvm/smm.c
> +++ b/arch/x86/kvm/smm.c
> @@ -435,10 +435,10 @@ static int rsm_enter_protected_mode(struct kvm_vcpu=
 *vcpu,
> =20
>  	/*
>  	 * First enable PAE, long mode needs it before CR0.PG =3D 1 is set.
> -	 * Then enable protected mode.	However, PCID cannot be enabled
> -	 * if EFER.LMA=3D0, so set it separately.
> +	 * Then enable protected mode. However, PCID and FRED cannot be
> +	 * enabled if EFER.LMA=3D0, so set them separately.
>  	 */
> -	bad =3D kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
> +	bad =3D kvm_set_cr4(vcpu, cr4 & ~(X86_CR4_PCIDE | X86_CR4_FRED));
>  	if (bad)
>  		return X86EMUL_UNHANDLEABLE;

[Severity: High]
This isn't a bug introduced by this patch, but does RSM emulation fail for
guests with CR4.CET enabled if the SMM handler temporarily clears CR0.WP?

If a guest enables CR4.CET and CR0.WP, and an SMI occurs where the SMM hand=
ler
clears CR0.WP (e.g., to modify read-only firmware data) and executes RSM
without restoring CR0.WP, rsm_enter_protected_mode() attempts to restore the
pre-SMM CR4 (which has CET=3D1) before restoring the pre-SMM CR0.

The kvm_set_cr4() call fails because the current vCPU CR0 still has WP=3D0.=
 This
forces the VM to shut down due to an unhandleable emulation failure
(X86EMUL_UNHANDLEABLE).

Does X86_CR4_CET also need to be masked out here and deferred until after
kvm_set_cr0(), exactly like PCIDE and FRED?

[ ... ]

[Severity: High]
Does this missing update to kvm_set_cr0() cause a regression where a guest =
can
clear CR0.PG when CR4.FRED is set?

Looking at kvm_set_cr0() in arch/x86/kvm/regs.c:

	if (!(cr0 & X86_CR0_PG) &&
	    (is_64_bit_mode(vcpu) || kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)))
		return 1;

If a guest in 32-bit compatibility mode (CS.L=3D0, EFER.LMA=3D1) with CR4.F=
RED=3D1
executes a MOV to CR0 to clear CR0.PG, kvm_set_cr0() incorrectly allows the
operation because it only checks for is_64_bit_mode() or CR4.PCIDE=3D1.

KVM then clears EFER.LMA, leaving the vCPU with CR4.FRED=3D1 and EFER.LMA=
=3D0,
which is an architecturally invalid state.

Can this allow a guest kernel (CPL=3D0) to force a host-level VM-entry abor=
t and
cause a Denial of Service by terminating its own VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D17
