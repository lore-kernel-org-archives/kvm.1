Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641533;
	b=flbNbnrJpgdG5jDHSVUd4kejnCskqAImVy21H6yr3phqXd+woJrufs9v0QLV+JIG7udm
	 15udSHYJ2IQ0koqOWkkoCOxthi30Dm8zHI/7HzumoLc+uKj5bsi8QWWd+RUj8a/nZx1VA
	 n0niGvgecn0ndcb73v6iV+qK+orUEMLLWMXhh9gr7yPWzQH32su9SKq45UPrp8ZrC1gQj
	 pqsiDot922jRKFwDCXcLmNqpCWFGh2ifNoqKm4k84aEt+dTtT19lcbBxrrgxRhxoESD6v
	 v0R2XpVzYKKetcVSUAOgGCL+gciLl/CvbTn//i3VdZY6IRj336CUOifLc8IytkkieMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641533;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=hivwqgp4LiwM4/VjEYMpC9tUrV6b8nagwQwd5M6FXY0=;
	b=QIPkwK2K6rAUEVEEv/3PKqN+PY7yGjH/s8K9mbcx90blJ43LEA4oYjuCReyr2uSeZuAe
	 JvFmvrvNv0JNnfpCiqox42f5LyNcaC5Imy0QsC89ZuVAgh5lSHL2wmhSjINCzG7DaDWb0
	 vDMGnZOd3JYqzQmWS/36FsKckv4+3b+h/ESc6N+A3bsimOgNeDNB3ZVy7FD1FtkybV0JN
	 f+j8encPB+xENOEj8Fj0fM9WOG4GaQkFHsAoXkagKRmxLYT9yk/vzS7gnpnjyKJf40mXS
	 tfKcjCaNs+f+qBuxMc3EoK1osSeJTp7mqRDZlpt/rQcKZdA/LWG1eO89aPMQbCN8w6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gnt6CG3P;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A36072C6C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A47A36072C6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gnt6CG3P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hivwqgp4LiwM4/VjEYMpC9tUrV6b8nagwQwd5M6FXY0=;
	b=gnt6CG3PY6+FXCPk0Ccv5TA8OY94HoKblijwQTwszWnfsP8EDHOcsuhvwHRY4Uucdj+pvX
	RZASDR6EfffictrBzQiuhRdnB3JQxIdf2ZLu1SCI6KPaLTkzJDRni5ti7qCOaKXfp1DgkQ
	2MWQX5E38YffT2TM8od1uUVVFlD2a0s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-mc2VB7-cNeavdXdt5hy-bA-1; Mon,
 02 Nov 2026 12:45:27 -0500
X-MC-Unique: mc2VB7-cNeavdXdt5hy-bA-1
X-Mimecast-MFC-AGG-ID: mc2VB7-cNeavdXdt5hy-bA_1793641526
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47E40195606A;
	Mon,  2 Nov 2026 17:45:26 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8D5F26C;
	Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 36/45] KVM: x86: Propagate memory faults through load_pdptrs()
Date: Mon,  2 Nov 2026 12:45:03 -0500
Message-ID: <20261102174512.8903-20-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

load_pdptrs() returns a 0/1 value, and therefore its callers do not
distinguish memory attribute errors (including from nested GPA
translation) from other failures.  Change them to propagate
negative errno.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/regs.c       | 43 ++++++++++++++++++++++++++++-----------
 arch/x86/kvm/svm/nested.c | 10 +++++----
 arch/x86/kvm/svm/svm.c    |  4 ++--
 arch/x86/kvm/vmx/nested.c |  6 ++++--
 4 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3969b769f1c1..b7c25b16ffca 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -176,7 +176,12 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	/* Note the offset, PDPTRs are 32 byte aligned when using PAE paging. */
 	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
 				       cr3 & GENMASK(11, 5), sizeof(pdpte));
-	if (ret < 0)
+	if (ret == -EFAULT) {
+		kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK, PAGE_SIZE,
+					      false, false, false);
+		return ret;
+	}
+	if (ret)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(pdpte); ++i) {
@@ -264,6 +269,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_post_set_cr0);
 int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 {
 	unsigned long old_cr0 = kvm_read_cr0(vcpu);
+	int r;
 
 	if (!kvm_is_valid_cr0(vcpu, cr0))
 		return 1;
@@ -286,9 +292,11 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	}
 #endif
 	if (!(vcpu->arch.efer & EFER_LME) && (cr0 & X86_CR0_PG) &&
-	    is_pae(vcpu) && ((cr0 ^ old_cr0) & X86_CR0_PDPTR_BITS) &&
-	    !load_pdptrs(vcpu, kvm_read_cr3(vcpu)))
-		return 1;
+	    is_pae(vcpu) && ((cr0 ^ old_cr0) & X86_CR0_PDPTR_BITS)) {
+		r = load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+		if (r <= 0)
+			return r ?: 1;
+	}
 
 	if (!(cr0 & X86_CR0_PG) &&
 	    (is_64_bit_mode(vcpu) || kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)))
@@ -315,6 +323,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	bool skip_tlb_flush = false;
 	unsigned long pcid = 0;
+	int r;
 #ifdef CONFIG_X86_64
 	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)) {
 		skip_tlb_flush = cr3 & X86_CR3_PCID_NOFLUSH;
@@ -335,8 +344,11 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	if (!kvm_vcpu_is_legal_cr3(vcpu, cr3))
 		return 1;
 
-	if (is_pae_paging(vcpu) && !load_pdptrs(vcpu, cr3))
-		return 1;
+	if (is_pae_paging(vcpu)) {
+		r = load_pdptrs(vcpu, cr3);
+		if (r <= 0)
+			return r ?: 1;
+	}
 
 	if (cr3 != kvm_read_cr3(vcpu))
 		kvm_mmu_new_pgd(vcpu, cr3);
@@ -411,6 +423,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_post_set_cr4);
 int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	unsigned long old_cr4 = kvm_read_cr4(vcpu);
+	int r;
 
 	if (!kvm_is_valid_cr4(vcpu, cr4))
 		return 1;
@@ -420,10 +433,12 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 		if ((cr4 ^ old_cr4) & X86_CR4_LA57)
 			return 1;
-	} else if (is_paging(vcpu) && (cr4 & X86_CR4_PAE)
-		   && ((cr4 ^ old_cr4) & X86_CR4_PDPTR_BITS)
-		   && !load_pdptrs(vcpu, kvm_read_cr3(vcpu)))
-		return 1;
+	} else if (is_paging(vcpu) && (cr4 & X86_CR4_PAE) &&
+		   ((cr4 ^ old_cr4) & X86_CR4_PDPTR_BITS)) {
+		r = load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+		if (r <= 0)
+			return r ?: 1;
+	}
 
 	if ((cr4 & X86_CR4_PCIDE) && !(old_cr4 & X86_CR4_PCIDE)) {
 		/* PCID can not be enabled when cr3[11:0]!=000H or EFER.LMA=0 */
@@ -579,7 +594,7 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 			      int *mmu_reset_needed, bool update_pdptrs)
 {
-	int idx;
+	int idx, r;
 	struct desc_ptr dt;
 
 	if (!kvm_is_valid_sregs(vcpu, sregs))
@@ -616,7 +631,11 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	if (update_pdptrs) {
 		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		if (is_pae_paging(vcpu)) {
-			load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+			r = load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+			if (r < 0) {
+				srcu_read_unlock(&vcpu->kvm->srcu, idx);
+				return r;
+			}
 			*mmu_reset_needed = 1;
 		}
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f1f40aad47..a512e0e8dd93 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -720,7 +720,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	if (reload_pdptrs && is_pae_paging(vcpu)) {
 		if (nested_npt)
 			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
-		else if (CC(!load_pdptrs(vcpu, cr3)))
+		else if (CC(load_pdptrs(vcpu, cr3) <= 0))
 			return -EINVAL;
 	}
 
@@ -2132,11 +2132,13 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 		 * nGPA translation. For !nNPT, reload eagerly unless userspace
 		 * already supplied authoritative PDPTRs via KVM_SET_SREGS2.
 		 */
-		if (nested_npt_enabled(to_svm(vcpu)))
+		if (nested_npt_enabled(to_svm(vcpu))) {
 			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
-		else if (!vcpu->arch.pdptrs_from_userspace &&
-			 CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
+		} else if (!vcpu->arch.pdptrs_from_userspace &&
+			 CC(load_pdptrs(vcpu, vcpu->arch.cr3) <= 0)) {
+			kvm_prepare_emulation_failure_exit(vcpu);
 			return false;
+		}
 	}
 
 	if (!nested_svm_merge_msrpm(vcpu))
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2601f8359137..a8b3d57aabef 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1587,8 +1587,8 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 		 * When !npt_enabled, vcpu->pdptrs[] is already available since
 		 * it is always updated per SDM when moving to CRs.
 		 */
-		if (npt_enabled)
-			load_pdptrs(vcpu, kvm_read_cr3(vcpu));
+		if (npt_enabled && load_pdptrs(vcpu, kvm_read_cr3(vcpu)) < 0)
+			kvm_vm_dead(vcpu->kvm);
 		break;
 	default:
 		KVM_BUG_ON(1, vcpu->kvm);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f6994a95523a..8c110f3d9cc3 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1240,7 +1240,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	 * must not be dereferenced.
 	 */
 	if (reload_pdptrs && !nested_ept && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, cr3))) {
+	    CC(load_pdptrs(vcpu, cr3) <= 0)) {
 		*entry_failure_code = ENTRY_FAIL_PDPTE;
 		return -EINVAL;
 	}
@@ -3454,8 +3454,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		 * the guest CR3 might be restored prior to setting the nested
 		 * state which can lead to a load of wrong PDPTRs.
 		 */
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
+		if (CC(load_pdptrs(vcpu, vcpu->arch.cr3) <= 0)) {
+			kvm_prepare_emulation_failure_exit(vcpu);
 			return false;
+		}
 	}
 
 
-- 
2.52.0


