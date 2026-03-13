Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0B19E96D
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363746; cv=none; b=htr3ZBu1Plsa2GtxVyiEG/tCLujZsmfGM+Q69JkNb2kELGF2Htx0FsFRTSUpV6OteglTyPOmPNtr1NksVTuMOeA/NdUeQmB3hNV6pwzCVQQXN5cqqfkE6hJIq+2mWylt0sLebYXb2Qv2u2HSHrBcUBGzReJKGOE7QHVVbnTbRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363746; c=relaxed/simple;
	bh=t7SBRthkjnSag9ZHPducZy4771fuu/95E2vZdxDD6lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KglfzFKGUWRrzYlnSZn9nBa7wBoI3xq4tp5++x6JhpKLp6LQcW+ze60PaiP4/FpNlQX8eOx7rRufgLlZ9KjElqf4gIVfwLZFgxjwkENvkTIunBIG85tTubzdLs1+A3/wd1zCI8/ww/hbIZqYTNMOjbdSpo9GRmojfGqJlEDc/5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtCNX1KA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtCNX1KA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829bf6406ecso5108355b3a.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773363744; x=1773968544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0PMjfJj5HOggwaEl4u8ReK/X7vSOv3Nc8M3FyAZ2iI=;
        b=WtCNX1KA30vWxDJcCt3/ZSqcQ5Q43ggf9s+c2Gf5342M542vZPyNpnNEdo1/oxLEo6
         /6ljnG+8lvKl5Hg60VGWnKfbygaisEDjqU+gw2AL0uXpYbCVignTV4hiD8s9qlWmmnWc
         c+nsbejuGeh/EhPUmzg5XeqLOmU8Vwr2HY6o4B5OaEqXgW1pt511zupU+1sRyLDnT5dr
         UuLnXmA4SD/B5rrBHOWrHRoHNHD1yaEf8u5fdBy0QeKwNuh8Sbld/EiwWzdNWEqp1jYf
         k8FBov6I3ApvlhrQABqgoUvXXMbcX9P/w2FH16bqpoqMNf6rcERssWlce/f8x6bAD2cj
         nO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363744; x=1773968544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0PMjfJj5HOggwaEl4u8ReK/X7vSOv3Nc8M3FyAZ2iI=;
        b=qV3uMNXi7rU1DFjyzXDA5+tM37ZMXfhOY0NF5WuvSgk5Vvg5IxG48WRDHRrTvjM8mn
         Pcq3L/d3nwZrwcU9h4JiXiyV87SSlBHDnokE7sBBYlNKVIaixuNQLrEH9TSqgADx+d/M
         kO7NsN8nYMJwTDZhBwW/zZGZTOXcEc+rYVC8PjodbZ2loyByteiqI1Ii5KGc1WMlVAPn
         S0uKqQ7hcbIqN3uilw+X24qvIrckZfbaFGvPuPqZvjX6OSh+fDi+5JEWouDayEVQs7h3
         b/tTpa4r0mHEu/9fPEg3dyxaRAnAIEKje9pyLeAQb5znxBPD5C3RhXhEi9RBq2h6qbiO
         lujw==
X-Forwarded-Encrypted: i=1; AJvYcCUtpY5bJG9WvpTH2MaZvOVDNh6+B2Ca65xuDrKqWVLwPrXSxOiY8CSUzC9Twr2vsWVGZuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwaoFZd553M7Df/UOXNBBa/gK6l11MDmjd5T8r89VoyE9Jq3S
	AGUkay8MHjbyYPTA28CCf74zImGmgqyxOxX03rmMiGvXLiXxIrb8UbWnCmM/+FYQ06vdd4XSud0
	WuUiZew==
X-Received: from pfbbr4.prod.google.com ([2002:a05:6a00:4404:b0:829:880b:b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3389:b0:827:3e19:574a
 with SMTP id d2e1a72fcca58-82a198ec7c0mr1189751b3a.42.1773363743798; Thu, 12
 Mar 2026 18:02:23 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:02:22 -0700
In-Reply-To: <tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215140402.24659-1-76824143@qq.com> <tencent_A1CC0E76805991513AA0C982068255A6A306@qq.com>
 <aZSMFPgRO6s_fUQO@google.com> <tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com>
Message-ID: <abNiHqMe0mqKIsML@google.com>
Subject: Re: [PATCH 2/3] KVM: x86: Skip IN_GUEST_MODE vCPUs in
 kvm_vcpu_on_spin main loop
From: Sean Christopherson <seanjc@google.com>
To: zhanghao <76824143@qq.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, zhanghao <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 12, 2026, zhanghao wrote:
> On Tue, Feb 17, 2026, Sean Christopherson wrote:
> > On Sun, Feb 15, 2026, 76824143@qq.com wrote:
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 476ecdb18bdd..663df3a121c8 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -4026,6 +4026,10 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
> > >  		vcpu = xa_load(&kvm->vcpu_array, idx);
> > >  		if (!READ_ONCE(vcpu->ready))
> > >  			continue;
> > > +
> > > +		if (READ_ONCE(vcpu->mode) == IN_GUEST_MODE)
> > > +			continue;
> > 
> > This should generally not happen, as vcpu->ready should only be true when a vCPU
> > is scheduled out.  Although it does look like there's a race in kvm_vcpu_wake_up()
> > where vcpu->ready could be left %true, e.g. if the task was delyed or preempted
> > after __kvm_vcpu_wake_up(), before the "WRITE_ONCE(vcpu->ready, true)".  Not sure
> > how best to handle that scenario.
> > 
> > > +
> > >  		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
> > >  			continue;
> > >  
> > > -- 
> > > 2.39.2
> > >
> 
> Thank you for reviewing this patch. As pointed out in the discussion,
> this addresses a race condition where kvm_vcpu_wake_up() can set
> "ready=true" while kvm_sched_in() is concurrently setting the vCPU to
> running state. Without this check, we might attempt to yield to a vCPU
> that is already running, which is futile.

Right, but I want to solve this by eliminating the race, not by papering over
the issue in kvm_vcpu_on_spin().  I don't see a sane way of handling the cross-vCPU
writes without atomics, and I'd prefer to avoid the complexity that comes with
that.

What if instead of having the waker set vcpu->ready, we remove it entirely and
instead do a best-effort detection of the "vCPU was blocking, is now awake, but
probably hasn't been scheduled in yet".  We can use a combination of flags to
detect that, and thanks to vcpu->scheduled_out, I'm pretty sure the false positive
rate would be on par with the existing vcpu->ready check (for the preempted case).

The idea is to identify the case where the vCPU is in the blocking sequence, but
not actually blocking, wants to run, and is scheduled out.

Compile tested only (and I don't love the name of the helper).

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b65..ac849d879b73 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10393,7 +10393,7 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
 
        rcu_read_unlock();
 
-       if (!target || !READ_ONCE(target->ready))
+       if (!target || !kvm_vcpu_is_runnable_and_scheduled_out(target))
                goto no_yield;
 
        /* Ignore requests to yield to self */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 581b217abc33..70739179af58 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1746,6 +1746,15 @@ static inline bool kvm_vcpu_is_blocking(struct kvm_vcpu *vcpu)
        return rcuwait_active(kvm_arch_vcpu_get_wait(vcpu));
 }
 
+static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
+{
+       return READ_ONCE(vcpu->preempted) ||
+              (READ_ONCE(vcpu->scheduled_out) &&
+               READ_ONCE(vcpu->wants_to_run) &&
+               READ_ONCE(vcpu->stat.generic.blocking) &&
+               !kvm_vcpu_is_blocking(vcpu));
+}
+
 #ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
 /*
  * returns true if the virtual interrupt controller is initialized and
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9faf70ccae7a..9f71e32daac5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -455,7 +455,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
        kvm_vcpu_set_in_spin_loop(vcpu, false);
        kvm_vcpu_set_dy_eligible(vcpu, false);
        vcpu->preempted = false;
-       vcpu->ready = false;
        preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
        vcpu->last_used_slot = NULL;
 
@@ -3803,7 +3802,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
        if (__kvm_vcpu_wake_up(vcpu)) {
-               WRITE_ONCE(vcpu->ready, true);
                ++vcpu->stat.generic.halt_wakeup;
                return true;
        }
@@ -4008,7 +4006,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
                        continue;
 
                vcpu = xa_load(&kvm->vcpu_array, idx);
-               if (!READ_ONCE(vcpu->ready))
+               if (!kvm_vcpu_is_runnable_and_scheduled_out(vcpu))
                        continue;
                if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
                        continue;
@@ -6393,7 +6391,6 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
        struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
        WRITE_ONCE(vcpu->preempted, false);
-       WRITE_ONCE(vcpu->ready, false);
 
        __this_cpu_write(kvm_running_vcpu, vcpu);
        kvm_arch_vcpu_load(vcpu, cpu);
@@ -6408,10 +6405,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 
        WRITE_ONCE(vcpu->scheduled_out, true);
 
-       if (task_is_runnable(current) && vcpu->wants_to_run) {
+       if (task_is_runnable(current) && vcpu->wants_to_run)
                WRITE_ONCE(vcpu->preempted, true);
-               WRITE_ONCE(vcpu->ready, true);
-       }
+
        kvm_arch_vcpu_put(vcpu);
        __this_cpu_write(kvm_running_vcpu, NULL);
 }
