Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620939;
	b=RAhQZz4ZbOX3cJyd00Zfki/b7sdoS9DsPNU+qQAyFrCq+Qfp6zMWoqfP1ewt/CUviG+Q
	 aIk0Wrw9Kf5k0M5zG11vwoKstLUKVSHVmMej6VYzaKeD/z4pr5FLc2GfwqxdbhROyIPMK
	 Sv+RR/RzSPvW2AVFzCwHUZJnpNxFGwnTAAb3tYYBR0RJRXaW1yo7T5G9w5L6qqQkhJnnV
	 odpO2PWH6rosbFj5/0UtoMZ2QpgJBNGbFzKfom5dgRXgvtr+UyV5+Vh8t2FPvUdQ8h49D
	 K9b/8r4AfALZq61eyg396q+4V7Y5+3D5ISHvxhVDRuhHbotrgDCjkHgbj1dBZx/ekWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620939;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=b5sVRv99PR+ZM7/7wDnpEuAOy5pT8BEMpzPFn1YNXQo=;
	b=WHjZKDvd55uG7VIBZhL1uCXXezcUUtVKUOkIGesy+1H0NNc+b/Faee3mq2AzCCQQ74LR
	 pyKgTETORVlr+Mcfe+IUMbDdJUPoIqwo7k6FTacfVZjoeCOncfeT6R2IbjmleiWBGjTq6
	 z5xrugtMH2b2Eo9VF5Ex4XGQqK5JkSrX+2yxcUigVlaAamebbArWUaeLPJRwfrHt2eIT7
	 oGfs8+8LFvyDYri9/7+4iz5S7F5GF0lJQbYhkQPCngPBHqkV5EAyZ5fNF8RR2ExuPl3ia
	 Wth4AtjAIhLzvEFt3GoH9Br75EwG60Frwme215CRzdLquAryzMT5m7V8NZIltySb9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NWpl/FAh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3F606A32E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWpl/FAh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E421F00A16;
	Mon,  2 Nov 2026 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793620938;
	bh=b5sVRv99PR+ZM7/7wDnpEuAOy5pT8BEMpzPFn1YNXQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NWpl/FAhGeCSzQK+WSAVbmATfxuaJuu2BWOLZJTpnc1jzJTFLtTkS90u3d7mVe5dW
	 VHz8BYszbv1nNVGdSa7Nc/xiMJfr3k+CstS20VzpVMGVfRBCWBp1TssVZZ/iau9Syg
	 1zjxJ/5Zx7sV6d/lYFplcg12/Z96ZCT7+vWhodWTRusr7Yg+ZMyaS32lrg7x+sFbkQ
	 lbb1VpfjGKSONnCU1K6444lPXFmWE2vRViS1O3qEsMXC38S9qRNOj8jCMymtzzb0dz
	 aCt/u37eePzuRH56y4jBI7VHEJHg8vR1+oIBfosq3f7rPfUSjqdxgq2lxNBgU7jh4i
	 wYed3SOogKuDw==
Message-ID: <sashiko-outbox-193363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] KVM: SEV: Add direct VMSA capability
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261102114137.1198982-5-joro@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-5-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:02:17 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: SEV: snp_launch_update_vmsa() skips debug and state checks =
on direct VMSA
- [Low] KVM: SVM: unscoped guard(mutex) in switch case in svm_enable_vm_cap=
()
--

commit ab904a5d7e5b93c050ee3612b960971e0dec53a9
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: SEV: Add direct VMSA capability

This commit adds the VM-scoped KVM_CAP_SNP_DIRECT_VMSA capability so
userspace can explicitly opt into direct VMSA mode on an SNP VM before
creating vCPUs. When enabled, KVM skips allocating KVM-owned VMSAs during
vCPU creation and skips syncing and measuring KVM-owned VMSAs at launch
finish.

[ ... ]

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 5bfe23790ba46..5638786c1d03d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2541,8 +2541,15 @@ static int snp_launch_update_vmsa(struct kvm *kvm,=
 struct kvm_sev_cmd *argp)
> =20
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct vcpu_svm *svm =3D to_svm(vcpu);
> -		u64 pfn =3D __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
> +		u64 pfn;
> +
> +		if (sev->snp_direct_vmsa) {
> +			if (!svm->sev_es.snp_has_guest_vmsa)
> +				svm->vmcb->control.vmsa_pa =3D INVALID_PAGE;
> +			goto protect_vcpu;
> +		}
> =20
> +		pfn =3D __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
>  		ret =3D sev_es_sync_vmsa(svm);
>  		if (ret)
>  			goto out;

[Severity: Medium]
When sev->snp_direct_vmsa is set in snp_launch_update_vmsa(), jumping
directly to protect_vcpu skips sev_es_sync_vmsa(), which normally performs
these pre-launch checks:

arch/x86/kvm/svm/sev.c:sev_es_sync_vmsa() {
	if (vcpu->arch.guest_state_protected)
		return -EINVAL;

	/* Check some debug related fields before encrypting the VMSA */
	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
		return -EINVAL;
}

Because kvm_arch_vcpu_ioctl_set_guest_debug() and
kvm_vcpu_ioctl_x86_set_debugregs() only check
vcpu->arch.guest_state_protected, userspace can invoke KVM_SET_GUEST_DEBUG
or KVM_SET_DEBUGREGS on an SNP vCPU before calling KVM_SEV_SNP_LAUNCH_FINIS=
H.

Could skipping these checks allow an SNP guest with KVM_CAP_SNP_DIRECT_VMSA
enabled to finalize launch with unsupported host guest_debug state (such as
BP_VECTOR intercepts, single-step, hardware breakpoint switching via
KVM_DEBUGREG_BP_ENABLED, or APICV_INHIBIT_REASON_BLOCKIRQ) locked in once
vcpu->arch.guest_state_protected is set, or allow snp_launch_update_vmsa() =
to
run again on an already-protected vCPU?

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44f..d841093941156 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5458,6 +5458,27 @@ static void *svm_alloc_apic_backing_page(struct kv=
m_vcpu *vcpu)
>  	return page_address(page);
>  }
> =20
> +static int svm_enable_vm_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
> +{
> +	switch (cap->cap) {
> +#ifdef CONFIG_KVM_AMD_SEV
> +	case KVM_CAP_SNP_DIRECT_VMSA:
> +		if (memchr_inv(cap->args, 0, sizeof(cap->args)) ||
> +		    kvm->arch.vm_type !=3D KVM_X86_SNP_VM)
> +			return -EINVAL;
> +
> +		guard(mutex)(&kvm->lock);
> +		if (kvm->created_vcpus)
> +			return -EINVAL;
> +
> +		to_kvm_sev_info(kvm)->snp_direct_vmsa =3D true;
> +		return 0;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +}

[Severity: Low]
As reported by Sashiko on v2 [1], in svm_enable_vm_cap(), guard(mutex)
declares a cleanup-attributed variable inside the switch block without
enclosing braces around the KVM_CAP_SNP_DIRECT_VMSA case.

When cap->cap does not match KVM_CAP_SNP_DIRECT_VMSA, jumping to the default
label bypasses initialization of the guard variable while remaining in its
scope, causing a build failure with CONFIG_KVM_AMD_SEV enabled. Should the
case body be wrapped in braces or use scoped_guard()?

[1] https://lore.kernel.org/r/20260908103338.427254-5-joro@8bytes.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102114137.1198=
982-1-joro@8bytes.org?part=3D4
