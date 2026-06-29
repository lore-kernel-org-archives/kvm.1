Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E831B86C7;
	Mon, 29 Jun 2026 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700347; cv=none; b=mqSeFZNSlyNj/xLAz1z3Yq0bz83iHM9EondEcY0XLnzsPBeDamVrBOv+/J2CI1CRT3yRBUDanPoQFQkpISw71vfXFBepsWdVgb7Y3M9uqJC5DssHniSuoDIZ4WIpUu2gUO+Y7MnXcrczcMS+Ji9e3G66RhHDCz4ka8ElMAXZXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700347; c=relaxed/simple;
	bh=smuXTbOEaVyaMXYXFYjix9vjemoWBCJhdYB022jFcwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3GOO2LOsdWksVzQUrsvrnTHAriuA20QFJinH8TNzwkXFP0pQzcnlWRG/315bCPdFcr6WJ9yITLDHzqiUb/DUkYGwYfD6hjQD1gE2Om2LUn3hkb2J9lcABqtSxCPECXcMYFx7aKX28v5nSk9heBqy7alA+ZFGI0XwRwZXixaRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Bxt3g32UFqUP8YAA--.39240S3;
	Mon, 29 Jun 2026 10:32:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxWeAu2UFqbBe3AA--.19539S3;
	Mon, 29 Jun 2026 10:32:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] LoongArch: KVM: Set default MAILBOX access size with 8
Date: Mon, 29 Jun 2026 10:32:11 +0800
Message-Id: <20260629023213.597030-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260629023213.597030-1-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAu2UFqbBe3AA--.19539S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With IOCSR instruction emulation in function kvm_emu_iocsr(), the possible
size combination is 1/2/4/8 and no other combinations. Here remove the
old default case and replace the default case with 8 in read_mailbox()
and write_mailbox().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/intc/ipi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
index 4fa0897d7bdb..d70bf415c7fc 100644
--- a/arch/loongarch/kvm/intc/ipi.c
+++ b/arch/loongarch/kvm/intc/ipi.c
@@ -67,11 +67,8 @@ static uint64_t read_mailbox(struct kvm_vcpu *vcpu, int offset, int len)
 		return data & 0xffff;
 	case 4:
 		return data & 0xffffffff;
-	case 8:
-		return data;
 	default:
-		kvm_err("%s: unknown data len: %d\n", __func__, len);
-		return 0;
+		return data;
 	}
 }
 
@@ -92,11 +89,9 @@ static void write_mailbox(struct kvm_vcpu *vcpu, int offset, uint64_t data, int
 	case 4:
 		*(unsigned int *)pbuf = (unsigned int)data;
 		break;
-	case 8:
+	default:
 		*(unsigned long *)pbuf = (unsigned long)data;
 		break;
-	default:
-		kvm_err("%s: unknown data len: %d\n", __func__, len);
 	}
 	spin_unlock(&vcpu->arch.ipi_state.lock);
 }
-- 
2.39.3

