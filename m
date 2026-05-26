Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853AC238C36;
	Tue, 26 May 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799993; cv=none; b=FLBR2fE0CqTDJ96pzR8ZqDKVgLWHgb3ytWlDgblsC9TvCyICRJJfxMswXbFc0E1/FPwjacH0yZhIUs7NIpz4sBZF3qajwapd+I/vPBza19o4BTa/EqwSWpONcjF6op62epnQg3Yccgs7Wr6+7kOah0barFxVEms6cjnpWfQ7YYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799993; c=relaxed/simple;
	bh=OhZM1n+w+2YwGw6tdwAp/Kdasbom8NQOMvqLT/bxDE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8YaHpjo7x+O3uD9EL6jJoKkX0hZ9eEkqzjRXYLqV7I3sVqqxLiIFy0bFG+5XZGCesWcpB8ZQDEzu19pdv4VZkNHIjHoBzVPVV8XeP6upvdYYSXwIQT5mV8NVom3tnFOw2UvGJ3a0GtJc+b2llr9tiBTUJcNq59kSwyamIAciig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxsOqvlxVqL2gNAA--.38294S3;
	Tue, 26 May 2026 20:53:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxpsCulxVqb5iRAA--.44615S4;
	Tue, 26 May 2026 20:53:03 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set
Date: Tue, 26 May 2026 20:52:55 +0800
Message-Id: <20260526125256.2511876-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526125256.2511876-1-maobibo@loongson.cn>
References: <20260526125256.2511876-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsCulxVqb5iRAA--.44615S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Interrupt delivery should be called after IN_GUEST_MODE is set. Other
threads may be posting interrupt however does not send IPI to the
vCPU, since the vCPU is not in IN_GUEST_MODE.

here move function call with kvm_deliver_intr() after IN_GUEST_MODE
is set, and set mode with OUTSIDE_GUEST_MODE with atomic method.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kvm/vcpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 3c6726e00531..f8ce985dc97b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -308,10 +308,10 @@ static int kvm_pre_enter_guest(struct kvm_vcpu *vcpu)
 		 * check vmid before vcpu enter guest
 		 */
 		local_irq_disable();
-		kvm_deliver_intr(vcpu);
 		kvm_deliver_exception(vcpu);
 		/* Make sure the vcpu mode has been written */
 		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
+		kvm_deliver_intr(vcpu);
 		kvm_check_vpid(vcpu);
 
 		/*
@@ -348,7 +348,7 @@ static int kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	u32 intr = estat & CSR_ESTAT_IS;
 	u32 ecode = (estat & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
 
-	vcpu->mode = OUTSIDE_GUEST_MODE;
+	smp_store_mb(vcpu->mode, OUTSIDE_GUEST_MODE);
 
 	/* Set a default exit reason */
 	run->exit_reason = KVM_EXIT_UNKNOWN;
-- 
2.39.3

