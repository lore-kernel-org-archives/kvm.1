Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA54BEE57;
	Fri, 11 Sep 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163045; cv=none; b=DkAVwliNiOEUIsVZOgjtu7SAgzLYVw5fI7XxDUu2RI67llILLCWfQFwcpJiWLyYcTm46snhftlXwTa6UhPHB2pAJ3CSRWF9/b0PtlMx+QTDEuWt6JBNHGNZruUG2Tr3Wdx24q76tzAROkZotJY2h+wjiiZl64foD5fC9lKxTSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163045; c=relaxed/simple;
	bh=LmGadgze0iyyl8KmfsawwtBrbsoXIrl6uQyMW4y3r3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCqDA/jbZlUhX9QZH7ey5hplgGCqIc69oEt6CWOwg4TALWE6NKMRpwRsVBYERVovjo1VBp4jNx43KQCK4FC4XJ6SPxwtpnuEAXonvT5bPklnfJStTeYYYYC8R79EK9We6D/4Osneh8FBvyzjApRZhsvUWWlF3/KlbHN8ovN5XjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9b2m6EZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9b2m6EZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163043; x=1820699043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmGadgze0iyyl8KmfsawwtBrbsoXIrl6uQyMW4y3r3w=;
  b=Z9b2m6EZuym78oVOD8Om+0C0bzQaymYMQOi+CnkF0snD73YurPt8MLoO
   QjGOFk9RsDjS0HDjzns9dIhLk9uzyBQaTsJuUsysmzKH794Ftn9RnCtEc
   4lo3Bhr5YAv7DrYYnUL8hb1oePisXh+Uln5EKNB47N3ddf12QjVyjuxNu
   KXf0vi7FlTEISyjxeHtbvFfAz3fvuU79FSKVPAyDXpBFwWtI3WiRFJn5w
   Y1/s3mPag/HOycV0vnTGcfczbFQHs13xtSgmmCp6BPA3EsC85d5YcTr5b
   GSNqj3NkggVJ5+ZT2PiXD/AgkGCvi6wSGTlYQ6+zkTBI8DhgozlugQvfv
   g==;
X-CSE-ConnectionGUID: Bs34d6RqQkmpeU+iTaKcTA==
X-CSE-MsgGUID: z80VRbzwQ1SFMMPlk/YUSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572951"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572951"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:44:02 -0700
X-CSE-ConnectionGUID: okdgUtZUQJm5ZcdU0+n7zA==
X-CSE-MsgGUID: IDGTdOTqTxa49fLmP4obww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004440"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:44:01 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 27/28] KVM: selftests: Add a new VM guest mode to run user level code
Date: Fri, 11 Sep 2026 14:36:57 -0700
Message-ID: <20260911213659.2025974-28-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add a new VM guest mode VM_MODE_PXXV48_4K_USER to set the user bit of
guest page table entries, thus allow user level code to run in guests.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Treat as new patch (last posted in v2).
---
 tools/testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c      |  5 ++++-
 tools/testing/selftests/kvm/lib/x86/processor.c | 16 ++++++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5a7a455b5387..981adfcbd5fa 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -191,6 +191,7 @@ enum vm_guest_mode {
 	VM_MODE_P40V48_16K,
 	VM_MODE_P40V48_64K,
 	VM_MODE_PXXVYY_4K,	/* For 48-bit or 57-bit VA, depending on host support */
+	VM_MODE_PXXVYY_4K_USER,	/* For 48bits VA but ANY bits PA with USER bit set */
 	VM_MODE_P47V64_4K,
 	VM_MODE_P44V64_4K,
 	VM_MODE_P36V48_4K,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9ddc047d5c27..e79fddedaf39 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -210,6 +210,7 @@ const char *vm_guest_mode_string(u32 i)
 		[VM_MODE_P40V48_16K]	= "PA-bits:40,  VA-bits:48, 16K pages",
 		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
 		[VM_MODE_PXXVYY_4K]	= "PA-bits:ANY, VA-bits:48 or 57, 4K pages",
+		[VM_MODE_PXXVYY_4K_USER]= "PA-bits:ANY, VA-bits:48,  4K user pages",
 		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
 		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
@@ -246,6 +247,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P40V48_16K]	= { 40, 48,  0x4000, 14 },
 	[VM_MODE_P40V48_64K]	= { 40, 48, 0x10000, 16 },
 	[VM_MODE_PXXVYY_4K]	= {  0,  0,  0x1000, 12 },
+	[VM_MODE_PXXVYY_4K_USER]= {  0,  0,  0x1000, 12 },
 	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
 	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
@@ -337,6 +339,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 		vm->mmu.pgtable_levels = 3;
 		break;
 	case VM_MODE_PXXVYY_4K:
+	case VM_MODE_PXXVYY_4K_USER:
 #ifdef __x86_64__
 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
 		kvm_init_vm_address_properties(vm);
@@ -355,7 +358,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 			vm->mmu.pgtable_levels = 4;
 		}
 #else
-		TEST_FAIL("VM_MODE_PXXVYY_4K not supported on non-x86 platforms");
+		TEST_FAIL("VM_MODE_PXXVYY_4K(_USER) not supported on non-x86 platforms");
 #endif
 		break;
 	case VM_MODE_P47V64_4K:
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index d31fa81ea075..51d713c4c9de 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -167,6 +167,9 @@ bool kvm_is_tdp_enabled(void)
 static void virt_mmu_init(struct kvm_vm *vm, struct kvm_mmu *mmu,
 			  struct pte_masks *pte_masks)
 {
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K || vm->mode == VM_MODE_PXXVYY_4K_USER,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
+
 	/* If needed, create the top-level page table. */
 	if (!mmu->pgd_created) {
 		mmu->pgd = vm_alloc_page_table(vm);
@@ -181,7 +184,7 @@ static void virt_mmu_init(struct kvm_vm *vm, struct kvm_mmu *mmu,
 
 void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
-	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K || vm->mode == VM_MODE_PXXVYY_4K_USER,
 		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	struct pte_masks pte_masks = (struct pte_masks){
@@ -239,6 +242,8 @@ static u64 *virt_create_upper_pte(struct kvm_vm *vm,
 		*pte = PTE_PRESENT_MASK(mmu) | PTE_READABLE_MASK(mmu) |
 		       PTE_WRITABLE_MASK(mmu) | PTE_EXECUTABLE_MASK(mmu) |
 		       PTE_ALWAYS_SET_MASK(mmu);
+		if (vm->mode == VM_MODE_PXXVYY_4K_USER)
+			*pte |= PTE_USER_MASK(mmu);
 		if (current_level == target_level)
 			*pte |= PTE_HUGE_MASK(mmu) | (gpa & PHYSICAL_PAGE_MASK);
 		else
@@ -266,7 +271,7 @@ void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
 	u64 *pte = &mmu->pgd;
 	int current_level;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K || vm->mode == VM_MODE_PXXVYY_4K_USER,
 		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((gva % pg_size) == 0,
@@ -316,6 +321,9 @@ void __virt_pg_map(struct kvm_vm *vm, struct kvm_mmu *mmu, gva_t gva,
 		*pte |= PTE_C_BIT_MASK(mmu);
 	else
 		*pte |= PTE_S_BIT_MASK(mmu);
+
+	if (vm->mode == VM_MODE_PXXVYY_4K_USER)
+		*pte |= PTE_USER_MASK(mmu);
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
@@ -372,7 +380,7 @@ static u64 *__vm_get_page_table_entry(struct kvm_vm *vm,
 	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level <= mmu->pgtable_levels,
 		    "Invalid PG_LEVEL_* '%d'", *level);
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K || vm->mode == VM_MODE_PXXVYY_4K_USER,
 		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid, (gva >> vm->page_shift)),
 		    "Invalid virtual address, gva: 0x%lx", gva);
@@ -645,7 +653,7 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K,
+	TEST_ASSERT(vm->mode == VM_MODE_PXXVYY_4K || vm->mode == VM_MODE_PXXVYY_4K_USER,
 		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	/* Set mode specific system register values. */
-- 
2.43.0

