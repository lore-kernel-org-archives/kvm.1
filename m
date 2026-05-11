Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4422E9729;
	Mon, 11 May 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482322; cv=none; b=VZDQi3fP6nnToatewbmbDyOzJI5htZQrMTMkX3TFfzrKqLk1xdRCJQ7ydK996gtGxL2pnejkn+ik+njFPoXaNUxIr5DRaQ00vdGAsGhYHUcO2NwG6ZPi/G78tjzwRiLdO8ubXzJb3GxINyTXQNG0Sao+cWL3I483xvNnIXddwZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482322; c=relaxed/simple;
	bh=bkdPL4aU5AVbNIddBr38AQpKTrA6P6EU41ehqvOotp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msPETxe3hTcA9b3E40TmGCGjzmmlbEnj9/HpeL4Cwcn4Hv5Rqve8jPTms1PzQjxd0Y9oPRXZEqcpfHVxDUMNS2hoS0YK40knhKNifFQCUvyzV87UszGguxhXMR0Wv0Q0uwtJSQssSy+O8pkRrXPQE+hZ344D2uVjUbHJld28Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx13iOfAFq64wIAA--.2026S3;
	Mon, 11 May 2026 14:51:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAx28GEfAFqAOh+AA--.42931S4;
	Mon, 11 May 2026 14:51:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] LoongArch: KVM: Use existing macro about interrupt bit mask
Date: Mon, 11 May 2026 14:51:43 +0800
Message-Id: <20260511065146.680650-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511065146.680650-1-maobibo@loongson.cn>
References: <20260511065146.680650-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx28GEfAFqAOh+AA--.42931S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

With interrupt post, register CSR_GINTC and CSR_GSTAT is used, and
CSR_GSTAT is used for percpu interrupt injection and CSR_GINTC is for
external hardware interrupt injection.

Here use existing macro about interrupt bit of register CSR_GINTC and
CSR_GSTAT, rather than hard coded constant value.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_vcpu.h | 33 +++++++++++++++------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index ccf938d89f02..e504c3822e6f 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -10,22 +10,27 @@
 #include <asm/loongarch.h>
 
 /* Controlled by 0x5 guest estat */
-#define CPU_SIP0			(_ULCAST_(1))
-#define CPU_SIP1			(_ULCAST_(1) << 1)
-#define CPU_PMU				(_ULCAST_(1) << 10)
-#define CPU_TIMER			(_ULCAST_(1) << 11)
-#define CPU_IPI				(_ULCAST_(1) << 12)
-#define CPU_AVEC                        (_ULCAST_(1) << 14)
+#define CPU_SIP0			BIT(INT_SWI0)
+#define CPU_SIP1			BIT(INT_SWI1)
+#define CPU_PMU				BIT(INT_PCOV)
+#define CPU_TIMER			BIT(INT_TI)
+#define CPU_IPI				BIT(INT_IPI)
+#define CPU_AVEC			BIT(INT_AVEC)
+#define KVM_ESTAT_IRQ_MASK		(CPU_SIP0 | CPU_SIP1 | CPU_PMU | CPU_TIMER \
+						| CPU_IPI | CPU_AVEC)
 
 /* Controlled by 0x52 guest exception VIP aligned to estat bit 5~12 */
-#define CPU_IP0				(_ULCAST_(1))
-#define CPU_IP1				(_ULCAST_(1) << 1)
-#define CPU_IP2				(_ULCAST_(1) << 2)
-#define CPU_IP3				(_ULCAST_(1) << 3)
-#define CPU_IP4				(_ULCAST_(1) << 4)
-#define CPU_IP5				(_ULCAST_(1) << 5)
-#define CPU_IP6				(_ULCAST_(1) << 6)
-#define CPU_IP7				(_ULCAST_(1) << 7)
+#define GINTC_VIP_DELTA			(INT_HWI0 - CSR_GINTC_VIP_SHIFT)
+#define CPU_IP0				BIT(INT_HWI0 - GINTC_VIP_DELTA)
+#define CPU_IP1				BIT(INT_HWI1 - GINTC_VIP_DELTA)
+#define CPU_IP2				BIT(INT_HWI2 - GINTC_VIP_DELTA)
+#define CPU_IP3				BIT(INT_HWI3 - GINTC_VIP_DELTA)
+#define CPU_IP4				BIT(INT_HWI4 - GINTC_VIP_DELTA)
+#define CPU_IP5				BIT(INT_HWI5 - GINTC_VIP_DELTA)
+#define CPU_IP6				BIT(INT_HWI6 - GINTC_VIP_DELTA)
+#define CPU_IP7				BIT(INT_HWI7 - GINTC_VIP_DELTA)
+#define KVM_GINTC_IRQ_MASK		(CPU_IP0 | CPU_IP1 | CPU_IP2 | CPU_IP3 \
+						| CPU_IP4 | CPU_IP5 | CPU_IP6 | CPU_IP7)
 
 #define MNSEC_PER_SEC			(NSEC_PER_SEC >> 20)
 
-- 
2.39.3

