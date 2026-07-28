Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F729B799
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251933; cv=none; b=DMYI/KfhJXmZoPaprwsI6AQEf2zyqxVlyCGGTPU6+fo+oRPOEXleIu/PMMMfUljG+rslzV7WsXSt/z0yvvFBSfss0LSI4BY1e16MI6/Y4ra3Iyn+N4TeDYSJAT6kvM9S+dRvu95hjLqP/E9kWYdUsksMvfagL2ZdtpnejYWAPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251933; c=relaxed/simple;
	bh=okXHslJijcCT9dabm+V6bbMHs28wBl5N534NmVs+oEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQs5titOdwi0ilMZaEmfmmHU6EXrXxLcZDClODoXoEzquNPCjjs6jvfo7p1LOG/mEbhxilrfItwxCrB99aerMLJw93T85gmHBaYN+60t+EFEixGN31NY5ioCkX3w/4RrPqL2LwN9zbBci/n38kvdL/1hl/qZN0myIePA6vJorSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWUZEPuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWUZEPuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB631F000E9;
	Tue, 28 Jul 2026 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251932;
	bh=hzeiEWFtwgH7f22Q7HRnQu3nM2sJ3gVBboQ7Eyg8F6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JWUZEPuGaFOMYvbxVVDcvyhkq5DAHPMcMDldPLxCKCmZHK3AHEwYSqbXI9+kWSNM2
	 TBWRVrD5OfxjY8cep+XOYfeGqfxw1aolegQAO9g1vlXpdqRiibCRJkSjCnQpAi3H2s
	 s67TlCXEXRBSFIu98aNWDGzIj2RMnB6bQMMmDTptixBXiwhNNZ2DQBNKWVor57Renh
	 jBlM4yeQGXccWrpcihUwMubKv+Wi+oxYBgZpLyPG4nD+YnDgGpX6oImRLFsPtp0B0f
	 VH7l9wHtb74FXf8Nf0DVrLO8MCZcdVi2IP63Ryng558C6ojUOY9bDzrqdO2jybkLld
	 amBdUe5oFQpcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 22/36] KVM: x86: Remove runtime Xen TSC frequency
 CPUID update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-23-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-23-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:18:51 +0000
Message-Id: <20260728151852.0BB631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditional removal of runtime Xen TSC CPUID updates breaks =
existing userspace (e.g., older QEMU versions) that relies on KVM to popula=
te these fields.
- [High] The commit relies on non-existent IOCTLs (`KVM_GET_CLOCK_GUEST` an=
d `KVM_VCPU_TSC_SCALE`) for userspace to populate the Xen TSC CPUID leaves.
--

--- Patch [22]: [PATCH v7 22/36] KVM: x86: Remove runtime Xen TSC frequency=
 CPUID update ---
commit 127a72b774b2e5b2be60192682a2508bb1a3e37c
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Remove runtime Xen TSC frequency CPUID update

This commit removes the dynamic updating of the Xen TSC info CPUID leaf in
KVM, assuming that userspace can populate these fields using specific IOCTLs
at vCPU setup time. It also removes the associated helper functions in xen.=
h.

>   - KVM_GET_CLOCK_GUEST returns the pvclock_vcpu_time_info structure
>     containing tsc_to_system_mul and tsc_shift (Xen leaf index 1)
>   - KVM_VCPU_TSC_SCALE returns the effective TSC and bus
>     frequencies in kHz (Xen leaf index 2, and 0x40000010)
>   - KVM_VCPU_TSC_SCALE returns the raw hardware scaling ratio for
>     precise arithmetic (VMClock)

[Severity: High]
Are KVM_GET_CLOCK_GUEST and KVM_VCPU_TSC_SCALE actually present in the tree?

I cannot find these IOCTLs, and it doesn't appear that internal variables l=
ike
vcpu->arch.pvclock_tsc_mul are exported to userspace by any other mechanism.
Could the commit message be updated, or are there missing patches that
introduce these interfaces?

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8eabd68fa0a15..cd495bedf6c8e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c

[ ... ]

> @@ -2119,22 +2118,6 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u3=
2 *ebx,
>  		} else if (function =3D=3D 0x80000007) {
>  			if (kvm_hv_invtsc_suppressed(vcpu))
>  				*edx &=3D ~feature_bit(CONSTANT_TSC);
> -		} else if (IS_ENABLED(CONFIG_KVM_XEN) &&
> -			   kvm_xen_is_tsc_leaf(vcpu, function)) {
> -			/*
> -			 * Update guest TSC frequency information if necessary.
> -			 * Ignore failures, there is no sane value that can be
> -			 * provided if KVM can't get the TSC frequency.
> -			 */

[Severity: Critical]
Does unconditionally removing this dynamic Xen TSC CPUID update break older
userspace binaries (like older QEMU versions) that expect KVM to handle
populating these leaves?

Since older VMMs do not populate these leaves themselves, removing this cou=
ld
result in Xen guests receiving zeroes or uninitialized data for TSC info,
leading to incorrect timekeeping or crashes.

Should this ABI change be gated behind a new capability (e.g.,
KVM_CAP_XEN_TSC_CPUID) so that legacy VMMs continue functioning while new V=
MMs
can opt-in to the new behavior?

> -			if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, vcpu))
> -				kvm_guest_time_update(vcpu);
> -
> -			if (index =3D=3D 1) {
> -				*ecx =3D vcpu->arch.pvclock_tsc_mul;
> -				*edx =3D vcpu->arch.pvclock_tsc_shift;
> -			} else if (index =3D=3D 2) {
> -				*eax =3D div_u64(vcpu->arch.hw_tsc_hz, HZ_PER_KHZ);
> -			}
>  		}
>  	} else {
>  		*eax =3D *ebx =3D *ecx =3D *edx =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D22
