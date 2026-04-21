Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9A3A257C;
	Tue, 21 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783346; cv=none; b=Hpq6xMBr1A/FoLKOQL1LHfySpNsKB8+MJbR6w+qWVGYJVjjTk0xyUEwCzlltIaAZJKMNRS5+4MlHWWgsVHQlECVscqfN03fy0FnSrf8RfFUm2Tl8YiyNxG0ttEcTNSVak/LfLJee3BYsPB3hr3eokJyhNUKOnRZeZpuiE4vRLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783346; c=relaxed/simple;
	bh=p/wdV82CM5k36GboR0wr9dwL7I5eqEnXaA6SjWQmRfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALjkThzVQxS2JNNo7maBhEex7aqCdFTq7OcpJYPODKqIth0qC9zuxXE8zzCVkpDL1ZZ8GDGI25yNq1Src7W7X3XL/TNXu3Kzheo0W+ChAXxvv3pYj3Zuc0hYvHQkd7HBEDxVWX+N81S07Jvche812Swjtva3aCqOIj3Q3s7dsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa1jaqy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa1jaqy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22EC2BCB0;
	Tue, 21 Apr 2026 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776783346;
	bh=p/wdV82CM5k36GboR0wr9dwL7I5eqEnXaA6SjWQmRfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa1jaqy1uX4ggAIR1nqF3d8IXx0KZGfwmVA6Z8jfMhMthXvBdFJF0Mr9+UyUY8Moo
	 3zTrLZJtIChGJlFtY7o5EFHNQximwR+f2HbTkMlQos1LBTsl6o8xuhIlYqLyYPx4jZ
	 2khgDZ6NrK2mTo6XOpQGXa2NbxzYRBAZhErASFbDeMXHOstYf+3roFObXsM2TUSA/H
	 7ASK6YFsVrRd3GTXsRQlvACe5U7v6a7uOql3uyPhTcGc9OsN6fCEcCZvB1gxWnaSkY
	 8msQfhT63/P+MHfZPj/9fMfiWucnHcmFNgWyfB0J2rzMJHQjaN5HcieUt5WGDZ+OQj
	 3fJeW/qyClWuw==
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
Subject: [PATCH 2/3] RISC-V: KVM: AIA: Replace global HGEI count with simple enabled bool
Date: Tue, 21 Apr 2026 10:54:49 -0400
Message-Id: <20260421145451.1597930-3-guoren@kernel.org>
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

Now that HGEI line management is fully per-CPU (via struct
aia_hgei_control::nr_hgei), the global `kvm_riscv_aia_nr_hgei`
is no longer needed. Replace it with a simple `bool
kvm_riscv_aia_hgei_enabled` that only indicates whether HGEI
support is available at all.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/kvm_aia.h |  2 +-
 arch/riscv/kvm/aia.c             | 18 ++++++++----------
 arch/riscv/kvm/aia_device.c      |  4 ++--
 arch/riscv/kvm/main.c            |  3 +--
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index b04ecdd1a860..e8749ac6bed7 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -79,7 +79,7 @@ struct kvm_vcpu_aia {
 
 #define irqchip_in_kernel(k)		((k)->arch.aia.in_kernel)
 
-extern unsigned int kvm_riscv_aia_nr_hgei;
+extern bool kvm_riscv_aia_hgei_enabled;
 extern unsigned int kvm_riscv_aia_max_ids;
 DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 #define kvm_riscv_aia_available() \
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index a23729052cfb..70ff1d25dd99 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -28,7 +28,7 @@ struct aia_hgei_control {
 static DEFINE_PER_CPU(struct aia_hgei_control, aia_hgei);
 static int hgei_parent_irq;
 
-unsigned int kvm_riscv_aia_nr_hgei;
+bool kvm_riscv_aia_hgei_enabled;
 unsigned int kvm_riscv_aia_max_ids;
 DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
 
@@ -491,7 +491,7 @@ static int aia_hgei_init(void)
 	struct irq_domain *domain;
 
 	/* Skip SGEI interrupt setup for zero guest external interrupts */
-	if (!kvm_riscv_aia_nr_hgei)
+	if (!kvm_riscv_aia_hgei_enabled)
 		goto skip_sgei_interrupt;
 
 	/* Find INTC irq domain */
@@ -524,7 +524,7 @@ static int aia_hgei_init(void)
 static void aia_hgei_exit(void)
 {
 	/* Do nothing for zero guest external interrupts */
-	if (!kvm_riscv_aia_nr_hgei)
+	if (!kvm_riscv_aia_hgei_enabled)
 		return;
 
 	/* Free per-CPU SGEI interrupt */
@@ -631,6 +631,7 @@ int kvm_riscv_aia_init(void)
 {
 	int rc;
 	const struct imsic_global_config *gc;
+	unsigned int kvm_riscv_aia_nr_hgei;
 
 	if (!riscv_isa_extension_available(NULL, SxAIA))
 		return -ENODEV;
@@ -641,21 +642,18 @@ int kvm_riscv_aia_init(void)
 	kvm_riscv_aia_nr_hgei = fls_long(csr_read(CSR_HGEIE));
 	csr_write(CSR_HGEIE, 0);
 	if (kvm_riscv_aia_nr_hgei)
-		kvm_riscv_aia_nr_hgei--;
+		kvm_riscv_aia_hgei_enabled = true;
 
 	/*
 	 * Number of usable HGEI lines should be minimum of per-HART
 	 * IMSIC guest files and number of bits in HGEIE
 	 */
-	if (gc)
-		kvm_riscv_aia_nr_hgei = min((ulong)kvm_riscv_aia_nr_hgei,
-					    gc->nr_guest_files);
-	else
-		kvm_riscv_aia_nr_hgei = 0;
+	if (!gc)
+		kvm_riscv_aia_hgei_enabled = 0;
 
 	/* Find number of guest MSI IDs */
 	kvm_riscv_aia_max_ids = IMSIC_MAX_ID;
-	if (gc && kvm_riscv_aia_nr_hgei)
+	if (gc && kvm_riscv_aia_hgei_enabled)
 		kvm_riscv_aia_max_ids = gc->nr_guest_ids + 1;
 
 	/* Initialize guest external interrupt line management */
diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index 3d1e81e2a36b..5b45b1114425 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -71,7 +71,7 @@ static int aia_config(struct kvm *kvm, unsigned long type,
 				 * external interrupts (i.e. non-zero
 				 * VS-level IMSIC pages).
 				 */
-				if (!kvm_riscv_aia_nr_hgei)
+				if (!kvm_riscv_aia_hgei_enabled)
 					return -EINVAL;
 				break;
 			default:
@@ -628,7 +628,7 @@ void kvm_riscv_aia_init_vm(struct kvm *kvm)
 	 */
 
 	/* Initialize default values in AIA global context */
-	aia->mode = (kvm_riscv_aia_nr_hgei) ?
+	aia->mode = (kvm_riscv_aia_hgei_enabled) ?
 		KVM_DEV_RISCV_AIA_MODE_AUTO : KVM_DEV_RISCV_AIA_MODE_EMUL;
 	aia->nr_ids = kvm_riscv_aia_max_ids - 1;
 	aia->nr_sources = 0;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index cb8a65273c1f..bcfa139f4871 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -169,8 +169,7 @@ static int __init riscv_kvm_init(void)
 	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
 
 	if (kvm_riscv_aia_available())
-		kvm_info("AIA available with %d guest external interrupts\n",
-			 kvm_riscv_aia_nr_hgei);
+		kvm_info("AIA available with guest external interrupts\n");
 
 	kvm_riscv_setup_vendor_features();
 
-- 
2.40.1

