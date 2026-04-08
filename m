Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAA3DB652
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662967; cv=none; b=uWVZjlc2gq1X0ysqXKTgwiBCYCB6eARZu99h80D0+iy8JVEdwWXYG7M0j9AK+6U2MHE0fugNRvj23WIZ0dELK9kXzax0kdhC634SM1gVTawoI63QuPqXeddLbztQNK9kPc0NCV3gfevXp6EcICKvywB8GX6N/3C85DW7mkJeNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662967; c=relaxed/simple;
	bh=Vi2h6wgXSqS0Z3npITZpTKJzqvGpkE+E7w8apfBRHU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTLe4QLHD3WUCz3u7aPJEdUKWizGrE93Mr7W3JZQgRoK0MVz4DMiJ32f4zfteN0mSegJ9BwG+CsmCT7aHk4Rxm36lhFonW1qJol2hnGLR6hPftFddRdocvEw33JK9TnJ+NCkcWUlKI+j6+hR7zK3kwbwy6XLqDrQ6wHiAuPxZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FgLs291H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgLs291H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2s/gpUseP+WPonCcnkk3uiS88opdY1tg3pny2c7juOg=;
	b=FgLs291HZH01mxxDj6IIeC2d+zgGrxCxMXndS5ZK44YMc6feWDhdwZzkGIOH+IZKXHoK3u
	ujxKTfaCsmm+i+YNcebRHkNDINa15SzgBiv9JY9ZEiVB+p/fvoQ+L7EKY/KhdEJn5nQdaV
	epFp6xGXtk5BQ6DB4OO3nUAd7b/+ftA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-EgcAuF1sMauVfa5NI_ietw-1; Wed,
 08 Apr 2026 11:42:39 -0400
X-MC-Unique: EgcAuF1sMauVfa5NI_ietw-1
X-Mimecast-MFC-AGG-ID: EgcAuF1sMauVfa5NI_ietw_1775662957
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F74F1955D79;
	Wed,  8 Apr 2026 15:42:37 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A45C19560A6;
	Wed,  8 Apr 2026 15:42:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 18/27] KVM: x86/mmu: add support for MBEC to EPT page table walks
Date: Wed,  8 Apr 2026 11:42:08 -0400
Message-ID: <20260408154217.458420-19-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Extend the page walker to support moving bit 10 of the PTEs
into ACC_USER_EXEC_MASK and bit 6 of the exit qualification of
EPT violation VM exits.

Note that while mmu_has_mbec()/cr4_smep affect the interpretation of
ACC_USER_EXEC_MASK and add bit 10 as a "present bit" in guest EPT page
table entries, they do not affect how KVM operates on SPTEs.  That's
because the MMU uses explicit ACC_USER_EXEC_MASK/shadow_xu_mask even for
the non-nested EPT; the only difference is that ACC_USER_EXEC_MASK and
ACC_EXEC_MASK will always be set in tandem outside the nested scenario.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 13 +++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h | 27 +++++++++++++++++++++------
 arch/x86/kvm/mmu/spte.h        |  2 ++
 arch/x86/kvm/vmx/nested.c      |  9 +++++++++
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c4da7a42c77f..07bdc8f9b0cb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5555,7 +5555,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
-	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
@@ -5596,8 +5595,18 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		u16 smapf = 0;
 
 		if (ept) {
-			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
+			const u16 xs = ACC_BITS_MASK(ACC_EXEC_MASK);
+			const u16 xu = ACC_BITS_MASK(ACC_USER_EXEC_MASK);
+
+			if (pfec & PFERR_FETCH_MASK) {
+				/* Ignore XU unless MBEC is enabled.  */
+				if (cr4_smep)
+					ff = pfec & PFERR_USER_MASK ? (u16)~xu : (u16)~xs;
+				else
+					ff = (u16)~xs;
+			}
 		} else {
+			const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 
 			/* Faults from kernel mode accesses to user pages */
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index f5f9e745f21d..7d7c617885fa 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -124,12 +124,17 @@ static inline void FNAME(protect_clean_gpte)(struct kvm_mmu *mmu, unsigned *acce
 	*access &= mask;
 }
 
-static inline int FNAME(is_present_gpte)(unsigned long pte)
+static inline int FNAME(is_present_gpte)(struct kvm_mmu *mmu,
+					 unsigned long pte)
 {
 #if PTTYPE != PTTYPE_EPT
 	return pte & PT_PRESENT_MASK;
 #else
-	return pte & 7;
+	/*
+	 * For EPT, an entry is present if any of bits 2:0 are set.
+	 * With mode-based execute control, bit 10 also indicates presence.
+	 */
+	return pte & (7 | (mmu_has_mbec(mmu) ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
 #endif
 }
 
@@ -152,7 +157,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
 {
-	if (!FNAME(is_present_gpte)(gpte))
+	if (!FNAME(is_present_gpte)(vcpu->arch.mmu, gpte))
 		goto no_present;
 
 	/* Prefetch only accessed entries (unless A/D bits are disabled). */
@@ -173,10 +178,17 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 static inline unsigned FNAME(gpte_access)(u64 gpte)
 {
 	unsigned access;
+	/*
+	 * Set bits in ACC_*_MASK even if they might not be used in the
+	 * actual checks.  For example, if EFER.NX is clear permission_fault()
+	 * will ignore ACC_EXEC_MASK, and if MBEC is disabled it will
+	 * ignore ACC_USER_EXEC_MASK.
+	 */
 #if PTTYPE == PTTYPE_EPT
 	access = ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
 		((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
-		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
+		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0) |
+		((gpte & VMX_EPT_USER_EXECUTABLE_MASK) ? ACC_USER_EXEC_MASK : 0);
 #else
 	/*
 	 * P is set here, so the page is always readable and W/U/!NX represent
@@ -331,7 +343,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	if (walker->level == PT32E_ROOT_LEVEL) {
 		pte = mmu->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
-		if (!FNAME(is_present_gpte)(pte))
+		if (!FNAME(is_present_gpte)(mmu, pte))
 			goto error;
 		--walker->level;
 	}
@@ -414,7 +426,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		pte_access = pt_access & (pte ^ walk_nx_mask);
 
-		if (unlikely(!FNAME(is_present_gpte)(pte)))
+		if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
 			goto error;
 
 		if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
@@ -521,6 +533,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * ACC_*_MASK flags!
 		 */
 		walker->fault.exit_qualification |= EPT_VIOLATION_RWX_TO_PROT(pte_access);
+		if (mmu_has_mbec(mmu))
+			walker->fault.exit_qualification |=
+				EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
 	}
 #endif
 	walker->fault.address = addr;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index f5261d993eac..fe9571837fee 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -395,6 +395,8 @@ static inline bool __is_rsvd_bits_set(struct rsvd_bits_validate *rsvd_check,
 static inline bool __is_bad_mt_xwr(struct rsvd_bits_validate *rsvd_check,
 				   u64 pte)
 {
+	if (pte & VMX_EPT_USER_EXECUTABLE_MASK)
+		pte |= VMX_EPT_EXECUTABLE_MASK;
 	return rsvd_check->bad_mt_xwr & BIT_ULL(pte & 0x3f);
 }
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e0ef2cb8f2cd..925dfa7f54df 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7450,6 +7450,15 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	BUG_ON(!mmu_is_nested(vcpu));
+
+	/*
+	 * MBEC differentiates based on the effective U/S bit of
+	 * the guest page tables; not the processor CPL.
+	 */
+	access &= ~PFERR_USER_MASK;
+	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
+		access |= PFERR_USER_MASK;
+
 	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
 }
 
-- 
2.52.0


