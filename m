Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54963CF046
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010779; cv=none; b=rPeqCe8Tguo8S9RvIz4RzuPtkHRnWII1taL4sS/ZmwIrwrASxGy4UlkADHHKvGJcmZ7LVTplM7INUrpn/4EHB65NB1UPnnqmqE5xHOGvY8CSjVsHSaJjwPY4KpcVYllpz/xCBpgOa99ZJqD347HUQqWHBqeUoP9v/hqIYYcTrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010779; c=relaxed/simple;
	bh=R2IXZ10vRme19c+Gk4ccRI6jVQXDt3gPieeiCBImRik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/tQe/N2u/3aDs/XVblsVaeN64k8ZwzfUAVN387Z/SNySlkD0x1FsOJk4WKR6mHHjQGLP5eNf1qMMPvdMV97TS8wAHcy0J3LIvdf2xEhqBcoB2LvzzWIR/jycnlm6rJTIwhx594yHf0T2ASvJOFXFwVVreKavdf0JPVWmhyaVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bf8tC4ok; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSo/3qpd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf8tC4ok";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSo/3qpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1eg0oRZL9p2dzmvyJdmoHA1p2W7/BHTuZQBuaEk5HA=;
	b=bf8tC4okWibu9pRtsoQfJSFA6mFSOXos0CmW3wziwjkvvaH6bAQ8NxgQfGqhLHG4cmoyP8
	5tlpjvlj1zDrHynKe7VdehuYB/HKGYnKCfp7tW+pJgu0IfCwSF7FPGUDFv2x6syW4v1/uv
	tfBnG80SWFZF8YsZM7sa3Nw3U+2sObg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-4DHIP3WSOwqGoEGKsfz8Mg-1; Tue, 05 May 2026 15:52:54 -0400
X-MC-Unique: 4DHIP3WSOwqGoEGKsfz8Mg-1
X-Mimecast-MFC-AGG-ID: 4DHIP3WSOwqGoEGKsfz8Mg_1778010773
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488e097a270so33088535e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010772; x=1778615572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1eg0oRZL9p2dzmvyJdmoHA1p2W7/BHTuZQBuaEk5HA=;
        b=cSo/3qpd/AIocWQez8l26UO1HRpSZEEL+q2RDwk7XfYzLknebefjK3Mt9VCeJcoM5e
         AdrtQItWYqGg1llqhxWr4+r4ZXwlPEUv0Ho1Yfy21QgNy5fLNgmQbmReyzqa0Amb2ByU
         CrdhxWy8M9NnNRgWSS7DiJKucKVi+fz7KirJRJTnTOKbH+0pXEFcOvTfkQxW9dKaM7G8
         wUMNXZ08dOEfJ/mgbfFHMOPZupRMfgR+b1rltYAi6M7dEQBFMh0MAVf3A4Lsi8KZSycZ
         sSkPuANsZ9j9pkxw0/Gk339RoJ5TnUGSA9oYhC3VunFBs/dKuR2ihTuVDZxgHcMGLrMW
         heLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010772; x=1778615572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1eg0oRZL9p2dzmvyJdmoHA1p2W7/BHTuZQBuaEk5HA=;
        b=d0BY6fV3Y71wGaTGXwpcmwNHouHGNS4d1ydAHvU0T21YvzrrIEqUR67f1tsGwjCIW8
         HONh5gq4517PI42wBC6DFjUVsnBL/TBuzraQE3Ea1r99iMqiNLpPvTjsXYksm9Y/z02I
         Qx66Zxfb4OqoW03QdSITMkZDanfEYLdvQpQuq1WABXdG+os4pZTXfAZip+mVfZVtULIC
         gAZ32lQWUO26UwiKDwhGvvKUAezIne428/+oV/+0TRX8xOddfStg0u1r8iDi7vXJJtzk
         A9yz4Lyc7ifwrxzRx36XgOezN3hzXw4MOl6fGZVycxPgr3SE3OrFvLMTg50JYC0BN4b8
         RULg==
X-Forwarded-Encrypted: i=1; AFNElJ+rriqA3OR3IFnJDl6otQ/+mWC2+orbZb1rm4koXNaVfiAiCd4/ek64LRm61oUQDQuitK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvccyRd7X3M6DNdiSGZLeJCy0RQn44KCnC9bX/oIFrR7PXJeSK
	jpkGx/C+OzZhimpHGyyhAdR7GxmOCB8oeJXU+FWpwuMmxASSgHnuEHFwOv+uHTIIqsZ8a+ue8Gy
	DlwUM9ktNl2rYqIAhDmOCi1vtTibehpKYwJyPt5B1WopsBitprsotNfersrvZpA==
X-Gm-Gg: AeBDietCvoKtd0tTe8n33Ae5pWs8IpOQ4DFiNeR1iLD9s18T5TZtNdK6yOx2FyhWk2s
	kVKMfsGoAPXphNwks0u9+fTpxuBSO+GE/+RQOxCN+DO2oM4WavWdPveVgs1Kear45Nfb6/xWjOV
	jcln+o2hqBrtpJoRQNUNhxVMCTr9vhKb1jWlia1WZ17oHvQgMfN4Md7cXSaTmfaOVrsR4fhx495
	ukrgaQRI1mcQBpSkGmFmrBLSAbG18G7fonRtuqxQJkwYdbCKBnu1mcOBwoOKn7Hs1tCwWeFtK/x
	GRbQCbcBFngwyM/fXT+h7dkIWDcHmYL4Yp9W39HnsSTXvBx4rVEOmnQOnkYfbfYQGPbJWk7J267
	+8QFrUi0H/zR1vp9oscLGPrt7DixpJBTPRazanzFCiSNUybpcg2NdYJUBJQOkYo+ojUfplG9AY3
	OVdg056LGzkqdJPQ173UK5s6ZgXrSrY27AxjJjb+M=
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48e51e21378mr12454045e9.12.1778010771984;
        Tue, 05 May 2026 12:52:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48e51e21378mr12453485e9.12.1778010771457;
        Tue, 05 May 2026 12:52:51 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e51f5a8c5sm4220615e9.1.2026.05.05.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 09/28] KVM: x86/mmu: introduce ACC_READ_MASK
Date: Tue,  5 May 2026 21:52:07 +0200
Message-ID: <20260505195226.563317-10-pbonzini@redhat.com>
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

Read permissions so far were only needed for EPT, which does not need
ACC_USER_MASK.  Therefore, for EPT page tables ACC_USER_MASK was repurposed
as a read permission bit.

In order to implement nested MBEC, EPT will genuinely have four kinds of
accesses, and there will be no room for such hacks; bite the bullet at
last, enlarging ACC_ALL to four bits and permissions[] to 2^4 bits (u16).

The new code does not enforce that the XWR bits on non-execonly processors
have their R bit set, even when running nested: none of the shadow_*_mask
values have bit 0 set, and make_spte() genuinely relies on ACC_READ_MASK
being requested!  This works because, if execonly is not supported by the
processor, shadow EPT will generate an EPT misconfig vmexit if the XWR
bits represent a non-readable page, and therefore the pte_access argument
to make_spte() will also always have ACC_READ_MASK set.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ++++-----
 arch/x86/kvm/mmu.h              |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 45 ++++++++++++++++++++-------------
 arch/x86/kvm/mmu/mmutrace.h     |  3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h  | 35 +++++++++++++++----------
 arch/x86/kvm/mmu/spte.c         | 18 +++++--------
 arch/x86/kvm/mmu/spte.h         |  5 ++--
 arch/x86/kvm/vmx/capabilities.h |  5 ----
 arch/x86/kvm/vmx/common.h       |  5 +---
 arch/x86/kvm/vmx/vmx.c          |  3 +--
 10 files changed, 69 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..8f2a1b915df9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -328,11 +328,11 @@ struct kvm_kernel_irq_routing_entry;
  * the number of unique SPs that can theoretically be created is 2^n, where n
  * is the number of bits that are used to compute the role.
  *
- * But, even though there are 20 bits in the mask below, not all combinations
+ * But, even though there are 21 bits in the mask below, not all combinations
  * of modes and flags are possible:
  *
  *   - invalid shadow pages are not accounted, mirror pages are not shadowed,
- *     so the bits are effectively 18.
+ *     so the bits are effectively 19.
  *
  *   - quadrant will only be used if has_4_byte_gpte=1 (non-PAE paging);
  *     execonly and ad_disabled are only used for nested EPT which has
@@ -347,7 +347,7 @@ struct kvm_kernel_irq_routing_entry;
  *     cr0_wp=0, therefore these three bits only give rise to 5 possibilities.
  *
  * Therefore, the maximum number of possible upper-level shadow pages for a
- * single gfn is a bit less than 2^13.
+ * single gfn is a bit less than 2^14.
  */
 union kvm_mmu_page_role {
 	u32 word;
@@ -356,7 +356,7 @@ union kvm_mmu_page_role {
 		unsigned has_4_byte_gpte:1;
 		unsigned quadrant:2;
 		unsigned direct:1;
-		unsigned access:3;
+		unsigned access:4;
 		unsigned invalid:1;
 		unsigned efer_nx:1;
 		unsigned cr0_wp:1;
@@ -366,7 +366,7 @@ union kvm_mmu_page_role {
 		unsigned guest_mode:1;
 		unsigned passthrough:1;
 		unsigned is_mirror:1;
-		unsigned :4;
+		unsigned:3;
 
 		/*
 		 * This is left at the top of the word so that
@@ -492,7 +492,7 @@ struct kvm_mmu {
 	 * Byte index: page fault error code [4:1]
 	 * Bit index: pte permissions in ACC_* format
 	 */
-	u8 permissions[16];
+	u16 permissions[16];
 
 	u64 *pae_root;
 	u64 *pml4_root;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 830f46145692..23f37535c0ce 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -81,7 +81,7 @@ u8 kvm_mmu_get_max_tdp_level(void);
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value);
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
-void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only);
+void kvm_mmu_set_ept_masks(bool has_ad_bits);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fc34536c536b..fa6a5e4ee09a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2033,7 +2033,7 @@ static bool kvm_sync_page_check(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	 */
 	const union kvm_mmu_page_role sync_role_ign = {
 		.level = 0xf,
-		.access = 0x7,
+		.access = ACC_ALL,
 		.quadrant = 0x3,
 		.passthrough = 0x1,
 	};
@@ -5539,7 +5539,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
  * update_permission_bitmask() builds what is effectively a
  * two-dimensional array of bools.  The second dimension is
  * provided by individual bits of permissions[pfec >> 1], and
- * logical &, | and ~ operations operate on all the 8 possible
+ * logical &, | and ~ operations operate on all the 16 possible
  * combinations of ACC_* bits.
  */
 #define ACC_BITS_MASK(access) \
@@ -5549,15 +5549,23 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (4 & (access) ? 1 << 4 : 0) | \
 	 (5 & (access) ? 1 << 5 : 0) | \
 	 (6 & (access) ? 1 << 6 : 0) | \
-	 (7 & (access) ? 1 << 7 : 0))
+	 (7 & (access) ? 1 << 7 : 0) | \
+	 (8 & (access) ? 1 << 8 : 0) | \
+	 (9 & (access) ? 1 << 9 : 0) | \
+	 (10 & (access) ? 1 << 10 : 0) | \
+	 (11 & (access) ? 1 << 11 : 0) | \
+	 (12 & (access) ? 1 << 12 : 0) | \
+	 (13 & (access) ? 1 << 13 : 0) | \
+	 (14 & (access) ? 1 << 14 : 0) | \
+	 (15 & (access) ? 1 << 15 : 0))
 
 static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
 	unsigned index;
 
-	const u8 x = ACC_BITS_MASK(ACC_EXEC_MASK);
-	const u8 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u8 u = ACC_BITS_MASK(ACC_USER_MASK);
+	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
+	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
+	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
 	bool cr4_smap = is_cr4_smap(mmu);
@@ -5580,32 +5588,33 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		unsigned pfec = index << 1;
 
 		/*
-		 * Each "*f" variable has a 1 bit for each UWX value
+		 * Each "*f" variable has a 1 bit for each ACC_* combo
 		 * that causes a fault with the given PFEC.
 		 */
 
 		/* Faults from reads to non-readable pages */
-		u8 rf = 0;
+		u16 rf = (pfec & (PFERR_WRITE_MASK|PFERR_FETCH_MASK)) ? 0 : (u16)~r;
 		/* Faults from writes to non-writable pages */
-		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
+		u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = 0;
+		u16 uf = 0;
 		/* Faults from fetches of non-executable pages */
-		u8 ff = 0;
+		u16 ff = 0;
 		/* Faults from kernel mode accesses of user pages */
-		u8 smapf = 0;
+		u16 smapf = 0;
 
 		if (ept) {
-			rf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
-			ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
+			ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 		} else {
-			/* Faults from kernel mode accesses to user pages */
-			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
+			const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
 
-			uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+			/* Faults from kernel mode accesses to user pages */
+			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
+
+			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
 
 			if (efer_nx)
-				ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
+				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 
 			/* Allow supervisor writes if !cr0.wp */
 			if (!cr0_wp)
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 764e3015d021..dcfdfedfc4e9 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -25,7 +25,8 @@
 #define KVM_MMU_PAGE_PRINTK() ({				        \
 	const char *saved_ptr = trace_seq_buffer_ptr(p);		\
 	static const char *access_str[] = {			        \
-		"---", "--x", "w--", "w-x", "-u-", "-ux", "wu-", "wux"  \
+		"----", "r---", "-w--", "rw--", "--u-", "r-u-", "-wu-", "rwu-", \
+		"---x", "r--x", "-w-x", "rw-x", "--ux", "r-ux", "-wux", "rwux"	\
 	};							        \
 	union kvm_mmu_page_role role;				        \
 								        \
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 901cd2bd40b8..fb1b5d8b23e5 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -170,25 +170,24 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 	return true;
 }
 
-/*
- * For PTTYPE_EPT, a page table can be executable but not readable
- * on supported processors. Therefore, set_spte does not automatically
- * set bit 0 if execute only is supported. Here, we repurpose ACC_USER_MASK
- * to signify readability since it isn't used in the EPT case
- */
 static inline unsigned FNAME(gpte_access)(u64 gpte)
 {
 	unsigned access;
 #if PTTYPE == PTTYPE_EPT
 	access = ((gpte & VMX_EPT_WRITABLE_MASK) ? ACC_WRITE_MASK : 0) |
 		((gpte & VMX_EPT_EXECUTABLE_MASK) ? ACC_EXEC_MASK : 0) |
-		((gpte & VMX_EPT_READABLE_MASK) ? ACC_USER_MASK : 0);
+		((gpte & VMX_EPT_READABLE_MASK) ? ACC_READ_MASK : 0);
 #else
-	BUILD_BUG_ON(ACC_EXEC_MASK != PT_PRESENT_MASK);
-	BUILD_BUG_ON(ACC_EXEC_MASK != 1);
+	/*
+	 * P is set here, so the page is always readable and W/U/!NX represent
+	 * allowed accesses.
+	 */
+	BUILD_BUG_ON(ACC_READ_MASK != PT_PRESENT_MASK);
+	BUILD_BUG_ON(ACC_WRITE_MASK != PT_WRITABLE_MASK);
+	BUILD_BUG_ON(ACC_USER_MASK != PT_USER_MASK);
+	BUILD_BUG_ON(ACC_EXEC_MASK & (PT_WRITABLE_MASK | PT_USER_MASK | PT_PRESENT_MASK));
 	access = gpte & (PT_WRITABLE_MASK | PT_USER_MASK | PT_PRESENT_MASK);
-	/* Combine NX with P (which is set here) to get ACC_EXEC_MASK.  */
-	access ^= (gpte >> PT64_NX_SHIFT);
+	access |= gpte & PT64_NX_MASK ? 0 : ACC_EXEC_MASK;
 #endif
 
 	return access;
@@ -501,10 +500,18 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		if (write_fault)
 			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_WRITE;
-		if (user_fault)
-			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
-		if (fetch_fault)
+		else if (fetch_fault)
 			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
+		else
+			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
+
+		/*
+		 * Accesses to guest paging structures are either "reads" or
+		 * "read+write" accesses, so consider them the latter if write_fault
+		 * is true.
+		 */
+		if (access & PFERR_GUEST_PAGE_MASK)
+			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
 
 		/*
 		 * Note, pte_access holds the raw RWX bits from the EPTE, not
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 849a1c1c92b5..1b7fb508098b 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -194,12 +194,6 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	int is_host_mmio = -1;
 	bool wrprot = false;
 
-	/*
-	 * For the EPT case, shadow_present_mask has no RWX bits set if
-	 * exec-only page table entries are supported.  In that case,
-	 * ACC_USER_MASK and shadow_user_mask are used to represent
-	 * read access.  See FNAME(gpte_access) in paging_tmpl.h.
-	 */
 	WARN_ON_ONCE((pte_access | shadow_present_mask) == SHADOW_NONPRESENT_VALUE);
 
 	if (sp->role.ad_disabled)
@@ -228,6 +222,9 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 		pte_access &= ~ACC_EXEC_MASK;
 	}
 
+	if (pte_access & ACC_READ_MASK)
+		spte |= PT_PRESENT_MASK; /* or VMX_EPT_READABLE_MASK */
+
 	if (pte_access & ACC_EXEC_MASK)
 		spte |= shadow_x_mask;
 	else
@@ -391,6 +388,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 	u64 spte = SPTE_MMU_PRESENT_MASK;
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
+		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
 		shadow_user_mask | shadow_x_mask | shadow_me_value;
 
 	if (ad_disabled)
@@ -491,18 +489,16 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_set_me_spte_mask);
 
-void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
+void kvm_mmu_set_ept_masks(bool has_ad_bits)
 {
 	kvm_ad_enabled		= has_ad_bits;
 
-	shadow_user_mask	= VMX_EPT_READABLE_MASK;
+	shadow_user_mask	= 0;
 	shadow_accessed_mask	= VMX_EPT_ACCESS_BIT;
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
-	/* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
-	shadow_present_mask	=
-		(has_exec_only ? 0ull : VMX_EPT_READABLE_MASK) | VMX_EPT_SUPPRESS_VE_BIT;
+	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
 	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
 	shadow_host_writable_mask = EPT_SPTE_HOST_WRITABLE;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index bc02a2e89a31..121bfb2217e8 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -52,10 +52,11 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
 #define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-1))
 #endif
 
-#define ACC_EXEC_MASK    1
+#define ACC_READ_MASK    PT_PRESENT_MASK
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
 #define ACC_USER_MASK    PT_USER_MASK
-#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
+#define ACC_EXEC_MASK    8
+#define ACC_ALL          (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK | ACC_READ_MASK)
 
 #define SPTE_LEVEL_BITS			9
 #define SPTE_LEVEL_SHIFT(level)		__PT_LEVEL_SHIFT(level, SPTE_LEVEL_BITS)
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 56cacc06225e..7e59eb0f41bb 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -300,11 +300,6 @@ static inline bool cpu_has_vmx_flexpriority(void)
 		cpu_has_vmx_virtualize_apic_accesses();
 }
 
-static inline bool cpu_has_vmx_ept_execute_only(void)
-{
-	return vmx_capability.ept & VMX_EPT_EXECUTE_ONLY_BIT;
-}
-
 static inline bool cpu_has_vmx_ept_4levels(void)
 {
 	return vmx_capability.ept & VMX_EPT_PAGE_WALK_4_BIT;
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index adf925500b9e..1afbf272efae 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -85,11 +85,8 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 {
 	u64 error_code;
 
-	/* Is it a read fault? */
-	error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
-		     ? PFERR_USER_MASK : 0;
 	/* Is it a write fault? */
-	error_code |= (exit_qualification & EPT_VIOLATION_ACC_WRITE)
+	error_code = (exit_qualification & EPT_VIOLATION_ACC_WRITE)
 		      ? PFERR_WRITE_MASK : 0;
 	/* Is it a fetch fault? */
 	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..337bbfecc021 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8683,8 +8683,7 @@ __init int vmx_hardware_setup(void)
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
-		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
-				      cpu_has_vmx_ept_execute_only());
+		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
 	else
 		vt_x86_ops.get_mt_mask = NULL;
 
-- 
2.54.0

