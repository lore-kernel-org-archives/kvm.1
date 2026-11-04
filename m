Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782210;
	b=s82g5XzlN+7H1H64YPI1ARdiUbCDPxvPZBFaSJ5UT4TftBCvvGFl7w3YEw7xn21XQOtF
	 yv7RNT4ooWclMjmWSwMXApu4LuvuE9i5D9EPgpeS2gkT1IMUgN+XFMmEW+1VtXD4oQ+R7
	 iYu/BJPwNv7rSNvzMo/JVFriEveI4Fdflkfmy86qAzV4oNXtgBOqQKK5w26pY5haxLSzT
	 rN6uK+9IKoVppkDXurO8kk9YnRqPRVHwAV/+7FRNku99h/v0Y8XPOhzig83giLkSfMETW
	 DT9NmXNLGf4g3SdLkZLjBayLRMCGAfvnSjFY4NTdJ/7eKNNq/kZeZkVekfI/Rg/fPIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782210;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k6cFiPxDKZRgK9kMm6ffD3lcFe9pofTaWFF6Z8LHBvA=;
	b=hh5oN/x8hhBPDNltzxLsxSM/k6Lk5lmW/XNlpTN17YhIT8dHtORzjygpgubm+j3zoGrv
	 QFHCBOB2mmIauzd+ZlWqqiD+yvAs711xdQNlQuxCzk+StcterO2MXAc6xVZvB4I4XC5Iy
	 UxZCC0AjqZzJzepDg2EF+/YMls+v75slk3C/pWQETukwlN2xCRDu69Ed9NE4VIZp5pL8e
	 fMFHPA3dQlqY0vINNeVkCkC08wjVA21e0IzaPxABmGgPfuVgr+OFA3LtHkbKCOWywHklH
	 AuhpGD2qsgSQ5k9GJtNfiu4LtPSbeTxqmyxU1ZAjQLxNLrgi8b9l3QraX6dAkTbHi5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PowOMSN5;
	arc=none smtp.remote-ip=95.215.58.184
Received: from mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3B606A338
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 08:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B3B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PowOMSN5
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IhkYbzhiK9uOMZTCAa9N1LaNA5uVBTFupFJmfgNvMLQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793782207; v=1; x=1794387007;
 b=PowOMSN57XHcsi6ghMGJUA7es/pqdtbkTm5370VlKFHoj5T90RWHEWfGtiZaXGb4NrADCPY8
 WZYTffx+q4sp9ElPm/pUpzIhxmpVJ7NLe0Ss6PeLwPS3ZlRi6SbkVuXRqY9NQfq++Iy/eYaBCPH
 X5ixV3Vqk7wDBmzrLvjILnb8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 16f814717aa144a4;
	Wed, 04 Nov 2026 08:50:06 +0000
X-Mizu-Trace-ID: 16f814717aa144a4
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] KVM: arm64: selftests: Add pkvm_vcpu_regs register-state test
Date: Wed,  4 Nov 2026 08:48:38 +0000
Message-ID: <20261104084842.132944-13-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104084842.132944-1-fuad.tabba@linux.dev>
References: <20261104084842.132944-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A protected vCPU's registers are held at EL2, which handles some exits
itself and returns others to the host. The host can move the vCPU's
thread to another CPU at any exit. The guest's registers have to keep
their values through all of that.

Verify that x19-x28 and v0-v31 keep the values the guest loaded across
each kind of exit, and across a host CPU migration at every MMIO exit.

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/arm64/pkvm_vcpu_regs.c      | 221 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/arm64/pkvm_vcpu_regs.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8855c9abb2fd0..1e40e793aa6f3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -195,6 +195,7 @@ TEST_GEN_PROGS_arm64 += arm64/pkvm_id_regs
 TEST_GEN_PROGS_arm64 += arm64/pkvm_mem_share
 TEST_GEN_PROGS_arm64 += arm64/pkvm_psci
 TEST_GEN_PROGS_arm64 += arm64/pkvm_smccc
+TEST_GEN_PROGS_arm64 += arm64/pkvm_vcpu_regs
 TEST_GEN_PROGS_arm64 += arm64/psci_test
 TEST_GEN_PROGS_arm64 += arm64/sea_to_user
 TEST_GEN_PROGS_arm64 += arm64/set_id_regs
diff --git a/tools/testing/selftests/kvm/arm64/pkvm_vcpu_regs.c b/tools/testing/selftests/kvm/arm64/pkvm_vcpu_regs.c
new file mode 100644
index 0000000000000..a9b9615a9075b
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/pkvm_vcpu_regs.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pkvm_vcpu_regs - a protected guest's registers across every kind of exit.
+ *
+ * Copyright (C) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ */
+
+#include <errno.h>
+#include <sched.h>
+
+#include "kvm_util.h"
+#include "pkvm.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* Accesses to this IPA, outside every memslot, exit to the VMM as MMIO. */
+#define MMIO_IPA	BIT_ULL(31)
+#define MMIO_READ_VAL	0x0123456789abcdefUL
+
+/* One new host page per stage-2 fault. */
+#define FAULT_MEMSLOT	(PKVM_IDMAP_MEMSLOT + 1)
+#define FAULT_GPA	BIT_ULL(30)
+
+#define NR_EXITS	64
+
+enum exit_kind {
+	EXIT_MMIO_WRITE,
+	EXIT_MMIO_READ,
+	EXIT_HVC,
+	EXIT_SYSREG_EL2,
+	EXIT_SYSREG_HOST,
+	EXIT_S2_FAULT,
+	NR_EXIT_KINDS,
+};
+
+static const char * const exit_kind_names[] = {
+	[EXIT_MMIO_WRITE]	= "MMIO writes to the VMM",
+	[EXIT_MMIO_READ]	= "MMIO reads from the VMM",
+	[EXIT_HVC]		= "hypercalls EL2 handles",
+	[EXIT_SYSREG_EL2]	= "sysreg traps EL2 handles",
+	[EXIT_SYSREG_HOST]	= "sysreg traps the host handles",
+	[EXIT_S2_FAULT]		= "stage-2 faults on new memory",
+};
+
+/* x19-x28, v0-v31, then what the exit left in x0. */
+struct reg_state {
+	u64 x[10];
+	u64 v[32][2];
+	u64 x0;
+};
+
+#define REG_WORDS	(offsetof(struct reg_state, x0) / sizeof(u64))
+
+static_assert(offsetof(struct reg_state, v) == 80, "v0 offset");
+static_assert(offsetof(struct reg_state, x0) == 592, "x0 offset");
+
+#define X_REGS	"19, 20, 21, 22, 23, 24, 25, 26, 27, 28"
+#define V_REGS	"0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, "		\
+		"16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31"
+
+/* @op x19-x28 and v0-v31 at their struct reg_state offsets from @buf. */
+#define REGS_OP(op, buf)								\
+	".irp num, " X_REGS "\n" op "	x\\num, [%[" buf "], #8 * (\\num - 19)]\n.endr\n"	\
+	".irp num, " V_REGS "\n" op "	q\\num, [%[" buf "], #80 + 16 * \\num]\n.endr\n"
+
+/* Load the registers, take the exit @insn causes, and store them again. */
+#define REGS_ACROSS(insn, addr)								\
+({											\
+	asm volatile(REGS_OP("ldr", "in") insn "\n" REGS_OP("str", "out")		\
+		     "str	x0, [%[out], #592]\n"						\
+		     : : [in] "r"(&regs_in), [out] "r"(&regs_out), [arg] "r"(addr)		\
+		     : "x0", "x1", "x2", "x3",						\
+		       "x19", "x20", "x21", "x22", "x23", "x24", "x25", "x26", "x27", "x28",	\
+		       "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",			\
+		       "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",		\
+		       "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",		\
+		       "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",		\
+		       "memory");							\
+})
+
+/* Set in the guest's copy by the host before the first run. */
+static int exit_kind;
+static u64 host_page_size;
+
+static struct reg_state regs_in, regs_out;
+
+static void guest_regs_across_exits(void)
+{
+	u64 *in = (u64 *)&regs_in, *out = (u64 *)&regs_out;
+	int i, j;
+
+	pkvm_guest_init();
+
+	for (i = 0; i < NR_EXITS; i++) {
+		/* Different in every word and on every exit. */
+		for (j = 0; j < REG_WORDS; j++)
+			in[j] = 0x0101010101010101UL * (j + 1) ^ (u64)i << 32;
+
+		switch (exit_kind) {
+		case EXIT_MMIO_WRITE:
+			REGS_ACROSS("str	x0, [%[arg]]", MMIO_IPA);
+			break;
+		case EXIT_MMIO_READ:
+			REGS_ACROSS("ldr	x0, [%[arg]]", MMIO_IPA);
+			GUEST_ASSERT_EQ(regs_out.x0, MMIO_READ_VAL);
+			break;
+		case EXIT_HVC:
+			REGS_ACROSS("mov	w0, #0x80000000\n hvc	#0", 0);
+			break;
+		case EXIT_SYSREG_EL2:
+			REGS_ACROSS("mrs	x0, id_aa64pfr0_el1", 0);
+			break;
+		case EXIT_SYSREG_HOST:
+			REGS_ACROSS("mrs	x0, clidr_el1", 0);
+			break;
+		case EXIT_S2_FAULT:
+			REGS_ACROSS("str	x0, [%[arg]]", FAULT_GPA + i * host_page_size);
+			break;
+		}
+
+		for (j = 0; j < REG_WORDS; j++)
+			__GUEST_ASSERT(out[j] == in[j], "exit %d: %s%d is 0x%lx, not 0x%lx", i,
+				       j < 10 ? "x" : "v", j < 10 ? 19 + j : (j - 10) / 2,
+				       out[j], in[j]);
+	}
+
+	GUEST_DONE();
+}
+
+static cpu_set_t host_cpus;
+
+/* Move this thread, and with it the vCPU's next run, to another of its CPUs. */
+static void migrate_thread(void)
+{
+	int cpu = sched_getcpu();
+
+	do
+		cpu = (cpu + 1) % CPU_SETSIZE;
+	while (!CPU_ISSET(cpu, &host_cpus));
+
+	pin_self_to_cpu(cpu);
+	TEST_ASSERT_EQ(sched_getcpu(), cpu);
+}
+
+static void run_regs_across_exits(struct kvm_vcpu *vcpu, bool migrate)
+{
+	struct kvm_run *run = vcpu->run;
+	u64 data = MMIO_READ_VAL;
+	struct ucall uc;
+
+	for (;;) {
+		vcpu_run(vcpu);
+
+		if (run->exit_reason == KVM_EXIT_MMIO && run->mmio.phys_addr == MMIO_IPA) {
+			if (!run->mmio.is_write)
+				memcpy(run->mmio.data, &data, sizeof(data));
+			if (migrate)
+				migrate_thread();
+			continue;
+		}
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			return;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		default:
+			TEST_FAIL("Unexpected exit: %s", exit_reason_str(run->exit_reason));
+		}
+	}
+}
+
+/* With @migrate, the vCPU moves to another host CPU at every MMIO exit. */
+static void test_regs_across_exits(enum exit_kind kind, bool migrate)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned int npages;
+	struct kvm_vm *vm;
+
+	vm = pkvm_vm_create_with_one_vcpu(&vcpu, guest_regs_across_exits);
+	npages = NR_EXITS * getpagesize() / vm->page_size;
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, FAULT_GPA, FAULT_MEMSLOT, npages, 0);
+	virt_map(vm, FAULT_GPA, FAULT_GPA, npages);
+	virt_map(vm, MMIO_IPA, MMIO_IPA, 1);
+	write_guest_global(vm, exit_kind, kind);
+	write_guest_global(vm, host_page_size, getpagesize());
+
+	run_regs_across_exits(vcpu, migrate);
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	int kind;
+
+	TEST_REQUIRE(pkvm_supported());
+
+	ksft_print_header();
+	ksft_set_plan(1 + NR_EXIT_KINDS);
+
+	for (kind = 0; kind < NR_EXIT_KINDS; kind++) {
+		test_regs_across_exits(kind, false);
+		ksft_test_result_pass("x19-x28 and v0-v31 across %s\n", exit_kind_names[kind]);
+	}
+
+	TEST_ASSERT(!sched_getaffinity(0, sizeof(host_cpus), &host_cpus),
+		    "sched_getaffinity: errno %d", errno);
+	if (CPU_COUNT(&host_cpus) < 2) {
+		ksft_test_result_skip("x19-x28 and v0-v31 across host CPU migrations: one CPU\n");
+	} else {
+		test_regs_across_exits(EXIT_MMIO_WRITE, true);
+		TEST_ASSERT(!sched_setaffinity(0, sizeof(host_cpus), &host_cpus),
+			    "sched_setaffinity: errno %d", errno);
+		ksft_test_result_pass("x19-x28 and v0-v31 across host CPU migrations\n");
+	}
+
+	ksft_finished();
+}
-- 
2.47.3

