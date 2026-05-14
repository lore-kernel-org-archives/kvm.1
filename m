Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537F248F57
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792712; cv=none; b=gen0TS2cGCzcYvX+SiEhWM6rdpH1DVNBhpCvTc8n7pNmt5NXYBiEDR51lJiBfMIRXNKzdOOmemINlNTsX0yumdKLkCGWZN8TQEHGuttjHnevb6jO73hzaYuXaGJdk+0g9HrwyZp+cZOEHVDSi6677NUCz31n0nBWE6xIYO+nNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792712; c=relaxed/simple;
	bh=IjQ48/HE1E4hW6XzjVNXhJW9jaswGOXUsy0PdNzX2YQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P6Pv+YjHJ1yMkFuz3Xryue24pyZfZQIspeFJQ6TQ4TZoCvBecjdpd9c0XjV5dhprtcf2F9MZ3/nx1OyddZFzJJFrOkgPzr1JUMF+YdLMdL0POrw7wuZlUFf3uBpSm8lWCirPuEsu2f9Aj/cBZo8/KjB1iGJvEVTlMq9iumI0QGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fl6eRRey; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl6eRRey"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so3272025a12.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792708; x=1779397508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=finPTRSSSDW1HtRjz8RysOT4r6eDhisEP3NJezbjx/E=;
        b=fl6eRRey/newSuHyIHNZhJtx5ST8VOaKuJ48RnkoMHkolJDhlSDIihp5wpGLYPU8wU
         47F1otXvTYXoO2GAkwrEBjPiAY5ko6+e5Y/Hq5ZV/+1zXl5yHRM9v93nliQ1vBaQbHMB
         3LWtcKkdFboB74WsXWK5KTUadqq7UC1Il2+yQjZrhpZikBeQMu34dCpABt2Q/YhBsJpH
         xn2pli+sHvLSdLzOSygumX4/cZZkQ9EAUZDqYQz/PRMlBauMqbeX91l+nFEBKutEUrmI
         iwxQVymqoRKBxjfntVeoMNgvubyEHR6Zdbqjv+SOFvQ8V06mDh1jZ/O2tMlh6lRBEnwZ
         q+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792708; x=1779397508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=finPTRSSSDW1HtRjz8RysOT4r6eDhisEP3NJezbjx/E=;
        b=GDV/LnESboOBpARHmBxFMSycb4htDT/4tfITooeHwl1vq0dgNJ7OWFoRgqWDVJI+ID
         7HyVZh+g4xvEhkbw0hV+i+rDBJ1ekMlw6AIfmySEwzazgoNqFWRCmGfpPx+OEiwfi5l7
         zw03aknsK2eu4x0F6hwnMBjZKiWWrjh8c/VsZZXfqIEfEM12Gva86NDEMsWojbzpy4uI
         s3I4RdNt8tYL7n1JK1BKnl8kX43yVvjizp7d6Yd4sB9I0UahLpen6yRAgIaFN2tfd+s4
         N5zfKdufU4IKp2/kWQFaGMKzB2WYi2awW/f3ioO/kRV9NJvuFhPau5uLX0753H7JwA/L
         xDbA==
X-Gm-Message-State: AOJu0Yyb7tCc3ZKWS9EqjX05S8Y7ZcDAEP2/aGTJGTnHghavyp5VEKtX
	e9Cise4cNkyEmVQKDuR+yuFoeKtjiRqL5ZLRfmgXm6MgjhgIDNtU3ZAHwwHgg50bIpALDTOHZmK
	x3oEymQ==
X-Received: from pfbga17.prod.google.com ([2002:a05:6a00:6211:b0:830:bd81:a29a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f93:b0:3aa:f2c7:fd87
 with SMTP id adf61e73a8af0-3b22ebc898emr826341637.31.1778792707939; Thu, 14
 May 2026 14:05:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:45 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-6-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 05/20] x86/virt: Use macro shenanigans to
 get reg offsets when swapping guest/host regs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Replace the hand-coded literal offsets in the guest/host assembly code
with programmatically generated offsets to make the code more readable and
easier to maintain.  E.g. this will make it much, much easier to make
the guest register structure per-CPU.

To workaround offsetof() being resolved at compile-time, i.e. not by the
preprocessor, provide a macro to define the immediate constraints for
inline assembly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/virt.h | 62 ++++++++++++++++++++++++++++++++++++--------------
 x86/svm.c      |  5 ++--
 x86/svm.h      | 11 +++++----
 x86/vmx.c      |  3 ++-
 4 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/lib/x86/virt.h b/lib/x86/virt.h
index ccc90c25..1066390d 100644
--- a/lib/x86/virt.h
+++ b/lib/x86/virt.h
@@ -29,24 +29,52 @@ struct guest_regs {
 
 extern struct guest_regs regs;
 
-#define __SWAP_GPRS			\
-	"xchg %%rcx, regs+0x8\n\t"	\
-	"xchg %%rdx, regs+0x10\n\t"	\
-	"xchg %%rbx, regs+0x18\n\t"	\
-	"xchg %%rbp, regs+0x28\n\t"	\
-	"xchg %%rsi, regs+0x30\n\t"	\
-	"xchg %%rdi, regs+0x38\n\t"	\
-	"xchg %%r8, regs+0x40\n\t"	\
-	"xchg %%r9, regs+0x48\n\t"	\
-	"xchg %%r10, regs+0x50\n\t"	\
-	"xchg %%r11, regs+0x58\n\t"	\
-	"xchg %%r12, regs+0x60\n\t"	\
-	"xchg %%r13, regs+0x68\n\t"	\
-	"xchg %%r14, regs+0x70\n\t"	\
-	"xchg %%r15, regs+0x78\n\t"
+#define GUEST_REG_OFFSET(name) \
+	[off_##name] "i" (offsetof(struct guest_regs, name))
 
-#define SWAP_GPRS			\
-	"xchg %%rax, regs+0x0\n\t"	\
+#define GUEST_REGS_OFFSETS	\
+	GUEST_REG_OFFSET(rax),	\
+	GUEST_REG_OFFSET(rcx),	\
+	GUEST_REG_OFFSET(rdx),	\
+	GUEST_REG_OFFSET(rbx),	\
+	GUEST_REG_OFFSET(cr2),	\
+	GUEST_REG_OFFSET(rbp),	\
+	GUEST_REG_OFFSET(rsi),	\
+	GUEST_REG_OFFSET(rdi),	\
+	GUEST_REG_OFFSET(r8),	\
+	GUEST_REG_OFFSET(r9),	\
+	GUEST_REG_OFFSET(r10),	\
+	GUEST_REG_OFFSET(r11),	\
+	GUEST_REG_OFFSET(r12),	\
+	GUEST_REG_OFFSET(r13),	\
+	GUEST_REG_OFFSET(r14),	\
+	GUEST_REG_OFFSET(r15),	\
+	GUEST_REG_OFFSET(rflags)
+
+#define GUEST_REG(name) \
+	xxstr(regs+%c[off_##name])
+
+#define SWAP_REG(name) \
+	"xchg %%" xxstr(name) "," GUEST_REG(name) "\n\t"
+
+#define __SWAP_GPRS		\
+	SWAP_REG(rcx)		\
+	SWAP_REG(rdx)		\
+	SWAP_REG(rbx)		\
+	SWAP_REG(rbp)		\
+	SWAP_REG(rsi)		\
+	SWAP_REG(rdi)		\
+	SWAP_REG(r8)		\
+	SWAP_REG(r9)		\
+	SWAP_REG(r10)		\
+	SWAP_REG(r11)		\
+	SWAP_REG(r12)		\
+	SWAP_REG(r13)		\
+	SWAP_REG(r14)		\
+	SWAP_REG(r15)
+
+#define SWAP_GPRS		\
+	SWAP_REG(rax)		\
 	__SWAP_GPRS
 
 #endif /* _x86_VIRT_H_ */
\ No newline at end of file
diff --git a/x86/svm.c b/x86/svm.c
index 893b3f49..1762cadb 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -254,7 +254,7 @@ u64 __svm_vmrun(u64 rip)
 		      "vmrun %%rax\n\t"               \
 		      ASM_POST_VMRUN_CMD
 		      :
-		      : "a" (virt_to_phys(vmcb))
+		      : GUEST_REGS_OFFSETS, "a" (virt_to_phys(vmcb))
 		      : "memory", "r15");
 
 	return (vmcb->control.exit_code);
@@ -296,7 +296,8 @@ static noinline void test_run(struct svm_test *test)
 			      : // inputs clobbered by the guest:
 				"=D" (the_test),            // first argument register
 				"=b" (the_vmcb)             // callee save register!
-			      : [test] "0" (the_test),
+			      : GUEST_REGS_OFFSETS,
+			        [test] "0" (the_test),
 				[vmcb_phys] "1"(the_vmcb),
 				[PREPARE_GIF_CLEAR] "i" (offsetof(struct svm_test, prepare_gif_clear))
 			      : "rax", "rcx", "rdx", "rsi",
diff --git a/x86/svm.h b/x86/svm.h
index a9e15f67..67a1cddd 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -437,18 +437,18 @@ static inline void clgi(void)
 
 #define ASM_PRE_VMRUN_CMD                       \
                 "vmload %%rax\n\t"              \
-                "mov regs+0x80, %%r15\n\t"      \
+                "mov " GUEST_REG(rflags) ", %%r15\n\t" \
                 "mov %%r15, 0x170(%%rax)\n\t"   \
-                "mov regs, %%r15\n\t"           \
+                "mov " GUEST_REG(rax) ", %%r15\n\t" \
                 "mov %%r15, 0x1f8(%%rax)\n\t"   \
                 __SWAP_GPRS                     \
 
 #define ASM_POST_VMRUN_CMD                      \
                 __SWAP_GPRS                     \
                 "mov 0x170(%%rax), %%r15\n\t"   \
-                "mov %%r15, regs+0x80\n\t"      \
+                "mov %%r15, " GUEST_REG(rflags) "\n\t" \
                 "mov 0x1f8(%%rax), %%r15\n\t"   \
-                "mov %%r15, regs\n\t"           \
+                "mov %%r15, " GUEST_REG(rax)"\n\t" \
                 "vmsave %%rax\n\t"              \
 
 
@@ -459,7 +459,8 @@ static inline void clgi(void)
                 "vmrun %%rax\n\t"               \
 		ASM_POST_VMRUN_CMD \
 		: \
-		: "a" (virt_to_phys(vmcb)) \
+		: GUEST_REGS_OFFSETS, \
+		  "a" (virt_to_phys(vmcb)) \
 		: "memory", "r15") \
 
 #endif
diff --git a/x86/vmx.c b/x86/vmx.c
index 603730c2..8a38ae8a 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1751,7 +1751,8 @@ static noinline void vmx_enter_guest(struct vmentry_result *result)
 		"3: \n\t"
 		: [vm_fail]"+m"(result->vm_fail),
 		  [vm_fail_flags]"=m"(result->flags)
-		: [launched]"m"(launched), [HOST_RSP]"i"(HOST_RSP)
+		: [launched]"m"(launched), [HOST_RSP]"i"(HOST_RSP),
+		  GUEST_REGS_OFFSETS
 		: "rdi", "memory", "cc"
 	);
 	in_guest = 0;
-- 
2.54.0.563.g4f69b47b94-goog

