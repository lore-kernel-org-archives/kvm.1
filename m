Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641529;
	b=v2IGGtwpfwdgLchR2o7IKCpPEmbnU+F0j8OlTFfGpGMRR5qAkDDRHYqbxvPMsHPzlFyz
	 LgSI7ZsMop8SY1ZuvSUMoJ3nG8u9vEtDMiMZGKA+nldGxfwGiVamjph6rXpRXPyBKW8QJ
	 3EM2sQCf7LLnGk4boIL2yU4rwOuT/kB11Kp4WKpP2WLX5kgO6roLd/3tnt9LBCE2CCLZN
	 tTJuI+IOfdGeHFJFNPdwoNpzmlQ3sNs2HSByqk49vh0dtIHwOjvjLaU006tE23wyBnMqc
	 vx86Ck+m34cCMBFph+1/2gtFkK0AiumyrLyzyvcAnOkAV7THxxDa5njJ8LQFutOOVEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641529;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=DcWB8xvBarWjhqsWFhGKnXSK0V6SOGjLjMA4H94uIS0=;
	b=hYIbzENQC4haNbK4lLKEA9R3bKqqERH+tahtG2S1hdSAI3BR2q9IfUV1+lLmQc68eUie
	 n0G76IozhrdjJYnq2YhNf4VnnfCu7AIv8EgKTOkrAx3ABeb7gwut1m9rXQnCADK3yZkjh
	 +S9ySUKKLrw/yyN3pgdC7BpVSOoLsKbBAjFIeTKNfjiXxdmD5/mc/TetI25cJxWs3ocmO
	 sgP0PPm6dB4mpa7Y6875Jej5k/69oBzn3LUMAOIzsg71aHOvfeHX8UU7Ca+qVqGMAvXLG
	 UPVTghZojIgiaNOCIQpHcSW9ka0BXco/ws5rlBzmC8CN3c0YY75nUk3uKDAVLVrETuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IC95GZVZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7D606A582
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B7D606A582
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IC95GZVZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcWB8xvBarWjhqsWFhGKnXSK0V6SOGjLjMA4H94uIS0=;
	b=IC95GZVZlP6IlSExsOP7wHhzxsZDNJTLioPcljpJbmDKzrPl4DgwLu2GdR5zNXjugreBWz
	ev2LCPB1nvf//vM5J/qf1lB9J7emrBSBW95Sd4UJIV/UTn2yZVzE5UFpX+5vS1GJOqkwng
	C3O5g6B2NtsP0L9bb/F3s189pf0TZps=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-DqRUHs0uPGu1wHaaytI_5A-1; Mon,
 02 Nov 2026 12:45:26 -0500
X-MC-Unique: DqRUHs0uPGu1wHaaytI_5A-1
X-Mimecast-MFC-AGG-ID: DqRUHs0uPGu1wHaaytI_5A_1793641525
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20561956051;
	Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FC6A433;
	Mon,  2 Nov 2026 17:45:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 35/45] KVM: x86/mmu: Propagate errors from nested GPA translation
Date: Mon,  2 Nov 2026 12:45:02 -0500
Message-ID: <20261102174512.8903-19-pbonzini@redhat.com>
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

The nested translation callbacks currently discard errors returned
by gva_to_gpa().  Adjust translate_nested_gpa()'s calling convention
similar to what was done to gva_to_gpa(), so that errors can be
propagated from page walk as well as from users that directly care
about L2 GPAs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  8 ++++----
 arch/x86/kvm/hyperv.c           |  6 ++++--
 arch/x86/kvm/mmu.h              | 18 ++++++++++--------
 arch/x86/kvm/mmu/mmu.c          |  5 ++---
 arch/x86/kvm/mmu/paging_tmpl.h  | 12 ++++++------
 arch/x86/kvm/regs.c             |  8 +++++---
 arch/x86/kvm/svm/nested.c       | 18 +++++++++---------
 arch/x86/kvm/vmx/nested.c       | 18 +++++++++---------
 arch/x86/kvm/x86.c              | 15 +++++++++++----
 9 files changed, 60 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 99f9c9269f2f..7fbcf60e56cf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1780,10 +1780,10 @@ struct kvm_x86_nested_ops {
 			 struct kvm_nested_state *kvm_state);
 	bool (*get_nested_state_pages)(struct kvm_vcpu *vcpu);
 	int (*write_log_dirty)(struct kvm_vcpu *vcpu, gpa_t l2_gpa);
-	gpa_t (*translate_nested_gpa)(struct kvm_vcpu *vcpu, gpa_t gpa,
-				      u64 access,
-				      struct x86_exception *exception,
-				      u64 pte_access);
+	int (*translate_nested_gpa)(struct kvm_vcpu *vcpu, gpa_t gpa,
+				    u64 access, gpa_t *translated_gpa,
+				    struct x86_exception *exception,
+				    u64 pte_access);
 
 	int (*enable_evmcs)(struct kvm_vcpu *vcpu,
 			    uint16_t *vmcs_version);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ee5189815a06..090955541518 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2119,8 +2119,10 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 
 	/* Slow direct hypercalls from L2 provide a nested GPA. */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, hc->ingpa,
-					      PFERR_GUEST_FINAL_MASK, NULL, 0);
+		r = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, hc->ingpa,
+				      PFERR_GUEST_FINAL_MASK, &hc->ingpa, NULL, 0);
+		if (r)
+			return r;
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 224f4c1a957e..40dcbcbae173 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -377,15 +377,17 @@ static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
 	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
 }
 
-static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
-				      struct kvm_pagewalk *w,
-				      gpa_t gpa, u64 access,
-				      struct x86_exception *exception,
-				      u64 pte_access)
+static inline int kvm_translate_gpa(struct kvm_vcpu *vcpu,
+				    struct kvm_pagewalk *w,
+				    gpa_t gpa, u64 access, gpa_t *translated_gpa,
+				    struct x86_exception *exception,
+				    u64 pte_access)
 {
-	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.ngpa_walk)
-		return gpa;
-	return kvm_nested_call(translate_nested_gpa)(vcpu, gpa, access,
+	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.ngpa_walk) {
+		*translated_gpa = gpa;
+		return 0;
+	}
+	return kvm_nested_call(translate_nested_gpa)(vcpu, gpa, access, translated_gpa,
 						     exception, pte_access);
 }
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c827f2e1f3d1..9567c109306b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4474,9 +4474,8 @@ static int nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
 	 * the last argument to kvm_translate_gpa (which NPT does not use).
 	 */
-	*gpa = kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
-				 exception, ACC_ALL);
-	return 0;
+	return kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
+				 gpa, exception, ACC_ALL);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 7775ba789258..a76ec22ce3f2 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -398,9 +398,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->table_gfn[walker->level - 1] = table_gfn;
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
-		real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(table_gfn),
-					     nested_access | PFERR_GUEST_PAGE_MASK,
-					     &walker->fault, 0);
+		kvm_translate_gpa(vcpu, w, gfn_to_gpa(table_gfn),
+				  nested_access | PFERR_GUEST_PAGE_MASK,
+				  &real_gpa, &walker->fault, 0);
 
 		if (unlikely(real_gpa == INVALID_GPA))
 			return 0;
@@ -458,9 +458,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(gfn),
-				     access | PFERR_GUEST_FINAL_MASK,
-				     &walker->fault, walker->pte_access);
+	kvm_translate_gpa(vcpu, w, gfn_to_gpa(gfn),
+			  access | PFERR_GUEST_FINAL_MASK, &real_gpa,
+			  &walker->fault, walker->pte_access);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3621f1a47d37..3969b769f1c1 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -165,9 +165,11 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
 	 * to an L1 GPA.
 	 */
-	real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(pdpt_gfn),
-				     PFERR_USER_MASK | PFERR_WRITE_MASK |
-				     PFERR_GUEST_PAGE_MASK, NULL, 0);
+	ret = kvm_translate_gpa(vcpu, w, gfn_to_gpa(pdpt_gfn),
+				PFERR_USER_MASK | PFERR_WRITE_MASK | PFERR_GUEST_PAGE_MASK,
+				&real_gpa, NULL, 0);
+	if (ret)
+		return ret;
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5d0a2f658365..73f1f40aad47 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2148,24 +2148,24 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
-				      u64 access,
-				      struct x86_exception *exception,
-				      u64 pte_access)
+static int svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
+				    u64 access, gpa_t *translated_gpa,
+				    struct x86_exception *exception,
+				    u64 pte_access)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
-	gpa_t result;
 
-	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
-		return gpa;
+	if (WARN_ON_ONCE(!mmu_is_nested(vcpu))) {
+		*translated_gpa = gpa;
+		return 0;
+	}
 
 	/* Non-GMET walks are always user-walks */
 	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
 		access |= PFERR_USER_MASK;
 
-	w->gva_to_gpa(vcpu, w, gpa, access, &result, exception);
-	return result;
+	return w->gva_to_gpa(vcpu, w, gpa, access, translated_gpa, exception);
 }
 
 struct kvm_x86_nested_ops svm_nested_ops __initdata = {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a666c2908889..f6994a95523a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7477,16 +7477,17 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 }
 
 
-static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
-				      u64 access,
-				      struct x86_exception *exception,
-				      u64 pte_access)
+static int vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
+				    u64 access, gpa_t *translated_gpa,
+				    struct x86_exception *exception,
+				    u64 pte_access)
 {
 	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
-	gpa_t result;
 
-	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
-		return gpa;
+	if (WARN_ON_ONCE(!mmu_is_nested(vcpu))) {
+		*translated_gpa = gpa;
+		return 0;
+	}
 
 	/*
 	 * MBEC differentiates based on the effective U/S bit of
@@ -7496,8 +7497,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
 		access |= PFERR_USER_MASK;
 
-	w->gva_to_gpa(vcpu, w, gpa, access, &result, exception);
-	return result;
+	return w->gva_to_gpa(vcpu, w, gpa, access, translated_gpa, exception);
 }
 
 struct kvm_x86_nested_ops vmx_nested_ops __initdata = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 53400fda9f44..59b38484a0d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7315,10 +7315,17 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 
 	*ret = -KVM_EFAULT;
 	while (offset < sizeof(clock_pairing)) {
-		gpa_t gpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr + offset,
-					      PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);
-		size_t len = min_t(size_t, sizeof(clock_pairing) - offset,
-				   PAGE_SIZE - offset_in_page(gpa));
+		gpa_t gpa;
+		size_t len;
+		int r;
+
+		r = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr + offset,
+				      PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK,
+				      &gpa, NULL, 0);
+		if (r)
+			return r;
+		len = min_t(size_t, sizeof(clock_pairing) - offset,
+			    PAGE_SIZE - offset_in_page(gpa));
 
 		if (gpa == INVALID_GPA)
 			return 0;
-- 
2.52.0


