Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D287D5581FD;
	Tue, 22 Sep 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089378; cv=none; b=YL3DjQOPvBexCWZ5lfK5q6SrChJEHbiBasoaAENuqsHmmDzvH5EMbDBp8NJNODu36zQa9tDfEFWKvyqqaBzPk+KefiGQzLstJdjVrlNa4T6OJXiy2l3raBc9H9MLuZEpB0vXuH7kzemzIuvuoEMxVhQgrjbfae0GVaFlHJ2vOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089378; c=relaxed/simple;
	bh=3J+esiQzIwjeD5YkDGGUJSyQUmtY/wqoWzHfAAf4dwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjkYeBaIT8iW6ETdZ2Q1OeV/iUuVeo8OYoUwo2BnRSzLjGYlevVBL5eP6dpbBs+DlnpH1HTR2U+G+gGj7gc0sVviw7kESdAehiynemQSrSCLuL7nx7nmikHbuzGUieBlcEWuqqaeouvYZmJeraqhvMx6unNeSXL8a7zjF3nGgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWl7wJ1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWl7wJ1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2831F00898;
	Tue, 22 Sep 2026 15:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089376;
	bh=NqtepCXeFpHFsb6AmnY8OHQMfHgcQxtJPFfgBTNCDVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWl7wJ1+99S9qM3eSiMZ3Sc0Im2Wlx/Mat0BArXX/E7scQrlnKR50yvg6CDJLU7Ee
	 cDCM0liZ+Jpw9T6VldFxb8R8vfeVr0Q7WZCXNhrZ1HoqSE8RwZFk1lBdMnEsMKL/0/
	 rYvFBUK7yJqmaF+nL5PbESTKUVbzksnfunumSBcwe7IFyh9Vp/DmcTCELXff2FrD+x
	 yLA4E1yFiJYdX/ca16Yp+5JUpZ8fieKyMZBljzR/z1310B6fmJbhAROcs4Dzjeac2f
	 w4bueSO1HAPK465Jyxi8RJfO87Aj/5ShQja+GslmRxqMfInxoJYo7M+QYRFDScEEXB
	 GLtQ/nyykkduw==
Date: Tue, 22 Sep 2026 20:31:45 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: Re: [RFC PATCH v3 16/27] KVM: SVM: Add handler for VMGEXIT Secure
 AVIC NAE event
Message-ID: <arKHLaVluCNCTaau@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
 <ao8PtliwDo8H49sa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao8PtliwDo8H49sa@google.com>

Hi Sean,

On Wed, Aug 26, 2026 at 09:09:26AM -0700, Sean Christopherson wrote:
> On Wed, Jul 08, 2026, Naveen N Rao (AMD) wrote:
> > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > 
> > [DO NOT MERGE]
> > 
> > VMGEXIT Secure AVIC NAE event is used by the guest for two purposes
> > determined by VMCB->EXITINFO1:
> > 1. SVM_VMGEXIT_SAVIC_REGISTER_GPA: Used to inform the hypervisor about
> >    the GPA of the page (RBX) being used as the Secure AVIC backing page.
> >    RAX indicates APIC ID of the target vCPU (-1 for self)
> > 2. SVM_VMGEXIT_SAVIC_UNREGISTER_GPA: Used to inform the hypervisor that
> >    the GPA is no longer being used as the backing page for Secure AVIC.
> >    The previously registered GPA for the Secure AVIC backing page is
> >    returned by the hypervisor to the guest.
> > 
> > The primary motivation behind these is to ensure that Secure AVIC
> > hardware accesses to the guest APIC backing page never generate an #NPF,
> > since Secure AVIC hardware cannot recover from such faults. Quoting the
> > APM:
> >   "It is required that the guest APIC backing page for a vCPU is
> >    pinned in system memory between VMRUN and VMEXIT because some AVIC
> >    hardware acceleration sequences may not be restartable when secure
> >    AVIC is enabled. If an access to the guest's own backing page by
> >    AVIC hardware results in a nested page fault, EXITINFO1 bit 63
> >    (Not Restartable) is set (this is an Automatic Exit) and the BUSY
> >    bit in the VMSA is set."
> > 
> > A guest vCPU that has the BUSY bit set in the VMSA cannot be restarted
> > and the guest will have to be killed.
> > 
> > One of the main reasons why the SPTE for a Secure AVIC backing page may
> > be invalidated is if it is backed by a huge page in the host, and an
> > adjacent page changes state forcing the huge page to be split. Currently
> > though, KVM uses guest_memfd to back SEV-SNP guest private memory, and
> > those only use 4k pages. As such, this _may_ not be an issue today.
> > 
> > It is possible that KVM may still invalidate an SPTE for other reasons -
> > those will need to be addressed.
> 
> As I said in PUCK, this is going to be painful to support, both now and in the
> future.  We _could_ get it working, but I'm not at all convinced that I want to
> commit to supporting Secure AVIC in its current form.

...

> Those are solvable problems, but I'm not exactly chomping at the bit to take on
> the complexity to support what IMO is a poorly designed feature.  There's a very
> good reason why control pages are referenced by their host PA in both the VMCS
> and VMCB.

As an update: I had a discussion with the hardware team about this.  My 
understanding so far is that this is by design, i.e., referencing the 
backing page by GPA (as against using an SPA) was intentional for 
specific micro-architectural reasons and the #NPF issue is a side-effect 
of that.

> 
> Though on a slightly happier note, I was wrong about KVM_X86_QUIRK_SLOT_ZAP_ALL.
> That quirk only applies to KVM_X86_DEFAULT_VM VMs, i.e. wouldn't need to be
> manually disabled for SNP.

Great!

> 
> And if we go with my suggestion[1] to force KVM_MEMSLOT_GMEM_ONLY when binding to
> a gmem instance with in-place conversion enabled, then the fix/optimization to
> ignore mmu_notifiers for gmem-only memslots will avoids spurious zaps on that
> front[2].

Nice, this has been the one path that I have been able to trigger a non 
restartable #NPF reliably in my testing so far. So, this will be 
definitely needed and I suppose this will imply a dependency on in-place 
conversion.

> 
> However, there are still problems.  E.g. when converting memory, userspace would
> need to make sure to never do a redundant/superfluous KVM_SET_MEMORY_ATTRIBUTES2
> on a range that contains a Secure AVIC page, because __kvm_gmem_set_attributes()
> will tell the MMU to invalidate SHARED mappings for the entire range.  I.e. by
> design, guest_memfd will not chunk the invalidations based on the per-page state
> of PRIVATE vs. SHARED, because cross-referencing the current attributes would
> incur non-trivial complexity.  For TDX, this isn't a problem because the S-EPT
> is a separate paging structure, and so kvm_gfn_range_filter_to_root_types() can
> simply skip MIRROR roots to avoid over-zapping PRIVATE memory.  SNP doesn't have
> such a thing.

I suppose this is one of the bigger concerns (next to ensuring all 
invalidation paths are covered). If I'm reading this right, I think your 
idea (thanks!) to skip zap'ing SPTEs for attribute updates addresses 
this path:
https://lore.kernel.org/all/ao9CKMXAX-hScRSa@google.com/

In fact, as far as I can tell, it likely also addresses the MMU Notifier 
path independently.

I believe the other larger concern was ensuring coverage so that there 
aren't surprises in a production deployment. I was thinking if a check 
for the Secure AVIC backing page GPA in sev_gmem_invalidate_range() 
(with a subsequent kvm_vm_dead() or such on a match) can serve as a way 
to ensure we aren't missing any paths, and to guard against future 
changes.

> 
> Converting a subset of a huge PRIVATE page would also be problematic, although
> that one isn't so bad since we already need to call into the TDP MMU to pre-split
> S-EPT pages, because those too can't tolerate spurious zappings.

For hugepages, the intent is to split as part of the Secure AVIC NAE 
Event for backing page registration. i.e., PSMASH()+prefault at the time 
of registration. And since there is no PUNSMASH(), the backing page 
should never end up as part of a hugepage again.


- Naveen
