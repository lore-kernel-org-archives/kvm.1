Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF13DFC8F;
	Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605362; cv=none; b=CVFxd7JmeQHlbszx+9jrYMGKQmqDrNhbqd8zy8Ycn9AqbuK6UuvvWs0ucIIzvjg5iacunhE4rvAqpKZnwJ1nBbfiumOJ8z0K2X3C+zVAy8CcknH0pq71ZzS3q+D+hfxoC+uR3R0gNwLlXrJ0XAPbMe9c/XOXS5rF7Lvb+IXGz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605362; c=relaxed/simple;
	bh=5J8YWhpdP8Syhwa569HZmM4YNHLeAAV+rWpNb4p7wec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cM7uAS0LuGRlSVypVfd+WBVd3bnftSmLQMBLmyxCLv+pLN4kijLQGka91A2r/CogtufgiGIFObXs1jP/fn8FPcVR/5DCPItRl76OLR2sD5t1diE0C89ykbAqbZPjTeQ050qL7PCHZ5Y6dfqHxtAikcgh8Jdi9GCt00EPPjuF5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRAtkeO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRAtkeO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA291F0089C;
	Thu,  4 Jun 2026 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605361;
	bh=AjoZr4mLwGK6n4XmzF+gC6Omz91QPnfrZ4XRKtO/Fo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRAtkeO4UzDWC3TPK1xK+YgEIZAzWnwos5y1bZOyQUTCX0uD34uZgEw3gj88xjQ/q
	 LHgBoRNimeAW++KY+YLZSkjL1aP+JFcvmD/NTk7FjZ4Pm72v0Lpgt/oOMUCLUTxw8l
	 pNVUo6jyMXtPeUcpgrZv+NypTPGUHCIW9yKIWaz2SCGlzqqYhAVPT87sNzwxVC7qyi
	 RYy/I6WqBwxAjx5GBJKZAFDcgC1Z2LlO9NLwEQhq7yvgOiyoTQW0oDy46+I3VoN6qu
	 fGJnZA2Wqz08eo4VQIo6ULizwV0Ns5jpv0z7pZXMurXMEhrBJH13zJJyOLRkaXmxfu
	 RmctrcMbwYaUQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2 04/10] KVM: selftests: Move GPR load/save definitions outside of nSVM code
Date: Thu,  4 Jun 2026 20:35:40 +0000
Message-ID: <20260604203546.365658-5-yosry@kernel.org>
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

In preparation for reusing the code for nVMX tests, move the guest_regs
array declaration as well as GPR switching macro to processor.h.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 5 +++++
 tools/testing/selftests/kvm/lib/x86/processor.c     | 2 ++
 tools/testing/selftests/kvm/lib/x86/svm.c           | 4 ----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index ff0b270bfe27f..57f81f0bcc42d 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -414,6 +414,11 @@ static inline unsigned int x86_model(unsigned int eax)
 #define GUEST_REGS_R15	15
 #define NR_GUEST_REGS	GUEST_REGS_R15
 
+extern u64 guest_regs[NR_GUEST_REGS];
+
+#define GUEST_SWITCH_GPR_ASM(reg, idx) \
+	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"
+
 struct desc64 {
 	u16 limit0;
 	u16 base0;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4ca48de7a926d..44a7233d69900 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -29,6 +29,8 @@ bool host_cpu_is_amd_compatible;
 bool is_forced_emulation_enabled;
 u64 guest_tsc_khz;
 
+u64 guest_regs[NR_GUEST_REGS];
+
 const char *ex_str(int vector)
 {
 	switch (vector) {
diff --git a/tools/testing/selftests/kvm/lib/x86/svm.c b/tools/testing/selftests/kvm/lib/x86/svm.c
index 1bd111e8bed26..6528a6416c178 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -13,7 +13,6 @@
 
 #define SEV_DEV_PATH "/dev/sev"
 
-u64 guest_regs[NR_GUEST_REGS];
 u64 rflags;
 
 /* Allocate memory regions for nested SVM tests.
@@ -131,9 +130,6 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip, void *guest_r
 	}
 }
 
-#define GUEST_SWITCH_GPR_ASM(reg, idx) \
-	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"
-
 /*
  * save/restore 64-bit general registers except rax, rip, rsp
  * which are directly handed through the VMCB guest processor state
-- 
2.54.0.1032.g2f8565e1d1-goog

