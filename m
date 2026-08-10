Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C03FADF7
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371751; cv=none; b=r7lDnd9sZDay67xnF52Z4DKA9+ceDqVxZRFEylSAhgE0HjKKN1zU0GzRPaRIH1JaL5144a7/myqUSp1yXjj7iF6qhIVZcRHVupPDJR1HJvcUEXvksZZ4mS138+bB3lbPuc/fUyED5IfXWbNMCJ9SOhsKVTLii0g1zNrgVXbbTs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371751; c=relaxed/simple;
	bh=8g8km/C3yIxQynwOX3yaXcIqjAlktfsOY5bFp2UYV6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rOyLxfVNMe00IxtWLYH2gLHATTK0g0gKuo4fd8nJuLL36HHt5hVy4dMAbJer7I0EsCY33K/N2dC7aHTWj3VxYi+qWh4tp0oEixNzeanm712IuU+qWcjx/nSrgcUQjyBcD3ha3CUxRkpdEPVcRXpC6aVFBZ5WAlcEyUtt9vOnDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ngJYVAe3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngJYVAe3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d122bbc621so59713085ad.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786371743; x=1786976543; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vyov84/MoszmkbZl8iei5CYtyOkdDWiwki2+Rn3v4lc=;
        b=ngJYVAe31txSb0DAeSTEE0GyBfVbIA7S89NpvaWCQ0EN7ePJQI7UtiT1WeOSr3IDRN
         pXKdX61jNnrmQ08YM0QVputY2J6d9JkCqRkuneD6pWExzj4rjIvMUKqieP6/APrYEU6M
         e9E8QBBUWCM3fdN2BQQAU+qB2q2g0fKwxvMOZCGjti7cMJbF+UGD7zpU0PV7IHDwEUcG
         IE1c1RI+BCslfFaMnMWGjGZGOVkSPp5Pp25M74g8RT/D5g8BCZGpwYmlFC1vHRz8r5Qb
         rsoaFDBvMJ84nQLlF8n4j9n1QRz138s+W2KWaKdfYqKp64YoxE90AoqdI6tALZxyPlNo
         vShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371743; x=1786976543;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vyov84/MoszmkbZl8iei5CYtyOkdDWiwki2+Rn3v4lc=;
        b=bRvVHtC2CCphg12/V8/zf3SGsEJE1GrhO83zGrhvq38Y5GjDJhY7VtW3x9aXLl28F8
         pPYeUii+TRVK+J1cffpdzYCPZ2tNPAW93sLO09qvfcf3thxXMtSx5A1Fin/3zXZpYZr7
         pWe4TdLKpr+ZMvVk1H79oChY40Do6GOqvs/WcPChC6SCwVE1STzKZ4ZjgCR1Eyoa3Vxy
         w9L7djJlR/Mfy1cwbrGFhwuTxalgO5Sq49GN0ONFoBqKdOOSphCXOXy1b1E/VzOEKI7w
         K9uIT+cdrtDDFEunU7lDDlXEKxMwLiuJkS8HaLgQhAmAWwbXOXwp3rv+E5IvqdkqmO31
         ZAow==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Ma+vlGEX99DR9ULfw71qu754FPSZG7tYW4g1hbOqgDvWLcn1txrZVHV2ICdRs3gCXr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqAfSBNmQrlSuG1jI2CxZkXRXAtca+yyUWKM5+MtlASlH+dkr
	vhtnIWJcqEwXQP75+BkgICsXah6PjBjDjN2w7GMCQaTSHcGH/KXj2GU7Lx8sqE+S9Ge9vfDKJz2
	CiMEWMA==
X-Received: from plbb11.prod.google.com ([2002:a17:903:c0b:b0:2d2:f257:ff6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1847:b0:2ca:d91d:d3a7
 with SMTP id d9443c01a7336-2d294b46248mr294491635ad.10.1786371743067; Mon, 10
 Aug 2026 07:22:23 -0700 (PDT)
Date: Mon, 10 Aug 2026 07:22:22 -0700
In-Reply-To: <7c34aa00b566822c257c52c4b398809354f88bf8.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com> <20260804233923.3504629-6-seanjc@google.com>
 <20260805000221.B63F61F00A3A@smtp.kernel.org> <anN_J_KZhVJ1zIeI@google.com>
 <anUmdhx0Dh-yd89z@google.com> <anYBYu4rx-jCv8gr@google.com>
 <9D3BEB2D-1FC8-4607-BB92-8C26F138985A@infradead.org> <7c34aa00b566822c257c52c4b398809354f88bf8.camel@infradead.org>
Message-ID: <annenh5tqKQ0xWel@google.com>
Subject: Re: [PATCH v8 05/17] KVM: x86: Avoid NTP frequency skew for KVM clock
 on 32-bit host
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 08, 2026, David Woodhouse wrote:
> On Fri, 2026-08-07 at 18:26 +0100, David Woodhouse wrote:
> > (Home and on the phone after an insane week; full attention span
> > might be limited until Monday).
> 
> Hi, my name is Dave and I'm an addict...
> 
> > The only reason the ktime snapshot stuff is last in the series is
> > because I did that work on the kernel's core timekeeping two years
> > after the rest of the series, and it was still sitting at the tip
> > branch at the time so I didn't want to make it a hard dependency for
> > the kvmclock series. Now the timekeeping stuff is merged we can fold
> > it all into the kvmclock series however we like.
> 
> I think that goes for "Compute kvmclock base without pvclock_gtod_data"
> too. It *isn't* at the end of the series, but I'm fairly sure (from
> memory) that it's one of the newer commits, and I just shuffled it
> earlier in the series for very similar reasons to the ones you're
> looking at now.

That's good, because I came to same conclusion last week :-)

This is what I now have locally as "part 1", which I'm planning on posting today.
It'll be too late for 7.3, but if part 1 looks good to you, I'll throw them in an
unstable topic branch for 7.4 so that we can consider them "done" and work on the
remaining patches.

  KVM: x86: Update "last guest TSC" snapshot prior to enabling IRQs/preemption
  KVM: x86: Improve accuracy of KVM clock when TSC scaling is in force
  KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
  KVM: x86: Activate master clock immediately on vCPU creation
  KVM: x86: Compute kvmclock base without pvclock_gtod_data
  KVM: x86: Avoid NTP frequency skew for KVM clock on 32-bit host
  KVM: x86: Drop unnecessary CPU pinning when computing/getting kvmclock
  KVM: x86: Move "no master clock" fallback from __get_kvmclock() to get_kvmclock()
  KVM: x86: Wrap all of __get_kvmclock_master_clock() with CONFIG_X86_64=y
  KVM: x86: Fall back to non-master-clock if clockread fails in get_kvmclock()
  KVM: x86: Fix KVM clock precision in get_kvmclock() with TSC scaling
  KVM: x86: Use get_kvmclock() in kvm_get_wall_clock_epoch()
  KVM: x86: Fix compute_guest_tsc() to handle negative time deltas
  KVM: x86: Disable preemption, not IRQs, when getting TSC+freq pair
  KVM: x86: Make master clock logic in guest PV clock updates 64-bit only
  KVM: x86: Upscale TSC to "now", not master clock when updating PV clocks
  KVM: x86: Simplify and comment kvm_get_time_scale()
  KVM: x86: Remove implicit rdtsc() from kvm_compute_l1_tsc_offset()
  KVM: x86: Use kernel timekeeping snapshots for getting kvmclock time since boot
  KVM: x86: Use kernel timekeeping snapshot for monotonic clock
  KVM: x86: Use kernel timekeeping snapshot to get walltime+TSC
