Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49833B14C1;
	Mon, 29 Jun 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758282; cv=none; b=Jb/sc1ErTzLzI786Aswg4KDSr2ELVaYfAgpQXOX1kheszLedqi7u0B6eZw0cxvzP0wLrf/vfIIWCb3GqXWXrS+GVt0ZZSOdqZCigFw6umYlJRZc2pDyU0VkJrTK6MF0VsiO5ZpEAk6lT1AVsjSftfypGzJauhCIhBLyVnchJA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758282; c=relaxed/simple;
	bh=NUUdWem4jdfYHybxYDShpd9aSYgkjX+85LpntYZtEoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0Zh7HswAooAR/bZayR1voys85DyyUqKNLNh/esXfAThz0c6t4U+Bghj+DITwy50PKJxnuYJWc9JFZKUbH07GIJ2+HbxXXAM7yfjMr03fnYTW8Kf6Jq+hV1wNWQ5PrAUzcuk/haZHKOhAUVp6JTF9/rDtYMeDN+QdtM4ee/w4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7ok4iEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7ok4iEU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC301F00AC4;
	Mon, 29 Jun 2026 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758280;
	bh=7fMOoow4itrcFmGJb1pO1MYeeymB0KqAOuVCXRra+vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D7ok4iEUIJ20WZNpNh9logXwJ9yDxXz7aEZhXqXoz6+la7YAq8ZkYWxy0o23C2pg1
	 A9YgD78QzitY755CyYZ+7/q6VX+w+PZSpRZPaxR2zcSQChlbyLzYJJlZOvphSFCBmq
	 d2/wUr1M4CrVzj0X5SB0Rrox5l4ygMom7ujUxBRn3ijHCZXpYwjNnzrRDaKMt/pO1X
	 5+kpiGc1nOild05oryMtdNsnxMkqG0oKGyC6bhE/ZvSEZhwrb6of/3wO5vxdvPdOTo
	 WkQRcEqKxJ5B08iNVxsgrazV2od0Zbhj1qcTIzkXwHxtSD32xfy1gUvTjhNqFk8wnI
	 srlIBwrZOXN8A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 03/10] KVM: selftests: Use an array for guest_regs (and fix offsets)
Date: Mon, 29 Jun 2026 18:37:38 +0000
Message-ID: <20260629183746.699840-4-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260629183746.699840-1-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The assembly code defined by SAVE_GPR_C uses the wrong offsets for some
registers in guest_regs. For example, the offset of RCX should 0x08 not
0x10. Also, the last offset in the struct (R15) is 0x78, not 0x80, so
the code actually saves and restore beyond the end of gpr64_regs.

Eliminate hardcoded offsets by using an array instead of a struct
(similar to KVM's per-vCPU regs), and use the array index to generate
the offset. While at it, rename SAVE_GPR_C and LOAD_GPR_C to a single
macro, SVM_SWITCH_GPRS_ASM.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     | 36 +++++++-------
 tools/testing/selftests/kvm/lib/x86/svm.c     | 47 ++++++++++---------
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7d3a27bc0d842..535f26e077570 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -396,25 +396,23 @@ static inline unsigned int x86_model(unsigned int eax)
 #define PTE_GET_PA(pte)		((pte) & PHYSICAL_PAGE_MASK)
 #define PTE_GET_PFN(pte)        (PTE_GET_PA(pte) >> PAGE_SHIFT)
 
-/* General Registers in 64-Bit Mode */
-struct gpr64_regs {
-	u64 rax;
-	u64 rcx;
-	u64 rdx;
-	u64 rbx;
-	u64 rsp;
-	u64 rbp;
-	u64 rsi;
-	u64 rdi;
-	u64 r8;
-	u64 r9;
-	u64 r10;
-	u64 r11;
-	u64 r12;
-	u64 r13;
-	u64 r14;
-	u64 r15;
-};
+#define GUEST_REGS_RAX	0
+#define GUEST_REGS_RCX	1
+#define GUEST_REGS_RDX	2
+#define GUEST_REGS_RBX	3
+#define GUEST_REGS_RSP	4
+#define GUEST_REGS_RBP	5
+#define GUEST_REGS_RSI	6
+#define GUEST_REGS_RDI	7
+#define GUEST_REGS_R8	8
+#define GUEST_REGS_R9	9
+#define GUEST_REGS_R10	10
+#define GUEST_REGS_R11	11
+#define GUEST_REGS_R12	12
+#define GUEST_REGS_R13	13
+#define GUEST_REGS_R14	14
+#define GUEST_REGS_R15	15
+#define NR_GUEST_REGS	(GUEST_REGS_R15 + 1)
 
 struct desc64 {
 	u16 limit0;
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 766d15f1d534a..8e392e0451123 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -13,7 +13,7 @@
 
 #define SEV_DEV_PATH "/dev/sev"
 
-struct gpr64_regs guest_regs;
+u64 guest_regs[NR_GUEST_REGS];
 u64 rflags;
 
 /* Allocate memory regions for nested SVM tests.
@@ -125,7 +125,7 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip)
 
 	vmcb->save.rip = (u64)guest_rip;
 	vmcb->save.rsp = (u64)svm->stack;
-	guest_regs.rdi = (u64)svm;
+	guest_regs[GUEST_REGS_RDI] = (u64)svm;
 
 	if (svm->ncr3_gpa) {
 		ctrl->misc_ctl |= SVM_MISC_ENABLE_NP;
@@ -133,31 +133,32 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip)
 	}
 }
 
+#define GUEST_SWITCH_GPR_ASM(reg, idx) \
+	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"
+
 /*
  * save/restore 64-bit general registers except rax, rip, rsp
  * which are directly handed through the VMCB guest processor state
  */
-#define SAVE_GPR_C				\
-	"xchg %%rbx, guest_regs+0x20\n\t"	\
-	"xchg %%rcx, guest_regs+0x10\n\t"	\
-	"xchg %%rdx, guest_regs+0x18\n\t"	\
-	"xchg %%rbp, guest_regs+0x30\n\t"	\
-	"xchg %%rsi, guest_regs+0x38\n\t"	\
-	"xchg %%rdi, guest_regs+0x40\n\t"	\
-	"xchg %%r8,  guest_regs+0x48\n\t"	\
-	"xchg %%r9,  guest_regs+0x50\n\t"	\
-	"xchg %%r10, guest_regs+0x58\n\t"	\
-	"xchg %%r11, guest_regs+0x60\n\t"	\
-	"xchg %%r12, guest_regs+0x68\n\t"	\
-	"xchg %%r13, guest_regs+0x70\n\t"	\
-	"xchg %%r14, guest_regs+0x78\n\t"	\
-	"xchg %%r15, guest_regs+0x80\n\t"
-
-#define LOAD_GPR_C      SAVE_GPR_C
+#define SVM_SWITCH_GPRS_ASM \
+	GUEST_SWITCH_GPR_ASM(rbx, GUEST_REGS_RBX) \
+	GUEST_SWITCH_GPR_ASM(rcx, GUEST_REGS_RCX) \
+	GUEST_SWITCH_GPR_ASM(rdx, GUEST_REGS_RDX) \
+	GUEST_SWITCH_GPR_ASM(rbp, GUEST_REGS_RBP) \
+	GUEST_SWITCH_GPR_ASM(rsi, GUEST_REGS_RSI) \
+	GUEST_SWITCH_GPR_ASM(rdi, GUEST_REGS_RDI) \
+	GUEST_SWITCH_GPR_ASM(r8,  GUEST_REGS_R8)  \
+	GUEST_SWITCH_GPR_ASM(r9,  GUEST_REGS_R9)  \
+	GUEST_SWITCH_GPR_ASM(r10, GUEST_REGS_R10) \
+	GUEST_SWITCH_GPR_ASM(r11, GUEST_REGS_R11) \
+	GUEST_SWITCH_GPR_ASM(r12, GUEST_REGS_R12) \
+	GUEST_SWITCH_GPR_ASM(r13, GUEST_REGS_R13) \
+	GUEST_SWITCH_GPR_ASM(r14, GUEST_REGS_R14) \
+	GUEST_SWITCH_GPR_ASM(r15, GUEST_REGS_R15)
 
 /*
  * selftests do not use interrupts so we dropped clgi/sti/cli/stgi
- * for now. registers involved in LOAD/SAVE_GPR_C are eventually
+ * for now. Registers involved in SVM_SWITCH_GPRS_ASM are eventually
  * unmodified so they do not need to be in the clobber list.
  */
 void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
@@ -168,9 +169,9 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 		"mov %%r15, %[vmcb_rflags]\n\t"
 		"mov %[guest_regs_rax], %%r15\n\t"
 		"mov %%r15, %[vmcb_rax]\n\t"
-		LOAD_GPR_C
+		SVM_SWITCH_GPRS_ASM
 		"vmrun %[vmcb_gpa]\n\t"
-		SAVE_GPR_C
+		SVM_SWITCH_GPRS_ASM
 		"mov %[vmcb_rflags], %%r15\n\t"
 		"mov %%r15, rflags\n\t"
 		"mov %[vmcb_rax], %%r15\n\t"	// rax
@@ -178,7 +179,7 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 		"vmsave %[vmcb_gpa]\n\t"
 		: [vmcb_rflags] "+m" (vmcb->save.rflags),
 		  [vmcb_rax] "+m" (vmcb->save.rax),
-		  [guest_regs_rax] "+rm" (guest_regs.rax)
+		  [guest_regs_rax] "+rm" (guest_regs[GUEST_REGS_RAX])
 		: [vmcb_gpa] "a" (vmcb_gpa)
 		: "r15", "memory");
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

