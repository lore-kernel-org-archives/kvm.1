Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18324503E9
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841090; cv=none; b=YO0pjjinq1bFcKgFgKm8BWUcSIYkU8YgQqIJ8/rr7licY1CNC6xc+He8IhzMKhq02LqXMIPYw+bk3ae74TJzoXww2go7h2MXwb2wOl0W2rmapu3TN1Bwe8JxQHhsp3sejqXff9dQ3ea7yE1J7nJRxzma2mXLIa3RrUF3U11opcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841090; c=relaxed/simple;
	bh=qNsGDjSXmrDO4E8OltKgVJGP7btPSiJzKaauWKqcujE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EG/5F+ADJYAuMT5f0l48Nb1+B8O9aKdFxbuA3MdYXy2yg4RSmUDStmY1nfbHdPRxXsFfe5izcofJhHcb+y7dDuPPkrRauz0TY45oua62THPSq1f5kSznzuJok6vOPIiYrgaoho+l6QkRlFwAOWExAVMCM0cet1TNGp9w+sYZUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jW2HLtQ6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jW2HLtQ6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so53693455ad.2
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785841082; x=1786445882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gmvruGvhObjRkfatzPup5KdvMlhQ+iXfk/s6L7SaZ4=;
        b=jW2HLtQ60QQFt+SjWe9vngmz0t8kJKeFS10Fxm6bv03XD/UFVbQ0JcmmXbZClfN8L0
         okzAlUj+Z5dsm4lCkGAc0PQw6YB90LPqcoIDAgmpk+lZirFfAeRy38LA4YdEYxxRLkLe
         X4NlA/hSdlKwkqXom7iCZaXhbRlyvnUyeoFRD4y3EBcTR3gu1qdBzbbONTkCeP+SxuoE
         WhN602rJZXk2sO4FvJNuH5bcxrEfzMCgQV0TXvlV6Y3nOx3e0i39vlktP62arco9m4X4
         kSuC5k6BvCopopt1MHZN2GqjDNR3ZXE10MfeFl4grVhmKuvQ55jw7qjNVDX0DqVgdwDG
         cOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785841082; x=1786445882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gmvruGvhObjRkfatzPup5KdvMlhQ+iXfk/s6L7SaZ4=;
        b=a9ho+ERCU/l2Yl8nuNQOJh94weWOvATA+9h6oKDG3gxHqEqYC1zjlJPJukjW6LSdho
         B7cEYX0Nw/Cw8W50Ni99dgcTYLd4iVL9KSQPzKEiI/8O2EGBOao1J7pFZponkN3JdSHL
         Ja2q2/mPXdZP7/CBWnFNEsutimrTHjcfVAK9S+FvhD4T6bIVL+UBBOSnW267PcnOO3kI
         lvJcoa0t6Wx6iLIRP3Lctk7sBmM/el5428o8ZuYuEmiwoNB9Wwn9Y408SVLDEukTAahh
         cX/SYQnYK1Y/GS8L6O5dbvxSzG4Vc5xnqBOyW11XHV7h9POBBpHok5sLcYsIF9QvzL78
         Oq4w==
X-Gm-Message-State: AOJu0Yy6hggO5sVWZFfR755qfOjVpsQMqueZWW6bth0doc4EwKPHnDVM
	1OkZn5iaEfyj7inJyRLqsZFa2FPym0IjyNEm48n1Ben5K0ERHLc79uLx
X-Gm-Gg: AR+sD1237GcEVib9p3Mq8pSJQ+8EKMax1z6bMp6HNTcEIuLm/OrOTch0kAE2/mt+TZU
	va4v68N8tXltfwG7+um4V54k5pTGLgYuCJs3Uos4RgX203blP1pURo2RM8+sXkCH0y7vEtKcU3y
	4L8ym6w8TZzies0Qv4HRyEsauryIocedIA68Os9hWG+wWm5P6XnrgGli9JR5qYcj9LMKbftrdYT
	5tnPqklP4P9G0vghZlB33fCR461+1ardHLAYrQj/+dqk9RmY/Y2ZpcVuFuVNKb/U5PlFk3+pS29
	5BI++iFwj/5MbSgMk7Ma4HJ098OcQstKpA3TDWwsTQMhmePFb6YhCzwFk9BaOlJqrUuWhtDXNQW
	tXa9GmnhYs/3l9A15wB+3yMWaW/r2D5J69HrmRqfPL6Dtf7lavJ7K7JEBqJWS1BnuuuYjteXK+p
	+kn0By3pKeTw0DEAovbSu93JpWaGVW5DMotOqKBHffegRD0iOAViC7HgGfcNoAkiq2C87TL6Bqt
	4JWz1RFdCHqMQ==
X-Received: by 2002:a17:903:22d1:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2d0522233d3mr134076635ad.17.1785841081905;
        Tue, 04 Aug 2026 03:58:01 -0700 (PDT)
Received: from DESKTOP-58PM2JF.localdomain ([116.84.110.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0b6fbf2c6sm102515ad.34.2026.08.04.03.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:58:01 -0700 (PDT)
From: Jinu Kim <kimjw04271234@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2] KVM: x86/mmu: Write-protect tracked GFNs in all address spaces
Date: Tue,  4 Aug 2026 19:57:55 +0900
Message-ID: <20260804105755.276646-1-kimjw04271234@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM relies on write tracking to fault all subsequent guest CPU writes to a
GFN that backs a shadow page.  The write-protection installed when tracking
starts is currently restricted to the supplied memslot.

With SMM, the same backing page can be mapped through both x86 address
spaces.  If the peer address space already has a writable SPTE, a guest
write through that mapping bypasses page tracking and leaves KVM's shadow
state stale.  On current mainline, changing a nested EPT PDE through the
surviving SMM mapping leaves L2 using the old translation even after a
valid INVEPT.  Performing the same change through the tracked address
space faults and updates the translation.

Write-protect existing mappings in both x86 address spaces whenever KVM
registers or synchronizes a tracked GFN.

Revoking existing SPTEs is not sufficient.  A later fault on another GFN
in the same 2 MiB or 1 GiB region can recreate a writable huge SPTE over
the tracked GFN.  When selecting a mapping level, consult dynamic
large-page restrictions in every peer memslot that overlaps the candidate
huge-page range.  Keep slot-layout and memory-attribute restrictions local
to the address space that owns the mapping, and keep all counters in their
owning memslots.

This restores the invariant that a tracked GFN cannot remain, or become,
CPU-writable through another x86 address space.

Fixes: 699023e23965 ("KVM: x86: add SMM to the MMU role, support SMRAM address space")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Jinu Kim <kimjw04271234@gmail.com>
---
Changes in v2:
- Cover writable huge-SPTE recreation in addition to existing SPTEs.
- Check every peer memslot that overlaps the candidate huge-page range.
- Propagate only dynamic peer restrictions and keep per-slot accounting and
  intrinsic restrictions local.

Testing:
- The existing-SPTE reproducer produced
  before=A hidden=A hidden_invept=A control=B on stock v7.2-rc6, and
  before=A hidden=B hidden_invept=B control=B with this patch.
- A huge-SPTE re-arm reproducer placed the tracked GFN one 4 KiB page into a
  2 MiB mapping, then faulted a sibling GFN before writing the tracked GFN.
  An existing-SPTE-only fix left hidden=A hidden_invept=A; this patch
  produced hidden=B hidden_invept=B.
- Re-ran the existing-SPTE reproducer with tdp_mmu=N; this patch produced
  before=A hidden=B hidden_invept=B control=B.
- Ran all 103 tests in the default x86 KVM selftests collection.  65 passed,
  35 skipped, and the three failures reproduced with the parent commit in
  the same nested test environment.
- Ran all 87 tests in the default x86 kvm-unit-tests suite.  53 passed,
  30 skipped, and the four failures reproduced with the parent commit in the
  same nested test environment.
- Built and booted a matching bzImage, kvm.ko, kvm-intel.ko, and
  irqbypass.ko from commit e38548d14bfb.
- Passed scripts/checkpatch.pl --strict and a W=1 build of kvm.ko and
  kvm-intel.ko.

 arch/x86/kvm/mmu.h              | 11 +++++
 arch/x86/kvm/mmu/mmu.c          | 77 +++++++++++++++++++++++++++------
 arch/x86/kvm/mmu/mmu_internal.h |  3 ++
 arch/x86/kvm/mmu/page_track.c   |  2 +-
 arch/x86/kvm/x86.c              |  8 ++--
 5 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd58..2dd89fcba0aea 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -274,6 +274,17 @@ static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 	return !tdp_mmu_enabled || kvm_shadow_root_allocated(kvm);
 }
 
+/*
+ * The upper bits of disallow_lpage describe restrictions that are intrinsic
+ * to the memslot or its memory attributes.  The lower bits refcount dynamic
+ * restrictions, e.g. shadowed or externally write-tracked GFNs.
+ */
+#define KVM_LPAGE_MIXED_FLAG		BIT(31)
+#define KVM_LPAGE_SLOT_DISALLOW_FLAG	BIT(30)
+#define KVM_LPAGE_DISALLOW_FLAGS	(KVM_LPAGE_MIXED_FLAG | \
+					 KVM_LPAGE_SLOT_DISALLOW_FLAG)
+#define KVM_LPAGE_DYNAMIC_DISALLOW_MASK	GENMASK(29, 0)
+
 static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
 {
 	/* KVM_HPAGE_GFN_SHIFT(PG_LEVEL_4K) must be 0. */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 66e69d2a41b3c..69e33140723c9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -742,13 +742,43 @@ static bool kvm_gfn_is_lpage_allowed(struct kvm *kvm,
 	return true;
 }
 
-/*
- * The most significant bit in disallow_lpage tracks whether or not memory
- * attributes are mixed, i.e. not identical for all gfns at the current level.
- * The lower order bits are used to refcount other cases where a hugepage is
- * disallowed, e.g. if KVM has shadow a page table at the gfn.
- */
-#define KVM_LPAGE_MIXED_FLAG	BIT(31)
+static bool kvm_gfn_is_lpage_allowed_for_mapping(struct kvm *kvm,
+						 const struct kvm_memory_slot *slot,
+						 gfn_t gfn, int level)
+{
+	const struct kvm_memory_slot *other_slot;
+	struct kvm_memslot_iter iter;
+	struct kvm_memslots *slots;
+	gfn_t start, end;
+
+	if (lpage_info_slot(gfn, slot, level)->disallow_lpage)
+		return false;
+
+	if (kvm_arch_nr_memslot_as_ids(kvm) == 1)
+		return true;
+
+	start = gfn_round_for_level(gfn, level);
+	end = start + KVM_PAGES_PER_HPAGE(level);
+	slots = __kvm_memslots(kvm, slot->as_id ^ 1);
+
+	if (kvm_memslots_empty(slots))
+		return true;
+
+	other_slot = __gfn_to_memslot(slots, start);
+	if (other_slot && other_slot->base_gfn + other_slot->npages >= end)
+		return !(lpage_info_slot(start, other_slot, level)->disallow_lpage &
+			 KVM_LPAGE_DYNAMIC_DISALLOW_MASK);
+
+	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+		gfn_t slot_gfn = max(start, iter.slot->base_gfn);
+
+		if (lpage_info_slot(slot_gfn, iter.slot, level)->disallow_lpage &
+		    KVM_LPAGE_DYNAMIC_DISALLOW_MASK)
+			return false;
+	}
+
+	return true;
+}
 
 static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 					    gfn_t gfn, int count)
@@ -761,7 +791,8 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 
 		old = linfo->disallow_lpage;
 		linfo->disallow_lpage += count;
-		WARN_ON_ONCE((old ^ linfo->disallow_lpage) & KVM_LPAGE_MIXED_FLAG);
+		WARN_ON_ONCE((old ^ linfo->disallow_lpage) &
+			     KVM_LPAGE_DISALLOW_FLAGS);
 	}
 }
 
@@ -801,7 +832,7 @@ static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 
 	kvm_mmu_gfn_disallow_lpage(slot, gfn);
 
-	if (kvm_mmu_slot_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
+	if (kvm_mmu_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
 		kvm_flush_remote_tlbs_gfn(kvm, gfn, PG_LEVEL_4K);
 }
 
@@ -1510,12 +1541,33 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 	return write_protected;
 }
 
+bool kvm_mmu_gfn_write_protect(struct kvm *kvm,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int min_level)
+{
+	struct kvm_memory_slot *other_slot;
+	bool write_protected;
+
+	BUILD_BUG_ON(KVM_MAX_NR_ADDRESS_SPACES > 2);
+
+	write_protected = kvm_mmu_slot_gfn_write_protect(kvm, slot, gfn, min_level);
+	if (kvm_arch_nr_memslot_as_ids(kvm) > 1) {
+		other_slot = __gfn_to_memslot(__kvm_memslots(kvm, slot->as_id ^ 1), gfn);
+		if (other_slot)
+			write_protected |= kvm_mmu_slot_gfn_write_protect(kvm,
+							     other_slot,
+							     gfn, min_level);
+	}
+
+	return write_protected;
+}
+
 static bool kvm_vcpu_write_protect_gfn(struct kvm_vcpu *vcpu, u64 gfn)
 {
 	struct kvm_memory_slot *slot;
 
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn, PG_LEVEL_4K);
+	return kvm_mmu_gfn_write_protect(vcpu->kvm, slot, gfn, PG_LEVEL_4K);
 }
 
 static bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -3396,7 +3448,6 @@ static u8 kvm_gmem_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fau
 int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 			      const struct kvm_memory_slot *slot, gfn_t gfn)
 {
-	struct kvm_lpage_info *linfo;
 	int host_level, max_level;
 	bool is_private;
 
@@ -3412,8 +3463,8 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
 
 	max_level = min(max_level, max_huge_page_level);
 	for ( ; max_level > PG_LEVEL_4K; max_level--) {
-		linfo = lpage_info_slot(gfn, slot, max_level);
-		if (!linfo->disallow_lpage)
+		if (kvm_gfn_is_lpage_allowed_for_mapping(kvm, slot, gfn,
+							 max_level))
 			break;
 	}
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 73cdcbccc89e8..424ff75433582 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -207,6 +207,9 @@ void kvm_mmu_gfn_allow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn);
 bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn,
 				    int min_level);
+bool kvm_mmu_gfn_write_protect(struct kvm *kvm,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int min_level);
 
 /* Flush the given page (huge or not) of guest memory. */
 static inline void kvm_flush_remote_tlbs_gfn(struct kvm *kvm, gfn_t gfn, int level)
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 7e8195a311bb0..f32caafcca8db 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -106,7 +106,7 @@ void __kvm_write_track_add_gfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 */
 	kvm_mmu_gfn_disallow_lpage(slot, gfn);
 
-	if (kvm_mmu_slot_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
+	if (kvm_mmu_gfn_write_protect(kvm, slot, gfn, PG_LEVEL_4K))
 		kvm_flush_remote_tlbs(kvm);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47cb9eba113b1..bfe350567cea3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13557,9 +13557,10 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		slot->arch.lpage_info[i - 1] = linfo;
 
 		if (slot->base_gfn & (KVM_PAGES_PER_HPAGE(level) - 1))
-			linfo[0].disallow_lpage = 1;
+			linfo[0].disallow_lpage = KVM_LPAGE_SLOT_DISALLOW_FLAG;
 		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
-			linfo[lpages - 1].disallow_lpage = 1;
+			linfo[lpages - 1].disallow_lpage =
+				KVM_LPAGE_SLOT_DISALLOW_FLAG;
 		ugfn = slot->userspace_addr >> PAGE_SHIFT;
 		/*
 		 * If the gfn and userspace address are not aligned wrt each
@@ -13569,7 +13570,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 			unsigned long j;
 
 			for (j = 0; j < lpages; ++j)
-				linfo[j].disallow_lpage = 1;
+				linfo[j].disallow_lpage =
+					KVM_LPAGE_SLOT_DISALLOW_FLAG;
 		}
 	}
 

base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
-- 
2.43.0
