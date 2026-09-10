Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333581E51E0;
	Thu, 10 Sep 2026 02:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007324; cv=none; b=gRC7QNoX0i1xuFuj2azG/Bxdug12BGDfrO3fy0MODBpGqqh3hnYQWa5cKVmYWtovm4B62hWRWnvfwnZQBSCQQ2CYMBfZMANW3jZz6bsd4+fYwD9WuKrzsFQzHgh7zJ/XtCUMwXTe2co5k0R4KEl9zxZPLo/6WPEytTfEtpqpoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007324; c=relaxed/simple;
	bh=UBSpuyJsPE0uoRnsrElhGkVCTU1HAJNQjUftLVPTZk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OWjGx+SVc3wAKXNfXc1bB/lQHaS5Np76MGAiKGtUYLlFXuoD7zO+wSlJ/xNlfV2mRE8CZ55vBm9o7wvWAQej+Q0WU6pa36t+47Bz5klSKtGi4CSKod7RfSnrUT+zBRrNVb9cb6PKtqHq129Rt0VL0PqjwHVSNOYXkTupX0JODCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxLNLXFaJqpGgKAA--.30092S3;
	Thu, 10 Sep 2026 10:28:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKs7WFaJqj0geAA--.31709S2;
	Thu, 10 Sep 2026 10:28:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Tao Cui <cui.tao@linux.dev>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: KVM: Allow to set pv_feature until vCPU run
Date: Thu, 10 Sep 2026 10:21:18 +0800
Message-Id: <20260910022118.2339780-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKs7WFaJqj0geAA--.31709S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Now pv_feature can be set only once, there is problem with VM migration.
Where it is set when vCPU is created and after migration, here it is
allowed to set for many times, until vCPU starts to run.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Rename ran_atleast_once with has_run for simplity.
  2. Rebase on the latest version where there is pv_setting_lock
     protection when modify pv_features of VM.
---
 arch/loongarch/include/asm/kvm_host.h |  3 ++-
 arch/loongarch/kvm/vcpu.c             | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 65d91c3ce313..4ee1a29a5ea0 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -164,7 +164,6 @@ enum emulation_result {
 #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
 #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
 
-#define LOONGARCH_PV_FEAT_UPDATED	BIT_ULL(63)
 #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
 					 BIT(KVM_FEATURE_PREEMPT) |	\
 					 BIT(KVM_FEATURE_STEAL_TIME) |	\
@@ -250,6 +249,8 @@ struct kvm_vcpu_arch {
 	struct dmsintc_state dmsintc_state;
 	/* cpucfg */
 	u32 cpucfg[KVM_MAX_CPUCFG_REGS];
+	/* VCPU ran at least once */
+	bool has_run;
 
 	/* paravirt steal time */
 	struct {
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8e028be3f0a9..dbf87ac5252b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1166,12 +1166,17 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 
 		/* All vCPUs need set the same PV features */
 		spin_lock(&kvm->arch.pv_setting_lock);
-		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
-				&& ((kvm->arch.pv_features & valid) != val)) {
+		if ((kvm->arch.pv_features & valid) == val) {
+			spin_unlock(&kvm->arch.pv_setting_lock);
+			return 0;
+		}
+
+		if (vcpu->arch.has_run) {
 			spin_unlock(&kvm->arch.pv_setting_lock);
 			return -EINVAL;
 		}
-		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
+
+		kvm->arch.pv_features = val;
 		spin_unlock(&kvm->arch.pv_setting_lock);
 		return 0;
 	default:
@@ -1858,6 +1863,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	int r = -EINTR;
 	struct kvm_run *run = vcpu->run;
 
+	/* Mark this VCPU ran at least once */
+	if (!vcpu->arch.has_run)
+		vcpu->arch.has_run = true;
+
 	if (vcpu->mmio_needed) {
 		if (!vcpu->mmio_is_write)
 			kvm_complete_mmio_read(vcpu, run);

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.39.3

