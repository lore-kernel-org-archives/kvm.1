Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B73C061E;
	Thu, 14 May 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740205; cv=none; b=P402piNlpqRvMjBMNAB9dd+LADdOKkkM5CtT1V3iyIrSsHx+KT9tymYNUn0AY820d4vAs7ByFbDGSn8zGjHi+u5IC0DdGo+z7l2YK+ANgoNkQPnUoKkT+bpfG3QVIWDzm4GgxbI8QCe/RHXEhqCH9ZOLWPODKCmCxX0o7bKWmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740205; c=relaxed/simple;
	bh=hkh36XRsen/JnuQoDrHsOoB+jd9jICKmgtz0Og7gyEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/6AjqL2/ulGmcIHoRjbqeVO4FmrnmNH9datoemvKOT4/JUxnI1JCyRzXWABiNlOxPDLEJ0RREgu7ErT4mvo0N8kqaUHJ+nuuIbfJgt47PYiQ6HZXUDSnU89Uce94Qarg5YeAaO6DtXGiTuFTDbWKG7ZUnMBvoNG4z4yl8liCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxI_CNawVqXLwJAA--.29424S3;
	Thu, 14 May 2026 14:28:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKMawVqJAqCAA--.49521S3;
	Thu, 14 May 2026 14:28:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] LoongArch: KVM: Simple interrupt status acquire interface
Date: Thu, 14 May 2026 14:28:24 +0800
Message-Id: <20260514062824.1378373-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514062824.1378373-1-maobibo@loongson.cn>
References: <20260514062824.1378373-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKMawVqJAqCAA--.49521S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

When VM is migrating, interrupts status are stored in software CSR estat
register, also new injected interrupts are cached in
vcpu::arch::irq_pending.

With interrupt status acquire interface, there is expensive vcpu_load()
and vcpu_put() function call to sync cached vcpu::arch::irq_pending.
Here new internal API kvm_vcpu_sync_intr() is added to sync cached
pending irq to software CSR estat register.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_vcpu.h |  1 +
 arch/loongarch/kvm/interrupt.c        | 42 +++++++++++++++++++++++++++
 arch/loongarch/kvm/vcpu.c             | 15 ++++++----
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index efe26b04b35f..e78bb2527329 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -64,6 +64,7 @@ int  kvm_emu_idle(struct kvm_vcpu *vcpu);
 int  kvm_pending_timer(struct kvm_vcpu *vcpu);
 int  kvm_handle_fault(struct kvm_vcpu *vcpu, int fault);
 void kvm_deliver_intr(struct kvm_vcpu *vcpu);
+void kvm_vcpu_sync_intr(struct kvm_vcpu *vcpu);
 void kvm_deliver_exception(struct kvm_vcpu *vcpu);
 
 void kvm_own_fpu(struct kvm_vcpu *vcpu);
diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index 380aabb3d4d0..24925c238a65 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -71,6 +71,48 @@ void kvm_deliver_intr(struct kvm_vcpu *vcpu)
 	}
 }
 
+void kvm_vcpu_sync_intr(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+	unsigned long mask, val;
+
+	if (!csr)
+		return;
+
+	mask = READ_ONCE(vcpu->arch.irq_clear);
+	if (mask) {
+		mask = xchg_relaxed(&vcpu->arch.irq_clear, 0);
+
+		/*
+		 * sync cached irq_clear to sw state
+		 *
+		 * When VM is migrated to other physical machines or
+		 * snapshot is created, cached irq pending state should
+		 * be synced
+		 */
+		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+		val &= ~(mask & KVM_ESTAT_IRQ_MASK);
+		kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, val);
+
+		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC);
+		val &= ~((mask >> 2) & KVM_GINTC_IRQ_MASK);
+		kvm_write_sw_gcsr(csr, LOONGARCH_CSR_GINTC, val);
+	}
+
+	mask = READ_ONCE(vcpu->arch.irq_pending);
+	if (mask) {
+		mask = xchg_relaxed(&vcpu->arch.irq_pending, 0);
+		/* sync cached irq_pending to sw state */
+		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_ESTAT);
+		val |= (mask & KVM_ESTAT_IRQ_MASK);
+		kvm_write_sw_gcsr(csr, LOONGARCH_CSR_ESTAT, val);
+
+		val = kvm_read_sw_gcsr(csr, LOONGARCH_CSR_GINTC);
+		val |= (mask >> 2) & KVM_GINTC_IRQ_MASK;
+		kvm_write_sw_gcsr(csr, LOONGARCH_CSR_GINTC, val);
+	}
+}
+
 int kvm_pending_timer(struct kvm_vcpu *vcpu)
 {
 	return test_bit(INT_TI, &vcpu->arch.irq_pending);
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 2f4fd6fa5b0e..5f94360e8a4b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -610,14 +610,11 @@ static int _kvm_getcsr(struct kvm_vcpu *vcpu, unsigned int id, u64 *val)
 
 	if (id == LOONGARCH_CSR_ESTAT) {
 		preempt_disable();
-		vcpu_load(vcpu);
 		/*
 		 * Sync pending interrupts into ESTAT so that interrupt
 		 * remains during VM migration stage
 		 */
-		kvm_deliver_intr(vcpu);
-		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
-		vcpu_put(vcpu);
+		kvm_vcpu_sync_intr(vcpu);
 		preempt_enable();
 
 		/* ESTAT IP0~IP7 get from GINTC */
@@ -1649,6 +1646,14 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Restore timer state regardless */
 	kvm_restore_timer(vcpu);
+
+	/*
+	 * Restore Root.GINTC from unused Guest.GINTC register
+	 *
+	 * SW state about LOONGARCH_CSR_GINTC is updated with get_csr()
+	 * ioctl command only. Update HW state from changed SW state.
+	 */
+	write_csr_gintc(csr->csrs[LOONGARCH_CSR_GINTC]);
 	kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
 	/* Don't bother restoring registers multiple times unless necessary */
@@ -1711,8 +1716,6 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_ISR3);
 	}
 
-	/* Restore Root.GINTC from unused Guest.GINTC register */
-	write_csr_gintc(csr->csrs[LOONGARCH_CSR_GINTC]);
 	write_csr_gstat(csr->csrs[LOONGARCH_CSR_GSTAT]);
 
 	/*
-- 
2.39.3

