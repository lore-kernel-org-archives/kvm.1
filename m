Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008D3C063A;
	Mon, 29 Jun 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758282; cv=none; b=q2FmA8zHKexTaUgRQp6FJU9GzEDQebSIsQHMB1sRHSRADEKL0V4WKkXE9SNv1aoCS7aJy3ZYZKQmIRZ7aKtLn3OIL+OCgw0807bLHI7kY3uBybQN8shmdRZSAcWNaIRWt4QE7SFfQYpAicKlmrwtjdl/v4uiucYo9oqwVKMfIow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758282; c=relaxed/simple;
	bh=7jeiF9DEPr8qfUoBXRV4D0DvWo10qUzBvSKpM+78gN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8AEw6AWSvt+qji37sGj90ImaHjDI+YlJzyDMiDYWw4Q85j3EEyKHomSVK9WbY/t0JM1avBLUNqWEnvEMrVaUG0ZWcia3vnlVbUDmUmVHyn8E4hko4+YTQQbMRCwMKSb+Sh5mPAqzCQyZhpzLNdDUgNKG8WxehkbqRJATVf0vH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM5b/XCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM5b/XCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF8B1F01558;
	Mon, 29 Jun 2026 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758281;
	bh=Ni3d7BJRkw0/4qKeAweXCzBh1RORxAWAiKt72aHpHMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZM5b/XCkWkRF36kq1XYt1CGYrBzBTuv+dy225qcHXmpaWcEc9qTS8YuyNibXyYEHJ
	 CVWWwj93UGx5OMpt2YTet8QVO4OmzzcWRWeRCK9rLTUnscSQsY6wVfHn/5tH8+BvxQ
	 z9lAeZG5DfYPnzdP6y7HDisr4NdCbRjSXI0vb8k8/Zu6ayOpoWm0Efv3R2vWTy8WnL
	 l+fXcOy9xayQC4rubBc8dAPhnYHcm9h51JnaeOt/xQUoWfpR7KVnlkjmTejWH15mLW
	 UzHg5pbI8rysY7FbJAavjqlbNUgeYaURlF4jsPbUnJElpxov5eJLExSGcDAZ6pM0Rq
	 UjonCEJ1wYLiw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 04/10] KVM: selftests: Move GPR load/save definitions outside of nSVM code
Date: Mon, 29 Jun 2026 18:37:39 +0000
Message-ID: <20260629183746.699840-5-yosry@kernel.org>
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
index 535f26e077570..28edeab74e0e6 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -414,6 +414,11 @@ static inline unsigned int x86_model(unsigned int eax)
 #define GUEST_REGS_R15	15
 #define NR_GUEST_REGS	(GUEST_REGS_R15 + 1)
 
+extern u64 guest_regs[NR_GUEST_REGS];
+
+#define GUEST_SWITCH_GPR_ASM(reg, idx) \
+	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"
+
 struct desc64 {
 	u16 limit0;
 	u16 base0;
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ef56dcefe0119..0d66aff04939b 100644
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
index 8e392e0451123..d07f10b5dc963 100644
--- a/tools/testing/selftests/kvm/lib/x86/svm.c
+++ b/tools/testing/selftests/kvm/lib/x86/svm.c
@@ -13,7 +13,6 @@
 
 #define SEV_DEV_PATH "/dev/sev"
 
-u64 guest_regs[NR_GUEST_REGS];
 u64 rflags;
 
 /* Allocate memory regions for nested SVM tests.
@@ -133,9 +132,6 @@ void generic_svm_setup(struct svm_test_data *svm, void *guest_rip)
 	}
 }
 
-#define GUEST_SWITCH_GPR_ASM(reg, idx) \
-	"xchg %%" #reg ", guest_regs + 8 *" XSTR(idx) "\n\t"
-
 /*
  * save/restore 64-bit general registers except rax, rip, rsp
  * which are directly handed through the VMCB guest processor state
-- 
2.55.0.rc0.799.gd6f94ed593-goog

