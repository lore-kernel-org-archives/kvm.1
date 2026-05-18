Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62563932E6;
	Mon, 18 May 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135924; cv=none; b=NWJbLvQeq0JOudoV2XKMprLAJdill0g8ucsh1cuq7D5GoK1KTCL0opxdietm3bgMrNDU85jHRwJSqbg5KFmG6u5VWBACrLEkI1TicZHt2j/lECJPVIN3zdmRN8LrkOgMh1bSB7j+DQ3bhbkdMVtIs+reXoNANDpTawlIbYBlEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135924; c=relaxed/simple;
	bh=njX+iJo3+TNYTdvOBhNX5VWPurSrqrigf3nE/wY7WxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHtWkQTnDkm1AvpQB1G2mQfc/JW9JOvZDcdjIU5kJpGQ+A8AxQNU38rAbIsyNLJiIFDSML1NcsqJKcd0miLst+9SLnNxfi4iIygXwQum/xA+Nf+aV+XZuEwCDf0dt7S6CtjKBo8yP3CxeuQTtcdrHvGe7AyspbMsVYj09U4SGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKAt6nmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKAt6nmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDD8C2BCC6;
	Mon, 18 May 2026 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135924;
	bh=njX+iJo3+TNYTdvOBhNX5VWPurSrqrigf3nE/wY7WxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKAt6nmYgToYPx7QoZLnYx4XCsil0pj+qC1/QAtO4nn1Qdnd/EbCgxQWLk6DWyRu1
	 Lxs4S8Xs3S7yR0yK3vvuFJrpF887g68EYrhy7URbySHBhXGqX4OcMueUt50yGcWUI0
	 FxZbqDJ6xsPcbeSVs/qAXQwDxCp52MOWWIJg6qtHHMQLTqIuIdXNkBkQkHLbKsZo0l
	 97WvP6BQvvPqmnS9jAVmN2FAiBRhwd/triMa8aiEVurz8KFRMLToVfLhik/2h8iBbp
	 B50jNtvLHxPDHxQYXNZdEwl4kq3Y6ZtZ++DLsU40I1tbFgHbRZdhfsnbQvG5MiOltP
	 m3ffOuKAbdSvQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosryahmed@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 2/8] KVM: selftests: Move GPR load/save definitions outside of nSVM code
Date: Mon, 18 May 2026 20:25:08 +0000
Message-ID: <20260518202514.2037078-3-yosry@kernel.org>
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

In preparation for reusing the code for nVMX tests, move the definitions
for GPRs switching to processor.h.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     | 42 +++++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c |  2 +
 tools/testing/selftests/kvm/lib/x86/svm.c     | 41 ------------------
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 1482f2b53a9c5..8e4eab84b91bc 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -397,6 +397,48 @@ struct gpr64_regs {
 	u64 r15;
 };
 
+extern struct gpr64_regs guest_regs;
+
+#define DEFINE_ASM_GPR64_OFFSET(reg) \
+	asm(".equ GPR64_OFF_" #reg ", %c0" : : "i"(offsetof(struct gpr64_regs, reg)))
+
+DEFINE_ASM_GPR64_OFFSET(rbx);
+DEFINE_ASM_GPR64_OFFSET(rcx);
+DEFINE_ASM_GPR64_OFFSET(rdx);
+DEFINE_ASM_GPR64_OFFSET(rbp);
+DEFINE_ASM_GPR64_OFFSET(rsi);
+DEFINE_ASM_GPR64_OFFSET(rdi);
+DEFINE_ASM_GPR64_OFFSET(r8);
+DEFINE_ASM_GPR64_OFFSET(r9);
+DEFINE_ASM_GPR64_OFFSET(r10);
+DEFINE_ASM_GPR64_OFFSET(r11);
+DEFINE_ASM_GPR64_OFFSET(r12);
+DEFINE_ASM_GPR64_OFFSET(r13);
+DEFINE_ASM_GPR64_OFFSET(r14);
+DEFINE_ASM_GPR64_OFFSET(r15);
+
+#define GUEST_SWITCH_GPR_ASM(reg) \
+	"xchg %%" #reg ", guest_regs + GPR64_OFF_" #reg "\n\t"
+/*
+ * save/restore 64-bit general registers except rax, rip, rsp
+ * which are directly handed through the VMCB guest processor state
+ */
+#define GUEST_SWITCH_GPRS_NORAX_ASM \
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
 struct desc64 {
 	u16 limit0;
 	u16 base0;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b51467d70f6e7..caefcd12df8d2 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -29,6 +29,8 @@ bool host_cpu_is_amd_compatible;
 bool is_forced_emulation_enabled;
 u64 guest_tsc_khz;
 
+struct gpr64_regs guest_regs;
+
 const char *ex_str(int vector)
 {
 	switch (vector) {
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 6a6926b3b9d7c..b4d1a00dbe27f 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -13,7 +13,6 @@
 
 #define SEV_DEV_PATH "/dev/sev"
 
-struct gpr64_regs guest_regs;
 u64 rflags;
 
 /* Allocate memory regions for nested SVM tests.
@@ -131,46 +130,6 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_r
 	}
 }
 
-#define DEFINE_ASM_GPR64_OFFSET(reg) \
-	asm(".equ GPR64_OFF_" #reg ", %c0" : : "i"(offsetof(struct gpr64_regs, reg)))
-
-DEFINE_ASM_GPR64_OFFSET(rbx);
-DEFINE_ASM_GPR64_OFFSET(rcx);
-DEFINE_ASM_GPR64_OFFSET(rdx);
-DEFINE_ASM_GPR64_OFFSET(rbp);
-DEFINE_ASM_GPR64_OFFSET(rsi);
-DEFINE_ASM_GPR64_OFFSET(rdi);
-DEFINE_ASM_GPR64_OFFSET(r8);
-DEFINE_ASM_GPR64_OFFSET(r9);
-DEFINE_ASM_GPR64_OFFSET(r10);
-DEFINE_ASM_GPR64_OFFSET(r11);
-DEFINE_ASM_GPR64_OFFSET(r12);
-DEFINE_ASM_GPR64_OFFSET(r13);
-DEFINE_ASM_GPR64_OFFSET(r14);
-DEFINE_ASM_GPR64_OFFSET(r15);
-
-#define GUEST_SWITCH_GPR_ASM(reg) \
-	"xchg %%" #reg ", guest_regs + GPR64_OFF_" #reg "\n\t"
-/*
- * save/restore 64-bit general registers except rax, rip, rsp
- * which are directly handed through the VMCB guest processor state
- */
-#define GUEST_SWITCH_GPRS_NORAX_ASM \
-	GUEST_SWITCH_GPR_ASM(rbx) \
-	GUEST_SWITCH_GPR_ASM(rcx) \
-	GUEST_SWITCH_GPR_ASM(rdx) \
-	GUEST_SWITCH_GPR_ASM(rbp) \
-	GUEST_SWITCH_GPR_ASM(rsi) \
-	GUEST_SWITCH_GPR_ASM(rdi) \
-	GUEST_SWITCH_GPR_ASM(r8)  \
-	GUEST_SWITCH_GPR_ASM(r9)  \
-	GUEST_SWITCH_GPR_ASM(r10) \
-	GUEST_SWITCH_GPR_ASM(r11) \
-	GUEST_SWITCH_GPR_ASM(r12) \
-	GUEST_SWITCH_GPR_ASM(r13) \
-	GUEST_SWITCH_GPR_ASM(r14) \
-	GUEST_SWITCH_GPR_ASM(r15)
-
 /*
  * selftests do not use interrupts so we dropped clgi/sti/cli/stgi
  * for now. registers involved in GPRs switching are eventually
-- 
2.54.0.563.g4f69b47b94-goog

