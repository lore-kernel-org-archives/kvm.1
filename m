Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2236308C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763559; cv=none; b=WJals990zBtSNa4njo5gJ85+5SlAUpl4Hfa6pcPcXZYsXGeOvo8PAf44pyFM97KBv3q1WnURNg689sIvkQzyI3UmGRHKCA52ByEh5xe3Eni2nIDNgyMFOGyPLp8T91o/Ub/eMHF5Kiy0T06d83COlbSaCCcSt6D4uqBBAmUhUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763559; c=relaxed/simple;
	bh=mHZEN9VsRGqjqCssbvNKqiiprdqF3SpE8VAB/Dd5Wtg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOGAX1NtVjLcwxctFihGg274s3KB9JVg6X/5WDde2rLK7HwF4vsy1yFkPHNpbPtI2oOROCupVg7CzxNE6PUgCXqb/siUBm/sWGSPzY2ODnEds6viIQ7rqfCVeajoLe0Jr4qHMAyjsaL6DF0boj1h2huAJbKtC9htWyn4DxVK0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lYThRDqh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lYThRDqh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab232cc803so19323145ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776763557; x=1777368357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqGRaYikd48k8jEHjjdiykQw70hWXJqzRcIUQ0MV2mg=;
        b=lYThRDqhzeUmWdXf2XYH+8RL82uBbJnDFkstNVFWbtBtaYV9HzuYdqdPM0ufRTjavq
         06Y4Yiri4ZtQ2GcD/5kHFN5neReyU55H7/GIlZn/SZq8gqMrW8bWKw0i892zGi+Cf9NY
         xuioPEopBdzdB9X2jmL9XZscgssLU4ZwnTlBHQycJiOgx1nOJOA5i5t1Hri5EIQE2hHR
         oFy9BLjRynWM3rbal//Q7oSrCYvJjYb8MQWex3qGFGbJcVc/u6IsaD0QNnoshOIoHLHi
         kD3l2nHp7NsSVSmhTsVcRPG9RHT2MjPyr1112gkLS8zHj60sY3zlQ6UB3WpoD4oVjC+1
         aySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763557; x=1777368357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqGRaYikd48k8jEHjjdiykQw70hWXJqzRcIUQ0MV2mg=;
        b=GcMfI1QG3Vs0I97KfFcl7uggXMTOj4OcsXJxz3Ba69wyhSfTldj5SuSln3U+8Q1vUH
         39XbCY5bwSq4Kr6DN2jQIZNHlrtFhYqeFaXm7BPiskacsrCbRC1RMmMAemHqv28e/9gT
         PSrr0UOsqeJ2v2cMKKwKcqUYEUsTWvZ489lddIMlMjce2p1/oEWO7Hhp5eH9CN99HbHC
         apn1+FC3IvC0N3KHQbNyy0D5chuwMLHL0W3acf6u+VvCUGf4LxFjoZP18c6ez7qRNx+i
         AEWf+M5djdzsUUtc2IUp/qq562PhNK2LpKSpxFCbVMSiqJfmzkSEZSexaweendn7xqMK
         8aHA==
X-Forwarded-Encrypted: i=1; AFNElJ+Rh/JpRDCzKx27ILegPShLmZSr0kzRUEceu34fUKujoe3+7JNMrzAxoY2AShHakSL4IOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnebAg6eLpZL6S2SjzphmRTtPaimrk1BVsjdar46NSxEulHsN7
	ZcQZVuIiVIyjJKeMTOLz5xFp+qTmkVeiAKjvIE+edsMshDxxOqBwLPuWpSwALze/EpY=
X-Gm-Gg: AeBDieuK/jnrws+H0GUACxYt894aO4To5B4btbk5OABI2QZUPCB3WXhMFGyYMEw2Ben
	kEPgm2wbbdZxn+85qY18bZ1nLQcflE2bwnZQmbschYkXt2wwQ5QI/a6JqjQynF9wIohKkQWDnok
	w4Sy+X8zCrZ59RgByvHBxaGOSFOr/bdgDwdoZo541gKhJbXolEgiAJNtjnbYuklT3cLUl/aKUSf
	fskHl7kuaTmlKHmk0fMmmhao4kaW2XM4jf7g3Zd490khgRWbBKGOefXZaYQzOv1yxU83JguZRDK
	zIZXp8FMDrlQzl8EXXMVl0raQvWIPIMiCurxM+fMsHH5x3Ytlsmz2PkoHGmRf7VT6zrBICED3X3
	EsGRhoIcSO4Xl3XLSzc/rOR/82/FUYxWut0F+0ynWdxXEJsxPOLqZHk4uBea6YFNX767VugOwt1
	cUVAgUB24o39E7iRLR+doSuxhgmNiZPcjvauGKAqfOoSYTUU6D21kWaiwFJ6x0XGOdHNOo
X-Received: by 2002:a17:903:1b30:b0:2b4:586d:2e5c with SMTP id d9443c01a7336-2b5f9ecbaa1mr174163805ad.2.1776763557022;
        Tue, 21 Apr 2026 02:25:57 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm131965105ad.4.2026.04.21.02.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Apr 2026 02:25:56 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	andrew+kernel@donnellan.id.au,
	andreyknvl@gmail.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	apopple@nvidia.com,
	ardb@kernel.org,
	atish.patra@linux.dev,
	baolin.wang@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	david@kernel.org,
	debug@rivosinc.com,
	djordje.todorovic@htecgroup.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	ilias.apalodimas@linaro.org,
	junhui.liu@pigmoral.tech,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.xuemei1@zte.com.cn,
	ljs@kernel.org,
	namcao@linutronix.de,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rmclure@linux.ibm.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryabinin.a.a@gmail.com,
	surenb@google.com,
	vincenzo.frascino@arm.com,
	vishal.moola@gmail.com,
	wangruikang@iscas.ac.cn,
	zhangchunyan@iscas.ac.cn
Subject: [PATCH 5/7] riscv: add contiguous PTE range clearing helpers
Date: Tue, 21 Apr 2026 17:24:55 +0800
Message-Id: <20260421092457.37649-6-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260421092457.37649-1-cuiyunhui@bytedance.com>
References: <20260421092457.37649-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Svnapot-aware implementations of clear_full_ptes() and
get_and_clear_full_ptes() so full PTE batches can be cleared without
losing the required unfold semantics for NAPOT mappings.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 75 ++++++++++++++++++++++++-
 arch/riscv/mm/contpte.c          | 96 ++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 722483d4df37f..3e6516b5a4587 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -657,7 +657,6 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 }
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
-
 static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pteval, unsigned int nr)
 {
@@ -764,6 +763,47 @@ __ptep_get_and_clear(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 
 #define __ptep_get_and_clear __ptep_get_and_clear
 
+static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned int nr, int full)
+{
+	(void)full;
+
+	for (;;) {
+		__ptep_get_and_clear(mm, addr, ptep);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
+#define __clear_full_ptes __clear_full_ptes
+
+static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
+					      unsigned long addr,
+				      pte_t *ptep,
+				      unsigned int nr,
+				      int full)
+{
+	pte_t pte, tmp_pte;
+
+	(void)full;
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		if (pte_dirty(tmp_pte))
+			pte = pte_mkdirty(pte);
+		if (pte_young(tmp_pte))
+			pte = pte_mkyoung(pte);
+	}
+
+	return pte;
+}
+
+#define __get_and_clear_full_ptes __get_and_clear_full_ptes
 static inline void
 __ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
@@ -831,6 +871,11 @@ pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 pte_t napotpte_ptep_get_lockless(pte_t *ptep);
 void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		       pte_t *ptep, pte_t pte, unsigned int nr);
+void napotpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned int nr, int full);
+pte_t napotpte_get_and_clear_full_ptes(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep,
+				       unsigned int nr, int full);
 void napotpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 				     unsigned long addr, pte_t *ptep,
 			     unsigned int nr, cydp_t flags);
@@ -933,6 +978,32 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 	napotpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
 }
 
+#define clear_full_ptes clear_full_ptes
+static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, unsigned int nr, int full)
+{
+	if (likely(nr == 1)) {
+		napotpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		__clear_full_ptes(mm, addr, ptep, nr, full);
+		return;
+	}
+
+	napotpte_clear_full_ptes(mm, addr, ptep, nr, full);
+}
+
+#define get_and_clear_full_ptes get_and_clear_full_ptes
+static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+				    unsigned int nr, int full)
+{
+	if (likely(nr == 1)) {
+		napotpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
+	}
+
+	return napotpte_get_and_clear_full_ptes(mm, addr, ptep, nr, full);
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
@@ -989,6 +1060,8 @@ napotpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 #define ptep_get_lockless			__ptep_get_lockless
 #define ptep_get_and_clear			__ptep_get_and_clear
 #define clear_young_dirty_ptes			__clear_young_dirty_ptes
+#define clear_full_ptes				__clear_full_ptes
+#define get_and_clear_full_ptes			__get_and_clear_full_ptes
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect			__ptep_set_wrprotect
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index f73af7d9b099a..77c2a4dbd3dda 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -107,6 +107,38 @@ __napot_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep
 	return pte;
 }
 
+static void __napot_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, unsigned int nr)
+{
+	for (;;) {
+		__napot_ptep_get_and_clear(mm, addr, ptep);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
+static pte_t __napot_get_and_clear_full_ptes(struct mm_struct *mm,
+					     unsigned long addr, pte_t *ptep,
+					     unsigned int nr)
+{
+	pte_t pte, tmp_pte;
+
+	pte = __napot_ptep_get_and_clear(mm, addr, ptep);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		tmp_pte = __napot_ptep_get_and_clear(mm, addr, ptep);
+		if (pte_dirty(tmp_pte))
+			pte = pte_mkdirty(pte);
+		if (pte_young(tmp_pte))
+			pte = pte_mkyoung(pte);
+	}
+
+	return pte;
+}
+
 static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep, pte_t target)
 {
@@ -202,6 +234,33 @@ void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(__napotpte_try_fold);
 
+static void napotpte_try_unfold_range(struct mm_struct *mm,
+				      unsigned long addr, pte_t *ptep,
+				      unsigned int nr)
+{
+	unsigned long next;
+	pte_t pte;
+	unsigned int chunk;
+
+	while (nr) {
+		pte = READ_ONCE(*ptep);
+		if (pte_present_napot(pte)) {
+			__napotpte_try_unfold(mm, addr, ptep, pte);
+			next = napot_align_addr(addr) + napotpte_size();
+			chunk = (next - addr) >> PAGE_SHIFT;
+		} else {
+			chunk = 1;
+		}
+
+		if (chunk > nr)
+			chunk = nr;
+
+		ptep += chunk;
+		addr += chunk * PAGE_SIZE;
+		nr -= chunk;
+	}
+}
+
 void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, pte_t pte)
 {
@@ -349,6 +408,43 @@ void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(napotpte_set_ptes);
 
+void napotpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned int nr, int full)
+{
+	(void)full;
+
+	if (!napot_hw_supported() || !mm_is_user(mm)) {
+		__napot_clear_full_ptes(mm, addr, ptep, nr);
+		return;
+	}
+
+	/*
+	 * Unlike arm64 contpte, a Svnapot PTE block stores identical
+	 * napot-encoded entries across the whole block rather than per-page
+	 * PFNs. Batch zap paths must therefore unfold the whole covered range
+	 * so the core MM later sees ordinary per-page PTEs for rmap/rss/tlb
+	 * batching.
+	 */
+	napotpte_try_unfold_range(mm, addr, ptep, nr);
+	__napot_clear_full_ptes(mm, addr, ptep, nr);
+}
+EXPORT_SYMBOL(napotpte_clear_full_ptes);
+
+pte_t napotpte_get_and_clear_full_ptes(struct mm_struct *mm,
+				       unsigned long addr, pte_t *ptep,
+				       unsigned int nr, int full)
+{
+	(void)full;
+
+	if (!napot_hw_supported() || !mm_is_user(mm))
+		return __napot_get_and_clear_full_ptes(mm, addr, ptep, nr);
+
+	napotpte_try_unfold_range(mm, addr, ptep, nr);
+
+	return __napot_get_and_clear_full_ptes(mm, addr, ptep, nr);
+}
+EXPORT_SYMBOL(napotpte_get_and_clear_full_ptes);
+
 void napotpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 				     unsigned long addr, pte_t *ptep,
 				     unsigned int nr, cydp_t flags)
-- 
2.39.5

