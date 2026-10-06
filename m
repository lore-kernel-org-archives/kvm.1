Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED132367B8
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791262946; cv=none; b=OJd/Ae3AnEsO1W3GCsrmUNafLenOQyT7/y3EH9exaLP92eR7I7j0hIc67f72JfXxYRkIjV9HLAPpslWik9bCmLafhKsQ5dCsZy+PEwGp8EZ9aoZVAYwLlN51rgU0pAHerdzqCKzEkpbJ/pJrRMKtP0ZvMjBVoRw2EJtGPhnBqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791262946; c=relaxed/simple;
	bh=mLp/Te6XovODgA3ctFdIo+GqO0+rWdIhoncf+nOJAk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e606kBgs/+ooMpyS+ObE/k7UF98bKZDph1nvXHJdsj1s0YW79NoGaYzjfJas4lSM13OdmiX/+zAR6X/0qQRUzaR7u/HD+mHI9P4w/OG4cHamYXdl7DDMmGD56vYECFpQUAmxgqE8VpmEPWkeNh8unH4ErU6QeIz3Wt9Cy4aOgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dj63/WOR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dj63/WOR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a82c7e8fcfso1212953a91.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 22:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791262944; x=1791867744; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FOXXPBDAovzDD17f2vUafohoPRyevd3vdSD2CvKlr3A=;
        b=dj63/WORKE9dxC1Np/WjUHjTEGOblaPa7F++0DLB03bF1PiRNSxc+TK+Q3Ccz/WL5+
         F3ez6pniumiEbwKE4Tq+sw4GtAzLYDwWpTYE5qbooHOQgbfgbw52rKvgOk55VXBLvU0G
         xJhpIjHAhvUvnMseKxBqB2FNufgCO1hvCWRVO0eB8+k70naeNhm/DlNQfEpMtL9E+eIT
         uoE4x0Z7/BboQ0oVQ8hF9DbJkvO+2hP5uzMg++LWhIFmqoStYp+z/Dlm/bXxpQoRZQ94
         5r6ry0HuI1bEu3MAqIYTRhQSzsrn4yAGecQsuZZiQCjSrPEV6sj6rjKCawSf4NnWFTGa
         rlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791262944; x=1791867744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOXXPBDAovzDD17f2vUafohoPRyevd3vdSD2CvKlr3A=;
        b=Z6qCzBnbpTIJ4O6v37LKPgp6fWvIrJlFPnGVh3AMd6L2kbAOaIsYbXIGgQ7EpYQuN5
         CXl043RTnxDyco06+sJwvn5CKD7Xsk2k/HNWaD5rlsNLnL3nXMlLZLxivmtBL05IvExa
         fXsaljN46CKjUPxQS5CKiJlb5l+6R2qpz4PMZ46HzHCyANfX7wiwhd2kOHQIK7xgiQPz
         SVCuOM/H1DYvCjuRdmspSnDaKZbOyKLd8d2wisAnrWYvV3/Wo7z1JgYsz4Te/ERz7T0x
         +IEYai6K2X9i0rknEF2Ld1l0jtI3Qu+73H6yVOXZ2J5OIuR5VV3GahZ5xP/Lt+xECoya
         Wlnw==
X-Forwarded-Encrypted: i=1; AKwUvBwkAH2l1EyBCrS51Sp8cuhyebft5dZMQlPxypModpJJ8uqe/rAhheInMAKuffiYn8bu0rk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9OtQzo+3zTGy4dUM8uHMFlUDSzKdZsxn7mXkLJloPWs+IzpVN
	shuOn9HBM/WwHLk1utsfx+ycMk2IfMwWGE0BsieQaAFKmMKcd3/XIPa8wRPmAEjoCFyiCVnhkRm
	HbAFkEQ==
X-Received: from pjbdw21.prod.google.com ([2002:a17:90b:955:b0:3a8:4e6f:49e3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:288c:b0:39e:5b3c:4633
 with SMTP id 98e67ed59e1d1-3a8735166fbmr234816a91.21.1791262943760; Mon, 05
 Oct 2026 22:02:23 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:02:18 -0700
In-Reply-To: <7fd7a6dc-9429-44d4-94b7-c7930536043a@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824131824.6040-1-shivansh.dhiman@amd.com>
 <20260824135155.6B0A41F000E9@smtp.kernel.org> <7fd7a6dc-9429-44d4-94b7-c7930536043a@amd.com>
Message-ID: <asSA2uApsOMMCvgI@google.com>
Subject: Re: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB on
 shutdown intercept
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 25, 2026, Shivansh Dhiman wrote:

> On 24-08-26 19:21, sashiko-bot@kernel.org wrote:
> >> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> >> --- a/arch/x86/kvm/svm/svm.c
> >> +++ b/arch/x86/kvm/svm/svm.c
> > [ ... ]
> >> @@ -2164,18 +2164,23 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
> > [ ... ]
> >>  	if (!is_sev_es_guest(vcpu)) {
> >> -		clear_page(svm->vmcb);
> >> +		struct vmcb_control_area *control = &svm->vmcb->control;
> >> +
> >> +		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
> >> +		control->int_ctl &= ~GENMASK(15, 0);
> >> +		control->int_state = 0;
> > 
> > [Severity: High]
> > Since clear_page() was replaced with targeted clearing, do we also need to
> > clear control->event_inj and control->event_inj_err here?
> > 
> > According to the AMD APM, hardware does not clear the EVENTINJ field in the
> > VMCB on a VM exit, which leaves the VALID bit set if an exit occurs during
> > event delivery (such as a triple fault leading to SVM_EXIT_SHUTDOWN).
> > 
> > If the EVENTINJ field is left intact across this shutdown reset, will KVM
> > execute the subsequent VMRUN with the stale EVENTINJ_VALID flag still set?
> > 
> > Could this cause KVM to spuriously inject the old fault into the newly
> > reset real-mode vCPU on its first instruction, leading to an immediate
> > crash or an infinite triple-fault loop?
> The latest APM says otherwise. The #VMEXIT sequence in APM ends with "clear
> EVENTINJ field in VMCB". Hardware clears the field on every exit, so there
> is nothing stale to carry across the shutdown reset and the scenario can't
> arise.

But that seemingly unconditional statement has hidden clauses[*]:

 : >> The second half isn't. Clearing EVENTINJ is not part of injection, it's part of
 : >> #VMEXIT, and it's unconditional.
 : > So that doesn't mesh with the above comment, which says:
 : >
 : >   Hardware clears EVENTINJ field when it injects an event.
 : >
 : > And it begs the question of how this patch is at all useful.  Because all this
 : > fancy new paranoia is clearly generating #VMEXITs, and if #VMEXIT unconditionally
 : > clears control->event_inj, I don't see how control->event_inj can be non-zero if
 : > KVM attempted VMRUN.
 : >
 : > I.e. either this is all broken, or the APM is buggy.
 : 
 : My wording in the comment is misleading. The clear is part of the #VMEXIT path
 : out of guest mode, where it is indeed unconditional. However, VMRUN can
 : terminate even before the guest mode is ever entered. With ESMTP, the hardware
 : can give out a garden variety of exits at the sync point. In this case we
 : get a VMEXIT that implies the VMRUN never actually ran any guest code then
 : EVENTINJ won't be cleared. Since the exit code isn't a reliable discriminator,
 : a non-zero EVENTINJ is the only way to tell.

Ignoring that IMO the APM needs to be updated to clarify exactly when EVENTINJ
is cleared and when it isn't, I don't see any point in not manually clearing the
field on SHUTDOWN.  Common sense would say that it's unnecessary as SHUTDOWN can
only occur if VMRUN gets into the guest, but the cost is completely neglible and
there is zero chance EVENTINJ *needs* to be retained, unlike say the PML index.

We can certainly add a comment saying it's paranoid, but I do think we should
manually clear EVENTINJ and friend, e.g.

	/*
	 * EVENTINJ is cleared on #VMEXIT, but only if VMRUN fully entered the
	 * guest.  Manually clear the fields even though it should be redundant,
	 * as there is no downside to doing so.
	 */
	control->event_inj = 0;
	control->event_inj_err = 0;

[*] https://lore.kernel.org/all/d946de080e3dd34844a665c167179e4910fdc9d4.1789399214.git.prsampat@amd.com
