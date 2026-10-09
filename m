Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF584EB843;
	Fri,  9 Oct 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560606; cv=none; b=H3HMUNBZTYzlcJ3rID2XcnHPxUi3BdVdpN/gaWBH0N8iPTKR5tU6rKL8CbhPXkAUushLJJCj5K91gxfwyqu4imeZmTkUUi84nY2i18aGzS2EBErdj9wG/jH3CMcBC08qs3TYHEAemwDPrUsg3YX7ecfI6I1t3Aq4eKTrc8WaC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560606; c=relaxed/simple;
	bh=FBrjgH0x5EGOlSJEOcDQAUei+hDRBQyVthD5BGCwepk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJm0sNhHnAsvuvQiDYF+LX3zsI7YmO/KDHvancutPuLwMoth1WJhSWdr0dRzu+suc3QHSmq5ERtPKUi8bwds0ePPPUkfZqiLywft8BNyOEUKuuC22Pas8xQtFPF4Px7kt17lnfZWnjLM9xmgUOKqm/eey5LPr/GmNd4B6paloTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzcdNITb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzcdNITb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D431F000FF;
	Fri,  9 Oct 2026 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560605;
	bh=z/6mVlzTEA0Dl8rq6Hoos2CSyNWP/SuVbaIeD5VNGEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WzcdNITbKeO9FKZtpp5MUxAlGFSPUIK5SadAWH5Eiv3vT7pyFxLkWL4EVPr4I1GTf
	 TmiNvy4aOiqBVPD67/mW5lhuLF/Q6YkO5scvldsDec8+VZsePgKQLl5+1Lw34t2nwI
	 0FH4SHmQF3rYK27UnEYq01LNnK8BL0JzmlbBHzwVshtLapLCyXdTJmXjrXaEUfUTFY
	 ozmjz1lVBJ3rSmt8YiwOmzmr+Z0Ohi4xHTeR/Ofc728kdRGu/YnQUd7dUP4967dOtP
	 qpIqoPjgS7DcCJoxXcPMeRNiHPfItTQwvJiZkRbT2NmnEBncWr+EaW4WWovi9TIvOE
	 PzKWSIhATsxPQ==
Date: Fri, 9 Oct 2026 15:43:23 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 13/29] KVM: nSVM: Add a placeholder ASID for L2
Message-ID: <askLA0KB-A5V3bSa@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-14-yosry@kernel.org>
 <sashiko-outbox-163478@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163478@kernel.org>

On Thu, Oct 08, 2026 at 12:42:00AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm/svm: SEV migration leaves vmcb01 without SEV flags if in guest mode
> --
> 
> commit a990122c49d4a9878fc605ac4ab62f79ce50bdad
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: nSVM: Add a placeholder ASID for L2
> 
> This commit introduces a placeholder ASID for L2 that is initially the same
> as L1's ASID to facilitate future ASID separation. It also updates SEV VM
> migration to copy the new SEV ASID into asid02 and vmcb02 if nested is
> already initialized on the destination vCPU.
> 
> [ ... ]
> 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 99577859e1aab..b2e6acfbb081f 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2041,6 +2041,15 @@ static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm,
> >  	 */
> >  	free_asid(dst_svm->asid);
> >  	dst_svm->asid = asid;
> > +
> > +	/*
> > +	 * If nested is already initialized on the destination vCPU, also update
> > +	 * the nested ASID to match the new SEV ASID.
> > +	 */
> > +	if (dst_svm->nested.vmcb02.ptr) {
> > +		dst_svm->nested.asid02 = asid;
> > +		dst_svm->nested.vmcb02.ptr->control.asid = asid;
> > +	}
> >  }
> >  
> >  static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
> 
> [Severity: High]
> Does this migration path leave vmcb01 without SEV flags if the destination
> vCPU is in guest mode?
> 
> During SEV migration, sev_migrate_from() calls sev_init_vmcb() shortly after
> sev_vcpu_migrate_asid() updates the ASID:
> 
> arch/x86/kvm/svm/sev.c:sev_migrate_from() {
>     ...
> 		sev_vcpu_migrate_asid(dst_svm, dst->asid);
> 		sev_init_vmcb(dst_svm, false);
>     ...
> }
> 
> If userspace restores nested state before the migration ioctl, the vCPU could
> be in guest mode with svm->vmcb pointing to vmcb02.
> 
> In this scenario, sev_init_vmcb() modifies svm->vmcb, effectively leaving
> vmcb01 uninitialized for SEV:
> 
> arch/x86/kvm/svm/sev.c:sev_init_vmcb() {
>     ...
> 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV;
> 	clr_exception_intercept(svm, UD_VECTOR);
> 
> 	WARN_ON_ONCE(svm->asid != sev_get_asid(vcpu->kvm));
> 	svm->vmcb->control.asid = svm->asid;
>     ...
> }
> 
> When the vCPU exits nested mode, it will run L1 as a normal (non-SEV) guest.
> Since KVM still expects an SEV/SEV-ES guest (is_sev_es_guest() is true), KVM
> will skip loading guest state but the hardware will execute vmcb01 as a normal
> guest. Can this cause a guest crash or hypervisor confusion (e.g. unexpected
> intercepts triggering KVM warnings)?
> 
> Should the migration path ensure vmcb01 is updated with the SEV flags and
> new ASID regardless of whether the vCPU is currently in nested guest mode?

This seems like a pre-existing issue. sev_init_vmcb() (and some of its
callees) already operate on the current VMCB, which would be vmcb02 if
the vCPU is in guest mode.

This series (but not this patch, but patch 7) adds another
initialization in the current VMCB to sev_init_vmcb(), which arguably
makes things a bit worse, but it's already broken.

So I am leaning to not doing anything in this series, and migrating SEV
vCPUs in guest mode (or disallowing that?) can be done separately
if/when needed.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=13
