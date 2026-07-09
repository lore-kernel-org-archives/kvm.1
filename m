Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25D3ED134;
	Thu,  9 Jul 2026 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585716; cv=none; b=rB0lj9UZWmLmjNltv6QMDxlGhV6KSFBrEsSH1p2ZGxa31NWXGwpQLx37/ov+MedTC5W3HsHJ22Im+93J6TxnHmMk94xmnH0T+/pE2/ugrDGmgn8G9J52dQe+LRcRrPTXD+zt4mnGm4D7qhap5Qb4Xyy87wVlwkC2n0SZNJIJ3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585716; c=relaxed/simple;
	bh=smuXTbOEaVyaMXYXFYjix9vjemoWBCJhdYB022jFcwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlQIK5vF27H8URSWwNB/RSyngdtzx3pZGDcluRKRjnUpsuE8EeU7wNo4k3rem/RyccKJqGwug8lVPJIzbA9i/mbREnvEy5Tc01le9SvmUboR42OkQ7n+XBQyVIrEu4K2h88JRKeVlJz1QlRaXBOHjpg61jmcDj/eY+zf14rvBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx5+quW09q5MYBAA--.7494S3;
	Thu, 09 Jul 2026 16:28:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxnMapW09q3qIGAA--.32266S3;
	Thu, 09 Jul 2026 16:28:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] LoongArch: KVM: Set default MAILBOX access size with 8
Date: Thu,  9 Jul 2026 16:21:06 +0800
Message-Id: <20260709082109.1361767-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260709082109.1361767-1-maobibo@loongson.cn>
References: <20260709082109.1361767-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxnMapW09q3qIGAA--.32266S3
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

