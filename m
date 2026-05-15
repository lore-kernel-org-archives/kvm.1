Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F483F8717
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861088; cv=none; b=lUVg/2XLnJ0uXWT54KxAxC2UWY1SS3+U7tDtbrx5a0yPTU96EOEXDozPsHuizsOfYQkuPnOOn6MTYbkmUfHzyF0WHqrX0X5odM3lAv/8IsY6iGwSq4uGl1nfQ79fnQDkAq60RGnNL7s4b2BAkWL8pWroy0utZuk9yYfY3S5YC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861088; c=relaxed/simple;
	bh=tG/vwPXG+NgCJqpeTpzbd4mkkNiN98tDPGGb1Pn/dzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anwqmIIQw53/33lVpk6y2RlOpWX1Z+8U9Qk02wrEcESC9cXvhW1A+e0JEDJV8zvdSSUk2eMVXOblSi0Wg3okJEwgLUlVkzQQJ1d8sHr8X5V33S6+9ATjhCArx5hYaajP+t3Ock8l2DD9DRE8kA6hRSKcYaHRGbqoL1OJ/uF54oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1CoDm84; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1CoDm84"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-835386ff122so9047954b3a.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861086; x=1779465886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=P1CoDm841RdLfhufFvZbcH5Z5jYygOD1GqrQNBCa5nC1iV13pRnCLUvq3TQ4kKSyvb
         H2YSnLdPNfAp0JzM8rCnv8Xq3mIVGXKntx47mUWR67PL7ncAaf9XXOxr+xLRjNn+9FSt
         FAik1aD+t6eIHo9/Aex8E9Z6B4mYzRD5SjCFxcjWN+9K8lgRoiBv8m5n99ylxQFa7xTU
         ZJQwKJsJmpw6JYR2/BIFb06LGYbQLtoZBL4CSUW9rVMUCIFKMfdYLqxx4ZhBDLJnifQC
         e/o9hPB2nKda9pIoLdgmMh60ImLCVVHJyK5gX0ztJCX7Lpnqb/X5CWL0WlnOdBYVyxfb
         mozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861086; x=1779465886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dYv7n7MNQFWGtdjlWPVxo0rnA4k4aMTlnbBv8oYiho8=;
        b=msOwVL9gWPqtLMFDPrTc3YIXCRyUrUp1EyriwTVsBm0GszCD7FiV2YJLrGxDSbXSQh
         z3fzlaO4fra6NhC70+028lX6YqrtLdNZ9hkR6JcuOSEsgyFb92tVUQRxURNTwW+wdR9E
         LmZ4b5q2cJ1RxT1d0lU1fPzCthCVkuxsyJl/eiIYlpf36O6t8OvtIUX8g1YVklcdhkp/
         LXfwlAOKW9OVjPdak6M+l7DVvXqKMA8sKeUYXk5cRuauG/1rEjTqcA8am6U2Y8wG2ULu
         y7yT2zqe2E7hdEpZvjymjpE6xqZtQKwfLaUMwzOjQQLeb8B05h/GvZxlxuliWnpJ7mFs
         TjIw==
X-Gm-Message-State: AOJu0YwTTL3tV8sFu11UYAI1pIc1Ixg8no5gDAvD894lLRlCZlyROZSG
	RfFUJzDP3pbu/p1Chu9VLFFQMOVnBcLOl1d+9CdIxUNpAbgWaBf0pQ2HCPXN+460
X-Gm-Gg: Acq92OGwZQ4UPJ8wwqNCzI5XJ1x56s9TW+igHkhoQwDiIdPazzwHFFdopNW9RfsqH2g
	ttM3hSDLg/ptXHQsMte/vXzxHSqqlCmMK+mHN/X2irayI4ZSw8xgi7GaqXfcGk0Y3tzBW8dOm1s
	GMcJ6wgeUFRfwNkzPy7lApaVZOW9a6wuBjotB0RM3Gb9xEexqmcjBFo1Q+EseYou/RLRQRCrWbp
	I8XcuG5DU3DA07jyfiG/R7tU6A222rT8aVWZtag6/eh6oSdyP8UBIHWQe4mZnWhga68amN6y0sh
	l7MG1zvlIv5aqnJ1DD9QSEjCQwMYn9Git0AoKLtTYPinjuN+lfK4bayAN78czHMFIce5KZLK3/o
	lkceMHmDyd3y7vzykGhghE0nTQL/b8DUJ+6GhDtgCBjKOvW0ROg6bF8UvfztfVF8rlWjEbcVw1z
	NJZ61NrlDNy/zNkpV9YGg5Aizw5dMQZQQ91a2JP3r/4yZxWG55NN2W
X-Received: by 2002:a05:6a00:1902:b0:834:ea1a:4b25 with SMTP id d2e1a72fcca58-83f33b2e0c9mr5587593b3a.12.1778861085597;
        Fri, 15 May 2026 09:04:45 -0700 (PDT)
Received: from localhost.localdomain ([171.76.86.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm7920262b3a.49.2026.05.15.09.04.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 09:04:43 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/4] KVM: selftests: Add aligned guest physical page allocator
Date: Fri, 15 May 2026 21:34:21 +0530
Message-ID: <b7977803c6aa382c30db739bfc00e17893eef861.1778857539.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1778857539.git.ritesh.list@gmail.com>
References: <cover.1778857539.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

powerpc will require this to allocate MMU tables in guest memory that
are larger than guest base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3666a8530f31..c515c918c2c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
-			   u32 memslot, bool protected);
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
+			   gpa_t min_gpa, u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
 static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
@@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
+static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
+					     size_t align, gpa_t min_gpa,
+					     u32 memslot)
+{
+	/*
+	 * By default, allocate memory as protected for VMs that support
+	 * protected memory, as the majority of memory for such VMs is
+	 * protected, i.e. using shared memory is effectively opt-in.
+	 */
+	return __vm_phy_pages_alloc(vm, num, align, min_gpa, memslot,
+				    vm_arch_has_protected_memory(vm));
+}
+
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 only).
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2a76eca7029d..cdb004c9ba56 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1442,7 +1442,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva,
 	u64 pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	gpa_t gpa = __vm_phy_pages_alloc(vm, pages,
+	gpa_t gpa = __vm_phy_pages_alloc(vm, pages, 1,
 					   KVM_UTIL_MIN_PFN * vm->page_size,
 					   vm->memslots[type], protected);
 
@@ -2021,7 +2021,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above min_gpa.
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
 			   gpa_t min_gpa, u32 memslot,
 			   bool protected)
 {
@@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = min_gpa >> vm->page_shift;
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical page available, "
+					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+					min_gpa, vm->page_size, memslot);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg) {
-- 
2.39.5

