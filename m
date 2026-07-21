Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCC403E9C;
	Tue, 21 Jul 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633124; cv=none; b=DDbCtSDtbgyKYrLMAsbuKUSwuzTpuaW12ICFF+FCpU/+k7NCPUezEvceQ9U31BCpigcq7Ppud4H+7kxJbSFxlpKHWDv7V4OZXEdhHHlRogy1nP3y5VbN5F9u5RqMmdmxp0XqfMpuAgHXMFtMyRcyOor6qI+zxWTNvPR+VH26Ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633124; c=relaxed/simple;
	bh=Af4CVCjtShcmgw0IydJXrc6l42LR3VATdP8D/SA9vDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCj4eclB3dh7Q/QviRQ+kMGp80xr4g1v2N3J8AX5X4tbJ70pO9sjYw0jhoiu3w2JTiPBmwyUMAoyVBtxrGEqxmIULqYbt2Kz77v4Gggry49Zrwp9cU8LU90RcgBV7yTvaJSzJYINWtIQOIzs9ypJUrNGZ13kYJzllpSx/r3/S7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: esmtpsz11t1784633099t86bbe47d
X-QQ-Originating-IP: N+tMx1w72ZK4uOz590DgffrsiOgt9acwJYrcgyAIQlg=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 19:24:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10782298649588333164
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
Subject: [PATCH v3] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Tue, 21 Jul 2026 11:24:54 +0000
Message-ID: <574AACF6F4298057+20260721112454.330498-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
References: <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYG9n5uPxz1Wk29WLAKSIS8+yDMQ0XsxkF+/B/ZlNrctudD+rKtJ1Pvg
	SZf+7mCSAXPygAl9PzYtM0c/fB0gkgvhDX1RPhLihaK4oQAPg6VdugR9pzwbksgzz+voNYC
	NIwktM2z2xIpqgG+5P3h60DYgnYbhkq0RYQFwLyRFxeA8HKJnrFI10TIqo5hj3mpjSqyPHE
	Pqn6j90YX5akXbNnmAJ2iSGYW6y/dnxUwF0z5Zcd3jUbcgFnMjgJ7/FJiSDj8oBa6UJ85je
	nAEfwVn1YqQ21YlQQWfeix1Hfn5om1iSEdoSDDgYUmQEAdWVp23ATBj7DM7Kd5Z8d6YaoTJ
	+zGPFcXtv5k3FciJjmtd3F/otrA2n6x1oGrctY/7jYo9rTrjOl+7a3ax8adzmq0J4yvUrQP
	5X4PGyPPgTs6+4Wek/oVmkqSkfJrmlACjFkgHonSJ9MZWL3/P8+L39905luadQPH4G2ojlG
	3A+K4LvvLrW4r2G+g/vNi3wq7Gf9PoSdpQ5Q8Sv12Dvc4XVXnjgazEpIlgvLkWs5y2LWy3a
	MyQNdehZ2dSr/FOX0PYYoTYnWpCvcHVFDcUvUvQjetrk6gaU8rqgL2tWrL1Nbu8GtX2ltne
	MVdRmylWwl2IISdlEor5Kzc8GUXUV4wlZXBuqdGeu5H6eKsLU9z0xlr8MXBBshhYWM1FwnG
	8g55qH+Of1UWlOysDmQaunOS/9Ykw14yPVbeZQbJGqxgmtifv0k8HAfy7NfUFsPTTWiYzpX
	fHhoAog0kh2+K0+h+GPcvTKbS6mDFVYXuiGHr2iUwklfcmFz63mBHSnri6kQNmGFvhTQ931
	irK5zCt6zOtoQJ/Qb+LsQqGrGwex8M59ZBKeefc10sd1UHdtK7tAEuzet4zTv8HLtNslDpH
	ttKV6oaUygqx3KXCZoqTXA/e/8LVrPkYlpSXSgNbhsOzBjD8rhkqQlQBNN6WIH90CBboNmh
	89taFxfl6ViVg2AE96EvM7OIEGITTDsVVsGgyuZ5m4PgydZ0JCde05OZys0NrJ4UdpS8vRd
	xarivc5usDIqTcu80WqAbyeZNWXhRwSds38ugL2G2H1syTEujvvglgkD3UOWVQfs5LRaSn+
	2xaEwIDMSgh
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Changes in v3:
- Move v_available from a host-side static variable into struct
  handlers (Guest memory), fixing synchronization issue between
  host (writer) and Guest (reader).
Changes in v2:
- Add a v_available flag to prevent infinite exception loops on
  hosts without the V extension.
- Use regs->status instead of reading the live sstatus CSR.

 .../selftests/kvm/lib/riscv/processor.c       | 68 ++++++++++++++++---
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..841474acfabd 100644
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
@@ -348,8 +340,33 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
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
@@ -415,6 +432,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 
 struct handlers {
 	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+	bool v_available;
 };
 
 void route_exception(struct pt_regs *regs)
@@ -432,6 +450,33 @@ void route_exception(struct pt_regs *regs)
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
+		if (handlers && handlers->v_available && !(regs->status & SR_VS)) {
+			regs->status |= SR_VS_INITIAL;
+			return;
+		}
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,6 +493,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.43.0

