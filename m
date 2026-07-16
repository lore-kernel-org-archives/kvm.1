Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFD10F0;
	Thu, 16 Jul 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166344; cv=none; b=gXpTOnG0kWnHZtEM5GsW/TryN3GoNu8oC507fTHiPELmpPnNaP+4A4AAR7Rj1c1U5pntDj247mDEZQsmz66JNFQE0UUJwrFsotG4TguFanxgS4aXzx+6yCKAgRBVX0HgdLd/WgyVJ5bmltbcRnO2KZJDmEz0buP2biXssUMtmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166344; c=relaxed/simple;
	bh=uq/aXDtxYFUZ7dkSAeZFowZ+YQvMpSe3O8e/pAb9hR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GgcUrw95TlfBL0LlhiNC/QTJdFXNxz3U6xaO8iAXrriucse+y45am2Ld2CKyrbunG3e3Kggb/sLXciB6p0Qd0Q7bsMbIMitYXg49JceUs1tqbJC4MZw/zBRhOYgqmKGK13Bdpcdzu7GKM2/4kkq2qYnwpvNv0QPFhrA6akfUip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxVerDN1hqdQoEAA--.14696S3;
	Thu, 16 Jul 2026 09:45:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxIuTCN1hqq44OAA--.41171S2;
	Thu, 16 Jul 2026 09:45:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Tao Cui <cui.tao@linux.dev>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
Date: Thu, 16 Jul 2026 09:38:23 +0800
Message-Id: <20260716013823.3259816-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuTCN1hqq44OAA--.41171S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Now pv_feature can be set only once, there is problem with VM migration.
Where it is set when vCPU is created and after migration, here it is
allow to set for many times, until vCPU starts to run.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  4 +++-
 arch/loongarch/kvm/vcpu.c             | 15 +++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..af376fc44c44 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -163,7 +163,6 @@ enum emulation_result {
 #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
 #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
 
-#define LOONGARCH_PV_FEAT_UPDATED	BIT_ULL(63)
 #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
 					 BIT(KVM_FEATURE_PREEMPT) |	\
 					 BIT(KVM_FEATURE_STEAL_TIME) |	\
@@ -250,6 +249,9 @@ struct kvm_vcpu_arch {
 	/* cpucfg */
 	u32 cpucfg[KVM_MAX_CPUCFG_REGS];
 
+	/* VCPU ran at least once */
+	bool ran_atleast_once;
+
 	/* paravirt steal time */
 	struct {
 		u64 guest_addr;
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..ce6a1b06d50d 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 		if (val & ~valid)
 			return -EINVAL;
 
-		/* All vCPUs need set the same PV features */
-		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
-				&& ((kvm->arch.pv_features & valid) != val))
+		if ((kvm->arch.pv_features & valid) == val)
+			return 0;
+
+		if (vcpu->arch.ran_atleast_once)
 			return -EINVAL;
-		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
+
+		/* All vCPUs need set the same PV features */
+		kvm->arch.pv_features = val;
 		return 0;
 	default:
 		return -ENXIO;
@@ -1851,6 +1854,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	int r = -EINTR;
 	struct kvm_run *run = vcpu->run;
 
+	/* Mark this VCPU ran at least once */
+	if (!vcpu->arch.ran_atleast_once)
+		vcpu->arch.ran_atleast_once = true;
+
 	if (vcpu->mmio_needed) {
 		if (!vcpu->mmio_is_write)
 			kvm_complete_mmio_read(vcpu, run);

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.39.3

