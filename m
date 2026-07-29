Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699B48035C
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333059; cv=none; b=Mb87xegtdV4XX8xBI4H1KVkJiigEiH7UnG3Gy585SKkbEJRPcwPSOjb1zl/2w/l67z1Tw8B3PsFsApEtz9E8PUaxLOFrHBjHtSnLU7h2hVMILAOEUoUvkhaHtnd1ly8XnsXcmETVKF4edGIcmb0tw1b3+6EinNrA9qp4aBBqmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333059; c=relaxed/simple;
	bh=+a4E2DwrqGsPjqV8eVQjvVaELxn85Anle/p001GGg5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HLwqwCyWFEAQYY30LXipAzCBPmJGbOGPymqov1jMLavq2I/0oF40vP6t1zHlM223S8NY/owmu3z+iCaglLtLYhSRVl3VCXVIV/LuujrCpP83dWOA4pSnmdrnXPK7ACun2LSxT8ONM7aL9QF6KHjHPkKVsHlyo1OJ8vXLRLDH1y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiL2f0yM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiL2f0yM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CAA1F000E9;
	Wed, 29 Jul 2026 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333055;
	bh=BnZZ/UG3KpTJ/q0pFZnDSY1e9N1WhY1d8yZE8+yzNfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hiL2f0yMlcWLCFJK7c1fj/YPZwzGZE7kkzjfyVmY8j5NQ/Oxq38kuShUAE2kn2gSx
	 ENRyFGRapb1EX4KcJwRpHumjHrHYSZzLZaIax4BhTB3hyNHzJ4xfIhK0OklSugEEYH
	 gBsWs8SlQogje8HlhwIu2x+tnma+mV7RtuSMmZV3rWDdi9TdJFdP205gqWDkts/CAw
	 5fOf+D4Q5GxY3qkhXym2aQloalwgw4NFnwkR4/diU5IJ09VU6UpFwCNyImCamwZaml
	 vFTpQEIzFzq+DZ7dhE+Pb/fa5ZrXxmFO5jMxREPq8Ept4UxbdQN8A+jB7nBf4CvCOy
	 AAmeTMfisWDEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] KVM: VMX: Cap VMX preemption timer to work
 around Intel erratum
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729134203.1377606-3-seanjc@google.com>
References: <20260729134203.1377606-1-seanjc@google.com>
 <20260729134203.1377606-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:50:54 +0000
Message-Id: <20260729135054.B5CAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The computed VMX preemption timer maximum value can exceed 32 bits=
 on modern CPUs because it is not clamped to the architectural limit (UINT_=
MAX). This leads to silent 32-bit truncation when written to the VMCS, brea=
king the timer's soft-disable mechanism and causing premature guest timer e=
xpirations.
--

--- Patch [2]: [PATCH v6 2/2] KVM: VMX: Cap VMX preemption timer to work ar=
ound Intel erratum ---
commit 021d423821c3a8ec582691801fee4d57b9a316fc
Author: Jim Mattson <jmattson@google.com>

KVM: VMX: Cap VMX preemption timer to work around Intel erratum

This commit introduces a workaround for an Intel erratum where the VMX
preemption timer can expire early if programmed with large values. It
calculates a safe maximum value based on CPUID.15H. This maximum is then
used when the timer is soft-disabled and to bound delta_tsc.

Closes: https://lore.kernel.org/all/Zn9X0yFxZi_Mrlnt@google.com/

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 7d2cc36a04e51..67c8dc1eb2c4f 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c

[ ... ]

> @@ -8305,6 +8306,33 @@ static inline int u64_shl_div_u64(u64 a, unsigned =
int shift,
>  	return 0;
>  }
> =20
> +/*
> + * Workaround for a widespread Intel erratum (e.g. EMR158) where the
> + * VMX-preemption timer may expire earlier than expected when programmed
> + * with large values. The workaround is to cap the timer value to strict=
ly
> + * less than 2^25 * CPUID.15H:EBX / CPUID.15H:EAX.
> + */
> +static __init u64 calc_preemption_timer_max_value(void)
> +{
> +	const u64 ARCHITECTURAL_MAX_VALUE =3D UINT_MAX;
> +	u32 eax, ebx, ecx, edx;

[ ... ]

> +	if (WARN_ON_ONCE(!(((u64)ebx << 25) / eax)))
> +		return ARCHITECTURAL_MAX_VALUE;
> +
> +	return (((u64)ebx << 25) / eax) - 1;

[Severity: High]
If a CPU has a high TSC-to-crystal clock ratio (for example, EBX/EAX >=3D 1=
28),
could this calculation exceed UINT_MAX? Because the returned u64 is not cla=
mped
to ARCHITECTURAL_MAX_VALUE, preemption_timer_max_value could end up storing=
 a
value larger than 32 bits.

> +}

[ ... ]

> @@ -8362,12 +8392,12 @@ int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 g=
uest_deadline_tsc,
>  		return -ERANGE;
> =20
>  	/*
> -	 * If the delta tsc can't fit in the 32 bit after the multi shift,
> -	 * we can't use the preemption timer.
> +	 * If the delta tsc exceeds the preemption timer limit after the
> +	 * multi shift, we can't use the preemption timer.
>  	 * It's possible that it fits on later vmentries, but checking
>  	 * on every vmentry is costly so we just use an hrtimer.
>  	 */
> -	if (delta_tsc >> (cpu_preemption_timer_multi + 32))
> +	if ((delta_tsc >> cpu_preemption_timer_multi) > preemption_timer_max_va=
lue)
>  		return -ERANGE;

[Severity: High]
If preemption_timer_max_value is greater than UINT_MAX, does this condition=
 fail
to catch delta_tsc limits that exceed 32 bits? It appears this might bypass=
 the
required hrtimer fallback for large guest deadlines, as the value will late=
r be
silently truncated.

> =20
>  	vmx->hv_deadline_tsc =3D tscl + delta_tsc;

[ ... ]

> @@ -8401,7 +8431,7 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vc=
pu, bool force_immediate_exit
>  		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
>  		vmx->loaded_vmcs->hv_timer_soft_disabled =3D false;
>  	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
> -		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
> +		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, preemption_timer_max_value);
>  		vmx->loaded_vmcs->hv_timer_soft_disabled =3D true;
>  	}
>  }

[Severity: High]
Will writing an un-clamped u64 to vmcs_write32() cause it to be truncated? =
If
truncated, the preemption timer could fire prematurely when soft-disabled
instead of waiting for the maximum duration.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729134203.1377=
606-1-seanjc@google.com?part=3D2
