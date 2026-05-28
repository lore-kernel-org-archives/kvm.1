Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485443F4DEF
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975401; cv=none; b=fQJLKKuGHlb9cfLKV9uRtCF7Sa/a9n/YpaIlO1yXWpNA419h88deJUQMxZMljkUsWMiRiKkP1T0U12RLo/UMV6rM/wCfPCmwkk6d4ospZ8VhorN7Ggd4oAT8kzUFo4T7t7Duy3hAp4dXHE7m8zi2pfjNJrVhxOa9RYT9FViricQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975401; c=relaxed/simple;
	bh=X+xMF2yGVx9C/DR3w5/Drg3+Kccx+yRcyMhUFGsn6oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L83wVeSbtAsNFtkerDCSH53H77izJAZvHhNZYdm7GDmOEMJGFKbotip/oC3G7L/gVe5aSf4pRBmoJRRey4xc9hZcddY5ARFzcQuVEAHs11kHZrVfxwsFMHcpWtKKi5lEL+HuZlD/lQ415dvOjJe2SrMMi+RcNFV3BKy7ZuN9ckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c463d085a9a11f1aa26b74ffac11d73-20260528
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7898a5c5-52e3-4ba5-bfd1-bff2451899b7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:7898a5c5-52e3-4ba5-bfd1-bff2451899b7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:e5e1367ba0f27be65b9dce77309bea87,BulkI
	D:260526191859W4KD99E2,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:41,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c463d085a9a11f1aa26b74ffac11d73-20260528
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 675425396; Thu, 28 May 2026 21:36:30 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/4] LoongArch: KVM: Preserve auto-enabled PV features on userspace override
Date: Thu, 28 May 2026 21:35:55 +0800
Message-ID: <20260528133558.2196416-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528133558.2196416-1-cuitao@kylinos.cn>
References: <20260528133558.2196416-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace (e.g., QEMU) sets PV features via KVM_SET_DEVICE_ATTR
with CPUCFG_KVM_FEATURE, it completely replaces the kernel-default
pv_features. This causes features auto-enabled by the kernel (such as
KVM_FEATURE_STEAL_TIME) to be lost if userspace doesn't explicitly
include them.

Add a pv_auto_features field to struct kvm_arch that saves the
kernel-default PV features set during kvm_vm_init_features(). When
userspace overrides pv_features, OR the saved auto features back
to preserve them.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 2 ++
 arch/loongarch/kvm/vcpu.c             | 2 +-
 arch/loongarch/kvm/vm.c               | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 776bc487a705..903cb67ca817 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -127,6 +127,8 @@ struct kvm_arch {
 	struct kvm_phyid_map  *phyid_map;
 	/* Enabled PV features */
 	unsigned long pv_features;
+	/* PV features auto-enabled by kernel */
+	unsigned long pv_auto_features;
 	/* Supported KVM features */
 	unsigned long kvm_features;
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index e28084c49e68..d82782b90457 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1169,7 +1169,7 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
 				&& ((kvm->arch.pv_features & valid) != val))
 			return -EINVAL;
-		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
+		kvm->arch.pv_features = (val | kvm->arch.pv_auto_features) | LOONGARCH_PV_FEAT_UPDATED;
 		return 0;
 	default:
 		return -ENXIO;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index 1317c718f896..8af874e0b36b 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -57,6 +57,7 @@ static void kvm_vm_init_features(struct kvm *kvm)
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
 		kvm->arch.kvm_features |= BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
 	}
+	kvm->arch.pv_auto_features = kvm->arch.pv_features;
 }
 
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
-- 
2.43.0

