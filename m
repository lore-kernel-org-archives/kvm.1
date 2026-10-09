Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463B3D1A9A
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791578159; cv=none; b=twneaxe61t5Dqqh5WJkAWj3mL2iajpNezNMnzqzU1JfiQTjWQBIJ+QkZH6dt8egxO7+lnbUYpC44cLdB1assKYQnOGnLRedi31nn02O9omWXsDiZEMdcF1u8eQSmPBYQVXskhl19p2CxythIq98JMfI2n5KORF/65diyzmuiZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791578159; c=relaxed/simple;
	bh=PfTAicrEoNLDkm42IQNl9ACSlpLIoq43+6AwdL4QLtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PbeXtY7DxFm5ywEE7+AQKcK6wnXU2WZ4EsrJyHPpdnVl4/ryzlJxeyQsNoOiWoYtz3EmblNiZVb/mGB1N8CTCFPEX9FGpj9BLG6VAm5SO8d4NejCrJYGVGDuzn6ahv660/rNc54v/qzOsjqYLWRx3eURyGSBofi3bTa1e2q90Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdO//9nc; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdO//9nc"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so181231a91.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791578158; x=1792182958; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUNz7LmSPiGppLW+FVXC0WJz4DIhuCD6pA3Tczcp2kQ=;
        b=WdO//9nc6uIhm9o3uCMdkqSMviZOfBNoznixvAjSU3MuQHLnu3wvwAAZe+15BEIvIw
         ul3kaZ1DqKz79bxrLCUnNOT/nAVLp7vBHyoJrYKlf+DqF2HHA5eInNqV0tZDY6tshT+S
         Qhu9rOol1HHVnEaT3o3Vm9KkKzZyqpvAkWYFmXW7dicnChPMV/dce3r0XwhIAtfgOGyz
         dXNeN7KC88x4GXDDCu3bgjXonNpWeq2MFpf3srt6vy4n0fCjpEQ+nPTBkELP+k6YFWpQ
         Kdl+Q3Dry6szGE6GzycNy6is+2d39yZjscdLTYT+Z6Z9Awd1Hk5QgnpIaX7LyQrTpUPA
         BcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791578158; x=1792182958;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KUNz7LmSPiGppLW+FVXC0WJz4DIhuCD6pA3Tczcp2kQ=;
        b=nXW42T8QX4i6T57v7BoCfewHwP/eGgW/ftwWJUBUdegSPjF9cF3g3xpz5WU+qs7OCs
         uCE1xoEr1tW8uUlSwEnyQ2lUgoIvq9QgtWdvG+pslxc49gAPyNphjj5gdTkgMiJDNj3C
         V394KUwtdKz6vjqqbFBosFUzT4UDfulYfj28fhzfsoGLx4xuojjq2X82mSQp9AlFgmU1
         m1sQx0UAMIPeGJWPVMS90jgo6vzbF5JZsuH0HjAjCrIBI804/jQKhT8u3UIev/dThBVG
         2eDWwh6PONotpWoliScFor5oG2r8AX1z8U6G7CCOOQiLV3E5Pmmcr/0qRQ0PCJpHaZpB
         mzoQ==
X-Forwarded-Encrypted: i=1; AKwUvByRyV0oqyvmq0nnd958ur+iab84/h3ufkUYU+uH+DGqz9via7V97abQifcKuBx5317I5zc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKbtCeN/X065vXXYlEPflPPUY+QNTyS68LOK+LuLbn2HbCcjZrX
	wt0TdVbRYAGg4h+6ObOOovffHbnhVWExWTcV3w0AVnbq03qTrnyBqj2CLi9k8rhQi6ZYtKn+q/V
	jzNartw==
X-Received: from pjbsj2.prod.google.com ([2002:a17:90b:2d82:b0:3ab:4cf:7b95])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1844:b0:3ab:188b:c5bf
 with SMTP id 98e67ed59e1d1-3ab3a955af4mr2571263a91.18.1791578157882; Fri, 09
 Oct 2026 13:35:57 -0700 (PDT)
Date: Fri, 9 Oct 2026 13:35:57 -0700
In-Reply-To: <20261008090037.86931-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008090037.86931-1-flyingpeng@tencent.com>
Message-ID: <aslQLXcK1VXSkrVo@google.com>
Subject: Re: [PATCH] KVM: x86: Guard against division by zero in adjust_lapic_timer_advance()
From: Sean Christopherson <seanjc@google.com>
To: Peng Hao <flyingpenghao@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 08, 2026, Peng Hao wrote:
> When TSC calibration fails and userspace never programs a tsc khz,
> vcpu->arch.virtual_tsc_khz stays zero, but the lapic timer's
> software-mode expiry path still calls adjust_lapic_timer_advance()
> unconditionally on every timer expiration (unlike
> __wait_lapic_expire(), this path is not gated on tsc_scaling_ratio).
> Both the "too early" and "too late" branches do_div() by
> virtual_tsc_khz, so a zero khz crashes the host with #DE as soon as
> the timer advance drifts outside the adjust window.
> 
> Bail out before either division.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 13e32c4915e2..4dcbc66c8e07 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1991,6 +1991,9 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  	    abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_MIN)
>  		return;
>  
> +	if (unlikely(!vcpu->arch.virtual_tsc_khz))
> +		return;

Ugh.  I'd rather reject KVM_CREATE_VCPU, even though there is a rather surprising
amount of code in KVM that does indeed play nice with tsc_khz == 0.  I don't see
how the guest can possibly function with virtual_tsc_khz==0.

vcpu->arch.virtual_tsc_{shift,mult} will also be left as zero (to avoid #DE there
as well):

	/* tsc_khz can be zero if TSC calibration fails */
	if (user_tsc_khz == 0) {
		/* set tsc_scaling_ratio to a safe value */
		kvm_vcpu_write_tsc_multiplier(vcpu, kvm_caps.default_tsc_scaling_ratio);
		return -1;
	}

	/* Compute a scale to convert nanoseconds in TSC cycles */
	kvm_get_time_scale(user_tsc_khz * 1000LL, NSEC_PER_SEC,
			   &vcpu->arch.virtual_tsc_shift,
			   &vcpu->arch.virtual_tsc_mult);

and so nsec_to_cycles() will always return zero due to multiplying by zero.  That
means things like the APIC timer will always fire immediately:

	apic->lapic_timer.tscdeadline = kvm_read_l1_tsc(apic->vcpu, tscl) +
		nsec_to_cycles(apic->vcpu, deadline);

The first instance of this goes back to 03ba32cae66e ("VMX: x86: handle host TSC
calibration failure"), and every "fix" since then has been to avoid #DE.

> +
>  	/* too early */
>  	if (advance_expire_delta < 0) {
>  		ns = -advance_expire_delta * 1000000ULL;
> -- 
> 2.43.7
> 
