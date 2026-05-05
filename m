Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974E3CAE7D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010785; cv=none; b=PVjMxHqnuABYpuKdvsgBRf2VQOlqWgQw0Qna/2Pxs6oOs5qC6+yZ8y+AGsh1q0nDMGh2UG52Wz8qmEgeQUcZa7U2ntYz7f6WmEWK/IeRQ8rt5EMzLEnnnIJ9EjgLlC+LJtV6WdOz6YEJmp+fmxjOa2HvWrKPgezjDjbog6+Fdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010785; c=relaxed/simple;
	bh=7mx2Rcdlygnmrs2vjtPcfbzzCBA11TiFb3NszhIEg/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rc+XXOliSOOHTg9IMDPYz9SFXdzI8berozrU9HNOdLW/2zYeiArAwnAs2iOfGrVQSxdlOBTVflcEPVoWjHVjk+nHW+Oq8A+DDnyAVeGAfrfQAOrDSPE/BowRx5Q7Q79A4NqigtyVuqOsTcgpev2FB7cequzjzav25/KFqkJtX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGYOF9vG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tZ5iXO7R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGYOF9vG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tZ5iXO7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N4tj7QeNb58lXu2azaV28nS46uz+bzJfiBhVJBY6iLw=;
	b=AGYOF9vGwPfbAfSv0bl6ekb67tv3iDo41akv0C8/+OOImhvdR70jGCqm1iD3iZ+uccZTel
	bcdgCPFAkegOWcjV9RjQCIIYbdRx3R749Qye1s1fkkC6GjLidPSQahKgKP2WvxYk+KLi85
	77zqDxv1sU1uYB0t/qzJPGh7TaVEte0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-ktPp75d0PVmbAr0-1n8p_Q-1; Tue, 05 May 2026 15:52:59 -0400
X-MC-Unique: ktPp75d0PVmbAr0-1n8p_Q-1
X-Mimecast-MFC-AGG-ID: ktPp75d0PVmbAr0-1n8p_Q_1778010778
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449dcfe8005so4623114f8f.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010778; x=1778615578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4tj7QeNb58lXu2azaV28nS46uz+bzJfiBhVJBY6iLw=;
        b=tZ5iXO7R2uu7dSc/U34XdWUUcqe1kNxapnTfxIzf3LAU+krSiW0/r7ii8IbqjPW/Et
         FndRqFTGWTwBssgJhwrlczhA18VNFxuPtRpavP2t+T0M+b0kOpBAtLDnE3938+rvdktk
         fqfBd4WSbRrYI29JHu+rFBFc4BZQ8dmKu+8D2bTwm0CQI7h63efTtUd23NrdNz6+6QA3
         JDmknYjf0PurvU1w1FprnCXHWqOSbJiLKw0qkwppBO8MC/HlLoVYa85IdzIVeoTUcCgR
         TP+yRtyGoSmxMoN4WJLll57esiJsUnWxScYFx6HNtYITrW8sLd+oOw+Vd8BMUPdqfWFJ
         epsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010778; x=1778615578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4tj7QeNb58lXu2azaV28nS46uz+bzJfiBhVJBY6iLw=;
        b=ih+SrE1sADYjoi3ZPZpj+zsZbOXeD3K783CyLIGu1O6+3P//4c13BeXGy7xtCNbK8V
         oSHxeNncsgwJEpkcWgnNV7eR6eMTM+CC9oPA2BCUo7dLiFEMkIu1i3HcjtoHUDf45vee
         Vg+XCE3N1Bh8chi0FAKF7jGQQgthVUw2ntEJuJrnRGSFyywpr3mzSh04ZQNNXIEmPpoa
         01FnpX2leJUCqhiYF7de/xpvsULUVFM5GpEF9j9qDvoak75yVOOpyplmQe4tv8CgXjJD
         Zk151eapX0oGvNSy26O0FjN6g5h24mTpmh0Qc3cBHjtTIhKdFAXjrsUIa75F/XDHgMx7
         1wAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ypdIVGmwp/nmFkbhoNxlr8paj6Jm+UxTdNZJ5mXG62Ux73Byln+nj/KimZLhRN4D77pE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcn+zSKN/1RSTdpLZIQ3VqY1BCBlOCAfCVzm3THpiTN2oCDvkK
	x7Jp5r1s/h213dipwVMC3iVKP1AMeuwxaXXhYGDHafhWPfaQH1JsERIzvHY/eNZ5wUpXkBri4uP
	THOBS3/Mpb+k7U7Zo8zDprrf433qtSB8EysDdLf2PNyBHJZuUlu4F8Q==
X-Gm-Gg: AeBDievsGQnIzbh6XemQsEl2LM4j8FGNsRWrKZ6HdnKlLA7zHX48GK3nHohiT2wbeAU
	fLUhPgZcwaVZUfzpXdwUwg7nG1MR+jv56EDWuBjeLWE/wT2nWSDTzdamdT+RcRjmzh6+NYiS1uF
	L/Ks+s5bYnn0Q2p/sbYiNiwRFoYsd5Wo2/Absu5Jpu0dcBfjmbKJeSA6OIPRpCwY+4ltkVTrTtl
	8yia5zlcrgbolumBQUx3RUjBCRGIe+jO4/XuToHrbz/tLTDZ9bJ2Fmrc4PNQZfPxXx1xspu6xFg
	8p/zIjLfDMm1qTaRtMnchXvb6GHYRVYu4vvguQTuSJcVrlpPH2YaDlRbQ+abpzB9JPikzqUlSu+
	kwv/NN/Upy6FOgtP04AVTpW09Upl1Tx8GIMsiRd4a3L6VIwTT2VpYP/plOZgKfDr1tVO8d6xYJe
	/XwY5q32Jo8FcdWzVJO8gMSuauxBAEb1BqZUY3WSc=
X-Received: by 2002:a05:600c:34c8:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48e51f2ed22mr11863755e9.15.1778010778258;
        Tue, 05 May 2026 12:52:58 -0700 (PDT)
X-Received: by 2002:a05:600c:34c8:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-48e51f2ed22mr11863355e9.15.1778010777821;
        Tue, 05 May 2026 12:52:57 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52859ac7sm1615405e9.1.2026.05.05.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 12/28] KVM: x86: make translate_nested_gpa vendor-specific
Date: Tue,  5 May 2026 21:52:10 +0200
Message-ID: <20260505195226.563317-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.54.0

