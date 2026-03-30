Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C88437E2F3;
	Mon, 30 Mar 2026 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843127; cv=none; b=Pe8WMGvfTrfsyJYwEyjdZ75B2ylbmppbU3ohzqIoA32gG9DQCza0Fj7l63uypodGjOPrrHlBERCJz/F/TeFZMUjG21vvwT3rAzYmFUTDBg9owXjT+++emCTbZsvtXs4XGUjuGTdirGk47lbwGGXk6NxEV3l10SYXc46xiRsMHfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843127; c=relaxed/simple;
	bh=W7OAHQraw1gdBGtic7MB0Md5fgkWMELvqZ5WQ/SVRf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8e1UDLEQpSLrGXbIs0ILfzNYwqLc1X+Bqbr+MIFBhqMyE0QeQ/5p3+diQ24Pl/vJy+jUGW7I9H/5cq2+M3MSue/cx+sm9fFmUDsLHMDu7I6D71L81nfG9vc2qlJqtc1uC1fu7AHiZGivBh06l1GK1Fqwh6wlwOwd1ksJsc81ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx48Dr9MlpP9IfAA--.31070S3;
	Mon, 30 Mar 2026 11:58:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCx_8Lq9MlpwXFgAA--.53173S3;
	Mon, 30 Mar 2026 11:58:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] LoongArch: KVM: Add separate KVM_REQ_LBT_LOAD request bit
Date: Mon, 30 Mar 2026 11:58:27 +0800
Message-Id: <20260330035832.2204720-2-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCx_8Lq9MlpwXFgAA--.53173S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There are different structures with LBT and FPU register restore,
with LBT the structure is vcpu::arch::lbt, with FPU the structure
is vcpu::arch::fpu. And FPU/LSX/LASX saving and restoring share
the common structure vcpu::arch::fpu.

New request bit KVM_REQ_LBT_LOAD is used for LBT register restore.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 1 +
 arch/loongarch/kvm/exit.c             | 6 ++----
 arch/loongarch/kvm/vcpu.c             | 6 +++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 19eb5e5c3984..035e698309d0 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -38,6 +38,7 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(1)
 #define KVM_REQ_PMU			KVM_ARCH_REQ(2)
 #define KVM_REQ_AUX_LOAD		KVM_ARCH_REQ(3)
+#define KVM_REQ_LBT_LOAD		KVM_ARCH_REQ(4)
 
 #define KVM_GUESTDBG_SW_BP_MASK		\
 	(KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index da0ad89f2eb7..3e06a66a90f8 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -827,10 +827,8 @@ static int kvm_handle_lbt_disabled(struct kvm_vcpu *vcpu, int ecode)
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
index 831f381a8fd1..2f2c1cbe127c 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -249,15 +249,15 @@ static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
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

