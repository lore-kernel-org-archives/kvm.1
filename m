Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C63CCFBD
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792711; cv=none; b=rxQEI8vflRw9h81/82Anc6Aa7U6G1xwMgrf7/B56835AaqJ3F/cgX+TzL99yZRvDqK2NI36i2WK2e6SkBAXBgHfFa878oDGoL3Z+kgRYINXTjpOl+U3rT/HYjJJcIh1daq9Ld565I9ZDaiEi1+U32x9PcFPFgQa6XOVGQhbuVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792711; c=relaxed/simple;
	bh=zuQQPL0jLayud4XeZt4s47Xtt6vGaXY03T9t3dnnr9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZA5ZY/VHf+mFdo2Zb+nSx+3EqTBDwrXT1pkgSQt2mMwvgEASkKe5isj+fxkxj2zr94uofs3tAJjE8mGlaU5qeMkK/XhVA9ODuDd1UlhUcIk5sFaS+EBV6P1TiRsQUdOrWrW6ITVkLRcwVZxouRMIizJ/c5LNLr2rNDdHAOs9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvsEYyhD; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvsEYyhD"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83544d05c5aso4531022b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792707; x=1779397507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cxTN0twtBMiNxP0sdrc8AA2jPj0rdTT5K+/0XduiR/U=;
        b=hvsEYyhDCgsnza3PuF0mnPaZZ+3pieZh/bX8jRkgkviZDJA77NDueEyfXan1UIqbnj
         /RG3Qk5NeXWJoFyYb507z2amxpZokxdeMF52dDZd1jUVPVNVvYoEZjUXZzd7Ts63zVsF
         UaR5s3YdI67+gLV0YQvZyukBnDCbYsXTQbvZEPP1n3OyCUgN0KUXAdE8+KQEEE2wo4yV
         uJS/wZlQDDT8kRXUTVZ6lzhEJ1ZgIJNr1NHgRhJiWSQFocwWDILHStVUDc/t2M4iK38u
         5UVXxzKvmOmu6Ru6d2/BmSMyOutIqTWPQNzISRTOzu6UvdCSCBzUsonfzJtHrJYnxuwK
         9R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792707; x=1779397507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxTN0twtBMiNxP0sdrc8AA2jPj0rdTT5K+/0XduiR/U=;
        b=nd7cU9W/x/HZO566zXaqfQpVM56RDGn4erRa/wKMD6Qj+m8YzoAol3BZPktzQUZMAw
         FZ7pXvPrkfD56kX5SJINGyKdG7gasaWUCgqD9RnEMH/HbS6+TVG88b5PobbmZG40XrFU
         NChfRwHjeCH4P07MzC/RU5C311Q30y4F9i4YWn0QB+jrfRKB0tcHuMpyKaWvaDsIrg4X
         A/6Ckbx3dz+leOx+D5LNf42lDFlEb3m7JBVgfpyHzPkaOD/1Xv7w0rFfmu/taFylBBQ/
         4iZLc1A2KciIB4STErw69ShFVrqdGWJJekrLaT+1gSmE+8PoTwIqc5FDOjyEp9ve3xOV
         IU1A==
X-Gm-Message-State: AOJu0YxuVXQJVbkCx8e8xzSTZXE8c2S6jn/QC5aHdV5z6zcEvusE6kVe
	RFCKiDD97Vmc+dO7iD8FQRmw1q9/w/UXV5+FxGRqcqllY3OeQV7mOv1vRJGzPheZT6brhpVOG0G
	chxno7w==
X-Received: from pfbey21.prod.google.com ([2002:a05:6a00:38d5:b0:82f:790c:3922])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:439b:b0:82f:2070:2683
 with SMTP id d2e1a72fcca58-83f33c76531mr1244296b3a.21.1778792706849; Thu, 14
 May 2026 14:05:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:44 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-5-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 04/20] x86: Dedup guest/host context switch
 of registers across SVM and VMX
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Deduplicate the context switching of registers across VM-Enter<=>VM-Exit
between SVM and VMX.  The required functionality and implementations are
practically identical, literally the only difference is that SVM doesn't
need (or want) to manually swap RAX as SVM automatically swaps RAX at
VMRUN and #VMEXIT.

Opportunistically rename the structure to "guest_regs" to clarify its
purpose, and to avoid conflicts, e.g. with realmode's "struct regs".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/virt.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 x86/svm.c      |  4 ++--
 x86/svm.h      | 47 ++++-----------------------------------------
 x86/vmx.c      |  8 ++++----
 x86/vmx.h      | 42 +---------------------------------------
 5 files changed, 63 insertions(+), 90 deletions(-)
 create mode 100644 lib/x86/virt.h

diff --git a/lib/x86/virt.h b/lib/x86/virt.h
new file mode 100644
index 00000000..ccc90c25
--- /dev/null
+++ b/lib/x86/virt.h
@@ -0,0 +1,52 @@
+#ifndef _x86_VIRT_H_
+#define _x86_VIRT_H_
+
+#include "libcflat.h"
+
+struct guest_regs {
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	/*
+	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
+	 * by software in any relevant flows.
+	 */
+	u64 cr2;
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u64 rflags;
+};
+
+extern struct guest_regs regs;
+
+#define __SWAP_GPRS			\
+	"xchg %%rcx, regs+0x8\n\t"	\
+	"xchg %%rdx, regs+0x10\n\t"	\
+	"xchg %%rbx, regs+0x18\n\t"	\
+	"xchg %%rbp, regs+0x28\n\t"	\
+	"xchg %%rsi, regs+0x30\n\t"	\
+	"xchg %%rdi, regs+0x38\n\t"	\
+	"xchg %%r8, regs+0x40\n\t"	\
+	"xchg %%r9, regs+0x48\n\t"	\
+	"xchg %%r10, regs+0x50\n\t"	\
+	"xchg %%r11, regs+0x58\n\t"	\
+	"xchg %%r12, regs+0x60\n\t"	\
+	"xchg %%r13, regs+0x68\n\t"	\
+	"xchg %%r14, regs+0x70\n\t"	\
+	"xchg %%r15, regs+0x78\n\t"
+
+#define SWAP_GPRS			\
+	"xchg %%rax, regs+0x0\n\t"	\
+	__SWAP_GPRS
+
+#endif /* _x86_VIRT_H_ */
\ No newline at end of file
diff --git a/x86/svm.c b/x86/svm.c
index 941e0784..893b3f49 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -223,9 +223,9 @@ void vmcb_ident(struct vmcb *vmcb)
 	}
 }
 
-struct regs regs;
+struct guest_regs regs;
 
-struct regs get_regs(void)
+struct guest_regs get_regs(void)
 {
 	return regs;
 }
diff --git a/x86/svm.h b/x86/svm.h
index d9f7c731..a9e15f67 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -2,6 +2,7 @@
 #define X86_SVM_H
 
 #include "libcflat.h"
+#include "virt.h"
 
 enum {
 	INTERCEPT_INTR,
@@ -390,26 +391,6 @@ struct svm_test {
 	bool on_vcpu_done;
 };
 
-struct regs {
-	u64 rax;
-	u64 rcx;
-	u64 rdx;
-	u64 rbx;
-	u64 cr2;
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
-	u64 rflags;
-};
-
 typedef void (*test_guest_func)(struct svm_test *);
 
 int run_svm_tests(int ac, char **av, struct svm_test *svm_tests);
@@ -435,7 +416,7 @@ int get_test_stage(struct svm_test *test);
 void set_test_stage(struct svm_test *test, int s);
 void inc_test_stage(struct svm_test *test);
 void vmcb_ident(struct vmcb *vmcb);
-struct regs get_regs(void);
+struct guest_regs get_regs(void);
 void vmmcall(void);
 void svm_setup_vmrun(u64 rip);
 u64 __svm_vmrun(u64 rip);
@@ -454,36 +435,16 @@ static inline void clgi(void)
     asm volatile ("clgi");
 }
 
-
-
-#define SAVE_GPR_C                              \
-        "xchg %%rcx, regs+0x8\n\t"              \
-        "xchg %%rdx, regs+0x10\n\t"             \
-        "xchg %%rbx, regs+0x18\n\t"             \
-        "xchg %%rbp, regs+0x28\n\t"             \
-        "xchg %%rsi, regs+0x30\n\t"             \
-        "xchg %%rdi, regs+0x38\n\t"             \
-        "xchg %%r8, regs+0x40\n\t"              \
-        "xchg %%r9, regs+0x48\n\t"              \
-        "xchg %%r10, regs+0x50\n\t"             \
-        "xchg %%r11, regs+0x58\n\t"             \
-        "xchg %%r12, regs+0x60\n\t"             \
-        "xchg %%r13, regs+0x68\n\t"             \
-        "xchg %%r14, regs+0x70\n\t"             \
-        "xchg %%r15, regs+0x78\n\t"
-
-#define LOAD_GPR_C      SAVE_GPR_C
-
 #define ASM_PRE_VMRUN_CMD                       \
                 "vmload %%rax\n\t"              \
                 "mov regs+0x80, %%r15\n\t"      \
                 "mov %%r15, 0x170(%%rax)\n\t"   \
                 "mov regs, %%r15\n\t"           \
                 "mov %%r15, 0x1f8(%%rax)\n\t"   \
-                LOAD_GPR_C                      \
+                __SWAP_GPRS                     \
 
 #define ASM_POST_VMRUN_CMD                      \
-                SAVE_GPR_C                      \
+                __SWAP_GPRS                     \
                 "mov 0x170(%%rax), %%r15\n\t"   \
                 "mov %%r15, regs+0x80\n\t"      \
                 "mov 0x1f8(%%rax), %%r15\n\t"   \
diff --git a/x86/vmx.c b/x86/vmx.c
index 44ee3697..603730c2 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -44,7 +44,7 @@ struct vmcs *vmcs_root;
 u32 vpid_cnt;
 u64 guest_stack_top;
 u32 ctrl_pin, ctrl_enter, ctrl_exit, ctrl_cpu[2];
-struct regs regs;
+struct guest_regs regs;
 
 struct vmx_test *current;
 
@@ -1732,7 +1732,7 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 	asm volatile (
 		"mov %[HOST_RSP], %%rdi\n\t"
 		"vmwrite %%rsp, %%rdi\n\t"
-		LOAD_GPR_C
+		SWAP_GPRS
 		"cmpb $0, %[launched]\n\t"
 		"jne 1f\n\t"
 		"vmlaunch\n\t"
@@ -1740,14 +1740,14 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 		"1: "
 		"vmresume\n\t"
 		"2: "
-		SAVE_GPR_C
+		SWAP_GPRS
 		"pushf\n\t"
 		"pop %%rdi\n\t"
 		"mov %%rdi, %[vm_fail_flags]\n\t"
 		"movl $1, %[vm_fail]\n\t"
 		"jmp 3f\n\t"
 		"vmx_return:\n\t"
-		SAVE_GPR_C
+		SWAP_GPRS
 		"3: \n\t"
 		: [vm_fail]"+m"(result->vm_fail),
 		  [vm_fail_flags]"=m"(result->flags)
diff --git a/x86/vmx.h b/x86/vmx.h
index 425b1c43..56f37633 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -5,6 +5,7 @@
 #include "processor.h"
 #include "bitops.h"
 #include "util.h"
+#include "virt.h"
 #include "asm/page.h"
 #include "asm/io.h"
 
@@ -58,26 +59,6 @@ struct invvpid_operand {
 	u64 gla;
 };
 
-struct regs {
-	u64 rax;
-	u64 rcx;
-	u64 rdx;
-	u64 rbx;
-	u64 cr2;
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
-	u64 rflags;
-};
-
 union exit_reason {
 	struct {
 		u32	basic			: 16;
@@ -587,25 +568,6 @@ enum vm_entry_failure_code {
 	ENTRY_FAIL_VMCS_LINK_PTR	= 4,
 };
 
-#define SAVE_GPR_C				\
-	"xchg %%rax, regs\n\t"			\
-	"xchg %%rcx, regs+0x8\n\t"		\
-	"xchg %%rdx, regs+0x10\n\t"		\
-	"xchg %%rbx, regs+0x18\n\t"		\
-	"xchg %%rbp, regs+0x28\n\t"		\
-	"xchg %%rsi, regs+0x30\n\t"		\
-	"xchg %%rdi, regs+0x38\n\t"		\
-	"xchg %%r8, regs+0x40\n\t"		\
-	"xchg %%r9, regs+0x48\n\t"		\
-	"xchg %%r10, regs+0x50\n\t"		\
-	"xchg %%r11, regs+0x58\n\t"		\
-	"xchg %%r12, regs+0x60\n\t"		\
-	"xchg %%r13, regs+0x68\n\t"		\
-	"xchg %%r14, regs+0x70\n\t"		\
-	"xchg %%r15, regs+0x78\n\t"
-
-#define LOAD_GPR_C	SAVE_GPR_C
-
 #define VMX_IO_SIZE_MASK	0x7
 #define _VMX_IO_BYTE		0
 #define _VMX_IO_WORD		1
@@ -739,8 +701,6 @@ enum vm_entry_failure_code {
 #define VMCS_FIELD_RESERVED_SHIFT	(15)
 #define VMCS_FIELD_BIT_SIZE		(BITS_PER_LONG)
 
-extern struct regs regs;
-
 extern union vmx_basic_msr basic_msr;
 extern union vmx_ctrl_msr ctrl_pin_rev;
 extern union vmx_ctrl_msr ctrl_cpu_rev[2];
-- 
2.54.0.563.g4f69b47b94-goog

