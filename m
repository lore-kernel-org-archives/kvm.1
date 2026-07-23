Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08471326D55;
	Thu, 23 Jul 2026 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782971; cv=none; b=UszdoDUMQtVOib+4kcQFjkuhSgFx9zojonvb2/A+YHu2OHt+9pu9g89i0hP/063uSNd55pbixP/e/hqa1tD6dE1Ng+5IGN9zvdGHVIugD073X772L5qKu8tbS5WiBnktFSyBBcYcxq+i5TsTo5KtNc6rmDNLU5LcqT8NR0Iiy90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782971; c=relaxed/simple;
	bh=4J7HqiOhF2SXWgjJdCMDq841eZA6tjlRMl9yTOCLiSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no5mCigzSFgqIkAzE/1law+mEzGhWlue5Nxi1Lt9ewi1dFq2KzaoB64PRzzQB0Kruh310LA6uWHvgp3qtm+yAHUFppXqiUj3TdCfV3Zrvz9Uvl2iJo1XsKHdvnu/4oH88ghjk0gyXhJgX4lDRMSpjIw7pOEow6EL1ZdZceGNgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581671F000E9;
	Thu, 23 Jul 2026 05:02:46 +0000 (UTC)
Date: Thu, 23 Jul 2026 05:02:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV
 VMs
Message-ID: <amGf_h4yDIRuxoDf@google.com>
References: <20260616004155.1435766-9-yosry@kernel.org>
 <20260616010604.ACC021F000E9@smtp.kernel.org>
 <CAO9r8zNx4=dq=SBMcNwWzedVR4UGgarg=_pfmPT1DWb1MzC2CA@mail.gmail.com>
 <CAO9r8zNE5F_895rmxuidfs_5Rf0Y5n+osr+bdiT3ju5=+za5sQ@mail.gmail.com>
 <amFhWUcEWucx1hlH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amFhWUcEWucx1hlH@google.com>

On Wed, Jul 22, 2026 at 05:33:29PM -0700, Sean Christopherson wrote:
> On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> > On Tue, Jun 16, 2026 at 10:50 AM Yosry Ahmed <yosry@kernel.org> wrote:
> > > On Mon, Jun 15, 2026 at 6:06 PM <sashiko-bot@kernel.org> wrote:
> > > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > > --- a/arch/x86/kvm/svm/sev.c
> > > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > > @@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
> > > > >       if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
> > > > >               cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
> > > > >
> > > > > -     /* Assign the asid allocated with this SEV guest */
> > > > > -     svm->asid = asid;
> > > > > -
> > > > > -     if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> > > > > +     if (WARN_ON_ONCE(asid != svm->vmcb->control.asid)) {
> > > >
> > > > [Severity: High]
> > > > Can a malicious SEV guest or an unprivileged host-userspace process trigger
> > > > this warning by entering nested virtualization or via KVM_SET_NESTED_STATE?
> > > >
> > > > KVM does not strictly prohibit userspace from exposing CPUID.SVM to an SEV
> > > > guest. If an SEV guest sets EFER.SVME and executes VMRUN, KVM intercepts it
> > > > and handles the nested transition via nested_svm_vmrun(), which switches the
> > > > active VMCB pointer to the nested vmcb02.
> > > >
> > > > The nested vmcb02 does not inherit the SEV ASID assignment from
> > > > sev_init_vmcb(), and its control.asid is initialized separately. During the
> > > > subsequent svm_vcpu_run() -> pre_sev_run() call, the VM's valid SEV ASID will
> > > > no longer match the nested vmcb02's ASID, causing this warning to trigger.
> > >
> > > Hmm I looked around the code and I can't see what prevents SEV guests
> > > from setting EFER_SVME or using KVM_SET_NESTED_STATE. However, I think
> > > a VMRUN from an SEV VM will fail, at least due to not being able to
> > > read the vmcb12 from guest memory?
> > >
> > > That being said, I can drop this stopgap if preferred, I was going to
> > > drop it before sending but I left it in just to be cautious.
> > 
> > From an offline discussion with Sean, seems like it's technically
> > possible to actually run nested in SEV. 
> 
> It is, past me actually got it working (I was curious). :-)
> 
> > So I need to actually handle this in this series, by making sure L2 uses the
> > same ASID as L1 (required for SEV), and always flushing that ASID on nested
> > transitions. I will also drop this stopgap, given that it's likely that using
> > the wrong ASID will result in a loud failure anyway.
> 
> FWIW, "need" is debatable.  If supporting nested+SEV adds a lot of complexity,
> I'd probably be ok dropping support for that, e.g. by failing VMRUN with a software
> error.  But if it's roughly the same complexity overall, I'd probably vote to
> allow it, mainly to avoid making semi-arbitrary support/policy decisions in KVM.

It's mostly fine. Actually I dropped this patch in the next version and
kept using svm->asid for SEV (but I moved its initialization to VMCB
init). With that, handling SEV TLB flushes boils down to flushing on
nested transitions if svm->asid == svm->nested.asid02, which we need to
do anyway in case both L1 and L2 are using the fallback ASID.
