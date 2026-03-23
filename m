Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE87404E;
	Mon, 23 Mar 2026 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774237241; cv=none; b=SR93jc5dvXokMqEUCcDdS+4A+4XKalDLKSOFaSx+0fKvdNyrRlQoYSrkj6mk7rV/F62iFqJ0pJT260D3REAaDRVnFB7CVMJUnAyaCmoERrPDm/hbow1GEVwHYIcx+77+ConNObjGvfiGWDnK3MApgv8vI0Z232yzf4Jcctij3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774237241; c=relaxed/simple;
	bh=2GilZkAoeozT1RpSJYGejiwFN6C6fjf+USga5J6Xx/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pfUUhPz/a/xf56x4xl/iohTcDSk9HODYIdNE8tdF+DgEIAnjrBOwPHKWJQN4svAHmjqjAsjLnhCTZtSH4zZsZpdBvAbZPqQiAeRpf9Z/tPTZ/kbeXS0earm2x7u8G98z0hZmcx6ZtHYJNOlk2KyeuqHestlgG/KNlqBmYO7xq/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxvsMztsBpKqkdAA--.19681S3;
	Mon, 23 Mar 2026 11:40:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxaeAytsBpOBRbAA--.43922S2;
	Mon, 23 Mar 2026 11:40:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Set max used FPU type with FPU exception
Date: Mon, 23 Mar 2026 11:40:34 +0800
Message-Id: <20260323034034.3465072-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeAytsBpOBRbAA--.43922S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With FPU save and restore flow, the cost is the same with different
FPU width 8/16/32 bytes, whatever from CPU cycle and cache line impaction.

Here is to enable FPU with max used type, for example if application
ever uses LASX instrction, enable FPU with LASX type even with FPU
exeception. So it can avoid possible LSX/LASX exception in future.

With context switch microbench which may touch FPU and LASX, there is 9%
improvement when halt_poll_ns is disabled. The command is
"./context --test=pipe" and source code located at:
  https://github.com/bibo-mao/context_switch/blob/main/context.c

Original     Wih patch      improvement
75232        82440          9%

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  1 +
 arch/loongarch/kvm/exit.c             |  6 +++---
 arch/loongarch/kvm/vcpu.c             | 25 ++++++++++---------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 19eb5e5c3984..7d739fd5cda6 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -203,6 +203,7 @@ struct kvm_vcpu_arch {
 	/* Which auxiliary state is loaded (KVM_LARCH_*) */
 	unsigned int aux_inuse;
 	unsigned int aux_ldtype;
+	unsigned int aux_used;
 
 	/* FPU state */
 	struct loongarch_fpu fpu FPU_ALIGN;
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index da0ad89f2eb7..da8e330c8b20 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -754,7 +754,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu, int ecode)
 		return RESUME_HOST;
 	}
 
-	vcpu->arch.aux_ldtype = KVM_LARCH_FPU;
+	vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_FPU;
 	kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
 
 	return RESUME_GUEST;
@@ -796,7 +796,7 @@ static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu, int ecode)
 	if (!kvm_guest_has_lsx(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else {
-		vcpu->arch.aux_ldtype = KVM_LARCH_LSX;
+		vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_LSX;
 		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
 	}
 
@@ -816,7 +816,7 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu, int ecode)
 	if (!kvm_guest_has_lasx(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else {
-		vcpu->arch.aux_ldtype = KVM_LARCH_LASX;
+		vcpu->arch.aux_ldtype = vcpu->arch.aux_used | KVM_LARCH_LASX;
 		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
 	}
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8810fcd7e26e..0a111c74a330 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -239,23 +239,14 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
 		}
 
 	if (kvm_check_request(KVM_REQ_AUX_LOAD, vcpu)) {
-		switch (vcpu->arch.aux_ldtype) {
-		case KVM_LARCH_FPU:
-			kvm_own_fpu(vcpu);
-			break;
-		case KVM_LARCH_LSX:
-			kvm_own_lsx(vcpu);
-			break;
-		case KVM_LARCH_LASX:
+		if (vcpu->arch.aux_ldtype & KVM_LARCH_LASX)
 			kvm_own_lasx(vcpu);
-			break;
-		case KVM_LARCH_LBT:
+		else if (vcpu->arch.aux_ldtype & KVM_LARCH_LSX)
+			kvm_own_lsx(vcpu);
+		else if (vcpu->arch.aux_ldtype & KVM_LARCH_FPU)
+			kvm_own_fpu(vcpu);
+		else if (vcpu->arch.aux_ldtype == KVM_LARCH_LBT)
 			kvm_own_lbt(vcpu);
-			break;
-		default:
-			break;
-		}
-
 		vcpu->arch.aux_ldtype = 0;
 	}
 }
@@ -956,6 +947,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 			break;
 		case KVM_REG_LOONGARCH_VCPU_RESET:
 			vcpu->arch.st.guest_addr = 0;
+			vcpu->arch.aux_used = 0;
 			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
 			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
 
@@ -1384,6 +1376,7 @@ void kvm_own_fpu(struct kvm_vcpu *vcpu)
 
 	kvm_restore_fpu(&vcpu->arch.fpu);
 	vcpu->arch.aux_inuse |= KVM_LARCH_FPU;
+	vcpu->arch.aux_used |= KVM_LARCH_FPU;
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_FPU);
 }
 
@@ -1412,6 +1405,7 @@ int kvm_own_lsx(struct kvm_vcpu *vcpu)
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LSX);
 	vcpu->arch.aux_inuse |= KVM_LARCH_LSX | KVM_LARCH_FPU;
+	vcpu->arch.aux_used |= KVM_LARCH_LSX | KVM_LARCH_FPU;
 
 	return 0;
 }
@@ -1442,6 +1436,7 @@ int kvm_own_lasx(struct kvm_vcpu *vcpu)
 
 	trace_kvm_aux(vcpu, KVM_TRACE_AUX_RESTORE, KVM_TRACE_AUX_LASX);
 	vcpu->arch.aux_inuse |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
+	vcpu->arch.aux_used |= KVM_LARCH_LASX | KVM_LARCH_LSX | KVM_LARCH_FPU;
 
 	return 0;
 }

base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.39.3

