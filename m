Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FC3CF1F0
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166082; cv=none; b=G5xTmCvddLbplgsMOAdjGwnc2yTrMXZumeP/mfkR3xiaXgKvO2eG584QOEn8X68HPs9kWMhTcQmRr9HesKOtXSNc1xgHOmvb6rLN+ed99gQEjc61dnKFfila686RSMSu01ayDB58VXT7f+e9DAx3usrCJotf4bnYLjavd4WnY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166082; c=relaxed/simple;
	bh=3E5j/FE/JRJkbw9OQMSFEo6HgKHmGwRPkJ8xSvjvNFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gLVrkR0iOwIucfXWWiRLP+ZYh7uyhDV61ChP18/Y/wYrhaXbSXTvXk4oDnLtEtmgacdn74oVqdSdFxZOPdX2qY7HTQJ+kRMxpZ7mtoRwtUy/7FmyTPc/9z30wkG11EYG5zFZ2wQufH3XNmVurpCEWUSlhz47sVfDh+1q+by1jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVKDvH2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVKDvH2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2401F000FF;
	Fri, 11 Sep 2026 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166079;
	bh=53gzqFhKIIfwlf/SraLGO/ELphUOZwMJCKRocudIhyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PVKDvH2tMqFNeNzP0n6zsszuu0yIqvC/j+vBj2ppCnFOt1FwSdmy7YLYgh5OGGeal
	 AlIKfMqhvuByp4/pt1wX81+is7PWMmaxn3Z5P+VfxFdZeNu1dojs/yahUp7g/oFQ8T
	 PDD4vNu1B/zvxtHZTw2qeNcWZKjIXqKxisgR7YWqW2+mawWSfMKmzeDlbwATbiFTGv
	 lb0HesQKNEqizrRxOzmfo4Ub0FJGt3r1MGf+bXbVzFzJFx9lsrpH/GIv9yCUpzOYK3
	 v8Wup9IZ7eDnTAtAOBwWnKtxTxzTlv1fSRH6ngTNVGWu8QKGPjDZA0t41ibbkOJQJZ
	 BQM1VDqFTdEYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 21/28] KVM: nVMX: Handle FRED VMCS fields in nested
 VMX context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-22-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-22-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:34:38 +0000
Message-Id: <20260911223438.EF2401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] L2 guest state corruption: FRED MSRs leak across VMRESUME when L1 =
configures LOAD_IA32_FRED=3D1 and SAVE_IA32_FRED=3D0.
- [Medium] Missing VM-entry consistency checks allow L1 to bypass guest FRE=
D MSR validation and trigger hardware VM-entry failures.
--

commit 057f971773a8afea0241cab2d4cb47bca7dc2643
Author: Xin Li (Intel) <xin@zytor.com>
Subject: KVM: nVMX: Handle FRED VMCS fields in nested VMX context

Extend nested VMX context management to include FRED-related VMCS fields,
enabling proper handling of FRED state during nested virtualization.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6576935b9d43f..83e846fb3fc8c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c

[ ... ]

> @@ -2755,6 +2792,10 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *v=
mx, struct vmcs12 *vmcs12)
>  				     vmcs12->guest_ssp, vmcs12->guest_ssp_tbl);
> =20
>  	set_cr4_guest_host_mask(vmx);
> +
> +	if (guest_cpu_cap_has(&vmx->vcpu, X86_FEATURE_FRED) &&
> +	    nested_cpu_load_guest_fred_state(vmcs12))
> +		vmcs_write_fred_msrs(&vmcs12->guest_fred_msrs);
>  }

[Severity: High]
Can this lead to L2 guest state corruption?

When L1 sets VM_ENTRY_LOAD_IA32_FRED=3D1 but VM_EXIT_SAVE_IA32_FRED=3D0, it
expects L2's FRED MSRs to be reset to the values in vmcs12 on every VM-entr=
y.

Because the vmcs02 update is placed here inside prepare_vmcs02_rare(), it is
skipped on a clean VMRESUME operation. Since FRED MSRs are passed through to
L2 (via the MSR bitmap), L2 can modify them directly without triggering a
VM-exit.

Hardware saves these modified values to vmcs02 on VM-exit, but KVM does not
sync them back to vmcs12 (because SAVE_IA32_FRED=3D0). On the next VMRESUME,
prepare_vmcs02_rare() is bypassed, leaving the stale, modified L2 values in
vmcs02. L2 will therefore inherit its previous modified state instead of the
clean baseline values configured by L1 in vmcs12.

[ ... ]

[Severity: Medium]
Could KVM miss a VM-entry consistency check during FRED MSR validation?

Looking at nested_vmx_check_guest_state() in arch/x86/kvm/vmx/nested.c,
the FRED MSR validation is nested under the ia32e condition:

	if (ia32e) {
		if (nested_cpu_load_guest_fred_state(vmcs12)) {
			if (CC(vmcs12->guest_ia32_fred_config & FRED_CONFIG_RESERVED) ||

If an L1 hypervisor sets VM_ENTRY_LOAD_IA32_FRED=3D1 but clears
VM_ENTRY_IA32E_MODE=3D0, these checks bypass the validation of
guest_ia32_fred_config and other FRED MSRs.

Additionally, KVM appears to lack the cross-control verification required
by the SDM where LOAD_IA32_FRED=3D1 requires IA32E_MODE=3D1. As a result, K=
VM
might attempt to VMLAUNCH vmcs02 with invalid state, which hardware rejects
with a VM-instruction error and triggers the warn_on_missed_cc path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D21
