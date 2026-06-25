Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900426ED4F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401602; cv=none; b=VuTquYCAqinSNLYeNhQZRe+QsS2js3TK5/unPN9FXEGmORrJC+6Tb27SPJismk861/IOUutearuBv2ckI1ocYixREiB6uR/4+psu+rjNRy8Bnzq7TE/VSbgZxCxn6HaTqlm29nqg6EW+9Aq0dr2egU4nJhJqbWjVC26dkc7dGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401602; c=relaxed/simple;
	bh=twFSZimBgVyH1Czznpg2BHM/+Zn9yPSjUlemZ/QSjkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hpvmK/WnF3kB9VlJzDGTZ5PUSHMCd2qSGu0/PJCGgU0AwW4/TYVxNVOkBWjKQlw+lQQYfjTbF/pep0/FjFkieOXWph6jH9I78rsRTYYRwByc7ozCN6w26JOG4R0EsmTsGtnrm2H432JALU09Mq9Mg1ePsRHyXeUTg2HAtkmzdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVc0tWSO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVc0tWSO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1439209a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782401601; x=1783006401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyu6XoCt55ZCvclCSFJHccbxEoC5E9teTwQ5QaNRgyY=;
        b=PVc0tWSOuF6fOIIDOvrKcMoGKDbZWauKyE2nwMks3uTedxrOM5FbH2lpmpHbYUGkNX
         +10KuVxlQVvor3MBqrtPTODZ5AdKFcwG6aBAgNekcVk47Dv9LEQ15PldNDFmwoCB/5sD
         2Kjl3wOThPBvvDGuD2v/w1ckYqYNZPptv/8UzXwrJz7GvFU9cwNj1AnPKB0AsJa53gSy
         NYNTJ1Q4c5oA1x+RfmYpRPujHY10yCe9oSTxMJlgWaXuGSfPFmYknKXq5fkucbG6PA67
         0wc3wAJmUztKPz8CPQ4hQhfm7Jkaqc5TMHkYO0PQ+i2tJ4e/y/cXmx3jhUuJGm9JDhmK
         kcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782401601; x=1783006401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyu6XoCt55ZCvclCSFJHccbxEoC5E9teTwQ5QaNRgyY=;
        b=naXuK++pVxjOLUDwcado6refdSknL1lLa7E5x2EiwADxFtFKATsz4kV5yOhAKB3w7d
         gZYZvFmVNujEEdwPSj3m7g95PwvyoAv2kdnvnXxWRmYuSwCoWI6H0pnxZREOVxtAREAD
         bQ2E8kuaQaNHGJ4cVe6pYNXUw+823hcFVjez9x3nEAFMXezWSB+5OFAJn/dBjOR2Ony9
         Xebbp8P4gKuHpn3J/jUAxbpMb8OMP0Iecmpl9A3T//pi9CgpLI4rvXuy5DM98f21nkrq
         tXNUpT3a4L5od8Uq36IhYbCtnAGKmiLMX0W0byiADcNAINwtpcRoEHn7hPVxfN3im6HZ
         FQbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5tk7jpP0hPHSJZq9wAGO1tzUXGfMbRKZY1CDlyLPpfrpfgz0kQEm5XTU68Hd33fSfIrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDooAiCWUFinf3fTUsei5Zia7nA68kSB0u6e7tkdJvHjN6tW8v
	58PZUzWMRb6KOjRxInQ8m3szl2cDMIxSi0W1s7rrcY5R9CixY56jPkH61tUQCfSOgzrx/VWQFfB
	qqKhWUA==
X-Received: from pfbhu37.prod.google.com ([2002:a05:6a00:69a5:b0:845:6285:73db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2291:b0:837:e9cc:d465
 with SMTP id d2e1a72fcca58-845b3af04b2mr3769179b3a.20.1782401600539; Thu, 25
 Jun 2026 08:33:20 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:33:19 -0700
In-Reply-To: <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com> <c4ce0b3ebc40384afef7895909df3d00370b3e1d.camel@intel.com>
Message-ID: <aj1KP2h49GzfNHFz@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, Kai Huang wrote:
> On Wed, 2026-06-24 at 15:05 -0700, Sean Christopherson wrote:
> > Ignore KVM's internal "service pending PV EOI" request if the vCPU has
> > disabled PV EOIs since the request was made.  Asserting that PV EOIs are
> > enabled can fail if reading guest memory in pv_eoi_get_user() fails, i.e.
> > if pv_eoi_test_and_clr_pending() bails early, *and* the vCPU also disables
> > PV EOIs.
> > 
> >   kernel BUG at arch/x86/kvm/lapic.c:3338!
> >   Oops: invalid opcode: 0000 [#1] SMP
> >   CPU: 4 UID: 1000 PID: 890 Comm: pv_eoi_test Not tainted 7.0.0-d585aa5894d8-vm #337 PREEMPT
> >   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> >   RIP: 0010:kvm_lapic_sync_from_vapic+0x12b/0x140 [kvm]
> >   Call Trace:
> >    <TASK>
> >    kvm_arch_vcpu_ioctl_run+0x1075/0x1c30 [kvm]
> >    kvm_vcpu_ioctl+0x2d5/0x980 [kvm]
> >    __x64_sys_ioctl+0x8a/0xd0
> >    do_syscall_64+0xb5/0xb40
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >    </TASK>
> >   Modules linked in: kvm_intel kvm irqbypass
> >   ---[ end trace 0000000000000000 ]---
> > 
> > Fixes: ae7a2a3fb6f8 ("KVM: host side for eoi optimization")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/lapic.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 6f30bbdddb5a..38bba9a1114c 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -3371,6 +3371,12 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
> >  					struct kvm_lapic *apic)
> >  {
> >  	int vector;
> > +
> > +	if (unlikely(!pv_eoi_enabled(vcpu))) {
> > +		__clear_bit(KVM_APIC_PV_EOI_PENDING, &vcpu->arch.apic_attention);
> > +		return;
> > +	}
> > +
> 
> Do you think whether it's better to do this in kvm_lapic_set_pv_eoi(), i.e.,
> when guest disables PV_EOI for this vCPU?

Yes, if we were doing the initial implementation.  I opted not to go that route
because it would require writing to guest memory to put the shared flag back to
KVM_PV_EOI_DISABLED, at which point this becomes a guest-visible change.  It's
probably fine?  But very, very, theoretically, a guest could toggle the feature
on/off and expect memory to remain unchanged.

And I want to get rid of the BUG_ON() no matter what, so I opted to leave the
WRMSR path alone and go with the minimal (albeit ugly) fix.

> If we do so, it seems we can save the unnecessary pv_eoi_set_pending() (which
> writes guest memory) called from apic_sync_pv_eoi_to_guest(), or it's not
> possible to happen?

No, the whole point of apic_sync_pv_eoi_to_guest() is to do pv_eoi_set_pending().
The naming of the flags and the way the code is written obfuscates the logic to
some extent, but what it's doing in pseudocode is:

    IF vCPU has in-service IRQ and no pending IRQs; THEN
        vCPU.pv_eoi = ACTIVE
    FI

where vCPU.pv_eoi is the shared memory.  The guest side, in its APIC EOI path:

  static notrace __maybe_unused void kvm_guest_apic_eoi_write(void)
  {
	/**
	 * This relies on __test_and_clear_bit to modify the memory
	 * in a way that is atomic with respect to the local CPU.
	 * The hypervisor only accesses this memory from the local CPU so
	 * there's no need for lock or memory barriers.
	 * An optimization barrier is implied in apic write.
	 */
	if (__test_and_clear_bit(KVM_PV_EOI_BIT, this_cpu_ptr(&kvm_apic_eoi)))
		return;
	apic_native_eoi();
  }

then does:

    IF vCPU.pv_eoi != ACTIVE; THEN
        do APIC EOI
    FI
