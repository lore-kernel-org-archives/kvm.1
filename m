Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65E405C5A
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886243; cv=none; b=qB2wvQWYw+U1+XkVs1a51VK/DA2MOgDiS52nPVvPlozS9opTYsEp63uDFDkIapQR089Fa12A2ok74WXnbc/clZgL/LAVwgqUiob9zZDwoHqtBt8McMyo7FYLJsFfhGZ8oYICQznIQQMF+o9Qgk51swZvclxqkBBvQbvRV2coT8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886243; c=relaxed/simple;
	bh=iGu/jCmUI75IPaNIOyg0/8ZKPNqZvB77qbHSERBa7sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh6Q6CJ698OA+hVJ/MWoNxcfYTAfl+g0zjJLy58EqNb7tLVZmVJmokNq2nanwQt/C4RnMfYR7qTYke3NhQbyUBggkqeZ0ir4DjexEcEmA9UsnH14RS78+J0yq5cPtTx9GqtezCNXzaQPO9Wu3M3J7YKqeUJ66R08/t6+zdeUOuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOaWj63j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOaWj63j"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so85856255ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886241; x=1780491041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4S58wFnVNRvnxdkAeXXsrXJzD1QYgOVb+aOndCv6B0=;
        b=VOaWj63jzj3gjDk38Horm6RGN9AWDXovHZxZUOhYICxN/hghcxtQvpG+0gjnm+7Irq
         DhYLHOVAxBzQPwOmxlkd7N6Dh8BIG2u4JBWyr1sTK3v+tQ3cf9SqjTNxnsT42wZq/LgP
         tJ1yM+c83PK3dgyqooRTaTyX63AqSEkZCIhFTc5MddYqtAPR448HfMNvHx/mMcVrxFo+
         dUmwryJ3hqydlCvuTsC96GTi4gcCr+UAGI7IA90C7cCcq0ut4wiOfdl6/oK3xPIew1KV
         qc8gUuWjlRxIaAHOvOp8wWb8FYxrxN1p9AAbg72CroLItb3iikW8jvE+ZDFqvuKEZJb4
         qDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886241; x=1780491041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4S58wFnVNRvnxdkAeXXsrXJzD1QYgOVb+aOndCv6B0=;
        b=W/c8qnqWeWMVIjLvjOWkhGeGkuZ/bq795R2st+bytlDK//zz1evISszK++NM9DEvRH
         oemI2B3K3SsmNKFoRzRMGMNSB8iybVZiQuOEidluxZVlxnFarVmMIr6R1T5IaKruce+e
         A9rokuTxfRBd7fgDDYpF2kT/K2DsOvxioUyiBAJPLSPuD8IdPxsP/+x7Oia0XnnQCrfq
         2CZ1A+X5nCnjo2O2g5dwhZ1KQJXPy1VOrdaPBgvo+lViRMgXKBbcge7jA4jgk4yNXPdl
         +v2kgPxB7m6CVbY2+40mPHuGtICfxNy7jt/KugcoEtR136GOGP6Qv6cBzK6vlfR/fAAK
         +oaA==
X-Gm-Message-State: AOJu0YynjUM7uPiwojt3+g4lO6ZooZO9hGsAlPnPl8DLuDn8QR76bCNG
	AyJhbQbvv1bxMLietyXk1sKcmyJ4R2DBGh9wbUY6QenFD90aA36w79G/ry6aBw==
X-Gm-Gg: Acq92OGBhjQru96rnbBjk3SPhtJn1QQNoNrCk/RQIwykDMEoXPaC6TyOSDh3UMAVC9h
	WKYb8SuFg3RuhgzDTPXdUQTGRVEMuixqCWdZcdInOHf94M/2xgnluJlxx3lq+Mybp4Hy1i8bce3
	G3gkAkKy22hcC7cqaTNotzg4UHYyatiORY3Sw4k1N1eezBN+YeCJwuxRdTwLP4oORyuvDAItKuK
	/CJzBcdxcCYxAJudz8KEgq+6eE2tODfX1eVdBv38Ekp5FJVciIwQ3ox3L1tQbEbDALgGLJIqjcl
	1zcD0lEdOwacSTxXD1mDvyRTHwg3cuarbrMNeBlBjKKiH3HVhqjuVpg84Ki4jdbUhABH613Fm2Y
	qEeG8/EGQBVClhckQBJwi1tv/luBZoWzFds7GHvkt60pGpNCGR0+WsfHfmjpMAFu/o0BO0kEpK6
	w9CmtHSOqZMOv7eY5pQlc8pJSp2RucLychUwo1R56/kGJYe86PuA==
X-Received: by 2002:a17:903:19e8:b0:2b2:539b:d2b1 with SMTP id d9443c01a7336-2beb0628a12mr256281175ad.16.1779886241233;
        Wed, 27 May 2026 05:50:41 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:40 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 06/10] KVM: PPC: selftests: Use u64 instead of uint64_t
Date: Wed, 27 May 2026 18:19:55 +0530
Message-ID: <0132c8045f8d2718b155eab52e659d9b0a80aefe.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 26f8453288d4c ("KVM: selftests: Use u64 instead of uint64_t")
made this change from uint64_t -> u64 for all other kvm selftests.

Do the same for powerpc as well. No functional changes expected.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../selftests/kvm/include/powerpc/hcall.h     |  6 +--
 .../selftests/kvm/include/powerpc/processor.h | 16 +++----
 .../testing/selftests/kvm/lib/powerpc/hcall.c |  6 +--
 .../selftests/kvm/lib/powerpc/processor.c     | 44 +++++++++----------
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/hcall.h b/tools/testing/selftests/kvm/include/powerpc/hcall.h
index 4028baa6c5d8..f923b3f5e233 100644
--- a/tools/testing/selftests/kvm/include/powerpc/hcall.h
+++ b/tools/testing/selftests/kvm/include/powerpc/hcall.h
@@ -10,8 +10,8 @@
 /* Ucalls use unimplemented PAPR hcall 0 which exits KVM */
 #define H_UCALL	0
 
-int64_t hcall0(uint64_t token);
-int64_t hcall1(uint64_t token, uint64_t arg1);
-int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2);
+int64_t hcall0(u64 token);
+int64_t hcall1(u64 token, u64 arg1);
+int64_t hcall2(u64 token, u64 arg1, u64 arg2);
 
 #endif
diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index cb75b77c33bb..cbbe390ae244 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -15,16 +15,16 @@ struct kvm_vm;
 struct kvm_vcpu;
 
 struct ex_regs {
-	uint64_t	gprs[32];
-	uint64_t	nia;
-	uint64_t	msr;
-	uint64_t	cfar;
-	uint64_t	lr;
-	uint64_t	ctr;
-	uint64_t	xer;
+	u64	gprs[32];
+	u64	nia;
+	u64	msr;
+	u64	cfar;
+	u64	lr;
+	u64	ctr;
+	u64	xer;
 	uint32_t	cr;
 	uint32_t	trap;
-	uint64_t	vaddr; /* vaddr of this struct */
+	u64	vaddr; /* vaddr of this struct */
 };
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/powerpc/hcall.c b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
index efb4318252be..cd10022572a5 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/hcall.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/hcall.c
@@ -5,7 +5,7 @@
 #include "kvm_util.h"
 #include "hcall.h"
 
-int64_t hcall0(uint64_t token)
+int64_t hcall0(u64 token)
 {
 	register uintptr_t r3 asm ("r3") = token;
 
@@ -17,7 +17,7 @@ int64_t hcall0(uint64_t token)
 	return r3;
 }
 
-int64_t hcall1(uint64_t token, uint64_t arg1)
+int64_t hcall1(u64 token, u64 arg1)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
@@ -30,7 +30,7 @@ int64_t hcall1(uint64_t token, uint64_t arg1)
 	return r3;
 }
 
-int64_t hcall2(uint64_t token, uint64_t arg1, uint64_t arg2)
+int64_t hcall2(u64 token, u64 arg1, u64 arg2)
 {
 	register uintptr_t r3 asm ("r3") = token;
 	register uintptr_t r4 asm ("r4") = arg1;
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 9846ec26a32a..ac5c3421ec81 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -14,9 +14,9 @@
 #define RADIX_TREE_SIZE ((0x2UL << 61) | (0x5UL << 5)) /* 52-bits */
 #define RADIX_PGD_INDEX_SIZE 13
 
-static void set_proc_table(struct kvm_vm *vm, int pid, uint64_t dw0, uint64_t dw1)
+static void set_proc_table(struct kvm_vm *vm, int pid, u64 dw0, u64 dw1)
 {
-	uint64_t *proc_table;
+	u64 *proc_table;
 
 	proc_table = addr_gpa2hva(vm, vm->arch.prtb);
 	proc_table[pid * 2 + 0] = cpu_to_be64(dw0);
@@ -81,9 +81,9 @@ static int pt_shift(struct kvm_vm *vm, int level)
 	}
 }
 
-static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
+static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
 {
-	uint64_t size = vm->page_size;
+	u64 size = vm->page_size;
 
 	if (level == 4)
 		return size;
@@ -97,7 +97,7 @@ static uint64_t pt_entry_coverage(struct kvm_vm *vm, int level)
 	return size;
 }
 
-static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
+static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 {
 	switch (level) {
 	case 1:
@@ -128,11 +128,11 @@ static int pt_idx(struct kvm_vm *vm, uint64_t vaddr, int level, uint64_t *nls)
 	}
 }
 
-static uint64_t *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
-			  uint64_t vaddr, int level, uint64_t *nls)
+static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
+			  u64 vaddr, int level, u64 *nls)
 {
 	int idx = pt_idx(vm, vaddr, level, nls);
-	uint64_t *ptep = addr_gpa2hva(vm, pt + idx * 8);
+	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
 
 	return ptep;
 }
@@ -151,7 +151,7 @@ static uint64_t *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
 #define PDE_NLS		0x0000000000000011ull
 #define PDE_PT_MASK	0x0fffffffffffff00ull
 
-static gpa_t __vm_alloc_pt(struct kvm_vm *vm, uint64_t pt_shift)
+static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
 {
 	gpa_t pt;
 
@@ -189,16 +189,16 @@ static gpa_t __vm_alloc_pt(struct kvm_vm *vm, uint64_t pt_shift)
 	return pt;
 }
 
-void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
+void virt_arch_pg_map(struct kvm_vm *vm, u64 gva, u64 gpa)
 {
 	gpa_t pt = vm->mmu.pgd;
-	uint64_t *ptep, pte;
+	u64 *ptep, pte;
 	int level;
 
 	for (level = 1; level <= 3; level++) {
-		uint64_t nls;
-		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
-		uint64_t pde = be64_to_cpu(*pdep);
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
 
 		if (pde) {
 			TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
@@ -227,13 +227,13 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa)
 gpa_t addr_arch_gva2gpa(struct kvm_vm *vm, gva_t gva)
 {
 	gpa_t pt = vm->mmu.pgd;
-	uint64_t *ptep, pte;
+	u64 *ptep, pte;
 	int level;
 
 	for (level = 1; level <= 3; level++) {
-		uint64_t nls;
-		uint64_t *pdep = virt_get_pte(vm, pt, gva, level, &nls);
-		uint64_t pde = be64_to_cpu(*pdep);
+		u64 nls;
+		u64 *pdep = virt_get_pte(vm, pt, gva, level, &nls);
+		u64 pde = be64_to_cpu(*pdep);
 
 		TEST_ASSERT((pde & PDE_VALID) && !(pde & PTE_LEAF),
 			"PDE not present at level: %u gva: 0x%lx pde:0x%lx\n",
@@ -263,8 +263,8 @@ static void virt_dump_pt(FILE *stream, struct kvm_vm *vm, gpa_t pt,
 	size = 1U << (pt_shift(vm, level) + 3);
 
 	for (idx = 0; idx < size; idx += 8, va += pt_entry_coverage(vm, level)) {
-		uint64_t *page_table = addr_gpa2hva(vm, pt + idx);
-		uint64_t pte = be64_to_cpu(*page_table);
+		u64 *page_table = addr_gpa2hva(vm, pt + idx);
+		u64 pte = be64_to_cpu(*page_table);
 
 		if (!(pte & PTE_VALID))
 			continue;
@@ -320,7 +320,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	struct ex_regs *ex_regs;
 	struct kvm_regs regs;
 	struct kvm_vcpu *vcpu;
-	uint64_t lpcr;
+	u64 lpcr;
 
 	stack_vaddr = __vm_alloc(vm, stack_size,
 				       DEFAULT_GUEST_STACK_VADDR_MIN,
@@ -374,7 +374,7 @@ void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 	vcpu_regs_get(vcpu, &regs);
 
 	for (i = 0; i < num; i++)
-		regs.gpr[i + 3] = va_arg(ap, uint64_t);
+		regs.gpr[i + 3] = va_arg(ap, u64);
 
 	vcpu_regs_set(vcpu, &regs);
 	va_end(ap);
-- 
2.39.5

