Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641538;
	b=fXsdb14seJa7r1OpshXLobmw91fmBp/CgICcYoaHt9BWqGR9/bLZPwiEqC9aNuuNDaqc
	 PcRkZwnypm2nbu2ukIURrRbC5MRCiiA//j6tyOfUbg8gHSn3YaLC/1eyLX+vy+oktnu4+
	 ooXiTPKaTsq8eCI43D+1bJgClB9FGZUFToH3SXjRYHCvbCJDQp1FxkXF7bNMkbR6YUcys
	 OiLP4lcLXQi+lHRzQOWYq+yq495tLzLYWpgjFyqXcnXxoROLdDPVf18IjVLHu3C4EHbzt
	 UnnVFXat4YzneMiuzPo4AlIlNYf0fp4QaEZpN84mABZu3YpTECTxch/+pqVb4IijT0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641538;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=SbwFKY24Cw/sSoe5pUEIOLf92upMycjKyHq3lH5UZac=;
	b=luwjkG53Od4pVcOzDui1sKW+Z9PhaHLtehz1YByHkFTEMkYEtsIrGJz7sO07Fsh+lGrR
	 bg6LhM4ORbsLS+9wEWVQ3+pTkhcTMY5xFX6GGSBVvu7cHGMElMa1mukC6AdVHWJuk+BTm
	 JBAtQPch1vWfjcXT6FbOrO+hEe578fMY8Phhg/r8yUdW33CuUPV43AWg1lFGFcP99FfO9
	 3CrdfqzMU1luiJoAt6klQbloi1TjgmfhPC85qHB8toBnQG5bdfE1DV/FC0398iXltwphY
	 VVk7kh0HPPyAX3elBkhdp9XtwMeb35nXDzK/ozFYfigWObV8HecCzIH+L7QpyAikV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="E6/auYuP";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3F607DABA
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A3F607DABA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E6/auYuP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbwFKY24Cw/sSoe5pUEIOLf92upMycjKyHq3lH5UZac=;
	b=E6/auYuPfT7uhYS/0YHSJLJKC/rBnHehmbXP/IsFftPQigI2i2aijqa9/iAuxHxQIYywcy
	mKESacTCU0poDRHwGPt3LwogAA4xeF5Ozxw9SNQVW9r+ItKzPO3b3Ov2m9xXfSsjx7gQ07
	I9s0xq/UTlUPUzYDd11MpLqKIDEuVWk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-8cel1qkWM4-OwpwvxOjzbg-1; Mon,
 02 Nov 2026 12:45:33 -0500
X-MC-Unique: 8cel1qkWM4-OwpwvxOjzbg-1
X-Mimecast-MFC-AGG-ID: 8cel1qkWM4-OwpwvxOjzbg_1793641532
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6816318007ED;
	Mon,  2 Nov 2026 17:45:32 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB8C1180057F;
	Mon,  2 Nov 2026 17:45:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 45/45] KVM: x86: split out parts of load_pdptrs
Date: Mon,  2 Nov 2026 12:45:12 -0500
Message-ID: <20261102174512.8903-29-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add new functions that can be used to read and validate the PDPTRs
without placing them in the kvm_vcpu struct.  KVM can use them to
read all the information that is needed for a nested vmentry or vmexit,
and fault out to userspace is needed, prior to committing to completing
the vmentry/vmexit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/regs.c | 51 ++++++++++++++++++++++++++++++++-------------
 arch/x86/kvm/regs.h |  3 +++
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3a11a6d06889..17e5aeb746ef 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -149,17 +149,29 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 	return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
 }
 
+int kvm_validate_pdptrs(struct kvm_vcpu *vcpu, const u64 *pdptrs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.pdptrs); ++i) {
+		if ((pdptrs[i] & PT_PRESENT_MASK) &&
+		    (pdptrs[i] & pdptr_rsvd_bits(vcpu)))
+			return 0;
+	}
+	return 1;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_validate_pdptrs);
+
 /*
- * Load the pae pdptrs.  Return 1 if they are all valid, 0 otherwise.
+ * Read the PAE PDPTRs into @pdptrs.  Return 1 if they are valid, 0 if they are
+ * invalid, and a negative value on error.
  */
-int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
+int kvm_read_validate_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3, u64 *pdptrs)
 {
 	struct kvm_pagewalk *w = &vcpu->arch.gva_walk;
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
 	gpa_t real_gpa;
-	int i;
 	int ret;
-	u64 pdpte[ARRAY_SIZE(vcpu->arch.pdptrs)];
 
 	/*
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
@@ -174,8 +186,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 		return 0;
 
 	/* Note the offset, PDPTRs are 32 byte aligned when using PAE paging. */
-	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdpte,
-				       cr3 & GENMASK(11, 5), sizeof(pdpte));
+	ret = kvm_vcpu_read_guest_page(vcpu, gpa_to_gfn(real_gpa), pdptrs,
+				       cr3 & GENMASK(11, 5), sizeof(vcpu->arch.pdptrs));
 	if (ret == -EFAULT) {
 		kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK, PAGE_SIZE,
 					      false, false, false);
@@ -184,26 +196,37 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	if (ret)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(pdpte); ++i) {
-		if ((pdpte[i] & PT_PRESENT_MASK) &&
-		    (pdpte[i] & pdptr_rsvd_bits(vcpu))) {
-			return 0;
-		}
-	}
+	return kvm_validate_pdptrs(vcpu, pdptrs);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_validate_pdptrs);
 
+void kvm_commit_pdptrs(struct kvm_vcpu *vcpu, const u64 *pdptrs)
+{
 	/*
 	 * Marking VCPU_REG_PDPTR dirty doesn't work for !tdp_enabled.
 	 * Shadow page roots need to be reconstructed instead.
 	 */
-	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs)))
+	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdptrs, sizeof(vcpu->arch.pdptrs)))
 		kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.root_mmu,
 				   KVM_MMU_ROOT_CURRENT);
 
-	memcpy(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs));
+	memcpy(vcpu->arch.pdptrs, pdptrs, sizeof(vcpu->arch.pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_REG_PDPTR);
 	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 	vcpu->arch.pdptrs_from_userspace = false;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_commit_pdptrs);
 
+int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
+{
+	u64 pdptrs[ARRAY_SIZE(vcpu->arch.pdptrs)];
+	int r;
+
+	r = kvm_read_validate_pdptrs(vcpu, cr3, pdptrs);
+	if (r <= 0)
+		return r;
+
+	kvm_commit_pdptrs(vcpu, pdptrs);
 	return 1;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(load_pdptrs);
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 31f4d3f6ea42..86a92a877374 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -63,6 +63,9 @@ unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
 unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
+int kvm_read_validate_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3, u64 *pdptrs);
+int kvm_validate_pdptrs(struct kvm_vcpu *vcpu, const u64 *pdptrs);
+void kvm_commit_pdptrs(struct kvm_vcpu *vcpu, const u64 *pdptrs);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
-- 
2.52.0

