Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC33403E9A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095717; cv=none; b=nOo0TQX5kNlsZhZ2iWlv8yuxTk6y99EYnZaeMKmgM/ezeKcOgkH+ppfQ5GL0HET6HdCLBWWTVy/io3Ea/8URkrOv4Nkzgr4GM4jvsBz7BfkBRn5msE3W9Ykd6F3pP9DgCriK2EkX6ObypRC4dqwAFPqq50wtCY3hkw2BlI5ItNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095717; c=relaxed/simple;
	bh=7wV4425Ik6VmbZw8mS9ERhskIFF8KLOKmoKc5i15TOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFGzSKGeWRsPWuPF4IVE3uVcAPor1ZaiIxZzTqeHuWX4ln5Y+Q4iPS3f4GkZ+iN+GOCFkz5by/AkYD7Ult7i/VMgvuPcAU+SCApPmTpZWflFtUBKKfkwXmilsGgh7nhFv/jjkXIcLxR6J6x96tAinv7bWeF38weswADg7fGb33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ3ueX5g; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ3ueX5g"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso5939110a91.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095716; x=1781700516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9BiimjFi0aXMRD8saAolcJy9dKWyzjah+ENtioga50=;
        b=UZ3ueX5g1tECmiQTekl63YG4uxnbaZ5Ruja4oBxSC/TyyT9mu0AEIvsnWzSFtm0kVu
         r4z7Q/N416FOxEo7DOUpm1q84P9vJp+xoH6mNSCPC+1B1mLTFtA327bAel7Wt//F6iXD
         KiAn5kZeRZbexUauobIXQsF1pfPDx+z7lUSFL72a5ZdRJgCWeLDo98vwuNLRFdBtKhjl
         2olNXw769sv1uutWsUTR8e8prLaYHBVqgzNTUiRrsh/TMJaWliR/ee4xpRk9ARMLFjnY
         XB9QTrso/RsR+qlbRrmLcvvMagnbimnHoiv3q/MBduL1cRvYEn7GYhLXs5X2H3v4jCqv
         rX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095716; x=1781700516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9BiimjFi0aXMRD8saAolcJy9dKWyzjah+ENtioga50=;
        b=KQtNxOiNQpqAYfaXotJ1nCpz+ls6gO9b4HsW9/TCaqjoZau7saOlHqStzDvONG9MlU
         CvU3Fg863NIyLyssWxS24A+7fcgLlh8DYO784oJCHFLzg/Td/wiAXx8C+SolVSYKWhV0
         UsslhNRIWIkVMA5T3KeU4SEt9cI6b2DxN1BnbQv+y9X1O04iEdF0v/XD0kd2VmJeTyji
         tqnlCZD8wkt3UpKLVLuyQpndgsTHQUDKq7YEOsUwwqkJxw14F59UEjq63INTVE82gdZn
         upe7kg3MLA6FJF38hnVcvpL70Vp75pnAcf9JK30IGm4aLkWho0UJKZkc7XQmy8fC/Fdp
         A68g==
X-Gm-Message-State: AOJu0YxRO/1ZxwxE5VsaYJhK5nyA9Trj4OPGwnVo3jRuuYAUbwiU7vnD
	gmzZgv7kubsXqdaq+BQbzVt1LApV6ojD1RVM+d6nknYv+UFc58dbHip0Y/5W3A==
X-Gm-Gg: Acq92OEWKT1jECtdbYVibZlif+96RV5/jiGi79t47saeFL6o43m7IknGb/IXM0RkQlE
	U81XUVjHM+OYBxTSguX6dpIP7oVKFugpCaGEPFQz++ij2/LNwW6BIhXX3pEp5hpvvsF7hrAVx4M
	Hecw9LFq25nOpAv2M+dB1dOvqlyCw6Wk3sSfraQjS5YQNG4GnmFAU96PGEPwIuMmWt3A8mPsW2n
	2VF4BvzjWg9vrq/2NTLQqulDkGT8ZcHwwib4ta33DI24mgV+2GR86mwJQwNtHLu9tShdE8ot2Gt
	btZG6HOpUzo1L+ZpMExjy8Zsr1Xo+eGMSsPVdoyba4SyIwBncNp9bMnxkgmwWYBdjFpxlA2n8Ne
	XvFcm797TmE8zUeR0WDW4z2R4FkggFXYua44lHQ1lnxSd5+78XfE1vFxtuoUuqM5dj+IK5h+MYK
	9R+05yaimzBxDEUh4UYOlqlxAxdbxUlHlPo4egw8lli/mNF04ALjYLblqKjrmQpCi7eWLmWR7s
X-Received: by 2002:a17:90b:1350:b0:366:4782:1379 with SMTP id 98e67ed59e1d1-370f0f459d1mr26153514a91.24.1781095716002;
        Wed, 10 Jun 2026 05:48:36 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.48.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:48:35 -0700 (PDT)
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
Subject: [PATCH v3 RESEND 10/10] KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and gva_t
Date: Wed, 10 Jun 2026 18:17:26 +0530
Message-ID: <2acdd4984130cc5b66ab6cdbdb8bdfee193838c2.1781093720.git.ritesh.list@gmail.com>
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

commit df079910f9814 ("KVM: selftests: Replace "u64 gpa" with "gpa_t" throughout")
commit 014dfb7b9bf3f ("KVM: selftests: Replace "vaddr" with "gva" throughout")

Similar to above 2 commits, this patch makes the relevant changes to
powerpc kvm selftests code to make use of gpa_t and gva_t types instead
of u64 throughout the code.

No functional change intended.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../selftests/kvm/include/powerpc/processor.h |  3 ++-
 .../selftests/kvm/lib/powerpc/processor.c     | 20 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/powerpc/processor.h b/tools/testing/selftests/kvm/include/powerpc/processor.h
index 95ec3debc83c..f0ee21a8e2d4 100644
--- a/tools/testing/selftests/kvm/include/powerpc/processor.h
+++ b/tools/testing/selftests/kvm/include/powerpc/processor.h
@@ -7,6 +7,7 @@
 
 #include <linux/compiler.h>
 #include "ppc_asm.h"
+#include "kvm_util_types.h"
 
 extern unsigned char __interrupts_start[];
 extern unsigned char __interrupts_end[];
@@ -24,7 +25,7 @@ struct ex_regs {
 	u64	xer;
 	u32	cr;
 	u32	trap;
-	u64	vaddr; /* vaddr of this struct */
+	gva_t	gva; /* gva of this struct */
 };
 
 void vm_install_exception_handler(struct kvm_vm *vm, int vector,
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
index 2c1e95c8aa9c..009a0859ba05 100644
--- a/tools/testing/selftests/kvm/lib/powerpc/processor.c
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -97,17 +97,17 @@ static u64 pt_entry_coverage(struct kvm_vm *vm, int level)
 	return size;
 }
 
-static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
+static int pt_idx(struct kvm_vm *vm, gva_t gva, int level, u64 *nls)
 {
 	switch (level) {
 	case 1:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 39) & 0x1fff;
+		return (gva >> 39) & 0x1fff;
 	case 2:
 		if (nls)
 			*nls = 0x9;
-		return (vaddr >> 30) & 0x1ff;
+		return (gva >> 30) & 0x1ff;
 	case 3:
 		if (vm->mode == VM_MODE_P52V52_4K) {
 			if (nls)
@@ -116,12 +116,12 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 			if (nls)
 				*nls = 0x5;
 		}
-		return (vaddr >> 21) & 0x1ff;
+		return (gva >> 21) & 0x1ff;
 	case 4:
 		if (vm->mode == VM_MODE_P52V52_4K)
-			return (vaddr >> 12) & 0x1ff;
+			return (gva >> 12) & 0x1ff;
 		else /* vm->mode == VM_MODE_P52V52_64K */
-			return (vaddr >> 16) & 0x1f;
+			return (gva >> 16) & 0x1f;
 	default:
 		TEST_ASSERT(false, "Invalid page table level %d\n", level);
 		return 0;
@@ -129,9 +129,9 @@ static int pt_idx(struct kvm_vm *vm, u64 vaddr, int level, u64 *nls)
 }
 
 static u64 *virt_get_pte(struct kvm_vm *vm, gpa_t pt,
-			  u64 vaddr, int level, u64 *nls)
+			  gva_t gva, int level, u64 *nls)
 {
-	int idx = pt_idx(vm, vaddr, level, nls);
+	int idx = pt_idx(vm, gva, level, nls);
 	u64 *ptep = addr_gpa2hva(vm, pt + idx * 8);
 
 	return ptep;
@@ -189,7 +189,7 @@ static gpa_t __vm_alloc_pt(struct kvm_vm *vm, u64 pt_shift)
 	return pt;
 }
 
-void virt_arch_pg_map(struct kvm_vm *vm, u64 gva, u64 gpa)
+void virt_arch_pg_map(struct kvm_vm *vm, gva_t gva, gpa_t gpa)
 {
 	gpa_t pt = vm->mmu.pgd;
 	u64 *ptep, pte;
@@ -331,7 +331,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 				       MEM_REGION_DATA);
 	ex_regs_paddr = addr_gva2gpa(vm, ex_regs_vaddr);
 	ex_regs = addr_gpa2hva(vm, ex_regs_paddr);
-	ex_regs->vaddr = ex_regs_vaddr;
+	ex_regs->gva = ex_regs_vaddr;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
 
-- 
2.50.1 (Apple Git-155)

