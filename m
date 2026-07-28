Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F5437855;
	Tue, 28 Jul 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260562; cv=none; b=aYj1yTzGnvJ6fzJxYVi+3IJMcKlXaB0e+BbEAcaYkytElzQqdFZF6LGJFbJMeJdXcClfpK1ggtXMCP69AIRRs5i15ulI07vWCVn57xmz05y5yjkLmQLkJqXtpM8aMg0J+/0FV9p/sQPLVLnDx/r0YApqpz0n0ioW56DuV9S3FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260562; c=relaxed/simple;
	bh=lbH7JjPEGS0xmReLA1ycsoQbbHq4Ool3PQ7FO78hDiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHw0Y4oVCOsQqcQ59Xbr9jFEReoVwSULlxTptYIDiPxy8agBCndXbDY0Eg/fnRxqyEJfJMWE3BVgHY5b374gPB2wa0+47lFYCjLme9ClTIpvq7REaK7QdRIgP+w0CDo+5hhRqX+1VZGHXZ7xgOrjrUJ4HDKFgo8coRiLdO25mBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeJ7I1Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeJ7I1Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FFB1F00A3D;
	Tue, 28 Jul 2026 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260560;
	bh=2aWvaYBeDcNVbS5b1j5qkl8R/YocatdbNurgREgdseI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FeJ7I1Dh/tsUrqp3io9mhgyxFLUWcdFlt9CpQ+lcw6g0xrxKateCLtEQLbEH1tqnt
	 wzep3T3bSyAPD8q9vzp9tDcVvlcopMtpoOdsNEUi/AJhFKQuyG+4H+3yBtVSHZqBq0
	 LEhtaf2/TUM2ycVNcQ396Rtlj3jI0GOu5jmJYBMRcRpPCZyN3VTo+OEapbg2W8MBEK
	 wHzLpihzDWFb9QnamO6xB+8fo+4MdW5BeUCksUgi51W1ouCRyra6y5ck5c65VyyCPv
	 BlELkSn1x51lxQgLU2Edr9YhrUlkVQxGmwyd0ORj1PrlryBs7ztxptJ+kpOt645+EC
	 0vS56aeL+zb2A==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 04/13] KVM: selftests: Handle rflags save/restore for SVM in guest_regs
Date: Tue, 28 Jul 2026 17:42:23 +0000
Message-ID: <20260728174232.2423257-5-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of handling rflags separately, add it to guest_regs. No
functional change intended.

Assisted-by: Gemini:Gemini-Next
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 4 +++-
 tools/testing/selftests/kvm/lib/x86/svm.c           | 6 ++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d7f1acaddd4ee..dab64688e8eae 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -415,6 +415,7 @@ struct guest_regs {
 	u64 r13;
 	u64 r14;
 	u64 r15;
+	u64 rflags;
 };
 
 extern struct guest_regs guest_regs;
@@ -438,7 +439,8 @@ extern struct guest_regs guest_regs;
 	GUEST_REG_OFFSET(r12),	\
 	GUEST_REG_OFFSET(r13),	\
 	GUEST_REG_OFFSET(r14),	\
-	GUEST_REG_OFFSET(r15)
+	GUEST_REG_OFFSET(r15),	\
+	GUEST_REG_OFFSET(rflags)
 
 #define GUEST_REG(name) "guest_regs + %c[off_" #name "]"
 
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 7db38faded89e..b05be50f075d6 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -13,8 +13,6 @@
 
 #define SEV_DEV_PATH "/dev/sev"
 
-u64 rflags;
-
 /* Allocate memory regions for nested SVM tests.
  *
  * Input Args:
@@ -161,7 +159,7 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 {
 	asm volatile (
 		"vmload %[vmcb_gpa]\n\t"
-		"mov rflags, %%r15\n\t"
+		"mov " GUEST_REG(rflags) ", %%r15\n\t"
 		"mov %%r15, %[vmcb_rflags]\n\t"
 		"mov " GUEST_REG(rax) ", %%r15\n\t"
 		"mov %%r15, %[vmcb_rax]\n\t"
@@ -169,7 +167,7 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 		"vmrun %[vmcb_gpa]\n\t"
 		SVM_SWITCH_GPRS_ASM
 		"mov %[vmcb_rflags], %%r15\n\t"
-		"mov %%r15, rflags\n\t"
+		"mov %%r15, " GUEST_REG(rflags) "\n\t"
 		"mov %[vmcb_rax], %%r15\n\t"	// rax
 		"mov %%r15, " GUEST_REG(rax) "\n\t"
 		"vmsave %[vmcb_gpa]\n\t"
-- 
2.55.0.487.gaf234c4eb3-goog

