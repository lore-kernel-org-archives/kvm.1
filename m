Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F856406800
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095695; cv=none; b=sV2T1LC9GYG/SedoN8ADw36M0BwdfEL9u8UIhCoP0WvpnfYVxyLMDL7QHnbH2IxU5hoLTdz2G3KQtjnr4mvuXpi4Ja3K6ZFOeZtt0gIrN2P33s5Fk2gxigddKxWv2vmaMgvu79QiDNtseqj6MxjgmpVlOJpFJsBUtp/DDISAp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095695; c=relaxed/simple;
	bh=iuKoNf2i+PHXWeiokIk7S1PGimD80LQSYGSvE6JQtqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHnPP/0LFdLYlA1gc0pTUlaDEiCY3/7ry5Xqr0by8DKHA812JyTzFNFMKkB0/lpwoz+puZMxq7+gxM/RMGtYkqzKpLt5wfty/JAHlx15Lt64y8TiJwTldRuotErOzSqBNjy8K+vWAd/w6FRkXhVR955WeEdH6dmDzfDZdChMeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYiEpZrL; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYiEpZrL"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso4254011a91.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095694; x=1781700494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqa48U7Zo36zEODVSIgL4W0ts+Mysp9P11byxscZfNU=;
        b=QYiEpZrLAGK0lsO502lzbILUEH8Sf/SQ6Q77HHhhY5H8r8h3iHz6XIJ6NsAl3woWdp
         Y9gJAwvvixAISeA+mEtj/3fqroSvNRK3CmBDSUqKhAC4eYYCxk4EbFN+idx6svllsyll
         WsZWpGFXciQfXQWoza3pQ8JKWcY4dThKmCrAGsQQclpjYnut3/U2xmqGQKek3Rk9haWW
         ThbVBwuh6joyw+q5R+xLx+o8MVm9vYPb7AxD2N0KQJyDwydqVQbkrGdkMs9nD550sv6j
         ghWTa/Hw6mL4aCl8+ZpfnnTA+F1SgSxCI6K3m3RPJ+Ud7sx7rqSJfOtmCcRitlbH4zRK
         ToRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095694; x=1781700494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqa48U7Zo36zEODVSIgL4W0ts+Mysp9P11byxscZfNU=;
        b=E833iLusqSfPJzYh77rK0vsp39kKMPrLkSIB4qMy0TtijlW+ClVuM6LAWQYdPoW593
         P1zG4w7px/6imRPUNQXIZ2jBs7sbh1/Vfp8iArev6hRG8ZxAwVfkClzOnOFM7gcszE6d
         8bnGoNYRMu7XGZrtuTOCRSpsMhHgYiLOpIjzsTAmxMoCNxU9pqJRnJ2ZprnNTI2jMPyl
         zyGAam9xUNpbdBjPaNnwIHMKLkOmwFAIqXmhhmP0OvRTadXY6gjWQgIwA92j8hkrCpy+
         3xyqLKt4bP672zYHrFQIL7GOLOMqyDGYG0qN0dUreGU9oEVrf3+y3WZht3/u0+VKaEgH
         PDHw==
X-Gm-Message-State: AOJu0Yy4ka/HPXDGbt+QVI461u/vb4L0b0krin06qDJm3OIO+leSNj7N
	1fBWWemoyFxcyFn7la5aK/GNcOo2da9lt1swVc/XTtYr4w6o4FC5vadwaiR2Tw==
X-Gm-Gg: Acq92OGZKsFEwxWFOmVelfJ8Fps5MovzQU5FL+vCJYLFzNVzWCH92fAvrriGf+wFup2
	LKpYaCnPBKDyHx/A3YNl4CCl3oChSFwvi2KcQCyKSgKcgO+kCAFmJAn7axubxyKmU4VPZIgIhhg
	8kxOjy8MjT4vtrl/Vl73cCydnxGPJfQ4XJjdRTEQBBVt8OZhxnUTDG9xfGYc7d2QiSfCk5MC9DF
	DMmAPM6fHvy0u02aXfH1MRLT/DrKpoQoZ1U7lK+BEryluExRi5EazOb6d1JVW6hwy+HisUWypYb
	BESsO5vUK4q9FpVgRjaZXn0o57e+trEQBMsbG7RUv9l8sQ9eo1sdEJFIoOW08o/Zj//8hh2vqdV
	GXN4P0pwW0XKrS9+7zR4PhzwTIFK/dtuo/5WoQgbhJ5sRXoRu3JjZ1KcxQnTr7NgUzgaJRHLZbf
	S5S7mi3IZrZJgAFy9doGXwLEZlFmfOQDQamPhaSXyaU5a3UxNT4PCw1KhebWK2YA==
X-Received: by 2002:a17:90b:2706:b0:36b:ad81:c134 with SMTP id 98e67ed59e1d1-370ee928d34mr26496639a91.10.1781095693483;
        Wed, 10 Jun 2026 05:48:13 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 06/10] KVM: PPC: selftests: Use u64 instead of uint64_t
Date: Wed, 10 Jun 2026 18:17:22 +0530
Message-ID: <a09b26fcaceb79693b38af9c6ece9a8a9a4b93a9.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
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
2.50.1 (Apple Git-155)

