Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E22C28C2A1;
	Mon, 23 Mar 2026 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774234581; cv=none; b=MKgTDCoMk7W/AxRHlNLDNOSAp+yy9GIdmZGa4Yl6rmYTecsfFbbpm5sFPOlHVAj8PfmGD0a27krH5gi/SHXDPew2dD5HdUCFVXPtxO8ktdXE2qjaozvhw1YgGkvNNVaevWqx1hcsQl+gmacyqEgWeJ3JjuDJBswh++KWIacS0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774234581; c=relaxed/simple;
	bh=omcBfFSmTGtKmubn8NNmh/ELlSQUrctCVpJbJ/JNpas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TCyqz8ObAJmU4DeKKjlac06yXJH7pUI5rO94CjDB802NvHfcQelR/dBlADPQZ7/clXgfJghpwp0VkvEddJw+95TVnMPaG+bRiw/mgj/k6rNvVyxs6QOJxPp4Q/iSM5g16zaUlUxHN0LMehJpl1fbkJr8gyKyLXDQkTAjofMNZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx7qnQq8Bpm6YdAA--.25527S3;
	Mon, 23 Mar 2026 10:56:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxbcLOq8Bpcg5bAA--.40805S3;
	Mon, 23 Mar 2026 10:56:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 1/4] LoongArch: KVM: Add kvm_request_pending checking in kvm_late_check_requests()
Date: Mon, 23 Mar 2026 10:56:10 +0800
Message-Id: <20260323025613.3260876-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260323025613.3260876-1-maobibo@loongson.cn>
References: <20260323025613.3260876-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxbcLOq8Bpcg5bAA--.40805S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add kvm_request_pending() checking firstly in kvm_late_check_requests(),
at most time there is no pending request, the following pending bit
checking can be skipped then.

Also move function kvm_check_pmu() in kvm_late_check_requests(), and put
it after kvm_request_pending() checking.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8ffd50a470e6..028eb3d5a33b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -149,14 +149,6 @@ static void kvm_lose_pmu(struct kvm_vcpu *vcpu)
 	kvm_restore_host_pmu(vcpu);
 }
 
-static void kvm_check_pmu(struct kvm_vcpu *vcpu)
-{
-	if (kvm_check_request(KVM_REQ_PMU, vcpu)) {
-		kvm_own_pmu(vcpu);
-		vcpu->arch.aux_inuse |= KVM_LARCH_PMU;
-	}
-}
-
 static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
 {
 	u32 version;
@@ -232,6 +224,14 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
 static void kvm_late_check_requests(struct kvm_vcpu *vcpu)
 {
 	lockdep_assert_irqs_disabled();
+	if (!kvm_request_pending(vcpu))
+		return;
+
+	if (kvm_check_request(KVM_REQ_PMU, vcpu)) {
+		kvm_own_pmu(vcpu);
+		vcpu->arch.aux_inuse |= KVM_LARCH_PMU;
+	}
+
 	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GPA, vcpu))
 		if (vcpu->arch.flush_gpa != INVALID_GPA) {
 			kvm_flush_tlb_gpa(vcpu, vcpu->arch.flush_gpa);
@@ -312,7 +312,6 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		/* Make sure the vcpu mode has been written */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 		kvm_check_vpid(vcpu);
-		kvm_check_pmu(vcpu);
 
 		/*
 		 * Called after function kvm_check_vpid()
-- 
2.39.3

