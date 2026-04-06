Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1B390218
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498369; cv=none; b=HliWvX2XxctUFkeQP/QV8B34GenlnXwH5peJffEAqkhWcub3vPqVnBVVxjjTjBUXrWe2CL84kXf0yc0gI62VCk0/2F3FT1YA+j/gEimJdcK4QgGoAVVFyyAahOgoMTAb6osE817IXkDAAon5OLye4wYFfyUnp138SU33aMTvR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498369; c=relaxed/simple;
	bh=K7QUyorWgJ1bt/io0zMKMx3F/m5DdiP3gvFGZ8CTS3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3n2hz+GJM0X88aOYEczPOswJSrnM+2OXNOR5ys8GUTXTQkV8MxyINxUUlA0HF78fXodcf5CwW7Pv+86eUJ/erELi2h3nvP2QnW9vYGHoHik86uhSWIiu+wJciSaUk7Y6bouMXNgZ8jdDRzm4Vd9RORKQQP2FEtOhVUYsreXDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+Gwcd+C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+Gwcd+C"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso8375424a91.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775498362; x=1776103162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8un0IEjBMxtnZYDO+jKaIXeNdgwpHrOxZMgG/O9GlLg=;
        b=U+Gwcd+CabsZluNkvLO+XjvCc18ngJXAvRCn1N38Qkvjckzkcy7b/h3lrbIZX7sOX5
         IhM+SK7tVo3i7mUoxeDDpT8MwOEJlKzwS/NamcS+OJZMBOkfEZcVP69SmT9rlGfXvzXl
         gFxfE3nvToz9zJg0x2AIaFwKxEk0z4vPboHhE29OSHuvesMckZCo7WoH2k1qR49trvPT
         Sp+D/NDzyJ29obWt1is/aSK7+oZLUPdD8IH89i/f+FcDhGJv6PhJp9cTexIieskX6jsz
         KXXDOWQPXDO930CSq6rw2PyHaO8P5MwPwVGrAkZmPOXdBnmZYQxOvOLGrW1+jWoqMHfE
         ddnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498362; x=1776103162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8un0IEjBMxtnZYDO+jKaIXeNdgwpHrOxZMgG/O9GlLg=;
        b=r/aFcLDu0i9TkkFicGmk3W8CLR6r5Sxs1vmrwmqvC/376WP8NH1Zy3b+2CcEuL3nOt
         cDYeChZuZoqCa/OVpXkFeow5BqXoIButOMxNxptTcZqPQFqte7v1MIagepYm2uaWpbQT
         UxhObookLD3OWVlCsMACSgmiH/687+lQdrKmk77Ve1wXh0BXZDQmxpZBsHbLRk3npPH6
         qKx4iqmNOwiSNmMDoKlsB33JXtcYT+vfOZtq5XvO1cZpAaFLuIzc3kCqhTqmHNIVrCy/
         UKGMtWJOJq+L0/ApBXG+mPAeKeNRr+o3tQ+Cthioa8k3wKlEb3wR5I0icw+4YVYz0wud
         09xw==
X-Forwarded-Encrypted: i=1; AJvYcCUnPNI7HgU/Oq++CsN/yEB39xvbHBMFCp4sthBn+9i3ptalimRtVAxNMQhCgQHAAjUVjPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXoVZmUCK0IpPccTyR4q86Bryg95B4OURCFuD3+LBfGtR+EPR
	ysnp5b1q7/7Mrwyh3+i/TP9HRE65oPJAlf/WYC7iwyJL+PWkaec/Qu5pI7yx0n5Us3z6nwtdyXj
	canJjUQ==
X-Received: from pfch7.prod.google.com ([2002:a05:6a00:1707:b0:829:7245:b797])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958e:b0:39c:2b9d:93ae
 with SMTP id adf61e73a8af0-39f2f1ae00dmr12997024637.60.1775498362325; Mon, 06
 Apr 2026 10:59:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:59:20 -0700
In-Reply-To: <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-4-freimuth@linux.ibm.com> <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
Message-ID: <adP0eA7dBlS4B6gl@google.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
From: Sean Christopherson <seanjc@google.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com, 
	imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 06, 2026, Matthew Rosato wrote:
> On 4/6/26 2:44 AM, Douglas Freimuth wrote:
> > S390 needs a fast path for irq injection, and along those lines we 
> > introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> > the global work queue as it does today, this patch provides a fast path for
> > irq injection.
> > 
> > The inatomic fast path cannot lose control since it is running with
> > interrupts disabled. This meant making the following changes that exist on 
> > the slow path today. First, the adapter_indicators page needs to be mapped
> > since it is accessed with interrupts disabled, so we added map/unmap
> > functions. Second, access to shared resources between the fast and slow 
> > paths needed to be changed from mutex and semaphores to spin_lock's.
> > Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> > but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> > these enhancements were required to prevent blocking on the fast inject
> > path.
> > 
> > Fencing of Fast Inject in Secure Execution environments is enabled in the
> > patch series by not mapping adapter indicator pages. In Secure Execution
> > environments the path of execution available before this patch is followed.
> > 
> > Statistical counters have been added to enable analysis of irq injection on
> > the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> > io_set_adapter_int and io_390_inatomic_adapter_masked.
> > 
> > Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> 
> 
> Sashiko complains about PREEMPT_RT kernels and spinlocks being sleepable
> in this case which would break the whole point of kvm_arch_set_irq_inatomic.

Just make it a raw spinlock so that it stays an actual spinlock.

> I suspect actually the kvm_arch_set_irq_inatomic() call itself shouldn't
> be used in this case, or in other words it wouldn't be an issue with
> just this s390 implementation but rather all of arch implementations?
> 
> I did not try enabling it and running a test, but I did do some
> searching of the codebase and I can found at least 1 spinlock acquired
> somewhere along the inatomic path for the existing implementations...
> 
> longarch (pch_pic_set_irq)

I doubt anyone runs PREEMPT_RT VMs on LoongArch at this point.

> arm64 (vgic_its_inject_cached_translation)

Uses raw.

> powerpc (icp_deliver_irq)

Presumably arch_spin_lock() is also a "raw" version?  PPC KVM is barely maintained
at this point, so I wouldn't worry much about it.

> riscv (kvm_riscv_aia_aplic_inject)

Uses "raw".

> For x86 I didn't find a spinlock -- maybe I didn't look hard enough! --
> but I did find a path that uses RCU (kvm_irq_delivery_to_apic_fast)
> which AFAIU would also become preemptible under PREEMPT_RT.

This isn't about becoming preemptible per se, it's about non-raw spinlocks
becoming sleepable locks.  RCU can be made preemptible, but rcu_read_lock()
doesn't become sleepable.

> So for this series it seems reasonable to me to proceed as-is, with an
> open question whether there should be a KVM-wide avoidance of
> kvm_arch_set_irq_inatomic() under PREEMPT_RT?

s390 should use a raw spinlock, same as arm64 and RISC-V.
