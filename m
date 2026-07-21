Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186D3451DA;
	Tue, 21 Jul 2026 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634977; cv=none; b=nN5DlTd3H6sv48ghAmMsf7MjuMO6/YbodPSOLoqrBFVPyiR8WjvzedagLK3ypcc6cDjJbVaPn332gAibhUXpaIq06MqEG0wqFez7Rg/xNG2vDx6g1e1iJcPkiziLnXh71VWE68n83bgl5cjnrAxpzcQI8agsFp5/Y6+fjd0yHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634977; c=relaxed/simple;
	bh=OiKYjHgs8yfl3D/5jJm7sEOb7graCNa31cNxuR7adJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2lEaGdpCd8VfCztZjnWzgoeA9tvr7M37boNPw9dw6mqzYwQu254Bzp+bOVoOpQmTYdMXAURlZwIuQJf18d/51/artyCXTDtOmwl3rq4zz26aqQ9GZJCwlLynL6Vdugu21Ji5YmkX88RU3iZwLVNnL4TW7sLb7p1/+IuZy9oINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: zesmtpsz6t1784634963t6e8a6e90
X-QQ-Originating-IP: 7UTGWJP3KrvUOqnlyru4WDx7yxHshRvG5L4FHHW3S5o=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 19:56:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18011628127360508405
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
Subject: [PATCH v4] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Tue, 21 Jul 2026 11:55:58 +0000
Message-ID: <759A31C23819178D+20260721115558.341592-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721112454.330498-1-jinrui@haiwei.tech>
References: <20260721112454.330498-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NU1WQlQcW6dRJYxTTHGKZf+WGTLga1Es9GITG2SkkbjAr/a9F3XSzSGY
	BlIoILboLIoBK1ndhh3Ea1Y5xfQXUcNsuQy6XQvWdBceZl6pRRRz020jYsDyepFEak3vHdu
	K3ne9iRMRtdYEDi2zvRFuFmyIePydK+zPuOZ+D8V/MdlGnT0CcGVbtyw8yRUVacDJLdcN3x
	7xadjVRKOMjd+PX5+Fx+0orK9PFSvScFH1GDAPwfUXBe75N/CGJxsTIDQp20fX+IeI8MkSQ
	gQZsFf3BOWO+z5KdxnqxhW7H2Bg2TQREnx1QkVrt5k8LdurpwVxPdofC4SdnDLudkdzgPcy
	j+XB3+PmR5X19BXloxDck4swc1f9J7l3vJQpR0MnEXDK22YEqivfzjB5xMwWkExwTezxk1N
	9IViXG8kYEyibsg1wzJ/vz1cFstEOQPL1TMhRtvNa9M3c7OkhkPygeUlIceHAegwy5P/vFy
	arI8RsmSXXsCT1BSWjfNVbX6l+uAPnwMOimKE4wy2/oE7HZZSBO4VJjv27njVYHVMcUowrw
	6YltTD/WcACtCaLfgID2hPk+1oMvJM5Z3ZKShYGPVdXtmXS061QYJHkYKxmatgpC+q8Grjh
	b6OjQemARTN8C4HCx7t7Ox/LlTWm0hcSQCDjDU3ni9xGZjbL0ZSNhpNfaMJGy84C1R30w9Z
	bz9XTeu2yaJ7lDlVL6finqZNjuG1cLew4Lavr6otdk5wxId7S4RkG0SxmS86AiOcRTvQX7g
	2UrXD7fqtNoTBomuUhr/u/9Rc+fZPas7Qk//KVjOKmQxY4zcHbLjsA9MGFTlAtlNc6ewN8K
	S1uxuMGnW+ZJSqp0HiGGiGzgplBs5GfB2dFtrZjIQ8kOq7zI9v+MMcdPdDll/SFkUS6pqu4
	Wb39DvBDdgolknX2sd7r5B5wvwCmi9L1k81IMPhkx2O/d05pTSUqi2uktL6KEiJwIFpBAw6
	qMGUCBTxbDTfXQJ9LYHeRVOC8vHxKzflJNfCREq7EszxUALrnrmufXXh3sImJVJP9b4gkSp
	s8H6GLHn12RAE0Ks5mNMpgvKFT2KWvm2vU23745SQpo4Y4cU8O6UiloUg4tHX9C4HL0r5S4
	pPcn9RFw6J+dQRCGwSxgV8=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Changes in v4:
- Add vcpu_dump() call in assert_on_unhandled_exception() to restore
  the register dump that was lost when guest_unexp_trap() was removed.
Changes in v3:
- Move v_available from a host-side static variable into struct
  handlers (Guest memory), fixing synchronization issue between
  host (writer) and Guest (reader).
Changes in v2:
- Add a v_available flag to prevent infinite exception loops on
  hosts without the V extension.
- Use regs->status instead of reading the live sstatus CSR.

 .../selftests/kvm/lib/riscv/processor.c       | 69 ++++++++++++++++---
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..bf0675cc86d6 100644
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
@@ -408,6 +425,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 	struct ucall uc;
 
 	if (get_ucall(vcpu, &uc) == UCALL_UNHANDLED) {
+		vcpu_dump(stderr, vcpu, 2);
 		TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)",
 			uc.args[0], uc.args[1]);
 	}
@@ -415,6 +433,7 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
 
 struct handlers {
 	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+	bool v_available;
 };
 
 void route_exception(struct pt_regs *regs)
@@ -432,6 +451,33 @@ void route_exception(struct pt_regs *regs)
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
 
@@ -448,6 +494,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.43.0

