Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4738734D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023572; cv=none; b=O6IaajVv5EQzdS7OgS3+8i5E/U/dInWipjnZUhi+BbZkavGYJ42GuXO6gaKkwtcp8i1h7F0gHk/RnawvufOXhpbjFyRxnxhJxbHjGqmGroEB8pQYXS8eP+dgWfNzaBBgvCim0hrOq1T0uZY5+DQb0UrAzOP2cvydVukHWH/iTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023572; c=relaxed/simple;
	bh=fGiEBig1+PxObcMRjhnaSQu+CNHGMbAe5oFHz6Pmgpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qHN9gfpK3gQ2AdeZAHn74t8kpf3VbTfwlXaXCRa55g9agncjTI3WSilSeBlZALe5nfym/IQJlIZ9l0kANd0mavL+KCTxQ/0BFDyYfkvE438EJ5qy7mX2q17fFn0W4MM2Vg3Cc2OPyr2/q/ch1t/ZSSGG/yDozl0bbm1EoMpOKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gVCCb5AS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gVCCb5AS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=PMrw2dkMkevRx0mBN9tT7igHWZ3Aq1QLBjN8i+eUHq4=;
	b=gVCCb5ASo1DNZOaONsgM6zC+IZY0FYV7FASh1LdAUaF2M/1A5Hz40MjYKcSnci
	5BMoD2LaYueAphV6X9aciGv1210PcfnTPKzH444QllgYRe03p9uAgqzIB93NsnFx
	K+NmYs6j/HVfJDuxbXElPP+P6iZ/Jg3vISsk3gxRoVU7I=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHLwJ2jnRqAmAJOQ--.33671S2;
	Thu, 06 Aug 2026 21:39:02 +0800 (CST)
Date: Thu, 6 Aug 2026 21:39:02 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after successful
 delivery
Message-ID: <anSOdijwS6LBbfYJ@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wCHLwJ2jnRqAmAJOQ--.33671S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxKw1fZF1DZFWftr4Dtwb_yoW8XrWrpF
	WfCa98Kr4ktr4UGFyvya1rJr98u34vyr4fCr1Du347AFn093s7Xr4xXrW0ga48W3yrA3yY
	qr1Yvw1fXFyDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j6D73UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+Rd4a2p0jnfC4gAA36

From: Hao Zhang <zhanghao1@kylinos.cn>

The I/O APIC sets remote_irr for level-triggered interrupts to track that
the interrupt has been accepted by a local APIC and that the I/O APIC must
wait for the corresponding EOI before delivering the interrupt again.

But ioapic_service() currently sets remote_irr for any non-zero return
from kvm_irq_delivery_to_apic(). The delivery helper can return -1 when
no destination is found. Treating -1 as success causes KVM to set
remote_irr even though no interrupt was delivered and no EOI will ever
be generated, leaving the pin blocked.

Set remote_irr only when the delivery result is positive, i.e. when at
least one local APIC accepted the interrupt.

Fixes: 4925663a079c ("KVM: Report IRQ injection status to userspace.")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 757667fb2bfa..24a7cc3b8b7e 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -491,7 +491,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
 	} else
 		ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
 
-	if (ret && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
+	if (ret > 0 && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
 		entry->fields.remote_irr = 1;
 
 	return ret;

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.15.0

