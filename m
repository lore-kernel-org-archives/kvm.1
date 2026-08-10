Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14536494F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786342690; cv=none; b=oFyoPhsek9SUjF4MT6RnJejFgsWnDsNT8JkXujzQ7s0AL+IENQzENTQQ546QU3XdTnvKwd1lQTNHW8+cmzTkriTEnh5T2nwriKHeOSuh5p7JAVPZ+ISmltUyZXefN9w/ojsgj6ubT1X3CmGKk9ojP+tuEqW9fAsIsd+qr03pLd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786342690; c=relaxed/simple;
	bh=3lD3q8wMZ3PdcuhUkyElXFPmUS7XOYG3bUwzqRB2uZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=foQR3auDUAUkBUsLBrSjjPPz31rQbiPl2DeZn3qZoAR1dZUqEkCPiZca3QwFWhUcOdEXJb/4ih2PWtGrcrRDOBsmOs+8JzPHkov2fD8Q11vbYUWb0mGyAMRAVCfT8b00c9F/kDoZyES57c62geAaq7aQpL1pwVty7Jmq/R9i7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HQiux8ST; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HQiux8ST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=amKM5PLJDLcbAbnxIdU/PLJFzXlolDvlxKCzQu1nQzk=;
	b=HQiux8STn8sIzCjAb+8v2rhcjQ3xDju0xqWAt5/pHMu+Ay8O0s45ijpJuuyo/b
	BC313J7OlRnAbPkeI9FqFlFDTBeU3NZ/Blvo9dB1u7wACZ1MB+bzkXdGPXYqjGYu
	3BB9zxTYmQjC0yhpVhu/fantUabFI0bpwJgd6ZO8Bpj+w=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnkLP6bHlq0PYxMQ--.55222S2;
	Mon, 10 Aug 2026 14:17:30 +0800 (CST)
Date: Mon, 10 Aug 2026 14:17:29 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Huang, Kai" <kai.huang@intel.com>,
	kvm@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: ioapic: Update state only after successful
 delivery
Message-ID: <anls-aUppuiFolpS@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:PigvCgAnkLP6bHlq0PYxMQ--.55222S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFW3CFW7CFW8Zw1xCr18AFb_yoW5WFW8pF
	WDCayq9r4kJr1rWF4vya1rAF98u3s5trW3C34kC34ftan0yw1vqrs7KrW0qa4UWrWfAa1U
	tF15tw15CFyUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UEJmUUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+RtSRWp5bPsgqwAA36

From: Hao Zhang <zhanghao1@kylinos.cn>

The I/O APIC tracks delivered interrupts in state that is later used to
decide whether an interrupt is still pending or blocked waiting for an
EOI.

For level-triggered interrupts, remote_irr means that a local APIC
accepted the interrupt and that the I/O APIC must wait for the
corresponding EOI before delivering the interrupt again.  For
edge-triggered interrupts, irr_delivered is used to hide delivered
interrupts from KVM_GET_IRQCHIP so that userspace does not reinject an
interrupt that has already left the I/O APIC.

But ioapic_service() currently updates that state before or without
checking that interrupt delivery actually succeeded.
kvm_irq_delivery_to_apic() can return -1 when no destination is found.
Treating failed delivery as success can either leave a level-triggered
pin blocked forever waiting for an EOI that will never be generated, or
cause KVM_GET_IRQCHIP to drop an undelivered edge-triggered interrupt
from the saved IRR state.

Update I/O APIC delivery state only when the delivery result is positive,
i.e. when at least one local APIC accepted the interrupt.

Fixes: 4925663a079c ("KVM: Report IRQ injection status to userspace.")
Fixes: 5bda6eed2e36 ("KVM: ioapic: Record edge-triggered interrupts delivery status")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Changes in v2:
 - Address Kai Huang's review by deferring both remote_irr and
   irr_delivered updates until interrupt delivery succeeds.
 - Extend the selftest to cover failed edge-triggered delivery and verify
   that the interrupt remains pending in IRR.

Link to v1: https://lore.kernel.org/all/anSOdijwS6LBbfYJ@192.168.1.215/

 arch/x86/kvm/ioapic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 757667fb2bfa..540e5665fbe4 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -474,9 +474,6 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
 	irqe.shorthand = APIC_DEST_NOSHORT;
 	irqe.msi_redir_hint = false;
 
-	if (irqe.trig_mode == IOAPIC_EDGE_TRIG)
-		ioapic->irr_delivered |= 1 << irq;
-
 	if (irq == RTC_GSI && line_status) {
 		/*
 		 * pending_eoi cannot ever become negative (see
@@ -491,8 +488,12 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
 	} else
 		ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
 
-	if (ret && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
-		entry->fields.remote_irr = 1;
+	if (ret > 0) {
+		if (irqe.trig_mode == IOAPIC_EDGE_TRIG)
+			ioapic->irr_delivered |= 1 << irq;
+		else if (irqe.trig_mode == IOAPIC_LEVEL_TRIG)
+			entry->fields.remote_irr = 1;
+	}
 
 	return ret;
 }

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.15.0

