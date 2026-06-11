Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1613C408609
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191385; cv=none; b=OKf9TNnLSPFZc2qxbLypV7H5XmsBTH7aMnWP1YsE+vg0PLGF5fRmsdYpbKDoYU5IhHDHQfuvGOX6gpaKC9j5T6pFg9fDzIertSKoPbBTIlJOY5MFB5Q6i56aZ2i3j/x0Iej85weFaOiH7lW837ilXqZ52sPY/1aH97U2zbAmnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191385; c=relaxed/simple;
	bh=LvmEmn/d02UPDwvFAncBmm6/Z2kX0bNBhbIcZG0qB7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmnQ2x5FNIXXbK2wDKKs2BDq37UtpAe4DNIkHOULEmrvhX/Ju7O4Juvl91nPbRjy4IKAdm4fonCHx2JL+BJ2Gv0iOVGYYRiEr/zpclRn3bLVctdJIcaxMS+Q5HZD7pZ54QwOKDkMXvOJpwDZ732VGfYYB6qTWRLN1avgR+Gh624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UriHnWVw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UriHnWVw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bcfce8a33so951894a91.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781191381; x=1781796181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ACd4Dl5+KeXNBoEpmyZuLt1AdhrL5Oj9s/Y4Gv5hU=;
        b=UriHnWVwGzZMpXcaavhyRrdUzSdK5zbBEgX3tr/UGo20Y6CA/0NvkdhGK2ouAL0Gl2
         HL6A5cSIVHEnEyYXq9g44MOjM8koSLzXpwcwXSmuD8g9mJLXjX+9K94LWjde9g+rDSj8
         iuPoa56IkIr6X2XKv+ltcW1rkiIF/mO4yHsJg7vtLgb4RtGeQ5vVgmVpw3vNzpW9J1JO
         ulhl87gCtfnT1qU0ruvYBBLWjB5dq7526k32DBaEidTrrKy0aBY4oeZbLEM2PTed0uiV
         DXRRBOh1/78m4GHOE0igaLBrDaVQNmQzRQ8nNneY94uHUdhhQXfmCuAqhuydSsSdtmCN
         6VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191381; x=1781796181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9ACd4Dl5+KeXNBoEpmyZuLt1AdhrL5Oj9s/Y4Gv5hU=;
        b=qZqXy0XYSPJJrSMvSAZt2vP4BumY/zhaChU1+F+uUgAivzPFmsJj/6nZQ+J2RFCqgd
         J0ukcyuVqu/TouhGPG4ZIfoAOPvWNtuyC2ILHYtTfJ/J09VcLweRVBJQlYMw7vdZwZ0p
         1Igr7vb6K6qEovoQfaLlMipKcm/QRLM2fhgrMzLIELtr6bR2OF0PFFFSc0PACmkkGcIg
         G70/OvDmvMhoqUAyNOgqkWhyexXtzbwPUdSKEPFLBdWA4FSXxTrRXAAp/vogsQiOrpUS
         xU4Ab6ldvPwHhIQ55Uz3vWvkeVVtsjzvadTwkXZWorxtPVGs0RRPDHoo614yDnTbfFnn
         iCnw==
X-Forwarded-Encrypted: i=1; AFNElJ9qgsrM9s2JutdLtA7ZHHIkfns1D+uqAUDqE9pu/lipOgr4j3XsVL6QzUGqP7Fehy71lyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SzH0waq1wa8OOczvYj3JMxIwemW7Dgj+g40fyJlclA+qHwn2
	3vClyZoEcs7l/v4hMG5nDz/CpYwpQChnOsiEMkJpsX1vyEInFBTUxZ8vBrI3AoVEdZtgHKKFmeh
	BwlJmtg==
X-Received: from pgv38.prod.google.com ([2002:a63:1566:0:b0:c7f:c4f1:ae17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38ce:b0:369:7491:7b24
 with SMTP id 98e67ed59e1d1-377eba825f0mr2732063a91.6.1781191380757; Thu, 11
 Jun 2026 08:23:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:23:00 -0700
In-Reply-To: <airAthcKDZeDfzXS@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aimMWzAf5b3luM0b@v4bel> <wxamg6zqn2qmsci2fwfepbqou5vtgydqmonr67mu7b73nkakbe@zedss5vzeci3>
 <aiqNPBQzoU9f8RwI@v4bel> <aiqueNUndQsbMNud@google.com> <airAthcKDZeDfzXS@v4bel>
Message-ID: <airS1G23atiuWdTl@google.com>
Subject: Re: [PATCH] KVM: SEV: Don't return a still-assigned gmem page to the host
From: Sean Christopherson <seanjc@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> On Thu, Jun 11, 2026 at 05:47:52AM -0700, Sean Christopherson wrote:
> > On Thu, Jun 11, 2026, Hyunwoo Kim wrote:
> > > On Wed, Jun 10, 2026 at 05:16:57PM -0500, Michael Roth wrote:
> > > > On Thu, Jun 11, 2026 at 01:10:03AM +0900, Hyunwoo Kim wrote:
> > > > > ---
> > > > >  arch/x86/kvm/svm/sev.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > > > > index 6c6a6d663e29..8fee6ec529f9 100644
> > > > > --- a/arch/x86/kvm/svm/sev.c
> > > > > +++ b/arch/x86/kvm/svm/sev.c
> > > > > @@ -5178,8 +5178,12 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > > > > 
> > > > >                 rc = rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> > > > >                 if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error %d\n",
> > > > > -                             pfn, rc))
> > > > > +                             pfn, rc)) {
> > > > > +                       /* Still assigned to the guest; pin and leak rather than freeing. */
> > > > > +                       folio_get(page_folio(pfn_to_page(pfn)));
> > > > > +                       snp_leak_pages(pfn, use_2m_update ? PTRS_PER_PMD : 1);
> > > > >                         goto next_pfn;
> > > > > +               }
> > > > 
> > > > This roughly aligns with what would happen if snp_page_reclaim() fails
> > > > in sev_gmem_post_populate(), while the guest is being initialized via
> > > > KVM_SEV_SNP_LAUNCH_UPDATE ioctl, which calls into kvm_gmem_populate().
> > > > 
> > > > However, in kvm_gmem_populate(), we still free the page. Maybe, to
> > > > address both cases, we should just add a parameter to snp_leak_pages()
> > > > to tell it to take an extra ref and use that in both of these paths.
> > > > 
> > > > Or we can just do the direct folio_get() in both cases, the above
> > > > formalizes the handling convention a little better though IMO.
> > > 
> > > If I understand correctly, an extra ref alone still seems to leave the
> > > LRU corruption that sashiko flagged:
> > > 
> > > https://lore.kernel.org/all/20260610162623.061BA1F00898@smtp.kernel.org/
> > > 
> > > A gmem folio is on the unevictable LRU, and taking a ref keeps the folio
> > > on the LRU. page->buddy_list, which snp_leak_pages() uses, shares the
> > > same union as folio->lru, so leaking the page overwrites the folio's LRU
> > > pointers. Both paths deal with a gmem folio, so the same applies.
> > > 
> > > To handle this properly, the folio would need to be taken off the LRU
> > > before leaking, with something like folio_isolate_lru(), but that is
> > > mm-internal and does not look usable from KVM. How should we proceed?
> > > Please let me know if I am missing something.
> > 
> > I'm inclined to do nothing.  rmp_make_shared() should only fail in this case if
> > there's a fatal bug somewhere, no?  Either that or do BUG_ON(), because at some
> > point these types of errors are simply unrecoverable.
> 
> A guest can make a gmem page a VMSA via AP creation,

Ugh, the bane of my existence.  Can we kill off that feature yet?  I'm only half
joking.  Not even half.

> and if that gfn is then hole-punched, a page that is still assigned to the
> guest is returned to the host in sev_gmem_invalidate(), which looked like it
> could lead to a host RMP PF, so I sent the patch.

Yeah, I suspect you're right.  But leaking the page doesn't fix the underlying
problem, which is that it's possible to free a page that's being used as a VMSA.

We can't simply pin the page, because IIUC ->free_folio() is called when the page
is removed from the filemap, not when the folio/page is free back to the allocator.

I.e. we can't do this.

diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
index 74fb15551e83..ea70c7ade152 100644
--- arch/x86/kvm/svm/sev.c
+++ arch/x86/kvm/svm/sev.c
@@ -3510,6 +3510,9 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 
        svm = to_svm(vcpu);
 
+       if (svm->sev_es.snp_has_guest_vmsa)
+               kvm_release_page_clean(phys_to_page(svm->vmcb->control.vmsa_pa));
+
        /*
         * If it's an SNP guest, then the VMSA was marked in the RMP table as
         * a guest-owned page. Transition the page to hypervisor state before
@@ -4027,6 +4030,13 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
        if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
                return;
 
+       /*
+        * Drop the reference to the previous VMSA page (acquired above) if the
+        * guest is changing its VMSA.
+        */
+       if (svm->sev_es.snp_has_guest_vmsa)
+               kvm_release_page_clean(phys_to_page(svm->vmcb->control.vmsa_pa));
+
        /*
         * From this point forward, the VMSA will always be a guest-mapped page
         * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
@@ -4043,13 +4053,6 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 
        /* Mark the vCPU as runnable */
        kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
-       /*
-        * gmem pages aren't currently migratable, but if this ever changes
-        * then care should be taken to ensure svm->sev_es.vmsa is pinned
-        * through some other means.
-        */
-       kvm_release_page_clean(page);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)

The right way to handle this is to treat the VMSA "mapping" like an MMU mapping.
I.e. this is fundamentally the same mess we have to solve in order to not pin
pages that are mapped into L2 via vmcs01/vmcb02 for nVMX/nSVM.

Something like this, sans the actually handling of the request.  The simple way
to handle the request would be to invalidate control.vmsa_pa if snp_has_guest_vmsa
is true, and then redo the mapping part of sev_snp_init_protected_guest_state().

We could put the kvm_x86_call(gmem_invalidate_range)(kvm, range) call in
kvm_unmap_gfn_range() to avoid the extra arch hook, but I would prefer to have an
explicit connection between the invalidate() phase and the free() phase.

Have I mentioned how much I hate AP creation?

---
 arch/x86/include/asm/kvm-x86-ops.h |  3 ++-
 arch/x86/include/asm/kvm_host.h    |  3 ++-
 arch/x86/kvm/svm/sev.c             | 11 ++++++++++-
 arch/x86/kvm/svm/svm.c             |  5 ++++-
 arch/x86/kvm/svm/svm.h             | 13 ++-----------
 arch/x86/kvm/x86.c                 |  9 +++++++--
 include/linux/kvm_host.h           |  3 ++-
 virt/kvm/guest_memfd.c             | 17 +++++------------
 8 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 83dc5086138b..ea308250ef47 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -147,7 +147,8 @@ KVM_X86_OP_OPTIONAL(get_untagged_addr)
 KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
 KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
 KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
-KVM_X86_OP_OPTIONAL(gmem_invalidate)
+KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
+KVM_X86_OP_OPTIONAL(gmem_free_folio)
 #endif
 
 #undef KVM_X86_OP
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a5..0a5aec1701bd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2009,7 +2009,8 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
+	void (*gmem_invalidate_range)(struct kvm *kvm, struct kvm_gfn_range *range);
+	void (*gmem_free_folio)(struct folio *folio);
 	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 };
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..411480a90e36 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5115,9 +5115,18 @@ int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
 
 	return 0;
 }
+void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	if (!sev_snp_guest(kvm))
+		return;
+
+	kvm_make_all_cpus_request(kvm, KVM_REQ_VMSA_PAGE_RELOAD);
+}
 
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void sev_gmem_free_folio(struct folio *folio)
 {
+	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
+	kvm_pfn_t end = start + (1ul << folio_order(folio));
 	kvm_pfn_t pfn;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 526e0fdcd16b..907be66d6f2a 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5460,9 +5460,12 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
 
+#ifdef CONFIG_KVM_AMD_SEV
 	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_invalidate_range = sev_gmem_invalidate_range,
+	.gmem_free_folio = sev_gmem_free_folio,
 	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
+#endif
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..5129ab1a84d7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1008,7 +1008,8 @@ int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
 int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
-void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
+void sev_gmem_free_folio(struct folio *folio);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
 struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu);
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa);
@@ -1034,16 +1035,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
-{
-	return 0;
-}
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
-static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
-{
-	return 0;
-}
-
 static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 {
 	return NULL;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf122b8c3210..a734ddf59cf9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14134,9 +14134,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	kvm_x86_call(gmem_invalidate)(start, end);
+	kvm_x86_call(gmem_invalidate_range)(kvm, range);
+}
+
+void kvm_arch_gmem_free_folio(struct folio *folio)
+{
+	kvm_x86_call(gmem_free_folio)(folio);
 }
 #endif
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 27498e990dff..7de9b07870b7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2602,7 +2602,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
+void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
+void kvm_arch_gmem_free_folio(struct folio *folio);
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86690683b2fe..8ec5041934db 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 		}
 
 		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
+#endif
 	}
 
 	if (flush)
@@ -523,23 +527,12 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_free_folio(struct folio *folio)
-{
-	struct page *page = folio_page(folio, 0);
-	kvm_pfn_t pfn = page_to_pfn(page);
-	int order = folio_order(folio);
-
-	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
-}
-#endif
-
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-	.free_folio = kvm_gmem_free_folio,
+	.free_folio = kvm_arch_gmem_free_folio,
 #endif
 };
 

base-commit: de3a35be92d2391ece4bf3143ef2887192625fd0
-- 

> Other sites such as snp_page_reclaim() leak the page on this failure rather
> than freeing it.
> 
> If you think this isn't a real problem, leaving it as is seems fine to me.
> I don't see a good place to put a BUG_ON.
