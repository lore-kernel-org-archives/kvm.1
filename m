Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96E21256C;
	Tue, 21 Jul 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636725; cv=none; b=D/YPq+CvWNArjjhGGnk95sX6VoVVhlAGBcG9ezGa1Y/fWW0yTkTmy6ANVEcRsy5hISsA1YPBDZh3QS81hGzSmfGxxfUWyZ7XDQMEI7F9XrZBXbJXuxTRwDqXlAXTqChnrFOf8yDRlMlOphiUa6HDGTQugrkGXU80byl5RiWqgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636725; c=relaxed/simple;
	bh=J8G9Mf86/QNhcAp4MycTpvpehF5An+6SgrQwU/YBlVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atrOQVF92Yljw1pT5dUNjSm6G7UVxWtoO79i2DnujyPfOqGAeyPvwKzELzZykz30smpG90PNxh5wdYtIgGCyiux5NLYny3XiCSCpJtL/bSRT9RjfHsUsbCgtDCBdmYAgeo0x9cxxqzXMwYwCUZ7Sd/iJfsWxFfhQ846DmOgKP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: zesmtpgz5t1784636697t1ab0bdb5
X-QQ-Originating-IP: E4jMg68m2VMQeBL41dE2uKWfCFRZ8sl2sAgZLc0GIa0=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 20:24:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8024588964083147569
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
Subject: [PATCH v5] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Tue, 21 Jul 2026 12:24:42 +0000
Message-ID: <2D686C2069E3C0F9+20260721122442.351865-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721115558.341592-1-jinrui@haiwei.tech>
References: <20260721115558.341592-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N29iqeDVD2V0/dqiPRy3XEqjf8/rkLt2trwYkppv3p47JPx+oLguZY9F
	hU+OQFhJRz3GSH9YZz3xzw+5PYqRM7Pw3SDPplTIUKoReWAuhZu7tSmoDZ2tzEvz1q5HqVx
	9EYPLKkqwtwKhVQ21joqI7RCgILzyR67j/GnoA1q0J1AZm9CYNo3JPVeAty1m85p1AE0t6w
	CMU9OWQvTD6/lOtjTyA8IizgwT2wn2CmrG7a2Hu1l77Jd2UA4IVZvlc0hb/YX0pWY58NN5f
	0KqfmsUBsw0yTZOmFwzXHw0xZ7MecFAs6s8OteyG6BO2UJaByBbB8Mln+xRaEpncnntssvX
	ydz2pO4hyOqrjRsuNpCHY7ah5vidmLZ6ETxMvzm4PIDew+vowj9041343ZsKnso9i+bPB1M
	G+ZKbUwCy06wtw6AgYh5kPk7JG9dUWE9Uil5XPwMTgpQQ/8yG9DldIQqXec3rxjWEEnw5Fo
	gG+nreafrr19P//8GOvMC5+TuiIfUdeZwOWq9uk1dV1R9Ro5iWHaRW1FRf/AvMcjRiL7ZEE
	ATj6yMw9QGx72POpUHEKRg0XlrsCBIUviqPs+9u8wRyFW8izjD+jHX8dlMQcCG9wD1TFIKA
	MsjA9RtaU49NRvjdwVhGO0YPo+B8ZZAnr3isNCyXX5eMUvXjOJ5L+uSGDQg9KQJAEf9s8aV
	V4wnGvnfXONCC46XcPR7n/Vl6PIq1blLXi95DJO+tXlecuUZt+IYEh7f+PhqYDxWcFWRfDW
	7Th8w+PT8UNRK0YKOvjDd9HkzdoEJgVyCNaglUs5DsKJ81iS2xWfUs3DGyzrLUXoM7AMJHI
	KxbtnLN3RPd1/tSPF+fbDRFzVFsvV44Ifg6lehWGCGmvoiayGMtaG2mf9gLSMZfKIhCbO/p
	tmGYTdnLL/p86S0+1eWX2J6D6I4mvIdvEmhOoJbx1QHLdsdDsu8f4Shue24B9zv8IbwK8Ek
	tXEZO08FKoGQlbmlwXXZTXP8Zk9nYsPIlcxTy4lA8H4+8NnsXlERIe/OMeDxlx0VZQb11dS
	Elsr/MUSDKUukFgaOF0OZ16wY1cbKBDQ0F6TYqqJwFO4p1KgeepKErFnaSnDiaLVKrXfzHh
	bh4Hze21Hh7ZErtEndMyp02DVsByJnKLQ==
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
Changes in v5:
- Replace the one-shot v_available flag with per-vcpu (epc, vcpu_id)
  tracking to correctly handle multi-vCPU tests and the case where V
  is disabled after vCPU creation without causing false-positive
  bailouts on other vCPUs.
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

 .../selftests/kvm/lib/riscv/processor.c       | 85 ++++++++++++++++---
 1 file changed, 75 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..03a3223a0466 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -297,14 +297,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
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
@@ -348,8 +340,34 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
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
+		h->v_vcpu = -1;
+	}
 
 	return vcpu;
 }
@@ -408,6 +426,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		vcpu_dump(stderr, vcpu, 2);
 		TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)",
 			uc.args[0], uc.args[1]);
 	}
@@ -415,6 +434,9 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 
 struct handlers {
 	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+	bool v_available;
+	unsigned long v_epc;
+	int v_vcpu;
 };
 
 void route_exception(struct pt_regs *regs)
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
+		 * Compare (epc, vcpu_id) against the last attempted
+		 * enablement to avoid an infinite loop when V is available
+		 * but the test later disabled it or the hardware rejects
+		 * the VS change.
+		 */
+		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
+			int vcpu_id = 0;
+
+			asm volatile("csrr %0, sscratch" : "=r" (vcpu_id));
+			if (handlers->v_epc != regs->epc ||
+			    handlers->v_vcpu != vcpu_id) {
+				handlers->v_epc = regs->epc;
+				handlers->v_vcpu = vcpu_id;
+				regs->status |= SR_VS_INITIAL;
+				return;
+			}
+		}
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,6 +510,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.43.0

