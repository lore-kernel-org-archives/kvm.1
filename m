Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FD35DA6B;
	Tue, 17 Mar 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739766; cv=none; b=rDuM0stCt7kpo7Q3UMxdsgxWNu6vPFU69xySx/g+lhIPvkCUkYf4JSsO+G9e6yRGOMeQ/W7YDrRNcTOyVD8RrmNJojc4X1EX4Vuzvv9Ydbc5NwbdwdY7g6gNfAJ4jOI7lNoqSX6tvCrXxhFkQkAtUbt4ZI9C7eLjya5Xg83fO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739766; c=relaxed/simple;
	bh=CYX3G3ifnOGdRTffmuHm0LU74ney0de1dwmKeDVPgFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jR0LXoOmNkZgAe37FbHIRM5UBE+nCpiXtejVa508kT4ARcFRWWzuTUOIZE2e7fy2nL5bG+MFvxKNPMfiqrccyY1V2Mh7MDLb84SfzjBIaTdNrqnKDTwVOwBofEEYNv34dLRmg/hksFf4OZkqH4lmScVqDjEz11VmgNp5g0M/oNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxqsLsHrlpTOQbAA--.14701S3;
	Tue, 17 Mar 2026 17:29:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxHOHpHrlp3PlWAA--.35253S4;
	Tue, 17 Mar 2026 17:29:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 2/3] LoongArch: KVM: Move host CSR_EENTRY save in context switch
Date: Tue, 17 Mar 2026 17:29:10 +0800
Message-Id: <20260317092911.1400248-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260317092911.1400248-1-maobibo@loongson.cn>
References: <20260317092911.1400248-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHpHrlp3PlWAA--.35253S4
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
index 028eb3d5a33b..e82b2c84ce17 100644
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

