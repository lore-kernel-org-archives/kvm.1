Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364B36A009;
	Tue, 21 Jul 2026 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631494; cv=none; b=ABDqNLfqiXArE0NKDW2gA7HQa4dIItO7rjXWpb1fBBiWdjngKZdwWp44bbT2MB/gTxXEQanq0agLKaYlEv3Y+gO77yUFabwQEiBh+YAB4LVgsCo/bncPNwrurjcE0hG4sNWZMh4gWpWBkuZJxWAodR3jwYJcAnak8pZfx924h5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631494; c=relaxed/simple;
	bh=C9i7oJgmwyDacT2oC9e5xhsXG1haAhuSRFvL3DR9R1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZTg1t8xK8cFAoPXBDAfOnk94D/Qg3GB7ZGBSW9TNkxB5VDfzx6+qu7B3NBOlEezo1CSEysqX7MRSEXRb0kduViwIpmobSBt+3ipTRLaFt1GI0ReZsJ4fuRPYEAMw40WWKRNpxYtwP4y68Bmmn/+dqfz84Gy/WtZ01xLzwpSXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: esmtpsz19t1784631473t8bd3dbd8
X-QQ-Originating-IP: zVGL0MIEiXwbehjZG6FBDiiLZOrsJoGfOatAdd6SQLw=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 18:57:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4376131265427308852
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
Subject: [PATCH v2] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Tue, 21 Jul 2026 10:57:36 +0000
Message-ID: <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
References: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OVFdYp27KdlJss+1XMr0N52sC8l2KueFkzEG6WBwSB7fCP/GB+LowRW6
	DumEkAbz0Se+C4zqpMV3MXWFw8upIG8b0va503Fe0gKWoQhP00/4WBCwgjZogXfUxTHU0p4
	0lrhHIN6oxfMDvZzBCMlNn2/QS7LbazPhs+3j7Hyyd7CIaZLczQYj5hdpQO69wBrswGiTkJ
	TSWWy3gJ0zlTeniLkbIgo0v/aJN2u7PeXU0+J0eC8Ut9a7F1IgmV90WRWNCkQTNZsKmQVP1
	AmBJj38LVBiNzZAo7pfnCNsoc5mYxFQLwOH/O9VA6+Z4UPlwYf8llQHSDxQtZiSrvvvayGE
	0s7ztW4OL+EecJrAee5RN+8ObvgTEXeporTgXLilsptUSIbR3jPrLQh7QPpzCSamv0vbKYO
	Yaa6Beb9zG0dr6S83T7wHC2uB4polxYKiDzaYnD05AudbhQhx+gMplRVXOrAky8aGlOVWMR
	xIAjAvrbkOMxjdqGvuZn5PKNktvi7/a4sC0HgPT3N4TQ6ZQi1vS4Yy2bKoMHYHkijesf+qA
	y6KDaEI8pM+9ZTIT++BEq0kQnnMGSUu81YqxA2f/yCMKiHm90f1RCt/0MRBEDfOXMSatkAf
	KGTzoXea7yxiGKd0Lt0sbG213QrwVnv84EUnyjpH/AtvHlbcZ+277NSerUmdD3wpX2cCTJU
	6p1aieKiONZymgZYt1X/g8kLDgV7U2nVqjW+lATHdywlDQVVxj3Bz5JRp6HsoIGAKnHU/E6
	yESakmhME3pNhSqm1RGYe7Z8CNo//ICPHdMoh7F09uKA/53dVWyMWRJaC/UrirUoqh4P9YB
	t/9am1TNqg2qKKkRPBtTpx6zCnHSDgEg+uc8O9jXy8xc2p27J5eC4dUQN2LfhI7y6IjY8q2
	gGyVfEBds1M4yCrOn0pNiYcMvUwPfgVRbeh6+pPzUPdrx6K446FvVLyjqnwBjTli8rrjMwz
	hQjyVyej6/fRjoHfg69r6d8xtjfb0gBoxmnIvzKC6r6egJOlwqXlBQz7rqugTd9lZtCBOYH
	h2a05PTW1hTvRRuCDsRVET+ysPIFFJVO811U2aw3uqNB1mPEcvHMYwewWQy5SGm/B9IIFyM
	ezm4p39NrqQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

4. Make vm_init_vector_tables() idempotent by checking vm->handlers
   before allocation, so tests that manually call it (ebreak_test,
   arch_timer, sbi_pmu_test) do not leak memory.

The check runs before test-registered EXC_INST_ILLEGAL handlers
(e.g. sbi_pmu_test) to ensure V enablement takes priority.

Tested on a riscv64 host with KVM enabled: all 12 KVM selftest
binaries pass.

Signed-off-by: jinrui <jinrui@haiwei.tech>
---
Changes in v2:
- Add a v_available flag to guard lazy V enablement on hosts that do
  not support the V extension, preventing an infinite exception loop
  when an illegal instruction is executed.
- Use regs->status (preserved at exception entry by save_context)
  instead of reading the live sstatus CSR, avoiding a TOCTOU race with
  nested exceptions.

 .../selftests/kvm/lib/riscv/processor.c       | 60 +++++++++++++++----
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..62efd07e5639 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -17,6 +17,9 @@
 
 static gva_t exception_handlers;
 
+/* True if KVM allows the Guest to use the V (vector) extension */
+static bool v_available;
+
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, u64 ext)
 {
 	unsigned long value = 0;
@@ -297,14 +300,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
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
@@ -348,8 +343,23 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
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
+	v_available = __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);
+
+	/*
+	 * Use the full exception vector table (which provides lazy V
+	 * extension enablement for EXC_INST_ILLEGAL in route_exception)
+	 * as the default exception handler. vm_init_vector_tables() is
+	 * idempotent; tests that call it again will get a no-op.
+	 */
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
 
 	return vcpu;
 }
@@ -432,6 +442,33 @@ void route_exception(struct pt_regs *regs)
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
+		 * Initial and sret to re-execute the faulting instruction.
+		 * Use regs->status (saved at exception entry) rather than
+		 * reading the live CSR to avoid a TOCTOU race with nested
+		 * exceptions.
+		 */
+		if (v_available && !(regs->status & SR_VS)) {
+			regs->status |= SR_VS_INITIAL;
+			return;
+		}
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,6 +485,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.43.0

