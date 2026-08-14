Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8244BC92
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705093; cv=none; b=AZDxaeIYeCVw1zQYQ6rubdItmpRbpZFTO286qy45p6VDLyb6NYEWOLPzivTlHMi2CXnilCBQLMA+lqKF3s7iiaNlHUYzeuI47fmL7GLFVDu8c8Tk+VXpN7V0BtUM90+cDxi4WQOWPlCgNbraiX+0WatZKiWxO7u2xauqtE372pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705093; c=relaxed/simple;
	bh=BN80hJUPahMuBoWkUclOUZnV69Dkfc+SFkZgjZJXao0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZjFltP+tW/6kM+OaFU0wfdhlTdd/bFDP+P6C4AEe5xWqctPCJfDfAJrQKccB6QzNTstx15JHEKFeDs1Zw/eBErIOUT+CS+t0Xkn/bFGDTqWdWbNUK13mMMdWFpO2WInjS9JZGGcukAK8iIT8gdhhDiVVFv1QxdYsGEL+ZnQa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifNmiy6Q; arc=none smtp.client-ip=91.218.175.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifNmiy6Q"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BN80hJUPahMuBoWkUclOUZnV69Dkfc+SFkZgjZJXao0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786705085; v=1; x=1787309885;
 b=ifNmiy6Q3Bv6W8Sy3llrNgWtYfS9IFotfXylgutWgBBeRPB28+JBYoLw24rRURDc1ed+o/d3
 1IuTtfBmD5ruma5YmlrMte9Pv/+ERChHQLbKbCVrUtMXs8plPkOOudz+HP2NPBNAOeOwwpp2z+0
 zzeIaslwLzG7NU4gkJkqlZVY=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id 50b76cf9531200b1;
	Fri, 14 Aug 2026 10:58:05 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] KVM: riscv: Avoid overwriting existing G-stage tables with huge leaves
Date: Fri, 14 Aug 2026 06:57:52 -0400
Message-ID: <20260814105752.565325-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V KVM can overwrite an existing G-stage table entry when installing
a huge leaf mapping. If the target huge range already has a lower-level
page table, kvm_riscv_gstage_set_pte() can replace the non-leaf entry
with a leaf PTE. This disconnects the lower-level page table and can
change guest-visible mappings or leak the page-table page.

Reject replacing a valid non-leaf PTE with a leaf PTE. If huge-page
installation hits such a conflict, fall back to a 4K mapping for the
faulting GPA and leave the existing page-table structure intact.

Suggested-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 arch/riscv/kvm/gstage.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef..23cb35e36073 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -174,6 +174,12 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 
 	if (pte_val(*ptep) != pte_val(map->pte)) {
 		bool was_invalid = !pte_val(*ptep);
+
+		/* Avoid replacing an existing lower-level table with a leaf mapping. */
+		if (!gstage_pte_leaf(ptep) && !was_invalid &&
+		    gstage_pte_leaf(&map->pte))
+			return -EEXIST;
+
 		set_pte(ptep, map->pte);
 		if (gstage_pte_leaf(ptep) &&
 		    !(was_invalid && riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)))
@@ -211,12 +217,13 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_gstage_mapping *out_map)
 {
 	bool found_leaf;
+	phys_addr_t huge_page_offset;
 	u32 ptep_level;
 	pgprot_t prot;
 	pte_t *ptep;
 	int ret;
 
-	out_map->addr = gpa;
+	out_map->addr = gpa & PAGE_MASK;
 	out_map->level = 0;
 
 	ret = gstage_page_size_to_level(gstage, page_size, &out_map->level);
@@ -287,7 +294,18 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 	out_map->pte = pfn_pte(PFN_DOWN(hpa), prot);
 	out_map->pte = pte_mkdirty(out_map->pte);
 
-	return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
+	ret = kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
+	if (ret == -EEXIST) {
+		huge_page_offset = out_map->addr & (page_size - 1);
+		hpa += huge_page_offset;
+		out_map->level = 0;
+		out_map->pte = pfn_pte(PFN_DOWN(hpa), prot);
+		out_map->pte = pte_mkdirty(out_map->pte);
+
+		ret = kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
+	}
+
+	return ret;
 }
 
 static inline unsigned long make_child_pte(unsigned long huge_pte, int index,
-- 
2.43.0

