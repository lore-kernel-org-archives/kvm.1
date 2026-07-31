Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCDD36A343
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540264; cv=none; b=WRrbYgG6+VbYVcNYbIR2nkY4TO789ZqWznH6LSgGpfM/ZIe7XPz01aNlj8funnJ7gFx2I1x7GjCd60I1kb9PjSxspzS39AWXEPItc9eRSnsRVo464NMNl0kJ7EoPYCFSASvwGjnFlRWbag5R8RBYRJU+VU1Dnq62Vur68WYYDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540264; c=relaxed/simple;
	bh=58Te/+tOkv6LXXdsGaDB5qVdhgpv8m07P5AoW0v8c68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qtC41w7rtTzSaPxZcZqlxSdhutY79pw/t9y5/ghtkteze08dgDJ8cNEWZfRkrSOBi0pjwUP9IfErZmZ96zu8fsKPclNbPt88CxV03rQWo7QkJ4idaFzgvgdckywoLGgJbwtbf7qebElNFPdm/UstgTQaV/TZ0xXVvEP2a2dw5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q6/1KJVr; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6/1KJVr"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so3557575a91.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785540261; x=1786145061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fun1HisIe61fwc36HWwP0mEpqtzKSpu6BfRxhF/FWAM=;
        b=q6/1KJVrIcQq7HZ8Izyn8hHdR2/rDr3BqD8DMrCRuKMaik5izzE9bOvK3C8BE0chLE
         ZUwMb/p+7MWpaTRDh/pGB+QK26ERJggAMa+eAcDWOvVOcosqLHN7nLCUrgOKb4zF4cIO
         coyBDjWuMml8v61Ftm50glPUmTAbeTAfaBsbSrxOqKXIeKTltMnZOU7wK7oZlDBC0Lrb
         hsb9jRA7KNR/+jCW/2Waxf93K8FaUdPJC/Z2XaGQymGYfpB+W3X1e3cbXPhyVvCyP67K
         iCv9gvDPkq4+I/GzsWDTxYtJPT3yihXNMEy+n5qG6b5rlD1Q6OprFQaf/Ccf6dLW7VGe
         NB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785540261; x=1786145061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fun1HisIe61fwc36HWwP0mEpqtzKSpu6BfRxhF/FWAM=;
        b=VIZwRIPQPQn22y7UviNlP2jkhF7CwTq9rE0LHUALRHqfBaBZSBvgJn6KJ3z/S4oDn0
         uY30szau9ssBhwMuRWV2zxZFzd26LVMUJQfbzjUF61nvLX58+Ru58oYl0R/myeZJmAdD
         ipTGrfi8CdfFQuwLz/7D8R65omckXdRbsU4BS3xWGq0EnRNeM+TC8pRo24Qk+DUZ0Sb2
         i2Nf++9UITLKmqGPAgqIcKn7wZBr828lRbESBv/u72A9MS2pMCfWmCOZv4vf4TZHDOYz
         jm1NDp9X1WQ1Y6l1YHfU23LdR5zSa49i3UH+p/8qeAT/VegKhBWO2R00YinFUZMvZD09
         yLvg==
X-Forwarded-Encrypted: i=1; AHgh+RpeDh4x/DOensRawlD4oUDeCrObVXfRe+tTyjpmcjXkFYtzxyfnpuz24EmHwC6dmS2pkG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynfw4xblz2OOW2lcfItg9k14tzKVMFWDF9AmwI22fdmPbLRrSk
	G2XsSwjOWTNLwFQSDOqIIFgfeZsjVm4khyRbZ0b59QWFqnXr+TnnR9YQTMNCvx58D2YJ2fmBGYd
	Ab4zmCw==
X-Received: from pjbms10.prod.google.com ([2002:a17:90b:234a:b0:38e:b9dd:4f3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b02:b0:38e:bbf1:de34
 with SMTP id 98e67ed59e1d1-38fbc3e7e39mr1464539a91.7.1785540261077; Fri, 31
 Jul 2026 16:24:21 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:24:20 -0700
In-Reply-To: <20260728144954.355376-32-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org> <20260728144954.355376-32-dwmw2@infradead.org>
Message-ID: <am0upFND1r93HPxq@google.com>
Subject: Re: [PATCH v7 31/36] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5c78dd1e4c69..0680332d7d45 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3435,6 +3435,169 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
>  	}
>  }
>  
> +#ifdef CONFIG_X86_64
> +static int kvm_vcpu_ioctl_get_clock_guest(struct kvm_vcpu *v, void __user *argp)
> +{
> +	struct pvclock_vcpu_time_info hv_clock = {};
> +	struct kvm_vcpu_arch *vcpu = &v->arch;
> +	struct kvm_arch *ka = &v->kvm->arch;
> +	unsigned int seq;
> +
> +	/*
> +	 * If KVM_REQ_CLOCK_UPDATE is already pending, or if the pvclock
> +	 * has never been generated at all, call kvm_guest_time_update().
> +	 */
> +	if (kvm_check_request(KVM_REQ_CLOCK_UPDATE, v) || !vcpu->hw_tsc_hz) {
> +		int idx = srcu_read_lock(&v->kvm->srcu);
> +		int ret = kvm_guest_time_update(v);
> +
> +		srcu_read_unlock(&v->kvm->srcu, idx);

		guard(srcu)(&vcpu->kvm->srcu);

		if (kvm_guest_time_update(v))
			return -EBUSY;

> +		if (ret)
> +			return -EINVAL;

This should be -EBUSY, because KVM_REQ_CLOCK_UPDATE is a transient condition.
And that's why a capability is needed: if userspace goes with the "probe" method,
it could get a temporary failure, and then a naive userspace could stop using
the ioctl entirely.

> +	}
> +
> +	/*
> +	 * Reconstruct the pvclock from the master clock state, matching
> +	 * exactly what kvm_guest_time_update() writes to the guest.
> +	 */
> +	do {
> +		seq = read_seqcount_begin(&ka->pvclock_sc);
> +
> +		if (!ka->use_master_clock)
> +			return -EINVAL;

EINVAL also feels wrong, userspace hasn't done anything wrong.  Maybe -ENODATA?
Not sure what the right returnis.

> +
> +		hv_clock.tsc_timestamp = kvm_read_l1_tsc(v, ka->master_cycle_now);
> +		hv_clock.system_time = ka->master_kernel_ns + ka->kvmclock_offset;
> +	} while (read_seqcount_retry(&ka->pvclock_sc, seq));
> +
> +	hv_clock.tsc_shift = vcpu->pvclock_tsc_shift;
> +	hv_clock.tsc_to_system_mul = vcpu->pvclock_tsc_mul;
> +	hv_clock.flags = ka->all_vcpus_matched_tsc ? PVCLOCK_TSC_STABLE_BIT : 0;
> +
> +	if (copy_to_user(argp, &hv_clock, sizeof(hv_clock)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/*
> + * Reverse the calculation in the hv_clock definition.
> + *
> + * time_ns = ( (cycles << shift) * mul ) >> 32;
> + * (although shift can be negative, so that's bad C)
> + *
> + * So for a single second,
> + * NSEC_PER_SEC = ( ( FREQ_HZ << shift) * mul ) >> 32
> + * NSEC_PER_SEC << 32 = ( FREQ_HZ << shift ) * mul
> + * ( NSEC_PER_SEC << 32 ) / mul = FREQ_HZ << shift
> + * ( NSEC_PER_SEC << 32 ) / mul ) >> shift = FREQ_HZ
> + */
> +static u64 hvclock_to_hz(u32 mul, s8 shift)
> +{
> +	u64 tm = NSEC_PER_SEC << 32;
> +
> +	/* Maximise precision. Shift right until the top bit is set */
> +	tm <<= 2;
> +	shift += 2;
> +
> +	/* While 'mul' is even, increase the shift *after* the division */
> +	while (!(mul & 1)) {
> +		shift++;
> +		mul >>= 1;
> +	}
> +
> +	tm /= mul;
> +
> +	if (shift >= 64)
> +		return 0;
> +	if (shift > 0)
> +		return tm >> shift;
> +	if (shift <= -64)
> +		return 0;
> +	return tm << -shift;
> +}
> +
> +static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __user *argp)
> +{
> +	struct pvclock_vcpu_time_info user_hv_clock;
> +	struct kvm *kvm = v->kvm;
> +	struct kvm_arch *ka = &kvm->arch;
> +	u64 curr_tsc_hz, user_tsc_hz;
> +	u64 user_clk_ns;
> +	u64 guest_tsc;
> +	int rc = 0;
> +
> +	if (copy_from_user(&user_hv_clock, argp, sizeof(user_hv_clock)))
> +		return -EFAULT;
> +
> +	if (user_hv_clock.pad0 || user_hv_clock.pad[0] || user_hv_clock.pad[1])
> +		return -EINVAL;
> +
> +	if (!user_hv_clock.tsc_to_system_mul)
> +		return -EINVAL;
> +
> +	if (user_hv_clock.tsc_shift < -31 || user_hv_clock.tsc_shift > 31)
> +		return -EINVAL;
> +
> +	user_tsc_hz = hvclock_to_hz(user_hv_clock.tsc_to_system_mul,
> +				    user_hv_clock.tsc_shift);
> +
> +	kvm_hv_request_tsc_page_update(kvm);
> +
> +	/*
> +	 * kvm_start_pvclock_update() takes tsc_write_lock and opens
> +	 * the pvclock seqcount; kvm_end_pvclock_update() closes both.
> +	 * All clock state modifications between them are atomic with
> +	 * respect to readers in kvm_guest_time_update().
> +	 */
> +	kvm_start_pvclock_update(kvm);
> +	pvclock_update_vm_gtod_copy(kvm);
> +
> +	if (!ka->use_master_clock) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	curr_tsc_hz = (u64)get_cpu_tsc_khz() * HZ_PER_KHZ;
> +	if (unlikely(curr_tsc_hz == 0)) {
> +		rc = -EINVAL;

Same comments here regarding return codes.

> +		goto out;
> +	}
> +
> +	if (kvm_caps.has_tsc_control)
> +		curr_tsc_hz = kvm_scale_tsc(curr_tsc_hz,
> +					    v->arch.l1_tsc_scaling_ratio);
> +
> +	/*
> +	 * Allow for a discrepancy of 1 kHz either way between the TSC
> +	 * frequency used to generate the user's pvclock and the current
> +	 * host's measured frequency, since they may not precisely match.
> +	 */
> +	if (user_tsc_hz < curr_tsc_hz - 1000 ||
> +	    user_tsc_hz > curr_tsc_hz + 1000) {

I don't follow, why is KVM restricting what frequency userspace can set?

> +		rc = -ERANGE;
> +		goto out;
> +	}
