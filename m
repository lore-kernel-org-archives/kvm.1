Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F152F6577;
	Wed, 11 Mar 2026 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199263; cv=none; b=LvyTo7EmG3ZZR8olvcizgug1Y5+uYBmuYDh0mZRD05Tcd9p+x+zeAz84AD2a7rGW0t20TjlOmD1ssfI0Iqa6uWK8l6A07gjuEKk0l47L6AlqGG8F2OskN+fubrf1Nvl+PS5DB5ZyowmiBm81e5VshbmaVCiCxSmStBgFE9Vg24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199263; c=relaxed/simple;
	bh=Y9kRhex0//f7baPvR8E6zVksePP0JGjPvBxZa/0Qey8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBz5/GWwZIcehFJ9KMnL+No/TIzxhNxJZKDNZ96DD28RLwx6u3uehLBRxEj1EuamTjHpGY2Oiq07BKu9hbW+txe01IIqpl+ZEWTmRawvL1Ql/z/6EU2VhoBoyjkRZ4DNwDaV5kJAR85ZyVXyvWLRT0MH3Vs8IOUdzc4xQaBTUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxMMCI37BpucgZAA--.16602S3;
	Wed, 11 Mar 2026 11:20:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAj37BpH69SAA--.26923S4;
	Wed, 11 Mar 2026 11:19:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/3] LoongArch: KVM: Move host CSR_EENTRY save in context switch
Date: Wed, 11 Mar 2026 11:18:56 +0800
Message-Id: <20260311031857.3591470-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260311031857.3591470-1-maobibo@loongson.cn>
References: <20260311031857.3591470-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAj37BpH69SAA--.26923S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

CSR register LOONGARCH_CSR_EENTRY is shared between host cpu and guest
vCPU, KVM need save and restore LOONGARCH_CSR_EENTRY register. Here move
CSR register LOONGARCH_CSR_EENTRY saving in context switch function,
rather than VM enter entry.

At most time VM enter/exit is much more frequent than vCPU thread context
switch.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 6104982b53c8..044627c6ddc7 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -319,7 +319,6 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		 * and it may also clear KVM_REQ_TLB_FLUSH_GPA pending bit
 		 */
 		kvm_late_check_requests(vcpu);
-		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
 		/* Clear KVM_LARCH_SWCSR_LATEST as CSR will change when enter guest */
 		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
 
@@ -1624,9 +1623,11 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * If not, any old guest state from this vCPU will have been clobbered.
 	 */
 	context = per_cpu_ptr(vcpu->kvm->arch.vmcs, cpu);
-	if (migrated || (context->last_vcpu != vcpu))
+	if (migrated || (context->last_vcpu != vcpu)) {
 		vcpu->arch.aux_inuse &= ~KVM_LARCH_HWCSR_USABLE;
-	context->last_vcpu = vcpu;
+		context->last_vcpu = vcpu;
+		vcpu->arch.host_eentry = csr_read64(LOONGARCH_CSR_EENTRY);
+	}
 
 	/* Restore timer state regardless */
 	kvm_restore_timer(vcpu);
-- 
2.39.3

