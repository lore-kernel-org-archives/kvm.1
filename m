Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3305288AD
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775848848; cv=none; b=HYM1JhkPuRb3Rc0WensNjDZJ35Fs8QRn2NjgdqzQYrsQ65kybJ+rd7gzztqx/eiSMntd08kmc5ioHS9+YOGHA1zDFxOcX1mJf3N9p0ZmANh5bqmGYCpJpjTnApOOGIJcURND12LEfESSMFqjetReKGizBvH+UfxvcArwVh39jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775848848; c=relaxed/simple;
	bh=dDSoe18ZPa5o6UYbbuBc3OWeA+HX14GM64n9Py9kxDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ebdb8yyQbVSDTs+OQOxy3Daoj0RQr7ZppcVylh+kNUK42S3MRnKq8o0TIIP/ui7IT993t+LTQ8CT6tBCF6uIktVXPx7a3Tw/07jHVSf3yrPX4V3WKOGC138jVlYsE9SrrE4AoZE0epWUTjQKq0/7uARLIO9+XFJnfiiwKk24KOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Np6fcX/E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Np6fcX/E"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so2915687a91.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775848846; x=1776453646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODcx3kPkAa7pQlpWAI3ymYf3+ivHVM6fe1fHRRDycvI=;
        b=Np6fcX/ETNbG/9Suy0vbedowzqV3SYVgrTO0jg7mlfvzSvhpAA4HvNxWBlyPJCjRkN
         rEcvFMu7DDxdyN/V0ymn5jKvUESUWNiJjOJZGoax3WYT//QSxUBdJZAYll/7PVoQZ2hx
         ++6lu+ReJS1yaCr+Caz+m3bNT8/X6H8C0v4YStVAnzXElO3648t1DOktOUhqldKwuX74
         2Ojx1tY0HndB6iCivtDHp14X069ARxcgcyxSO8dV//omWuGI7GYbal9ngs6gNP7r2df8
         57U/pFoT8xBNvqUKtNmuNq8c4isB5zrhC0Jaj7nTocEt4DN52HXErcKZFnvn48Fq50lR
         hdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775848846; x=1776453646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODcx3kPkAa7pQlpWAI3ymYf3+ivHVM6fe1fHRRDycvI=;
        b=FGV24iQKOwFUv9vsHXmNyafcF/TInO+MB9PTc/KoLYYMq5C6PC4ns6D5GjBH/WOSW8
         uYboOPiYB/LkTKjwjNCDzegEalHq3an80o1k0cd8O+xPKlSRL1XMJqIsf+L7jV4iQvJs
         MBijuzfT9pcPJ3I9eK81kDAEeNc4Fl0pPQ8+Q5y/8zc7TrEKu0HBpghxWkxfpSNmir3f
         eVZo5EHE8xKjsed4emVydoiKzl38pjTX08ou2juq0SiW60EH+ZT+C5SYo8KHRCCH4cfy
         YOsuyR+ycKpbS2IlADsJnxDfRxaEJJItfnkGsAl/e/fnjwVPbmyVK4JRmNfl8FZue7ie
         toZg==
X-Forwarded-Encrypted: i=1; AJvYcCUE4OCNef8An7pdSUlE8rc+2O+6iol5JkJbnIKFLbwanYsg/f8X9o7Yb4speUkok5cxZaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEE9U54rxI+lzFBYQ7JqzPBX3Ol+QXd68tRrxeio+BY7wKPl7
	EjEcpYVFEbZ9GWmm0VY+IKvK7o4cs5sBPDLHPDj68KteLl+Zld3+sn6BTSc29eRWO+3A4KNvOZm
	cLHcm/Q==
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:35d:9b4c:48fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c50:b0:35d:8ea1:62df
 with SMTP id 98e67ed59e1d1-35e42838d40mr4878307a91.21.1775848845914; Fri, 10
 Apr 2026 12:20:45 -0700 (PDT)
Date: Fri, 10 Apr 2026 12:20:44 -0700
In-Reply-To: <adkl4wFdk4JrM3T-@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com> <20260409222449.2013847-2-seanjc@google.com>
 <adkl4wFdk4JrM3T-@blrnaveerao1>
Message-ID: <adlNjCRRCur8mjCA@google.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs
 KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 10, 2026, Naveen N Rao wrote:
> On Thu, Apr 09, 2026 at 03:24:47PM -0700, Sean Christopherson wrote:
> > Fix multiple (classes of) bugs with one stone by using KVM's mask of
> > readable local APIC registers to determine which x2APIC MSRs to pass
> > through (or not) when toggling x2AVIC on/off.  The existing hand-coded
> > list of MSRs is wrong on multiple fronts:
> > 
> >  - ARBPRI, DFR, and ICR2 aren't supported by x2APIC; disabling
> >    interception is nonsensical and suboptimal (the access generates a
> >    #VMEXIT that requires decoding the instruction).
> > 
> >  - RRR is completely unsupported.
> > 
> >  - AVIC currently fails to pass through the "range of vectors" registers,
> >    IRR, ISR, and TMR, as e.g. X2APIC_MSR(APIC_IRR) only affects IRR0, and
> >    thus only disables intercept for vectors 31:0 (which are the *least*
> >    interesting registers).
> 
> :facepalm:
> 
> We seriously need better selftests for these.

+1000.  In general, we need a way to validate "this should exit, this should not".

> Also on my list has been to cook up something for your other fix where AVIC
> gets inhibited for non-zero vCPU IDs (with x2AVIC disabled):
> http://lore.kernel.org/r/20260112232805.1512361-1-seanjc@google.com
> 
> I started looking at Alejandro's series adding AVIC-related binary 
> stats, but had to switch to other things. Last I looked, I felt that 
> your suggestion to add an "exits" array accounting individual #VMEXITs 
> would in particular be helpful:
> https://lore.kernel.org/kvm/ZmMjHwavCLk0lRd7@google.com/

We have per-exit stats (and more!) internally, and it's ugly.   For simplicity,
and/or perhaps to reduce out-of-tree maintenance costs, we did the easy thing of
tracking hardware exit reasons as is.  Which is *extremely* useful, but also
quite wasteful with respect to memory consumption, as a large percentage of exit
counts are unintresting and/or completely unused, especially on SVM due to SVM
having high granularity exit reasons.

> Though I'm not sure how standardizing this across VMX and SVM looks 
> like, and/or if it will be truly helpful

Probably even uglier :-)   The one case I'm confident would benefit from some
amount of standardization is exceptions.  If we simply regurgitate hardware exits,
Intel/VMX will only capture "did an exception occur", whereas AMD/SVM will
capture exactly which exception occurred.  If we *strictly* regurgitated exits,
it would be even worse than that, because NMIs get lumped in with exceptions on
VMX.

There are more cases like that, where VMX and SVM have slightly different exit
granularity.  We'd want to standardize on what gets presented to userspace so
that userspace doesn't have to effectively do the standardization (or worse, can
only implement certain checks for one vendor or the other).

> -- we may be interested in specific exits, such as AVIC-related exits for
> some of the tests...
> Thoughts?

I don't think we should plan on leveraging per-exit stats for testing purposes,
as they may never land upstream, and if they do, it will take some time.  E.g.
even though we find them valuable, I'm far from convinced that what we've got
implemented internally is suitable for upstream.

However!  Idea.  For many testcases, we don't actually care about *what* exit
occurred, only if *an* exit occurred (or not).  I.e. tests really just need a
binary yes/no signal.  Which we _almost_ have today, except stat.exits is polluted
with exits that are host-induced/owned (e.g. IRQs and NMIs) and/or asynchronous
in nature, e.g. the VMX preemption timer (which is arguably host-owned as well).

If KVM provides a stat that increments only on exits that are the direct result
of a guest action, then we can use that in selftests to detect unexpected (or
missed) exits, without having to worry about false failures due to noise from
host IRQs/NMIs/SMIs, etc.

The hardest part is probably figuring out a name :-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3f3290d5a0a6..a8530a3d0545 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4256,6 +4256,9 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
        struct vcpu_svm *svm = to_svm(vcpu);
        struct vmcb_control_area *control = &svm->vmcb->control;
 
+       if (is_guest_induced_exit(control->exit_code))
+               ++vcpu->stat.guest_induced_exits;
+
        /*
         * Next RIP must be provided as IRQs are disabled, and accessing guest
         * memory to decode the instruction might fault, i.e. might sleep.
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 967b58a8ab9d..cd7769c412ab 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7524,6 +7524,9 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
                                             bool force_immediate_exit)
 {
+       if (is_guest_induced_exit(vmx_get_exit_reason(vcpu).basic))
+               ++vcpu->stat.guest_induced_exits;
+
        /*
         * If L2 is active, some VMX preemption timer exits can be handled in
         * the fastpath even, all other exits must use the slow path.

> > @@ -162,9 +165,15 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
> >  	if (!x2avic_enabled)
> >  		return;
> >  
> > +	x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
> > +
> > +	for (i = 0; i < BITS_PER_TYPE(typeof(x2apic_readable_mask)); i++)
> > +		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
> > +					  MSR_TYPE_R, intercept);
> > +
> 
> Yet to test this series (will get to it next week in more detail), but I 
> suppose you meant to use `for_each_set_bit()` or such?

Heh, my turn for a /facepalm.  I'm glad I admitted I didn't test this very well :-)
