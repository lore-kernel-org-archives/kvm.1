Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD662EBB8D
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957955; cv=none; b=hbEjjQmvEo62BQWfKsGOVMeSF/kQsnkC5NRkr8OvV3xv1BxMNN34zXL1iuUzSuo0ggWvyk4LaGbRD/bPphrGYM7H9VBxmpy/IL1pme7Tj/CqUoPFD20gPzurm8HGdNYyGlgOpMjE7n60ka/N+PbecY9Ht5XZLzREl4eYVBN7QxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957955; c=relaxed/simple;
	bh=zn5T0ZVRaXIVFl4ttINw4zqUTc/cV8bPgYexu7wBY8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IOfO6ggpzmEztHkfdPUwvDogcl8Tz/FRTnK32a61/hiJ1lV1Bz8zKezkK6ACEixIPAk83DosGwxXJh24ceX+NOp3ZVgpkaJbCiYcE5u0dfGR6GhLH9/8874htNmLuWQjy50IqNE36UNS1GFv4VLSRtzewD9J26zmC63YgHfSBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMmQZr7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMmQZr7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADD91F000E9;
	Mon, 13 Jul 2026 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957950;
	bh=KisnLKS4qXJBhSKCfQ4JOsOHL15/sUDSaFEiPSIAKuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HMmQZr7A5kpJMhEIq7skD5+6nsreqdFRRrghhgI8/YW7fxRMWxI2YugDYwmb4IWlr
	 CAqgTOeS95QHyxNyQS+cAfHudYbftOhoBWZG2wFV/BgrIEZvLXxj4CmVXjD2VAR73L
	 1cnFD6cghpgBk21PLhSlxSCKeM2uMwd9r9/jewrg0WJQfpVRq6VEOel7BC6Ewcj205
	 o2AixxpCJJAro79hOwZD/N8h5sK/ZIZnLddHSrTxikTCmknvuOgRSLzVwfpyEareDv
	 7+DVpKYpu+r0D8Awsq+2GKqOgLMnj2jE5SzdCiBYDnaAaIlRIAmUyKEpY0kUZQwRHg
	 fWuPmzh1qT57g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: store L2's TSC frame in the VM-exit IA32_TSC
 MSR-store list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713144605.2773845-1-amirmohammad.eftekhar@cispa.de>
References: <20260713144605.2773845-1-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:52:30 +0000
Message-Id: <20260713155230.7ADD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch incorrectly returns L2's TSC frame instead of L1's TSC f=
rame for IA32_TSC in the VM-exit MSR-store list, directly violating the Int=
el SDM.
- [Medium] The patch introduces an inconsistency between the MSR_IA32_TSC a=
utostore path and the fallback read path.
--

--- Patch [1]: [PATCH] KVM: nVMX: store L2's TSC frame in the VM-exit IA32_=
TSC MSR-store list ---
commit 9a886b64a3ad54e2783daef1b8de78fa7019e1c2
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: nVMX: store L2's TSC frame in the VM-exit IA32_TSC MSR-store list

This commit updates KVM to store L2's TSC frame in the VM-exit IA32_TSC
MSR-store list. It recomposes L2's frame using L1 state and vmcs12 TSC
controls.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6957bb6f5cf7e..610b58933d6b4 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1111,8 +1111,26 @@ static bool nested_vmx_get_vmexit_msr_value(struct=
 kvm_vcpu *vcpu,
>  	if (msr_index =3D=3D MSR_IA32_TSC && vmx->nested.tsc_autostore_slot >=
=3D 0) {
>  		int slot =3D vmx->nested.tsc_autostore_slot;
>  		u64 host_tsc =3D vmx->msr_autostore.val[slot].value;
> +		u64 l2_multiplier =3D vmx_get_l2_tsc_multiplier(vcpu);
> +		u64 l2_offset, l2_ratio;
> =20
> -		*data =3D kvm_read_l1_tsc(vcpu, host_tsc);
> +		/*
> +		 * The guest that just exited is L2, so the value auto-stored on
> +		 * its behalf must be L2's frame: RDMSR(IA32_TSC) in L2 reads
> +		 * (host_tsc scaled by the composed ratio) + the composed offset
> +		 * (SDM Vol 3C 27.4).  nested_vmx_vmexit() has already restored
> +		 * the composed TSC state to L1's by the time the MSR-store list
> +		 * is processed, so recompose L2's frame from L1 state and the
> +		 * vmcs12 TSC controls.  kvm_read_l1_tsc() would instead record
> +		 * L1's frame, dropping L2's offset (and scaling) entirely.
> +		 */
> +		l2_offset =3D kvm_calc_nested_tsc_offset(vcpu->arch.l1_tsc_offset,
> +						       vmx_get_l2_tsc_offset(vcpu),
> +						       l2_multiplier);
> +		l2_ratio =3D kvm_calc_nested_tsc_multiplier(vcpu->arch.l1_tsc_scaling_=
ratio,
> +							  l2_multiplier);
> +
> +		*data =3D kvm_scale_tsc(host_tsc, l2_ratio) + l2_offset;

[Severity: High]
Does this calculation violate the architectural requirements for the VM-exit
MSR-store list?

According to the Intel SDM (Vol 3C, 27.4), reads of MSR_IA32_TSC for the
VM-exit MSR-store list are not subject to TSC offsetting or TSC scaling,
which requires the hardware to save the bare host TSC.

From L1's perspective, the bare host TSC is L1's TSC frame. By applying L2's
offset and multiplier here, this returns L2's TSC frame instead. A
conforming L1 hypervisor that correctly applies its guest's offset and
multiplier could inadvertently apply them a second time, which could
corrupt the L2 guest's clock.

>  		return true;
>  	}
> =20

[Severity: Medium]
Is there an inconsistency introduced between the autostore path and the
fallback MSR read path?

If the autostore slot was not successfully allocated, the code falls back to
calling kvm_emulate_msr_read() right below this block. Because the vcpu
state is already reverted to L1's configuration before processing the
MSR-store list, the fallback path continues to evaluate and return L1's TSC
frame.

This divergence causes the returned value to unexpectedly toggle between L2=
's
frame and L1's frame depending on whether the autostore array was full.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713144605.2773=
845-1-amirmohammad.eftekhar@cispa.de?part=3D1
