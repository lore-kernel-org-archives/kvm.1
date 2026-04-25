Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511E1DE894;
	Sat, 25 Apr 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777078787; cv=none; b=mV15pBHNeLUms6Bsy/Dd4wbPDrTJSmb6cR416Y6AnqhIZXzZ1oR6KKoKrUP833PiWrtDIlsTdWhLt3TqBf/tuIwKxOSgn4fcA7U6rlo8jMavd5W7noSJkDTJdQKTmtvcTn4MWumq0j9F0gtEiEzTCRRI+HwpppBJOagqwx1kRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777078787; c=relaxed/simple;
	bh=cERsT3FzaAmTn0XF4uxIOLVAlPMEYfFsUqX/c6wlcfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIVQ5wMwZ92MGvHL7nXtpODL3HYZd6hyM+ad7Gpp9hHjoz91EI1kxa8Lm+zu6OfX6OjgiPXQl/PQfEunAShffJoAQ4Awl1I8AL9GtAEMms1Wbs5dDxuRZXwHpnYp/jdsu0Q6EZtfw6qpFOC3yxAsybVZvvw29n3L21iFFE3/rBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGjRELfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGjRELfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A07C4AF09;
	Sat, 25 Apr 2026 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777078787;
	bh=cERsT3FzaAmTn0XF4uxIOLVAlPMEYfFsUqX/c6wlcfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGjRELfo7XWL9qHq5ylh6aclUwW/sJetbl2K/qhuO2k1euJ9vGRQFrEkvL6U848iy
	 3ci7xTEhydCrgj3UXsvRX+tWbe73FMLL/Z58JnTtDWfUzShbW+EfaSR87jljlaEFtZ
	 S3mvJxY5T8DWw1XybYwLy8jPCJlpEweZtxB9M/PgE3KbO0O7QjOC9GVLSzM1T5SBz5
	 G6tVeCSKrP/+r1uvIhVbNHeebv4V5l7vkjPIiVZ+B4RR0IYypjRf3wdgP8xR2ErWWn
	 kVMOZw6Rb7tB85DpBIf6lEpsb8IeUPlSiR5bThkD6B0roMe4QGhDq08Cv4HeAMET5g
	 YBwOBxJjmBNWQ==
From: guoren@kernel.org
To: guoren@kernel.org
Cc: alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	cp0613@linux.alibaba.com,
	fangyu.yu@linux.alibaba.com,
	gaohan@iscas.ac.cn,
	inochiama@gmail.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	me@ziyao.cc,
	palmer@dabbelt.com,
	pjw@kernel.org,
	tglx@kernel.org
Subject: [PATCH V2 1/4] RISC-V: KVM: AIA: Make HGEI number and management fully per-CPU
Date: Sat, 25 Apr 2026 00:59:13 +0000
Message-ID: <20260425005916.3321811-2-guoren@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425005916.3321811-1-guoren@kernel.org>
References: <20260425005916.3321811-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Previously the number of Hypervisor Guest External Interrupt (HGEI)
lines was stored in a single global variable `kvm_riscv_aia_nr_hgei`
and assumed to be the same for all HARTs. This assumption does not
hold on heterogeneous RISC-V SoCs where different cores may expose
different HGEIE CSR widths.

Introduce `nr_hgei` field into the per-CPU `struct aia_hgei_control`
and probe the actual supported HGEI count for the current HART in
`kvm_riscv_aia_enable()` using the standard RISC-V CSR probe
technique:

    csr_write(CSR_HGEIE, -1UL);
    nr = fls_long(csr_read(CSR_HGEIE));
    if (nr)
        nr--;

All HGEI allocation, free and disable paths (`kvm_riscv_aia_free_hgei()`,
`kvm_riscv_aia_disable()`, etc.) now use the per-CPU value instead of
the global one.

The early global `kvm_riscv_aia_nr_hgei` is kept only for deciding
whether SGEI interrupt registration is needed; the real per-HART
initialization of lock and free_bitmap is moved to enable time.

This makes KVM AIA robust on big.LITTLE-style and multi-vendor
asymmetric platforms.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/kvm/aia.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 5ec503288555..a23729052cfb 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -23,6 +23,7 @@ struct aia_hgei_control {
 	raw_spinlock_t lock;
 	unsigned long free_bitmap;
 	struct kvm_vcpu *owners[BITS_PER_LONG];
+	unsigned int nr_hgei;
 };
 static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
 static int hgei_parent_irq;
@@ -452,7 +453,7 @@ void kvm_riscv_aia_free_hgei(int cpu, int hgei)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	if (hgei > 0 && hgei <= kvm_riscv_aia_nr_hgei) {
+	if (hgei > 0 && hgei <= hgctrl->nr_hgei) {
 		if (!(hgctrl->free_bitmap & BIT(hgei))) {
 			hgctrl->free_bitmap |= BIT(hgei);
 			hgctrl->owners[hgei] = NULL;
@@ -486,21 +487,8 @@ static irqreturn_t hgei_interrupt(int irq, void *dev_id)
 
 static int aia_hgei_init(void)
 {
-	int cpu, rc;
+	int rc;
 	struct irq_domain *domain;
-	struct aia_hgei_control *hgctrl;
-
-	/* Initialize per-CPU guest external interrupt line management */
-	for_each_possible_cpu(cpu) {
-		hgctrl = per_cpu_ptr(&aia_hgei, cpu);
-		raw_spin_lock_init(&hgctrl->lock);
-		if (kvm_riscv_aia_nr_hgei) {
-			hgctrl->free_bitmap =
-				BIT(kvm_riscv_aia_nr_hgei + 1) - 1;
-			hgctrl->free_bitmap &= ~BIT(0);
-		} else
-			hgctrl->free_bitmap = 0;
-	}
 
 	/* Skip SGEI interrupt setup for zero guest external interrupts */
 	if (!kvm_riscv_aia_nr_hgei)
@@ -545,9 +533,29 @@ static void aia_hgei_exit(void)
 
 void kvm_riscv_aia_enable(void)
 {
+	struct aia_hgei_control *hgctrl;
+
 	if (!kvm_riscv_aia_available())
 		return;
 
+	hgctrl = this_cpu_ptr(&aia_hgei);
+
+	/* Figure-out number of bits in HGEIE */
+	csr_write(CSR_HGEIE, -1UL);
+	hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
+	csr_write(CSR_HGEIE, 0);
+	if (hgctrl->nr_hgei)
+		hgctrl->nr_hgei--;
+
+	if (hgctrl->nr_hgei) {
+		hgctrl->free_bitmap = BIT(hgctrl->nr_hgei + 1) - 1;
+		hgctrl->free_bitmap &= ~BIT(0);
+	} else {
+		hgctrl->free_bitmap = 0;
+	}
+
+	raw_spin_lock_init(&hgctrl->lock);
+
 	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
 	csr_write(CSR_HVIPRIO2, 0x0);
@@ -588,7 +596,7 @@ void kvm_riscv_aia_disable(void)
 
 	raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-	for (i = 0; i <= kvm_riscv_aia_nr_hgei; i++) {
+	for (i = 0; i <= hgctrl->nr_hgei; i++) {
 		vcpu = hgctrl->owners[i];
 		if (!vcpu)
 			continue;
-- 
2.43.0

