Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E170937DEBA;
	Wed, 12 Aug 2026 05:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513196; cv=none; b=BrQKgF0AVz5e2pUMN/3ZEwOIQugxrMWVjrzDarJ4Cx76fVBYGKXXLZa6o5LgNsPI6XX4xHWSi1wG6la4xDzNhtTwZ8f3ek6nIO5rOcihtf7tQhWUUWvSEKuHS7J5f1X5/Lt9BNhMdx8FvbzBAlZiL4w91//UF4j0Oszkb4bYW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513196; c=relaxed/simple;
	bh=nkGX5BJ/2eIbUb924iQqtUVrC3DCMdOrC+PKV7KbnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS2eiAK2FnrlvSiMQHFS4mS5UIqQCJIl7lf0hq96g7uZie+s776AyD82K+5k7FDgDxSzSddgnT9+je0ZwPIV7wppd5IDAas1cvvaaFlRNkkGrpOZhHPcZ9euv4mDhwM8q5JiVaxOlNlSxKCtzmtA9hr58z2fqfmy0/uPTNgPp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowADnVD8UB3xqybQxBQ--.41533S3;
	Wed, 12 Aug 2026 13:39:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Guo Ren <guoren@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] RISC-V: KVM: Validate AIA MMIO address ranges
Date: Wed, 12 Aug 2026 13:39:31 +0800
Message-ID: <38f87205419f328693bc6ab25ae78f021c2dd003.1786512671.git.pengpeng@iscas.ac.cn>
In-Reply-To: <cover.1786512671.git.pengpeng@iscas.ac.cn>
References: <cover.1786512671.git.pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD8UB3xqybQxBQ--.41533S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rXr1rAw13Aw4Duw45KFg_yoW7JF13pr
	47G393WrWFq3yxWwsYyr1qkwn09w10ka1fGryUua1Fkr1IqryfKF1vga4UXF98JrykuF4a
	yF4rta15uF4Fyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7Mx
	kF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
	43ZEXa7VUjrHUDUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Userspace supplies the APLIC and per-vCPU IMSIC base addresses through
the AIA device API.  The address setters currently reject only
misaligned addresses.

The regions are later registered on KVM's MMIO bus with fixed sizes.  An
aligned base near U64_MAX can therefore wrap when the range end is
formed.  A lower base can still place the range beyond the selected
guest stage-2 physical address space.  kvm_io_bus_cmp() assumes that
registered ranges do not wrap.

Validate the complete interval when an address is stored.  Since
KVM_CAP_VM_GPA_BITS can change the selected GPA width before AIA
initialization, validate every address again before registering the
first MMIO device.

Return -EINVAL for misalignment or arithmetic overflow and -E2BIG when
the end exceeds the stage-2 GPA limit, following the arm64 VGIC
address-validation convention.

Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/riscv/kvm/aia_device.c | 79 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
index efc7c0bcfba9..e969dbdc4b97 100644
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
@@ -191,6 +216,40 @@ static int aia_imsic_addr(struct kvm *kvm, u64 *addr,
 	return 0;
 }
 
+static int aia_validate_addr_ranges(struct kvm *kvm)
+{
+	struct kvm_aia *aia = &kvm->arch.aia;
+	struct kvm_vcpu_aia *vaia;
+	struct kvm_vcpu *vcpu;
+	unsigned long idx;
+	int ret;
+
+	if (aia->nr_sources) {
+		if (aia->aplic_addr == KVM_RISCV_AIA_UNDEF_ADDR)
+			return -EINVAL;
+
+		ret = aia_check_addr_range(kvm, aia->aplic_addr,
+					   KVM_DEV_RISCV_APLIC_ALIGN,
+					   KVM_DEV_RISCV_APLIC_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	kvm_for_each_vcpu(idx, vcpu, kvm) {
+		vaia = &vcpu->arch.aia_context;
+		if (vaia->imsic_addr == KVM_RISCV_AIA_UNDEF_ADDR)
+			return -EINVAL;
+
+		ret = aia_check_addr_range(kvm, vaia->imsic_addr,
+					   KVM_DEV_RISCV_IMSIC_ALIGN,
+					   KVM_DEV_RISCV_IMSIC_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static gpa_t aia_imsic_ppn(struct kvm_aia *aia, gpa_t addr)
 {
 	u32 h, l;
@@ -244,9 +303,9 @@ static int aia_init(struct kvm *kvm)
 	if (aia->nr_ids < aia->nr_sources)
 		return -EINVAL;
 
-	/* APLIC base is required for non-zero number of sources */
-	if (aia->nr_sources && aia->aplic_addr == KVM_RISCV_AIA_UNDEF_ADDR)
-		return -EINVAL;
+	ret = aia_validate_addr_ranges(kvm);
+	if (ret)
+		return ret;
 
 	/* Group index bits must not overlap guest and HART index bits. */
 	if (aia->nr_group_bits &&
@@ -263,12 +322,6 @@ static int aia_init(struct kvm *kvm)
 	kvm_for_each_vcpu(idx, vcpu, kvm) {
 		vaia = &vcpu->arch.aia_context;
 
-		/* IMSIC base is required */
-		if (vaia->imsic_addr == KVM_RISCV_AIA_UNDEF_ADDR) {
-			ret = -EINVAL;
-			goto fail_cleanup_imsics;
-		}
-
 		/* All IMSICs should have matching base PPN */
 		if (base_ppn == KVM_RISCV_AIA_UNDEF_ADDR)
 			base_ppn = aia_imsic_ppn(aia, vaia->imsic_addr);
-- 
2.50.1 (Apple Git-155)

