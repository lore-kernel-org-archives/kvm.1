Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC29535AC2B;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623597; cv=none; b=Hv4vy/qoBqtbaRJREe3x7F7oS6erMXgUwVuIzPjgKzSnuZvBmR5v226I9dYfqCuwnisyQ2vmprVZa6GY6e4kkBocKrpjkVJctgzYVkoHyKoT0x/+U6FfMmvo051TD3Cb8+eqJltVVFRCNt6+zfkADknCrpD3p4nDaXKTwvTMEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623597; c=relaxed/simple;
	bh=jD6rZIHBnAc3F0vl+05n+kzI241HhCjoZQe6JKFRv0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5uHRYw6mEA3yCdlPf/vW/ZEqU0Hu+nEY1LsERysnCkrKciKv/MoYosuZf96iIVf+yTsymstrhfM4ryuhCYzSKx7jDgOEF22hlkrcUx9aTnIFxyo8ZFkmjMghM6ikt71HYFdU2fM9SDA28psUAF/DRCL8ebfnrgDpqHbm3o90j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPXla7AB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPXla7AB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E523C19424;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775623597;
	bh=jD6rZIHBnAc3F0vl+05n+kzI241HhCjoZQe6JKFRv0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qPXla7AB2EtgSTJDuDTbb3N2x4I3R+WuXNUBuKc9fio1qRsnbJ/2hGSAdyt9QY8Yu
	 4kebme7GxctLviD4bdTvRzeeJ9Hn0EuedyVqIff/yR06jk6lL48hZW8xA+lX2bo7B7
	 38wF0/6P24n9Xd0DwFxjeBSlOAxxWDa+o7qQ3fTmRwCu3slDJguuap4AG8Nx6zBN2P
	 JzdhsSKwxskh2g4kso8fB+7OBzsAmM1EDYNibwJpBafSB/1KUZ3MJ4MkIxxsPOgUQg
	 E1jM9leU9y1HU1mm+P+MjYOFM/oe1u0vppkTzKdNjY4P1zj5YNUguKLxk/oCILebBV
	 mySlu7XfRIWVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96728FD5F68;
	Wed,  8 Apr 2026 04:46:37 +0000 (UTC)
From: Charlie Jenkins via B4 Relay <devnull+thecharlesjenkins.gmail.com@kernel.org>
Date: Tue, 07 Apr 2026 21:46:01 -0700
Subject: [PATCH 13/16] KVM: riscv: selftests: Add csr emulation test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-riscv_insn_table-v1-13-54b4736a1e77@gmail.com>
References: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
In-Reply-To: <20260407-riscv_insn_table-v1-0-54b4736a1e77@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Conor Dooley <conor@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775623594; l=4489;
 i=thecharlesjenkins@gmail.com; s=2026030; h=from:subject:message-id;
 bh=v0o+U8CrXApIBAL0UNGWmAnw7rvZN7PoEjmLiOgCLHI=;
 b=L9BrRpEMB+4Md2H09k6rx8pwpAEyxK+234nKTLHkVZk0ySxZHmX+h0Tj6VImR7JYn89yN3y3m
 pD0YEkL2f1GB5LtQLLU4Pv2EYgMixIOTtyDhwdREFLPv5Va0VsHccYR
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=vpF2USrG+aB6CTbSt34rzJKsAVe/l+GAXo1IomCMETk=
X-Endpoint-Received: by B4 Relay for thecharlesjenkins@gmail.com/2026030
 with auth_id=663
X-Original-From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Reply-To: thecharlesjenkins@gmail.com

From: Charlie Jenkins <thecharlesjenkins@gmail.com>

Introduce a kvm test that uses the emulated test csr to validate that
all emulated reads/writes to csrs function as expected.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm     |   1 +
 tools/testing/selftests/kvm/riscv/csr_test.c | 123 +++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d402fb339bc0..2eadab48186b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -202,6 +202,7 @@ TEST_GEN_PROGS_s390 += s390/user_operexec
 TEST_GEN_PROGS_s390 += rseq_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
+TEST_GEN_PROGS_riscv += riscv/csr_test
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
 TEST_GEN_PROGS_riscv += riscv/ebreak_test
 TEST_GEN_PROGS_riscv += riscv/mmio_test
diff --git a/tools/testing/selftests/kvm/riscv/csr_test.c b/tools/testing/selftests/kvm/riscv/csr_test.c
new file mode 100644
index 000000000000..432d043fa1ac
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/csr_test.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * csr_test.c - Tests the csr functionality.
+ */
+#include "kvm_util.h"
+#include "ucall_common.h"
+
+#define CSR_TEST 0x240
+#define FP 0x00006000
+
+/*
+ * Use the fcsr as a U-mode accesible csr and compare against the custom 'test'
+ * hypervisor csr (currently using vsscratch)
+ */
+#define test_csr(write, initial, mode)								\
+static void test_##write(void)									\
+{												\
+	unsigned long hypervisor_result, reference_result, old_hypervisor;			\
+	unsigned long mask = 0x15;								\
+	asm volatile (										\
+		"csrs	sstatus, %[enable_fp]\n"						\
+		"csrw	fcsr, %[init]\n"							\
+		#write"	zero, fcsr, %[mask]\n"							\
+		"csrr	%[ref_res], fcsr\n"							\
+		: [ref_res] "=&r" (reference_result)						\
+		: [enable_fp] "r" (FP), [mask] #mode(mask), [init] "r" (initial)		\
+		: "memory"									\
+	);											\
+	asm volatile (										\
+		"csrw	%[test_csr], %[init]\n"							\
+		#write"	%[old], %[test_csr], %[mask]\n"						\
+		"csrr	%[hyp_res], %[test_csr]\n"						\
+		: [hyp_res] "=&r" (hypervisor_result), [old] "=&r" (old_hypervisor)		\
+		: [test_csr] "i"(CSR_TEST), [mask] #mode(mask), [init] "r" (initial)		\
+		: "memory"									\
+	);											\
+	/* Check that writing works */								\
+	GUEST_ASSERT_EQ(reference_result, hypervisor_result);					\
+	/* Check that reading works */								\
+	GUEST_ASSERT_EQ(old_hypervisor, initial);						\
+	GUEST_DONE();										\
+}
+
+test_csr(csrrw, 0x0, r)
+test_csr(csrrs, 0x0, r)
+test_csr(csrrc, 0x15, r)
+test_csr(csrrwi, 0x0, i)
+test_csr(csrrsi, 0x0, i)
+test_csr(csrrci, 0x15, i)
+
+static void run(void *guest_code, char *instruction)
+{
+	struct ucall uc;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	kvm_create_device(vm, KVM_DEV_TYPE_TEST);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
+		    "CSR instruction '%s' failed: '%s'", instruction,
+		    uc.buffer);
+
+	kvm_vm_free(vm);
+}
+
+static void check_test_csr_guest(void)
+{
+	unsigned long scause, stvec;
+
+	asm volatile(
+		"la	%[stvec], 1f\n"
+		"csrw	stvec, %[stvec]\n"
+		"csrwi	%[test_csr], 0x0\n"
+		"1:\n"
+		"csrr	%[scause], scause\n"
+		: [scause] "=&r" (scause), [stvec] "=&r" (stvec)
+		: [test_csr] "i" (CSR_TEST)
+	);
+
+	/* An illegal instruction will be generated if CONFIG_RISCV_KVM_TEST_CSR is not enabled. */
+	if (scause == 2)
+		GUEST_FAIL("CONFIG_RISCV_KVM_TEST_CSR not enabled.\n");
+	GUEST_DONE();
+}
+
+static int check_test_csr(void)
+{
+	struct ucall uc;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int success;
+
+	vm = vm_create_with_one_vcpu(&vcpu, check_test_csr_guest);
+	kvm_create_device(vm, KVM_DEV_TYPE_TEST);
+
+	vcpu_run(vcpu);
+
+	success = get_ucall(vcpu, &uc) == UCALL_DONE;
+
+	kvm_vm_free(vm);
+
+	return success;
+}
+
+int main(void)
+{
+	/* Skip if CONFIG_RISCV_KVM_TEST_CSR not enabled */
+	if (!check_test_csr())
+		exit(KSFT_SKIP);
+
+	run(test_csrrw, "csrrw");
+	run(test_csrrs, "csrrs");
+	run(test_csrrc, "csrrc");
+	run(test_csrrwi, "csrrwi");
+	run(test_csrrsi, "csrrsi");
+	run(test_csrrci, "csrrci");
+
+	return 0;
+}

-- 
2.52.0


