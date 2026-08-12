Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677B3E171C
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523982; cv=none; b=H6CivErzp2j1PMoJ9bOohtzrtQB5gM2d8i3bOCS/RcE6QinlZr3zr39alzoMljjXSpruEMM9Q3GHymn6+Py7t6FcI3FfRNg+J5i/eUjEryCNyZ2o+062nCMU0WH67EtvVTzzwkAFTm8XmelRVrDDKvM48G0RXIEAj6GrDIW9aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523982; c=relaxed/simple;
	bh=y/mZIHpLkUD8rchDcl8nd3UVsTrxSurInsR3eeqy2d8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rTUFen/NfbMY1aX2PDotL46SAhYZJafvEmJxyP2Q5KyTnWnN5JpQetg8JxrQ3mizj3Ab4LjqCYQS1EfHHoujCnpIM4n1ljQvBk/RgfGT+gyyzhLkSHhQb2bDy5wkeNUtsUfkv/xVyPfhFOExu9qNxApeyLmmF1WVDvwHupQSkr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hc6qnr6l; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hc6qnr6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=gxfJs/zHb7nHF591FwcoW5Pj/IAvpxr1Zc32xpPuphU=;
	b=hc6qnr6lhCeOLYd5RtFgzloPc+qqHdcUHi1ei0fFFRq4TcAsnaFBeGNLw5nBXW
	TWPO5fUeG4jDfOiKsbhaiOO/WX7UkRHnyIh9NB25pVyIGugPHpzskzigMR26JE5U
	0THOusNuSwn5QeXt2XtYnYrO1Z4GnFfH15tpUcKXabyzI=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnIyIuMXxqRlN6Lw--.52315S2;
	Wed, 12 Aug 2026 16:39:10 +0800 (CST)
Date: Wed, 12 Aug 2026 16:39:07 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v5 5/6] KVM: x86: ioapic: Clear irr_delivered on
 level-triggered RTE
Message-ID: <anwxK1aCSCGVygih@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anwugm-oU0v1VM-t@192.168.1.215>
X-CM-TRANSID:QCgvCgAnIyIuMXxqRlN6Lw--.52315S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF15CryrAFyxuFWftFWrKrg_yoW8ArWkpa
	y0kan5ur4DXwn5Gas7Aa10gF9xu3s5Jr43CrWDC3yUtayYg3s2qFs3CrWkWa4rWrWxAw42
	qr1Fyw1rWFyDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRo5l5UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3Q4RBGp8MS5VlgAA3M

From: Hao Zhang <zhanghao1@kylinos.cn>

irr_delivered hides delivered edge interrupts from KVM_GET_IRQCHIP.
The interrupt remains in IRR until the guest deasserts the line.

The guest can reprogram an IOAPIC RTE from edge to level via MMIO.
If an edge interrupt was delivered before the trigger mode change, a
stale irr_delivered bit can incorrectly mask a subsequent pending level
interrupt from KVM_GET_IRQCHIP.

That can cause userspace to migrate the VM without a pending level
interrupt that is still present in KVM's in-kernel IOAPIC.

Clear irr_delivered when the RTE is configured for level-triggered
interrupts.

Fixes: 5bda6eed2e36 ("KVM: ioapic: Record edge-triggered interrupts delivery status")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/ioapic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 676effd674f9..81db025d2ac9 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -377,8 +377,17 @@ static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 		 * as edge-triggered. This behavior is used to simulate an
 		 * explicit EOI on IOAPICs that don't have the EOI register.
 		 */
-		if (e->fields.trig_mode == IOAPIC_EDGE_TRIG)
+		if (e->fields.trig_mode == IOAPIC_EDGE_TRIG) {
 			e->fields.remote_irr = 0;
+		} else {
+			/*
+			 * irr_delivered tracks edge-triggered interrupts that
+			 * have already been delivered.  Clear stale edge-triggered
+			 * delivery state when the entry is configured for
+			 * level-triggered interrupts.
+			 */
+			ioapic->irr_delivered &= ~(1 << index);
+		}
 
 		mask_after = e->fields.mask;
 		if (mask_before != mask_after)
-- 
2.15.0

