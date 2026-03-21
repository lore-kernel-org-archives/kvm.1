Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD862D5A19
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051804; cv=none; b=UDWKwSkaTXGcWCuvVrpacQ81NnQEJu0Ng8eKuTOZbnP+C+/HlEp0FQl7PJQZWyXvsztQjp4oAXLWfhFRxV5FjY02tK2kCO1JA70MP/kulMGcKUZGilcr7OXqKy4tpkxd0H8kO9BNZ6aH/T+hGVJlFePrkM7JShUFcsQz0Zsp/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051804; c=relaxed/simple;
	bh=ONNnmmHHTvZZuq1E66YR5KlEWSW1FH6WWzPZVjXzpp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orcvDXK2+dYW9YE+Z5HWjL0fGwcfT5N2CbHNulDCN9hO9lwaPY/c9ub/l6OFSnD4g8ukeZX0/lpee9gPo9IQp/mv0uvsTt6zka9p50imWl2L3cBeiHYSSW8oo0NUAH9UXXi053vfb5cDV9+miKxA+xdCN1Tf/oEkd7YZzXeSdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEib1lm2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuGOFNDO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEib1lm2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuGOFNDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q59OVnPK7veWu46dmOf9r5Y7uxmYjxSGeRJZVAJUaWA=;
	b=FEib1lm2TpzD0xAAlCvIcsK1z1LwL29rlovWQFUrTroZXTWcSVib1LBJfBy4GFjYAtPZR/
	Ra7JjuuyspUs9qWubD7ALUX8cJYO5gaoTzKJ6yDOMa5uthxKEf4/xPHAAYKskDgDq3N2rq
	+KLR7DwRl4nz1uo9WQBLBgxpj3wbUYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-BvR34noCM_m_kRUm3sM7cQ-1; Fri, 20 Mar 2026 20:09:55 -0400
X-MC-Unique: BvR34noCM_m_kRUm3sM7cQ-1
X-Mimecast-MFC-AGG-ID: BvR34noCM_m_kRUm3sM7cQ_1774051794
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852ccff333so26503725e9.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051794; x=1774656594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q59OVnPK7veWu46dmOf9r5Y7uxmYjxSGeRJZVAJUaWA=;
        b=fuGOFNDOFbZc0cFgy8cutjNUzD9NDnb9+vuI/KhZiN+vB4mw1zLTLmNxOY9jUHb/mD
         Dzld7UBPiUTVaKvEh1VlwG3pWJWFf/ofIT03O7rNmiC0KHpmT6BUjscvZ/iHksIxkttZ
         j0XYaV2jSjZIH8jCNLrhCAhp2oTZ7TAFU1gFdJ4S4kpm5EDysx2MbjwTvlAHjkE8UGKo
         KNm69n/Bdor8Pa2Oi9YmVJjPhG0dVwWtyo/Q2ZEMML79vs+iUd9cxkRoc91hbwxZMbXW
         E4SRqfwDiPMLHxvjgfEAsWG26q7N7klkSHtzuD84Y35SPKspIXwSiJX6pAmLWwGVsW2E
         wqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051794; x=1774656594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q59OVnPK7veWu46dmOf9r5Y7uxmYjxSGeRJZVAJUaWA=;
        b=gC7XNuPTHl3zvuYqnOKk1MEZ7Zt3i41uTy8W5ymqzMvGV6JevqUm1RW9Gx/0ePh0vp
         5mFsDjdJMdijHr7ynhCsBaUTjKxWR85tUqlU6fOimpUajZcgrhQvUkpk8g4i7mLc2cHd
         p3af2dVC4Qy/DIeCukY8goPpVbIYjmy1Okqd6IxhUH6TXr+kyycz8fhudJqCHGmj4wi2
         js4YQ+s7C6ywYE+hT0t6jfAE3/gXLXKhOmtSDIenkUCHZgHbeIiHb2Xl6H6f1Ut50QMf
         qzOhM8KWPGcgBOrr31iXFod/JF+NCuDdxnLH26AHDdSXoq06I5OubFGj6w988YTgqEYE
         Tsrw==
X-Forwarded-Encrypted: i=1; AJvYcCVYZRsgYZsuGeXX6sFepdr0kfvqS8wC0erYldwR28yhTXI25d+q+95/yS2QxwXfMvA/NnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXcJioCYG+/i6YTrFfvGTxjY5qhVKaAxLdEG/uP/SWLDcG8Pr
	PYG+X5rUNl4iHGzzySwdKMDFPUeGTcqnHu377F8UETg+M9anEUNstVc6QZNiEpVCOVzzkJWzw1P
	dlWUN3eQO9KjumNA2PacGjjUuL2FFypgymiIm/eBd+k+hGrprRzZwhQ==
X-Gm-Gg: ATEYQzxY/PhRKY376MWM0FvIsk7tbpzaJEsZgd3PIb1Uz2tCoCsJ3p0MpKI7MJpP4oq
	u1kgt7tPFsFZiYJjkmbkLOv67QWnH+s42QwBHUfS43jSdvf9XOySmkDvSufxQVVHZB8cU2wA6Jv
	NLiy1l7QQPzM3yqGfcN53/NHR8m2mNjvbiSma5P+aTnBHcsoqhrt89EPt5GdwxKWI842qIq3eD1
	sxTWe7gW5fkIMVknDxDVHGZVZFp///qqCjVw4wCtfHTZtzhCRqhJSIANCR3qaek+S1FiPZE1BaT
	Pe8dFJR4twcXm2qyyJ+tmI7EnnMuvux5Xvtyu8dB56g/pmyaPL+c55K2wKaXwXKF+O8VlZTYLlw
	nnpJpvH/WIbUZh0kAfJ86K0tERyLs5ZjpNxzgsRhhGIBCaZpVPlyyg2XpLjp2/VdAbNQGQSorUy
	/LgszS4Tws3A+uaaGCDLXRPPnF
X-Received: by 2002:a05:600c:3546:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-486fee28918mr67987785e9.26.1774051793909;
        Fri, 20 Mar 2026 17:09:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-486fee28918mr67987465e9.26.1774051793419;
        Fri, 20 Mar 2026 17:09:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm112298305e9.2.2026.03.20.17.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 08/22] KVM: x86/mmu: introduce ACC_READ_MASK
Date: Sat, 21 Mar 2026 01:09:17 +0100
Message-ID: <20260321000931.1947084-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
being requested!  This works becase, if execonly is not supported by the
processor, shadow EPT will generate an EPT misconfig vmexit if the XWR
bits represent a non-readable page, and therefore the pte_access argument
to make_spte() will also always have ACC_READ_MASK set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 12 +++++-----
 arch/x86/kvm/mmu.h              |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 39 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/mmutrace.h     |  3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h  | 21 +++++++++---------
 arch/x86/kvm/mmu/spte.c         | 18 ++++++---------
 arch/x86/kvm/mmu/spte.h         |  5 +++--
 arch/x86/kvm/vmx/capabilities.h |  5 -----
 arch/x86/kvm/vmx/common.h       |  5 +----
 arch/x86/kvm/vmx/vmx.c          |  3 +--
 10 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 871c7ff4fb29..3efb238c683c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -317,11 +317,11 @@ struct kvm_kernel_irq_routing_entry;
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
@@ -336,7 +336,7 @@ struct kvm_kernel_irq_routing_entry;
  *     cr0_wp=0, therefore these three bits only give rise to 5 possibilities.
  *
  * Therefore, the maximum number of possible upper-level shadow pages for a
- * single gfn is a bit less than 2^13.
+ * single gfn is a bit less than 2^14.
  */
 union kvm_mmu_page_role {
 	u32 word;
@@ -345,7 +345,7 @@ union kvm_mmu_page_role {
 		unsigned has_4_byte_gpte:1;
 		unsigned quadrant:2;
 		unsigned direct:1;
-		unsigned access:3;
+		unsigned access:4;
 		unsigned invalid:1;
 		unsigned efer_nx:1;
 		unsigned cr0_wp:1;
@@ -355,7 +355,7 @@ union kvm_mmu_page_role {
 		unsigned guest_mode:1;
 		unsigned passthrough:1;
 		unsigned is_mirror:1;
-		unsigned :4;
+		unsigned :3;
 
 		/*
 		 * This is left at the top of the word so that
@@ -481,7 +481,7 @@ struct kvm_mmu {
 	 * Byte index: page fault error code [4:1]
 	 * Bit index: pte permissions in ACC_* format
 	 */
-	u8 permissions[16];
+	u16 permissions[16];
 
 	u64 *pae_root;
 	u64 *pml4_root;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b4b6860ab971..f5d35f66750b 100644
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
index 84351df8a9cb..b87dbf9e42b9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2029,7 +2029,7 @@ static bool kvm_sync_page_check(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 	 */
 	const union kvm_mmu_page_role sync_role_ign = {
 		.level = 0xf,
-		.access = 0x7,
+		.access = ACC_ALL,
 		.quadrant = 0x3,
 		.passthrough = 0x1,
 	};
@@ -5426,7 +5426,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
  * update_permission_bitmask() builds what is effectively a
  * two-dimensional array of bools.  The second dimension is
  * provided by individual bits of permissions[pfec >> 1], and
- * logical &, | and ~ operations operate on all the 8 possible
+ * logical &, | and ~ operations operate on all the 16 possible
  * combinations of ACC_* bits.
  */
 #define ACC_BITS_MASK(access) \
@@ -5436,15 +5436,24 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
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
 	unsigned byte;
 
-	const u8 x = ACC_BITS_MASK(ACC_EXEC_MASK);
-	const u8 w = ACC_BITS_MASK(ACC_WRITE_MASK);
-	const u8 u = ACC_BITS_MASK(ACC_USER_MASK);
+	const u16 x = ACC_BITS_MASK(ACC_EXEC_MASK);
+	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
+	const u16 u = ACC_BITS_MASK(ACC_USER_MASK);
+	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
 	bool cr4_smap = is_cr4_smap(mmu);
@@ -5467,24 +5476,26 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 		unsigned pfec = byte << 1;
 
 		/*
-		 * Each "*f" variable has a 1 bit for each UWX value
+		 * Each "*f" variable has a 1 bit for each ACC_* combo
 		 * that causes a fault with the given PFEC.
 		 */
 
+		/* Faults from reads to non-readable pages */
+		u16 rf = (pfec & (PFERR_WRITE_MASK|PFERR_FETCH_MASK)) ? 0 : (u16)~r;
 		/* Faults from writes to non-writable pages */
-		u8 wf = (pfec & PFERR_WRITE_MASK) ? (u8)~w : 0;
+		u16 wf = (pfec & PFERR_WRITE_MASK) ? (u16)~w : 0;
 		/* Faults from user mode accesses to supervisor pages */
-		u8 uf = (pfec & PFERR_USER_MASK) ? (u8)~u : 0;
+		u16 uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
 		/* Faults from fetches of non-executable pages*/
-		u8 ff = (pfec & PFERR_FETCH_MASK) ? (u8)~x : 0;
+		u16 ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
 		/* Faults from kernel mode fetches of user pages */
-		u8 smepf = 0;
+		u16 smepf = 0;
 		/* Faults from kernel mode accesses of user pages */
-		u8 smapf = 0;
+		u16 smapf = 0;
 
 		if (!ept) {
 			/* Faults from kernel mode accesses to user pages */
-			u8 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
+			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
 			/* Not really needed: !nx will cause pte.nx to fault */
 			if (!efer_nx)
@@ -5517,7 +5528,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | smepf | smapf;
+		mmu->permissions[byte] = ff | uf | wf | rf | smepf | smapf;
 	}
 }
 
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index f35a830ce469..44545f6f860a 100644
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
index ed762bb4b007..bbdbf4ae2d65 100644
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
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index e2acd9ed9dba..0b09124b0d54 100644
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
@@ -390,6 +387,7 @@ u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled)
 	u64 spte = SPTE_MMU_PRESENT_MASK;
 
 	spte |= __pa(child_pt) | shadow_present_mask | PT_WRITABLE_MASK |
+		PT_PRESENT_MASK /* or VMX_EPT_READABLE_MASK */ |
 		shadow_user_mask | shadow_x_mask | shadow_me_value;
 
 	if (ad_disabled)
@@ -490,18 +488,16 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_me_spte_mask);
 
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
index 3d77755b6b10..0c305f2f4ba0 100644
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
index 5316c27f6099..3bda6a621d8a 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -288,11 +288,6 @@ static inline bool cpu_has_vmx_flexpriority(void)
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
index 2e687761aeaf..98801c408b8c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8425,8 +8425,7 @@ __init int vmx_hardware_setup(void)
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
-		kvm_mmu_set_ept_masks(enable_ept_ad_bits,
-				      cpu_has_vmx_ept_execute_only());
+		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
 	else
 		vt_x86_ops.get_mt_mask = NULL;
 
-- 
2.52.0

