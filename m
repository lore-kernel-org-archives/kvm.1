Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D88374A0B;
	Sun, 20 Sep 2026 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909885; cv=none; b=PDPMo7NNB4Z4QyYJahS7hPLUdjKMEAodkHedWsJQrbeLC525A2uwTJXfEpiIEr2LtMKBCZBulxRktZ4XQOHJpJsSz4Dc3MnK6qMjhyCEJIEaRb0yUrS/7muQZEP2I1KVF9S7H55G69p/1aYBwDPe/ChPCx9p0RubZoYVax52pys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909885; c=relaxed/simple;
	bh=iY2tTAN5hfeoLtOYLYi0jYo0ZKivjdPk2NhNjOysVX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLbSqmRTejGBh3WNHvpNbXnTrBPAuMmWWbNx3k4YCGiULwO9U/HQbgUiF2xWs1TPMv8eCpOLgaeGxNQWDH8nHZEVktVpHYt4nFwEeWeioADBti78sRNTS3iprSayMXWcoboFb7M7w298qcGRN/rBluPeOXRt88VBH60ipjUJ3rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XPN8OP0Y; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XPN8OP0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iE
	FMnbAxecubDwFBLIa6PNB7531/R3ke9Bw5hV74+qo=; b=XPN8OP0Yf76mhU3Iyf
	oFY7EFski+crozbHMJfs2Je1V1n1rn67sRlQN2lUvQjPs7D2tLFkuZ8Z7Q/o1hSH
	YQPeTpBpg7gjizvwe0jnq2XJvFC3m8gqmiaqdn2Iaq7QOP1YAqxT8N0XCue1Yg5H
	3K8GElFa+f1YsQDF0ZdUyHwZM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD33+IA269qOrXBAQ--.40335S2;
	Sun, 20 Sep 2026 21:09:21 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: anup@brainfault.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atish.patra@linux.dev>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Guo Ren <guoren@kernel.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Nutty Liu <nutty.liu@hotmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH v2 1/2] RISC-V: KVM: Validate AIA MMIO address ranges
Date: Sun, 20 Sep 2026 21:09:18 +0800
Message-ID: <3046cfd67c5f962014cd38e49a0e8bf28b6fb53f.1789872556.git.hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1789872556.git.hppiscas@163.com>
References: <cover.1789872556.git.hppiscas@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD33+IA269qOrXBAQ--.40335S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DGr1rAFWUXr15KryUKFg_yoWrAr4kpF
	4UGrs8XrWFqryxKwsayr1DC3yY9r1vka13JryUuF4Fkr1Iqr1SkFnYga1jqry5Ar929a1a
	ya1rKayrur4YyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziLvKUUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7gF9Rmqv2wEOyQAA3M

The AIA address setters check alignment but not the complete fixed-size
APLIC and IMSIC MMIO regions. A range can therefore wrap when its end is
formed or extend beyond the selected guest physical address space before
it is registered on the KVM MMIO bus.

Check the complete range in both setters. Return -EINVAL for alignment
or arithmetic overflow and -E2BIG for a range beyond the selected GPA
limit, following the arm64 VGIC address-validation convention.

Recheck only the APLIC range during initialization: userspace can set
its address and then change KVM_CAP_VM_GPA_BITS while the VM still has
no vCPUs or memory slots. An IMSIC address, in contrast, can only be set
for an existing vCPU, which already prevents subsequent GPA-width
changes. No additional pass over the vCPUs is needed.

Keep the existing required-address checks and IMSIC cleanup path.

The issue was found by our static-analysis tool.

Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1: https://lore.kernel.org/r/38f87205419f328693bc6ab25ae78f021c2dd003.1786512671.git.pengpeng@iscas.ac.cn/
- Keep the original APLIC and per-vCPU IMSIC required-address checks.
- Drop the separate pass over all vCPUs during initialization.
- Recheck only APLIC, whose address can be configured before GPA width
  becomes immutable; IMSIC setters already require an existing vCPU.

 arch/riscv/kvm/aia_device.c | 42 +++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index efc7c0b..4490015 100644
--- a/arch/riscv/kvm/aia_device.c
+++ b/arch/riscv/kvm/aia_device.c
@@ -10,7 +10,9 @@
 #include <linux/bits.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kvm_host.h>
+#include <linux/overflow.h>
 #include <linux/uaccess.h>
+#include <asm/kvm_gstage.h>
 #include <asm/kvm_isa.h>
 
 static int aia_create(struct kvm_device *dev, u32 type)
@@ -142,17 +144,37 @@ static int aia_config(struct kvm *kvm, unsigned long type,
 	return 0;
 }
 
+static int aia_check_addr_range(struct kvm *kvm, u64 addr, u64 alignment,
+				u64 size)
+{
+	u64 end;
+
+	if (!IS_ALIGNED(addr, alignment))
+		return -EINVAL;
+
+	if (check_add_overflow(addr, size, &end))
+		return -EINVAL;
+
+	if (end > kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels))
+		return -E2BIG;
+
+	return 0;
+}
+
 static int aia_aplic_addr(struct kvm *kvm, u64 *addr, bool write)
 {
 	struct kvm_aia *aia = &kvm->arch.aia;
+	int ret;
 
 	if (write) {
 		/* Writes can only be done before irqchip is initialized */
 		if (kvm_riscv_aia_initialized(kvm))
 			return -EBUSY;
 
-		if (*addr & (KVM_DEV_RISCV_APLIC_ALIGN - 1))
-			return -EINVAL;
+		ret = aia_check_addr_range(kvm, *addr, KVM_DEV_RISCV_APLIC_ALIGN,
+					   KVM_DEV_RISCV_APLIC_SIZE);
+		if (ret)
+			return ret;
 
 		aia->aplic_addr = *addr;
 	} else
@@ -166,6 +188,7 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr,
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vcpu_aia *vcpu_aia;
+	int ret;
 
 	vcpu = kvm_get_vcpu(kvm, vcpu_idx);
 	if (!vcpu)
@@ -177,8 +200,10 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr,
 		if (kvm_riscv_aia_initialized(kvm))
 			return -EBUSY;
 
-		if (*addr & (KVM_DEV_RISCV_IMSIC_ALIGN - 1))
-			return -EINVAL;
+		ret = aia_check_addr_range(kvm, *addr, KVM_DEV_RISCV_IMSIC_ALIGN,
+					   KVM_DEV_RISCV_IMSIC_SIZE);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&vcpu->mutex);
@@ -248,6 +273,15 @@ static int aia_init(struct kvm *kvm)
 	if (aia->nr_sources && aia->aplic_addr == KVM_RISCV_AIA_UNDEF_ADDR)
 		return -EINVAL;
 
+	/* The GPA width may change after setting APLIC's address on an empty VM. */
+	if (aia->nr_sources) {
+		ret = aia_check_addr_range(kvm, aia->aplic_addr,
+					   KVM_DEV_RISCV_APLIC_ALIGN,
+					   KVM_DEV_RISCV_APLIC_SIZE);
+		if (ret)
+			return ret;
+	}
+
 	/* Group index bits must not overlap guest and HART index bits. */
 	if (aia->nr_group_bits &&
 	    aia->nr_group_shift < (IMSIC_MMIO_PAGE_SHIFT +

