Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E71A3C65F2
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631994; cv=none; b=ap5gUc4nwUs7OVxAdc2W10NMyExfCSoMQfAsEt6aUox8wUqG2ksOsQ4CWqAuQnzo3oiZ9CwvANij1CAFNAn8HOxebfqsUy+n1b+LnOkjibG4nUnrosVYGbJec9VFZ55vERulU9xRBGE4bda71hpFQ7xO/XIAVNkXn8TFaBKAjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631994; c=relaxed/simple;
	bh=lLdwQpDTcPOWBVReltKAfchd1iqm/kq2ztbfmzrjYVs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cN4h2UT6BkF1nUty91AJRkudLy2DPm6LQjJApmDNt/YQaN/kJyJ/Rwv403/BmweMlgTa2V7Q9mFkXOvVInZ5E6eg4VDuyVt/n7fqG/y5fj9mLJeSZ/wvvrGoujLBTbf7cnDkEDXt2I9Yc/8lszoQUofX8HHH+rjU2ylc+WZ9ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfMpsCm0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfMpsCm0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6b7c75550so2483095ad.2
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781631993; x=1782236793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nmo0xgaFEu9Qka/xs6PV8EIWbCG7nAbJ7f7XgGDPyM=;
        b=OfMpsCm0mN+prlDM62M9kNdyoJyHhCprz0BfxVnNwe8mFHCCSkkQjxEp5YKiJ2gwvt
         kAXWyhcJ10HZJNeViI0lNZuzahFrb1sUKwlJaij7ulKvneI45lxbxWoIWgEOMFn7vJM8
         wTb8QzKU+AcwdEdzrGQjxh+unfo/D6tFsg59hQKcQaJIiDQReoami6gIPJ2qWMmQ72O3
         qyUiX5ZKqDIs1lnIklNKXw7l3mOOfd1+W2Zx4lSmqVZcL2pzPYz/XCHqvMUz9vjEt7Kw
         1k+B8RiuuLWhAn/WfmrLyKMS960hhpAa5MAxsx+LAvFuz+al7FJVCj8VqaDd4urad5vf
         yLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631993; x=1782236793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nmo0xgaFEu9Qka/xs6PV8EIWbCG7nAbJ7f7XgGDPyM=;
        b=bfG7IT94BDpfgi61u2jHCSxnJP7vTs7GqKNn4wOhoiOBHghtkIea78LXzxwQYqRtdR
         Nnwov0XWVjJ8lZRYcKmMoalIMAGgKtgMhXAsdMbTqRhYZrKP8+Gs1GRIkuvKSwAh1N51
         Mt2xTBqsyiMbR8+cJl+D2EQ3OAajCThYFUbdkqeLou6xtLBOBWFy47oyM7Ffpn7f4lMn
         iqZSu+pMMVSXJgAVmg8kPJfaNADdCB/K5xbdhJI9dmRkEX1f8GaTD9mIx1Oou4lRC8/5
         ZTLIDklif3l9MoECoUvpmnHjUft6idhKrDnHgIZOZX08zbPVDW+luYY7GH4Kgrx252oY
         zvMg==
X-Forwarded-Encrypted: i=1; AFNElJ+1v44hAfGnHFNUSu7uC59QfkDeKo6ig2C4hqkj58KctxkeescK0BVszXVA0PqLS9wABhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIf73zl+b5DWoDM8bLb5s6mQJwcpuGYY+19XqaB6p6O0DPe5Cd
	WpMZbxtF8OG/cmnCglg+Xrat6MGDvxUAoeCDzjfkRNGKem+YRfbfz4+Q6x/5VNNPgA+EKcB3KPI
	Wr6oIXg==
X-Received: from plbli14.prod.google.com ([2002:a17:903:294e:b0:2c0:a7f8:c132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f610:b0:2b2:67ca:5ff9
 with SMTP id d9443c01a7336-2c6bbcae428mr1042675ad.0.1781631992468; Tue, 16
 Jun 2026 10:46:32 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:46:31 -0700
In-Reply-To: <CAO9r8zNFk287zeB+0nrUvcCqpn-wi3CZo6t-9COQGkdd3POzMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com>
 <ajA1xaafH-IkuugD@google.com> <CAO9r8zNFk287zeB+0nrUvcCqpn-wi3CZo6t-9COQGkdd3POzMg@mail.gmail.com>
Message-ID: <ajGL95j_Z3ynCUAy@google.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> > > The code makes sense to me but I am trying to make sense of the changelog.
> >
> > What part (parts?) is confusing?  Honest question.  I'm trying to reword the
> > changelog to make it "better", but I'm failing miserable because I don't know
> > what's wrong :-)
> 
> 1. For kvm_vcpu_has_events() being unaffected, the explanation in
> paragraph #3 is focused on the code path from nested_vmx_run() ->
> kvm_emulate_halt_noskip(). I don't immediately see how
> kvm_arch_vcpu_runnable() is unaffected.

To reach kvm_vcpu_has_events(), kvm_vcpu_running() needs to return false.  For
that to happen, vcpu->arch.mp_state needs to be something other than RUNNABLE.

If nested_run_pending is true, then mp_state *must* be RUNNABLE (barring bugs or
stupid userspace), because KVM shouldn't emulate VMRUN/VMLAUNCH/VMRESUME while
the vCPU is !RUNNABLE.  

I didn't include that in the changelog because I thought it was obvious, but
obviously (LOL) not :-D

I called out the GUEST_ACTIVITY_HLT case because (to me) that is less obvious.

> 2. More importantly, paragraphs #3 and #4 read like this patch would
> regress kvm_vcpu_ready_for_interrupt_injection() and
> kvm_vcpu_has_events() if it affected them. Maybe clearly state that
> this patch is the right thing to do for these 2 functions as well, but
> they are more-or-less unaffected by the bug anyway? For
> kvm_vcpu_ready_for_interrupt_injection(), maybe just make it more
> clear in paragraph #4 that it currently incorrectly treats interrupts
> as allowed in the problematic scenario, but it is not a problem
> because ..., and it only results in a spurious exit to userspace (or
> not even that?).

Is this better?

  When querying whether or not interrupts (IRQs) are allowed, check for a
  pending nested run _after_ checking whether or not interrupts are blocked.
  If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs can
  be blocked while running L2, and interrupts will indeed be blocked once the
  nested VM-Enter to L2 is completed, then KVM should treat interrupts as not
  being allowed.
  
  For injection, this avoids an unnecessary (forced) VM-Exit, as KVM can
  immediately request an IRQ window, instead of forcing an exit and _then_
  requesting an IRQ window (because after the forced exit, KVM will see that
  interrupts are blocked).
  
  For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection() is
  affected in practice.  Barring KVM bugs or misbehaving userspace (at which
  point all architectural guarantees are off), kvm_vcpu_has_events() is
  unreachable when a nested run is pending.  To reach kvm_vcpu_has_events(),
  kvm_vcpu_running() needs to return false, i.e. vcpu->arch.mp_state needs
  to be something other than RUNNABLE.  If nested_run_pending is true, then
  mp_state *must* be RUNNABLE (again barring bugs or stupid userspace),
  because KVM shouldn't emulate VMRUN/VMLAUNCH/VMRESUME while the vCPU is
  !RUNNABLE.
  
  The one "near miss" is VMX's GUEST_ACTIVITY_STATE field, which allows L1 to
  put the vCPU into HLT or WFS as part of nested VMLAUNCH/VMRESUME.  However,
  KVM clears nested_run_pending prior to calling kvm_emulate_halt_noskip()
  when putting L2 into HLT via GUEST_ACTIVITY_HLT, and also clears the flag
  before setting mp_state to INIT_RECEIVED.  SVM has no equivalent to
  GUEST_ACTIVITY_STATE.
  
  I.e. the vCPU will always be runnable if a nested run is pending, and thus
  kvm_arch_vcpu_runnable() => kvm_vcpu_has_events() is effectively dead code,
  as is __kvm_emulate_halt() => kvm_vcpu_has_events().  Oh, and TDX doesn't
  support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable as
  KVM shouldn't be faulting in memory with a pending nested VM-Enter.
  
  As for kvm_vcpu_ready_for_interrupt_injection(), KVM's current behavior of
  incorrectly treating interrupts as being allowed could result in KVM
  prematurely exiting to userspace to accept an ExtINT.  But, KVM will still
  hold/block the ExtINT and request its own IRQ window.  I.e. the net effect
  is more or less the same as the for-injection case, the unnecessary exit
  just happens at a different boundary.
