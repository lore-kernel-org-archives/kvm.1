Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01CD39479C;
	Mon, 18 May 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135925; cv=none; b=noEz716bsWqKLnlXTtzXcwG2jGDwGc/5hJClweiD9yROAVtVha9ZCr0P0k/1RUso/zV4mPooxL00WkkcGNUuBTyYnIskd/r8zRPU4dneHfOqBR8H2S4AaT9EMGgVpcTFtm3ycDjD7bCHvo5wjTDp0qC5e8odcx+hlHsZz2NSAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135925; c=relaxed/simple;
	bh=ufaGfnPeyDc9dujy05w2JCVcs25USAABBdfA6RnPZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxIM8ziRmdHTXYgPjUk13nBbcElOIUJYcMGeRQ32gJHVF/dlDtu7U9AyKzaQ4HG00SQLLXomnzW/t5ZdiiXh9QTbI1Li57SIdHmUNUNgeHBHTVcuT2RyUwb4Aluw7aT3BlcEMsdUvp3qnceYVbrCBNqwXfjVN6aar+nOb/T1gvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQi6LyrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQi6LyrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2462C4AF09;
	Mon, 18 May 2026 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135925;
	bh=ufaGfnPeyDc9dujy05w2JCVcs25USAABBdfA6RnPZiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQi6LyrW8y7D5Q7P17xG8K3OhIxKWn5GOsoICtweXKHW0C6axZ4ki8CfGR1sk1QDW
	 Gm3Kh/NBWrhyWEmfEeJQhFTDyYHn/I0jqi4wcTGI5wri1Ja+Z2ABM9+Kwnc1TGU7K8
	 lj3VTy1oNsMFvM6Zkb18WHa0qvi/Gq5GEYeFWovwkzBQAImy57HAqgMkcp4s/XZ0Xr
	 8psoDKE4zZXL19qVjWerKAjVPJgiu90zJLZsHEvT8xcsNfeUIYo1de3CvXcO6jSVNP
	 gi4eyyq5WgBNdoDThcfIxHoydh6MThR//ucM0a9xSZEUNTwge3FTkggFeVczmODkbY
	 5Ypgka3bGJ7pQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 3/8] KVM: selftests: Reuse GPR switching logic for nVMX
Date: Mon, 18 May 2026 20:25:09 +0000
Message-ID: <20260518202514.2037078-4-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260518202514.2037078-1-yosry@kernel.org>
References: <20260518202514.2037078-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

Reuse the GPR switching logic for nVMX by adding a wrapper that also
switches RAX, replacing the push/pop of a subset of the registers.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     |  5 ++
 tools/testing/selftests/kvm/include/x86/vmx.h | 46 +++++--------------
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 8e4eab84b91bc..ca2ec92490f7c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -402,6 +402,7 @@ extern struct gpr64_regs guest_regs;
 #define DEFINE_ASM_GPR64_OFFSET(reg) \
 	asm(".equ GPR64_OFF_" #reg ", %c0" : : "i"(offsetof(struct gpr64_regs, reg)))
 
+DEFINE_ASM_GPR64_OFFSET(rax);
 DEFINE_ASM_GPR64_OFFSET(rbx);
 DEFINE_ASM_GPR64_OFFSET(rcx);
 DEFINE_ASM_GPR64_OFFSET(rdx);
@@ -439,6 +440,10 @@ DEFINE_ASM_GPR64_OFFSET(r15);
 	GUEST_SWITCH_GPR_ASM(r14) \
 	GUEST_SWITCH_GPR_ASM(r15)
 
+#define GUEST_SWITCH_GPRS_ASM \
+	GUEST_SWITCH_GPR_ASM(rax) \
+	GUEST_SWITCH_GPRS_NORAX_ASM
+
 struct desc64 {
 	u16 limit0;
 	u16 base0;
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 90fffaf915958..a7f6f0c9b6b9d 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -363,9 +363,6 @@ static inline u64 vmptrstz(void)
 	return value;
 }
 
-/*
- * No guest state (e.g. GPRs) is established by this vmlaunch.
- */
 static inline int vmlaunch(void)
 {
 	int ret;
@@ -373,34 +370,23 @@ static inline int vmlaunch(void)
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
+			     GUEST_SWITCH_GPRS_ASM
 			     "vmlaunch;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     GUEST_SWITCH_GPRS_ASM
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
@@ -408,28 +394,20 @@ static inline int vmresume(void)
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
+			     GUEST_SWITCH_GPRS_ASM
 			     "vmresume;"
 			     "incq (%%rsp);"
-			     "1: pop %%rax;"
-			     "pop %%rdi;"
-			     "pop %%rsi;"
-			     "pop %%rdx;"
-			     "pop %%rcx;"
-			     "pop %%rbp;"
+			     "1: ;"
+			     GUEST_SWITCH_GPRS_ASM
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
2.54.0.563.g4f69b47b94-goog

