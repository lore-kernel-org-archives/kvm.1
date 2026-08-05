Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A93361656;
	Wed,  5 Aug 2026 00:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889593; cv=none; b=mb4KnKPOO/CxOyu9sbDHnhVuZpkLoV8tPDURJbf3XtaixSXqiGj78J2uw9DDO8kJI/53PFOHfT3l20hsnyFqA05VixayLSinHvAqjyae6TVSUcnwO82M4LWQD+se9qWwYuxKLDhTlUA9QTGwj4PRTga0NjlvXqn1Nb/xUz92V5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889593; c=relaxed/simple;
	bh=6Y0ruCQjRIvcf8jHEUAWAjqppP1l0nwcYkyefZg1tIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyju1t4Hqxp24ou8TEDk6zaoJumuV5TjPsmpx3vJFqqf1ItfXYC877LYTkSZIk5fhWMA/Umu7GjTOJHbyf/0TRY5fmThpEj3MMQO4uQMZWHO7FToaXcBzSyOaHiSanx357Xc8SlzBqPoEqLfHhpeblIPdzU1nj15PjV2k6l4310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZrXRkQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZrXRkQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E6B1F000E9;
	Wed,  5 Aug 2026 00:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785889591;
	bh=ZqtlKU4cY58dPY9pNqRL9ZuGSGU+dBaCUPyiHskq3Tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hZrXRkQdM/8rJ+iyu+DnBYb8cbVCcmRRbaA/N8BKBLJV6TDrsUvpm/uLr57Da82XE
	 H/2nESR+WKvoz/4zkBI6is01ZcZjYskrAXX1T+JJ0uWIuFnYDuW9pNn/nElgR00BDm
	 A6bSQ/knvhcbNxR3m19dd7mzBoVUckODReloF+xpweDKdP/exnSLoCEG1dGSwCbB64
	 wLWrInsBiRPOQzinmbo90q7lyr+hUhqHGQBYjdRLgv2oN4BJUD6OhjUO6Qi9XTfpn4
	 0dB+JTV8xTCPO6zpHWHnL2v3HciUr+3yn0usQPDomCKTBKzbRmKKdUh2AiFUm8i+rN
	 m6mGTnuxZpY2g==
Date: Wed, 5 Aug 2026 00:26:30 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/28] KVM: nSVM: Add a placeholder ASID for L2
Message-ID: <anKCocdyhY6PFT3l@google.com>
References: <20260728003557.1136583-1-yosry@kernel.org>
 <20260728003557.1136583-13-yosry@kernel.org>
 <CAO9r8zPoeV6H61vwO06Wj=ed+5_tUC8LVqEf=zp-U-axvxNt3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zPoeV6H61vwO06Wj=ed+5_tUC8LVqEf=zp-U-axvxNt3g@mail.gmail.com>

On Fri, Jul 31, 2026 at 11:34:34PM -0700, Yosry Ahmed wrote:
> On Mon, Jul 27, 2026 at 5:36 PM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > In preparation for introducing a separate ASID for L2, introduce a
> > 'placeholder' ASID that is still the same as L1's ASID. This will
> > facilitate future changes that need to distinguish L1 and L2's ASIDs,
> > before actually using a different ASID for L1 and L2.
> >
> > No functional change intended.
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 5 +++--
> >  arch/x86/kvm/svm/svm.h    | 2 ++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index ed4af5a08f794..eb60d6b959d86 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -698,7 +698,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
> >          *  - Honor L1's request to flush an ASID on nested VMRUN
> >          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
> >          *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> > -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
> >          *
> >          * [*] Unlike nested EPT, SVM's ASID management can invalidate nested
> >          *     NPT guest-physical mappings on VMRUN.
> > @@ -928,7 +927,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
> >         else
> >                 vmcb02->control.bus_lock_counter = 0;
> >
> > -       vmcb02->control.asid = vmcb01->control.asid;
> > +       vmcb02->control.asid = svm->nested.asid02;
> >
> >         /* Overwritten later if necessary.  */
> >         vmcb_clr_flush_asid(vmcb02);
> > @@ -1498,6 +1497,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
> >         if (!svm->nested.msrpm)
> >                 goto err_free_vmcb02;
> >
> > +       svm->nested.asid02 = svm->asid;
> > +
> 
> From internal Sashiko:
> ---
> Does caching the ASID here risk leaving nested.asid02 stale during an
> intra-host SEV VM migration?
> 
> If userspace restores EFER.SVME on a destination vCPU before completing
> the migration, svm_allocate_nested() is called and nested.asid02 is
> initialized with a normal non-SEV TLB tag.
> 
> Later, when KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM completes the migration,
> sev_migrate_from() updates the primary ASID but misses this new
> nested.asid02 field:
> 
> arch/x86/kvm/svm/sev.c:sev_migrate_from() {
>         ...
>         dst_svm->asid = dst->asid;
>         sev_init_vmcb(dst_svm, false);
>         ...
> }
> 
> When L1 subsequently executes VMRUN to enter L2,
> nested_vmcb02_prepare_control() will assign this stale non-SEV
> nested.asid02 to vmcb02->control.asid.
> 
> Does this mismatch cause L2 to run with an invalid non-SEV ASID while the
> VMCB's SEV bit is set, resulting in an unconditional #VMEXIT_INVALID
> hardware fault?
> ---
> 
> I am starting to hate SEV..
> 
> This would also be correct if the vCPUs are created on the destination
> VM before it's marked as an SEV VM. This is a recurring theme at this
> point.

So for this problem and the other two SEV migration problems reported in
patch #10, I am thinking we end up with something like this over both
patches (untested) -- any feedback would be appreciated as I have ~0
knowledge of SEV and ~0 testing capabilities:

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 087d18a5eda69..09a0572996352 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2019,6 +2019,29 @@ static void sev_unlock_two_vms(struct kvm *dst_kvm, struct kvm *src_kvm)
        atomic_set_release(&src_sev->migration_in_progress, 0);
 }

+static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm, struct vcpu_svm *src_svm,
+                                 unsigned int asid)
+{
+       /*
+        * Free the (potentially non-SEV) ASID on the destination vCPU before
+        * setting the new SEV ASID. Clear the ASID on the source vCPU to avoid
+        * mistakenly attempting to free an SEV ASID after the vCPU is no longer
+        * an SEV vCPU.
+        */
+       free_asid(dst_svm->asid);
+       dst_svm->asid = asid;
+       src_svm->asid = 0;
+
+       /*
+        * If nested is already initialized on the destination vCPU, update the
+        * nested ASID as well to match the new SEV ASID.
+        */
+       if (dst_svm->nested.vmcb02.ptr) {
+               dst_svm->nested.asid02 = asid;
+               dst_svm->nested.vmcb02.ptr->control.asid = asid;
+       }
+}
+
 static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
 {
        struct kvm_sev_info *dst = to_kvm_sev_info(dst_kvm);
@@ -2071,12 +2094,6 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
        kvm_for_each_vcpu(i, dst_vcpu, dst_kvm) {
                dst_svm = to_svm(dst_vcpu);

-               dst_svm->asid = dst->asid;
-               sev_init_vmcb(dst_svm, false);
-
-               if (!dst->es_active)
-                       continue;
-
                /*
                 * Note, the source is not required to have the same number of
                 * vCPUs as the destination when migrating a vanilla SEV VM.
@@ -2084,6 +2101,12 @@ static void sev_migrate_from(struct kvm *dst_kvm, struct kvm *src_kvm)
                src_vcpu = kvm_get_vcpu(src_kvm, i);
                src_svm = to_svm(src_vcpu);

+               sev_vcpu_migrate_asid(dst_svm, src_svm, dst->asid);
+               sev_init_vmcb(dst_svm, false);
+
+               if (!dst->es_active)
+                       continue;
+
                /*
                 * Transfer VMSA and GHCB state to the destination.  Nullify and
                 * clear source fields as appropriate, the state now belongs to

