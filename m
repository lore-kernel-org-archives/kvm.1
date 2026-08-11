Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E923FBB7D
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433699; cv=none; b=NZWksoKjr8bnyswivEfc8muWOneaN4rU6RJN+xQFOEWjt9TWKhpU2RxNHYYgDGdJCARkW7yhGjjXy8CwaiaxIjPP5jXwsOozZNJatuHx7USakESY1CzHJMmTHlGbu9YIppDZz937MeC4D6LCFXmzVdZowvgIFMQpMBRhw1yjnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433699; c=relaxed/simple;
	bh=BCijcyc2YON9Qun6yhjuU9sJdVm13vfOtl6wh60ohao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SzP1KNQkx+uFSpbsm68jvdEdKtFC4/+ToHPvoabKofJCLOBHBJk4hGdFuyNzvLL8Q42CwAScf5AZxcGkDr2zP2H5nCaFyhCL+UqAdZ+1cPaqzj48EtKPffthgP+yJ6XLrcdamQcbZRZVECyRsV7KQQxw0y32QjrSsOFcde6UC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BtZJ9AH5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BtZJ9AH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=knco2wL0PAROi7VA9hpFL4U53D68U96cTEPJr5RB/HI=;
	b=BtZJ9AH5IFB19sxTuextr2G+wT2CkToFCphpk67jT2e1z0KfhXIk1G6K1TtuHJ
	drpCzS+Uuffa9529IYidP6CXVjpMMthmbq4r5uQgzNi1UgpIph00QNpHPrHzzk0S
	bZ3zhv3ZJGVvv3QCynnnhr/sjYHW1BWOtxX0yktpavg98=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3H_B+0HpqS+HkAw--.42304S2;
	Tue, 11 Aug 2026 15:34:23 +0800 (CST)
Date: Tue, 11 Aug 2026 15:34:22 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v4 1/4] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Message-ID: <anrQfoE8HRvsaao_@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wD3H_B+0HpqS+HkAw--.42304S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxKw1xtF4UJFyDKryxAFb_yoW8GF47pF
	93CFZ0kr4kKr45GFykJa1fJF98u34vvrWfAr1DurZrAFs0v3s7Xr4xJry0v340grWfZay5
	tF1Yv3WfWFWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uz6wtUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3R+Mf2p60H+16gAA3R

From: Hao Zhang <zhanghao1@kylinos.cn>

The I/O APIC sets remote_irr for level-triggered interrupts that have
been accepted by a local APIC and are waiting for an EOI.

ioapic_service() currently treats any non-zero return from
kvm_irq_delivery_to_apic() as successful delivery.  But
kvm_irq_delivery_to_apic() returns -1 when no destination is found.
Setting remote_irr for that failed delivery leaves the pin blocked
forever waiting for an EOI that will never be generated.

Update remote_irr only when the delivery result is positive, i.e. when
at least one local APIC accepted the interrupt.

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

