Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E56425CFB
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549094; cv=none; b=clmgZ+47xra3dbfaGgiV8sEQTntVrz8/Ux/2NBpwz6zZ70Q2AcLFDT5dffq2O3e8VgIswfwTlIP64AvTMOg+tgaJK4/R+BAolZecLmpU45Qy3v13EMEmEH+ytns3dK5A5n0bdT5C2+KRbmvcGaL7Py/rTxIBtYj96tTrJSzn+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549094; c=relaxed/simple;
	bh=8jc9qasPQEJtjMNrB6TSw8n8P34GibmcgRAgDSNYJZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp2ToEMSXHdeEzzv71vTEKkSZTxcbCcXGyBGtBY3+S+8mB/EoHdzi64udEf6bT3m0KZVfAT1EH0TxPL+cgT9zit0RDBhq09P4WFNRQc7uKyMweY64z97gilzcnfk2fup/YrWpfKdO4mCC6hjrtQxwVXzcVLIQ0GxsmIBXHOnFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzdC7p0v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL0V3ZKy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzdC7p0v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL0V3ZKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSdMfPXfsmtQMuSqhfU0sdTptN3/E4detZ+Ck4ZdAzw=;
	b=BzdC7p0v/k2mWg1HJBZANEFXl1c6nmm0rTpzl8Ptn37XRgUWeQMGyaSR9Ak4HYcpkff//i
	YIKnT2VLrBvOY/AzesAKP9OMR8TKfYxGVkiJ6Aeov2y/skHq5lqKUhZ14p0zP/LcMIr1D0
	TTM8XO2R0RS+RlOPR5w81p92pqT4TEc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-ecw_6YBKN1yy3DXnT1q8QA-1; Thu, 26 Mar 2026 14:18:08 -0400
X-MC-Unique: ecw_6YBKN1yy3DXnT1q8QA-1
X-Mimecast-MFC-AGG-ID: ecw_6YBKN1yy3DXnT1q8QA_1774549087
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3e0a73f8so980204f8f.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549087; x=1775153887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSdMfPXfsmtQMuSqhfU0sdTptN3/E4detZ+Ck4ZdAzw=;
        b=OL0V3ZKyGV+o46L0eE99uQLNClKT1O9pQEQpSPvFEo78uzj2szx48NUxDy4+2DGZou
         EZFatAlg2P91EDbESq/RMbQrorMIqcn4MqUpNIlNgsHXGgo6+cWg5oJ2BHmKX4Yav2aN
         QBXoNt2PnSthvH0TdCaPWFZnCVCbfIfWwQssTr10UDujxB2M6DNM7r3r+t9rbQMpHs/O
         j739Ca3YwDGtxLKOcDNnayX2PPbQ6AaPM9kLPbeDU3x8ZrC9s16nh45rNdW3dsgxyBTy
         vDvmSDVSniMiBB84ZUEqRNwM/unolsfR1F6Nr4F7Bs+foRiWFlFszNAx2zgdmNH0uJIr
         1vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549087; x=1775153887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSdMfPXfsmtQMuSqhfU0sdTptN3/E4detZ+Ck4ZdAzw=;
        b=Kf8dINxyf4j97DSnV7J0euKi/c9vTLZPoGpgl3NxoQcdMfstVjgwjPeOjGJL9Yr4T8
         3Z11TFC+vpiQ9IwTY13K1hUPc8keXMSh/dhP7ME4QHX/BI+XObAyBS5uChuDQ6vfAP+i
         YTUREDf9oUWVBIuh+RsUXCn4B574sIZYc2WlJJTdLUuSkaIyKKpmrS2CfnWL+7/9vLjC
         S8uqriU6BXskmPH+IVQNxqovHK6knyPyqbUOOINI3oJ74DaquRpiBaMu3xQc2KT1SOLw
         Xqfbkh/KYJl2cckk2PKOTC3YWM+iAQ1DE+fiqMZx7RxKb/YjiWqa0nRTgr4XuTY584Hj
         +G1g==
X-Forwarded-Encrypted: i=1; AJvYcCX3baCuW2JeXdL1xQULFBToI91S4FGxrcRjY/KA5GN5e4e9l9c15y65SwtRSGNwoPq23ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6PxyOyQY1oFC+gZFNj0pP6EKKpjBUsigiJSly7boryzElC+S
	Amm/QyNp8AHm8blkBemIZh/si6QYTDbgrmWPZ9SJctEiPy7rlRhVBa3p+L+wgBZYX6R/XOzTTJe
	A2BCiYO01QAU4V8C4KGe+13vxqjpxJ+bYIWUMxkYdfNmbNCk/G0FKpw==
X-Gm-Gg: ATEYQzz5qYUkgeaAykPy+9Whrt03AsJuiv7fQhlipU9TkINzIz83neXh2KZOgkTKBDl
	ovrn03M6uFkve3F8cQc11jqdz1+32BsIJtPORowqdsZymGI3hf8/ETFjEQ4kIIDyizFCXUYTSkJ
	GaF5+Ph8JfNkKRdXw4Us6hPPybA6KZeTrE3EB9pYBhcOHy0r/j1tRBK5KT8h/B/Ug1PAok6VBSv
	qPIRmCRjpb+Yaq85+njazhFxyii9rqzH38FssLCGnBsFlpHM9QvX3w5BPBBFnHJsRJ3yrHTnk01
	o3CuS9H/LYGKevwVIrjNRi9AdnuSgNKwRtHuP0xTWeMEMWnRulbv4PXYGEZmb6/MHggkji9eoao
	wLXll4qVCltMvCS0ihF39MKb4MlBdohk6YsqUfaAuxdmP/+BaQ8OKOyVNlMINyxIfxCeoC27vF3
	FAe8xAoR0wlijFh7cO68izOCFy
X-Received: by 2002:a05:6000:40cd:b0:43b:4aba:8f38 with SMTP id ffacd0b85a97d-43b88a956b7mr13404575f8f.47.1774549086848;
        Thu, 26 Mar 2026 11:18:06 -0700 (PDT)
X-Received: by 2002:a05:6000:40cd:b0:43b:4aba:8f38 with SMTP id ffacd0b85a97d-43b88a956b7mr13404514f8f.47.1774549086254;
        Thu, 26 Mar 2026 11:18:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919dfb54sm9816606f8f.31.2026.03.26.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 15/24] KVM: x86/mmu: add support for MBEC to EPT page table walks
Date: Thu, 26 Mar 2026 19:17:13 +0100
Message-ID: <20260326181723.218115-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e768aeb05886..cd2418fe8708 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5551,7 +5551,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned byte;
 
-	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
@@ -5592,8 +5591,18 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
index 09e2e630d4b6..95aa1b4fc327 100644
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
@@ -413,7 +425,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		pte_access = pt_access & (pte ^ walk_nx_mask);
 
-		if (unlikely(!FNAME(is_present_gpte)(pte)))
+		if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
 			goto error;
 
 		if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
@@ -518,6 +530,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * ACC_*_MASK flags!
 		 */
 		walker->fault.exit_qualification |= EPT_VIOLATION_RWX_TO_PROT(pte_access);
+		if (mmu_has_mbec(mmu))
+			walker->fault.exit_qualification |=
+				EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
 	}
 #endif
 	walker->fault.address = addr;
-- 
2.53.0

