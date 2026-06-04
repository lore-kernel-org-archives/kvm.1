Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA981494A1A;
	Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605363; cv=none; b=unDQR5QMUhM/B4UdGgYwGltJLakmRQ6MJ+gqlNgFabVtXR1lRa+9Cgcx+MfZCuAR+sfz/xoe3xs6K6FQM3Ms13x8cLFt4ZrQzkxrniAlqWEXVqAwNNZlE2vKelp6OM+9vRWkGimzwzlaVVTlvG+V0pB7wujPaoFAPQVa4Tecelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605363; c=relaxed/simple;
	bh=j7IfzI3voPCQYj2N+nIvNBdNRyvLg7aGNszigvogpdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mA5Hxp55VvSSpQ67sk4FHivQOeLXbdzhjBNp608iEl+NJykyv+PcAznCwm23AnqVKzjV/KMUd7XDAuHgvbT1p08HozB767iB8pfd8LH+Svq66/ozS+Fo1bIkgoRHIFuBuz7SCfru3O4idzzAVG1IiMu9xUgc4CgP+dJa34oRF94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+fxadKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+fxadKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8148B1F00898;
	Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605361;
	bh=ovrEBxl4FhwKwnx1ah7haB2DJeKCMEvjp5Fkgg7XjVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+fxadKU6FYA7PhVsz9ZEGezp3EBvosGTYg7E8hmwvoYSj92a4iNO/SLDgY/TTxt5
	 XfeTxhGWxKZsaKOtpbWbWJWj8GF8P694h9jwsNAyN8DJGnIUSUn9CRXJL27lVokFCZ
	 GvZ2uG1bHX4ABjGKDIkHRq9iuhsB6gxQYFKtKg0OPaoAa43D6keAt3FR/v5XCDQfT/
	 ebNDiZuviGIh4eDFDVT7sMyvK4KNKsR+OG9tJR3qibmUi43MVq66ugl6R9SzGXhzgs
	 HC/BDEb+PNfe1FYF9mW+6s5QR03Ud7pWSpCr/waFVyidfsNOrMuW2JXnBIyXCtG0kF
	 LhxOyzYsPLRTw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 05/10] KVM: selftests: Reuse GPR switching logic for nVMX
Date: Thu,  4 Jun 2026 20:35:41 +0000
Message-ID: <20260604203546.365658-6-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604203546.365658-1-yosry@kernel.org>
References: <20260604203546.365658-1-yosry@kernel.org>
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

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 63 +++++++++----------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 90fffaf915958..64996c310fe4c 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -363,9 +363,23 @@ static inline u64 vmptrstz(void)
 	return value;
 }
 
-/*
- * No guest state (e.g. GPRs) is established by this vmlaunch.
- */
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
2.54.0.1032.g2f8565e1d1-goog

