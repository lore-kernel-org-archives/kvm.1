Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9A304BB2;
	Mon,  8 Jun 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882356; cv=none; b=Gh4b6KLpjnZshHnbKYMqSWnGQA/nfcBT7ftj8678601RoZKGsMrA6JCJjs6fFNRGMvyU3jq+KYB8PVOSJ4jmZc0XHOIrZFy7mNFELIL2ywOr3KQC8/pkYdOhFm6L7FlmoPXWRDlzJq+3agRRc5ZbNF1PTR5S9fjXr9S7d+n3L34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882356; c=relaxed/simple;
	bh=jzVWtUayeOPCeFSiXCUSWlxb3xZ9FyPrfGI2r0tqKgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njK4QywWuZrHkW65PSkQUl5gVWg+/Gk0jWCRKqWOUUAV3GU4c+ohAl4SshV3c/2Eg1rFmYYayh0JWldofDPc/ohdibiOKTA9jW3WOHkShekzlkOqM3uj5kKgiv02h0ON6DdDzVoHUr7MtR/sxXmWaaXMdtxlTDjhTgydFhka040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx8eqqGyZqK5kRAA--.47440S3;
	Mon, 08 Jun 2026 09:32:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMKoGyZqNTafAA--.39164S3;
	Mon, 08 Jun 2026 09:32:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
Date: Mon,  8 Jun 2026 09:32:19 +0800
Message-Id: <20260608013222.375257-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260608013222.375257-1-maobibo@loongson.cn>
References: <20260608013222.375257-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMKoGyZqNTafAA--.39164S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are different structures with LBT and FPU register restore,
with LBT the structure is vcpu::arch::lbt, with FPU the structure
is vcpu::arch::fpu. And FPU/LSX/LASX saving and restoring share
the common structure vcpu::arch::fpu.

New request bit KVM_REQ_LBT_LOAD is used for LBT register restore,
and rename KVM_REQ_AUX_LOAD with KVM_REQ_FPU_LOAD for FPU register
restore.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h |  3 ++-
 arch/loongarch/kvm/exit.c             | 12 +++++-------
 arch/loongarch/kvm/vcpu.c             |  8 ++++----
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 776bc487a705..e76a49d4233b 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -38,7 +38,8 @@
 #define KVM_REQ_TLB_FLUSH_GPA		KVM_ARCH_REQ(0)
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(1)
 #define KVM_REQ_PMU			KVM_ARCH_REQ(2)
-#define KVM_REQ_AUX_LOAD		KVM_ARCH_REQ(3)
+#define KVM_REQ_FPU_LOAD		KVM_ARCH_REQ(3)
+#define KVM_REQ_LBT_LOAD		KVM_ARCH_REQ(4)
 
 #define KVM_GUESTDBG_SW_BP_MASK		\
 	(KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index 3b95cd0f989b..b839c989d3dc 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -756,7 +756,7 @@ static int kvm_handle_fpu_disabled(struct kvm_vcpu *vcpu, int ecode)
 	}
 
 	vcpu->arch.aux_ldtype = KVM_LARCH_FPU;
-	kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+	kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 
 	return RESUME_GUEST;
 }
@@ -798,7 +798,7 @@ static int kvm_handle_lsx_disabled(struct kvm_vcpu *vcpu, int ecode)
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else {
 		vcpu->arch.aux_ldtype = KVM_LARCH_LSX;
-		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+		kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 	}
 
 	return RESUME_GUEST;
@@ -818,7 +818,7 @@ static int kvm_handle_lasx_disabled(struct kvm_vcpu *vcpu, int ecode)
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
 	else {
 		vcpu->arch.aux_ldtype = KVM_LARCH_LASX;
-		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
+		kvm_make_request(KVM_REQ_FPU_LOAD, vcpu);
 	}
 
 	return RESUME_GUEST;
@@ -828,10 +828,8 @@ static int kvm_handle_lbt_disabled(struct kvm_vcpu *vcpu, int ecode)
 {
 	if (!kvm_guest_has_lbt(&vcpu->arch))
 		kvm_queue_exception(vcpu, EXCCODE_INE, 0);
-	else {
-		vcpu->arch.aux_ldtype = KVM_LARCH_LBT;
-		kvm_make_request(KVM_REQ_AUX_LOAD, vcpu);
-	}
+	else
+		kvm_make_request(KVM_REQ_LBT_LOAD, vcpu);
 
 	return RESUME_GUEST;
 }
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..c28aa37f37a9 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -239,7 +239,7 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
 			vcpu->arch.flush_gpa = INVALID_GPA;
 		}
 
-	if (kvm_check_request(KVM_REQ_AUX_LOAD, vcpu)) {
+	if (kvm_check_request(KVM_REQ_FPU_LOAD, vcpu)) {
 		switch (vcpu->arch.aux_ldtype) {
 		case KVM_LARCH_FPU:
 			kvm_own_fpu(vcpu);
@@ -250,15 +250,15 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
 		case KVM_LARCH_LASX:
 			kvm_own_lasx(vcpu);
 			break;
-		case KVM_LARCH_LBT:
-			kvm_own_lbt(vcpu);
-			break;
 		default:
 			break;
 		}
 
 		vcpu->arch.aux_ldtype = 0;
 	}
+
+	if (kvm_check_request(KVM_REQ_LBT_LOAD, vcpu))
+		kvm_own_lbt(vcpu);
 }
 
 /*
-- 
2.39.3

