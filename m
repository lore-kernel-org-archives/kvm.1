Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06C3CCFA8
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010783; cv=none; b=tbugHePJm9IK/5CNre0JxAO1SDkFID4i+C0e4zSDo6x1jzNivBfuJaSqhkJPMUen+eZqPn5O6EpOfWzbZ0zm9vshvArGiOT//hzOR3dTs5BbYGJbIdkeFOMe/tojVs0NSquIkRaue3xrqwOqOeDIu00YfNhj2Dg9y7brpGVrQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010783; c=relaxed/simple;
	bh=2U/3jefBJ7l9O2M5+c2UmKDUFVhFYy7ZCfqlYg7Tm+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwS23+qAVAMHoGEMey2jBLwOmoAuWv8mOfj9zPMci77B4qf3XtHRfAkc7HL6K6w5+NoENKol9vRKiCNS1p/UO+v7D+IBwvDLTOyZRbn2LIx+sR/3ooPVXR7zBYnUogh2DgqbueSEzHvjT4QgmEKBRYlzYEytT0bAN1e+FdWzRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBA4cTUt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6IS3dEm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBA4cTUt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6IS3dEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUdoCfMIvzOtOBmQ5/8GVTfaJ3h1aQni9LagJneRo0w=;
	b=QBA4cTUtcNcZ3+Z8xC+c+yqtn9cqIbK9NEZlUAixD4K/LRwkoCadFpZNjIvyfsUCILwF2c
	4JGrEoNiaxu8YJvmuEL6bgNI6Ah355VeMWevpKBMOl6Q3usW1YJJzlEbJvyEf1Kk+5CEI9
	wvEVuW3NNNR/PF+raakuY4Er7RfKOho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-JYTQoV9aMr-PBRws8kCfMw-1; Tue, 05 May 2026 15:52:57 -0400
X-MC-Unique: JYTQoV9aMr-PBRws8kCfMw-1
X-Mimecast-MFC-AGG-ID: JYTQoV9aMr-PBRws8kCfMw_1778010777
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a71109b94so3542170f8f.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010776; x=1778615576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUdoCfMIvzOtOBmQ5/8GVTfaJ3h1aQni9LagJneRo0w=;
        b=J6IS3dEmg558wrFgQvCow10/bR7VBnPjlIJfFTfOJ7POUpcQ3H0STzRzhfVzAUbetw
         v2zslx/OUShS6RPtH6as4gjFGhcXJ4acopFLFIQpQeG9ChWt5nNU4Jr2OpCLsIorm88h
         3bPhwYSvkgvdQlhKN+xGrditO2zt+cD6Nx4nHDusVT2UeuwW/7NTi+H3uru3HBdeeZ8/
         0u8eWs2lsnWRVdvuvOKrovpAgjJjdSGMYHDwFdtVZJBV1LHaj4/EPsqpeQJaB9WpWD5n
         tvst1CV63XxhsJGwwD+mUIPyfQmVmSO8eottJ6wDuE5/+y6Dm5CHCeDei3ljGdqrzNao
         eGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010776; x=1778615576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUdoCfMIvzOtOBmQ5/8GVTfaJ3h1aQni9LagJneRo0w=;
        b=jd+mGr4m8VHHyTUZKg5k7YJQEcmv8JM9X5lHb4H+zqEMNggxrHkeP+TbZcXkdYB3e1
         G0qzTr3Dw7yGH62eKDUAUXQvvjkbD+a5PGMlAMosYBTS1HGz9e8l19moZI0ck5uiwJmz
         Xd8vSUUclqv7nzU0dGYh2n7mwSi1mgh3wN/scREdTsZUBYWfQodLVu1TqulpByHEgj4W
         JjhhLTqJapJuKHIqIGWakGSaxigulTmJEVoYTYo5mugEBNLmt7liV4azUtHHhEB/bY+P
         isou2gadY4SJVwAWkUj0pkriqIqMGstyHGot/naaFu23npZF2EKbIn3SUsVhd7ck/Fsn
         wiQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/34ufrXrheazJJtP0Qawp6dTS8JuiRKlN+xSNcl6J0+A+cyvL7oxYM9pL8+uS95GoSdnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiFwhrF1jBMN+o9usZiM6Pb4AowctRU/2uuOGn+JK+kFrjTVG
	MtWRndnKWWsUM3b9bntn53D23lTmWb9aaE4/7/0Q5am/DKn/jJYNGLGYcVeV3r/BIBNbCT1axd3
	BmDCy1eiOYB2Z0bnBYDjGc+1fzpniW6pr9CedPodXqv1EmIivvsNznJMPmBXb6w==
X-Gm-Gg: AeBDievvaaW/TrrVftynT+fKHi04D/r1EF6RZaRV/ZJw9JDfc5Pve4e5toqJ+taAKgR
	x/Db1lSHkZUWB1g+LtWi0w71QD/JrZO+OLZHPlP9zVMlHXbrnADjQjfEofPBodevF6rlPeFJ5v+
	9z2+IUEb08sxSOEj9ISlRJuVsrUV649oh/30je6dEE9Hfyttv317KhrLe+W9Bd+50fxMQ/frEqt
	J4r21L69hYeZBih5fbTCuZM4Gv2hR71KbfvUw8aQZgpNwHA9zGmvS7rGda4TZBBBb5zOpeJtYLZ
	WXNZsbgt0do87BllUDRCuK65Y8mmHNkL7EpuPJrG0HSTXUFzjU3O2puA/jgxyc7I1AGF41Ueaml
	vQoKezxPQVYZGoqNuGLEJMq2afCMXEN1G0c5p3HnGoTD5Hlt1LrcYm6obvLro/wG+UAwOOjuLZ4
	LgpxR2h+jTlpgPD0f2zxvi1YimWJzvVp2PeJ5QweY=
X-Received: by 2002:a05:6000:22c6:b0:44b:df83:473e with SMTP id ffacd0b85a97d-4515b056d0bmr922860f8f.3.1778010776000;
        Tue, 05 May 2026 12:52:56 -0700 (PDT)
X-Received: by 2002:a05:6000:22c6:b0:44b:df83:473e with SMTP id ffacd0b85a97d-4515b056d0bmr922826f8f.3.1778010775568;
        Tue, 05 May 2026 12:52:55 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48911sm6878298f8f.11.2026.05.05.12.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 11/28] KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
Date: Tue,  5 May 2026 21:52:09 +0200
Message-ID: <20260505195226.563317-12-pbonzini@redhat.com>
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

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  This is available in the page walker
as pte_access & ACC_USER_MASK but not available to translate_nested_gpa,
so pass it down.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c          |  2 +-
 arch/x86/kvm/mmu.h             | 15 ++++++++++++---
 arch/x86/kvm/mmu/mmu.c         |  8 +++++++-
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 arch/x86/kvm/mmu/spte.h        |  6 ------
 arch/x86/kvm/x86.c             |  5 +++--
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cf9dd565b894..53688f7b76eb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2042,7 +2042,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	if (!hc->fast && is_guest_mode(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
-					PFERR_GUEST_FINAL_MASK, NULL);
+					PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 23f37535c0ce..635c2e5d8513 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -37,6 +37,12 @@ extern bool __read_mostly enable_mmio_caching;
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3
 
+#define ACC_READ_MASK    PT_PRESENT_MASK
+#define ACC_WRITE_MASK   PT_WRITABLE_MASK
+#define ACC_USER_MASK    PT_USER_MASK
+#define ACC_EXEC_MASK    8
+#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
+
 #define KVM_MMU_CR4_ROLE_BITS (X86_CR4_PSE | X86_CR4_PAE | X86_CR4_LA57 | \
 			       X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_PKE)
 
@@ -289,16 +295,19 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception);
+			   struct x86_exception *exception,
+			   u64 pte_access);
 
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct kvm_mmu *mmu,
 				      gpa_t gpa, u64 access,
-				      struct x86_exception *exception)
+				      struct x86_exception *exception,
+				      u64 pte_access)
 {
 	if (mmu != &vcpu->arch.nested_mmu)
 		return gpa;
-	return translate_nested_gpa(vcpu, gpa, access, exception);
+	return translate_nested_gpa(vcpu, gpa, access, exception,
+				    pte_access);
 }
 
 static inline bool kvm_has_mirrored_tdp(const struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 46412e4d207f..3dbac7ad044f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4348,8 +4348,14 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	if (exception)
 		exception->error_code = 0;
+	/*
+	 * EPT MBEC uses the effective access bits from the PTE to distinguish
+	 * user and supervisor accesses, and treats every linear address as a
+	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
+	 * the last argument to kvm_translate_gpa (which NPT does not use).
+	 */
 	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
-				 exception);
+				 exception, ACC_ALL);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 567f8b77ffe0..8dd9d510fc34 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -377,7 +377,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
 					     nested_access | PFERR_GUEST_PAGE_MASK,
-					     &walker->fault);
+					     &walker->fault, 0);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -447,7 +447,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
 				     access | PFERR_GUEST_FINAL_MASK,
-				     &walker->fault);
+				     &walker->fault, walker->pte_access);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 121bfb2217e8..8a4c09c5cdbf 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -52,12 +52,6 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define ACC_READ_MASK    PT_PRESENT_MASK
-#define ACC_WRITE_MASK   PT_WRITABLE_MASK
-#define ACC_USER_MASK    PT_USER_MASK
-#define ACC_EXEC_MASK    8
-#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
-
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
 #define SPTE_INDEX(address, level)	__PT_INDEX(address, level, SPTE_LEVEL_BITS)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ef1e3ae13887..67979b7de5d6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1073,7 +1073,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK |
-				     PFERR_GUEST_PAGE_MASK, NULL);
+				     PFERR_GUEST_PAGE_MASK, NULL, 0);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
@@ -7849,7 +7849,8 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 }
 
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u64 access,
-			   struct x86_exception *exception)
+			   struct x86_exception *exception,
+			   u64 pte_access)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	gpa_t t_gpa;
-- 
2.54.0

