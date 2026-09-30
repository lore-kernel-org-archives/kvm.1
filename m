Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934244B95CC;
	Wed, 30 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779649; cv=none; b=W+YTybW8cjjMROzaAuVHEoAVIVKeMVBxU7kR5EKaBaxnOWqFmZQs8A3ArWd2LwF233sUOnTkP73BIpqT50vYWFO9gKaYkQsaaSHBco19AjSSC+YCFZaTXJW3kapN2EXN9QzLz4dBKDF72x5upPu9nD/fikyvZqaONlZuOaAMWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779649; c=relaxed/simple;
	bh=eg1O4hp6ZGpH4Wox8SVMJUFhbsjB/6FWTwERFG76vkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEawC3nwfLFExnQtEmC/qkTpIFseBaA9X0f591Zd9vsk8p8ds2Tn34rKprib3JDXju5kR4GW57pHl/we6NYXzAXFXHm/Op4QjzpqJ12sewhLuEXR/Q/5zp8Odnh9Gh+k3a42VIeCtHjniAhPtwo7qoMJU6ewlKWagHZGrlcPe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU0wLhG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU0wLhG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CD71F000FF;
	Wed, 30 Sep 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779637;
	bh=XUqA+R/1TUTsmH/L3ACbrGDfVeU2HmhoSilR6GwX7O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YU0wLhG6t+JykqbrvEGZseSoBlujos4DULx7h0mqmrhTURY5WjljkA/XvDwbDEElP
	 s98Bnpj1+BL9Na6OKWFiI1QNfh3W84aWrRmXtxhtWxe6V59IhxRD3oAzovl86PuxOY
	 2MAthKZK34sXQJwsK4JUolZsturvizVvBWx23QUtybpWI4yfiEU8obyx6juf+Mupag
	 H6E/XnhvsLKI/sM/79dAhgTxc6i9VH2PQFOlnFfh5wLnitld0KJ6VnuFqLZnx5+iDC
	 Sb7J1E9pGiqBZw4nl0FxPddWU/pBUaIzcN7UM0oUEkW8c/jaLaG1pPy41seI3AlyRO
	 IrhJEQ2j2J8hA==
Date: Wed, 30 Sep 2026 20:13:59 +0530
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
Message-ID: <arzns-SbdhuGntwm@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <c0f9fdc27f3d9a1e63f2d39a40989d66b6facee3.1783490022.git.naveen@kernel.org>
 <ao8PtliwDo8H49sa@google.com>
 <arKHLaVluCNCTaau@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKHLaVluCNCTaau@blrnaveerao1>

On Tue, Sep 22, 2026 at 08:31:45PM +0530, Naveen N Rao wrote:
> Hi Sean,
> 
> On Wed, Aug 26, 2026 at 09:09:26AM -0700, Sean Christopherson wrote:
> > On Wed, Jul 08, 2026, Naveen N Rao (AMD) wrote:
> > > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > 
> > > [DO NOT MERGE]
> > > 
> > > VMGEXIT Secure AVIC NAE event is used by the guest for two purposes
> > > determined by VMCB->EXITINFO1:
> > > 1. SVM_VMGEXIT_SAVIC_REGISTER_GPA: Used to inform the hypervisor about
> > >    the GPA of the page (RBX) being used as the Secure AVIC backing page.
> > >    RAX indicates APIC ID of the target vCPU (-1 for self)
> > > 2. SVM_VMGEXIT_SAVIC_UNREGISTER_GPA: Used to inform the hypervisor that
> > >    the GPA is no longer being used as the backing page for Secure AVIC.
> > >    The previously registered GPA for the Secure AVIC backing page is
> > >    returned by the hypervisor to the guest.
> > > 
> > > The primary motivation behind these is to ensure that Secure AVIC
> > > hardware accesses to the guest APIC backing page never generate an #NPF,
> > > since Secure AVIC hardware cannot recover from such faults. Quoting the
> > > APM:
> > >   "It is required that the guest APIC backing page for a vCPU is
> > >    pinned in system memory between VMRUN and VMEXIT because some AVIC
> > >    hardware acceleration sequences may not be restartable when secure
> > >    AVIC is enabled. If an access to the guest's own backing page by
> > >    AVIC hardware results in a nested page fault, EXITINFO1 bit 63
> > >    (Not Restartable) is set (this is an Automatic Exit) and the BUSY
> > >    bit in the VMSA is set."
> > > 
> > > A guest vCPU that has the BUSY bit set in the VMSA cannot be restarted
> > > and the guest will have to be killed.
> > > 
> > > One of the main reasons why the SPTE for a Secure AVIC backing page may
> > > be invalidated is if it is backed by a huge page in the host, and an
> > > adjacent page changes state forcing the huge page to be split. Currently
> > > though, KVM uses guest_memfd to back SEV-SNP guest private memory, and
> > > those only use 4k pages. As such, this _may_ not be an issue today.
> > > 
> > > It is possible that KVM may still invalidate an SPTE for other reasons -
> > > those will need to be addressed.
> > 
> > We _could_ get it working, <snip>

I spent some time to see what this would look like, given that in-place 
conversion has now landed.

> > 
> > However, there are still problems.  E.g. when converting memory, userspace would
> > need to make sure to never do a redundant/superfluous KVM_SET_MEMORY_ATTRIBUTES2
> > on a range that contains a Secure AVIC page, because __kvm_gmem_set_attributes()
> > will tell the MMU to invalidate SHARED mappings for the entire range.  I.e. by
> > design, guest_memfd will not chunk the invalidations based on the per-page state
> > of PRIVATE vs. SHARED, because cross-referencing the current attributes would
> > incur non-trivial complexity.  For TDX, this isn't a problem because the S-EPT
> > is a separate paging structure, and so kvm_gfn_range_filter_to_root_types() can
> > simply skip MIRROR roots to avoid over-zapping PRIVATE memory.  SNP doesn't have
> > such a thing.
> 
> I suppose this is one of the bigger concerns (next to ensuring all 
> invalidation paths are covered). If I'm reading this right, I think 
> your idea (thanks!) to skip zap'ing SPTEs for attribute updates 
> addresses this path:
> https://lore.kernel.org/all/ao9CKMXAX-hScRSa@google.com/
> 
> In fact, as far as I can tell, it likely also addresses the MMU Notifier 
> path independently.

I can confirm that your suggested change above on the current 
kvm-x86/next tree with gmem in-place conversion enabled addresses MMU 
notifier events as well (so Alexandru's patch isn't strictly necessary).

I ended up with a slightly updated if condition to restrict it to SNP:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aadd5bdc2c97..195732dbdcce 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1702,6 +1702,7 @@ static bool __kvm_rmap_zap_gfn_range(struct kvm *kvm,

 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+       unsigned long shared_private =  KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
        bool flush = false;

        /*
@@ -1715,6 +1716,21 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
        lockdep_assert_once(kvm->mmu_invalidate_in_progress ||
                            lockdep_is_held(&kvm->slots_lock));

+       /*
+        * Skip zapping pages for to-PRIVATE/to-SHARED conversions for
+        * VMs with non-mirrored roots (SEV-SNP) since the mismatch
+        * between the NPT entry and the HW attribute (RMP) will force
+        * a #NPF, and the subsequent KVM page fault handler or the
+        * RMP fault handler will do the right thing.
+        *
+        * TODO: handle hugepages.
+        */
+       if (gmem_in_place_conversion && kvm_memslot_is_gmem_only(range->slot) &&
+           kvm_arch_has_private_mem(kvm) && kvm->arch.has_protected_state &&
+           !kvm_has_mirrored_tdp(kvm) &&
+           ((range->attr_filter & shared_private) != shared_private))
+               return false;
+

> 
> I believe the other larger concern was ensuring coverage so that there 
> aren't surprises in a production deployment. I was thinking if a check 
> for the Secure AVIC backing page GPA in sev_gmem_invalidate_range() 
> (with a subsequent kvm_vm_dead() or such on a match) can serve as a way 
> to ensure we aren't missing any paths, and to guard against future 
> changes.

With the below hunk, I think we should be able to catch invalidations 
due to PUNCH_HOLE, HWPOISON, memslot DELETE and to-SHARED conversions, 
and should help make the source of the invalidation clear:

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 96992d10cb2b..3c8daa876045 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5571,11 +5571,36 @@ void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
                 * vCPU to re-establish its VMSA.
                 */
                gpa_t gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_vmsa_gpa);
+               gpa_t savic_gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_guest_savic_gpa);

                if (VALID_PAGE(gpa) &&
                    gpa_to_gfn(gpa) >= range->start &&
                    gpa_to_gfn(gpa) < range->end)
                        kvm_make_request_and_kick(KVM_REQ_VMSA_PAGE_RELOAD, vcpu);
+
+               /*
+                * All PRIVATE invalidations that hit the Secure AVIC backing page in
+                * this path will result in a subsequent access by the Secure AVIC HW
+                * to cause a not-restartable #NPF killing the VM. Catch such
+                * invalidations here so that the source of those invalidations is
+                * clear, rather than a subsequent guest access resulting in a
+                * unrecoverable #NPF.
+                *
+                * This is expected on guest teardown, so check if there is a valid
+                * gmem.file before killing the VM.
+                */
+               if (VALID_PAGE(savic_gpa) &&
+                   READ_ONCE(range->slot->gmem.file) &&
+                   (range->attr_filter & KVM_FILTER_PRIVATE) &&
+                   gpa_to_gfn(savic_gpa) >= range->start &&
+                   gpa_to_gfn(savic_gpa) < range->end) {
+                       if (!kvm->vm_dead) {
+                               vcpu_err(vcpu, "Secure AVIC backing page invalidated, GPA 0x%llx!\n", savic_gpa);
+                               dump_stack();
+                               kvm_vm_dead(vcpu->kvm);
+                               return;
+                       }
+               }
        }
 }


The flip side is that this also catches memslot DELETE, which I suppose 
is something we still need to handle (as part of memslot DELETE+CREATE).
In my limited testing so far, I have not been able to hit a scenario 
where this has triggered, so I am not sure how critical or common that 
is during runtime (memslot changes before guest boot should be ok since 
Secure AVIC is not enabled at that point).

One option is to use the below KVM_REQ for memslot DELETE so that the 
target vCPU is kicked out before the invalidation and faults during a 
subsequent prefault (should go out to userspace, but needs to be 
checked). Regardless, we will need some way to suppress the kill in 
gmem_invalidate_range() above for a memslot DELETE.

> 
> > 
> > Converting a subset of a huge PRIVATE page would also be problematic, although
> > that one isn't so bad since we already need to call into the TDP MMU 
> > to pre-split
> > S-EPT pages, because those too can't tolerate spurious zappings.
> 
> For hugepages, the intent is to split as part of the Secure AVIC NAE 
> Event for backing page registration. i.e., PSMASH()+prefault at the time 
> of registration. And since there is no PUNSMASH(), the backing page 
> should never end up as part of a hugepage again.

Regardless of hugepage support, we will still need to prefault the 
backing page on registration to ensure Secure AVIC HW accesses do not 
fault. In addition, it looks like we will also need to prefault the page 
whenever a new NPT root is loaded. This turned out to be the larger 
change and I modeled part of this on KVM_REQ_VMSA_PAGE_RELOAD (diff 
below).

In the absence of hugepage support, this _looks_ to be addressing all 
the invalidation sources (other than memslot DELETE that I mentioned 
earlier) at this time, as far as I can tell.

Are there other invalidation sources we should worry about?

If we want to be super-paranoid, we could add some sort of a hook in 
__handle_changed_spte() though that looks excessive. Hooking into 
kvmmmu/kvm_tdp_mmu_spte_changed tracepoint instead might be a better 
option if we ever hit an unexpected not-restartable #NPF.


Thanks,
Naveen


---
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e456564f83da..8f26cf4cbfc0 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -119,6 +119,7 @@ KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
 KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
 KVM_X86_OP_OPTIONAL(protected_apic_has_interrupt)
 KVM_X86_OP_OPTIONAL(protected_apic_process_interrupt)
+KVM_X86_OP_OPTIONAL_RET0(protected_apic_page_reload)
 KVM_X86_OP_OPTIONAL(set_hv_timer)
 KVM_X86_OP_OPTIONAL(cancel_hv_timer)
 KVM_X86_OP(setup_mce)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0e0726cb75f8..e4b880bc68f5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -128,6 +128,8 @@
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
 #define KVM_REQ_PROTECTED_APIC_INTERRUPT	KVM_ARCH_REQ(35)
+#define KVM_REQ_PROTECTED_APIC_PAGE_RELOAD \
+	KVM_ARCH_REQ_FLAGS(36, KVM_REQUEST_WAIT)
 
 #define INVALID_PAGE (~(hpa_t)0)
 #define VALID_PAGE(x) ((x) != INVALID_PAGE)
@@ -1702,6 +1704,7 @@ struct kvm_x86_ops {
 	bool (*dy_apicv_has_pending_interrupt)(struct kvm_vcpu *vcpu);
 	bool (*protected_apic_has_interrupt)(struct kvm_vcpu *vcpu);
 	void (*protected_apic_process_interrupt)(struct kvm_vcpu *vcpu);
+	int (*protected_apic_page_reload)(struct kvm_vcpu *vcpu);
 
 	int (*set_hv_timer)(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 			    bool *expired);
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf8..0b611f3f5a21 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -340,6 +340,7 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 }
 
 int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
+int kvm_tdp_mmu_prefault_private_gpa(struct kvm_vcpu *vcpu, gpa_t gpa);
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 779cd1013f02..72d30df67795 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -273,7 +273,8 @@ struct vcpu_sev_es_state {
 
 	u64 ghcb_registered_gpa;
 
-	gpa_t snp_savic_gpa;
+	gpa_t snp_pending_savic_gpa;
+	gpa_t snp_guest_savic_gpa;
 
 	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
 	gpa_t snp_pending_vmsa_gpa;
@@ -1028,6 +1029,7 @@ int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
 bool snp_is_secure_avic_enabled(struct kvm *kvm);
+int snp_protected_apic_page_reload(struct kvm_vcpu *vcpu);
 #else
 static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
 {
@@ -1056,6 +1058,7 @@ static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 }
 static inline void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa) {}
 static inline bool snp_is_secure_avic_enabled(struct kvm *kvm) { return false; }
+static inline int snp_protected_apic_page_reload(struct kvm_vcpu *vcpu) { return 0; }
 #endif
 
 /* vmenter.S */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 195732dbdcce..a83a1c8ca950 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5327,6 +5327,15 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
+
+int kvm_tdp_mmu_prefault_private_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	if (KVM_BUG_ON(kvm_is_gfn_alias(vcpu->kvm, gpa >> PAGE_SHIFT), vcpu->kvm))
+		return -EINVAL;
+
+	return kvm_tdp_page_prefault(vcpu, gpa, PFERR_GUEST_FINAL_MASK | PFERR_PRIVATE_ACCESS, NULL);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_prefault_private_gpa);
 #endif
 
 static void nonpaging_init_context(struct kvm_mmu *context)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f2156850d346..96992d10cb2b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4595,11 +4595,95 @@ static int savic_handle_ipi_exit(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+int snp_protected_apic_page_reload(struct kvm_vcpu *vcpu)
+{
+	gpa_t gpa = READ_ONCE(to_svm(vcpu)->sev_es.snp_pending_savic_gpa);
+	int ret;
+
+	/*
+	 * At this point, it is safe to commit the new backing page GPA.
+	 * If replacing a valid GPA, it is up to the guest to ensure that
+	 * the previous backing page GPA has been cleared from the Secure
+	 * AVIC Control MSR before trying to register a new one as
+	 * invalidations will no longer care for the previous GPA.
+	 *
+	 * Publish the GPA under mmu_lock before prefaulting it so that
+	 * no invalidations go through after the prefault.
+	 */
+	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+		WRITE_ONCE(to_svm(vcpu)->sev_es.snp_guest_savic_gpa, gpa);
+
+	/* Unregistration */
+	if (gpa == INVALID_PAGE)
+		return 0;
+
+	ret = kvm_tdp_mmu_prefault_private_gpa(vcpu, gpa);
+
+	if (ret == -EINTR)
+		kvm_handle_signal_exit(vcpu);
+
+	if (ret) {
+		kvm_make_request(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, vcpu);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int savic_handle_vmgexit_register_gpa(struct kvm_vcpu *target_vcpu, gpa_t gpa)
+{
+	struct kvm *kvm = target_vcpu->kvm;
+	struct kvm_memory_slot *slot;
+	unsigned long mmu_seq;
+	int order, rmp_level, ret;
+	kvm_pfn_t pfn;
+	bool assigned;
+	gfn_t gfn;
+
+	gfn = gpa >> PAGE_SHIFT;
+
+	if (!page_address_valid(target_vcpu, gpa))
+		return -EINVAL;
+
+retry:
+	cond_resched();
+
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	slot = gfn_to_memslot(kvm, gfn);
+	if (!kvm_is_private_gfn(kvm, gfn) || !kvm_slot_has_gmem(slot))
+		return -EINVAL;
+
+	ret = kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &order);
+	if (ret)
+		return -EINVAL;
+
+	ret = snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
+	if (ret || !assigned) {
+		guard(read_lock)(&kvm->mmu_lock);
+
+		if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn))
+			goto retry;
+
+		return -EINVAL;
+	}
+
+	if (WARN_ON_ONCE(rmp_level != PG_LEVEL_4K))
+		return -EOPNOTSUPP;
+
+	WRITE_ONCE(to_svm(target_vcpu)->sev_es.snp_pending_savic_gpa, gpa);
+	kvm_make_request_and_kick(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, target_vcpu);
+
+	return 0;
+}
+
 static int sev_handle_savic_vmgexit(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *target_vcpu;
 	u64 apic_id;
 	gpa_t gpa;
+	int ret;
 
 	apic_id = kvm_rax_read_raw(&svm->vcpu);
 	if (apic_id != SVM_VMGEXIT_SAVIC_SELF_GPA && upper_32_bits(apic_id))
@@ -4616,27 +4700,14 @@ static int sev_handle_savic_vmgexit(struct vcpu_svm *svm)
 	switch (svm->vmcb->control.exit_info_1) {
 	case SVM_VMGEXIT_SAVIC_REGISTER_GPA:
 		gpa = kvm_rbx_read_raw(&svm->vcpu);
-		if (!page_address_valid(target_vcpu, gpa))
+		ret = savic_handle_vmgexit_register_gpa(target_vcpu, gpa);
+		if (ret)
 			goto vmgexit_err;
-
-		/*
-		 * TODO: Ensure that guest (Secure AVIC hardware) accesses
-		 * to the guest APIC backing page can never cause an #NPF.
-		 */
-
-		/*
-		 * Don't bother using any synchronization here if updating the
-		 * GPA for a different vCPU, to guard against potential
-		 * concurrent requests from different guest vCPUs. KVM's
-		 * handling for this will inform what synchronization,
-		 * if any will be necessary.
-		 */
-		to_svm(target_vcpu)->sev_es.snp_savic_gpa = gpa;
 		break;
 	case SVM_VMGEXIT_SAVIC_UNREGISTER_GPA:
-		gpa = to_svm(target_vcpu)->sev_es.snp_savic_gpa;
+		gpa = xchg(&to_svm(target_vcpu)->sev_es.snp_pending_savic_gpa, INVALID_PAGE);
 		kvm_rbx_write_raw(&svm->vcpu, gpa == INVALID_PAGE ? 0 : gpa);
-		to_svm(target_vcpu)->sev_es.snp_savic_gpa = INVALID_PAGE;
+		kvm_make_request_and_kick(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, target_vcpu);
 		break;
 	default:
 		goto vmgexit_err;
@@ -5076,7 +5147,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
-	svm->sev_es.snp_savic_gpa = INVALID_PAGE;
+	svm->sev_es.snp_pending_savic_gpa = INVALID_PAGE;
+	svm->sev_es.snp_guest_savic_gpa = INVALID_PAGE;
 
 	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 18d061a157c2..6909d2c645a9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2008,7 +2008,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 
 	u64 error_code = svm->vmcb->control.exit_info_1;
 	gpa_t gpa = svm->vmcb->control.exit_info_2;
-	gpa_t savic_gpa = svm->sev_es.snp_savic_gpa;
+	gpa_t savic_gpa = svm->sev_es.snp_guest_savic_gpa;
 
 	if (error_code & PFERR_SNP_NOT_RESTARTABLE_MASK) {
 		if (VALID_PAGE(savic_gpa) && (gpa_to_gfn(gpa) == gpa_to_gfn(savic_gpa)))
@@ -4848,6 +4848,9 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 		hv_track_root_tdp(vcpu, root_hpa);
 
 		cr3 = vcpu->arch.cr3;
+
+		if (snp_is_secure_avic_enabled(vcpu->kvm))
+			kvm_make_request(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, vcpu);
 	} else if (root_level >= PT64_ROOT_4LEVEL) {
 		cr3 = __sme_set(root_hpa) | kvm_get_active_pcid(vcpu);
 	} else {
@@ -5597,6 +5600,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.protected_apic_has_interrupt = avic_protected_apic_has_interrupt,
 	.protected_apic_process_interrupt = avic_protected_apic_process_interrupt,
+	.protected_apic_page_reload = snp_protected_apic_page_reload,
 
 	.get_exit_info = svm_get_exit_info,
 	.get_entry_info = svm_get_entry_info,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3384a1b215ef..897dca49e2c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8240,6 +8240,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_PROTECTED_APIC_INTERRUPT, vcpu))
 			kvm_x86_call(protected_apic_process_interrupt)(vcpu);
+
+		if (kvm_check_request(KVM_REQ_PROTECTED_APIC_PAGE_RELOAD, vcpu)) {
+			r = kvm_x86_call(protected_apic_page_reload)(vcpu);
+			if (r)
+				goto out;
+		}
 	}
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||


