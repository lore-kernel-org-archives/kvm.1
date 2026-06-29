Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90513244660;
	Mon, 29 Jun 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700348; cv=none; b=I1nV19VoYoUxAG6XEj0L7kCDRQBmGneClsLrvcpPnFu0bJhBqaEHwvryA8+G/9Xs+Fqn9Qq0CbeOAGSQT0GSOH11s25UEGQfUZgNg/+poGfm86pU4ZGKEks9pu5nPkGusrFp9d3JH3LlFHREcI6LG/OI4v+rublxm4zOfOoMbsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700348; c=relaxed/simple;
	bh=hRayyiTE4BTh5AusQgGIcvuEoaxIe52GCV7Ea94tBHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKOaih9ttMREzciqzSdgsm/aKl9bZYuyyB+1ZNzYTvC9jgFcAmC2agZ2O7Jz28Goj4W5OAflFQzfcTOt8IwXz6AMfKgmLW0n42sTkXULGeXsWI/BCwannN9cs+wTicCYWxqpG1S14U3kbR+OorKVJett0BL+8X/j0LOoQRL9v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxx3g42UFqU_8YAA--.39018S3;
	Mon, 29 Jun 2026 10:32:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAu2UFqbBe3AA--.19539S4;
	Mon, 29 Jun 2026 10:32:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] LoongArch: KVM: Replace kvm_err() with WARN_ONCE()
Date: Mon, 29 Jun 2026 10:32:12 +0800
Message-Id: <20260629023213.597030-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260629023213.597030-1-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAu2UFqbBe3AA--.19539S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Since guest kernel and ioctl parameter from user mode is untrusted,
there may be noise kernel log output in host hypervisor with abnormal
state. Here replace kvm_err() with WARN_ONCE() to reduce this kind
of noise kernel log, and there is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/exit.c         | 15 +++++++--------
 arch/loongarch/kvm/intc/dmsintc.c |  8 ++++----
 arch/loongarch/kvm/intc/eiointc.c | 18 ++++++++---------
 arch/loongarch/kvm/intc/ipi.c     | 32 +++++++++++++++----------------
 arch/loongarch/kvm/intc/pch_pic.c | 12 ++++++------
 arch/loongarch/kvm/vcpu.c         |  2 +-
 6 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 8572b63478bb..4ad006e27a4d 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -252,7 +252,7 @@ int kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		*gpr = *(s64 *)run->iocsr_io.data;
 		break;
 	default:
-		kvm_err("Bad IOCSR length: %d, addr is 0x%lx\n",
+		WARN_ONCE(1, "Bad IOCSR length: %d, addr is 0x%lx\n",
 				run->iocsr_io.len, vcpu->arch.badv);
 		er = EMULATE_FAIL;
 		break;
@@ -326,7 +326,7 @@ static int kvm_trap_handle_gspr(struct kvm_vcpu *vcpu)
 
 	/* Rollback PC only if emulation was unsuccessful */
 	if (er == EMULATE_FAIL) {
-		kvm_err("[%#lx]%s: unsupported gspr instruction 0x%08x\n",
+		WARN_ONCE(1, "[%#lx]%s: unsupported gspr instruction 0x%08x\n",
 			curr_pc, __func__, inst.word);
 
 		kvm_arch_vcpu_dump_regs(vcpu);
@@ -491,7 +491,7 @@ int kvm_emu_mmio_read(struct kvm_vcpu *vcpu, larch_inst inst)
 		return EMULATE_DO_MMIO;
 	}
 
-	kvm_err("Read not supported Inst=0x%08x @%lx BadVaddr:%#lx\n",
+	WARN_ONCE(1, "Read not supported Inst=0x%08x @%lx BadVaddr:%#lx\n",
 			inst.word, vcpu->arch.pc, vcpu->arch.badv);
 	kvm_arch_vcpu_dump_regs(vcpu);
 	vcpu->mmio_needed = 0;
@@ -529,7 +529,7 @@ int kvm_complete_mmio_read(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		*gpr = *(s64 *)run->mmio.data;
 		break;
 	default:
-		kvm_err("Bad MMIO length: %d, addr is 0x%lx\n",
+		WARN_ONCE(1, "Bad MMIO length: %d, addr is 0x%lx\n",
 				run->mmio.len, vcpu->arch.badv);
 		er = EMULATE_FAIL;
 		break;
@@ -656,7 +656,7 @@ int kvm_emu_mmio_write(struct kvm_vcpu *vcpu, larch_inst inst)
 	}
 
 	vcpu->arch.pc = curr_pc;
-	kvm_err("Write not supported Inst=0x%08x @%lx BadVaddr:%#lx\n",
+	WARN_ONCE(1, "Write not supported Inst=0x%08x @%lx BadVaddr:%#lx\n",
 			inst.word, vcpu->arch.pc, vcpu->arch.badv);
 	kvm_arch_vcpu_dump_regs(vcpu);
 	/* Rollback PC if emulation was unsuccessful */
@@ -748,8 +748,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu, int ecode)
 	 * treated as a reserved instruction!
 	 * If FPU already in use, we shouldn't get this at all.
 	 */
-	if (WARN_ON(vcpu->arch.aux_inuse & KVM_LARCH_FPU)) {
-		kvm_err("%s internal error\n", __func__);
+	if (WARN_ON_ONCE(vcpu->arch.aux_inuse & KVM_LARCH_FPU)) {
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 		return RESUME_HOST;
 	}
@@ -943,7 +942,7 @@ static int kvm_fault_ni(struct kvm_vcpu *vcpu, int ecode)
 	/* Fetch the instruction */
 	inst = vcpu->arch.badi;
 	badv = vcpu->arch.badv;
-	kvm_err("ECode: %d PC=%#lx Inst=0x%08x BadVaddr=%#lx ESTAT=%#lx\n",
+	WARN_ONCE(1, "ECode: %d PC=%#lx Inst=0x%08x BadVaddr=%#lx ESTAT=%#lx\n",
 			ecode, vcpu->arch.pc, inst, badv, read_gcsr_estat());
 	kvm_arch_vcpu_dump_regs(vcpu);
 	kvm_queue_exception(vcpu, EXCCODE_INE, 0);
diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index de25735ce039..708abbcd55bf 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -114,7 +114,7 @@ static int kvm_dmsintc_ctrl_access(struct kvm_device *dev,
 		}
 		break;
 	default:
-		kvm_err("%s: unknown dmsintc register, addr = %d\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown dmsintc register, addr = %d\n", __func__, addr);
 		return -ENXIO;
 	}
 
@@ -128,7 +128,7 @@ static int kvm_dmsintc_set_attr(struct kvm_device *dev,
 	case KVM_DEV_LOONGARCH_DMSINTC_GRP_CTRL:
 		return kvm_dmsintc_ctrl_access(dev, attr, true);
 	default:
-		kvm_err("%s: unknown group (%d)\n", __func__, attr->group);
+		WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->group);
 		return -EINVAL;
 	}
 }
@@ -139,13 +139,13 @@ static int kvm_dmsintc_create(struct kvm_device *dev, u32 type)
 	struct loongarch_dmsintc *s;
 
 	if (!dev) {
-		kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
+		WARN_ONCE(1, "%s: kvm_device ptr is invalid!\n", __func__);
 		return -EINVAL;
 	}
 
 	kvm = dev->kvm;
 	if (kvm->arch.dmsintc) {
-		kvm_err("%s: LoongArch DMSINTC has already been created!\n", __func__);
+		WARN_ONCE(1, "%s: LoongArch DMSINTC has already been created!\n", __func__);
 		return -EINVAL;
 	}
 
diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index 2b14485d14a7..555e55246f0c 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -47,7 +47,7 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
 	cpu = s->sw_coremap[irq];
 	vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
-		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
 		return;
 	}
 
@@ -165,12 +165,12 @@ static int kvm_eiointc_read(struct kvm_vcpu *vcpu,
 	struct loongarch_eiointc *eiointc = vcpu->kvm->arch.eiointc;
 
 	if (!eiointc) {
-		kvm_err("%s: eiointc irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__);
 		return 0;
 	}
 
 	if (addr & (len - 1)) {
-		kvm_err("%s: eiointc not aligned addr %llx len %d\n", __func__, addr, len);
+		WARN_ONCE(1, "%s: eiointc not aligned addr %llx len %d\n", __func__, addr, len);
 		return 0;
 	}
 
@@ -297,12 +297,12 @@ static int kvm_eiointc_write(struct kvm_vcpu *vcpu,
 	struct loongarch_eiointc *eiointc = vcpu->kvm->arch.eiointc;
 
 	if (!eiointc) {
-		kvm_err("%s: eiointc irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__);
 		return 0;
 	}
 
 	if (addr & (len - 1)) {
-		kvm_err("%s: eiointc not aligned addr %llx len %d\n", __func__, addr, len);
+		WARN_ONCE(1, "%s: eiointc not aligned addr %llx len %d\n", __func__, addr, len);
 		return 0;
 	}
 
@@ -345,7 +345,7 @@ static int kvm_eiointc_virt_read(struct kvm_vcpu *vcpu,
 	struct loongarch_eiointc *eiointc = vcpu->kvm->arch.eiointc;
 
 	if (!eiointc) {
-		kvm_err("%s: eiointc irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__);
 		return 0;
 	}
 
@@ -375,7 +375,7 @@ static int kvm_eiointc_virt_write(struct kvm_vcpu *vcpu,
 	struct loongarch_eiointc *eiointc = vcpu->kvm->arch.eiointc;
 
 	if (!eiointc) {
-		kvm_err("%s: eiointc irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: eiointc irqchip not valid!\n", __func__);
 		return 0;
 	}
 
@@ -502,7 +502,7 @@ static int kvm_eiointc_regs_access(struct kvm_device *dev,
 		p = (void *)s->coremap + offset * 4;
 		break;
 	default:
-		kvm_err("%s: unknown eiointc register, addr = %d\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown eiointc register, addr = %d\n", __func__, addr);
 		return -EINVAL;
 	}
 
@@ -546,7 +546,7 @@ static int kvm_eiointc_sw_status_access(struct kvm_device *dev,
 		p = &s->status;
 		break;
 	default:
-		kvm_err("%s: unknown eiointc register, addr = %d\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown eiointc register, addr = %d\n", __func__, addr);
 		return -EINVAL;
 	}
 	spin_lock_irqsave(&s->lock, flags);
diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index d70bf415c7fc..8d9dacfc1b15 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -30,7 +30,7 @@ static void ipi_send(struct kvm *kvm, uint64_t data)
 	cpu = ((data & 0xffffffff) >> 16) & 0x3ff;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
-		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
 		return;
 	}
 
@@ -105,7 +105,7 @@ static int mail_send(struct kvm *kvm, uint64_t data)
 	cpu = ((data & 0xffffffff) >> 16) & 0x3ff;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
-		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
 		return 0;
 	}
 	mailbox = ((data & 0xffffffff) >> 2) & 0x7;
@@ -139,7 +139,7 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t addr, uint64_t data)
 		ret = kvm_io_bus_read(vcpu, KVM_IOCSR_BUS, addr, 4, &val);
 		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		if (unlikely(ret)) {
-			kvm_err("%s: : read data from addr %llx failed\n", __func__, addr);
+			WARN_ONCE(1, "%s: : read data from addr %llx failed\n", __func__, addr);
 			return 0;
 		}
 		/* Construct the mask by scanning the bit 27-30 */
@@ -155,7 +155,7 @@ static int send_ipi_data(struct kvm_vcpu *vcpu, gpa_t addr, uint64_t data)
 	ret = kvm_io_bus_write(vcpu, KVM_IOCSR_BUS, addr, 4, &val);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 	if (unlikely(ret))
-		kvm_err("%s: : write data to addr %llx failed\n", __func__, addr);
+		WARN_ONCE(1, "%s: : write data to addr %llx failed\n", __func__, addr);
 
 	return 0;
 }
@@ -168,7 +168,7 @@ static int any_send(struct kvm *kvm, uint64_t data)
 	cpu = ((data & 0xffffffff) >> 16) & 0x3ff;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
-		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
 		return 0;
 	}
 	offset = data & 0xffff;
@@ -200,14 +200,14 @@ static int loongarch_ipi_readl(struct kvm_vcpu *vcpu, gpa_t addr, int len, void
 		break;
 	case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
 		if (offset + len > IOCSR_IPI_BUF_38 + 8) {
-			kvm_err("%s: invalid offset or len: offset = %d, len = %d\n",
+			WARN_ONCE(1, "%s: invalid offset or len: offset = %d, len = %d\n",
 				__func__, offset, len);
 			break;
 		}
 		res = read_mailbox(vcpu, offset, len);
 		break;
 	default:
-		kvm_err("%s: unknown addr: %llx\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown addr: %llx\n", __func__, addr);
 		break;
 	}
 	*(uint64_t *)val = res;
@@ -242,7 +242,7 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu, gpa_t addr, int len, cons
 		break;
 	case IOCSR_IPI_BUF_20 ... IOCSR_IPI_BUF_38 + 7:
 		if (offset + len > IOCSR_IPI_BUF_38 + 8) {
-			kvm_err("%s: invalid offset or len: offset = %d, len = %d\n",
+			WARN_ONCE(1, "%s: invalid offset or len: offset = %d, len = %d\n",
 				__func__, offset, len);
 			break;
 		}
@@ -258,7 +258,7 @@ static int loongarch_ipi_writel(struct kvm_vcpu *vcpu, gpa_t addr, int len, cons
 		any_send(vcpu->kvm, data);
 		break;
 	default:
-		kvm_err("%s: unknown addr: %llx\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown addr: %llx\n", __func__, addr);
 		break;
 	}
 
@@ -301,7 +301,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev,
 
 	vcpu = kvm_get_vcpu_by_id(dev->kvm, cpu);
 	if (unlikely(vcpu == NULL)) {
-		kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
+		WARN_ONCE(1, "%s: invalid target cpu: %d\n", __func__, cpu);
 		return -EINVAL;
 	}
 
@@ -335,7 +335,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev,
 		len = 8;
 		break;
 	default:
-		kvm_err("%s: unknown ipi register, addr = %d\n", __func__, addr);
+		WARN_ONCE(1, "%s: unknown ipi register, addr = %d\n", __func__, addr);
 		return -EINVAL;
 	}
 
@@ -369,7 +369,7 @@ static int kvm_ipi_get_attr(struct kvm_device *dev,
 	case KVM_DEV_LOONGARCH_IPI_GRP_REGS:
 		return kvm_ipi_regs_access(dev, attr, false);
 	default:
-		kvm_err("%s: unknown group (%d)\n", __func__, attr->group);
+		WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->group);
 		return -EINVAL;
 	}
 }
@@ -381,7 +381,7 @@ static int kvm_ipi_set_attr(struct kvm_device *dev,
 	case KVM_DEV_LOONGARCH_IPI_GRP_REGS:
 		return kvm_ipi_regs_access(dev, attr, true);
 	default:
-		kvm_err("%s: unknown group (%d)\n", __func__, attr->group);
+		WARN_ONCE(1, "%s: unknown group (%d)\n", __func__, attr->group);
 		return -EINVAL;
 	}
 }
@@ -394,13 +394,13 @@ static int kvm_ipi_create(struct kvm_device *dev, u32 type)
 	struct loongarch_ipi *s;
 
 	if (!dev) {
-		kvm_err("%s: kvm_device ptr is invalid!\n", __func__);
+		WARN_ONCE(1, "%s: kvm_device ptr is invalid!\n", __func__);
 		return -EINVAL;
 	}
 
 	kvm = dev->kvm;
 	if (kvm->arch.ipi) {
-		kvm_err("%s: LoongArch IPI has already been created!\n", __func__);
+		WARN_ONCE(1, "%s: LoongArch IPI has already been created!\n", __func__);
 		return -EINVAL;
 	}
 
@@ -420,7 +420,7 @@ static int kvm_ipi_create(struct kvm_device *dev, u32 type)
 	ret = kvm_io_bus_register_dev(kvm, KVM_IOCSR_BUS, IOCSR_IPI_BASE, IOCSR_IPI_SIZE, device);
 	mutex_unlock(&kvm->slots_lock);
 	if (ret < 0) {
-		kvm_err("%s: Initialize IOCSR dev failed, ret = %d\n", __func__, ret);
+		WARN_ONCE(1, "%s: Initialize IOCSR dev failed, ret = %d\n", __func__, ret);
 		goto err;
 	}
 
diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 175a630aceb4..299b4db26833 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -151,12 +151,12 @@ static int kvm_pch_pic_read(struct kvm_vcpu *vcpu,
 	struct loongarch_pch_pic *s = vcpu->kvm->arch.pch_pic;
 
 	if (!s) {
-		kvm_err("%s: pch pic irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: pch pic irqchip not valid!\n", __func__);
 		return ret;
 	}
 
 	if (addr & (len - 1)) {
-		kvm_err("%s: pch pic not aligned addr %llx len %d\n", __func__, addr, len);
+		WARN_ONCE(1, "%s: pch pic not aligned addr %llx len %d\n", __func__, addr, len);
 		return ret;
 	}
 
@@ -250,12 +250,12 @@ static int kvm_pch_pic_write(struct kvm_vcpu *vcpu,
 	struct loongarch_pch_pic *s = vcpu->kvm->arch.pch_pic;
 
 	if (!s) {
-		kvm_err("%s: pch pic irqchip not valid!\n", __func__);
+		WARN_ONCE(1, "%s: pch pic irqchip not valid!\n", __func__);
 		return ret;
 	}
 
 	if (addr & (len - 1)) {
-		kvm_err("%s: pch pic not aligned addr %llx len %d\n", __func__, addr, len);
+		WARN_ONCE(1, "%s: pch pic not aligned addr %llx len %d\n", __func__, addr, len);
 		return ret;
 	}
 
@@ -390,13 +390,13 @@ static int kvm_pch_pic_set_attr(struct kvm_device *dev,
 				return -EFAULT;
 
 			if (!dev->kvm->arch.pch_pic) {
-				kvm_err("%s: please create pch_pic irqchip first!\n", __func__);
+				WARN_ONCE(1, "%s: please create pch_pic irqchip first\n", __func__);
 				return -ENODEV;
 			}
 
 			return kvm_pch_pic_init(dev, addr);
 		default:
-			kvm_err("%s: unknown group (%d) attr (%lld)\n", __func__, attr->group,
+			WARN_ONCE(1, "%s: unknown group (%d) attr (%lld)\n", __func__, attr->group,
 					attr->attr);
 			return -EINVAL;
 		}
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..361fca46e2b3 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1473,7 +1473,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 	else if (intr < 0)
 		kvm_dequeue_irq(vcpu, -intr);
 	else {
-		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
+		WARN_ONCE(1, "%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
 		return -EINVAL;
 	}
 
-- 
2.39.3

