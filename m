Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7041A76A
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598186; cv=none; b=by6JekTAurBtLBwt3S4NKNiLhlh1lilbzaEb3LIO6gTXj/Ug2wqmCfVwt44z0dmxDFBTuztmDitX2cekTakKBfMzdTtws1vx3z7u7mSIyxMggYPdG4eP0uRJyPV6xDZDkSksXGWaQoxKWrgOMDVEQMTPndmeg+eE934DFAm03Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598186; c=relaxed/simple;
	bh=Oo3bx9uN5IkjwBoMlfjo4Vs2GEEjne0/akECfyp9msw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BrfA5BaIxD2D6GSEPW4jNbjGdzzpVkocsCXvpsG+RbrpnF9Q2nMjaBCYUp5MHuuF2kuQkyXzMnEpQ8Eh6K3dgMoUR1QST6m4k/FxxVuB5Plb5HJH+TcPy1f6O8xu09VUDwEVjdNlr67GxkhnsaczEWhHF6ElYICwoCpd8IeZhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTmOTucp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTmOTucp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso16283945ad.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783598181; x=1784202981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CivCo3sxABn6gVyRhQlVLSU7JseOeDcuh4Y0SWmJVu4=;
        b=dTmOTucpPLcfOqDTthUuecmoXf9OvsKRDIhe3nwEzoEy4EHPpa5a+e00Q4h0iwNcjC
         mOt8ogZ+84e5kH1Q4TufOLuBcDotWJfkpNxQZfb5/+A+zlPLbdSM554e3pG3gcPMRIRg
         khhEySXTxfZ8/vYyu++lfqKqVS1r2lIIYWxrVU2Z2h/4Pw009gc4+8LNaqAQGtzMAf2s
         9cVQjTw8n5ENMbEguWeQdtl54Bwnb40cs8ZMj+CxvA2QUesvpIwir/Rs7iqxklh2/hvx
         dHgolKXgUiLAJH1OSF+czR1YLNUN5fSCDpi1heyGCTHPnexPPgMbAPDq8QgZiB5S7VeQ
         Tf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598181; x=1784202981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CivCo3sxABn6gVyRhQlVLSU7JseOeDcuh4Y0SWmJVu4=;
        b=QGtFi9Bt6R4oi2qHMRdSONvpo/x1yPx8I8CUTfWHEMmA9ij7V/tCgBgxFDIJEEqye9
         KLIGR87WeoeG/0glvSCRHSiUaoDqZFbTuz19aYZjC2Rj1EfEGlCRslGyK2VoAiFz6gGB
         2avaN+VJw//QlYRefhPfSCpA1KlVqCA+qCJNiVgqPA6di/CZSEinBniAXBQu11HbzJo+
         HaXC1Y6H8B4a/CfxWnzg8UN3jq7WU78IUs9cpKB3vb3A74YGi6khhhrlqAHQhkp+9DFt
         Sm2nsLf4wdfUrWFwy/cGpiW+BoOH+VwOVMY0n+CON5EFX+ONXmgkeh7aLRBmdABAEUAo
         s7Ag==
X-Forwarded-Encrypted: i=1; AHgh+RoZKvJ+tRT3ovp0g7OKc5WRJRB7fUtELrILtecvlTaMl8t0qEo1yjTtoWfSj6HyxZQoezA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmuhfMZ/5zWrQ6Bu7ts50JbyDsjhOyFyOrTcnWZk1bi8uaP3+D
	6+g0P5vGLPLKSCmkEnH6H+gsanjKzMyJj6WowMtexnqrTgymYv7DW7qE
X-Gm-Gg: AfdE7cmkTziFRvxdiDf6hAPl/Clf/4QgmyRdwsGjVfvKVhKfN0qQmLZ5+4j4DYMfIfw
	22TiaolOMBjq7EJUZy+us7JfGEf1Ig+Urwwimv9bydykKV1s+O5sjSWZaXGks34Nr8Hyb30FQZI
	KvBu4Ch8QeRQP+scRoBzhRWnds+emXl6pifN8h6/jcUs5Z/nOK+HFl8FnjnIsi3Af1fovQeNsmY
	t7ApJVkmSkEf/wlVd2tT64A/jCX8KfznV7/QHIkE8ExxAfONmbNst93486bhrKeiahGP8nfccvs
	vAeTY7n3koY7twuWROLlQT0jmgeL1XKymg5TqgbGWJvhK4htZjiiedz9R1hr/7DGu6yDTl7C5AC
	/WG4NBvvuQUNt9msKWfbJ3IiUmq5wGNndMXO0djYwgDBoEQ6mATvgLjZM9iUF9ZGhms23mYX0ae
	/EkyhyLibOcpN3zTZjNXJr2NP/8JGtIovaX/q+AR52ew==
X-Received: by 2002:a17:903:4b4e:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2ccea5a815emr69832995ad.44.1783598180886;
        Thu, 09 Jul 2026 04:56:20 -0700 (PDT)
Received: from cyh-System-Product-Name.. ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3b906sm43917145ad.56.2026.07.09.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 04:56:20 -0700 (PDT)
From: "Yuhang.chen" <yhchen312@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Add kvm-riscv.wfi_trap_policy to control VS-mode WFI trapping
Date: Thu,  9 Jul 2026 19:56:10 +0800
Message-Id: <20260709115610.287420-1-yhchen312@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel command-line option, kvm-riscv.wfi_trap_policy=trap|notrap,
that controls whether a WFI executed by a VS-mode guest traps into KVM
(HS-mode) or executes natively.

Measured results (wfi_exit_stat delta / guest wake count over 3 s):

  policy        WFI_EXITS   WAKE_CNT
  ----------    ---------   --------
  default       295         294      (== trap, no regression)
  trap          295         294
  notrap          0         298

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Yuhang.chen <yhchen312@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++
 arch/riscv/kvm/vcpu.c                         | 44 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..ee6603b30033 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3254,6 +3254,20 @@ Kernel parameters
 
 			notrap: clear WFI instruction trap
 
+	kvm-riscv.wfi_trap_policy=
+			[KVM,RISCV] Control when to set the WFI instruction
+			trap for KVM VMs. When set, a VS-mode WFI traps into
+			KVM and is emulated; when clear, the guest executes
+			WFI natively and blocks until a VS-mode interrupt
+			(e.g. the sstc timer) is pending.
+
+			trap: set WFI instruction trap (HSTATUS.VTW=1)
+
+			notrap: clear WFI instruction trap (HSTATUS.VTW=0)
+
+			Defaults to trap, preserving the previous
+			unconditional behavior.
+
 	kvm_cma_resv_ratio=n [PPC,EARLY]
 			Reserves given percentage from system memory area for
 			contiguous memory allocation for KVM hash pagetable
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index c3672513b4e9..d50b47ed280e 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -12,6 +12,7 @@
 #include <linux/kdebug.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
@@ -26,6 +27,42 @@
 
 static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_former_vcpu);
 
+/*
+ * WFI trap policy for VS-mode guests, controllable through the
+ * kvm-riscv.wfi_trap_policy= kernel command-line option.
+ */
+enum kvm_riscv_wfi_trap_policy {
+	KVM_RISCV_WFI_TRAP,	/* Default: trap VS-mode WFI into KVM */
+	KVM_RISCV_WFI_NOTRAP,	/* Let VS-mode WFI execute natively */
+};
+
+static enum kvm_riscv_wfi_trap_policy kvm_riscv_wfi_trap_policy __read_mostly =
+	KVM_RISCV_WFI_TRAP;
+
+static int __init early_kvm_riscv_wfi_trap_policy_cfg(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (strcmp(arg, "trap") == 0) {
+		kvm_riscv_wfi_trap_policy = KVM_RISCV_WFI_TRAP;
+		return 0;
+	}
+
+	if (strcmp(arg, "notrap") == 0) {
+		kvm_riscv_wfi_trap_policy = KVM_RISCV_WFI_NOTRAP;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("kvm-riscv.wfi_trap_policy", early_kvm_riscv_wfi_trap_policy_cfg);
+
+static bool kvm_riscv_vcpu_wfi_should_trap(struct kvm_vcpu *vcpu)
+{
+	return kvm_riscv_wfi_trap_policy == KVM_RISCV_WFI_TRAP;
+}
+
 const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
 	STATS_DESC_COUNTER(VCPU, ecall_exit_stat),
@@ -73,7 +110,12 @@ static void kvm_riscv_vcpu_context_reset(struct kvm_vcpu *vcpu,
 	/* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
 	cntx->sstatus = SR_SPP | SR_SPIE;
 
-	cntx->hstatus |= HSTATUS_VTW;
+	/*
+	 * Trap VS-mode WFI into KVM unless the WFI trap policy lets the guest
+	 * execute it natively. See kvm_riscv_wfi_trap_policy.
+	 */
+	if (kvm_riscv_vcpu_wfi_should_trap(vcpu))
+		cntx->hstatus |= HSTATUS_VTW;
 	cntx->hstatus |= HSTATUS_SPVP;
 	cntx->hstatus |= HSTATUS_SPV;
 }
-- 
2.34.1

