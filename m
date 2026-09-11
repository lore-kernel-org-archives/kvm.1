Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36164BEE2C
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165786; cv=none; b=fsTokm+Rhj5vOdxmXLkH8568m4vBHL3DDo1tBT4UOYfpU4aJ6XjZIrb0d+VPLZleP5vOGohl/yq8CvCUklTK5LSbMCJvIiVio04mGYJIpyB/V2BVZqasFlLl9aGJtuDxuSd7iP2Ax/K361PTMzhghv+tj4d8L0gObllfvUw61zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165786; c=relaxed/simple;
	bh=qJP/NeJo72FBi0vp51W3UXaJc4T8gFyyC3CfVDEqvPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bPt3Kd83WP/3OG8ddSEx9Xa8Lgi6pib0WV948znuYrQmryrdFu8/tz/EzernN3C/UYGwHSM9E5RW79lJU42UYOPfoxH3ocjfQyghn+X9OHKfTX0N/sCcWZtzl+f/iZ2hyupy/dsloGA+jwE3oEyMhEz3fJUSyKrFOYQuEmjhC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+NKF6Vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+NKF6Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8361F000FF;
	Fri, 11 Sep 2026 22:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165784;
	bh=+4xDU+1XMec6gbZAP0sqXIE9SHLgH1u7TkiZyfEABLg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+NKF6VpjQVZW/TPvRoBi5kXRJYqWAljbIBL3scxmNMA4sHe5l7xNe1HF3/oPXudp
	 cTOJwX1K/u7V/v8yIpAvxW2dtxz7z3ctArPvfrKFupVw+tVFH+8PJkKROIH9DGU/Rf
	 tA/9rTgS6TDcCwJu5aol5qsSjyZ58Y3UrP03o4N3MaABHBZtbtiQTuRhmXP80u3iyX
	 fy8i/+SpSJa79rOmYzGcv1VEduMcSvIAKbyALPIlZ4PB01KOVyrOf2VHkqqO+jHLq0
	 fK7zck0Zn6tpMSwQatFbrdPZGEACLo1idyDQ7VjnVrm8W89IIkDzM/IIKCgV5Fg1pe
	 Ygt5A0jpc8gqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 24/28] KVM: nVMX: Validate FRED-related VMCS fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-25-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-25-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:29:43 +0000
Message-Id: <20260911222944.4A8361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing cross-field consistency checks for FRED VM-entry and VM-ex=
it controls against IA-32e mode, allowing invalid VMCS state to cause hardw=
are VM-entry failures.
- [Low] Redundant nesting of CC() macro causes duplicate tracepoints on fai=
lure.
--

commit 20abff7abf2b901c4e2f9f748875173a59380be0
Author: Xin Li (Intel) <xin@zytor.com>

KVM: nVMX: Validate FRED-related VMCS fields

Extend nested VMX field validation to include FRED-specific VMCS fields,
mirroring hardware behavior. This enables support for nested FRED by ensuri=
ng
control and guest/host state fields are properly checked.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 83e846fb3fc8c..3e0a1ed6440d4 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c

[ ... ]

> @@ -3167,8 +3158,28 @@ static int nested_check_vm_entry_controls(struct k=
vm_vcpu *vcpu,
>  		if (CC(intr_info & INTR_INFO_RESVD_BITS_MASK))
>  			return -EINVAL;
> =20
> -		/* VM-entry instruction length */
> +		if (CC(intr_type =3D=3D INTR_TYPE_RESERVED))
> +			return -EINVAL;
> +
> +		/*
> +		 * Only for hardware exceptions and when the CPU enumerates
> +		 * VMX nested-exception support, bit 13 (indicating a nested
> +		 * exception) has value 1. Otherwise it is reserved.
> +		 */
> +		if (CC(has_nested_exception &&
> +		       (intr_type !=3D INTR_TYPE_HARD_EXCEPTION ||
> +			!nested_cpu_has_nested_exception(vcpu))))
> +			return -EINVAL;
> +
>  		switch (intr_type) {
> +		case INTR_TYPE_NMI_INTR:
> +			if (CC(vector !=3D NMI_VECTOR))
> +				return -EINVAL;
> +			break;
> +		case INTR_TYPE_HARD_EXCEPTION:
> +			if (CC(vector > 31))
> +				return -EINVAL;
> +			break;
>  		case INTR_TYPE_SOFT_EXCEPTION:
>  		case INTR_TYPE_SOFT_INTR:
>  		case INTR_TYPE_PRIV_SW_EXCEPTION:
> @@ -3176,6 +3187,28 @@ static int nested_check_vm_entry_controls(struct k=
vm_vcpu *vcpu,
>  			    CC(vmcs12->vm_entry_instruction_len =3D=3D 0 &&
>  			    CC(!nested_cpu_has_zero_length_injection(vcpu))))
>  				return -EINVAL;

[Severity: Low]
Does this double CC() macro wrapping cause duplicate tracepoints?

If both conditions evaluate to true for soft exceptions and interrupts, the
inner CC() will emit a tracepoint, which then causes the outer CC() to also
evaluate to true and emit a second tracepoint. Is this intentional?

[ ... ]

> @@ -3262,9 +3295,27 @@ static int nested_vmx_check_host_state(struct kvm_=
vcpu *vcpu,
>  	if (ia32e) {
>  		if (CC(!(vmcs12->host_cr4 & X86_CR4_PAE)))
>  			return -EINVAL;
> +		if (nested_cpu_load_host_fred_state(vmcs12)) {
> +			if (CC(vmcs12->host_ia32_fred_config & FRED_CONFIG_RESERVED) ||
> +			    CC(vmcs12->host_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->host_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->host_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->host_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
> +			    CC(vmcs12->host_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
> +			    CC(vmcs12->host_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_config & PA=
GE_MASK, vcpu)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp1, vcpu)=
) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp2, vcpu)=
) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_rsp3, vcpu)=
) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp1, vcpu)=
) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp2, vcpu)=
) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->host_ia32_fred_ssp3, vcpu)=
))
> +				return -EINVAL;
> +		}
>  	} else {
>  		if (CC(vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE) ||
>  		    CC(vmcs12->host_cr4 & X86_CR4_PCIDE) ||
> +		    CC(vmcs12->host_cr4 & X86_CR4_FRED) ||
>  		    CC((vmcs12->host_rip) >> 32))
>  			return -EINVAL;

[Severity: High]
Are we missing a check for FRED host state when not in IA-32e mode?

If an L1 guest configures vmcs12 with VM_ENTRY_LOAD_IA32_FRED =3D 1 but
VM_ENTRY_IA32E_MODE =3D 0 (or equivalent host state), the FRED host state c=
hecks
are completely bypassed since ia32e is false here.

Would this missing cross-field consistency check allow an invalid vmcs12 st=
ate
to be accepted, failing to validate that FRED controls must be zero in 32-b=
it
mode?

[ ... ]

> @@ -3447,6 +3498,48 @@ static int nested_vmx_check_guest_state(struct kvm=
_vcpu *vcpu,
>  	     CC((vmcs12->guest_bndcfgs & MSR_IA32_BNDCFGS_RSVD))))
>  		return -EINVAL;
> =20
> +	if (ia32e) {
> +		if (nested_cpu_load_guest_fred_state(vmcs12)) {
> +			if (CC(vmcs12->guest_ia32_fred_config & FRED_CONFIG_RESERVED) ||
> +			    CC(vmcs12->guest_ia32_fred_rsp1 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->guest_ia32_fred_rsp2 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->guest_ia32_fred_rsp3 & GENMASK_ULL(5, 0)) ||
> +			    CC(vmcs12->guest_ia32_fred_ssp1 & GENMASK_ULL(2, 0)) ||
> +			    CC(vmcs12->guest_ia32_fred_ssp2 & GENMASK_ULL(2, 0)) ||
> +			    CC(vmcs12->guest_ia32_fred_ssp3 & GENMASK_ULL(2, 0)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_config & P=
AGE_MASK, vcpu)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp1, vcpu=
)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp2, vcpu=
)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_rsp3, vcpu=
)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp1, vcpu=
)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp2, vcpu=
)) ||
> +			    CC(is_noncanonical_msr_address(vmcs12->guest_ia32_fred_ssp3, vcpu=
)))
> +				return -EINVAL;
> +		}
> +		if (vmcs12->guest_cr4 & X86_CR4_FRED) {
> +			unsigned int ss_dpl =3D VMX_AR_DPL(vmcs12->guest_ss_ar_bytes);
> +
> +			if (CC(ss_dpl =3D=3D 1 || ss_dpl =3D=3D 2))
> +				return -EINVAL;
> +
> +			switch (ss_dpl) {
> +			case 0:
> +				if (CC(!(vmcs12->guest_cs_ar_bytes & VMX_AR_L_MASK)))
> +					return -EINVAL;
> +				break;
> +			case 3:
> +				if (CC(vmcs12->guest_rflags & X86_EFLAGS_IOPL))
> +					return -EINVAL;
> +				if (CC(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_STI))
> +					return -EINVAL;
> +				break;
> +			}
> +		}
> +	} else {
> +		if (CC(vmcs12->guest_cr4 & X86_CR4_FRED))
> +			return -EINVAL;
> +	}

[Severity: High]
Similarly, does this else branch for the guest state miss failing the entry=
 if
nested_cpu_load_guest_fred_state(vmcs12) is true?

Without this cross-field check, a malicious L1 hypervisor could provide a
vmcs12 with VM_ENTRY_LOAD_IA32_FRED =3D 1 but VM_ENTRY_IA32E_MODE =3D 0, ca=
using
KVM to accept the invalid configuration and copy the VM_ENTRY_LOAD_IA32_FRED
bit directly into vmcs02 during prepare_vmcs02.

This would lead to an L0 hardware VM-entry failure instead of the required
software synthesis of an L1 VMFail, causing a host-side denial of service
against the VM process.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D24
