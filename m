Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44B1AF0BB;
	Tue, 24 Mar 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774322131; cv=none; b=r3Le6/gWX01UUy8Wzlo1H3vHDQ4SI+DRkVNPHaouDUhAJLTVklV0CK9UsQRlLWPwoyjXFAhI/lv+q5+r46z+4ezxYYtXFMpaJnl30WSq7Auxf2P56AhmF02CCMtkJUPwrBhiIyzWXIRmkhrEzvr5cONxq6SbtnZJQzNRCoSH028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774322131; c=relaxed/simple;
	bh=9PulvccSPZ5qAmAiTFw7xCH66q4XDgzcFpA7ueFojxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewzu+4cUV7XbAkbj5K698Y9r+0h2q/LB9YXhYW2lRcvj2C4jt0LY0h97QHN54Ak9Knpq3aYAUD/CJw6HLQ0/aarbEpol1SJQddnH9KWkXRMSPfJ/mn5J6R66PYM3kZtSvcPGRV4Jv0qicf3X3DXIhn4pu5ACMskqfCHoJ3bM8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axz6vGAcJpNRAeAA--.27194S3;
	Tue, 24 Mar 2026 11:15:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxXcLCAcJpPOdbAA--.41620S2;
	Tue, 24 Mar 2026 11:15:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Aurelien Jarno <aurel32@debian.org>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Fix base address calculation problem in kvm_eiointc_regs_access()
Date: Tue, 24 Mar 2026 11:15:06 +0800
Message-Id: <20260324031506.264062-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxXcLCAcJpPOdbAA--.41620S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In function kvm_eiointc_regs_access(), register base address is caculated
from array base address plus offset, the offset is absolute value from base
address. The data type of array base address is u64, it should be converted
into void * type and then plus the offset.

Cc: <stable@vger.kernel.org>
Fixes: d3e43a1f34ac ("LoongArch: KVM: Use 64-bit register definition for EIOINTC").
Reported-by: Aurelien Jarno <aurel32@debian.org>
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1131431
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/eiointc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
index d2acb4d09e73..71bd67b57338 100644
--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -472,34 +472,34 @@ static int kvm_eiointc_regs_access(struct kvm_device *dev,
 	switch (addr) {
 	case EIOINTC_NODETYPE_START ... EIOINTC_NODETYPE_END:
 		offset = (addr - EIOINTC_NODETYPE_START) / 4;
-		p = s->nodetype + offset * 4;
+		p = (void *)s->nodetype + offset * 4;
 		break;
 	case EIOINTC_IPMAP_START ... EIOINTC_IPMAP_END:
 		offset = (addr - EIOINTC_IPMAP_START) / 4;
-		p = &s->ipmap + offset * 4;
+		p = (void *)&s->ipmap + offset * 4;
 		break;
 	case EIOINTC_ENABLE_START ... EIOINTC_ENABLE_END:
 		offset = (addr - EIOINTC_ENABLE_START) / 4;
-		p = s->enable + offset * 4;
+		p = (void *)s->enable + offset * 4;
 		break;
 	case EIOINTC_BOUNCE_START ... EIOINTC_BOUNCE_END:
 		offset = (addr - EIOINTC_BOUNCE_START) / 4;
-		p = s->bounce + offset * 4;
+		p = (void *)s->bounce + offset * 4;
 		break;
 	case EIOINTC_ISR_START ... EIOINTC_ISR_END:
 		offset = (addr - EIOINTC_ISR_START) / 4;
-		p = s->isr + offset * 4;
+		p = (void *)s->isr + offset * 4;
 		break;
 	case EIOINTC_COREISR_START ... EIOINTC_COREISR_END:
 		if (cpu >= s->num_cpu)
 			return -EINVAL;
 
 		offset = (addr - EIOINTC_COREISR_START) / 4;
-		p = s->coreisr[cpu] + offset * 4;
+		p = (void *)s->coreisr[cpu] + offset * 4;
 		break;
 	case EIOINTC_COREMAP_START ... EIOINTC_COREMAP_END:
 		offset = (addr - EIOINTC_COREMAP_START) / 4;
-		p = s->coremap + offset * 4;
+		p = (void *)s->coremap + offset * 4;
 		break;
 	default:
 		kvm_err("%s: unknown eiointc register, addr = %d\n", __func__, addr);

base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.39.3

