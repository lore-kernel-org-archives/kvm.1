Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC923C8AE
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693540; cv=none; b=hifzmA15UUhplOckx7YLRi9pw5BbYRDAMu6RGobaohaXxzTo7y1KBGSXblJ1rUNpCzYq/vCx+rg+DTalT6iYslGECXu7bCkptCvsf8+nAHpUUG85qOeI/sto5IThJgEU4Eg5TONOl79gfXkOgg25UKFmE8RJ+lLHfvnqvmk630k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693540; c=relaxed/simple;
	bh=VPhzxkM8e+Br+d0laxjenCUj/Zkb1K1wJmDWjK5LCqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtfNZB1q1mZAcFb2QMxNtrgwhLgMsA322KhI/vchWV+dwqWUy8Kzf9o0vY/fDVSt/2FZYlv2NSucEmgelx1RFI4jqVgzIzqea6BZ+1aKOcdPRZS56jHJWb/eXrmYex7k70NIH5VW/Ms2uIdq+7FnfbWkgSL2pz3NS1RFlaBq2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8+g4PS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8+g4PS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F81F000E9;
	Wed, 22 Jul 2026 04:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784693539;
	bh=BK7ERkk40CPMZBX7rRNptyKJc4HnEe2dhQt/tu4d0AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8+g4PS6B3B7k4ZE1I2Z/bJntDHaYxJ5Gsa9GgiZOsH1q4YzJmarhpIhH8RVCmfib
	 Dd5m7vct3IJfioAKHKP0seJC6Ku/JIko1GoQce6KvnUKwSVrEIeadzxMOs+qmau1PE
	 N4+Rqjzeze1ciqNEyTi0sJuviJUAaMSbANELbFq6I5LhSsg8mpIxzZP7exg8F12p61
	 80EvjfOqVUYGd9hcm9Hfpbufua77MYORwCi8SO5ruL+KCud81vyUop0qo2WNSGoT2w
	 6qZ/XjHaZD1LGORaWq+hH05UckYHBNnIgT+6pWlE4itO5ca8LGwjFslRAZ7H1a2k//
	 WZ7iiQyjDYOpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: VMX: Cap VMX preemption timer to work around
 Intel erratum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260722040311.3369898-1-jmattson@google.com>
References: <20260722040311.3369898-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:12:18 +0000
Message-Id: <20260722041218.BF1F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] If `calc_preemption_timer_limit()` returns 0, `preemption_timer_=
limit - 1` underflows to `ULLONG_MAX`, bypassing the frequency safety check=
 and writing `0xFFFFFFFF` to the preemption timer, which actively triggers =
the erratum.
--

--- Patch [1]: [PATCH v3] KVM: VMX: Cap VMX preemption timer to work around=
 Intel erratum ---
commit a2b4522c8049c537b2f6064441cc75a032adcb65
Author: Jim Mattson <jmattson@google.com>

KVM: VMX: Cap VMX preemption timer to work around Intel erratum

This commit implements a workaround for an Intel erratum where large
VMX-preemption timer values cause early expiration. It introduces a calcula=
ted
limit based on CPUID.15H to cap the timer value and soft-disable it.

Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6b96f7aea20bd..392788fec7bfb 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c

[ ... ]

> @@ -7292,7 +7293,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vc=
pu, bool force_immediate_exit
>  		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
>  		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
>  	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
> -		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
> +		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_limit - 1);

[Severity: Medium]
If preemption_timer_limit evaluates to 0, does this subtraction underflow a=
nd
result in writing 0xFFFFFFFF (after u32 truncation) to the timer? Writing=20
this value seems to be exactly what triggers the erratum we are trying to a=
void.

>  		vmx->loaded_vmcs->hv_timer_soft_disabled =3D true;
>  	}
>  }

[ ... ]

> @@ -8489,6 +8490,26 @@ static void __init vmx_setup_me_spte_mask(void)
>  	kvm_mmu_set_me_spte_mask(0, me_mask);
>  }
> =20
> +/*
> + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> + * VMX-preemption timer may expire earlier than expected when programmed
> + * with large values. The workaround is to cap the timer value to strict=
ly
> + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> + */
> +static __init u64 calc_preemption_timer_limit(void)
> +{
> +	u32 eax, ebx, ecx, edx;
> +
> +	if (cpuid_eax(0) < 0x15)
> +		return 1ULL << 32;
> +
> +	cpuid(0x15, &eax, &ebx, &ecx, &edx);
> +	if (!eax || !ebx)
> +		return 1ULL << 32;
> +
> +	return min_t(u64, 1ULL << 32, div_u64((u64)ebx << 25, eax));

[Severity: Medium]
Could this division result in 0 if a CPU or an L0 hypervisor provides unusu=
al=20
CPUID.15H values where eax > (ebx << 25)? If calc_preemption_timer_limit()=
=20
returns 0, it would cause the underflow mentioned above.

> +}
> +
>  __init int vmx_hardware_setup(void)
>  {
>  	unsigned long host_bndcfgs;

[ ... ]

> @@ -8639,7 +8662,7 @@ __init int vmx_hardware_setup(void)
>  		 * value.  Don't use the timer if it might cause spurious exits
>  		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
>  		 */
> -		if (use_timer_freq > 0xffffffffu / 10)
> +		if (use_timer_freq > (preemption_timer_limit - 1) / 10)

[Severity: Medium]
In the event that preemption_timer_limit is 0, this subtraction will underf=
low
to ULLONG_MAX. Does this unintentionally bypass the safety check and leave=
=20
enable_preemption_timer set to true?

>  			enable_preemption_timer =3D false;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722040311.3369=
898-1-jmattson@google.com?part=3D1
