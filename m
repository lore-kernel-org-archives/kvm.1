Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E803932CE;
	Mon, 18 May 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135924; cv=none; b=QrgDEaqjIlkTNUj6b2pZL1MSOHWUcx38LkM/MVI1Zf5Lb7Ba6TOqCEM1FilJRIF6QPpngxtqmQ1yEElQsnOOw6MnoQ1y+C1zydPVV+lqEfY6/z7G6BUM1DR8TNT38i3g9nixZczXGdVLdG9HRwCXYlQwacV8s14zZS8RfnHHrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135924; c=relaxed/simple;
	bh=+qgbpnPCsZtacnB8SkWTQSzxBNQtXBDtB8u7+5UFL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sl8Qb75J+ZjkT2nqgeUoKYxry7OZIt8X7KGGW7S+Iidnq7IAU/bJPZ+AZsdZl30puEUtVYcLUTlR9IsFR0ULc1CWoEcr6OHzz3XuuZ0cP6UvxEQ7m2HIh9UM44Qy8dJ+pMs87FkbUKDEhv5tW4zIP7y1ZSv3Uh8WaYg2PVPVJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seXO6iRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seXO6iRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1631BC2BCF6;
	Mon, 18 May 2026 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779135924;
	bh=+qgbpnPCsZtacnB8SkWTQSzxBNQtXBDtB8u7+5UFL/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seXO6iRy7sshOoFYC/h0y4dgtAQhAhPLY8B7JJn5ECoj6TKFZLdab7t9VavlE0ABt
	 bNMBx2G3QAQ3jZ/NWtROikXorxW0YulXCa0t0F9dRPcadmzqAgJ+kHA2qibD3EO/nz
	 VuMEYBF54GtusEXCfvPQjs/3/z/Md+QtDJ8pP29qek0Nw40WLPoYAVjpQuz0xuxHyf
	 Vjjd4Oi+iWT50J4pk/wDXEG8y4gZAr/bXmX8sQ3VJqw21asoycPCVCwL+zqYG/7XpV
	 jp6j/pv76lcQnuncZh7m5VKjVSkZGgf50wCF8C6pU0FaTi1P2ieLyTIG4wNP1aaxNU
	 ZeDGj5cY9sb4Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 1/8] KVM: selftests: Fix offsets in GPR switching for nSVM
Date: Mon, 18 May 2026 20:25:07 +0000
Message-ID: <20260518202514.2037078-2-yosry@kernel.org>
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

The GPRs switching code uses hardcoded offsets and gets them wrong. For
example, the offset of RBX should actually be 0x18. It also uses an
offset outside the struct for the last register.

Instead of hardcoded offsets, define ASM variables that hold the member
offsets using offsetof(), and define a macro that uses those offsets to
switch one GPR.  Opportunistically drop the separate SAVE/LOAD
macros in favor of a single SWITCH macro, and rename it to reflect that
it doesn't switch RAX.

Also, re-order the registers in the struct alphabetically since the
ordering does not matter anymore, and drop RSP as it's not used anyway.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../selftests/kvm/include/x86/processor.h     |  3 +-
 tools/testing/selftests/kvm/lib/x86/svm.c     | 58 ++++++++++++-------
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 77f576ee7789d..1482f2b53a9c5 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -381,10 +381,9 @@ static inline unsigned int x86_model(unsigned int eax)
 /* General Registers in 64-Bit Mode */
 struct gpr64_regs {
 	u64 rax;
+	u64 rbx;
 	u64 rcx;
 	u64 rdx;
-	u64 rbx;
-	u64 rsp;
 	u64 rbp;
 	u64 rsi;
 	u64 rdi;
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 3b01605ab016c..6a6926b3b9d7c 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -131,31 +131,49 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_r
 	}
 }
 
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
 
 /*
  * selftests do not use interrupts so we dropped clgi/sti/cli/stgi
- * for now. registers involved in LOAD/SAVE_GPR_C are eventually
+ * for now. registers involved in GPRs switching are eventually
  * unmodified so they do not need to be in the clobber list.
  */
 void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
@@ -166,9 +184,9 @@ void run_guest(struct vmcb *vmcb, u64 vmcb_gpa)
 		"mov %%r15, 0x170(%[vmcb])\n\t"
 		"mov guest_regs, %%r15\n\t"	// rax
 		"mov %%r15, 0x1f8(%[vmcb])\n\t"
-		LOAD_GPR_C
+		GUEST_SWITCH_GPRS_NORAX_ASM
 		"vmrun %[vmcb_gpa]\n\t"
-		SAVE_GPR_C
+		GUEST_SWITCH_GPRS_NORAX_ASM
 		"mov 0x170(%[vmcb]), %%r15\n\t"	// rflags
 		"mov %%r15, rflags\n\t"
 		"mov 0x1f8(%[vmcb]), %%r15\n\t"	// rax
-- 
2.54.0.563.g4f69b47b94-goog

