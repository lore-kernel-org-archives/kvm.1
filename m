Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2E3F4139;
	Tue, 14 Jul 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014366; cv=none; b=C0p4fCLhN6vIlC7yXR8wOdNrVaEM97vFH7Xz6QKomknT4YCmULg9FpCGe/7ln0Pp7Mpp9BQPUpH0/Bi33nEtMEBOWANy3zuUMudRztXV/qQBS1xAF4SFQ+DlHeZTCz+Oqe14EF1fYNlVJ19g3tZVF3s8ktLraW/mY+TO+5ruOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014366; c=relaxed/simple;
	bh=Wz6SHYMnyGJZn88lQLhnNjm4J5XHoJdBKLom6lEuXZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UB7pdk6ttlUMEr9b0UNdlM2B3WuVCE+5yUiFA+d2OXt2oLrD8123r/b3vLOeHZOrNRpE9GZlx3qPsSljjKI2PDoTOQc8N29FDaG8Z85lNEoVSRHgIL1V26s1uLl3TInhRqE17KXGC+o9IqzQEzTpAQueG4c7Q9Lfn7jpZDUxMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cxqusa5lVqr1MDAA--.13493S3;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxIuQT5lVqzZEMAA--.38917S5;
	Tue, 14 Jul 2026 15:32:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Song Gao <gaosong@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] LoongArch: KVM: Set default MAILBOX access size with 8
Date: Tue, 14 Jul 2026 15:25:18 +0800
Message-Id: <20260714072520.2745942-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260714072520.2745942-1-maobibo@loongson.cn>
References: <20260714072520.2745942-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuQT5lVqzZEMAA--.38917S5
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
index 928f9bd5e1f1..3871a6953a64 100644
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

