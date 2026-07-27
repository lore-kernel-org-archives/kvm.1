Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40093F7A98;
	Mon, 27 Jul 2026 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196367; cv=none; b=Q4uurQgv8b7ClAYAUHm/MsvrUEbzek9E5md01c5XbYItu5XvSMgDrg44nb6Buf2jO++R6g0HVeuImi2bhKoEwwzb/vKWm0dYxG6ogmkdGkmRvX9wWPR+Ycq0zcNeJ16St+w90siaRPFgxj8JLOmWO6Klq8c2Iz0BT0zePghHllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196367; c=relaxed/simple;
	bh=Rfx9Ob891ijev527lxLma+6QhMDftUCYG14i1EMaNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G67Dop1vP4F79SIpIQF5629bGvNi1W5gsgRAMml0Pqly+lNWgoxVBS+6uKLoN/kji0c2UQczW6G25gpiEWJW4XYaKNSINR1HR6BtS5IH1ZQYv8uJIkISiyip6YAqahotdlw966ja7xPj+8X9WRf/LCiTpfRZuTB5ieMxQrBTOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQZk3nX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQZk3nX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7181F00A3F;
	Mon, 27 Jul 2026 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196366;
	bh=JGWLe8tti3MNvE6p4UgFa/PE4HUM2Km5+vazPZ/+LeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQZk3nX5hwi4Irv76aBSj3+QpDWM+iT2tY8XE5opH26eEayAyDR9bVt+6pPb+fHvU
	 ROotNd4ZVHoH7PEFQb/TXNa/gANpyDZmsBeCrc4ouLy/HOKpyggbvb5i6se8mH+Ufu
	 2Tc6LoO/WvRwdu6HHTuGd2AwE20t5LxKfZaPwyPJ1cSTBU7IoLdDQu4TPFM64Uj5Nj
	 iUSBxr24R38LAB9plU+vZcdAggnSZll8c3F5QB6LsActf+Sj24530Sj/2nw5+X8s90
	 2YdepbjwLLW4cAIYVNifJ1gTJiWlhuefDkg7BrmJl/hvRjhvKc212fPswjSzKncxQ/
	 l+yLibL8EMxlg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 04/12] KVM: selftests: Handle rflags save/restore for SVM in guest_regs
Date: Mon, 27 Jul 2026 23:52:20 +0000
Message-ID: <20260727235228.1007324-5-yosry@kernel.org>
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
2.55.0.229.g6434b31f56-goog

