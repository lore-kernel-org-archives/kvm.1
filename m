Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EF208D0;
	Sat,  9 May 2026 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778299328; cv=none; b=sx40tUKksIFWLeJ1l9s0U28XCwKybKT8Vk5Stjtwr93ezgBeppiJ5+kqma/E2qwYSYmtX0blGDH7j++XFYWmpKrAfE4vjRUC7cTE8LlxDLFTXcVpVEi6suFu85rkQoauIcWscXNoOhefaIp1zsumOvsZ2tqP9UM/Y1XYoLxKRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778299328; c=relaxed/simple;
	bh=MpJu2PGkahvdKHNbYtsIqlF0BnnmwVMSDHE00fQHtVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V2yb+MavSbvTidPT1gFCsmrVJrYfmpMDjtD5j38gCIFXHMksiV/WChj0XsoYPiMLoaaLmq79jW8Zuj+QbeuspdZGk+xsNUFWYUyhcrnfQ85uoZSu0/ZaStPJYut4I02BkTMn7J0ur7mY+wevTr52uuYdaF+5zFZVgGRqDwId5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxAuu5sf5pRR0IAA--.25671S3;
	Sat, 09 May 2026 12:02:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxB8G4sf5pGFt9AA--.28188S2;
	Sat, 09 May 2026 12:02:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Remove timer interrupt injection with SW timer expired
Date: Sat,  9 May 2026 12:01:59 +0800
Message-Id: <20260509040159.338866-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxB8G4sf5pGFt9AA--.28188S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The software timer emulation is to wake up vCPU when vCPU executes
idle instruction and gives up host CPU, timer interrupt is injected
in vCPU context switch on and guest CSR timer restore function.

It is not necessary to inject timer interrupt when SW timer is expired.
Here remove it.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index 8356fce0043f..9bbf25be3903 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -30,7 +30,6 @@ enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.swtimer);
-	kvm_queue_irq(vcpu, INT_TI);
 	rcuwait_wake_up(&vcpu->wait);
 
 	return HRTIMER_NORESTART;

base-commit: 917719c412c48687d4a176965d1fa35320ec457c
-- 
2.39.3

