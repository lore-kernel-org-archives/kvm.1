Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200FE3921E7;
	Thu, 11 Jun 2026 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161111; cv=none; b=X9XQuapahLV8ACp2kUkJOBttPdVBgzpHysieAPdb0DKJ8+jBUd0RtzPux8HhQvT1aoqHz3K9aB7vz2kDViw9j5e1Jyao9RCnrz4Xj0oP1irzQkY8KbbiiMwcQkGhSMGhT7gBrJTVVEHYgczX/SGykQGS6Qwyfgit1K7cpEpZzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161111; c=relaxed/simple;
	bh=1IHp0yC/H/PtDFmTqYwaKUn4w0Bm/nMZAQMO4UIYVvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uCOOuo8Pma6tMKvgGwqSwjCiVF5L/vUFUZuTeAn14diBzZyOYh3FUynP+EpNK6PnnZOZ9zIE/wYOckILmi4QIQuTsZ8sLfKk7FhAb5nEk5TCQysEQwDGcKBJ8mq8aHMGAiUotmMVmAuMffQbSI5msjpjMA0D5qsjl6wny1dHAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Ax_umQXCpq_PsSAA--.49964S3;
	Thu, 11 Jun 2026 14:58:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCx98CPXCpq76eiAA--.32753S4;
	Thu, 11 Jun 2026 14:58:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/6] LoongArch: KVM: Deliver interrupt after IN_GUEST_MODE is set
Date: Thu, 11 Jun 2026 14:58:15 +0800
Message-Id: <20260611065815.1439154-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260611065815.1439154-1-maobibo@loongson.cn>
References: <20260611065815.1439154-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx98CPXCpq76eiAA--.32753S4
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
index 4f67eefbd4f1..265675e63269 100644
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

