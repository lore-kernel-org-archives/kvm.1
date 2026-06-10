Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57C40D598
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095666; cv=none; b=DxakZmKEch2o9YkG7gPkUsOzLFvQN3lYGNNhqZ1niVS3JtCYtmkPz5pkSTrGFoIu0wbvonqfbZY5tTNldrA0tG0OONSWzC8R2RMBsz2eALiy3djgLam1sUxu3V8EwofPj7Y0cHZKv/OraRTDUjgZFt3nRYsNg2k0nziBPvvgoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095666; c=relaxed/simple;
	bh=Bk7J3mLs3N7bfIUBu+nSVFQaHOBl7tueImnj0PHHNt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rea2Kea96B0GjqIJfJNIZTaOczQO+NVSsQb7VnbdCXwKtEiAl6CsH7wPEuF4+4dwQ3N/4bVVdJb7xBJQVjktOvXcKVmhODnQWjF2W6ZrJoZ/k2idJ8LdZFV0OfiycGt9EhdNW2oUanmBnrcbmpSyr6eamt7RHX2hs4/Xsj6fQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGCGa5Ub; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGCGa5Ub"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7247947a91.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095664; x=1781700464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1g5wHVLikCWLgdTTQWpgtkBPvcVl9HkkR1GjckPL4Q=;
        b=BGCGa5UbRlkMLk2ILiLpYR6JxRMHolkBQdH0NUlbFgnjDr/hmpoburpog5a6RgGOLy
         CVTe1XL7fudDafXfvtaNd2iHMVYcS7RHq+bed/SKPCHhdhpS9KvUm2FKOsKQQVb1LiY+
         fLQfEQ9bWbKHpSMIf847ZAFrJ3Gg5/rTXWjP7YGYcXTJGr8qf4O7GaRpRxtjaGLPsXGQ
         4hJOENYPsMRoMmrikkJ84OhChvnCRZP7vm23YHdHCNpbDJJGAuIks3VrSOZy5esxP+qE
         7uQ44xwhEPe6d6e8xOucRMxfoS45I3KIECnRb9+C7RKKBbEq87af5C8lrljZ9aQ1hAYy
         C+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095664; x=1781700464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1g5wHVLikCWLgdTTQWpgtkBPvcVl9HkkR1GjckPL4Q=;
        b=iSiAniGpkxMx6l9ZQ4vWcMNCVLTLoSl+e0s4p/bQaEch8+CP5owQhA0zUZ7clAtRa/
         iBspgsvyw0f/YeMcVLQ1Oji1sLGM6+4gmWrO6vqpaafTuW8REdSGha1y6JMRvbKvYpx9
         A+G2CHHwxV+HBKDpmeOnx9wE5ljVfPGLVlgcXXqYl97ecDLqF8Idn1xy+ur4OzPacwKW
         1sgQNnyyyI7j9r2QlsfHab0oLvAJ3yVm4E5K3NrSo1unOyW2QLvmGKdTb0fEbmlPYKfx
         oTZo8ILF2hbjJI5KB/p6aXCnzzxpjHpmLD0++fm9cdPA5f0gd/SqO2nabAIcIX4rIfxI
         injA==
X-Gm-Message-State: AOJu0Yz+k8Z+LxoEp3wJ3pNVDB97tw8XcjiHAoe3vjlC++Gs678icDmo
	yQPES0djZRgkm6hG673f8U2a+0wyy9OwMvcxye46aMdkmbavpVX03HcEr6KcsA==
X-Gm-Gg: Acq92OGThftomY2Z2DI+ZYZFHKxyXvMggFK/0f3Us/VSAGEveENP7jB5l+2naUYtk6K
	PqKohDkgzHEsLgHuAEItafMggQhFxAG4LPl7tqG6N1gtcIuGSw6sJyxmgI90Hbxqu9unAxUOTlZ
	CRmzrcdnifNoYPy6lbWMLTeCu61kwyEk1sSDBEqqk7F99vIlnhLBkPCiJtsrs8HgorNObQ+c1o2
	vIDBdokiOHoxc01e0fte2tZDJoncjS3tkQyXoD1lW+/6Enz+yZGqJMQjjCIlCiJdBYhkUSJ5QHt
	CVXgcllhLGXS69S8xSnH0wUTKiVB7cyJ7yKXNQXxP3R0yI997RJ1KeI7OH6LSb3Gr3enm+xs3nV
	4vwt/vmKM89f5PE128Qv1c6EbH5sdYv3BK1UoGc9ExuKciWuex9snnQhWNiuW2xmBv8MTa6TgNe
	FPeupVE7eljO7mMUEWssu9WIvuO35UmnzKspreXik6C7omKyYLpCbd04nVRLUjDA==
X-Received: by 2002:a17:90b:3d44:b0:368:7c0f:ebf7 with SMTP id 98e67ed59e1d1-370f0095b8amr26453338a91.16.1781095663927;
        Wed, 10 Jun 2026 05:47:43 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:43 -0700 (PDT)
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
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 01/10] KVM: selftests: Move pgd_created check into virt_pgd_alloc
Date: Wed, 10 Jun 2026 18:17:17 +0530
Message-ID: <ece1d2a3bdfa13666b608ce3d65cc166dd7a08e7.1781093720.git.ritesh.list@gmail.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

virt_arch_pgd_alloc all do the same test and set pgd_created. Move
this into common code -
except for x86's virt_arch_pgd_alloc() -> virt_mmu_init() - because this
can also be called from it's tdp_mmu_init() call for setting up it's
stage-2 mmu.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree and removed x86 case]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h        | 5 +++++
 tools/testing/selftests/kvm/lib/arm64/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 ----
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 4 ----
 tools/testing/selftests/kvm/lib/s390/processor.c      | 4 ----
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 2ecaaa0e9965..3666a8530f31 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1197,7 +1197,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm);
 
 static inline void virt_pgd_alloc(struct kvm_vm *vm)
 {
+	if (vm->mmu.pgd_created)
+		return;
+
 	virt_arch_pgd_alloc(vm);
+
+	vm->mmu.pgd_created = true;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
index 01325bf4d36f..498fbcb0ea16 100644
--- a/tools/testing/selftests/kvm/lib/arm64/processor.c
+++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
@@ -112,13 +112,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pgd(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 static void _virt_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 64d91fb76522..207055db5f5d 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -51,9 +51,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	int i;
 	gpa_t child, table;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
@@ -64,7 +61,6 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 		child = table;
 	}
 	vm->mmu.pgd = table;
-	vm->mmu.pgd_created = true;
 }
 
 static int virt_pte_none(u64 *ptep, int level)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..75a5d4c46001 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -66,13 +66,9 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
 	size_t nr_pages = vm_page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size;
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	vm->mmu.pgd = vm_phy_pages_alloc(vm, nr_pages,
 					 KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 					 vm->memslots[MEM_REGION_PT]);
-	vm->mmu.pgd_created = true;
 }
 
 void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index a9adb3782b35..342b7c92463e 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -17,16 +17,12 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	TEST_ASSERT(vm->page_size == PAGE_SIZE, "Unsupported page size: 0x%x",
 		    vm->page_size);
 
-	if (vm->mmu.pgd_created)
-		return;
-
 	gpa = vm_phy_pages_alloc(vm, PAGES_PER_REGION,
 				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, gpa), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	vm->mmu.pgd = gpa;
-	vm->mmu.pgd_created = true;
 }
 
 /*
-- 
2.50.1 (Apple Git-155)

