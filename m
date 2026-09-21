Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40361493D44;
	Mon, 21 Sep 2026 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993648; cv=none; b=BOuLi0FXPuDYfyg217r18hAklHSXtYKhEo+7WJdYSDhkmg2/zc+3+MLxWxLnjvXJv/MZAcM/dFvuKiaO0PbQMv7LsO8zolNbx6q1Bkx3bN4v4MeXaUOzGcYc36UHWGbkJt7VuUn+lY4MgNkjnuO62TPoQEw0AC4DDMJG5JhCccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993648; c=relaxed/simple;
	bh=nlX8+ZEvmtGvscRdSJ9FwPw4/iLV4sfdeuARDFxL3SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuTQZPPo2UuP5cZ7IXJfub4xhZ3IWl+wJBfQl1F8ziieJ+OqEeswdFfQyidWYBvhjXWoNvJCVN6Zl40AXDuzei7e2y2xJrhvrgRScWI3uLqmryt4b3bL6L2mdD5s/GP+fSDajEkNWoelPmRzS9tEG+aR2KyFGoPplcrgDLidS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z601kbIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z601kbIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3511F00893;
	Mon, 21 Sep 2026 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789993646;
	bh=dFvHrjq0ePXXh5iBLlUENtWHcaZyZBRhrnp1IAHS2tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z601kbIa9VSfIfHNKTEpmBalJufxQA/bArlgRDVF37yrMBOBoyWhpgkWJ+Xut1PKi
	 o6gEp2mkBaghr4j1DpATyzKBQp8qZURn6Tk7m/fmazSpf80LqYSkrFxphZ6oomow1I
	 5eWkwReNwMc84goCHDydh0J8BbTrCBIbjqpyREhZpOv5nZiN9qUOqlnqYSHpqd4Sr2
	 hnoXYXL+c4TqRz3nxQofwUHM5o9qn5+6FXmGnQiPUzFMlE8Kv+JqPCvuuYXZApTZ3a
	 ifkNNg8icwnqKOL8v+vqV9bRlwaOFIckKtpCQPVzreuSnB7DiB4SyRneQ4+dlrs4UV
	 1DOwgBQDoZlOQ==
From: "GUO Ren (XuanTie)" <guoren@kernel.org>
Date: Mon, 21 Sep 2026 12:27:01 +0000
Subject: [PATCH RFC v4 1/4] RISC-V: paravirt: Add pvqspinlock KVM backend
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-pvqspinlock-v4-1-409a22aed6ef@kernel.org>
References: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
In-Reply-To: <20260921-pvqspinlock-v4-0-409a22aed6ef@kernel.org>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
 CHEN Jiankang <yubin.cjk@alibaba-inc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Leonardo Bras <leobras@redhat.com>, 
 "GUO Ren (XuanTie)" <guoren@kernel.org>
X-Mailer: b4 0.16.0

Add the KVM backend for the SBI PVLOCK (paravirt qspinlock kick_cpu)
extension. kvm_sbi_ext_pvlock_kick_cpu() kicks the target vCPU out of
the halted state via kvm_vcpu_kick(), and yields to it with
kvm_vcpu_yield_to() when the target is already runnable.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h |  1 +
 arch/riscv/include/asm/sbi.h          |  5 ++++
 arch/riscv/include/uapi/asm/kvm.h     |  1 +
 arch/riscv/kvm/Makefile               |  1 +
 arch/riscv/kvm/vcpu_sbi.c             |  4 +++
 arch/riscv/kvm/vcpu_sbi_pvlock.c      | 54 +++++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index f01a2860c751..cdc16e64ad19 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -114,6 +114,7 @@ extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_fwft;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_mpxy;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_experimental;
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_vendor;
+extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pvlock;
 
 #ifdef CONFIG_RISCV_PMU_SBI
 extern const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pmu;
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 5725e0ca4dda..724ab834ad85 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -38,6 +38,7 @@ enum sbi_ext_id {
 	SBI_EXT_FWFT = 0x46574654,
 	SBI_EXT_MPXY = 0x4D505859,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_PVLOCK = 0x50564C4B,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -534,6 +535,10 @@ union sbi_dbtr_shmem_entry {
 	struct sbi_dbtr_id_msg id;
 };
 
+enum sbi_ext_pvlock_fid {
+	SBI_EXT_PVLOCK_KICK_CPU = 0,
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index 20d9959ca44f..110a0d62113f 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -228,6 +228,7 @@ enum KVM_RISCV_SBI_EXT_ID {
 	KVM_RISCV_SBI_EXT_SUSP,
 	KVM_RISCV_SBI_EXT_FWFT,
 	KVM_RISCV_SBI_EXT_MPXY,
+	KVM_RISCV_SBI_EXT_PVLOCK,
 	KVM_RISCV_SBI_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05089..404a4c5f8984 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -38,6 +38,7 @@ kvm-y += vcpu_sbi_sta.o
 kvm-y += vcpu_sbi_system.o
 kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
 kvm-y += vcpu_switch.o
+kvm-y += vcpu_sbi_pvlock.o
 kvm-y += vcpu_timer.o
 kvm-y += vcpu_vector.o
 kvm-y += vm.o
diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index 1c4f874368fb..07f72e619fd5 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -94,6 +94,10 @@ static const struct kvm_riscv_sbi_extension_entry sbi_ext[] = {
 		.ext_idx = KVM_RISCV_SBI_EXT_VENDOR,
 		.ext_ptr = &vcpu_sbi_ext_vendor,
 	},
+	{
+		.ext_idx = KVM_RISCV_SBI_EXT_PVLOCK,
+		.ext_ptr = &vcpu_sbi_ext_pvlock,
+	},
 };
 
 static const struct kvm_riscv_sbi_extension_entry *
diff --git a/arch/riscv/kvm/vcpu_sbi_pvlock.c b/arch/riscv/kvm/vcpu_sbi_pvlock.c
new file mode 100644
index 000000000000..728e59f3f18f
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_sbi_pvlock.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 GUO Ren (XuanTie) <guoren@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <asm/sbi.h>
+#include <asm/kvm_vcpu_sbi.h>
+
+static int kvm_sbi_ext_pvlock_kick_cpu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *target;
+
+	target = kvm_get_vcpu_by_id(kvm, cp->a0);
+	if (!target)
+		return SBI_ERR_INVALID_PARAM;
+
+	kvm_vcpu_kick(target);
+
+	if (READ_ONCE(target->ready))
+		kvm_vcpu_yield_to(target);
+
+	return SBI_SUCCESS;
+}
+
+static int kvm_sbi_ext_pvlock_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
+				      struct kvm_vcpu_sbi_return *retdata)
+{
+	int ret = 0;
+	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
+	unsigned long funcid = cp->a6;
+
+	switch (funcid) {
+	case SBI_EXT_PVLOCK_KICK_CPU:
+		ret = kvm_sbi_ext_pvlock_kick_cpu(vcpu);
+		break;
+	default:
+		ret = SBI_ERR_NOT_SUPPORTED;
+	}
+
+	retdata->err_val = ret;
+
+	return 0;
+}
+
+const struct kvm_vcpu_sbi_extension vcpu_sbi_ext_pvlock = {
+	.extid_start = SBI_EXT_PVLOCK,
+	.extid_end = SBI_EXT_PVLOCK,
+	.handler = kvm_sbi_ext_pvlock_handler,
+};

-- 
2.43.0

