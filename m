Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDD46EC76;
	Wed, 22 Jul 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705650; cv=none; b=Ja5lcfm34jevdAw0tbikE2vn1iiYbBdSWNwwicprIecDuN2YY/eFsh8ISa89+31XJ15ZxX/d+czbh6+9r1rExZOxWH0lnkF7FI2BFirm3Gzk6Q7xNVSGfS2byK4yt3YdhGcWGZJABTqY4U+Ho8YJxkK+Kc8ry6Ppzoy6p8j8onA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705650; c=relaxed/simple;
	bh=uFDfsjU0MQs2Eg+ze/m4oyeOgcK8qX2sxR4x8aX1Neo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzTUtQFMej+RPMr8PaqRM9q1uBFU4x0MpLF5rYZlbTomKfIyR+nFN/u7wjKvYoRMhHgQSckUYPmOW0hpdvQSpjgvHlZfx9Mf2sjaS5eVTBeorwuKyh/63U65lZgpcA3MzCOH+/jO/BMclsGUAcrptE/DcuXv/OhatuMW+3QnMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: zesmtpsz5t1784705630tb859c73b
X-QQ-Originating-IP: qoiGpSmq/wVHuR9h8at8YO36cWRH2WORRlrkXCG+RvA=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Jul 2026 15:33:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10989275502336654131
EX-QQ-RecipientCnt: 14
From: JinRui <jinrui@haiwei.tech>
To: Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jinrui <jinrui@haiwei.tech>
Subject: [PATCH v8] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Wed, 22 Jul 2026 07:33:44 +0000
Message-ID: <33AEC00DC78613A1+20260722073344.771230-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722062804.738428-1-jinrui@haiwei.tech>
References: <20260722062804.738428-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MO1HcJ6CTmFsdpa4k33r2vL5PWbEEr4TJRQx0miX+yr9PR6MtMUuIwAR
	vhbmNkBNFvVxqtetvwyOb1Bndo5HxsHl+l2nGAaqG6GZuXyryJwyXEwV3a64iaL7cjKn/Ww
	E+BWp37kVnsmMgYmPJIMpMvzBujh3/xvUU1IMverRq63EHl3VprFfQ1Br/hS8Og+aRrOblI
	j9MFyJkKS9XKY4AC/hIod21GLCZ+8UXW3E9RS3OeF259LYH31hHWEjkyyVzObI7VTx/Igaz
	U3qWOqsk0cKe0rB3rk8g6XhKurUIZEMmZCyhwDwux6J2VNqQbNxH7GmpOgD3pCQbqcXP6FB
	e9nihwYJf2GI+fgin/x2UT0oDoO4bbrs2QncEEWKDMbaNsFRiqt6SBBrLguEDtfiYKIpC/5
	PzEnLDOerUN61NOyCxsNEhQA3xZCnRCU4ZAsXUAbCCzpt2Qboz5bHHMB9uGkk2l6xQCnnqU
	tUW7Ia18QF8Yx2rfSNMcoZR/jDG2uw6jytV97dFKii1K22JzhM1vCvIvh+ybiKi+qV1o88l
	Mit+wzbzeU3eRqyKe6SBS2oGrt/D0olZ4Nbyn5DdS09GxBKB2n2oWjVPJYYL8hNwoRDD9ZT
	33IK08m/WWUTrwzi+ATjSZVIqKMD2zI5TFj0nObuAMW6ztMOyckRBH5YYDbnoS+OHM4K33H
	0g0FDPIpVqmeTRzI1pwQIgiE/ppi8kezfjKyGILNF3RSP41g0asYrKd5X33tI9oyBmOl037
	Lh5TDaFBFOuYa3JKf/sOPM2mL7KYlZduTsfoJibQQlI3hY+h4l4rTJYkXQFPhr1ROGpgiWj
	xK8N7prdkbuuBnXMqlbCCAnwVL78bCsr0iijxn3dPmcGAawMapMREBipCmIkuHaqqs1kMzX
	m4AslL2ihnIb+pOMBybYD6WNxsD3y/T6rkJU3E0SKhRhtBXgrzp2ZygmWDOhG9SzuDQa043
	somzIyz10vjhdBPqlgkV1QbOt7FISL8NSuZgJ4AeQDPAPscdjJzg4spGO3O+Vjsooyp2KRE
	xXM5ab+eAnoxdUHrxOOMWvXHW6pAXxLE09uYGXJtKpYkyrklCU
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

From: jinrui <jinrui@haiwei.tech>

When the cross-compiler defaults to an -march that includes the V
(vector) extension, -O2 auto-vectorization generates vector
instructions (e.g. vsetvli, vadd.vv) in Guest binary code. If the
Guest executes a vector instruction while sstatus.VS is Off, an
EXC_INST_ILLEGAL (scause=2) is raised. KVM's hedeleg delegates this
exception to the Guest, but the selftest has no way to handle it as a
bare-metal program, causing all Guest tests to fail.

In contrast, a real OS kernel handles this via riscv_v_first_use_handler(),
which detects the vector instruction, sets sstatus.VS to Initial, and
srets to re-execute.

Fix this with four changes in processor.c:

1. Delete the now-unused guest_unexp_trap() handler, which is replaced
   by the full exception vector table.

2. In vm_arch_vcpu_add(), notify KVM that the Guest is allowed to use
   the V extension via __vcpu_set_reg(V, 1) (best-effort, silently
   ignores errors on hardware without V). Also replace the raw stvec
   handler with the full exception vector table, which provides
   save_context/restore_context for safe lazy enablement.

3. In route_exception(), add a lazy V enablement check that runs
   before any test-registered handler. When the cause is a non-IRQ
   EXC_INST_ILLEGAL and sstatus.VS is Off, set VS to Initial and
   return so the faulting instruction is re-executed via sret.
   Track the epc per-vCPU via a flexible array member to avoid
   infinite loops on hardware without V and eliminate races between
   concurrent vCPUs.

4. Make vm_init_vector_tables() idempotent by checking vm->handlers
   before allocation, so tests that manually call it (ebreak_test,
   arch_timer, sbi_pmu_test) do not leak memory.

The check runs before test-registered EXC_INST_ILLEGAL handlers
(e.g. sbi_pmu_test) to ensure V enablement takes priority.

Tested on a riscv64 host with KVM enabled: all 20 KVM selftest
binaries pass (arch_timer, ebreak_test, steal_time, get-reg-list,
sbi_pmu_test, etc.).

Signed-off-by: jinrui <jinrui@haiwei.tech>
---
Changes in v8:
- Change 'ec' in route_exception() from int to unsigned long to
  match regs->cause (unsigned long), preventing signed truncation
  from bypassing the ec >= NR_EXCEPTIONS bounds check.

Changes in v7:
- Use unsigned int for vcpu_id, v_epc_capacity, and max_vcpus to
  prevent negative-value out-of-bounds array access on v_epc[].

Changes in v6:
- Move struct handlers definition to the top of the file, before its
  first use in vm_arch_vcpu_add().

Changes in v5:
- Allocate the per-vCPU epc table dynamically via a flexible array
  member sized by KVM_CAP_MAX_VCPUS rather than a hardcoded constant,
  making the concurrency fix safe for any vCPU count.

Changes in v4:
- Add vcpu_dump() in assert_on_unhandled_exception() to restore the
  register dump lost when guest_unexp_trap() was removed.

Changes in v3:
- Move v_available from a host-side static variable into struct
  handlers (Guest memory), fixing host-to-Guest synchronization.

Changes in v2:
- Add a v_available flag to prevent infinite exception loops on
  hosts without the V extension.
- Use regs->status instead of reading the live sstatus CSR.
---
 .../selftests/kvm/lib/riscv/processor.c       | 111 +++++++++++++++---
 1 file changed, 95 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..624f20f0f476 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -17,6 +17,13 @@
 
 static gva_t exception_handlers;
 
+struct handlers {
+	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+	bool v_available;
+	unsigned int v_epc_capacity;
+	unsigned long v_epc[];
+};
+
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, u64 ext)
 {
 	unsigned long value = 0;
@@ -297,14 +304,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 		" T3: 0x%016lx   T4: 0x%016lx T5: 0x%016lx T6: 0x%016lx\n",
 		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
 }
-
-static void __aligned(16) guest_unexp_trap(void)
-{
-	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
-		  KVM_RISCV_SELFTESTS_SBI_UNEXP,
-		  0, 0, 0, 0, 0, 0);
-}
-
 void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 {
 	vcpu_set_reg(vcpu, RISCV_CORE_REG(regs.pc), (unsigned long)guest_code);
@@ -348,8 +347,33 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	/* Setup sscratch for guest_get_vcpuid() */
 	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(sscratch), vcpu_id);
 
-	/* Setup default exception vector of guest */
-	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
+	/*
+	 * Enable the V (vector) extension in KVM so that the compiler can
+	 * safely generate vector instructions (e.g. via -O2 auto-
+	 * vectorization). Silently ignore errors; the test will still work
+	 * without V.
+	 */
+	__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_V), 1);
+
+	/*
+	 * Use the full exception vector table (which provides lazy V
+	 * extension enablement for EXC_INST_ILLEGAL in route_exception)
+	 * as the default exception handler. vm_init_vector_tables() is
+	 * idempotent; tests that call it again will get a no-op.
+	 */
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
+
+	/*
+	 * Record V extension availability in the handlers struct so that
+	 * route_exception() (called from Guest context) can check it
+	 * without relying on a host-side global variable.
+	 */
+	{
+		struct handlers *h = addr_gva2hva(vm, vm->handlers);
+
+		h->v_available = __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);
+	}
 
 	return vcpu;
 }
@@ -408,19 +432,17 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		vcpu_dump(stderr, vcpu, 2);
 		TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)",
 			uc.args[0], uc.args[1]);
 	}
 }
 
-struct handlers {
-	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
-};
-
 void route_exception(struct pt_regs *regs)
 {
 	struct handlers *handlers = (struct handlers *)exception_handlers;
-	int vector = 0, ec;
+	int vector = 0;
+	unsigned long ec;
 
 	ec = regs->cause & ~CAUSE_IRQ_FLAG;
 	if (ec >= NR_EXCEPTIONS)
@@ -432,6 +454,46 @@ void route_exception(struct pt_regs *regs)
 		ec = 0;
 	}
 
+	/*
+	 * Handle V (vector) extension lazy enablement before any
+	 * registered handler. The compiler's default march may include
+	 * V, and auto-vectorization generates vector instructions that
+	 * trigger EXC_INST_ILLEGAL when VS (Vector Status) in sstatus
+	 * is Off. Enable VS to Initial and re-execute the faulting
+	 * instruction, mimicking what a real OS kernel does.
+	 *
+	 * This check runs before any test-registered handler, so tests
+	 * that install their own EXC_INST_ILLEGAL handler (e.g.
+	 * sbi_pmu_test) are not affected.
+	 */
+	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec == EXC_INST_ILLEGAL) {
+		/*
+		 * If KVM supports the V extension for this Guest and VS
+		 * (Vector Status) is Off in the saved sstatus, set it to
+		 * Initial and re-execute the faulting instruction.
+		 *
+		 * Use regs->status (saved at exception entry) rather than
+		 * reading the live CSR to avoid a TOCTOU race.
+		 *
+		 * Track the epc per-vCPU to avoid an infinite loop when
+		 * V is disabled or the hardware rejects the VS change.
+		 * Using a per-vCPU array avoids races between concurrent
+		 * vCPUs that would occur with a single shared (epc, vcpu)
+		 * pair.
+		 */
+		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
+			unsigned int vcpu_id;
+
+			asm volatile("csrr %0, sscratch" : "=r" (vcpu_id));
+			if (vcpu_id < handlers->v_epc_capacity &&
+			    handlers->v_epc[vcpu_id] != regs->epc) {
+				handlers->v_epc[vcpu_id] = regs->epc;
+				regs->status |= SR_VS_INITIAL;
+				return;
+			}
+		}
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,9 +510,26 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
-	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
+	unsigned int max_vcpus;
+	size_t size;
+
+	if (vm->handlers)
+		return;
+
+	max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	if (max_vcpus == 0)
+		max_vcpus = 512;
+
+	size = sizeof(struct handlers) + max_vcpus * sizeof(unsigned long);
+	vm->handlers = __vm_alloc(vm, size, vm->page_size,
 				  MEM_REGION_DATA);
 
+	{
+		struct handlers *h = addr_gva2hva(vm, vm->handlers);
+
+		h->v_epc_capacity = max_vcpus;
+	}
+
 	*(gva_t *)addr_gva2hva(vm, (gva_t)(&exception_handlers)) = vm->handlers;
 }
 
-- 
2.43.0

