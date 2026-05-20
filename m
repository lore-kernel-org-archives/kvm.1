Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D73EFFD6;
	Wed, 20 May 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290644; cv=none; b=JuE74A7//aU9nGm+bFq1MGJD5pEVpDLOlOuwXZwT1EHTUFB4PvqTfd3pdQYjX48dTnA0wZ2+pEIp1eB2eC2WesPaIvXoE/RTZu6+fFBsjYAtL0mtdyoMmYF7MaeJU6dTfIBTmFv4CEAcy3m0rE1be/l6gQrm0REu0FYthmcwLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290644; c=relaxed/simple;
	bh=G3Fr4vdUrJW96r8Narcy4lOO2W49gdC191Maz6rHw7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRuOA4uLrx912ONVlALvozQ0h7kg5T3r4SU5ATrGvP9FB2eI966CBHvLW3e0GivfrH6ytW71hMEm7sqEJdjAv66G68q7m51JFC/lPQ+336fSFZ+nnsZQmcWEtu8/8j6OVfPwyhv17w7zIvQvajKqoTaAvk22KKCyflKJp11DjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S6jodwsx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S6jodwsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=od
	Esu4ivXyLhWqfIiJF0LkZTv8IhxJkl47gzx8ElsNs=; b=S6jodwsxcndgSb0jAD
	n6oGNFcijbWgLISH9fFniKQsT77rfB4PAeCGPisPrk7g82gWY9n2CpmJdU2cmMpO
	emUQBV4HCarL30Hhw4VVLiIY1L3JpZDts/ZpHP3VMlWsQutVN52ELdENyuA5Ikfn
	mr0+1JxESly3Po2QQei8W52zs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnt1md0Q1qGHMGCg--.33359S3;
	Wed, 20 May 2026 23:22:09 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm <kvm@vger.kernel.org>,
	kvm-riscv <kvm-riscv@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH 1/3] KVM: riscv: Pass the target size to huge G-stage checks
Date: Wed, 20 May 2026 23:21:46 +0800
Message-ID: <20260520152148.131272-2-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520152148.131272-1-tjytimi@163.com>
References: <20260520152148.131272-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnt1md0Q1qGHMGCg--.33359S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1fKw47JFWxKFWktFyxZrb_yoW5AF1rpF
	47KFs0krWYyr15Ww4SywnrW34rZr4rG34UJa4Utas0yFs8KF12gayDAay5XryYvr93XF47
	uF4avay5u398KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEqg4xUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC0AF68moN0aFatQAA3h

fault_supports_gstage_huge_mapping() already contains the two checks
needed before installing a G-stage block mapping: the userspace address
and GPA must have matching offsets within the block, and the whole block
must be contained within the memslot.

The helper currently hard-codes PMD_SIZE because its only caller is the
transparent hugepage path. The hugetlb path needs the same checks, but
the target block size can be either PMD_SIZE or PUD_SIZE depending on the
hugetlb VMA.

So pass the target mapping size into the helper and use it for the
alignment and bounds checks. This keeps the existing THP PMD behavior
unchanged and prepares the helper to be reused for the following hugetlb
fix.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/kvm/mmu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024..10be8f683 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -286,7 +286,8 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 }
 
 static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
-					       unsigned long hva)
+					       unsigned long hva,
+					       unsigned long map_size)
 {
 	hva_t uaddr_start, uaddr_end;
 	gpa_t gpa_start;
@@ -300,8 +301,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 
 	/*
 	 * Pages belonging to memslots that don't have the same alignment
-	 * within a PMD for userspace and GPA cannot be mapped with g-stage
-	 * PMD entries, because we'll end up mapping the wrong pages.
+	 * within a huge page for userspace and GPA cannot be mapped with
+	 * g-stage block entries, because we'll end up mapping the wrong pages.
 	 *
 	 * Consider a layout like the following:
 	 *
@@ -321,7 +322,7 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 *   e -> g
 	 *   f -> h
 	 */
-	if ((gpa_start & (PMD_SIZE - 1)) != (uaddr_start & (PMD_SIZE - 1)))
+	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
 		return false;
 
 	/*
@@ -336,7 +337,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 * userspace_addr or the base_gfn, as both are equally aligned (per
 	 * the check above) and equally sized.
 	 */
-	return (hva >= ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DOWN(uaddr_end, PMD_SIZE));
+	return (hva & ~(map_size - 1)) >= uaddr_start &&
+	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
 }
 
 static int get_hva_mapping_size(struct kvm *kvm,
@@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 	 * sure that the HVA and GPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (fault_supports_gstage_huge_mapping(memslot, hva)) {
+	if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
 		int sz;
 
 		sz = get_hva_mapping_size(kvm, hva);
-- 
2.43.0

