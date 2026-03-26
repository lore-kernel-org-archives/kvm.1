Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C442DFE8
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549107; cv=none; b=gQUP4MwT9jFKPgnAuRviRiknvD3NOoUsj+//X2vKhJYN9fMJRJBE4MT+cMBjUYzjue5BiDzx74IiBcbH1fa9PrkII5kgHTLexBvksnPBCUXVTqrQPNnsS7eaRdv8r3Vq79fh250t989sKMCN8UuHrjB7CaaUuKCvTeleUDE7ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549107; c=relaxed/simple;
	bh=SGJyEL+g3PK8q99YNoRrWIpj0f8lp2CxdOfUmoS4uIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPZB6r7cPi9p2wXgenAgnHXmY+/XIpg3EBq7yXQPkL+ZKOnalGywH8gY8HfNekPm4iMkXtP7ADse1Q27rb0+mpHRBP3fDBBDRWJM0O+dC5upDqvILxpdsuJz+qMJPFNW1NqQqjgSgHEPOZmVcLZI1vGKN9ub8aYS9ej3AZuCp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2sO2u71; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3eqhyWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2sO2u71";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3eqhyWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNZdUK8Qyt6OMDJgqqvESaDgnX6+IknpbbC3gSjOCX8=;
	b=V2sO2u71S1H0CP4Ab4psJdyhT+H4fIaginIVpgTwvyYndS7Lg+OGNN/uXStgUgMGvNGIie
	v6Wa2oi1yOx53bF18OGPe1q0AUK3Du39bMQXdG1iouGMAFlrWCkyb+tdMZUOubsQ2pGbEI
	9BXTZUkyvlsrfKS251kvZ4cZLmfhjyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-CD4tzpmKPhGptA8WySouHg-1; Thu, 26 Mar 2026 14:18:23 -0400
X-MC-Unique: CD4tzpmKPhGptA8WySouHg-1
X-Mimecast-MFC-AGG-ID: CD4tzpmKPhGptA8WySouHg_1774549103
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486f89b7f69so13597665e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549102; x=1775153902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNZdUK8Qyt6OMDJgqqvESaDgnX6+IknpbbC3gSjOCX8=;
        b=a3eqhyWGtSFUN5/xttUxgyzV71mDH6AeCo5zUdo8YIcadLaUI0h5IxK2ulhM5PtwhC
         L1JOJospwsRFUb5rIxj0Q7JZPzMZxnljlzEIXahYdtFbtZ4posNa0mnhz+1Ip3+8pigh
         oQ8LVCF7LUv9sRVc5kj3w4SdFn6WFusmwiOzM0zXYtG2nDpY0E0kE29hp9OXP9U4r9wi
         2HdR0gbIoZJxtMoqT1H8EGb1rpWEizm9/+JZ8nIJSc2iHdYoFyOipUltYq6WE+PxaN8H
         rW0O3VLbfpxD2EQJElM0O0VD4dDPr3p/N9Pu9G+mPZm+Ewk6jYqrNai/vYRby8qHV8Of
         yl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549102; x=1775153902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dNZdUK8Qyt6OMDJgqqvESaDgnX6+IknpbbC3gSjOCX8=;
        b=gTBjWBn/p1T+3tVxxJ7/ptMV/F+7ZjsF/UalXdI5LZV0SN0CFITCC0FZhHHkPUAEJb
         iXXDLp8WhcNiqaggA9JU9lMuT71FkEzr6qZBeij/IxraD/08+06fciRpj3Vl4qbI/G38
         zt8hAHcYiYdFs8HTzBEiUUfbRuumvzw5wya51lpR5PEC2tsA6paag+QB1z1CytNSRl5H
         9uFyYaDCs7dKl8c1AhNioUnVkpMU55MHGcK3lvwQ5/GD4vYmFEl0yNIFl3TrDvSVciNx
         /KHoApbLP38OJL2xqE7ECxaG++CDxaNxekCh0C7yaww2+GakqdNJvNZo5IBpNdAha9Gj
         Ih8g==
X-Forwarded-Encrypted: i=1; AJvYcCXTQ1BGjxZf7oFk2NfNr7SJ/wYy3AS2W30DbOGaCVF7yW6A9Ri16T/RpFOm3uHBk/KLvW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXH52muUjsTGOcqaHVjjEVwgH1lPOuZZwpZpuYsp0ay1wX7PUC
	aNQKLpHP7IS7rav7jz0BCxOzTNEtcD1Q0ZIz1F+HoHGxXDEWvKnl5Hq03dia56AMyLhI+PXLUSY
	faa8ZfmrB9uow9tiQiv6+f6vOo+gG8J7C5M5yJxqUe2nQChA4pmiffg==
X-Gm-Gg: ATEYQzz3oga5umV28oB5eBpoXmDGMRH66ZqBmFmqYKjEn7tp3yp37NydDOs/UfGe1FM
	3+6xGZlwj82RKdnlLdhHQP3GZGu2tLGEh3nzszRaKCrWhWE7ygu9iy2vqjbuC1ceU6WAFxmiPdp
	wZ8qKa5AfxeGrY9yjX4R/58aq8WSZ1QJm8qVcuwWr98BvdzMEIVq15/XWMGAE4v+izveicl0yX8
	9MBIXU1wX8P9FXRkfplgn2oa6pooNiYSVgcMukQU1HgtqE2kKEhdJ5MbKR9sCHQVShRix5hjQIX
	6riqZGPSMGjg0zlqQnw51FaqXHHBl0sk4KflrRp9di9vB7nygYZkMjScB1N7246NNp+JSMN5N6B
	+kKPmCdkBZvIl9lFVUXLDO3wivfcQZdVcnYOpkKn6Y8fk7Niz2x+vpzKjwI/2Ob8C5ntNbh1v5X
	SB8a3tyVrL6G+BsodIYRDyPFX5
X-Received: by 2002:a05:600c:5296:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-4871605a92dmr127515925e9.19.1774549102444;
        Thu, 26 Mar 2026 11:18:22 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-4871605a92dmr127515465e9.19.1774549102000;
        Thu, 26 Mar 2026 11:18:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm58241325e9.0.2026.03.26.11.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:18:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 21/24] KVM: x86/mmu: add support for GMET to NPT page table walks
Date: Thu, 26 Mar 2026 19:17:19 +0100
Message-ID: <20260326181723.218115-22-pbonzini@redhat.com>
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

GMET allows page table entries to be created with U=0 in NPT.
However, when GMET=1 U=0 only affects execution, not reads or
writes.  Ignore user faults on non-fetch accesses for NPT GMET.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.h              |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 19 +++++++++++++------
 arch/x86/kvm/svm/nested.c       |  3 ++-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index df46ee605b9b..2a26c8fe3f4b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -369,6 +369,8 @@ union kvm_mmu_page_role {
 		 * cr4_smep is also set for EPT MBEC.  Because it affects
 		 * which pages are considered non-present (bit 10 additionally
 		 * must be zero if MBEC is on) it has to be in the base role.
+		 * It also has to be in the base role for AMD GMET because
+		 * kernel-executable pages need to have U=0 with GMET enabled.
 		 */
 		unsigned cr4_smep:1;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index fa1942b126fb..ddca3e3e4eb2 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -90,7 +90,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 94d7e39a9417..d9eb059d24de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -55,6 +55,7 @@
 #include <asm/io.h>
 #include <asm/set_memory.h>
 #include <asm/spec-ctrl.h>
+#include <asm/svm.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
@@ -5553,7 +5554,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 {
 	unsigned byte;
 
@@ -5614,7 +5615,12 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+			/*
+			 * For NPT GMET, U=0 does not affect reads and writes.  Fetches
+			 * are handled below via cr4_smep.
+			 */
+			if (!(tdp && cr4_smep))
+				uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
 
 			if (efer_nx)
 				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
@@ -5725,7 +5731,7 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, false);
+	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
 	update_pkru_bitmask(mmu);
 }
 
@@ -5921,7 +5927,8 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
@@ -5934,7 +5941,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
-	cpu_role.base.cr4_smep = false;
+	cpu_role.base.cr4_smep = (nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) != 0;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
@@ -5992,7 +5999,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true);
+		update_permission_bitmask(context, true, true);
 		context->pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b36c33255bed..99edcca7ee64 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -95,7 +95,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 */
 	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
-				svm->nested.ctl.nested_cr3);
+				svm->nested.ctl.nested_cr3,
+				svm->nested.ctl.nested_ctl);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
-- 
2.53.0

