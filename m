Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAF3B9922;
	Thu, 13 Aug 2026 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611820; cv=none; b=iJs1DUHSnDmOL55OGOoJCNjKjbbZ5gjg8Fkt/OU0gigh6e2i6njPGFwPbRVR1/zRwi+vyxfvMu1rN+IpKYtBhz1+lELaphIbKAH5ZgFz0sq48jgMj9lQje3yKVVFEQ55T3R3LwfY0OM6hQQeW3javiXXYqAXJdFk0GnpBXNkY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611820; c=relaxed/simple;
	bh=VmIRJ7v4SJCt2OppA4gumPuJi70DSLr3Xl81F+8KvBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnFixX1Jzb1EOXpMHURjp9+5pYg+Bj9tGpk1c9s3bm12zoV0+6zEJuMEPHBvYM8b28IiHO5KN9VGto8N7/Df9wCPuUc1iIU01W39yKz4tmpDu1n4XeML+dyoO38PzHLY475zDmV7iH8YIzvc++3W8fAN3wZeYYmIwbnzLu3jp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: zesmtpsz5t1786611793tcd0fa4e6
X-QQ-Originating-IP: R9Ej3Mabn7TW3eBk3l+R5rLw0xXXsSI9t86r56myLeo=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 17:03:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4575981333641780540
EX-QQ-RecipientCnt: 15
From: JinRui <jinrui@haiwei.tech>
To: anup@brainfault.org,
	pbonzini@redhat.com,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: atish.patra@linux.dev,
	alex@ghiti.fr,
	sashiko-bot@kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jinrui <jinrui@haiwei.tech>
Subject: [PATCH v10] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Thu, 13 Aug 2026 09:03:06 +0000
Message-ID: <733FC2542EECADE1+20260813090306.3756434-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <034CA48A67574B32+20260811085036.2862645-1-jinrui@haiwei.tech>
References: <034CA48A67574B32+20260811085036.2862645-1-jinrui@haiwei.tech>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Od0VoHQHM0giZRDQx7XH7jFB3sZMQSfCecQGuX7syc4cgtvNrWnANQ7R
	fAGXvFXKr7g6uxn04vr/wzv0wWacrtjaVopsLh1Oh1ajc21d/EjVYt48ji1OhCQn/yNWMui
	kq1z9bJ9/JrFeHK5/yO1e1HM2cgeCLAUeb82EKnH4p8ePn4Iwr9v0nw/pgIBbUNMOetniOH
	gZDRxyLnCnITE/xOjJm8Y0AW9IVVX5iTj3bWuaZAJzFMW+QuLiq/Uw4AeU3Eg2ABTJ3owt+
	Z03Wp1bexMjOvDufriFPp78JDYxdpeTS6uxFsQkDvk1m/MmWEghftmHRzEptr+DBfoOCMIs
	eqqvxPgxcZye8kl5J2FXC3xOrYmR2YnBoRGubkSfSs76pSgxTlNemoM84xgRVTLlr06IyG+
	oh6gFwfuthLVGmcU/5Bu3hGugnhB0x169ZEnWirRPIwjtDP881E7PXdAJ9qObRud+QTSXSY
	ejuIlrvR5MUuBbNl7NhJdsD/DFq6HuzmvdwaKwpmrzt2KmE13Vpo1X/W6MGGdIMs6bTBH4e
	GCfKTH1p+zmmEPawyQUeiAK/nQwA7Y+/YkskgO3Xx3QlXSFvc/uvDvz1V4DicrgxYFH4c92
	KM1od2Dewi8hQUFeaY3VClEKd7ivoiVp0DMvI2dCpu4Cwirxu6/R9c26PI7Uicc3ysMBXTm
	kdp3123cpSh1SmyB9/cxKoEsd0gjYKhBxvzJfLFp10kWQ0oqdu95t6tEBy5qYbhfNa04cd2
	8a/++j7sBdtmKXwx+N9nNmHQ21xcMyewTQu/ggcTdzL5yINqm8K/uEhPftyAe+GtHHO0yJE
	JoXxxcyggucUqRl6RSOtkNR6DiryhDJmTZITwXKL0FSMCAlY9Vo+mFp/QLNtm9oKCLkvGw/
	Hds0oCeJ33ZslH/7GV1IcSB1GeUinnb8y3sFmtf6fQ097UpHes0sTC/8HXZiuMMo3S/qSwS
	A81nbikRklW44sGLACrFj1dGYEWB1L0tb+A0VSVpteeqs9g==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: jinrui <jinrui@haiwei.tech>

When the cross-compiler defaults to an -march that includes the V
(vector) extension, -O2 auto-vectorization generates vector instructions
(e.g. vsetvli, vadd.vv) in guest code. Executing such an instruction with
sstatus.VS Off raises EXC_INST_ILLEGAL (scause=2); KVM's hedeleg forwards
it to the guest, but the bare-metal selftest cannot handle it, so all
guest tests fail. A real kernel handles this via
riscv_v_first_use_handler(), which enables V and re-executes the
instruction.

Fix it in processor.c:

1. Delete the now-unused guest_unexp_trap() handler, replaced by the full
   exception vector table.

2. In vm_arch_vcpu_add(), advertise V to KVM via __vcpu_set_reg(V, 1)
   (best-effort, errors ignored on hardware without V) and install the
   full exception vector table instead of a raw stvec handler.

3. In route_exception(), decode the faulting instruction (stval) with
   insn_is_vector() and, when it is a vector instruction while sstatus.VS
   is Off, set VS to Initial and sret to re-execute it, before any
   test-registered handler. Genuinely illegal instructions still reach
   the unexpected-exception path.

4. Make vm_init_vector_tables() idempotent by checking vm->handlers
   before allocating, so tests that call it directly (ebreak_test,
   arch_timer, sbi_pmu_test) do not leak memory.

Tested on a riscv64 host with KVM enabled.

Signed-off-by: jinrui <jinrui@haiwei.tech>
---
Changes in v10:
- Decode the faulting instruction (insn_is_vector()) and only lazily
  enable V for actual vector instructions, so genuinely illegal
  instructions still reach the unexpected-exception path (Anup).
- Drop the per-vCPU v_epc[] guard and KVM_CAP_MAX_VCPU_ID sizing, as
  they are redundant with v_available and the sstatus.VS check.

 .../selftests/kvm/include/riscv/processor.h   | 13 +++
 .../selftests/kvm/lib/riscv/processor.c       | 79 ++++++++++++++++---
 2 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index e3acf2ae9881..685baefebdb1 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -25,6 +25,19 @@
 #define GET_RM(insn)            (((insn) & INSN_MASK_FUNCT3) >> INSN_SHIFT_FUNCT3)
 #define GET_CSR_NUM(insn)       (((insn) & INSN_CSR_MASK) >> INSN_CSR_SHIFT)
 
+/* Vector (V) instruction decoding, matching arch/riscv/include/asm/insn.h */
+#define RV_INSN_OPCODE_MASK	0x7f
+#define RVG_OPCODE_SYSTEM	0x73
+#define RVV_OPCODE_VECTOR	0x57
+#define RVV_OPCODE_VL		0x07
+#define RVV_OPCODE_VS		0x27
+#define RVV_VL_VS_WIDTH_8	0
+#define RVV_VL_VS_WIDTH_16	5
+#define RVV_VL_VS_WIDTH_32	6
+#define RVV_VL_VS_WIDTH_64	7
+#define RVV_EXTRACT_VL_VS_WIDTH(insn)	(((insn) >> 12) & 0x7)
+#define RVG_EXTRACT_SYSTEM_CSR(insn)	(((insn) >> 20) & 0xfff)
+
 static inline u64 __kvm_reg_id(u64 type, u64 subtype, u64 idx, u64 size)
 {
 	return KVM_REG_RISCV | type | subtype | idx | size;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..ffd84212c9b0 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -17,6 +17,11 @@
 
 static gva_t exception_handlers;
 
+struct handlers {
+	exception_handler_fn exception_handlers[NR_VECTORS][NR_EXCEPTIONS];
+	bool v_available;
+};
+
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, u64 ext)
 {
 	unsigned long value = 0;
@@ -298,13 +303,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *vcpu, u8 indent)
 		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
 }
 
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
@@ -348,8 +346,22 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	/* Setup sscratch for guest_get_vcpuid() */
 	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(sscratch), vcpu_id);
 
-	/* Setup default exception vector of guest */
-	vcpu_set_reg(vcpu, RISCV_GENERAL_CSR_REG(stvec), (unsigned long)guest_unexp_trap);
+	/*
+	 * Advertise V to KVM so -O2 auto-vectorization in guest code is valid;
+	 * ignore errors since the tests work without V too. Use the full
+	 * exception vector table (which lazily enables V in route_exception())
+	 * as the default handler; vm_init_vector_tables() is idempotent.
+	 */
+	__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(KVM_RISCV_ISA_EXT_V), 1);
+	vm_init_vector_tables(vm);
+	vcpu_init_vector_tables(vcpu);
+
+	/* Record V availability for route_exception(), which runs in guest context. */
+	{
+		struct handlers *h = addr_gva2hva(vm, vm->handlers);
+
+		h->v_available = __vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V);
+	}
 
 	return vcpu;
 }
@@ -408,19 +420,43 @@ void assert_on_unhandled_exception(struct kvm_vcpu *vcpu)
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
+static bool insn_is_vector(u32 insn)
+{
+	u32 opcode = insn & RV_INSN_OPCODE_MASK;
+	u32 width, csr;
+
+	/* All V-related instructions are 4-byte, i.e. not compressed. */
+	if ((insn & 0x3) != 0x3)
+		return false;
+
+	switch (opcode) {
+	case RVV_OPCODE_VECTOR:
+		return true;
+	case RVV_OPCODE_VL:
+	case RVV_OPCODE_VS:
+		width = RVV_EXTRACT_VL_VS_WIDTH(insn);
+		return width == RVV_VL_VS_WIDTH_8 || width == RVV_VL_VS_WIDTH_16 ||
+		       width == RVV_VL_VS_WIDTH_32 || width == RVV_VL_VS_WIDTH_64;
+	case RVG_OPCODE_SYSTEM:
+		csr = RVG_EXTRACT_SYSTEM_CSR(insn);
+		return (csr >= CSR_VSTART && csr <= CSR_VCSR) ||
+		       (csr >= CSR_VL && csr <= CSR_VLENB);
+	}
+
+	return false;
+}
 
 void route_exception(struct pt_regs *regs)
 {
 	struct handlers *handlers = (struct handlers *)exception_handlers;
-	int vector = 0, ec;
+	int vector = 0;
+	unsigned long ec;
 
 	ec = regs->cause & ~CAUSE_IRQ_FLAG;
 	if (ec >= NR_EXCEPTIONS)
@@ -432,6 +468,20 @@ void route_exception(struct pt_regs *regs)
 		ec = 0;
 	}
 
+	/*
+	 * Lazily enable V on the first vector instruction: if the faulting
+	 * instruction (stval) decodes as vector while VS is off, set VS to
+	 * Initial and re-execute it, like the kernel's
+	 * riscv_v_first_use_handler(). Genuinely illegal instructions fall
+	 * through to the unexpected-exception path.
+	 */
+	if (!(regs->cause & CAUSE_IRQ_FLAG) && ec == EXC_INST_ILLEGAL &&
+	    handlers && handlers->v_available && !(regs->status & SR_VS) &&
+	    insn_is_vector((u32)regs->badaddr)) {
+		regs->status |= SR_VS_INITIAL;
+		return;
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,6 +498,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.53.0
