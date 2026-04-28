Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCDC3FA5EA
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374608; cv=none; b=WfrZWuptawnITORck8D9tuagLK7h4PfzMC2ihHandNW2K38qHvnsY3QxM21rMSoigqyLcF8+MBiu+n1BdCwycPlb7+P0LdQX9Rq7TW0maAgdqiLRUIqqXxE4sEH0lNKx93mGOPHDCa7v2bQx7dNSzWZodmeWcf8LN4W/DAq64pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374608; c=relaxed/simple;
	bh=bSg7XmRbrruQa2PqC5StFoRIwS95D3bE1el8XO+L7IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9S4g+tNrxbICh28WxuCdWxzpM4ge9sQyzPZOL89frXJQcj5IWHbFcY08TIZyxcXPg+bR+tHHwY97Lso5oPXR5gh2VIYnWOAXYBNLohdsgGf3NCEV88wq5xRWsAnNliz/5eEZdikNhE2CnVoQ6NHLCmha9oNawipXV3ZVavwo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fllqb5h1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fllqb5h1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4I+ErKCcFAyo+V91TRlTUsn1L5S+t2tgXLY5cfXULw=;
	b=fllqb5h1N0FeanlNhMLDzfXbYntvjRjikTaOjM8n/xU8cm9P1Qbkd2GZ7fHr56BgiiN8Ed
	ESA+1bYzVMyjHOdJVItzuuBROxnLgDTWrNeatpoQBLnp1SomWPlMw6R38SXfINYRXYATVG
	yP7hfhsLpSvlqJILaRt8Rosvsi3fgEU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-NACe8r25O3OKAZ_NhnQ2kw-1; Tue,
 28 Apr 2026 07:09:58 -0400
X-MC-Unique: NACe8r25O3OKAZ_NhnQ2kw-1
X-Mimecast-MFC-AGG-ID: NACe8r25O3OKAZ_NhnQ2kw_1777374597
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACE4418005AA;
	Tue, 28 Apr 2026 11:09:57 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FC15180045E;
	Tue, 28 Apr 2026 11:09:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 12/28] KVM: x86: make translate_nested_gpa vendor-specific
Date: Tue, 28 Apr 2026 07:09:30 -0400
Message-ID: <20260428110946.11466-13-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

EPT and NPT have different rules for passing PFERR_USER_MASK to the
nested page table walk.  In particular, for final addresses EPT
uses the U bit of the guest (nGVA->nGPA) walk.

While at it, remove PFERR_USER_MASK from the VMX version of the
function, since it is actually ignored by the tables that
update_permission_bitmask() generates for EPT.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 arch/x86/kvm/hyperv.c           |  3 ++-
 arch/x86/kvm/mmu.h              |  9 +++------
 arch/x86/kvm/svm/nested.c       | 15 +++++++++++++++
 arch/x86/kvm/vmx/nested.c       | 12 ++++++++++++
 arch/x86/kvm/x86.c              | 16 ----------------
 6 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8f2a1b915df9..62dc782b2dd3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2010,6 +2010,10 @@ struct kvm_x86_nested_ops {
 			 struct kvm_nested_state *kvm_state);
 	bool (*get_nested_state_pages)(struct kvm_vcpu *vcpu);
 	int (*write_log_dirty)(struct kvm_vcpu *vcpu, gpa_t l2_gpa);
+	gpa_t (*translate_nested_gpa)(struct kvm_vcpu *vcpu, gpa_t gpa,
+				      u64 access,
+				      struct x86_exception *exception,
+				      u64 pte_access);
 
 	int (*enable_evmcs)(struct kvm_vcpu *vcpu,
 			    uint16_t *vmcs_version);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 53688f7b76eb..f35fae3a7b3d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
-		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
+		hc->ingpa = kvm_x86_ops.nested_ops->translate_nested_gpa(
+					vcpu, hc->ingpa,
 					PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 635c2e5d8513..63be5c5efed9 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -294,10 +294,6 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 	atomic64_add(count, &kvm->stat.pages[level - 1]);
 }
 
-gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception,
-			   u64 pte_access);
-
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
@@ -306,8 +302,9 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return translate_nested_gpa(vcpu, gpa, access, exception,
-				    pte_access);
+	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
+							    exception,
+							    pte_access);
 }
 
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f45..df232153eb24 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2071,8 +2071,23 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	return true;
 }
 
+static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
+				      u64 access,
+				      struct x86_exception *exception,
+				      u64 pte_access)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+
+	BUG_ON(!mmu_is_nested(vcpu));
+
+	/* NPT walks are always user-walks */
+	access |= PFERR_USER_MASK;
+	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+}
+
 struct kvm_x86_nested_ops svm_nested_ops = {
 	.leave_nested = svm_leave_nested,
+	.translate_nested_gpa = svm_translate_nested_gpa,
 	.is_exception_vmexit = nested_svm_is_exception_vmexit,
 	.check_events = svm_check_nested_events,
 	.triple_fault = nested_svm_triple_fault,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3fe88f29be7a..cd1924c6e075 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7438,8 +7438,20 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 	return 0;
 }
 
+static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
+				      u64 access,
+				      struct x86_exception *exception,
+				      u64 pte_access)
+{
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+
+	BUG_ON(!mmu_is_nested(vcpu));
+	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+}
+
 struct kvm_x86_nested_ops vmx_nested_ops = {
 	.leave_nested = vmx_leave_nested,
+	.translate_nested_gpa = vmx_translate_nested_gpa,
 	.is_exception_vmexit = nested_vmx_is_exception_vmexit,
 	.check_events = vmx_check_nested_events,
 	.has_events = vmx_has_nested_events,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 67979b7de5d6..7c6942afae81 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7848,22 +7848,6 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 	kvm_x86_call(get_segment)(vcpu, var, seg);
 }
 
-gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception,
-			   u64 pte_access)
-{
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
-	gpa_t t_gpa;
-
-	BUG_ON(!mmu_is_nested(vcpu));
-
-	/* NPT walks are always user-walks */
-	access |= PFERR_USER_MASK;
-	t_gpa  = mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
-
-	return t_gpa;
-}
-
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-- 
2.52.0


