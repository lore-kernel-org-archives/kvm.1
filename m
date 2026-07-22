Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D9332621
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699531; cv=none; b=JeCqfJTSz0NOb0v5Y0XmP/kbEZRq8OwU3xP05uJS9pfKlT6uw8lUYmymeQngalrBBYSg2CfRTM6JIryMr1qyOAyo/1wzHt4QxdOKeCy6RiBWPad7pp0xL8ztXUQ+QNyXQxQ+oGMgFsgxHRWsw+RK31mogLMTy1C/vaOddsBtyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699531; c=relaxed/simple;
	bh=9/BZKX/NjO1hAGhd35XFfyAO3E7Se5ihP2aZWgnztn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWl8kWwnmmifxqiYUCfyeTsuhdpX+UO1NUnAB/vL05LAWkLZpwKMjYXow8sgewnQ4Xcs+qhV/0mYHU9t967COhye6ywYddssOMw6Ri7EeprI9Eb0oiFosThLatPCOss+hGRp7g1UQyUg4nKFXU0Uw+DvtJmwSaU+/wTrn1Smlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XqEXnkh7; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XqEXnkh7"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso8228079a12.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784699529; x=1785304329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+Vs18zUuW9jRHKRWV57BKDh6kBFOJsRh9ahu/u+GUs=;
        b=XqEXnkh7xwgdA/jMUrtWc29Qvlx0ZM6T3Osa32YvsUO3SeONCvyClj8KsI7ciIl6w1
         4JqFIW/5gKSgrocQslr3ZlKRAmkGt+wXJcsYDu9vUro9xmdK7Ffl9ScED8NNUOZgy3PR
         tkeh94kBrX03QbfJ/sAr5EX9y6IPfvP1vQzeG5zRtQYlAbj2ru2cw3FSuzAoRBTi632d
         ozVhFjDXoo6Kd9eX64XyBIq/kjNIb2sw4SLxAsgA2c8wrpjCT938feSqJAe968ybfMmo
         dLPHqdAmrsb2eYb3JMLSbZAs4BVGSAtEkrpxVfgJxQeWIsAWovxBwxSUQBhauEHdn8We
         7Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784699529; x=1785304329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+Vs18zUuW9jRHKRWV57BKDh6kBFOJsRh9ahu/u+GUs=;
        b=gd4UyBAZpRt0ic1dbKZuETl0WloGKLU83mGmmyDCs9+XUMKn1IlcXhuTWSesFi6+0c
         1O2j61Ry9JbXFrgOP4Sm6uBBJzaTT0wod9klwItNf9guxr7pzGBSH0XWq3TJ7drLW4By
         Sd+azZIaomQq83QS2voMdhQ10jk4Le7HZeGJg3RTjfbD6++C93stHjNG4XY4tMvZnB3m
         hw+xJQHiTJgk9pDEk++DcjPfUUsDx4fjdjUl5OU5iDE49u++XqvpSHgGorJ+FZbrGumX
         2JQ+p5gCOTmWglk1Zpnu4FWyOdRlQlTXsnozVwpjaUZgi5PfKTviI9JroNc7T+YJA9KE
         uz9w==
X-Forwarded-Encrypted: i=1; AHgh+RoCtnXfNS/wzKFj8t65IJGIp69zjeEejWI5uZ/fG+TiPfkeZ6Ejq0/rmzJZeDP0FuZCh8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7X71Xa8Et6yEwuUxYGGmBPPT2+QjhgXLT/dzGnj/AJ1yhhV++
	i3R20ft2z8ubcBk3xd0EJ8mrc21lEjeEwYBQt/UaXQWuCqh7Ji7Tn79J1430KWaFIIU=
X-Gm-Gg: AR+sD13jJyb+dNxAqz/AMrQ47fRB4hggmmqZVj2WuuYl1+sqEbA1aO+GZhMBr/XmRFD
	7FBfQTVc6rbyNyGyvnyAsA/oXCsmjfz2tnBjyVTp61gxgUpejfTA1+Gak9X8wjlkRrewV8o75wz
	ZoMzvBRw4rwBpdFhpUc2gCxTqFCYzwvDv4xWfRVD6xttM5fmBL/Oq84oy7/KE7kJlh+QCT8gPRB
	ntKxrTK75T2itVeF8X5/YR8udG12tgCU+z3yWz2bXM/RuHwApEkF4rf1xHAdqFHC7jrAyfzqMgA
	3KPTx/Cm/yTGWW0z7Fyfq9IuqtIHu0jqlNbjGjx711G/t/ftCs9iXic2WjHCXCBvXuiLELaet9+
	jVOlFVo/F8jMN+nLeXBQL0xnbgTXpUHRBcvEyIdX9Su30T+ta+KZJ4rDCjQX9mghDVGwwMXRo/W
	3xl40AJ4gwCSUrl+Nr03b22Q==
X-Received: by 2002:a05:6300:95:b0:3c3:719d:dfe2 with SMTP id adf61e73a8af0-3c3ad95dd8cmr22080498637.36.1784699529275;
        Tue, 21 Jul 2026 22:52:09 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e081985sm5133138eec.23.2026.07.21.22.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 22:52:07 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Tue, 21 Jul 2026 22:52:03 -0700
Subject: [PATCH v4 2/2] KVM: RISC-V: Add CPU PM notifier for non-retention
 idle states
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-kvm-cpu-pm-v4-2-146bf942547d@sifive.com>
References: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
In-Reply-To: <20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784699525; l=11836;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=9/BZKX/NjO1hAGhd35XFfyAO3E7Se5ihP2aZWgnztn8=;
 b=niIBXZSIQus8Jg/hSaPimYNJO/9uNn2M97DA3DTsHcAo3Rhg/aVvGP8FpaZEwd1DvWUXCQwSj
 cdpsKyDFxnrCLlky72TMk8WrJal86b9LaongPc3l2+BEOX8ChchtW9G
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Register a CPU_PM notifier to restore hypervisor CSR content during CPU
non-retention idle states. When a CPU enters a deep idle state that
powers off the CPU domain, hypervisor CSRs and VS CSRs lose their state
and must be saved before entry and restored after exit.

This completes KVM's power management coverage for RISC-V:
- CPU hotplug: handled by kvm_online_cpu/kvm_offline_cpu (cpuhp callbacks)
- System suspend: handled by kvm_suspend/kvm_resume (syscore ops)
- CPU idle (retention): no action needed, CSRs are retained
- CPU idle (non-retention): handled by this CPU_PM notifier

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/include/asm/kvm_aia.h |  15 +++-
 arch/riscv/kvm/aia.c             | 144 ++++++++++++++++++++++-----------------
 arch/riscv/kvm/main.c            |  87 ++++++++++++++++++-----
 3 files changed, 163 insertions(+), 83 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index c67ec5ac0a14..7c1c3250598f 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -165,8 +165,19 @@ int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcpu *owner,
 			     void __iomem **hgei_va, phys_addr_t *hgei_pa);
 void kvm_riscv_aia_free_hgei(int cpu, int hgei);
 
-void kvm_riscv_aia_enable(void);
-void kvm_riscv_aia_disable(void);
+/**
+ * kvm_riscv_aia_enable() - Enable AIA support on current CPU
+ * @full_cleanup: true = full hardware init (CPU hotplug/module load),
+ *                false = lightweight CSR restore (CPU non-retention idle resume)
+ */
+void kvm_riscv_aia_enable(bool full_cleanup);
+
+/**
+ * kvm_riscv_aia_disable() - Disable AIA support on current CPU
+ * @full_cleanup: true = full hardware cleanup (CPU hotplug/module exit),
+ *                false = lightweight CSR save (CPU non-retention idle entry)
+ */
+void kvm_riscv_aia_disable(bool full_cleanup);
 int kvm_riscv_aia_init(void);
 void kvm_riscv_aia_exit(void);
 
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index bafb009c5ce5..4cf351f91c64 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -25,6 +25,7 @@ struct aia_hgei_control {
 	unsigned long free_bitmap;
 	struct kvm_vcpu *owners[BITS_PER_LONG];
 	unsigned int nr_hgei;
+	unsigned long saved_value;
 };
 static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
 static int hgei_parent_irq;
@@ -532,50 +533,59 @@ static void aia_hgei_exit(void)
 	free_percpu_irq(hgei_parent_irq, &aia_hgei);
 }
 
-void kvm_riscv_aia_enable(void)
+void kvm_riscv_aia_enable(bool full_cleanup)
 {
-	const struct imsic_global_config *gc;
-	const struct imsic_local_config *lc;
 	struct aia_hgei_control *hgctrl;
 	unsigned long flags;
-	int aia_nr_hgei;
 
 	if (!kvm_riscv_aia_available())
 		return;
 
-	gc = imsic_get_global_config();
-	lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
 	hgctrl = this_cpu_ptr(&aia_hgei);
 
-	/* Figure-out number of bits in HGEIE */
-	csr_write(CSR_HGEIE, -1UL);
-	hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
-	csr_write(CSR_HGEIE, 0);
-	if (hgctrl->nr_hgei)
-		hgctrl->nr_hgei--;
+	if (full_cleanup) {
+		const struct imsic_global_config *gc;
+		const struct imsic_local_config *lc;
+		int aia_nr_hgei;
 
-	/*
-	 * Number of usable per-HART HGEI lines should be minimum of
-	 * per-HART IMSIC guest files and number of bits in HGEIE.
-	 */
-	if (lc)
-		hgctrl->nr_hgei = min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
-	else
-		hgctrl->nr_hgei = 0;
+		gc = imsic_get_global_config();
+		lc = (gc) ? this_cpu_ptr(gc->local) : NULL;
 
-	/* Update the number of IMSIC guest files across all HARTs */
-	aia_nr_hgei = atomic_read(&kvm_riscv_aia_nr_hgei);
-	do {
-		if (aia_nr_hgei <= hgctrl->nr_hgei)
-			break;
-	} while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei, hgctrl->nr_hgei));
+		/* Figure-out number of bits in HGEIE */
+		csr_write(CSR_HGEIE, -1UL);
+		hgctrl->nr_hgei = fls_long(csr_read(CSR_HGEIE));
+		csr_write(CSR_HGEIE, 0);
+		if (hgctrl->nr_hgei)
+			hgctrl->nr_hgei--;
 
-	raw_spin_lock_irqsave(&hgctrl->lock, flags);
-	if (!hgctrl->free_bitmap_initialized) {
-		hgctrl->free_bitmap = (hgctrl->nr_hgei) ? GENMASK_ULL(hgctrl->nr_hgei, 1) : 0;
-		hgctrl->free_bitmap_initialized = true;
+		/*
+		 * Number of usable per-HART HGEI lines should be minimum of
+		 * per-HART IMSIC guest files and number of bits in HGEIE.
+		 */
+		if (lc)
+			hgctrl->nr_hgei = min((ulong)hgctrl->nr_hgei, lc->nr_guest_files);
+		else
+			hgctrl->nr_hgei = 0;
+
+		/* Update the number of IMSIC guest files across all HARTs */
+		aia_nr_hgei = atomic_read(&kvm_riscv_aia_nr_hgei);
+		do {
+			if (aia_nr_hgei <= hgctrl->nr_hgei)
+				break;
+		} while (!atomic_try_cmpxchg(&kvm_riscv_aia_nr_hgei, &aia_nr_hgei,
+					     hgctrl->nr_hgei));
+
+		raw_spin_lock_irqsave(&hgctrl->lock, flags);
+		if (!hgctrl->free_bitmap_initialized) {
+			hgctrl->free_bitmap = (hgctrl->nr_hgei) ?
+					      GENMASK_ULL(hgctrl->nr_hgei, 1) :
+					      0;
+			hgctrl->free_bitmap_initialized = true;
+		}
+		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+	} else {
+		csr_write(CSR_HGEIE, hgctrl->saved_value);
 	}
-	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
 
 	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 	csr_write(CSR_HVIPRIO1, 0x0);
@@ -587,16 +597,17 @@ void kvm_riscv_aia_enable(void)
 	csr_write(CSR_HVIPRIO2H, 0x0);
 #endif
 
-	/* Enable per-CPU SGEI interrupt */
-	enable_percpu_irq(hgei_parent_irq,
-			  irq_get_trigger_type(hgei_parent_irq));
+	if (full_cleanup)
+		enable_percpu_irq(hgei_parent_irq,
+				  irq_get_trigger_type(hgei_parent_irq));
 	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
+
 	/* Enable IRQ filtering for overflow interrupt only if sscofpmf is present */
 	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
 		csr_set(CSR_HVIEN, BIT(IRQ_PMU_OVF));
 }
 
-void kvm_riscv_aia_disable(void)
+void kvm_riscv_aia_disable(bool full_cleanup)
 {
 	int i;
 	unsigned long flags;
@@ -609,42 +620,49 @@ void kvm_riscv_aia_disable(void)
 
 	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
 		csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
-	/* Disable per-CPU SGEI interrupt */
-	csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
-	disable_percpu_irq(hgei_parent_irq);
 
-	csr_write(CSR_HVICTL, aia_hvictl_value(false));
-
-	raw_spin_lock_irqsave(&hgctrl->lock, flags);
-
-	for (i = 0; i <= hgctrl->nr_hgei; i++) {
-		vcpu = hgctrl->owners[i];
-		if (!vcpu)
-			continue;
+	if (full_cleanup) {
+		/* Disable per-CPU SGEI interrupt */
+		csr_clear(CSR_HIE, BIT(IRQ_S_GEXT));
+		disable_percpu_irq(hgei_parent_irq);
+	}
 
-		/*
-		 * We release hgctrl->lock before notifying IMSIC
-		 * so that we don't have lock ordering issues.
-		 */
-		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+	csr_write(CSR_HVICTL, aia_hvictl_value(false));
 
-		/* Notify IMSIC */
-		kvm_riscv_vcpu_aia_imsic_release(vcpu);
+	if (full_cleanup) {
+		raw_spin_lock_irqsave(&hgctrl->lock, flags);
 
-		/*
-		 * Wakeup VCPU if it was blocked so that it can
-		 * run on other HARTs
-		 */
-		if (csr_read(CSR_HGEIE) & BIT(i)) {
-			csr_clear(CSR_HGEIE, BIT(i));
-			kvm_vcpu_kick(vcpu);
+		for (i = 0; i <= hgctrl->nr_hgei; i++) {
+			vcpu = hgctrl->owners[i];
+			if (!vcpu)
+				continue;
+
+			/*
+			 * We release hgctrl->lock before notifying IMSIC
+			 * so that we don't have lock ordering issues.
+			 */
+			raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+
+			/* Notify IMSIC */
+			kvm_riscv_vcpu_aia_imsic_release(vcpu);
+
+			/*
+			 * Wakeup VCPU if it was blocked so that it can
+			 * run on other HARTs
+			 */
+			if (csr_read(CSR_HGEIE) & BIT(i)) {
+				csr_clear(CSR_HGEIE, BIT(i));
+				kvm_vcpu_kick(vcpu);
+			}
+
+			raw_spin_lock_irqsave(&hgctrl->lock, flags);
 		}
 
-		raw_spin_lock_irqsave(&hgctrl->lock, flags);
+		raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
+	} else {
+		hgctrl->saved_value = csr_read(CSR_HGEIE);
 	}
 
-	raw_spin_unlock_irqrestore(&hgctrl->lock, flags);
-
 	put_cpu_ptr(&aia_hgei);
 }
 
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 350e4f097d6e..b48bbd1855c1 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kvm_host.h>
+#include <linux/cpu_pm.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
@@ -33,14 +34,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
-int kvm_arch_enable_virtualization_cpu(void)
+/* Initialize hypervisor CSRs - called during CPU online and non-retention idle resume */
+static void kvm_riscv_csr_enable(void)
 {
-	int rc;
-
-	rc = kvm_riscv_nacl_enable();
-	if (rc)
-		return rc;
-
 	csr_write(CSR_HEDELEG, 0);
 	csr_write(CSR_HIDELEG, 0);
 
@@ -48,16 +44,11 @@ int kvm_arch_enable_virtualization_cpu(void)
 	csr_write(CSR_HCOUNTEREN, 0x02);
 
 	csr_write(CSR_HVIP, 0);
-
-	kvm_riscv_aia_enable();
-
-	return 0;
 }
 
-void kvm_arch_disable_virtualization_cpu(void)
+/* Clear hypervisor CSRs - called during CPU offline and non-retention idle entry */
+static void kvm_riscv_csr_disable(void)
 {
-	kvm_riscv_aia_disable();
-
 	/*
 	 * After clearing the hideleg CSR, the host kernel will receive
 	 * spurious interrupts if hvip CSR has pending interrupts and the
@@ -70,10 +61,52 @@ void kvm_arch_disable_virtualization_cpu(void)
 	csr_write(CSR_HIDELEG, 0);
 
 	kvm_riscv_clear_former_vcpu();
+}
+
+int kvm_arch_enable_virtualization_cpu(void)
+{
+	int rc;
+
+	rc = kvm_riscv_nacl_enable();
+	if (rc)
+		return rc;
+
+	kvm_riscv_csr_enable();
+	kvm_riscv_aia_enable(true);
 
+	return 0;
+}
+
+void kvm_arch_disable_virtualization_cpu(void)
+{
+	kvm_riscv_aia_disable(true);
+	kvm_riscv_csr_disable();
 	kvm_riscv_nacl_disable();
 }
 
+static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		kvm_riscv_csr_enable();
+		kvm_riscv_aia_enable(false);
+		return NOTIFY_OK;
+	case CPU_PM_ENTER:
+		kvm_riscv_aia_disable(false);
+		kvm_riscv_csr_disable();
+		return NOTIFY_OK;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kvm_riscv_cpu_pm_nb = {
+	.notifier_call = kvm_riscv_cpu_pm_notifier,
+};
+
 static void kvm_riscv_teardown(void)
 {
 	kvm_riscv_aia_exit();
@@ -174,22 +207,40 @@ static int __init riscv_kvm_init(void)
 
 	kvm_register_perf_callbacks();
 
-	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
-	if (rc) {
-		kvm_riscv_teardown();
-		return rc;
+	/* Register CPU PM notifier for CPU idle non-retention states */
+	if (IS_ENABLED(CONFIG_CPU_PM)) {
+		rc = cpu_pm_register_notifier(&kvm_riscv_cpu_pm_nb);
+		if (rc) {
+			kvm_err("Failed to register CPU PM notifier: %d\n", rc);
+			goto err_teardown;
+		}
 	}
 
+	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+	if (rc)
+		goto err_unregister_cpu_pm;
+
 	if (kvm_riscv_aia_available())
 		kvm_info("AIA available with %d guest external interrupts\n",
 			 atomic_read(&kvm_riscv_aia_nr_hgei));
 
 	return 0;
+
+err_unregister_cpu_pm:
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
+err_teardown:
+	kvm_riscv_teardown();
+	return rc;
 }
 module_init(riscv_kvm_init);
 
 static void __exit riscv_kvm_exit(void)
 {
+	/* Unregister CPU PM notifier */
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
+
 	kvm_exit();
 
 	kvm_riscv_teardown();

-- 
2.43.7

