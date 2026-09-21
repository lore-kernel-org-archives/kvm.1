Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB26485953
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989267; cv=none; b=ai7uOqAJVcKyV32cLfO393zT/+pvCIMOc7cR80+uHlpOjTZY0mnF+wMIkjK9pqujnHle1ltJ5JOo91Sp0ZYd38kxbMdpW0GyMGzdzV80XLKG4PjxsToo6/4r9hja4qSTVY0/XCHig08MU3OfwtNYUkpGNRQZ7gbQ7fTm3KJM3Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989267; c=relaxed/simple;
	bh=1jg1XxWMFzFAotXiHpvxbD8wsFp6YWqm9Uxeq0aUeV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyBeyTCI2bd+zbhCfughrT9orEGB47b1PpqM5k01GkY8yxbLx/UNGObJYj9B9JFSiXk1ydhYS8MIAniYF84v/oZ5vSOIANqGlpGHGKQljeV7BFhycCcEfZ+BFov+jc8OEEscd3MyBTmZ/xN+4Tohy3KalxZ8Q8Ng/x+sWz8whnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBzRnrvp; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBzRnrvp"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so26037685ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 04:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789989264; x=1790594064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdOHOI1E8fGa5CU5V13c9pAIdSK9plZJHC6KFQ2NxiI=;
        b=FBzRnrvp0gBU6Yet5j1nepLE+K8P+GMBuDeoX/06fyykYHBs7XemjVfaELpoRkpv9X
         CpEmddG4LkZvUz6fBa64Z6Q/GpZeDg/c/+m4wILvIuoaytVxv0RsIpod/lGV9EQqMggn
         1+eAKjABo/KgpNKOP173d2j9H2V282NjsxehrnBCKGaS02EvBPnVOYnjoYUgepqrIp4i
         yfmX8BAnMZ/Zm0Jo7CAe+HdT2gphdeQ17s5b/m1Zuv8fvuahfWtVJYk7Dq812gnfayQm
         jpVmfVU6jgCWvdedZRQNUJYgTH/7+F98jPwiRXKseifZOGnWVIDw02/YUZm7tM6u987Z
         gqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789989264; x=1790594064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TdOHOI1E8fGa5CU5V13c9pAIdSK9plZJHC6KFQ2NxiI=;
        b=Sc/lOlR401CpzLJOzxRkU7+Mecqqf4qlA3A13uZho3JRgj2DN2OWn/PAFqYdSCO5qu
         OnVEcQ5LVwoRWR2pVC7wSE6Fe5g+Nfz5Z6N7CNm3FlLw4IpTRVQ3k387u3rK/n0fQ/dW
         EPTAWclggNllmZGJrFPx0caK6VFuprHuoPZCwTMBf00iEof6cBMZdwPpXMPd9JjijHGa
         eMD1EiUwX6LgklR1h2C/xVEw40c7saCqeGG/3gXkMToTabm8VzYWdnFu0r4pg2T9L3bN
         yo4l7PrI4BbwoyLVjdn0B9nAjyZHSjh3YXZgmonggZ2gHK3jeaspoYJaKZPkErMVY0+V
         YFxA==
X-Forwarded-Encrypted: i=1; AKwUvBydD3E948QDb9ufStka4Wvx/ysOvE5/+x4iWvG9fupyX86TFR3i1nhPmCj17bqnXLU9YpY=@vger.kernel.org
X-Gm-Message-State: AFuF++kumPvc6qwOhEzN9fXdeHubcZok8POgkylEJe2zG9LsytT0Eylq
	lXCVKuRf+UhPKyLhg57uPkRfEJwEe9Q1WPFOk9tpmoEnlfQv/UhNNK46
X-Gm-Gg: AYBFou0V/kLHdQ1sIwOsfojFQhu91EgVHLd7O/j887WAwdwkhccYacQMGUz6CvY8bDH
	ix6sDDvWc0s2AJR2CEagsZbd/ufjcN7G1UX7i8n84SEU3kO7vZoeDbQbmsPCyeiCInIyh1Ncs9W
	sFO4+TnKO2GtX7Bm/uYKMKJS/qlLvY1GzAGS1czFUR4dw73uFJ2hastTTAMk9lWOVpsyHqCBmUP
	kx7QHpwgtZvwv++fzUJ5ehsnZgkc0XS/y1rB4WzS9yty3Bak7uS3DgVUomU2Fugn4tEUTlxOBtn
	Sna7svD4OPdXzFtNybsZaDcQi0iof/MZSYncIlbOnFP/ThrSUhpQ9yn+mkkJG9MTXsXDetilVg/
	pUqxSwxo24023DexGxcM9Xd/6O6nlJotYeA+7wOPGFMiVuEz3ID++ouAek5oHJ6rJIy6c4j/l+Q
	3VOUDAjncPDa05g4sDFvnOmWIfFKlCyO0FowXYuD3Lpc1aOKXt9gCMuRAPPM3g/aJjkwhR8+hnm
	oMM9u+RfXDnwNGDMNCXorgSTkML+B9v
X-Received: by 2002:a17:90b:35c9:b0:39e:6c6a:656c with SMTP id 98e67ed59e1d1-39e6c6a674bmr9093523a91.47.1789989264562;
        Mon, 21 Sep 2026 04:14:24 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm13438703a91.0.2026.09.21.04.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:14:24 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jinyu Tang <tjytimi@163.com>,
	Wang Yechao <wang.yechao255@zte.com.cn>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 2/5] KVM: riscv: Read G-stage PTEs once when walking page tables
Date: Mon, 21 Sep 2026 20:13:59 +0900
Message-ID: <20260921111402.120911-3-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260921111402.120911-1-suunj1331@gmail.com>
References: <20260921111402.120911-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gstage_pte_leaf() dereferences the PTE pointer, causing walkers to read
the same entry multiple times. This is safe under mmu_lock, but a
lockless walker could observe different values when deciding whether an
entry is a leaf and which child table to follow.

Make gstage_pte_leaf() take a PTE value and use a single snapshot for
presence, leaf and child-table checks. Also remove a redundant leaf
check in kvm_riscv_gstage_set_pte(), where mmu_lock prevents the entry
from changing.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 arch/riscv/kvm/gstage.c | 48 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index f61ba434093c..944fa4c95aea 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -19,8 +19,8 @@ unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 3;
 unsigned long kvm_riscv_gstage_max_pgd_levels __ro_after_init = 2;
 #endif
 
-#define gstage_pte_leaf(__ptep)	\
-	(pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
+#define gstage_pte_leaf(__pte)	\
+	(pte_val(__pte) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
 
 static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
 					     gpa_t addr, u32 level)
@@ -84,14 +84,18 @@ static int gstage_level_to_page_size(struct kvm_gstage *gstage, u32 level,
 bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
 			       pte_t **ptepp, u32 *ptep_level)
 {
-	pte_t *ptep;
+	pte_t *ptep, pte;
 	u32 current_level = gstage->pgd_levels - 1;
 
 	*ptep_level = current_level;
 	ptep = (pte_t *)gstage->pgd;
 	ptep = &ptep[gstage_pte_index(gstage, addr, current_level)];
-	while (ptep && pte_val(ptep_get(ptep))) {
-		if (gstage_pte_leaf(ptep)) {
+	while (ptep) {
+		pte = ptep_get(ptep);
+		if (!pte_val(pte))
+			break;
+
+		if (gstage_pte_leaf(pte)) {
 			*ptep_level = current_level;
 			*ptepp = ptep;
 			return true;
@@ -100,7 +104,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
 		if (current_level) {
 			current_level--;
 			*ptep_level = current_level;
-			ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+			ptep = (pte_t *)gstage_pte_page_vaddr(pte);
 			ptep = &ptep[gstage_pte_index(gstage, addr, current_level)];
 		} else {
 			ptep = NULL;
@@ -151,10 +155,12 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 		return -EINVAL;
 
 	while (current_level != map->level) {
-		if (gstage_pte_leaf(ptep))
+		pte_t pte = ptep_get(ptep);
+
+		if (gstage_pte_leaf(pte))
 			return -EEXIST;
 
-		if (!pte_val(ptep_get(ptep))) {
+		if (!pte_val(pte)) {
 			if (!pcache)
 				return -ENOMEM;
 			next_ptep = kvm_mmu_memory_cache_alloc(pcache);
@@ -163,9 +169,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 			set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
 					      __pgprot(_PAGE_TABLE)));
 		} else {
-			if (gstage_pte_leaf(ptep))
-				return -EEXIST;
-			next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+			next_ptep = (pte_t *)gstage_pte_page_vaddr(pte);
 		}
 
 		current_level--;
@@ -175,7 +179,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 	if (pte_val(*ptep) != pte_val(map->pte)) {
 		bool was_invalid = !pte_val(*ptep);
 		set_pte(ptep, map->pte);
-		if (gstage_pte_leaf(ptep) &&
+		if (gstage_pte_leaf(map->pte) &&
 		    !(was_invalid && riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)))
 			gstage_tlb_flush(gstage, current_level, map->addr);
 	}
@@ -316,7 +320,7 @@ bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 	unsigned long huge_pte, child_pte;
 	unsigned long child_page_size;
 	bool need_flush = false;
-	pte_t *ptep;
+	pte_t *ptep, pte;
 	int i, ret;
 
 	if (!pcache)
@@ -325,16 +329,17 @@ bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 	while(current_level > target_level) {
 		ptep = (pte_t *)&next_ptep[gstage_pte_index(gstage, addr, current_level)];
 
-		if (!pte_val(ptep_get(ptep)))
+		pte = ptep_get(ptep);
+		if (!pte_val(pte))
 			break;
 
-		if (!gstage_pte_leaf(ptep)) {
-			next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+		if (!gstage_pte_leaf(pte)) {
+			next_ptep = (pte_t *)gstage_pte_page_vaddr(pte);
 			current_level--;
 			continue;
 		}
 
-		huge_pte = pte_val(ptep_get(ptep));
+		huge_pte = pte_val(pte);
 
 		ret = gstage_level_to_page_size(gstage, current_level - 1, &child_page_size);
 		if (ret)
@@ -373,7 +378,7 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
 {
 	int i, ret;
-	pte_t old_pte, *next_ptep;
+	pte_t old_pte, pte, *next_ptep;
 	u32 next_ptep_level;
 	unsigned long next_page_size, page_size;
 	bool flush = false;
@@ -384,11 +389,12 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 
 	WARN_ON(addr & (page_size - 1));
 
-	if (!pte_val(ptep_get(ptep)))
+	pte = ptep_get(ptep);
+	if (!pte_val(pte))
 		return false;
 
-	if (ptep_level && !gstage_pte_leaf(ptep)) {
-		next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+	if (ptep_level && !gstage_pte_leaf(pte)) {
+		next_ptep = (pte_t *)gstage_pte_page_vaddr(pte);
 		next_ptep_level = ptep_level - 1;
 		ret = gstage_level_to_page_size(gstage, next_ptep_level, &next_page_size);
 		if (ret)
-- 
2.52.0

