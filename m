Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7B379C35;
	Wed, 30 Sep 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798234; cv=none; b=OLJm5+R33XReo6AFVbZAGYW5UTH7iNBootRHRp62xRmJ7A16vWnVbPOY/qd4jWQIEfW/Tn7EiU0tHM8A4dVQsGwAxDlaDYiUq3mwganhFd5r/qr/eEa7lW8XfQgZiSQ3whHLvPIUjKJ1CobXV8dByO+4g9CIU9ZQIUZ95Esck9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798234; c=relaxed/simple;
	bh=NIQo32u6KMXjjBDmY23aM4EFAUt+Tpskl7S9pgqXlSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaDsZOn8pVWZtm6NeJBtIXM53y8R9zAsHcc1FP51NQ4pmAC8GX+fdBNhQMX6tPM0ez9oYvl1EtSXV/5Z6PGf34qCdLANbdfTFRAG++t9O1DEQW84jCvSWXlJQVjvQ0wCzSzfwISXZuUsFNVblqe6sVnMtnAbGa9Bb5b0jo15T9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3J/HT9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3J/HT9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64BF1F000FF;
	Wed, 30 Sep 2026 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798232;
	bh=Zci62Ci/qN71IHaF9itQKeiUV4naisEmSdcOgW7bHpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k3J/HT9yTM93ZR+WShg2JPoA3J+jAR+S5rVaeeNK/LA84ETdRKBAbWXmjjcBi0zbR
	 bbuZ+IkFAsQHUp/Hl0eXLNRvmKsizVcg1b8wasSRmqbwisAZKa50zHx6A3ohS4wxZU
	 AnBD8dR4f2Gx1OjsMvTVgtp5XVTQ3pRg0zDLMqqqzkl9zUGijjX+Z4uVPkGlFjJe6b
	 OpKs/P10OCvBt0UukuKr9rmAI3W5BC3wn9MfrEfKvqkXBgf7eNW+w1pK4pMZHj/nrH
	 PQKYefuL1kSTK3aIvMC6NhMFFWnDhXj+lt9W4cH1YDoxyGpGXR2yZ9MReFPaZygxOg
	 dgH9mp7bkGOEw==
Date: Thu, 1 Oct 2026 01:24:59 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Tianyu Lan <tiala@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Michael Roth <michael.roth@amd.com>
Subject: Re: [RFC PATCH v3 16/27] KVM: SVM: Add handler for VMGEXIT Secure
 AVIC NAE event
Message-ID: <ar0yoCb7Zl9HCzjl@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
 <ao8PtliwDo8H49sa@google.com>
 <arKHLaVluCNCTaau@blrnaveerao1>
 <arzns-SbdhuGntwm@blrnaveerao1>
 <ar0ul9g3bvHI3VOV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar0ul9g3bvHI3VOV@google.com>

On Wed, Sep 30, 2026 at 08:45:27AM -0700, Sean Christopherson wrote:
> On Wed, Sep 30, 2026, Naveen N Rao wrote:
> > On Tue, Sep 22, 2026 at 08:31:45PM +0530, Naveen N Rao wrote:
> > With the below hunk, I think we should be able to catch invalidations 
> > due to PUNCH_HOLE, HWPOISON, memslot DELETE and to-SHARED conversions, 
> > and should help make the source of the invalidation clear:
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 96992d10cb2b..3c8daa876045 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -5571,11 +5571,36 @@ void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
> >                  * vCPU to re-establish its VMSA.
> >                  */
> >                 gpa_t gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa);
> > +               gpa_t savic_gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_savic_gpa);
> > 
> >                 if (VALID_PAGE(gpa) &&
> >                     gpa_to_gfn(gpa) >= range->start &&
> >                     gpa_to_gfn(gpa) < range->end)
> >                         kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
> > +
> > +               /*
> > +                * All PRIVATE invalidations that hit the Secure AVIC backing page in
> > +                * this path will result in a subsequent access by the Secure AVIC HW
> > +                * to cause a not-restartable #NPF killing the VM. Catch such
> > +                * invalidations here so that the source of those invalidations is
> > +                * clear, rather than a subsequent guest access resulting in a
> > +                * unrecoverable #NPF.
> > +                *
> > +                * This is expected on guest teardown, so check if there is a valid
> > +                * gmem.file before killing the VM.
> > +                */
> > +               if (VALID_PAGE(savic_gpa) &&
> > +                   READ_ONCE(range->slot->gmem.file) &&
> > +                   (range->attr_filter & KVM_FILTER_PRIVATE) &&
> > +                   gpa_to_gfn(savic_gpa) >= range->start &&
> > +                   gpa_to_gfn(savic_gpa) < range->end) {
> > +                       if (!kvm->vm_dead) {
> > +                               vcpu_err(vcpu, "Secure AVIC backing page invalidated, GPA 0x%llx!\n", savic_gpa);
> > +                               dump_stack();
> > +                               kvm_vm_dead(vcpu->kvm);
> > +                               return;
> > +                       }
> > +               }
> 
> This is beyond gross.

Ack, and to be perfectly clear: this change is not required.

I added this only to address concerns raised during PUCK that 
invalidation sources may not be evident if we take a not-restartable 
#NPF.

In reality, if we address memslot DELETE, all the other invalidation 
sources that reach here are already destructive to the VM (PUNCH_HOLE, 
MCE/HWPOISON and to-SHARED conversions) and point at a buggy guest/VMM 
(or HW in the case of MCE).

Hmm.. that made me think I may have got this backwards. This hook was 
added for VMSA reload to address PUNCH_HOLE, so I ended up using it for 
that purpose. But, it probably makes better sense to handle the 
invalidation from a memslot DELETE here, rather than BUG the VM. This 
hook is called on that path before the pages are zapped, so a KVM_REQ 
here might just be what we need to handle that.

Untested, but something like this instead (will look at this more 
tomorrow)?

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 96992d10cb2b..22b3f9fcac74 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5571,11 +5571,25 @@ void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 		 * vCPU to re-establish its VMSA.
 		 */
 		gpa_t gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa);
+		gpa_t savic_gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_savic_gpa);
 
 		if (VALID_PAGE(gpa) &&
 		    gpa_to_gfn(gpa) >= range->start &&
 		    gpa_to_gfn(gpa) < range->end)
 			kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
+
+		/*
+		 * For invalidations that hit the Secure AVIC backing page, kick the
+		 * vCPU out and queue a KVM_REQ to have the backing page prefaulted.
+		 * For memslot DELETE+CREATE, the vCPU won't re-enter the guest until
+		 * the memslot is re-created. For other destructive operations
+		 * (PUNCH_HOLE, HWPOISON, SHARED conversion), the VM is dead
+		 * regardless.
+		 */
+		if (VALID_PAGE(savic_gpa) &&
+		    gpa_to_gfn(savic_gpa) >= range->start &&
+		    gpa_to_gfn(savic_gpa) < range->end)
+			kvm_make_request_and_kick(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, vcpu);
 	}
 }
  

- Naveen

