Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36ED4BEE41
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164611; cv=none; b=byGjNcwCeJ2cMJ5pJPMTygTp8vexT88bn6J7ePTnMuTA0Tvpaa2yxjSo4tKqEYf1Ej4qp+odkmq5wc4JHmx8f2AK2T3nKJfyhvCZ/3KIBn7gU0lkgFQa98qA4Vk9XO3kJIjZlnGWGZH0MYlava7NjtTeh04c0zKtcyyXS7De120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164611; c=relaxed/simple;
	bh=q5iQZN/fijCx9+dwQE/8sQXpji8VZneJ6P8kWYjjTNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PKrW0+S8xRtFJqf5aXorElmpF7VaTQIFxYpmxjWKyPCfp045VJFFEwp0iUbhdK9buEJrRUslg/+QnsA7sLiU/tYHVWvyfoVZyP4JomoYVEg9Vu0w/VGQH43wCGGW1NgzPYhY9QMr/HpMxYFlgr5uEOt4y0qtoS6t3ELAmcMmut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esbmq3zj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esbmq3zj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4321F000FF;
	Fri, 11 Sep 2026 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164609;
	bh=84oEuUQukYoyuiMdf5LKhsstqo3eIow24h4FPNZob/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=esbmq3zjfqe0v7dUNE/Pk+Fo1vCQOeG+Q9U/5hLSHXZSTU2l2pXKC6Nniidtz93Ld
	 F1jfX5TobdNcR4QcApwl5BhjB7YEXzhkOHDo5854lgpkKemQ2/FXsoRG9Vq4Jlc0U1
	 IuSNFGIkn3vnoW8ruEwefh0d3ym/wNbq+LvLl3N+oA5u64FEpY/h+5O7WPGGD1gmjB
	 odxH1m5LKhw/hwTjcjbyOke7pON0YzqQBO4yJYLw4r5wfvpnXuMKrhrGgghKjbF271
	 TpcnLj6jSVyrZzv0MnoTa8DzqNeeeQlnQQSymx5s83DW4gE27BSaDR5zhD2/Biq93T
	 25KOGaukOtOVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/28] KVM: VMX: Initialize VMCS FRED fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-8-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-8-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:10:09 +0000
Message-Id: <20260911221009.9E4321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Host FRED MSRs are left uninitialized/corrupted on VM-Exit if =
KVM skips explicit initialization while the hardware capabilities dictate l=
oading them.
- [Critical] VM-Exit unconditionally corrupts the host's IA32_FRED_RSP0 MSR=
 (alias for IA32_SYSENTER_ESP), causing host ring-3 to ring-0 transitions t=
o use the wrong stack in FRED-enabled hosts when non-FRED guests run.
- [Critical] Guest FRED state is not explicitly initialized when the host h=
as disabled FRED in software, leaving VMCS fields undefined.
--

commit 81aa8f5538dba9476f74b76b06da72ada534dd41
Author: Xin Li (Intel) <xin@zytor.com>
Subject: KVM: VMX: Initialize VMCS FRED fields

This commit initializes host and guest VMCS fields for FRED (Flexible Return
and Event Delivery). It populates the host fields with host MSR values and
sets the guest fields to zero. The initialization is gated by checking if
the X86_FEATURE_FRED CPU feature is enabled.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1562,6 +1562,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int=
 cpu)
>  				    (unsigned long)(cpu_entry_stack(cpu) + 1));
>  		}

[Severity: Critical]
Could unconditionally writing to HOST_IA32_SYSENTER_ESP corrupt the host's=
=20
IA32_FRED_RSP0 MSR?

Because MSR_IA32_FRED_RSP0 is architecturally aliased to
MSR_IA32_SYSENTER_ESP, every VM-Exit will load this small trampoline stack
into MSR_IA32_FRED_RSP0.

If a guest does not have FRED enabled, KVM's vmx_prepare_switch_to_host()
skips syncing the RSP0 state. The per-CPU cache __this_cpu_read(fred_rsp0)
is never updated to reflect the hardware change, meaning
fred_update_rsp0() assumes the MSR is already correct.

When the host returns to userspace and takes a syscall or interrupt, won't
FRED deliver the event to ring 0 using this tiny trampoline stack instead
of the proper task stack?

> +		if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATU=
RE_FRED)) {
> +			vmcs_write64(HOST_IA32_FRED_RSP1, this_cpu_fred_rsp(FRED_STACK_LEVEL_=
1));
> +			vmcs_write64(HOST_IA32_FRED_RSP2, this_cpu_fred_rsp(FRED_STACK_LEVEL_=
2));
> +			vmcs_write64(HOST_IA32_FRED_RSP3, this_cpu_fred_rsp(FRED_STACK_LEVEL_=
3));
> +		}

[Severity: Critical]
Does checking cpu_feature_enabled(X86_FEATURE_FRED) here leave host VMCS=20
fields uninitialized if the host booted with FRED disabled in software=20
(e.g., via clearcpuid=3Dfred)?

The SECONDARY_VM_EXIT_LOAD_IA32_FRED control is set statically in=20
setup_vmcs_config() based purely on hardware capability MSRs. If KVM=20
enables the exit control but skips initializing these fields because=20
of this software check, the CPU will validate uninitialized memory=20
(left over from VMCLEAR) on VM-Exit.

Can this cause a fatal VM-Exit failure due to non-canonical addresses=20
or reserved bits in the uninitialized Host-State area?

[ ... ]

> @@ -4500,6 +4506,17 @@ void vmx_set_constant_host_state(struct vcpu_vmx *=
vmx)
>  	 */
>  	vmcs_write16(HOST_DS_SELECTOR, 0);
>  	vmcs_write16(HOST_ES_SELECTOR, 0);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATUR=
E_FRED)) {

[Severity: Critical]
Does this condition share the same risk as vmx_vcpu_load_vmcs(), where a
software-disabled FRED still forces a hardware VM-Exit load of these
uninitialized host fields?

> +		/* FRED CONFIG and STKLVLS are the same on all CPUs */
> +		vmcs_write64(HOST_IA32_FRED_CONFIG, kvm_host.fred_config);
> +		vmcs_write64(HOST_IA32_FRED_STKLVLS, kvm_host.fred_stklvls);
> +
> +		/* Linux doesn't support kernel shadow stacks, thus SSPs are 0s */
> +		vmcs_write64(HOST_IA32_FRED_SSP1, 0);
> +		vmcs_write64(HOST_IA32_FRED_SSP2, 0);
> +		vmcs_write64(HOST_IA32_FRED_SSP3, 0);
> +	}
>  #else

[ ... ]

> @@ -5030,6 +5047,17 @@ static void init_vmcs(struct vcpu_vmx *vmx)
>  	}
> =20
>  	vmx_setup_uret_msrs(vmx);
> +
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && kvm_cpu_cap_has(X86_FEATUR=
E_FRED)) {

[Severity: Critical]
Similarly to the host state, does this condition skip initializing the
guest FRED fields if FRED is disabled in software?

If the hardware supports it, setup_vmcs_config() statically sets
VM_ENTRY_LOAD_IA32_FRED. Skipping vmcs_write64() here leaves these fields
architecturally undefined after a VMCLEAR operation.

Will this trigger an immediate VM-Entry failure when the CPU attempts
to load the uninitialized guest FRED fields from the VMCS?

> +		vmcs_write64(GUEST_IA32_FRED_CONFIG, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP1, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP2, 0);
> +		vmcs_write64(GUEST_IA32_FRED_RSP3, 0);
> +		vmcs_write64(GUEST_IA32_FRED_STKLVLS, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP1, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP2, 0);
> +		vmcs_write64(GUEST_IA32_FRED_SSP3, 0);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D7
