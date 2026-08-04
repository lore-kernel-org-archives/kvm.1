Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F4945041E
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887813; cv=none; b=BvqkuotOsnCjxIrpwW3Vr4VvtptCqLmcNHEj7GIN6CF9KtoMyAxH3Hcb06ulkQDy8uV0QwwtqUctLj9KpZsGC5cgrBVkdUMiJUjE7jBEAT5Z4oBpk9i0KlhSkyuz0TnpeJAEBeirv0U/s1R0PvLSjjnd1PvTN2qeSdgDaGu1wqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887813; c=relaxed/simple;
	bh=DasHDXElKdeI59QiT4v7JlQzgDOgKj2fKppgudDoKso=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvu37zmoKGuGMkoAmu94tGGrbdkRiFcpswT2JYt0F8RXm6n/WBMGiQae1CvmnHDzB7wzvVtDCx7I7V+pixnj7zB48fJyvBxpSZEhE7vxo6+cVFZy11oBLKYITbhTTUoaJM8b0akJgeW67SrPV6e339BLK1YlJpzkrNBQ1wSebCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1IQuqdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1IQuqdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E811F00A3A;
	Tue,  4 Aug 2026 23:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887812;
	bh=plF56YUXi/ke6Rjen2mPijJb17iTCgj8EAWerhBJSW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j1IQuqdArHs9iesZlg2QjCnOE/3fHSz9CGLwjADLQhg7HvYNbyyKsOJNeRCaVLG+M
	 LVO+ej+qUPVd4N9Sjr6HdrFibmkKTOqADbq5H833LmeqW3HYBwBXCfy+DJGtLxeEQG
	 pqL0Sr5t4/45AinnfXdXYjud2VR9+bjHjuSC7AXmNgmG78Re0RuQzmUa70/gpVWuoX
	 6rBMNdoeWq2usKmt0Tz5Xv3Wolq6vrdcjbSYPGdZ0/wSLp9+ImWImL9vENdDLaEKdo
	 GimSq8bqKWwytwVeftXGt2JlaOfZMKxptIimQ3Lq4YWGmLakJR+1/peOGqqOYpZJYs
	 83Zus8idKjXwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/17] KVM: x86: Disable preemption, not IRQs, when
 getting TSC+freq pair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804233923.3504629-14-seanjc@google.com>
References: <20260804233923.3504629-1-seanjc@google.com>
 <20260804233923.3504629-14-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 23:56:51 +0000
Message-Id: <20260804235652.56E811F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `local_irq_save()` with `preempt_disable()` allows hardw=
are interrupts to break the temporal atomicity of clock reads, leading to g=
uest time corruption.
--

--- Patch [13]: [PATCH v8 13/17] KVM: x86: Disable preemption, not IRQs, wh=
en getting TSC+freq pair ---
commit a5cd5356feb83302b6464039e18ebbb2f4d759f9
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair

This commit replaces local_irq_save() with preempt_disable() in
kvm_guest_time_update() when reading the TSC and frequency pair. The
intention is to avoid overkill IRQ disabling, as preemption disabling is
sufficient to prevent task migration across CPUs during get_cpu_tsc_khz().

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fa00799ba13da..e0e8c6883b831 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1805,11 +1804,14 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
>  		}
>  	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
> =20
> -	/* Keep irq disabled to prevent changes to the clock */
> -	local_irq_save(flags);
> +	/*
> +	 * Ensure reading the TSC+frequency pair is done on the same CPU.  When
> +	 * NOT using the master clock, the TSC frequency may vary between CPUs.
> +	 */
> +	preempt_disable();
>  	tgt_tsc_hz =3D (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
>  	if (unlikely(tgt_tsc_hz =3D=3D 0)) {
> -		local_irq_restore(flags);
> +		preempt_enable();
>  		kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
>  		return 1;
>  	}

[Severity: High]
Could replacing local_irq_save() with preempt_disable() allow hardware
interrupts to break the temporal atomicity of the fallback clock reads?

If KVM falls back to the non-master clock path just below this code,
host_tsc and kernel_ns are read sequentially:

        if (!use_master_clock) {
                host_tsc =3D rdtsc();
                kernel_ns =3D get_kvmclock_base_ns();
        }

If an interrupt fires between these two reads, it would cause kernel_ns
to be sampled later than host_tsc.

Could this inflated kernel_ns then falsely trigger a catch-up adjustment
later in kvm_guest_time_update():

        if (vcpu->tsc_catchup) {
                u64 tsc =3D compute_guest_tsc(v, kernel_ns);
                if (tsc > tsc_timestamp) {
                        adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
                        tsc_timestamp =3D tsc;
                }
        }

and permanently advance the guest's TSC offset or cause temporary time free=
zes?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804233923.3504=
629-1-seanjc@google.com?part=3D13
