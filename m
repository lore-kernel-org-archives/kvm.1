Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E93446B0
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007328; cv=none; b=ZnGGPbDOY+brUaK71JpJiQvHYywYj373RXfBwSP4klIXzYQOO3AIdxdTdc3nKMOVMDMK7BjhknxJEhtyVmrJvGHOR7BZjOs35cnurLAGUs0T/JljXGRGzt8YIrLDsNvFjU8zO4oUt2161UAOmPzVBCR7hou4XEhIrGIS54V10S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007328; c=relaxed/simple;
	bh=NPytKttvhSWP9wC8ljBqJsACnF7U5YbZT2SHg4KiTeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ojJOhhC8lkJ+poQA8b2YkqcT03CilGnayWCP4sYXGOrkKMbHQxgC83ZcvMugKOR0H38G3jHok4bJnHzIjDM4dChvhFKKfBdzVJ0MnILUDIg+NeSnbzoa4EmLLNPA2Vtp6UZZTYZ0imn05ky7UadCH0haluVkM4JeicGDdGu9lXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMDv2/0p; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMDv2/0p"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso52493785ad.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790007326; x=1790612126; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qE+olzcN6zjo+GKIPM25wup16iAGlGxkabmAr9kueF4=;
        b=kMDv2/0pfOeO9EIP0rV03LQvkFgpH5nFnsnJhpzOQIZTQoPXLAexiL9TyRH8a6sZ99
         TuNxtc9ICVfkuN+QVktXd5614L7WfWqcuJZBNvcIJw3NCTDEP4B6I1GZ7hEoKW4JExqW
         DPqPspyFeKiUgnQtEWJg8hGT3EQoSscPOEdRY0vbwkJxSz2gzc+FVK5FNSiG6oDL6m/E
         75lG+FOhDbx/LmmHVwMZ0JLVw9o5DzJFQ77Sl4cd0xMmH8h7qdmwHBZGpjuvT3po2H9Q
         bvmHoxiOiMRUnNwfJEDKazP1xR5OfEZftNdpXWM6zLGmz3U/6Y4bVPLP59o5O/Vpm6Df
         4DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007326; x=1790612126;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qE+olzcN6zjo+GKIPM25wup16iAGlGxkabmAr9kueF4=;
        b=QaheWOtHUQEHMqa9P9hDPJmBMxy/onNYTrRiGiBx5sKobMEJDst4njbgTXB+Akm+6r
         hmnsQ4sfB6NEYjsOj+c2QmNyqq7jO04PgUmyB1WDZNhwnbc+wf4Hgf6VfuTaFnZRq1bD
         1z6Rk5zpPFGcIUAfLqObYF9RrwCVOpLXnV1yslWG4S9Qc5Xo+uiocBsOcmXVxObgxOU5
         iDLsPJdvd1bJtmJ6eZrWcVsYa1COU1knDCZDyTiHCiBzht42HV5ZBUcqCaVwilsuaNBp
         7X/Bm3ojEUrnmFMd+4hAgW8h4lqTAy7x/UZbugitEW/xuwIq3GTK0UfAsbrA/nFjDueH
         uKaw==
X-Forwarded-Encrypted: i=1; AKwUvBwmTm5M4Tox6wxuqy2UgSIJE96IOhWK365WtmjSWhqtBkEpI9KPW/zHwCdJNqTGnL+L5fA=@vger.kernel.org
X-Gm-Message-State: AFuF++mzNsV4UTHhVg05tmLelbpXxmjXE4dVpLGcVloJmJ5q/X1LlS1S
	R2Bw1GKAxlZXFpqA+2L+WO2HX2K+bwR1Wo2cYnKTQRVOr2npmLq95xk8+VFtspQH6PWIfrGzykN
	CQFfWCQ==
X-Received: from pgbfu21.prod.google.com ([2002:a05:6a02:4a95:b0:cc7:4c6e:3e90])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d8b:b0:3d3:b02a:61a5
 with SMTP id adf61e73a8af0-3dd8c41a021mr19357702637.28.1790007325870; Mon, 21
 Sep 2026 09:15:25 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:15:25 -0700
In-Reply-To: <ecbb6fb8-fe61-4028-880b-245f94db0f9f@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789399214.git.prsampat@amd.com> <d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com>
 <20260914171628.8A4631F00893@smtp.kernel.org> <ecbb6fb8-fe61-4028-880b-245f94db0f9f@amd.com>
Message-ID: <arFYHRzNFT886BME@google.com>
Subject: Re: [PATCH 1/3] KVM: SVM: Re-queue events that were never injected
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 17, 2026, Pratik R. Sampat wrote:
> 
> 
> On 9/14/26 1:16 PM, sashiko-bot@kernel.org wrote:
> > [You don't often get email from sashiko-bot@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] svm_complete_interrupts() incorrectly checks if (control->event_inj) instead of the SVM_EVTINJ_VALID bit, which can silently drop valid hardware-reported events (like guest page faults) by clobbering EXITINTINFO.
> > --
> > 
> > commit 50716e3ba11eb9d000a0186ffad984ac08df1dcb
> > Author: Pratik R. Sampat <prsampat@amd.com>
> > 
> > KVM: SVM: Re-queue events that were never injected
> > 
> > When injecting an event into the guest via the event_inj field, a non-zero
> > event_inj value on #VMEXIT means the hardware was unable to inject it.
> > This commit adds a check to recover potentially lost interrupts by detecting
> > an undelivered injected event and re-queuing it.
> > 
> >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >> index d0971685034b9..e2be2cd86c320 100644
> >> --- a/arch/x86/kvm/svm/svm.c
> >> +++ b/arch/x86/kvm/svm/svm.c
> > [ ... ]
> >> @@ -4323,6 +4324,27 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
> >>       svm->nmi_l1_to_l2 = false;
> >>       svm->soft_int_injected = false;
> >>
> >> +     /*
> >> +      * Hardware clears EVENTINJ field when it injects an event.
> >> +      * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
> >> +      * mode, and thus that the event was never delivered.  Migrate the event
> >> +      * to EXITINTINFO so that it's requeued instead of being dropped.
> >> +      *
> >> +      * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
> >> +      * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
> >> +      * without having injected that event into the guest.
> >> +      *
> >> +      * Clobbering EXITINTINFO is safe precisely because the vCPU never
> >> +      * entered guest mode.
> >> +      */
> >> +     if (control->event_inj) {
> > [Severity: High]
> > Does this code silently drop valid hardware-reported events?
> > 
> > If an L1 hypervisor sets event_inj to a non-zero value but leaves the
> > SVM_EVTINJ_VALID bit clear, hardware will ignore the injection and won't
> > clear EVENTINJ.
> 
> 
> The first half is right, nested_svm_check_event_inj() intentionally returns
> true when V is clear, so vmcb02->control.event_inj can be non-zero with V=0.
> 
> The second half isn't. Clearing EVENTINJ is not part of injection, it's part of
> #VMEXIT, and it's unconditional. 

So that doesn't mesh with the above comment, which says:

  Hardware clears EVENTINJ field when it injects an event.

And it begs the question of how this patch is at all useful.  Because all this
fancy new paranoia is clearly generating #VMEXITs, and if #VMEXIT unconditionally
clears control->event_inj, I don't see how control->event_inj can be non-zero if
KVM attempted VMRUN.

I.e. either this is all broken, or the APM is buggy.
