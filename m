Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674742DA20;
	Mon, 27 Jul 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196368; cv=none; b=kJr9ZkzccPEP2ZruOR5x5giaaZhRwutY5bz6aJIfVRbtJzZJJ/hLejGcdsfgbYbGsM7H435a1tVWRPaxk88bIxqG9eOIpDrEAKghdV1m/1rDBPkNUiE40liivOUXRKMFt7n7H9dZKYUoo88kB0N6Ldc86gQAUtTbE6iWV8j0pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196368; c=relaxed/simple;
	bh=zaW8MrZ7ZTbGdYtjolHn0IifNS4wKWy0X43nhag4uoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4WzTLwAcstfsjDT/vajx+dGRrdEeTQk4Yw9uWNAoGhuqgPO7Qvr0hTD4eT+X0I+SmBZCFoxSkmGeSKDUXmhpw7tIvf3JYB4XDMsWDq/ozj2JwcuhGHBatcctPKDX9hk7EF2lb5on+cblxs80bO14QSJ2Pz6+o1aMeywzzfL+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgKN+0V+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgKN+0V+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E5E1F00A3D;
	Mon, 27 Jul 2026 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196366;
	bh=jkFcTcyucc1l4jqF3NXUnvch/avIWMIXgmm1/WlHlyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BgKN+0V+smVlq/vZU+jJ3f8bHF1FxixesLjIlEOrHeGQpjxV2zKIcR6QYWX7jSWvq
	 AXv9vTbeATUNJBZCGc/t65A5FwGOsEHHvkxSzPfUc+r2Dhpxt7zJyDPSdJqX5lw1kE
	 T8pdmJEYnGwFRIABV8OCyZocSlh8ZvdY92A+O7o0tMaUmR6izWGgymrTxiW+BWZFrQ
	 9GpdMsp3k6Y0cNmn34EMEhfa1c+DQUXMu84Godc9lRhPjd/RwReQtScFx8CjXbcn8A
	 1elDmhaLemySYVWE4wl2QRhFByH+I+xpF7aAhYqjPwx38JgCKpU+Lmos5pVsMpGn7L
	 k8QHQwzRAgAOA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 05/12] KVM: selftests: Reuse GPR switching logic for nVMX
Date: Mon, 27 Jul 2026 23:52:21 +0000
Message-ID: <20260727235228.1007324-6-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260727235228.1007324-1-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse the GPR switching logic for nVMX by defining VMX_SWITCH_GPRS_ASM,
which is essentially the same as SVM_SWITCH_GPRS_ASM but also switches
RAX and doesn't switch RFLAGS, replacing the push/pop of a subset of the
registers.

The long clobber list of registers is no longer needed as registers are
saved and restored appropriately (and not clobbered by L2).

Define VMX_SWITCH_GPRS_ASM before including evmcs.h, such that it can be
used by evmcs_vmlaunch() and evmcs_vmresume().

This replaces the apparently thread-safe push/pop sequence with the
global GPR switching logic used by SVM, which isn't thread-safe at all.

However this is still an improvement because:
- The VMX logic is half-baked and prompts the UCALL clobber hack as it
  doesn't properly save/restore everything. Reusing the GPR switching
  logic used by SVM allows for dropping that hack.

- Hitting a problem due to half-baked GPR save/restore logic is arguably
  more likely than thread-safety. Evidently, adding more involved stress
  tests fails on VMX with the existing push/pop sequence. OTOH, there
  are no known failures on SVM due to lack of thread-safety fo
  save/restore. Only one test currently uses more than one vCPU with
  nested (the memstress test).

The logical next step is to move the guest_regs to be per-vCPU,
making it thread-safe for both VMX and SVM in a proper way.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../testing/selftests/kvm/include/x86/evmcs.h | 46 +++++--------
 tools/testing/selftests/kvm/include/x86/vmx.h | 69 +++++++++----------
 2 files changed, 49 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/evmcs.h b/tools/testing/selftests/kvm/include/x86/evmcs.h
index be79bda024bf1..82a8ea6b661f0 100644
--- a/tools/testing/selftests/kvm/include/x86/evmcs.h
+++ b/tools/testing/selftests/kvm/include/x86/evmcs.h
@@ -1207,30 +1207,23 @@ static inline int evmcs_vmlaunch(void)
 
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
-			       ((u64)&current_evmcs->host_rip)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			       ((u64)&current_evmcs->host_rip),
+			       GUEST_REGS_OFFSETS
+			     : "memory", "cc");
 	return ret;
 }
 
@@ -1246,30 +1239,23 @@ static inline int evmcs_vmresume(void)
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
-			       ((u64)&current_evmcs->host_rip)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			       ((u64)&current_evmcs->host_rip),
+			       GUEST_REGS_OFFSETS
+			     : "memory", "cc");
 	return ret;
 }
 
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 4bcfd60e3aecb..04f5e34dea3ae 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -290,6 +290,23 @@ struct vmx_msr_entry {
 	u64 value;
 } __attribute__ ((aligned(16)));
 
+#define VMX_SWITCH_GPRS_ASM \
+	GUEST_SWITCH_GPR_ASM(rax) \
+	GUEST_SWITCH_GPR_ASM(rbx) \
+	GUEST_SWITCH_GPR_ASM(rcx) \
+	GUEST_SWITCH_GPR_ASM(rdx) \
+	GUEST_SWITCH_GPR_ASM(rbp) \
+	GUEST_SWITCH_GPR_ASM(rsi) \
+	GUEST_SWITCH_GPR_ASM(rdi) \
+	GUEST_SWITCH_GPR_ASM(r8)  \
+	GUEST_SWITCH_GPR_ASM(r9)  \
+	GUEST_SWITCH_GPR_ASM(r10) \
+	GUEST_SWITCH_GPR_ASM(r11) \
+	GUEST_SWITCH_GPR_ASM(r12) \
+	GUEST_SWITCH_GPR_ASM(r13) \
+	GUEST_SWITCH_GPR_ASM(r14) \
+	GUEST_SWITCH_GPR_ASM(r15)
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
@@ -373,34 +387,24 @@ static inline int vmlaunch(void)
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
-			       [host_rip]"r"((u64)HOST_RIP)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			       [host_rip]"r"((u64)HOST_RIP),
+			       GUEST_REGS_OFFSETS
+			     : "memory", "cc");
 	return ret;
 }
 
-/*
- * No guest state (e.g. GPRs) is established by this vmresume.
- */
 static inline int vmresume(void)
 {
 	int ret;
@@ -408,28 +412,21 @@ static inline int vmresume(void)
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
-			       [host_rip]"r"((u64)HOST_RIP)
-			     : "memory", "cc", "rbx", "r8", "r9", "r10",
-			       "r11", "r12", "r13", "r14", "r15");
+			       [host_rip]"r"((u64)HOST_RIP),
+			       GUEST_REGS_OFFSETS
+			     : "memory", "cc");
 	return ret;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

