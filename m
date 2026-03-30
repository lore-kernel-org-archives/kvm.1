Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9E3947B0;
	Mon, 30 Mar 2026 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843128; cv=none; b=MSPwS6h7zeoC6Ok87Qg4lUV/og7okRLxSaKbYKrDpP5gr+YqKdxgsdqxtWiziScE0RFEa9W4ZuxISp7nIS/NKffUCFvaa7YZSEP+QPhKEulkUQQhjkPg0LCuT/QZHceQ6V0nBFVmy6HQ7sUF8My367+92ZuwYLgeapZSLp7HKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843128; c=relaxed/simple;
	bh=xgrmeC4fDlkAveAib4Om1FM0vN8PwDzX5mQ0wvB1BNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBoFWH41OoSSPd93YEFKUki6SC0eJm74s2nqHntlvPOyxVpzyV2zXMi9+kTyydLbsKIwFeKVFQs1FI/qtHmuHuFSrn+ICmg0KI5DwTLYAYviGhX7UQB3gdCnH+1AJ3Jh8Q+J9e5lxDa+6EZ//aqJasTlLrdT4/cTT3hosfg4Sog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxDMPs9MlpSNIfAA--.25212S3;
	Mon, 30 Mar 2026 11:58:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCx_8Lq9MlpwXFgAA--.53173S5;
	Mon, 30 Mar 2026 11:58:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] LoongArch: KVM: Rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD
Date: Mon, 30 Mar 2026 11:58:29 +0800
Message-Id: <20260330035832.2204720-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260330035832.2204720-1-maobibo@loongson.cn>
References: <20260330035832.2204720-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx_8Lq9MlpwXFgAA--.53173S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Request bit KVM_REQ_AUX_LOAD is used for FPU/LSX/LASX register
restore, here rename it with KVM_REQ_FPU_LOAD.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 2 +-
 arch/loongarch/kvm/exit.c             | 6 +++---
 arch/loongarch/kvm/vcpu.c             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 7cd883a8281f..9e0568c3c7f9 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -37,7 +37,7 @@
 #define KVM_REQ_TLB_FLUSH_GPA		KVM_ARCH_REQ(0)
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(1)
 #define KVM_REQ_PMU			KVM_ARCH_REQ(2)
-#define KVM_REQ_AUX_LOAD		KVM_ARCH_REQ(3)
+#define KVM_REQ_FPU_LOAD		KVM_ARCH_REQ(3)
 #define KVM_REQ_LBT_LOAD		KVM_ARCH_REQ(4)
 
 #define KVM_GUESTDBG_SW_BP_MASK		\
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index ddc3f4cc510b..07426682929a 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -754,7 +754,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu, int ecode)
 		return RESUME_HOST;
 	}
 
-	kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+	kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 
 	return RESUME_GUEST;
 }
@@ -795,7 +795,7 @@ static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu, int ecode)
 	if (!kvm_guest_has_lsx(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else
-		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+		kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 
 	return RESUME_GUEST;
 }
@@ -813,7 +813,7 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu, int ecode)
 	if (!kvm_guest_has_lasx(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else
-		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+		kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 
 	return RESUME_GUEST;
 }
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 144e26e1ed68..553881e326eb 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -238,7 +238,7 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
 			vcpu->arch.flush_gpa = INVALID_GPA;
 		}
 
-	if (kvm_check_request(KVM_REQ_AUX_LOAD, vcpu)) {
+	if (kvm_check_request(KVM_REQ_FPU_LOAD, vcpu)) {
 		if (kvm_guest_has_lasx(&vcpu->arch))
 			kvm_own_lasx(vcpu);
 		else if (kvm_guest_has_lsx(&vcpu->arch))
-- 
2.39.3

