Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2203F20ED;
	Mon, 14 Sep 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371090; cv=none; b=OkGv8OQL81aONa5xreSadIoRm6B7ALONBKRZndrefw1z50zD87ID1XssD9rKsERjgvqbf8B1ZX1EqIb+FD/9DliHfA1iuzfN/i+zirkAM1FydDFlZwNhJLsMOtCmYE06gn7IqLlCiTOGUlr/OGa7InRzWwo9zmJbsBSqce4ni6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371090; c=relaxed/simple;
	bh=mjC5aEg0jr+yXeG0sa/LeF7keN1owrxkWF90cvUI0lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ubfvHzz12+A7MZQDAqmocaufAeenIjs0eDcIgzKSb5D5L+LUaAsZiPRFOYRhaGAzm4B5knb9h2xnE4RHXbHZg1c+PdaJYe/HqjkqQmt80cbsHuWmw6T6g+/sYL7LTYeLy0XZQuYSyWmEAKnGxSQjRoVZebQkhfQruWG9uVZG6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eZgoxz9H; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eZgoxz9H"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1789371089; x=1820907089;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mjC5aEg0jr+yXeG0sa/LeF7keN1owrxkWF90cvUI0lo=;
  b=eZgoxz9HPxqojfklsB7diHfbJ0HnaQ6E1vh5ZJe777//zBNK2PqWgFUA
   9bjIjx+xquHYyY2PtJN6kXZBFq3zBIqcCqXmy50jofg7ZG0Lbg9i4fGTh
   lftib/UlO60p2ZJO/P7EfT4wqfgW7iRQ/34BzL4wcyrMo8wFjd7Phg0oP
   XY+3NK/oCAtZi3wDGVIPL+Z65UsUvobr0T53cB0fUtS4m8PZyPOB24Q+C
   K8BS7qxf1EMjrq5JuFzfpzRDERj+SFjPyzH7JglfOb3kqEsMDDh2n0M2q
   It7YvChHFA/6ovFKu6lcrlV+HY/6QQp3nbwz1cAaj2+bqhW5Wr3OkoyjV
   w==;
X-CSE-ConnectionGUID: lEYQd/CUTa60tgM6vXYUtg==
X-CSE-MsgGUID: j2OXDkbZQlObKG5BXGmuEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="254977303"
X-IronPort-AV: E=Sophos;i="6.27,102,1786978800"; 
   d="scan'208";a="254977303"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 16:31:10 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id D8A65100036D;
	Mon, 14 Sep 2026 07:31:08 +0000 (UTC)
Received: from az2nlsmom2.o.css.fujitsu.com (unknown [10.150.26.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 881401800BFA;
	Mon, 14 Sep 2026 07:31:08 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom2.o.css.fujitsu.com (Postfix) with ESMTP id C44B118002FD;
	Mon, 14 Sep 2026 07:31:02 +0000 (UTC)
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Date: Mon, 14 Sep 2026 16:30:44 +0900
Subject: [PATCH v2 1/3] KVM: arm64: selftests: Support five-level stage-1
 page tables
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-arm64-52bit-va-v2-1-3911cb9d4ad4@fujitsu.com>
References: <20260914-arm64-52bit-va-v2-0-3911cb9d4ad4@fujitsu.com>
In-Reply-To: <20260914-arm64-52bit-va-v2-0-3911cb9d4ad4@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
 Takayuki Okamoto <tokamoto@fujitsu.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789371056; l=4541;
 i=itaru.kitayama@fujitsu.com; s=20260825; h=from:subject:message-id;
 bh=mjC5aEg0jr+yXeG0sa/LeF7keN1owrxkWF90cvUI0lo=;
 b=7DfFUkA8aXGMtM/DD1jgfw6RcVdnLoUN1N2f+Gph7TODeSPeczCqvGITFCrwbSXP0Q82ddjs5
 9kdbQI1rnOoA3MR8zsljCryu3P+Bnkrq1SgP+zofWwoU+upUoMsOOu+
X-Developer-Key: i=itaru.kitayama@fujitsu.com; a=ed25519;
 pk=g9bTnr9giRP7JwNSZHy+OMLQZBEUtSE9tUnXso0hH1Y=

Add support for populating and walking five-level stage-1 page tables.
A five-level translation starts at architectural level -1, so extend
the page-table helpers and level validation accordingly.

This enables the page-table infrastructure required by 52-bit VA
configurations using the 4K translation granule.

Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Reviewed-by: Takayuki Okamoto <tokamoto@fujitsu.com>
---
 .../selftests/kvm/include/arm64/processor.h        |  1 +
 tools/testing/selftests/kvm/lib/arm64/processor.c  | 45 +++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/arm64/processor.h b/tools/testing/selftests/kvm/include/arm64/processor.h
index b8a902ba8573..7457503df956 100644
--- a/tools/testing/selftests/kvm/include/arm64/processor.h
+++ b/tools/testing/selftests/kvm/include/arm64/processor.h
@@ -113,6 +113,7 @@
 
 #define PTE_VALID		BIT(0)
 #define PGD_TYPE_TABLE		BIT(1)
+#define P4D_TYPE_TABLE		BIT(1)
 #define PUD_TYPE_TABLE		BIT(1)
 #define PMD_TYPE_TABLE		BIT(1)
 #define PTE_TYPE_PAGE		BIT(1)
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 01325bf4d36f..b589368bf822 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -29,13 +29,25 @@ static u64 pgd_index(struct kvm_vm *vm, gva_t gva)
 	return (gva >> shift) & mask;
 }
 
+static u64 p4d_index(struct kvm_vm *vm, gva_t gva)
+{
+	unsigned int shift = 3 * (vm->page_shift - 3) + vm->page_shift;
+	u64 mask = (1UL << (vm->page_shift - 3)) - 1;
+
+	TEST_ASSERT(vm->mmu.pgtable_levels == 5,
+		    "Mode %d does not have 5 page table levels", vm->mode);
+
+	return (gva >> shift) & mask;
+}
+
 static u64 pud_index(struct kvm_vm *vm, gva_t gva)
 {
 	unsigned int shift = 2 * (vm->page_shift - 3) + vm->page_shift;
 	u64 mask = (1UL << (vm->page_shift - 3)) - 1;
 
-	TEST_ASSERT(vm->mmu.pgtable_levels == 4,
-		"Mode %d does not have 4 page table levels", vm->mode);
+	TEST_ASSERT(vm->mmu.pgtable_levels >= 4,
+		    "Mode %d does not have >= 4 page table levels",
+		    vm->mode);
 
 	return (gva >> shift) & mask;
 }
@@ -147,6 +159,12 @@ static void _virt_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
 				 PGD_TYPE_TABLE | PTE_VALID);
 
 	switch (vm->mmu.pgtable_levels) {
+	case 5:
+		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + p4d_index(vm, gva) * 8;
+		if (!*ptep)
+			*ptep = addr_pte(vm, vm_alloc_page_table(vm),
+					 P4D_TYPE_TABLE | PTE_VALID);
+		/* fall through */
 	case 4:
 		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + pud_index(vm, gva) * 8;
 		if (!*ptep)
@@ -163,7 +181,7 @@ static void _virt_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
 		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + pte_index(vm, gva) * 8;
 		break;
 	default:
-		TEST_FAIL("Page table levels must be 2, 3, or 4");
+		TEST_FAIL("Page table levels must be 2, 3, 4, or 5");
 	}
 
 	pg_attr = PTE_AF | PTE_ATTRINDX(attr_idx) | PTE_TYPE_PAGE | PTE_VALID;
@@ -182,18 +200,35 @@ void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
 
 u64 *virt_get_pte_hva_at_level(struct kvm_vm *vm, gva_t gva, int level)
 {
+	int start_level = 4 - vm->mmu.pgtable_levels;
 	u64 *ptep;
 
+	TEST_ASSERT(level >= start_level && level <= 3,
+		    "Invalid translation level %d, valid range is %d-3",
+		    level, start_level);
+
 	if (!vm->mmu.pgd_created)
 		goto unmapped_gva;
 
 	ptep = addr_gpa2hva(vm, vm->mmu.pgd) + pgd_index(vm, gva) * 8;
 	if (!ptep)
 		goto unmapped_gva;
-	if (level == 0)
+	/*
+	 * Stage-1 translation starts at level -1 for a five-level page
+	 * table, and at levels 0, 1, or 2 for four-, three-, or two-level
+	 * page tables, respectively.
+	 */
+	if (level == start_level)
 		return ptep;
 
 	switch (vm->mmu.pgtable_levels) {
+	case 5:
+		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + p4d_index(vm, gva) * 8;
+		if (!ptep)
+			goto unmapped_gva;
+		if (level == 0)
+			break;
+		/* fall through */
 	case 4:
 		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) + pud_index(vm, gva) * 8;
 		if (!ptep)
@@ -214,7 +249,7 @@ u64 *virt_get_pte_hva_at_level(struct kvm_vm *vm, gva_t gva, int level)
 			goto unmapped_gva;
 		break;
 	default:
-		TEST_FAIL("Page table levels must be 2, 3, or 4");
+		TEST_FAIL("Page table levels must be 2, 3, 4, or 5");
 	}
 
 	return ptep;

-- 
2.43.0

