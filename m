Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7E4A04;
	Mon, 21 Apr 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745198334; cv=none; b=lTSVPc1J3ynC8ivhgO4IXTtSoRb0Si1T3ieccOwVbXjJc1GAwXIsqLfpynH4HtB7d0ZpaAxCaQsq2MtTZekkLGzvdrCP05NmX54HM0qVv2RG3990Yt/hB2PpC6akoQUNv3LEW4A79b9Nto0EMJImHolLumJ21+U0NpsvqROTgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745198334; c=relaxed/simple;
	bh=AGjGEA3UQHflfsSVzsJYKfbazpiUPBGawRA+JlJmfG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dm8CCR/GleeI5dR3wVJWQTLChq672/ixZ2jRrJM7qEHmRwu6gfitkf/lq5r/kKp4HygiQZ4LCk7h0NMN1T0nZs11eC+HR9sd5YFC+gNAQuunsp5OpPW5pv3A9Zl0l9oL2BN05NljLEPoZWPM0AW3u2+qUWcugZ6CwZMAOsD9l+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bx12n3nAVoZCTDAA--.60723S3;
	Mon, 21 Apr 2025 09:18:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxPcXznAVo2ZiNAA--.23015S2;
	Mon, 21 Apr 2025 09:18:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Song Gao <gaosong@loongson.cn>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Fix PMU pass-through issue if VM exits to host finally
Date: Mon, 21 Apr 2025 09:18:43 +0800
Message-Id: <20250421011843.1760829-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPcXznAVo2ZiNAA--.23015S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In function kvm_pre_enter_guest(), it prepares to enter guest and check
whether there are pending signals or events. And it will not enter guest
if there are, PMU pass-through preparation for guest should be cancelled
and host should own PMU hardware.

Fixes: f4e40ea9f78f ("LoongArch: KVM: Add PMU support for guest")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 8e427b379661..d96191d65f53 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -294,6 +294,8 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.aux_inuse &= ~KVM_LARCH_SWCSR_LATEST;
 
 		if (kvm_request_pending(vcpu) || xfer_to_guest_mode_work_pending()) {
+			/* Lose pmu for guest and let host own it */
+			kvm_lose_pmu(vcpu);
 			/* make sure the vcpu mode has been written */
 			smp_store_mb(vcpu->mode, OUTSIDE_GUEST_MODE);
 			local_irq_enable();

base-commit: 3088d26962e802efa3aa5188f88f82a957f50b22
-- 
2.39.3

