Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BD3FBB5E
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932268; cv=none; b=HmjcJ5RLlRBT+WaK9nP2ifw/cRfoJop6tz7nPvn3pLggcJ7R6aZBh1Bfy/hrtsI+qBVTuf8OMc1yzIxMT3qLgGCuEDtwz7a6RC8neBVhGoP//mT3tINbFsJjyuvs0WoN1ldlZlUq0gbUyrwm36lqW/waSzYlKlXO+RnU04oJZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932268; c=relaxed/simple;
	bh=UGvj9+fTNicg8OVHAc4FfoTSAld78NvFBDQkr1vG0/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKVOZV8k0RGQYY59ogR+qib2Tfl1ZQbPu8Q9zpX6b2Qo5AVvqoHU3dk1SfFAM6OKXpbqgl4CEzFpyoHMjXt3MWYSAQ/P3bQAjFzM3N+SI56g3ik9duDvz0GF4qOQ23a7ThgwYAfJgVv050T22vhj7a80xikVru3jkEMiCJZkltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxTIt7D5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxTIt7D5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F41F00893;
	Mon,  8 Jun 2026 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932267;
	bh=JvueXYLKBVq34rjHz7MFIk7ha3xlNo2yd9lYU8tF1AY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxTIt7D5YJObZlxKBW9PT4JDchPc3QK3ihnaFjwDK/zx1XxpcDCqV2RYac89d4/fP
	 GXv8JkBEsaFbtcSdhugp070O1qZBFA9f7Je58gCUSIDMYsHcOGsI1qSqk6KcK6oQmU
	 lTvYaVyDM+JWgEc5uWbaQaD8ADbuE8DBdb1vjZNcrc0yxcy+Oz5LUMvfNV5JqNiCEF
	 3oeh1MeGBzAikOUC1+P2B5lUwdxaTGAbtlyMAKwRznyTxhnRZMSj/0gzgwtW307gOd
	 rX3fh142WI0ExWSiCZ6HB6PPpjAAj0yavUbhoYHTSaLzLpvh8jV4cOsoZDkPFVcI3J
	 UgTaVt0Ov+zMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/60] KVM: SVM: Add support for the SEV-SNP #HV IPI NAE
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-8-joro@8bytes.org>
References: <20260608144252.351443-8-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:24:26 +0000
Message-Id: <20260608152427.5C6F41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unconditional dereference of `vcpu->arch.apic` before verifyin=
g its existence causes a host kernel panic if the in-kernel LAPIC is absent.
--

commit a2db726cf6351649d4f8b6df636d0b3bb754fe98
Author: Melody Wang <huibo.wang@amd.com>
KVM: SVM: Add support for the SEV-SNP #HV IPI NAE event

This commit introduces support for the #HV IPI NAE event for SEV-SNP
guests, allowing them to send IPIs to other vCPUs when Restricted
Injection is enabled. It implements the NAE event according to the GHCB
specification and adds a helper to send the IPI via x2APIC or xAPIC.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca667..ab40a2e4ab9d5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c

[ ... ]

> @@ -3583,3 +3583,25 @@ void kvm_lapic_exit(void)
>  	static_key_deferred_flush(&apic_sw_disabled);
>  	WARN_ON(static_branch_unlikely(&apic_sw_disabled.key));
>  }
> +
> +/* Send IPI by writing ICR with MSR write when X2APIC enabled, with mmio=
 write when XAPIC enabled */
> +int kvm_xapic_x2apic_send_ipi(struct kvm_vcpu *vcpu, u64 data)
> +{
> +	u32 icr_msr_addr =3D APIC_BASE_MSR + (APIC_ICR >> 4);
> +	struct kvm_lapic *apic =3D vcpu->arch.apic;
> +	gpa_t gpa =3D apic->base_address + APIC_ICR;

[Severity: Critical]
Does this unconditionally dereference the apic pointer before verifying it
is non-NULL?

If a guest or userspace process triggers the #HV IPI VMGEXIT for a VM
created without an in-kernel APIC, vcpu->arch.apic will be NULL. Because
apic->base_address is accessed immediately to calculate gpa, could this
trigger a host kernel panic?

Could the gpa calculation be deferred until after the kvm_lapic_enabled()
check to prevent this?

> +
> +	if (!kvm_lapic_enabled(vcpu))
> +		return 1;
> +
> +	if (vcpu->arch.apic_base & X2APIC_ENABLE) {
> +		if (!kvm_x2apic_msr_write(vcpu, icr_msr_addr, data))
> +			return 0;
> +	} else {
> +		if (!apic_mmio_write(vcpu, NULL, gpa, 4, &data))
> +			return 0;
> +	}
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_xapic_x2apic_send_ipi);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D7
