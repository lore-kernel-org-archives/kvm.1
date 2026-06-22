Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383B35203A;
	Mon, 22 Jun 2026 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100902; cv=none; b=cfj+1ltiDfDWX69Xlu3RdFuPp/syP2i0bwHUKH9+F8DkUkh1GlaWBt5iMD8kRE84rxKXacWeCoqnTsPTvndQur6I31f9cxyiyL8TFoJOcTEnof1lhEvc+FAYi8HHsTmuxrf+eXeKO93TzQvvo6ihWFAdytaEWLSd8UFbsr0ROco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100902; c=relaxed/simple;
	bh=763frQ7EoZ7Vc1DfOAoonCliM33mKg/2n2s5chR42Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8XTFuYMujWc/RN4oIrymZhXTv3bC6famALO+ynN//wu1E2N0AsQMihFYb98lFFqahceicYqYRAykY8v2OSv4yXvsYMPe7ISZxXfzu2oggR5NKw1x4DlAhxCLwBtx1AgEe4NkvjbbfFVw1SiRDFf6C9nOYcNew1sZ2lB96PK2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+8k3Bwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+8k3Bwu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24CAFC2BCB4;
	Mon, 22 Jun 2026 04:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782100902;
	bh=763frQ7EoZ7Vc1DfOAoonCliM33mKg/2n2s5chR42Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s+8k3BwuuT5dVyBFSZhxXAuUVDTvUD/4AXdNX8cUcK1zq3gKuity1u5G8ZZ0ftJ+L
	 2RyllilXKFPFTk2Caf3PmAWEz9eH9SY11q7wTxqCNGn1+xy5x0Yl74zfon3nZofC2I
	 Bq1CQ3ZyLUcypKnZJlIP/nnsxVLguLulS/Rp8dz7Y3tV0ELqCwitBJNkfqOan7gOhr
	 euPeMCdKWtPdLS1wWMxFtUStWfqWT6XUZyRiDTx+lQgg4EUlo0Cv7cMUzQGyzjlazd
	 FVxVtTlsqe8vKSTdQ26nuPgFPzgratIs8qA6gQGrxZSDJVU+zcLKoyPeemfkAyefpv
	 3QHfEJHhjqo1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C36FCD98F6;
	Mon, 22 Jun 2026 04:01:42 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Sun, 21 Jun 2026 21:01:30 -0700
Subject: [PATCH v2 12/16] riscv: kvm: Add emulated test csr
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-riscv_insn_table-v2-12-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
In-Reply-To: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782100900; l=5057;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=neF9aplelwD4odoezxCMv5VCTRiCvu3tkb2/zo8PcSI=;
 b=9jIIU8JY/LLPqDYTkqOQsDnVD/NjPR1ssGDR28kuMyfuB8pPk9cQOmt6ARJ3kfg9/+KvNnXvI
 l0KuzOqo2ykCOJNV4I3L6zsXMm2QfUeTGCAwrtcbJDW7wOSoMow9V2m
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/20260605
 with auth_id=810
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

To test the riscv kvm implementation of emulated CSRs, add support to
emulate the vsscratch csr when CONFIG_RISCV_KVM_TEST_CSR is set.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 arch/riscv/Kconfig.debug                   |  1 +
 arch/riscv/include/asm/kvm_host.h          | 10 ++++++++++
 arch/riscv/include/asm/kvm_vcpu_test_csr.h | 15 +++++++++++++++
 arch/riscv/kvm/Kconfig.debug               | 16 ++++++++++++++++
 arch/riscv/kvm/Makefile                    |  1 +
 arch/riscv/kvm/vcpu_insn.c                 |  5 +++++
 arch/riscv/kvm/vcpu_test_csr.c             | 21 +++++++++++++++++++++
 7 files changed, 69 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index eafe17ebf710..be202267da6d 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -1 +1,2 @@
 source "arch/riscv/kernel/tests/Kconfig.debug"
+source "arch/riscv/kvm/Kconfig.debug"
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c1bc..4d30d30ebefc 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -167,6 +167,12 @@ struct kvm_vcpu_reset_state {
 	unsigned long a1;
 };
 
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+struct kvm_test_csr {
+	unsigned long val;
+};
+#endif
+
 struct kvm_vcpu_arch {
 	/* VCPU ran at least once */
 	bool ran_atleast_once;
@@ -265,6 +271,10 @@ struct kvm_vcpu_arch {
 		gpa_t shmem;
 		u64 last_steal;
 	} sta;
+
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+	struct kvm_test_csr test_csr;
+#endif
 };
 
 /*
diff --git a/arch/riscv/include/asm/kvm_vcpu_test_csr.h b/arch/riscv/include/asm/kvm_vcpu_test_csr.h
new file mode 100644
index 000000000000..a844fccaafc3
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_vcpu_test_csr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_VCPU_RISCV_TEST_CSR_H
+#define __KVM_VCPU_RISCV_TEST_CSR_H
+
+#include <asm/kvm_vcpu_insn.h>
+
+#define KVM_RISCV_VCPU_TEST_CSR_FUNCS \
+	{.base = CSR_VSSCRATCH,	.count = 1,	.func = kvm_riscv_vcpu_test_csr },
+
+int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			    unsigned long *val, unsigned long new_val,
+			    unsigned long wr_mask);
+
+#endif /* !__KVM_VCPU_RISCV_TEST_CSR_H */
diff --git a/arch/riscv/kvm/Kconfig.debug b/arch/riscv/kvm/Kconfig.debug
new file mode 100644
index 000000000000..dc76e02120a3
--- /dev/null
+++ b/arch/riscv/kvm/Kconfig.debug
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "arch/riscv/kvm testing"
+
+config RISCV_KVM_TEST_CSR
+        bool "Test KVM CSR emulation"
+        depends on KVM
+        default n
+        help
+            Enable this option to enable the emulation of a test hypervisor csr.
+            The KVM test csr is the vsscratch register. Once this is enabled,
+            reading/writing to the vsscratch register will trap into the host
+            supervisor and reflect the change.
+
+            If unsure, say N.
+
+endmenu # "arch/riscv/kvm testing"
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05089..5092b86751c4 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -38,6 +38,7 @@ kvm-y += vcpu_sbi_sta.o
 kvm-y += vcpu_sbi_system.o
 kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
 kvm-y += vcpu_switch.o
+kvm-$(CONFIG_RISCV_KVM_TEST_CSR) += vcpu_test_csr.o
 kvm-y += vcpu_timer.o
 kvm-y += vcpu_vector.o
 kvm-y += vm.o
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 1d8741d02242..c5a70de4a579 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -10,6 +10,8 @@
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 
+#include <asm/kvm_vcpu_test_csr.h>
+
 struct insn_func {
 	unsigned long mask;
 	unsigned long match;
@@ -112,6 +114,9 @@ static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
 static const struct csr_func csr_funcs[] = {
 	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+	KVM_RISCV_VCPU_TEST_CSR_FUNCS
+#endif
 	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
 };
 
diff --git a/arch/riscv/kvm/vcpu_test_csr.c b/arch/riscv/kvm/vcpu_test_csr.c
new file mode 100644
index 000000000000..b8aa503cdaba
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_test_csr.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_vcpu_insn.h>
+#include <asm/kvm_vcpu_test_csr.h>
+
+#define vcpu_to_test_csr(vcpu) (&(vcpu)->arch.test_csr)
+
+int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			    unsigned long *val, unsigned long new_val,
+			    unsigned long wr_mask)
+{
+	struct kvm_test_csr *test_csr = vcpu_to_test_csr(vcpu);
+
+	*val = test_csr->val;
+
+	if (wr_mask)
+		test_csr->val = (test_csr->val & ~wr_mask) | (new_val & wr_mask);
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}

-- 
2.54.0


