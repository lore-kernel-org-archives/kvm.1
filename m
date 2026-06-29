Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB0C3D5656;
	Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758282; cv=none; b=QT6HtuIpf+csCw/sgnBBeQ6HcRGwX/+DjscIz5IH7VNAoUfWf0ogRXW+AtBq1LYqeNT/3Obq4cwImZY8EoUV4jRttdhFiTQx3sdFg1u+S34Umy0qaip4ZP5AXHAS3QajhkLRFyFlv1MnQQYMtc4zZG6g0VcCWqxuwBm05dss7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758282; c=relaxed/simple;
	bh=L6/xFSrGdlSp6FYlQE3WMFzqAcULBDvlNiS7lseieOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzG1efTPmkDTqY0zRiRj+m1LIG219tyohZT4Fa3KwvQI4QcABIPoPfN8kOYDeAsau0LVjsk6bhKiCgmgow+yRc6cf8CrF8NZtH2zjC7kDgsVBoxwcfPFCjMJbEwZWIBDA+yG5xjFwBe9MsRSk6N2V5QdT68BxwvfLYIX4I1Ulto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEWEsHVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEWEsHVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE381F000E9;
	Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758281;
	bh=ENiZRSTZrxvCA0i3UEfBKd90frN+KGd0//9q/lSKET0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEWEsHVDZzsdWiahU9EA9fZyXire0/JNLYSV4Zrv5UmPvFQkXsebzhhhqSRzMi01H
	 AyPt4vb2pWyenK5o0J/Zge5iplPLEMHb7p9E1iJSiGO4IRh5q+GH8VtYd5P/1lPJ5v
	 TQDvCDkepeWXrrIdbOHPAsu03r3p8eme8c1GQu6PnXxPVQHL1ucZTuYQS5CvdISH5k
	 47srd9PR2YSPoYWp23gqDLzIB5QcWbxb4Il3HcmgWRCg00flNvEQSNUSVd2r5GzP7o
	 y927LGko6Gt8TrwHjIbdALf/GxdWjEpMXrGH9TKn4A6ESMoMjwg8ydUSUStV4c7+dK
	 AI+SkLSoqvlzQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 05/10] KVM: selftests: Reuse GPR switching logic for nVMX
Date: Mon, 29 Jun 2026 18:37:40 +0000
Message-ID: <20260629183746.699840-6-yosry@kernel.org>
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

Reuse the GPR switching logic for nVMX by defining VMX_SWITCH_GPRS_ASM,
which is essentially the same as SVM_SWITCH_GPRS_ASM but also switches
RAX, replacing the push/pop of a subset of the registers.

The long clobber list of registers is no longer needed as registers are
saved and restored appropriately (and not clobbered by L2).

Define VMX_SWITCH_GPRS_ASM before including evmcs.h, such that it can be
used by evmcs_vmlaunch() and evmcs_vmresume().

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../testing/selftests/kvm/include/x86/evmcs.h | 40 ++++--------
 tools/testing/selftests/kvm/include/x86/vmx.h | 63 +++++++++----------
 2 files changed, 41 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index be79bda024bf1..98268be1aa5b2 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -1207,30 +1207,22 @@ static inline int evmcs_vmlaunch(void)
 
 	current_evmcs->hv_clean_fields = 0;
 
-	__asm__ __volatile__("push %%rbp;"
-			     "push %%rcx;"
-			     "push %%rdx;"
-			     "push %%rsi;"
-			     "push %%rdi;"
-			     "push $0;"
+	__asm__ __volatile__("push $0;"
 			     "mov %%rsp, (%[host_rsp]);"
 			     "lea 1f(%%rip), %%rax;"
 			     "mov %%rax, (%[host_rip]);"
+			     VMX_SWITCH_GPRS_ASM
 			     "vmlaunch;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     VMX_SWITCH_GPRS_ASM
+			     "pop %%rax;"
 			     : [ret]"=&a"(ret)
 			     : [host_rsp]"r"
 			       ((u64)&current_evmcs->host_rsp),
 			       [host_rip]"r"
 			       ((u64)&current_evmcs->host_rip)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			     : "memory", "cc");
 	return ret;
 }
 
@@ -1246,30 +1238,22 @@ static inline int evmcs_vmresume(void)
 	/* HOST_RSP */
 	current_evmcs->hv_clean_fields &= ~HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER;
 
-	__asm__ __volatile__("push %%rbp;"
-			     "push %%rcx;"
-			     "push %%rdx;"
-			     "push %%rsi;"
-			     "push %%rdi;"
-			     "push $0;"
+	__asm__ __volatile__("push $0;"
 			     "mov %%rsp, (%[host_rsp]);"
 			     "lea 1f(%%rip), %%rax;"
 			     "mov %%rax, (%[host_rip]);"
+			     VMX_SWITCH_GPRS_ASM
 			     "vmresume;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     VMX_SWITCH_GPRS_ASM
+			     "pop %%rax;"
 			     : [ret]"=&a"(ret)
 			     : [host_rsp]"r"
 			       ((u64)&current_evmcs->host_rsp),
 			       [host_rip]"r"
 			       ((u64)&current_evmcs->host_rip)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			     : "memory", "cc");
 	return ret;
 }
 
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 4bcfd60e3aecb..a808dc21c9f21 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -290,6 +290,23 @@ struct vmx_msr_entry {
 	u64 value;
 } __attribute__ ((aligned(16)));
 
+#define VMX_SWITCH_GPRS_ASM \
+	GUEST_SWITCH_GPR_ASM(rax, GUEST_REGS_RAX) \
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
+
 #include "evmcs.h"
 
 static inline int vmxon(u64 phys)
@@ -363,9 +380,6 @@ static inline u64 vmptrstz(void)
 	return value;
 }
 
-/*
- * No guest state (e.g. GPRs) is established by this vmlaunch.
- */
 static inline int vmlaunch(void)
 {
 	int ret;
@@ -373,34 +387,23 @@ static inline int vmlaunch(void)
 	if (enable_evmcs)
 		return evmcs_vmlaunch();
 
-	__asm__ __volatile__("push %%rbp;"
-			     "push %%rcx;"
-			     "push %%rdx;"
-			     "push %%rsi;"
-			     "push %%rdi;"
-			     "push $0;"
+	__asm__ __volatile__("push $0;"
 			     "vmwrite %%rsp, %[host_rsp];"
 			     "lea 1f(%%rip), %%rax;"
 			     "vmwrite %%rax, %[host_rip];"
+			     VMX_SWITCH_GPRS_ASM
 			     "vmlaunch;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     VMX_SWITCH_GPRS_ASM
+			     "pop %%rax;"
 			     : [ret]"=&a"(ret)
 			     : [host_rsp]"r"((u64)HOST_RSP),
 			       [host_rip]"r"((u64)HOST_RIP)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			     : "memory", "cc");
 	return ret;
 }
 
-/*
- * No guest state (e.g. GPRs) is established by this vmresume.
- */
 static inline int vmresume(void)
 {
 	int ret;
@@ -408,28 +411,20 @@ static inline int vmresume(void)
 	if (enable_evmcs)
 		return evmcs_vmresume();
 
-	__asm__ __volatile__("push %%rbp;"
-			     "push %%rcx;"
-			     "push %%rdx;"
-			     "push %%rsi;"
-			     "push %%rdi;"
-			     "push $0;"
+	__asm__ __volatile__("push $0;"
 			     "vmwrite %%rsp, %[host_rsp];"
 			     "lea 1f(%%rip), %%rax;"
 			     "vmwrite %%rax, %[host_rip];"
+			     VMX_SWITCH_GPRS_ASM
 			     "vmresume;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     VMX_SWITCH_GPRS_ASM
+			     "pop %%rax;"
 			     : [ret]"=&a"(ret)
 			     : [host_rsp]"r"((u64)HOST_RSP),
 			       [host_rip]"r"((u64)HOST_RIP)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			     : "memory", "cc");
 	return ret;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

