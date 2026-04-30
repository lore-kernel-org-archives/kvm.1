Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBB31F99C
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561692; cv=none; b=Bfbi/0PapoBnEo5gpvu/UwocTptmSpDfeLT4fx7s2S5JwqmA0e7B6bsMBAoz+3qRnMGpNhJg9El1AKhHNTjn3a0H1966BgUa5bBJDDOG/rmHy+0V4V2EcAANqPvzpp0sFLtH6FwTp4OOAFH6r/4gT6Tgz6GfarYNKsV+xHs2pG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561692; c=relaxed/simple;
	bh=GZSSTljDv+ergzv4M2yqC91lQETUIFR9uFQF4nCQLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNaSWfy5bay94Y0/CubE63xn4VDyEfaoEUFlldcJZwV32ZVoQEuGOPfvBH85GxdrGTZol6NNu1GzG/b2jTdAIdHsTQU2PkJ7OZI7YCagU9v53aI6CkIBXiA3UMm1duVg7WjifzHBiW2MLf5/n12JIUFGdhqLjBONQ82uUYL+b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/rURbYe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/rURbYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZeZAbqcBwGRE4+Xb1AswEMbnFoIKz17RW1UR3CzwhE=;
	b=D/rURbYe92zrluC4qhGyy4vdOMdlqbI/riOsrcXoqp0xRUh2zT1WbsiirOVcBZKcYoYpTN
	k15M2vxBI5OdZAxPY7mQxF4WB9R19rzyVOSCZ2m0GYYKom5PUTK7/YqAK4NinHKq5ockfu
	RWPR6LwVnnVyxHwAdcx77Vj5MdY7PiY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-eWwqrcbnN0GD_xt9snrH-g-1; Thu,
 30 Apr 2026 11:08:04 -0400
X-MC-Unique: eWwqrcbnN0GD_xt9snrH-g-1
X-Mimecast-MFC-AGG-ID: eWwqrcbnN0GD_xt9snrH-g_1777561683
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E421956059;
	Thu, 30 Apr 2026 15:08:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D51B1955D84;
	Thu, 30 Apr 2026 15:08:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 18/28] KVM: x86/mmu: add support for MBEC to EPT page table walks
Date: Thu, 30 Apr 2026 11:07:37 -0400
Message-ID: <20260430150747.76749-19-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Extend the page walker to support moving bit 10 of the PTEs
into ACC_USER_EXEC_MASK and bit 6 of the exit qualification of
EPT violation VM exits.

Note that while mmu_has_mbec()/cr4_smep affect the interpretation of
ACC_USER_EXEC_MASK and add bit 10 as a "present bit" in guest EPT page
table entries, they do not affect how KVM operates on SPTEs.  That's
because the MMU uses explicit ACC_USER_EXEC_MASK/shadow_xu_mask even for
the non-nested EPT; the only difference is that ACC_USER_EXEC_MASK and
ACC_EXEC_MASK will always be set in tandem outside the nested scenario.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 13 +++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h | 27 +++++++++++++++++++++------
 arch/x86/kvm/mmu/spte.h        |  2 ++
 arch/x86/kvm/vmx/nested.c      |  9 +++++++++
 4 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 245a2e92793d..fe87eee43b09 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5570,7 +5570,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
-	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
@@ -5611,8 +5610,18 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
index d4ce55195a7c..f741f7d4cc2d 100644
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
index 46b65475765d..84f5c25a1f12 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7452,6 +7452,15 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
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


