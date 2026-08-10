Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD7403B14
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374866; cv=none; b=FZ4XG/752uSHPYNxK+VQLN3OtRxrJLk+5wrneTVhrD4s8RIt9VcBiA/rb8dq6KeDJ3SqGeK/PHj2nezwrF+1ZUYwWWSd2MmLaKiFuERSwXbGAsh52WJrsBhfrA3VrKV4mvmVcdoVBGwY0ijuFNGS1JIufBQZjyVNj01td2mXIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374866; c=relaxed/simple;
	bh=BCijcyc2YON9Qun6yhjuU9sJdVm13vfOtl6wh60ohao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYtqhzoB+F8I0rvFaP3vjR3/j84jQ1YAsfgL1/MioD2MhsUWSH248hNzO/58i82G13sNtmtnuLe0mnYJqvWEQYhUwSlDhsthj08DF1+ObMrtxy13vz8y5Blihxh4n+8leuGeM/G943NL9XKEx3vrq39y4JQ2mjWpUddq4isFsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MAG8LTbw; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MAG8LTbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=knco2wL0PAROi7VA9hpFL4U53D68U96cTEPJr5RB/HI=;
	b=MAG8LTbwQDFdYLqbdrlxyv9BAl+mh6PRekJw4ciyhlMIDq7EhhoyDozld63Edl
	94+FWRpzJhCuTK5cJqSMMVSFq27DRlJld0tdWW46eh3ObbEDOEDwTqTefNHa2BDj
	6YYXNjmbegDf3xUG1i0A07xQcGXXSQWfpcL79whrcCdmE=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCnEJOX6nlq9lb4NA--.8543S2;
	Mon, 10 Aug 2026 23:13:28 +0800 (CST)
Date: Mon, 10 Aug 2026 23:13:26 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: "seanjc@google.com" <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v3 1/3] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Message-ID: <annqlqBOOGIQJ7sY@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wCnEJOX6nlq9lb4NA--.8543S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxKw1xtF4UJFyDKryxAFb_yoW8GF47pF
	93CFZ0kr4kKr45GFykJa1fJF98u34vvrWfAr1DurZrAFs0v3s7Xr4xJry0v340grWfZay5
	tF1Yv3WfWFWUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UrrchUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3RjZzGp56pgQeQAA3Y

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

