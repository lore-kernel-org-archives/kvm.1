Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693847C0E2;
	Wed,  9 Sep 2026 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943231; cv=none; b=izfJvxB1ds6bv9fFXdm78Y0uDBvEs5ztYNHhC/VanrwNkQqPDxGTThZCQcLkdAW4oYTbRRcG2DmGdkpX+suORjhWMQAWey+klmmUcR3/OJu+WscJnao+iZQGHDgod0+rwzJBkZhz9z0UXIsEkOoFz7DbDpqoMiKkuk2x5lvP4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943231; c=relaxed/simple;
	bh=TjHLwrF0iHppkbsu1PFtrAz92MyXMNC13N1B2FSiTdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYd9/i6NiN0gCq6whlP7PkgV1BKeKP41gFpL8k0BGMuyCSjZc3P0aI8vnonqHJjS0p3oG7RjM8HIwyPlMjAQiBBLU6kWUzi3rtBtIHKo8cnsG04vxG8ExNIpjkBlSEC5cyXSGMOr7ZSqYbOWgEEyfRqa8gNkBTHXs7E+3MlpGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxTNJ1G6FqTxwKAA--.28995S3;
	Wed, 09 Sep 2026 16:40:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHs90G6FqXdIdAA--.30773S4;
	Wed, 09 Sep 2026 16:40:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] LoongArch: KVM: Remove duplicated checking with DMSI irq injection
Date: Wed,  9 Sep 2026 16:32:59 +0800
Message-Id: <20260909083259.1910290-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260909083259.1910290-1-maobibo@loongson.cn>
References: <20260909083259.1910290-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHs90G6FqXdIdAA--.30773S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are some duplicated error checking in DMSI interrupt injection
function, also vcpu::arch::dmsintc_state is structure rather than pointer,
NULL pointer checking with dmsintc_state is not necessary, here remove
these unnecessary checking.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/dmsintc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index 79e56e330aeb..cd2cd7a5c01e 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -14,9 +14,6 @@ void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 	unsigned long vector[4], old;
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
-	if (!ds)
-		return;
-
 	for (i = 0; i < 4; i++) {
 		old = atomic64_read(&(ds->vector_map[i]));
 		vector[i] = old ? atomic64_xchg(&(ds->vector_map[i]), 0) : 0;
@@ -47,11 +44,6 @@ static int dmsintc_deliver_msi_to_vcpu(struct kvm_vcpu *vcpu, u32 vector)
 {
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
-	if (!vcpu || vector >= 256)
-		return -EINVAL;
-	if (!ds)
-		return -ENODEV;
-
 	if (!kvm_guest_has_msgint(&vcpu->arch))
 		return -EINVAL;
 
@@ -69,8 +61,6 @@ int dmsintc_set_irq(struct kvm *kvm, u64 addr, int data)
 
 	irq = (addr >> AVEC_IRQ_SHIFT) & AVEC_IRQ_MASK;
 	cpu = (addr >> AVEC_CPU_SHIFT) & kvm->arch.dmsintc->cpu_mask;
-	if (cpu >= KVM_MAX_VCPUS)
-		return -EINVAL;
 	vcpu = kvm_get_vcpu_by_cpuid(kvm, cpu);
 	if (!vcpu)
 		return -EINVAL;
-- 
2.39.3

