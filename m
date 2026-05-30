Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2033FE15
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160155; cv=none; b=P3wasdraqCiJDF1WHNABIEPZiDqqui4KEDElXqgNuS3Luk1j40cc5mq09ZDs6gboyC+7zE5K9DO0OmIGA8i1Hxg72sdmXTiNeyeA3/zLhqfsZX4QOBkZwoDP2w17fY90IB+tt4ohRopv45o+qee2W1DnLvP2l8TUCAtMjcSGvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160155; c=relaxed/simple;
	bh=ZyfpNgGklaSEhCthBgaCX8tV/5LmuUXzQoSStF7G2PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hb64O22bMGcjKKsXae11X7JBvM2I+nQUh6TPN5K68ElmbRl2iFwZLXvq2BKkY5bKC7kLwcGPmRXyge16HczIpCfqB8UEHqv0uoUiAnKlR4toa3IsGia9kVo9p7fxXPCDZQUp0rgsbkjBS28iHStxzCwUTQGhlsyTnSmskT9lNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uy8gOPPe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uy8gOPPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MqUsSM+54sbSP1UmNzpzmrG8YOArV4GH7BmQv0m3oM=;
	b=Uy8gOPPeKM6qt4WTIDa/6crVGjwsO2xSxRRD673623oQMi38yLn20mnMLYiXC4cuNJUuPG
	x4PXCfjWIqmOokyFdnXdGNnJTFLssrTafsOduC7Y4FxuoeAUkhRN1OJ5jQo9bHkMX+06uD
	Xhkzbbh2detCvjNrvTGgvBEl9yiFgEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-VMsJmDB-OxGyrFc0BSv0rA-1; Sat,
 30 May 2026 12:55:51 -0400
X-MC-Unique: VMsJmDB-OxGyrFc0BSv0rA-1
X-Mimecast-MFC-AGG-ID: VMsJmDB-OxGyrFc0BSv0rA_1780160150
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43F851800372;
	Sat, 30 May 2026 16:55:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8FF21800465;
	Sat, 30 May 2026 16:55:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2 5/5] KVM: x86/mmu: move pdptrs out of the MMU
Date: Sat, 30 May 2026 12:55:45 -0400
Message-ID: <20260530165545.25599-6-pbonzini@redhat.com>
In-Reply-To: <20260530165545.25599-1-pbonzini@redhat.com>
References: <20260530165545.25599-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

PDPTRs are part of the CPU state.  A bit unconventionally, they are
reached via vcpu->arch.walk_mmu instead of being stored in vcpu->arch
directly.  That is nice in principle---it would allow TDP shadow paging
to have its own PDPTRs---but it is not necessary, because EPT has no
PDPTRs and NPT does not cache them.

Since kvm_pdptr_read does not otherwise need the MMU, drop the pdptrs
from the MMU altogether.  There is however something to be careful
about, in that PDPTRs are now not stored separately in root_mmu and
nested_mmu for L1 and L2 guests.  In practice this was already not
an issue:

- for EPT the VMCS0x has to keep them up to date; and for the purpose
  of emulation they are always loaded from the VMCS on vmentry/vmexit,
  thanks to the clearing of dirty and available register bitmaps in
  vmx_switch_vmcs()

- for NPT, VCPU_EXREG_PDPTR is similarly cleared for nNPT, which does
  not cache the PDPTRs; while for non-nNPT the PDPTRs are loaded
  together with the load of CR3.

Note that page table PDPTRs are not affected, since they are stored
in pae_root.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  5 ++---
 arch/x86/kvm/kvm_cache_regs.h   |  4 ++--
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 20 ++++++++------------
 arch/x86/kvm/x86.c              |  6 +++---
 5 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2a4be06177ff..02ac77b54c58 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -540,10 +540,7 @@ struct kvm_mmu {
 	 * the bits spte never used.
 	 */
 	struct rsvd_bits_validate shadow_zero_check;
-
 	struct rsvd_bits_validate guest_rsvd_check;
-
-	u64 pdptrs[4]; /* pae */
 };
 
 enum pmc_type {
@@ -902,6 +899,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu *walk_mmu;
 
+	u64 pdptrs[4]; /* pae */
+
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
 	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
 	struct kvm_mmu_memory_cache mmu_shadowed_info_cache;
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 6bae5db5a54e..2a93e8c45c1a 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -192,12 +192,12 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 	if (!kvm_register_is_available(vcpu, VCPU_REG_PDPTR))
 		kvm_x86_call(cache_reg)(vcpu, VCPU_REG_PDPTR);
 
-	return vcpu->arch.walk_mmu->pdptrs[index];
+	return vcpu->arch.pdptrs[index];
 }
 
 static inline void kvm_pdptr_write(struct kvm_vcpu *vcpu, int index, u64 value)
 {
-	vcpu->arch.walk_mmu->pdptrs[index] = value;
+	vcpu->arch.pdptrs[index] = value;
 }
 
 static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vcpu, ulong mask)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 84496bc0508d..58a87a1b2ff8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1526,7 +1526,7 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	switch (reg) {
 	case VCPU_REG_PDPTR:
 		/*
-		 * When !npt_enabled, mmu->pdptrs[] is already available since
+		 * When !npt_enabled, vcpu->pdptrs[] is already available since
 		 * it is always updated per SDM when moving to CRs.
 		 */
 		if (npt_enabled)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f13d56bc32d1..3570e83ef280 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3376,30 +3376,26 @@ void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-
 	if (!kvm_register_is_dirty(vcpu, VCPU_REG_PDPTR))
 		return;
 
 	if (is_pae_paging(vcpu)) {
-		vmcs_write64(GUEST_PDPTR0, mmu->pdptrs[0]);
-		vmcs_write64(GUEST_PDPTR1, mmu->pdptrs[1]);
-		vmcs_write64(GUEST_PDPTR2, mmu->pdptrs[2]);
-		vmcs_write64(GUEST_PDPTR3, mmu->pdptrs[3]);
+		vmcs_write64(GUEST_PDPTR0, vcpu->arch.pdptrs[0]);
+		vmcs_write64(GUEST_PDPTR1, vcpu->arch.pdptrs[1]);
+		vmcs_write64(GUEST_PDPTR2, vcpu->arch.pdptrs[2]);
+		vmcs_write64(GUEST_PDPTR3, vcpu->arch.pdptrs[3]);
 	}
 }
 
 void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-
 	if (WARN_ON_ONCE(!is_pae_paging(vcpu)))
 		return;
 
-	mmu->pdptrs[0] = vmcs_read64(GUEST_PDPTR0);
-	mmu->pdptrs[1] = vmcs_read64(GUEST_PDPTR1);
-	mmu->pdptrs[2] = vmcs_read64(GUEST_PDPTR2);
-	mmu->pdptrs[3] = vmcs_read64(GUEST_PDPTR3);
+	vcpu->arch.pdptrs[0] = vmcs_read64(GUEST_PDPTR0);
+	vcpu->arch.pdptrs[1] = vmcs_read64(GUEST_PDPTR1);
+	vcpu->arch.pdptrs[2] = vmcs_read64(GUEST_PDPTR2);
+	vcpu->arch.pdptrs[3] = vmcs_read64(GUEST_PDPTR3);
 
 	kvm_register_mark_available(vcpu, VCPU_REG_PDPTR);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1913efef6c39..8dea09b20162 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1071,7 +1071,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	gpa_t real_gpa;
 	int i;
 	int ret;
-	u64 pdpte[ARRAY_SIZE(mmu->pdptrs)];
+	u64 pdpte[ARRAY_SIZE(vcpu->arch.pdptrs)];
 
 	/*
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
@@ -1100,10 +1100,10 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * Marking VCPU_REG_PDPTR dirty doesn't work for !tdp_enabled.
 	 * Shadow page roots need to be reconstructed instead.
 	 */
-	if (!tdp_enabled && memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs)))
+	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs)))
 		kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);
 
-	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
+	memcpy(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_REG_PDPTR);
 	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 	vcpu->arch.pdptrs_from_userspace = false;
-- 
2.52.0

