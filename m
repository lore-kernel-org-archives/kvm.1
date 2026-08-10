Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986E3B7771
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357172; cv=none; b=JqiLh3slCrrL9JT4cqe+hHHTbJQUBO136m3v8OMVcsKHe/BJNVUgfaME7Guur7OY7dN+nVUVwNIcpps1PwVge4H7M1w37axt+BO4yfpv+yWnHPB+9tyiSD6+FYl3B3fYLrTZ88Q/sMC6pri5faZ7ek4kgmqKpf7NzIuvT7ZkfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357172; c=relaxed/simple;
	bh=/VqRg1FiiWK5ygK/J2KLrf5GhjMkP/GTVRwzNgg/XzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k9C+ooF/lEe2evpZVzM08/vDYKamz1OvQGVx9ctfGetDUbtu0XPp/k39Be8epn6MufATwfP0aR3o2EDiiczC9Ze+V+JGbaKcn9g4Q3wWDmOW8wIwKni7olh9tM7DwOlKihSY1cg5e9TDtMhKwfH/wYUQEk7cx7/gTUQ5bKgS73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DusIShwu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DusIShwu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1304526a12.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1786357170; x=1786961970; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ThHcrvznI2+QSAI5cW+DWFGODRhB/qhrAmcxC4O4jLs=;
        b=DusIShwuxKZWozYxV5jAV2zv1vdSxnfq+dPE3zi5Puc/jbaRc/ds4UYuzCqDk0uvKx
         9lJ23XXiUh9pxHxKZ6g88iwMwp+FLFp51RZNJyTEmEHoJyVSd6BgTLhkR4TsGYzH0Y87
         RPiGdS4aZVCqSHbFAGmJdfIYTwu++nGbMtGjGnrj9qp19j3q3C6pLVvlAxH7eCe585WB
         KBx/dZdRyNZwQ/92asFHosU3JeZnA/xVElZRl+gN4dAV6UKcWoLnK3mvWUuDNZfV6iKF
         iwh1m7YFXaPe8A+qu6tYzeEJRhL9xfCtZSLuKkPG13W4ks1b/iHqB5QLNgRAAhOjvey2
         bB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786357170; x=1786961970;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ThHcrvznI2+QSAI5cW+DWFGODRhB/qhrAmcxC4O4jLs=;
        b=e5IKWemKcvi+gXiOrQdHRVRCM/Afifdz135wTsFAduptpj0kudxhL8xPyqZkN8iZV+
         CPmPIbGsW2ow/ZVIrOEyEvYmKOMR7wva7qFDeTK5B7fHGOu+YNFQ3VvnY4FY5amz3gpn
         DdDO/GZNfFuw0bfFa6hwrOLAtVPGZ7vSp7G6a3iGZeLd1feQg4louX0CMIXMBsl+qvf+
         JUWMMk019TMlRGyzvyE97pKefigqxkatA4zkmxDfxEXD70bLIjsm5mufgus4zSKLtvIu
         OH6KtLQX0P/8qt3XzjDNrk6zlse1GiBXcYkS63coHFFPlMmWxP3SM1pM10RZ/E+rB7tI
         RYNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQXK1/Nmpy24htCtCxp6Aycy5JS+VKBrv/ghQJo1wXGblgN7sip9h/rFJraVBFuAA4jqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zJf9AVMQe8cTjhFoa5n8ui7kE1R+VF7kyBlwEFMoMOrjfDEC
	tDAxoUE7HrhAHLePjsErhuTGV5ps0WonGdOvK0dblfLmhbsZspMYxJFDGKTAtRi0/h0=
X-Gm-Gg: AR+sD10Pmy9bxqpb8/de0QagbS37aYsV5zrkooVEqqz8Dt2ru6Wdb5NjRdqMqdJse0Q
	nUhN4dWNQY25/P96lht2iDY3fYXnTQwtJwN4BWFQiQlnfo6nlGx4NTSCsFJxToOqyFWPM+gNbqn
	ip3NT9bRV+PhOvFwPWFeJ6rknzHahcsQOKH0LzH6i3uss/g/usteF62BWR1nZde/QxOguFpP3rU
	8q5NYJ57SBrZZmBvGiwt8vNnaHWFVo9E+Klgcd8KMQFqUMOITV3YSGKjOZS/HxGaO8lcvUUIO/b
	fVLG4JW8vUozFo0InybuC7vSm0eiOwaFydhMaWvV0TmhpT2vKF2IfrOCpSM3RPrVEomgamNPy3q
	0I9k/B383OzvpIqY5YXffsyMa19Upgebn+BwE1TjmFX+iE7UcfhbpB8Tyagm2zvCuBokwEAuptD
	nrbQCwxAS3pVKKQAAtkk80/5W5Mgj0BVV1xE/CBZ6rtklXtJhqk3tMEfwNl2fExo32ZNQVnK5tH
	UPvyZVJ4tjRgXXiMD8=
X-Received: by 2002:a05:6a20:cf8d:b0:3c3:b5db:cd07 with SMTP id adf61e73a8af0-3cb85e61a8emr53401373637.15.1786357170215;
        Mon, 10 Aug 2026 03:19:30 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86fc7bsm41861803eec.1.2026.08.10.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:19:29 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 10 Aug 2026 03:18:50 -0700
Subject: [PATCH v5] KVM: RISC-V: Add CPU PM notifier for non-retention idle
 states
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-kvm-cpu-pm-v5-1-6c9e4c95caf5@sifive.com>
X-B4-Tracking: v=1; b=H4sIAImleWoC/3XNTW7CMBCG4asgr5nKM4zzw4p7oC5sZ1xcFBLFY
 LVCuXsdumgj2uUnzfPOXSWZoiS139zVJDmmOFzKMNuN8id7eROIXdmKNFW6IoZz7sGPNxh7aBk
 ZrfjOBKsKGCcJ8eMRO75+73Rz7+KvS2G5OMV0HabPx7eMy92f4YyAYEg3jSDV1phDiiFmefFDr
 5Zypt+2WlkCDVw3YiQ0nW/dk939b3fFOtEGrQ3SOvtk+cfWhCvLxSJXLrRMhutuZed5/gK0Urq
 mawEAAA==
X-Change-ID: 20260624-kvm-cpu-pm-94141aecd5fa
To: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Nutty Liu <nutty.liu@hotmail.com>, Jinyu Tang <tjytimi@163.com>, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786357169; l=9484;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=/VqRg1FiiWK5ygK/J2KLrf5GhjMkP/GTVRwzNgg/XzA=;
 b=iAYM+gAFzpYb4R/Mq3dv0mA5Ov5+pwu7A2n2aOT5kR1LiY/G6elW/hWelTbdQUKOXFfzd6hXG
 /hKKgxqd6X0C1UVKkhtWIO60/zJ8pJCYMpicxju11FH2TJeM9H98+kM
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
Changes in v5:
- Remove patch1 as it was merged.
- Add per-CPU virtualization state tracking (sashiko)
- Rename CSR helper functions (Anup)
- Introduce dedicated PM functions for AIA (Anup)
- Fix module exit sequence (Anup)
- Link to v4: https://patch.msgid.link/20260721-kvm-cpu-pm-v4-0-146bf942547d@sifive.com

Changes in v4:
- Remove the system_state checking (sashiko)
- Link to v3: https://patch.msgid.link/20260626-kvm-cpu-pm-v3-0-be051aafe9ba@sifive.com

Changes in v3:
- Remove the error kvm_riscv_nacl_disable() call in kvm_riscv_csr_disable()
(sashiko)
- Unregister CPU PM notifier first in riscv_kvm_exit() (sashiko)
- Link to v2: https://patch.msgid.link/20260626-kvm-cpu-pm-v2-0-478e5ef8dc9b@sifive.com

Changes in v2:
- Add patch 1 force restore VCPU after power state transitions (sashiko)
- Added CPU_PM_ENTER_FAILED event handling (sashiko)
- Optimized HGEIE save/restore with saved_value field (sashiko)
- Fixed HIE CSR restoration in lightweight idle resume path (sashiko)
- Link to v1: https://patch.msgid.link/20260624-kvm-cpu-pm-v1-1-52088e127a55@sifive.com
---
To: Anup Patel <anup@brainfault.org>
To: Atish Patra <atish.patra@linux.dev>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Radim Krčmář <radim.krcmar@oss.qualcomm.com>
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Nutty Liu <nutty.liu@hotmail.com>
To: Jinyu Tang <tjytimi@163.com>
Cc: greentime.hu@sifive.com
Cc: vincent.chen@sifive.com
Cc: zong.li@sifive.com
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/riscv/include/asm/kvm_aia.h |   3 ++
 arch/riscv/kvm/aia.c             |  42 ++++++++++++++++
 arch/riscv/kvm/main.c            | 106 ++++++++++++++++++++++++++++++++-------
 3 files changed, 133 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index c67ec5ac0a14..ab03f853e507 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -165,6 +165,9 @@ int kvm_riscv_aia_alloc_hgei(int cpu, struct kvm_vcpu *owner,
 			     void __iomem **hgei_va, phys_addr_t *hgei_pa);
 void kvm_riscv_aia_free_hgei(int cpu, int hgei);
 
+void kvm_riscv_aia_pm_exit(void);
+void kvm_riscv_aia_pm_enter(void);
+
 void kvm_riscv_aia_enable(void);
 void kvm_riscv_aia_disable(void);
 int kvm_riscv_aia_init(void);
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 9a653b4ad40a..0de9b8852ed2 100644
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
@@ -553,6 +554,47 @@ static void aia_hgei_exit(void)
 	free_percpu_irq(hgei_parent_irq, &aia_hgei);
 }
 
+void kvm_riscv_aia_pm_exit(void)
+{
+	struct aia_hgei_control *hgctrl;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	hgctrl = this_cpu_ptr(&aia_hgei);
+	csr_write(CSR_HGEIE, hgctrl->saved_value);
+
+	csr_write(CSR_HVICTL, aia_hvictl_value(false));
+	csr_write(CSR_HVIPRIO1, 0x0);
+	csr_write(CSR_HVIPRIO2, 0x0);
+#ifdef CONFIG_32BIT
+	csr_write(CSR_HVIPH, 0x0);
+	csr_write(CSR_HIDELEGH, 0x0);
+	csr_write(CSR_HVIPRIO1H, 0x0);
+	csr_write(CSR_HVIPRIO2H, 0x0);
+#endif
+	csr_set(CSR_HIE, BIT(IRQ_S_GEXT));
+	/* Enable IRQ filtering for overflow interrupt only if sscofpmf is present */
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
+		csr_set(CSR_HVIEN, BIT(IRQ_PMU_OVF));
+}
+
+void kvm_riscv_aia_pm_enter(void)
+{
+	struct aia_hgei_control *hgctrl;
+
+	if (!kvm_riscv_aia_available())
+		return;
+
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SSCOFPMF))
+		csr_clear(CSR_HVIEN, BIT(IRQ_PMU_OVF));
+
+	csr_write(CSR_HVICTL, aia_hvictl_value(false));
+
+	hgctrl = this_cpu_ptr(&aia_hgei);
+	hgctrl->saved_value = csr_read(CSR_HGEIE);
+}
+
 void kvm_riscv_aia_enable(void)
 {
 	const struct imsic_global_config *gc;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 350e4f097d6e..20b516e84e60 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -10,11 +10,14 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kvm_host.h>
+#include <linux/cpu_pm.h>
 #include <asm/cpufeature.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
 #include <asm/sbi.h>
 
+static DEFINE_PER_CPU(bool, kvm_riscv_virtualization_enabled);
+
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_vsstage_tlb_no_gpa);
 
 static void kvm_riscv_setup_vendor_features(void)
@@ -33,14 +36,9 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return -EINVAL;
 }
 
-int kvm_arch_enable_virtualization_cpu(void)
+/* Initialize hypervisor CSRs - called during CPU online and non-retention idle resume */
+static void kvm_riscv_csr_init(void)
 {
-	int rc;
-
-	rc = kvm_riscv_nacl_enable();
-	if (rc)
-		return rc;
-
 	csr_write(CSR_HEDELEG, 0);
 	csr_write(CSR_HIDELEG, 0);
 
@@ -48,16 +46,11 @@ int kvm_arch_enable_virtualization_cpu(void)
 	csr_write(CSR_HCOUNTEREN, 0x02);
 
 	csr_write(CSR_HVIP, 0);
-
-	kvm_riscv_aia_enable();
-
-	return 0;
 }
 
-void kvm_arch_disable_virtualization_cpu(void)
+/* Clear hypervisor CSRs - called during CPU offline and non-retention idle entry */
+static void kvm_riscv_csr_cleanup(void)
 {
-	kvm_riscv_aia_disable();
-
 	/*
 	 * After clearing the hideleg CSR, the host kernel will receive
 	 * spurious interrupts if hvip CSR has pending interrupts and the
@@ -70,10 +63,69 @@ void kvm_arch_disable_virtualization_cpu(void)
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
+	kvm_riscv_csr_init();
+	kvm_riscv_aia_enable();
+
+	__this_cpu_write(kvm_riscv_virtualization_enabled, true);
 
+	return 0;
+}
+
+void kvm_arch_disable_virtualization_cpu(void)
+{
+	kvm_riscv_aia_disable();
+	kvm_riscv_csr_cleanup();
 	kvm_riscv_nacl_disable();
+
+	__this_cpu_write(kvm_riscv_virtualization_enabled, false);
+}
+
+static int kvm_riscv_cpu_pm_notifier(struct notifier_block *self, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		/*
+		 * Only restore hypervisor state if KVM virtualization is
+		 * enabled on this CPU. This prevents unintentional re-enabling
+		 * of virtualization after it has been explicitly disabled.
+		 */
+		if (__this_cpu_read(kvm_riscv_virtualization_enabled)) {
+			kvm_riscv_csr_init();
+			kvm_riscv_aia_pm_exit();
+		}
+		return NOTIFY_OK;
+	case CPU_PM_ENTER:
+		/*
+		 * Only save and clear hypervisor state if KVM virtualization
+		 * is enabled on this CPU.
+		 */
+		if (__this_cpu_read(kvm_riscv_virtualization_enabled)) {
+			kvm_riscv_aia_pm_enter();
+			kvm_riscv_csr_cleanup();
+		}
+		return NOTIFY_OK;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block kvm_riscv_cpu_pm_nb = {
+	.notifier_call = kvm_riscv_cpu_pm_notifier,
+};
+
 static void kvm_riscv_teardown(void)
 {
 	kvm_riscv_aia_exit();
@@ -174,17 +226,31 @@ static int __init riscv_kvm_init(void)
 
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
 
@@ -192,6 +258,10 @@ static void __exit riscv_kvm_exit(void)
 {
 	kvm_exit();
 
+	/* Unregister CPU PM notifier */
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&kvm_riscv_cpu_pm_nb);
+
 	kvm_riscv_teardown();
 }
 module_exit(riscv_kvm_exit);

---
base-commit: dfdf1374fdeccb5b7e3d35186228e01ec5ea5f01
change-id: 20260624-kvm-cpu-pm-94141aecd5fa

