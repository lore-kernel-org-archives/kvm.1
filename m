Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBD53B2FD1;
	Tue,  2 Jun 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386214; cv=none; b=WKfaBsEERIdA81Joe4kasgN16fUAWlJvi+g0Bb7lS/6lbvxW6mp2F4Yia9T2qufr1aW/hlPul+9jqR+aL/pD2KwID4WA1me5RVUutb6xjzX4b4y76vJnubC1dyQdn55q8KqkO6MbnUbZPKrFwyprwok3HTphQBPaKdNezNiT2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386214; c=relaxed/simple;
	bh=oPpanwo20UBbX3AapN1SAoCmU776lNshxPMSSatKfJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG8V9NlJ8pMR1qaYricYdMMENdHMG91HgI9+o0EJp44lLACP89Hv/kTMpg9zzEmE0TBI0u6tF8FYd0ux5BYeaLXesYdKi3FCwmyuO076JiJPJQMLT8Sodvwwy/mA97oykcASPi53cT/cQr1IumUp8C0N5GW3SroAantpmVCJ8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxLuqhiR5q76YPAA--.43318S3;
	Tue, 02 Jun 2026 15:43:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxKMGhiR5qIxCZAA--.13937S2;
	Tue, 02 Jun 2026 15:43:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] LoongArch: KVM: Remove KVM_LARCH_LASX and KVM_LARCH_LSX
Date: Tue,  2 Jun 2026 15:43:16 +0800
Message-Id: <20260602074316.1647373-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260602074316.1647373-1-maobibo@loongson.cn>
References: <20260602074316.1647373-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMGhiR5qIxCZAA--.13937S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In kvm_lose_fpu() FPU state will save in vcpu::arch::fpu, its FPU
state comes from vcpu->arch.aux_inuse. Instead existing API
vm_guest_has_xxx() can be used also, and bit KVM_LARCH_LASX and
KVM_LARCH_LSX in arch.aux_inuse are removed. It makes the logic
simpler than ever.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  2 --
 arch/loongarch/kvm/vcpu.c             | 17 +++++++++--------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index bad16c5f963c..aa2000cfb58a 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -158,8 +158,6 @@ enum emulation_result {
 };
 
 #define KVM_LARCH_FPU		(0x1 << 0)
-#define KVM_LARCH_LSX		(0x1 << 1)
-#define KVM_LARCH_LASX		(0x1 << 2)
 #define KVM_LARCH_LBT		(0x1 << 3)
 #define KVM_LARCH_PMU		(0x1 << 4)
 #define KVM_LARCH_SWCSR_LATEST	(0x1 << 5)
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 53abf7aa61f8..523d4cf88343 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1392,7 +1392,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
 	kvm_restore_lsx(&vcpu->arch.fpu);
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
-	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
+	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
 
 	return 0;
 }
@@ -1408,7 +1408,7 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
 	kvm_restore_lasx(&vcpu->arch.fpu);
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
-	vcpu->arch.aux_inuse |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
+	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
 
 	return 0;
 }
@@ -1417,31 +1417,32 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
 /* Save context and disable FPU */
 void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 {
+	if (!(vcpu->arch.aux_inuse & KVM_LARCH_FPU))
+		return;
+
 	preempt_disable();
 
 	kvm_check_fcsr_alive(vcpu);
-	if (vcpu->arch.aux_inuse & KVM_LARCH_LASX) {
+	if (kvm_guest_has_lasx(&vcpu->arch)) {
 		kvm_save_lasx(&vcpu->arch.fpu);
-		vcpu->arch.aux_inuse &= ~(KVM_LARCH_LSX | KVM_LARCH_FPU | KVM_LARCH_LASX);
 		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LASX);
 
 		/* Disable LASX & LSX & FPU */
 		clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN | CSR_EUEN_LASXEN);
-	} else if (vcpu->arch.aux_inuse & KVM_LARCH_LSX) {
+	} else if (kvm_guest_has_lsx(&vcpu->arch)) {
 		kvm_save_lsx(&vcpu->arch.fpu);
-		vcpu->arch.aux_inuse &= ~(KVM_LARCH_LSX | KVM_LARCH_FPU);
 		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_LSX);
 
 		/* Disable LSX & FPU */
 		clear_csr_euen(CSR_EUEN_FPEN | CSR_EUEN_LSXEN);
-	} else if (vcpu->arch.aux_inuse & KVM_LARCH_FPU) {
+	} else {
 		kvm_save_fpu(&vcpu->arch.fpu);
-		vcpu->arch.aux_inuse &= ~KVM_LARCH_FPU;
 		trace_kvm_aux(vcpu, KVM_TRACE_AUX_SAVE, KVM_TRACE_AUX_FPU);
 
 		/* Disable FPU */
 		clear_csr_euen(CSR_EUEN_FPEN);
 	}
+	vcpu->arch.aux_inuse &= ~KVM_LARCH_FPU;
 	kvm_lose_lbt(vcpu);
 
 	preempt_enable();
-- 
2.39.3

