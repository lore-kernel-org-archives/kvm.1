Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238A3DC4C4
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010800; cv=none; b=aetJzAY6IjJvTfNaJ5QtWXDvEqPt92e4a32wUE+fxAlZoWill42jdifvLQvMl5LBZ9+AP2vXW7ADU2PqdE639tI7S5pbjaBU9R2CKud3CE4dTthkU9xStc8RMmg82Br1Ac40gLEQYo1IdhWAOo29K6BzMe7OVFOL2BfEfV8jeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010800; c=relaxed/simple;
	bh=rJPm4NDp94NZY1zF9AK5L99+BIR3MJVYPY4F2Kp0UjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyBwG0vh8E4LlnpgohiGAC5TP+qVj7oP4i3RIAnobXggbjJ/C9Rwdua0hFZVujW+ZYxjAjWkOkQchsL6jlNBNz7APVuIm6Mx3lgAmoWl8PAwOmpJxQ8eLZv+Ss/kj6sRvZ2X7MJgHTV7hgRsdSnHH/kFBm/pEsFa3qdZdQSZAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBttpY4g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9J6peSO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBttpY4g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9J6peSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lpUbzxtZJ85/hSmuxpEMRZGP9r8CuT9MGtmtr8hkk1w=;
	b=MBttpY4g661d54ssaUhRCtAr4++RB5HgXorkGtmxZTjnvV0EYfEjkg5Bi7iuMVUDHvEy78
	rjX+fMJY0NNaBpmCp4zuZmt+AREK/+Jia+zJY5iOYrH265TfTPbql96tsMnTQfNOegLuRN
	EBR0v3mCpqNdkuZP8u2ZXq58Xy0vAiM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-kgoS8E5jMbKGRiGgFtAouQ-1; Tue, 05 May 2026 15:53:15 -0400
X-MC-Unique: kgoS8E5jMbKGRiGgFtAouQ-1
X-Mimecast-MFC-AGG-ID: kgoS8E5jMbKGRiGgFtAouQ_1778010794
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso45226375e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010793; x=1778615593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpUbzxtZJ85/hSmuxpEMRZGP9r8CuT9MGtmtr8hkk1w=;
        b=h9J6peSOQUP9K63cud8rhB5FvkDoRm52C4BHJ1FXVTf5SnDVK4etcH2/jX/WPnMwhf
         j4AeulcojCVz1IESrrt/Nd9ckEpjdDq1Rwjpoc0Wvzh6O71IT+4l0dUvC4FJ1dEBfL5N
         +qtR5zgumQb9aRx/fvRNj+2D6nM3XG29AnqKaN1YMHBNR9tS/v6r6dLhkAq4AIO7DCaZ
         tG5aR0Z1sWA2lCMMpBRwSzayndyATs5pKZTjm6Ffd/SBwxvbrqQpqRd05IgwOTPvOq3C
         +y6KIVaaQ7/phRl4791R2lYtWcI7LlA1j2KeW0Gpbpkicam4ncnLLaufDLe5DkYRDDnS
         ip+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010793; x=1778615593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lpUbzxtZJ85/hSmuxpEMRZGP9r8CuT9MGtmtr8hkk1w=;
        b=d8iSUsdHQqSPTYQtGldUMZeTXv23rZDw4TUE8FIBMBPx1Gc7KWRVvxuRqex4rJKsAI
         ezYeggzjxUSN6pe2HU4tzcCjANPcHczjY8YpLHYnFe8huROtRiXThUzaOhyetpQb9OEO
         IbLiOUbmby/ol4FgwjslG3ClU0WNE2AY7BCLFNrtQO2B1uBVHReL5x/0ahKXbl0cN7Ly
         JzkOjDl3UGrKIAMGuAUbk4gZ6hJxKuSQg/kKmSgWPF1DIxioQn/wHA1IB9Cxdn7w0d9T
         vSn/3UqKin7gzlWkSMTdRs5SdDfbd6WDc/QJAGRN2Sof8eBSdLfUID4GDZDD3vg5AIn4
         Z02Q==
X-Forwarded-Encrypted: i=1; AFNElJ9dXaT8jcjBNGkB6GW45QWB1n10w4W9Md1m+U08zs6nEcGQPbJnhIJqQf/Gc1CEcqj5FEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymfaYAzhSPgzk8tDQ0qT4r9sHRvkI9O4gJbsdXCk1irnLyq+f3
	anHMPlv6xKsbXiSiOhF7P73O/avG69ZqaOpRcxsyNI2tU/G6zcoUXQdi0V+mZ44Qfqd6/Hc3ruk
	1w5AFaVKI1+T/qa2Ohv1Ge7OYKwjUYUJr5+ScBsUBdDgekjMecuPKzrKQP6qlRA==
X-Gm-Gg: AeBDiesMsqASRKWdK646Ojp6G5CKNGesqwfkL1pmBeIYfQUd8ukRRtlsA3T7pOZ88OR
	yVmSe0LF4G2XmXD8OVK9kxBQg5IfYE2RCYNg5lOYV1OOiQ7+di0oAOFlM9NmXLtRi/IPA4n1OBQ
	Bmma+1EoXqeI/g8j2a4+4xV2/tZqbVT9vqsqlqIruHcwxl+rKAp+0XC/hv97aah6yCmE+2Gx/2J
	S+/0oMyDEi0LWG2UN56pquK3vYEN8OLsZ8OCavFkE7ZDWB3pbGLmVQa8ZVTgD/E6Toqn6+v2oWV
	o7EvX9GtoQQPqVmVzNVdDisTQTNM1VCzaIwQG1pJTJq4nIwrMiiEyfRoWQvGrdcfN0FNuycu6WZ
	fGAelCLiciW9HZr1P27zmS8gMwuhUBz6pHD6/tGJUY4LMVpA5CY05icsaAL298YSQuvXPwH4c1x
	FVuFFTc7TTe7F9E+FbTYilcJQ+1oLL3/PyjEBdLBQ=
X-Received: by 2002:a05:600d:10:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48e51f36fc6mr9034905e9.21.1778010792937;
        Tue, 05 May 2026 12:53:12 -0700 (PDT)
X-Received: by 2002:a05:600d:10:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48e51f36fc6mr9034565e9.21.1778010792515;
        Tue, 05 May 2026 12:53:12 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm397632315e9.3.2026.05.05.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 18/28] KVM: x86/mmu: add support for MBEC to EPT page table walks
Date: Tue,  5 May 2026 21:52:16 +0200
Message-ID: <20260505195226.563317-19-pbonzini@redhat.com>
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
index 156050e22329..a5b68f18b220 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5570,7 +5570,6 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned index;
 
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
2.54.0

