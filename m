Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2B2F6188;
	Mon, 11 May 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482321; cv=none; b=kmLf76rGYm2UgKeun8YASpqa2Vx01w4voR4aBNaFdtoaBnwhdRziJr+IPf7drRNhhAA/5zgAs9x8ihzZ2g3yQ6ataHiTcqIhVhFl7meD/Qn+4aut/sTN6lIMwuPodwb6f5DFZO8tBHhh5c00TiaERpdbMb/XCtauGW67/2X0+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482321; c=relaxed/simple;
	bh=4J8l7fsKFXFSBuTKZXv5aOaG/rKtRLTDXjblKlUbBFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbS6MOUG8Yp72VTRiF1eCu5Yyu8p7vDOfO8ETO+AGnzG3PtRRfqsJdH4LMqNxeUt/7YI2k/SLjMoWwUkIJJ5uGv4XKdOgfElpYDPw8QtVp7CxIUZOzRO0LVmf5y5l1awk2fE8dI/pCP/MZib1sBcMcizPmVoOuCWT3AbfzVgS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxrcCNfAFq5owIAA--.2961S3;
	Mon, 11 May 2026 14:51:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx28GEfAFqAOh+AA--.42931S3;
	Mon, 11 May 2026 14:51:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] LoongArch: KVM: Check msgint feature in interrupt post
Date: Mon, 11 May 2026 14:51:42 +0800
Message-Id: <20260511065146.680650-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511065146.680650-1-maobibo@loongson.cn>
References: <20260511065146.680650-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28GEfAFqAOh+AA--.42931S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Interrupt AVEC is valid only if VM has msgint feature, and this feature
is checked in interrupt handling. Since interrupt handling is executing
in VM context switch, and it is hot path, here move the feature checking
in interrupt post rather than interrupt handling.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_vcpu.h | 6 ++++++
 arch/loongarch/kvm/interrupt.c        | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index 3784ab4ccdb5..ccf938d89f02 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -95,12 +95,18 @@ struct kvm_vcpu *kvm_get_vcpu_by_cpuid(struct kvm *kvm, int cpuid);
  */
 static inline void kvm_queue_irq(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	if (!kvm_guest_has_msgint(&vcpu->arch) && (irq == INT_AVEC))
+		return;
+
 	set_bit(irq, &vcpu->arch.irq_pending);
 	clear_bit(irq, &vcpu->arch.irq_clear);
 }
 
 static inline void kvm_dequeue_irq(struct kvm_vcpu *vcpu, unsigned int irq)
 {
+	if (!kvm_guest_has_msgint(&vcpu->arch) && (irq == INT_AVEC))
+		return;
+
 	clear_bit(irq, &vcpu->arch.irq_pending);
 	set_bit(irq, &vcpu->arch.irq_clear);
 }
diff --git a/arch/loongarch/kvm/interrupt.c b/arch/loongarch/kvm/interrupt.c
index a18c60dffbba..48dd56aa4dc5 100644
--- a/arch/loongarch/kvm/interrupt.c
+++ b/arch/loongarch/kvm/interrupt.c
@@ -36,8 +36,6 @@ static int kvm_irq_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 
 	switch (priority) {
 	case INT_AVEC:
-		if (!kvm_guest_has_msgint(&vcpu->arch))
-			break;
 		dmsintc_inject_irq(vcpu);
 		fallthrough;
 	case INT_TI:
@@ -75,9 +73,6 @@ static int kvm_irq_clear(struct kvm_vcpu *vcpu, unsigned int priority)
 
 	switch (priority) {
 	case INT_AVEC:
-		if (!kvm_guest_has_msgint(&vcpu->arch))
-			break;
-		fallthrough;
 	case INT_TI:
 	case INT_IPI:
 	case INT_SWI0:
-- 
2.39.3

