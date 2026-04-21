Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17F3D9046;
	Tue, 21 Apr 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783338; cv=none; b=J18YwdSyzdSo6STRLPJHNn+JtluDXJUlp7SSWWR85Fz8Ws6Wcd7n4Q1SfbSiiKZmfXWu3xF7MuIY+3f/b5I+Q43OGn9mKV2zurs0MC19eGIGbQHg9NZVhIno1w70BhtJl0qYjKadl0PePrk4CfVF6vYwCP9unLx6tijzSNp+3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783338; c=relaxed/simple;
	bh=yNgRE8sbFsnNOSNkaFVjWslqS4WljCPIev13eHJ7d2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHNhUyDk5LNc29+PgIYKmwo3Ui5PFYWo18bQ7Ji/WkNWwPYh3awEkjCYxrN0y9elHTvy/LI/YGOH+cpsiBpsF45voBMkDHTpoXuQeqPGe2gnpYd3HtZa8SeJpKZ3jvnscK5hv0SMgfzPcXn0EtkrF55RQb6Nj9mqZN0s+9aW6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTKaUxrB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTKaUxrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00CDC2BCB7;
	Tue, 21 Apr 2026 14:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783338;
	bh=yNgRE8sbFsnNOSNkaFVjWslqS4WljCPIev13eHJ7d2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTKaUxrB6CCnvZO9DbKdwed0dvhzWBIhh60yKBBdZYUyGLOrHzPTFZA7VguG797+W
	 kVkG6kerplCHTSg9AX1bJ2r91cZYFZzb2YEoem/3RRDl8AhkXZK3jb2w88mhKz+JZ+
	 gcxQWAC2bM15un1YqKrH6ktP5Or/M4bAZc8FhwcLWqzcWWn/iJCC+1f45RNGNoxRdI
	 N3eJR/humoI3w9Besak31t3dcQXLb+Fj7b/Kh7Q9VMZ3eR9G03rLKRM6NbsSoBkI8n
	 Tgckp5xr4/ct4QeAcsTQsjsXF+jAkXG5sKawrPriiiEyd7etliMmg2LWM+5eEsEUuS
	 olYFcyAOSDeQg==
From: guoren@kernel.org
To: fangyu.yu@linux.alibaba.com,
	cp0613@linux.alibaba.com,
	inochiama@gmail.com,
	me@ziyao.cc,
	gaohan@iscas.ac.cn,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	tglx@kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] RISC-V: KVM: AIA: Make HGEI number and management fully per-CPU
Date: Tue, 21 Apr 2026 10:54:48 -0400
Message-Id: <20260421145451.1597930-2-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260421145451.1597930-1-guoren@kernel.org>
References: <20260421145451.1597930-1-guoren@kernel.org>
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
2.40.1

