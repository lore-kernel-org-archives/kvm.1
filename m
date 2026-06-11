Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B03F786F;
	Thu, 11 Jun 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181365; cv=none; b=oRj0ApNrWfR950K0496ETPgEIHq9hQYSLWBadCXi4qXt9VT+vX9SQ9Qa2H+Wu5EUvEnvBDb5jy4Gky6pw8XvWC3o2oQ29KdAq7ieKp6PbYqGSy8HHDRSYTZATImfMwggvHQSrxF20cSw1/Mt3PdvSScrG0LgAvJ6WEqLa3z6bTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181365; c=relaxed/simple;
	bh=lfyZEBJGN1JHRbWpIMrlKDukBBjB3cMj42Hl6Ap+bYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8+1RH8cZWaia1PO6oVdM8gtDU1AWZezmOVWhtIshG/71QKZstFowxZNDHiu0g+D0BsgzJipGLSb9lf5R720l432ggaOt+GITYQRM9vqabtxikdtsTFYTSzOJ3yMT9evzTbJE8T+LBOICArulN8FsO70wHRM+iS8dHP0DeH7BDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 990761C0EDA;
	Thu, 11 Jun 2026 14:36:00 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
Date: Thu, 11 Jun 2026 14:35:25 +0200
Message-ID: <20260611123528.572255-2-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611123528.572255-1-joro@8bytes.org>
References: <20260611123528.572255-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Streamline the VMSA setting state of vcpus, where a VMSA can be either
KVM-allocated or guest-provided. This consolidates the various
tracking state around VMSAs.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 arch/x86/kvm/svm/sev.c | 301 ++++++++++++++++++++++++++++-------------
 arch/x86/kvm/svm/svm.h |  31 ++++-
 2 files changed, 237 insertions(+), 95 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6c6a6d663e29..9b1280222e20 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -147,6 +147,9 @@ static bool sev_snp_guest(struct kvm *kvm)
 }
 
 static int snp_decommission_context(struct kvm *kvm);
+static int kvm_rmp_make_shared(struct kvm *kvm, u64 pfn, enum pg_level level);
+static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va);
+static int snp_page_reclaim(struct kvm *kvm, u64 pfn);
 
 struct enc_region {
 	struct list_head list;
@@ -156,6 +159,173 @@ struct enc_region {
 	unsigned long size;
 };
 
+static void *sev_es_vmsa_ref(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	void *vmsa = NULL;
+
+	if (svm->sev_es.vmsa.vmsa_state == VMSA_SHARED) {
+		vmsa = page_address(svm->sev_es.vmsa.vmsa_page);
+	}
+
+	return vmsa;
+}
+
+static int sev_es_vcpu_alloc_vmsa(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct page *vmsa_page;
+
+	if (WARN_ON_ONCE(svm->sev_es.vmsa.vmsa_state != VMSA_NONE))
+		return -EINVAL;
+
+	/*
+	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
+	 * contain the encrypted register state of the guest.
+	 */
+	vmsa_page = snp_safe_alloc_page();
+	if (!vmsa_page)
+		return -ENOMEM;
+
+	svm->sev_es.vmsa.vmsa_state = VMSA_SHARED;
+	svm->sev_es.vmsa.vmsa_page = vmsa_page;
+
+	return 0;
+}
+
+static int sev_es_vcpu_vmsa_make_private(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
+	struct vcpu_svm *svm = to_svm(vcpu);
+	void *vmsa = sev_es_vmsa_ref(vcpu);
+
+	if (!vmsa)
+		return -EINVAL;
+
+	if (is_sev_snp_guest(vcpu)) {
+		u64 pfn = __pa(vmsa) >> PAGE_SHIFT;
+		int ret;
+
+		/* Transition the VMSA page to a firmware state. */
+		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
+		if (ret)
+			return ret;
+	}
+
+	svm->sev_es.vmsa.vmsa_state = VMSA_PRIVATE;
+
+	return 0;
+}
+
+static void sev_es_vcpu_free_vmsa(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	void *vmsa_ptr;
+
+	switch (svm->sev_es.vmsa.vmsa_state) {
+	case VMSA_NONE:
+	case VMSA_GUEST:
+		break;
+	case VMSA_PRIVATE:
+		vmsa_ptr = page_address(svm->sev_es.vmsa.vmsa_page);
+
+		if (is_sev_snp_guest(vcpu)) {
+			u64 pfn = __pa(vmsa_ptr) >> PAGE_SHIFT;
+
+			if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K)) {
+				pr_err("Failed to make VMSA page shared - leaking it to avoid re-use\n");
+				goto out;
+			}
+		}
+
+		if (vcpu->arch.guest_state_protected)
+			sev_flush_encrypted_page(vcpu, vmsa_ptr);
+
+		fallthrough;
+	case VMSA_SHARED:
+		__free_page(svm->sev_es.vmsa.vmsa_page);
+		break;
+	default:
+		BUG();
+	}
+out:
+
+	svm->sev_es.vmsa.vmsa_page = NULL;
+	svm->sev_es.vmsa.vmsa_state = VMSA_NONE;
+}
+
+static void sev_snp_vcpu_reclaim_vmsa(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	void *vmsa_ptr;
+	u64 pfn;
+
+	if (WARN_ON_ONCE(!is_sev_snp_guest(vcpu) ||
+	                 svm->sev_es.vmsa.vmsa_state != VMSA_PRIVATE))
+		return;
+
+	vmsa_ptr = page_address(svm->sev_es.vmsa.vmsa_page);
+	pfn = __pa(vmsa_ptr) >> PAGE_SHIFT;
+
+	if (!snp_page_reclaim(vcpu->kvm, pfn))
+		__free_page(svm->sev_es.vmsa.vmsa_page);
+
+	svm->sev_es.vmsa.vmsa_page = NULL;
+	svm->sev_es.vmsa.vmsa_state = VMSA_NONE;
+}
+
+static void sev_es_set_guest_vmsa(struct kvm_vcpu *vcpu, gpa_t vmsa_gpa)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	sev_es_vcpu_free_vmsa(vcpu);
+
+	svm->sev_es.vmsa.vmsa_state = VMSA_GUEST;
+	svm->sev_es.vmsa.vmsa_gpa = vmsa_gpa;
+}
+
+static u64 sev_es_vmsa_pa(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	enum vmsa_state vmsa_state = svm->sev_es.vmsa.vmsa_state;
+	u64 vmsa_pa = INVALID_PAGE;
+
+	if (vmsa_state == VMSA_GUEST) {
+		gpa_t vmsa_gpa = svm->sev_es.vmsa.vmsa_gpa;
+		struct kvm_memory_slot *slot;
+		struct page *page;
+		kvm_pfn_t pfn;
+		gfn_t gfn;
+
+		gfn = gpa_to_gfn(vmsa_gpa);
+
+		slot = gfn_to_memslot(vcpu->kvm, gfn);
+		if (!slot)
+			goto out;
+
+		/*
+		 * The new VMSA will be private memory guest memory, so retrieve the
+		 * PFN from the gmem backend.
+		 */
+		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+			goto out;
+
+		vmsa_pa = pfn_to_hpa(pfn);
+
+		/*
+		 * gmem pages aren't currently migratable, but if this ever changes
+		 * then care should be taken to ensure the guest vmsa is pinned
+		 * through some other means.
+		 */
+		kvm_release_page_clean(page);
+	} else if (vmsa_state == VMSA_PRIVATE || vmsa_state == VMSA_SHARED) {
+		vmsa_pa = __pa(page_address(svm->sev_es.vmsa.vmsa_page));
+	}
+
+out:
+	return vmsa_pa;
+}
+
 /* Called with the sev_bitmap_lock held, or on shutdown  */
 static int sev_flush_asids(unsigned int min_asid, unsigned int max_asid)
 {
@@ -925,7 +1095,7 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct kvm_sev_info *sev = to_kvm_sev_info(vcpu->kvm);
-	struct sev_es_save_area *save = svm->sev_es.vmsa;
+	struct sev_es_save_area *save = sev_es_vmsa_ref(vcpu);
 	struct xregs_state *xsave;
 	const u8 *s;
 	u8 *d;
@@ -1026,6 +1196,7 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 {
 	struct sev_data_launch_update_vmsa vmsa;
 	struct vcpu_svm *svm = to_svm(vcpu);
+	void *vmsa_ref = sev_es_vmsa_ref(vcpu);
 	int ret;
 
 	if (vcpu->guest_debug) {
@@ -1043,15 +1214,19 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	 * the VMSA memory content (i.e it will write the same memory region
 	 * with the guest's key), so invalidate it first.
 	 */
-	clflush_cache_range(svm->sev_es.vmsa, PAGE_SIZE);
+	clflush_cache_range(vmsa_ref, PAGE_SIZE);
 
 	vmsa.reserved = 0;
 	vmsa.handle = to_kvm_sev_info(kvm)->handle;
-	vmsa.address = __sme_pa(svm->sev_es.vmsa);
+	vmsa.address = __sme_pa(vmsa_ref);
 	vmsa.len = PAGE_SIZE;
 	ret = sev_issue_cmd(kvm, SEV_CMD_LAUNCH_UPDATE_VMSA, &vmsa, error);
 	if (ret)
-	  return ret;
+		goto free_vmsa;
+
+	ret = sev_es_vcpu_vmsa_make_private(vcpu);
+	if (ret)
+		goto free_vmsa;
 
 	/*
 	 * SEV-ES guests maintain an encrypted version of their FPU
@@ -1069,7 +1244,13 @@ static int __sev_launch_update_vmsa(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	 * MSR_IA32_DEBUGCTLMSR when guest_state_protected is not set.
 	 */
 	svm_enable_lbrv(vcpu);
+
 	return 0;
+
+free_vmsa:
+	sev_es_vcpu_free_vmsa(vcpu);
+
+	return ret;
 }
 
 static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -2508,23 +2689,22 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		struct vcpu_svm *svm = to_svm(vcpu);
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+		void *vmsa = sev_es_vmsa_ref(vcpu);
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
 			goto out;
 
-		/* Transition the VMSA page to a firmware state. */
-		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
+		ret = sev_es_vcpu_vmsa_make_private(vcpu);
 		if (ret)
 			goto out;
 
 		/* Issue the SNP command to encrypt the VMSA */
-		data.address = __sme_pa(svm->sev_es.vmsa);
+		data.address = __sme_pa(vmsa);
 		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE,
 				      &data, &argp->error);
 		if (ret) {
-			snp_page_reclaim(kvm, pfn);
+			sev_snp_vcpu_reclaim_vmsa(vcpu);
 
 			goto out;
 		}
@@ -3593,31 +3773,13 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_svm *svm;
+	struct vcpu_svm *svm = to_svm(vcpu);
 
 	if (!is_sev_es_guest(vcpu))
 		return;
 
-	svm = to_svm(vcpu);
-
-	/*
-	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
-	 * a guest-owned page. Transition the page to hypervisor state before
-	 * releasing it back to the system.
-	 */
-	if (is_sev_snp_guest(vcpu)) {
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
-
-		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
-			goto skip_vmsa_free;
-	}
-
-	if (vcpu->arch.guest_state_protected)
-		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
-
-	__free_page(virt_to_page(svm->sev_es.vmsa));
+	sev_es_vcpu_free_vmsa(vcpu);
 
-skip_vmsa_free:
 	__sev_es_unmap_ghcb(svm);
 }
 
@@ -4067,10 +4229,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_memory_slot *slot;
-	struct page *page;
-	kvm_pfn_t pfn;
-	gfn_t gfn;
+	u64 vmsa_pa;
 
 	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
 
@@ -4092,46 +4251,17 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
-		return;
-
-	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+	sev_es_set_guest_vmsa(vcpu, svm->sev_es.req_vmsa_gpa);
+	vmsa_pa = sev_es_vmsa_pa(vcpu);
 
-	slot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!slot)
+	if (!VALID_PAGE(vmsa_pa))
 		return;
 
-	/*
-	 * The new VMSA will be private memory guest memory, so retrieve the
-	 * PFN from the gmem backend.
-	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-		return;
-
-	/*
-	 * From this point forward, the VMSA will always be a guest-mapped page
-	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
-	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
-	 * that involves cleanups like flushing caches, which would ideally be
-	 * handled during teardown rather than guest boot.  Deferring that also
-	 * allows the existing logic for SEV-ES VMSAs to be re-used with
-	 * minimal SNP-specific changes.
-	 */
-	svm->sev_es.snp_has_guest_vmsa = true;
-
 	/* Use the new VMSA */
-	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
+	svm->vmcb->control.vmsa_pa = vmsa_pa;
 
 	/* Mark the vCPU as runnable */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
-	/*
-	 * gmem pages aren't currently migratable, but if this ever changes
-	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
-	 * through some other means.
-	 */
-	kvm_release_page_clean(page);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
@@ -4187,10 +4317,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			return -EINVAL;
 		}
 
-		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		target_svm->sev_es.req_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
-		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+		target_svm->sev_es.req_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
@@ -4708,20 +4838,7 @@ static void sev_es_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	struct vmcb *vmcb = svm->vmcb01.ptr;
 
 	svm->vmcb->control.misc_ctl |= SVM_MISC_ENABLE_SEV_ES;
-
-	/*
-	 * An SEV-ES guest requires a VMSA area that is a separate from the
-	 * VMCB page. Do not include the encryption mask on the VMSA physical
-	 * address since hardware will access it using the guest key.  Note,
-	 * the VMSA will be NULL if this vCPU is the destination for intrahost
-	 * migration, and will be copied later.
-	 */
-	if (!svm->sev_es.snp_has_guest_vmsa) {
-		if (svm->sev_es.vmsa)
-			svm->vmcb->control.vmsa_pa = __pa(svm->sev_es.vmsa);
-		else
-			svm->vmcb->control.vmsa_pa = INVALID_PAGE;
-	}
+	svm->vmcb->control.vmsa_pa = sev_es_vmsa_pa(&svm->vcpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES))
 		svm->vmcb->control.allowed_sev_features = sev->vmsa_features |
@@ -4797,7 +4914,7 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 int sev_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct page *vmsa_page;
+	int ret;
 
 	mutex_init(&svm->sev_es.snp_vmsa_mutex);
 
@@ -4808,11 +4925,9 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 	 * SEV-ES guests require a separate (from the VMCB) VMSA page used to
 	 * contain the encrypted register state of the guest.
 	 */
-	vmsa_page = snp_safe_alloc_page();
-	if (!vmsa_page)
-		return -ENOMEM;
-
-	svm->sev_es.vmsa = page_address(vmsa_page);
+	ret = sev_es_vcpu_alloc_vmsa(vcpu);
+	if (ret)
+		return ret;
 
 	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
@@ -5227,12 +5342,14 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	if (!is_sev_es_guest(vcpu))
 		return NULL;
 
+	vmsa = sev_es_vmsa_ref(vcpu);
+
 	/*
 	 * If the VMSA has not yet been encrypted, return a pointer to the
 	 * current un-encrypted VMSA.
 	 */
-	if (!vcpu->arch.guest_state_protected)
-		return (struct vmcb_save_area *)svm->sev_es.vmsa;
+	if (vmsa)
+		return vmsa;
 
 	sev = to_kvm_sev_info(vcpu->kvm);
 
@@ -5303,8 +5420,10 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 
 void sev_free_decrypted_vmsa(struct kvm_vcpu *vcpu, struct vmcb_save_area *vmsa)
 {
+	struct vmcb_save_area *vmsa_ptr = sev_es_vmsa_ref(vcpu);
+
 	/* If the VMSA has not yet been encrypted, nothing was allocated */
-	if (!vcpu->arch.guest_state_protected || !vmsa)
+	if (vmsa == vmsa_ptr)
 		return;
 
 	free_page((unsigned long)vmsa);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5137416be593..3d4799f09b23 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -240,9 +240,29 @@ struct svm_nested_state {
 	bool force_msr_bitmap_recalc;
 };
 
+enum vmsa_state {
+	/* No VMSA set */
+	VMSA_NONE,
+	/* VMSA allocated by KVM - Shared in RMP (if applicable) */
+	VMSA_SHARED,
+	/* VMSA allocated by KVM - Guest-private in RMP (SEV-SNP only) */
+	VMSA_PRIVATE,
+	/* Guest-owned VMSA */
+	VMSA_GUEST,
+};
+
+struct sev_es_vmsa_state {
+	enum vmsa_state vmsa_state;
+	union {
+		/* state == (KVM_SHARED || KVM_PRIVATE) */
+		struct page *vmsa_page;
+		/* state == GUEST */
+		gpa_t vmsa_gpa;
+	};
+};
+
 struct vcpu_sev_es_state {
 	/* SEV-ES support */
-	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
 	u8 valid_bitmap[16];
 	struct kvm_host_map ghcb_map;
@@ -266,10 +286,13 @@ struct vcpu_sev_es_state {
 
 	u64 ghcb_registered_gpa;
 
-	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
-	gpa_t snp_vmsa_gpa;
+	/* VMSA related state */
+	struct mutex snp_vmsa_mutex;	/* Used to handle concurrent updates of VMSA. */
+	struct sev_es_vmsa_state vmsa;	/* VMSA currently used by the VCPU */
+	gpa_t req_vmsa_gpa;		/* Requested new VMSA GPA */
+
+	bool snp_ap_runnable;
 	bool snp_ap_waiting_for_reset;
-	bool snp_has_guest_vmsa;
 };
 
 struct vcpu_svm {
-- 
2.53.0

