Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2C051AEDD
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072735; cv=none; b=epU05M/SZofsCFgvjhMQ3gYr7nugvSHIoqV5ucI2cMz04ssqnnH00xT81y9SVNv7n/cAm+K4JCKMqL/ApW9H4WYDb9ZxZdzgY9MTVHmBzR9jWqJyuiEiChTfVZZEgdTqI8bKYhnF0umCCG330dmm3qtfeochDtGU/jXA2cEtIkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072735; c=relaxed/simple;
	bh=Fmr8PvRAaAoeaJUzhHvHl4m0oLOfVqb5pwowBeNSOdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJ9pntcm8a9RXPYpMeuEjYz4k2S2hJuFOsQg/y7yTHiJKzUyQ9PNkwVddW2VxTOvfu5VOC4Zz7C9VpStNxnr7X4Wah9UPzKLYB2IlKN+4Kh1r/rr0i18ZnXFEkNX//Ib3FRIfNqZhFRW1OrKME48GbcE6QaP3V1ioUWg147C3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tN65rP8J; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tN65rP8J"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e85f74c21aso3365ad.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792072733; x=1792677533; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMSSECwkd6GBn6Q0rd3u20QgElhwSrNALm0yFALuhrI=;
        b=tN65rP8JSCBhl7JyekGO7FwQrm/5VwUqYlidc5dzNg2U+zSOqnKWC8q2BTe0mZV2g0
         Ya5kl+QNjqQXp2jhHnSXhdOBLthe+RfldxI3/0eXYMczq6dJS5l4OMJSLCYsuYkrQ10U
         9mduyXt7ddqlDei2qn8jP550fgupkDMEyhpOVRrB/mLHey1KzU/BC7Jx9AWQzrsWUX2T
         sCwAx6TYpmJfg8QLzdwNYEQDoJGSDojUAMmS6QRA8fXZaxvpiP5uuaEuFtWWSzCjXyjK
         tdyhCjdlksH7pXxNabCTl1Ubm4kXgv2fOU3KZXHHqMtAL6it0J6Phdf5b1ItUquijtKM
         WVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792072733; x=1792677533;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMSSECwkd6GBn6Q0rd3u20QgElhwSrNALm0yFALuhrI=;
        b=GgJh64KD9CDbS6hKHY+VcBnIuQGFYa7j0EuL3WfJpuPCC38IOn+AsjHEiksAxmfMMx
         jWM0CyIWog9/OeH6dM1oLfvyUmnCrF0PDECOb1G95EUBtXAsj+gKSIh5JNORJav5NqcB
         M9guShbVe2u/0Ee7KQbXMiKOh7gTLPltMVWBP2xDcRUBtW9U3ytnGI1fma2nUeyDqiny
         ht03Zga7vW3MLT+JPtA93qrlYtfYX3vW9HyuWPhmhgRviJ6tclpQi8Y9sdBp8uohsgf1
         Kbkm+XdG07tKyOdCQniZV6VrhOnFxk3/qEyVhdeANy6x2mKtq/Rnej4oDh4+EYUR7Dwt
         owrA==
X-Forwarded-Encrypted: i=1; AKwUvBwrIuIdyXAUZ1boR3K9jE6T2Ool+1l+1hGM+StYAUSGOuBz5glrSxEaj6AqeD7AboZc5qQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7bskjKZ6HoFjH5oMLA2VbHefdekwsxbg6UPf7UI93qbH9+AHR
	O6kC96Q34DWRxyzfjkdjfQADRz8ZWoSsO3LADzGl1MeAsU9qBCT5utXy4Aa9csZ8c8CHwfFcQ+w
	AFnZoEQ==
X-Received: from pllq21.prod.google.com ([2002:a17:902:7895:b0:2e2:c8c0:e8eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2348:b0:2e9:3295:11d1
 with SMTP id d9443c01a7336-2e97758f920mr460105ad.39.1792072733289; Thu, 15
 Oct 2026 06:58:53 -0700 (PDT)
Date: Thu, 15 Oct 2026 06:58:52 -0700
In-Reply-To: <asmwyCYDyaLwfmCV@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930001127.3170009-1-seanjc@google.com> <20260930001127.3170009-3-seanjc@google.com>
 <asmwyCYDyaLwfmCV@yzhao56-desk.sh.intel.com>
Message-ID: <atDcHCtdPNAJGHeI@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Synthesize SHUTDOWN instead of returning
 -EIO on unhandled EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ackerley Tng <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Sat, Oct 10, 2026, Yan Zhao wrote:
> On Tue, Sep 29, 2026 at 05:11:26PM -0700, Sean Christopherson wrote:
> > Exit to userspace with KVM_EXIT_SHUTDOWN instead of returning -EIO from
> > KVM_RUN if KVM encounters an EPT Violation due to a guest access to a
> > pending page.  Returning -EIO implies KVM is buggy, and most VMMs will
> > respond by completely terminating the VM, versus rebooting the VM in
> > response to KVM_EXIT_SHUTDOWN.  I.e. give the VMM the option of trying to
> > keep the VM (from the end user's perspective) alive.
> > 
> > Ideally, KVM would probably exit with KVM_EXIT_MEMORY_FAULT, but KVM would
> > need to extend run->memory_fault so that userspace knows the fault can't be
> > handled.  This scenario specifically occurs when the guest has deliberately
> > disabled #VEs on unaccepted memory for security purposes, i.e. the guest
> > literally disabled the mechanism that tells it it screwed up.  But, because
> > this is fatal, and the whole point is to NOT try to fixup the fault,
> > jumping through hoops to return MEMORY_FAULT instead of SHUTDOWN doesn't
> > make a whole lot of sense.
> > 
> > Don't bother bouncing through KVM_REQ_TRIPLE_FAULT as
> > tdx_handle_ept_violation() is a top-level exit handler, i.e. there is no
> > need to worry about failing to actually exit to userspace.
> > 
> > Fixes: e6a85781f783 ("KVM: TDX: Detect unexpected SEPT violations due to pending SPTEs")
> > Cc: stable@vger.kernel.org
> > Cc: James Houghton <jthoughton@google.com>
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Cc: Binbin Wu <binbin.wu@linux.intel.com>
> > Cc: Ackerley Tng <ackerleytng@google.com>
> > Cc: Vishal Annapurve <vannapurve@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/vmx/tdx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 29d4751f37fb..e3723f1222fc 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -1939,8 +1939,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
> >  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
> >  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
> >  				gpa, vcpu->vcpu_id);
> > -			kvm_vm_dead(vcpu->kvm);
> > -			return -EIO;
> > +			kvm_prepare_shutdown_exit(vcpu);
> Would it be better to exit with the reason KVM_EXIT_SYSTEM_EVENT and type
> KVM_SYSTEM_EVENT_SHUTDOWN or KVM_SYSTEM_EVENT_TDX_FATAL?

No.  KVM_SYSTEM_EVENT_SHUTDOWN is an explicit call from the guest to do a clean
shutdown (used by arm64 and RISC-V).  KVM_SYSTEM_EVENT_TDX_FATAL similarly exists
to relay explicit calls from the guest.  Ditto for KVM_SYSTEM_EVENT_CRASH and
KVM_SYSTEM_EVENT_SEV_TERM (which obviously is a poor fit for TDX, just pointing
out that it's another guest-initiated event).

KVM_EXIT_SHUTDOWN isn't a perfect fit, but IMO it's the closest approximation,
e.g. it's a rough equivalent of what happens if a #VE couldn't be handled because
the stack is invalid.  And more importantly, because we're retroactively fixing
code, KVM_EXIT_SHUTDOWN has the best chance of being handled appropriately by all
VMMs.

> By defining a specific flag (e.g., KVM_SYSTEM_EVENT_FLAG_TDX_UNEXPECTED_PENDING),
> we can stuff necessary info like gpa, vcpu->vcpu_id into data, so both pr_warn()
> and pr_warn_ratelimited() can be dropped.

Well, IMO, the printk can be dropped no matter what. :-)  But I don't care _that_
much so I'm ok keeping the ratelimited version.

vcpu_id is redundant, the exit is tied to a specific vCPU.  And as I said elsewhere,
practically speaking the GPA is all but guaranteed to be useless outside of
interactive debug sessions.
