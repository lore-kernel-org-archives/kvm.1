Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9431433BA8;
	Tue, 21 Jul 2026 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628879; cv=none; b=sROkEU96DfkdmVWMSPtweU1V9xxH0DXLOKYRgn4bTMfnjIHmwdGl5C2kzLqthK9K+DUxJTsqlJ2oezeMeWoBr2FUTxSfOsrlJ8PJP/maDIn9Jt+o6nO0gIWf2pNY1VDxki6BAcE4OZAPkfX9c2D2Eep7kZaauqTeOlV1DakP4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628879; c=relaxed/simple;
	bh=KDDY+d6MxMJrgFRCeMulZnJwe4B2MlNviK365K+uOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lufGyD8PBRyYsFRxHiW9kH0wjVfZQwbdqxyzrTLdH7wMX2u6OUyWbljyqvYhVYyzgS0lFitPwiX9mLkQT9GwP/OPuwLuxFKX4f2bht+esydmgSJcyldkz8vlC9Tgk04+jOGnNShPXUllddHMhfv3WZu9TuB2xeTRVxivilEjhv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech; spf=pass smtp.mailfrom=haiwei.tech; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=haiwei.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haiwei.tech
X-QQ-mid: esmtpsz17t1784628857t66910cac
X-QQ-Originating-IP: vDikGeTX9xdKaMVcbajN25qy8kQetXWq/mGgRDPtiH4=
Received: from rsl ( [183.242.33.186])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 18:14:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13123165881942951496
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
Subject: [PATCH] KVM: selftests: riscv: Add lazy V extension enablement for guests
Date: Tue, 21 Jul 2026 10:14:06 +0000
Message-ID: <4FAAF34C966898C0+20260721101406.305108-1-jinrui@haiwei.tech>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:haiwei.tech:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYFZlDKo2zpJtBLJHlLSXP/y80gjJgKxpKUzt6lGi1j/I6hvYnVokkvZ
	X6k5fjU/Zy/SqwqXqn2e2K0jRwezlSWKTVLWzuvFR1jjM8k29vE+4hLkM7ObAuti1Dne1fK
	lu+30RRPEDwx8hWm/VPLEk3kSN7j3bjZTK7ImwQ/O2Jlg0DBuXr+C40U+q2HbBB5jLwcKlr
	FYduUAng8EUMNbW1GgbQ/hQOCmeBQTHPqrMvqasqJZkNZyRGptlXHo0xhR2UP3mJ2uylu1V
	/KUc9NJWLibFSDTkCRxp9KwQKHY97c8QdpjaHnVfLk6eNFubxgVkyOpxv5jBzFAATdDgyrG
	n882VZr+HKTEF+iCTiSGI8472r2FC6Gt4I3EAqHvSW+BHD+X3aTRvEQOG5YoV/LeSWQoD5q
	/DRIlGLx2WxCw9rDF+OI1I8ID5kHlmZEi0j0o977W1Ki5vurBamIZFNtfbbKxpjfy8yGdBR
	NykPiGHnXcPKn2XA6G3c/dhqoaxmpvEhuKwuj0oiNfLYEOuU3K16Qq6uvID8wa6ujJClXx4
	sot5TM1ftMO/ke9hy0RZcQfzPwVgi6AXFeG6EZp5+GUforSFjpo3wOuRLtjDanXO5lkpyfY
	2pqlAJdAxrt/rGyctcpYn5NCRsfWCbzDPw+4ck3rBNNmvzx6WKkzn3olGDnbnOD0bAox236
	XYw9BcxWIMnDmRqpevPK+/A6Y1/S4g7/7qzGUWRh9Gt63hRxyzAgF9BSfqNZfq/Lq/Kb5hy
	RE0+S7scWlQDvF4Dy5VNcQj/4MPQuJAWn+3dGdX2PhU+YxtSuxwPoo9+b5CJ7tG2sInFBuS
	bi51jUiOCsOZ2MlSPEhG0F+upAKbv//kKsYuf9r6cMaAzfZvXyEzp1bkKH7BQe1XKbXk07e
	htvk250irCDKpX1Vza2SadSwAp4TnO8QxEwjCLQ6OFOZwBGf/W4lJMJKOaTobk3ngOYABvW
	M0KiM8kDrbqJYA3xO+5pQISbLkkp2SLsIgLKrxE0WDMR1JT8IpCwFWaZ6p9GZBGRiRl07Fv
	nqZo3sxmYV6QdC3BltEQf8FoJvTyc=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
 .../selftests/kvm/lib/riscv/processor.c       | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..68577b2f48f4 100644
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
@@ -348,8 +340,22 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
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
 
 	return vcpu;
 }
@@ -432,6 +438,28 @@ void route_exception(struct pt_regs *regs)
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
+		unsigned long sstatus;
+
+		asm volatile("csrr %0, sstatus" : "=r" (sstatus));
+		if (!(sstatus & SR_VS)) {
+			regs->status |= SR_VS_INITIAL;
+			return;
+		}
+	}
+
 	if (handlers && handlers->exception_handlers[vector][ec])
 		return handlers->exception_handlers[vector][ec](regs);
 
@@ -448,6 +476,9 @@ void vcpu_init_vector_tables(struct kvm_vcpu *vcpu)
 
 void vm_init_vector_tables(struct kvm_vm *vm)
 {
+	if (vm->handlers)
+		return;
+
 	vm->handlers = __vm_alloc(vm, sizeof(struct handlers), vm->page_size,
 				  MEM_REGION_DATA);
 
-- 
2.43.0

