Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77830E82C
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780941565; cv=none; b=FWWoimahRl43I8IHe3xdslcVJM+DjAIAAr9sZWoLo0+4KX1Z0uY4Az1YiLKTllIGvkLGwwjpeBbHtHwZuHiNXGlidS9IA7duMnVk8xCKPdqDkQ/HFYKYeNFhuxo1QR1FkiAfwM7PORpNAgcf0OAoHU7oYcedEooqZElZjlhVBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780941565; c=relaxed/simple;
	bh=O4uprqeGuV0T/9+4h/PtrHSAHnY5qDjV6kaltl/KQ5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IxKMg8uNXO7p2+1t2gctHqw3wv2aF3Ht1GVHQZs6UFqYeVhynxudbPM+Ugtgl3vNqty4vZF6n7+sSGcQfQvb1K5y3BXzb3muQC+X5RQ76SGiGBJNDPK4UzkscLW56sbMRQPIM19noHl+6mXVdsbcYDNa43uSQxmNcZ2jvQAgfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBc1ToyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBc1ToyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDE1F00893;
	Mon,  8 Jun 2026 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780941564;
	bh=uxl1t0ztGPpTadkVWw9i0tG6kK88yPi2fzZbtKpUtNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EBc1ToyMJkHLV/yPI2XS7ovOVwgiR8QvG/BnppyrAJ2fI7+rqmtgtlKukRg9VGrw1
	 sPq2XJ9gu9hoLwq4/4VoMDkLt0nFZpWRYFts0m6ejABo7udSb5wiPqugsjrc3UoE9d
	 ah9mCnC2S2OrSjURK2fqXDHp7L0ka3q1R5QpXYUKG074DD+JpST+lAREx2A16mxWDs
	 etVbv45PCNtoyfPgkhPpF6E41V/vOXfw9AERYzwdrPnz7n4iz1Xne0MmZtchSlqGvh
	 3899rBME0eCGtIHbgy9IPXd/97qcOUxBf12hFIbNhEK75rjNxLsbqNghcKsA+dLok8
	 Ta2Sx7h6gS1cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/34] KVM: x86: Fix compute_guest_tsc() to handle
 negative time deltas
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-15-dwmw2@infradead.org>
References: <20260608145455.89187-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 17:59:23 +0000
Message-Id: <20260608175924.0FDDE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe unsigned comparison in `kvm_guest_time_update` defeats the =
monotonicity guard when `compute_guest_tsc` mathematically wraps below zero.
- [High] `__pvclock_read_cycles` passes a wrapped negative delta to `pvcloc=
k_scale_delta()`, resulting in a wildly corrupted scaled clock offset.
--

commit 2283f250a7b73885318539a7dbf8a833e3f3f4ce
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: handle negative deltas in compute_guest_tsc()

The compute_guest_tsc() function computes the guest TSC at a given
kernel_ns timestamp. When the master clock reference point is earlier
than vcpu->arch.this_tsc_nsec, the delta wraps to a huge positive number.
This commit handles negative deltas explicitly by negating, scaling,
and subtracting from this_tsc_write.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fc9366b83912..8aae22401046 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2588,11 +2588,21 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu,=
 u32 user_tsc_khz)
> =20
>  static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)
>  {
> -	u64 tsc =3D pvclock_scale_delta(kernel_ns-vcpu->arch.this_tsc_nsec,
> -				      vcpu->arch.virtual_tsc_mult,
> -				      vcpu->arch.virtual_tsc_shift);
> -	tsc +=3D vcpu->arch.this_tsc_write;
> -	return tsc;
> +	s64 delta_ns =3D kernel_ns - vcpu->arch.this_tsc_nsec;
> +	u64 tsc;
> +
> +	/* Handle negative deltas gracefully (master clock ref may be earlier) =
*/
> +	if (delta_ns < 0) {
> +		tsc =3D pvclock_scale_delta(-delta_ns,
> +					  vcpu->arch.virtual_tsc_mult,
> +					  vcpu->arch.virtual_tsc_shift);
> +		return vcpu->arch.this_tsc_write - tsc;

[Severity: High]
This isn't a bug introduced by this patch, but does this incomplete fix exp=
ose
a logic error in the caller when the subtraction mathematically wraps below
zero?

If this_tsc_write is smaller than the scaled tsc (for example, if the guest
recently wrote 0 to the TSC), the return value wraps to a huge unsigned u64.

In the caller kvm_guest_time_update(), we see this unsigned comparison:

arch/x86/kvm/x86.c:kvm_guest_time_update() {
    ...
    u64 tsc =3D compute_guest_tsc(v, kernel_ns);
    if (tsc > tsc_timestamp) {
        adjust_tsc_offset_guest(v, tsc - tsc_timestamp);
        tsc_timestamp =3D tsc;
    }
    ...
}

Because the wrapped negative tsc appears as a huge positive number, this
evaluates to true. adjust_tsc_offset_guest() is then called with the wrapped
value, forcing the guest TSC to leap backwards.

Can this break the strict monotonicity guarantee and cause time anomalies or
guest kernel panics?

> +	}
> +
> +	tsc =3D pvclock_scale_delta(delta_ns,
> +				  vcpu->arch.virtual_tsc_mult,
> +				  vcpu->arch.virtual_tsc_shift);

[Severity: High]
This isn't a bug introduced by this patch, but does __pvclock_read_cycles()
suffer from the exact same scaling corruption?

When __get_kvmclock() calls __pvclock_read_cycles(), it uses rdtsc() for the
local TSC and ka->master_cycle_now for the timestamp:

arch/x86/kvm/x86.c:__get_kvmclock() {
    ...
    data->clock =3D __pvclock_read_cycles(&hv_clock, data->host_tsc);
    ...
}

If the local CPU's TSC is slightly behind the CPU that recorded the master
clock due to normal cross-CPU TSC skew, tsc < src->tsc_timestamp can occur:

arch/x86/include/asm/pvclock.h:__pvclock_read_cycles() {
    ...
    u64 delta =3D tsc - src->tsc_timestamp;
    u64 offset =3D pvclock_scale_delta(delta, src->tsc_to_system_mul,
                                     src->tsc_shift);
    ...
}

This causes delta to mathematically wrap to a huge unsigned number, which is
then passed directly to pvclock_scale_delta().

Could this produce an astronomical clock offset that gets returned to
userspace via the KVM_GET_CLOCK ioctl?

> +	return vcpu->arch.this_tsc_write + tsc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D14
