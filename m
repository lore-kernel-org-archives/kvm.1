Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7D3B960F
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780746; cv=none; b=Ds45aiFcmVzlXgHoquEMSI68HodQYNjHY9IDRtqr77bluJm+XBo7aaTeZZinzJTXYUcv6apmB4Hjig0UtsxvWvwSTSFiJPV2nUE1lOTHVK90oh2BotPV2Sz2xziVOBJQqY5IBjh9dsV2t6t60qADX2/oonQlUGXNBFt9sNUQ6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780746; c=relaxed/simple;
	bh=CYAPXrcSmsE3gWDLmTOHslKiv1fOruFSmaxBF5GFuiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcZI6lxzF0nn+18ZVwpDAz3j/k42L8urG/220unGUW1X/QaBrjoxeF6EOU36yAmLZTymdrS3dTB+WFKa2UiF0AZ0qHjNWAoGXXG8vhvNYY6KjNIxzj1udRPQ+cLsmEz5Sbv8biwmsrNT6JULq3mx5PergAgnAOIa0OAFNHGb64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzCxE+WB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzCxE+WB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF0D1F000E9;
	Wed, 26 Aug 2026 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780745;
	bh=egPkWkDa+qBvPBYsCBOD1JFmLMvY0l1WzvJ5W4K01lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KzCxE+WBya+4hi/Tcl/+W43IVgaydb1mfqPtqp/IFKbjoZLOAJPSKpeXs6lcyGKRM
	 e4YtOK4aFMz+hyUbm/V454nNnqO9kdxRppQRdW+WF6GVhyF8tEXX+vy2ZUC/ZIIshD
	 bv+xkqZg1aEexNgcTUxcZlrIx85XqUXSDqAy6gYI+RX2Jj/MJxmYxkTB0n3zZPyV9x
	 u1oaRnZED9K1ml70Q2g3ANxjLmW9fAU1lcBUsvczKKBCUHCUIMWXmndXi1vTAXZdMF
	 FpytJSZMSYU7zcj1vYQ845eDWMIhr+yeBmw0jQ2thyqkWdK07qkfOe1PfO0fMWW6vk
	 QJCipk9a8mNSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/21] KVM: x86: Disable preemption, not IRQs, when
 getting TSC+freq pair
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826213303.914988-15-seanjc@google.com>
References: <20260826213303.914988-1-seanjc@google.com>
 <20260826213303.914988-15-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 21:45:44 +0000
Message-Id: <20260826214544.CEF0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `local_irq_save()` with `preempt_disable()` allows inter=
rupts to occur between reading `host_tsc` and `kernel_ns`, causing the gues=
t clock to abruptly jump forward.
--

commit 905bf0112d20298ccaf2fcc14bf1871e4d77ff84
Author: Sean Christopherson <seanjc@google.com>
Subject: KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair

This commit replaces local_irq_save() with preempt_disable() when reading
the TSC and frequency pair to update guest time. The commit message notes
that disabling IRQs is overkill for task migration protection.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -1824,11 +1823,14 @@ int kvm_guest_time_update(struct kvm_vcpu *v)
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
Does this replacement of local_irq_save() with preempt_disable() expose the
fallback clock path to an interrupt latency race?

Because preempt_disable() does not disable hardware IRQs, it appears an=20
interrupt can now fire between reading host_tsc and kernel_ns:

kvm_guest_time_update() {
    ...
    if (!use_master_clock) {
        host_tsc =3D rdtsc();
        <-- hardware interrupt fires here
        kernel_ns =3D get_kvmclock_base_ns();
    }
    ...
}

If an interrupt occurs between these two reads, kernel_ns will be captured=
=20
after the interrupt completes. Would this artificially inflate the kernel_n=
s=20
value relative to the exact moment host_tsc was captured?=20

It looks like this could cause the elapsed interrupt time to be double-coun=
ted=20
(once in kernel_ns and again when the guest calculates elapsed time since=20
host_tsc), causing the guest clock to abruptly jump forward by milliseconds.

While later patches in this series update the use_master_clock path to use
the atomic ktime_get_snapshot_id(), it seems this !use_master_clock fallbac=
k=20
path remains exposed to this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826213303.9149=
88-1-seanjc@google.com?part=3D14
