Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66A5464C
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786325996; cv=none; b=pVIfqAkIAo9VX8n3jqT1+bxP33xW3JPnq26IUjPIRArJHI5d1MMzbHULnZ1fZfXV+MVL7VqhUidn7A2zrM1FcBnH/UZbBqtbj+3UU6m7LdCgkuCvbc2CfCsrkzpabq4Tw2d0A0pIYp2qkOZ5sZNxKwFdzKRNAa58d9U0QPtWg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786325996; c=relaxed/simple;
	bh=Ykz0PEP+2N1iUqqXtupamyn7XDb77nM9wCVUSgxqsWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtNKpe3vEWSZwcW4ZPtqTG9bA16YBsvSg35sc9nQMgojXketI5k3AWrCcO9ewPPsC02P+4011jA/MuinEowTavLQBjD7B9tFYeZhNBdpCis2T29zt8P2S4PbiWLAbHk16NWiWs12lDadRtgJgiwtWOJLAzyPkre1YPEbKa0U98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dq5Xlvs3; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dq5Xlvs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=S+3HhaAbfNoECCQfR6hQhtR98DFlLT0x+x/aZ1Hoj/g=;
	b=dq5Xlvs33+C8DU8N2JFRrY7QIijZdOfea2ixbBNZHaHMB3v37tNrKgccr5+MTb
	CrDhrm4vCTKdwbQQi34eCSS37Fd7KndeLpwYyokta0KK7OuLXwugCMNtTRCs4+Tg
	Sh160GpLajVAzhqC6s/GMkog6JrE8+88wrIu8WNM8mScQ=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHBKPMK3lqi8JTOw--.712S2;
	Mon, 10 Aug 2026 09:39:24 +0800 (CST)
Date: Mon, 10 Aug 2026 09:39:23 +0800
From: "hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
	"hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Set remote_irr only after
 successful delivery
Message-ID: <ankry_2y4dqWPTz3@192.168.1.215>
References: <anSOdijwS6LBbfYJ@192.168.1.215>
 <51b48f462c1a3005f5f45895af9ea5b9f213b41e.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51b48f462c1a3005f5f45895af9ea5b9f213b41e.camel@intel.com>
X-CM-TRANSID:_____wDHBKPMK3lqi8JTOw--.712S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW8Jr4xur1fCrWxXw1DWrg_yoW5CF4kpF
	WxCayqkr4kJry8WFykta1rJFyYk34vyr43Cr1Dur9rAws0g34vqFs3CrW8ua48ZrW8C3WF
	y3W5t34fGa4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRWq2XUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+Qz26Wp5K8wYuAAA3+

On Fri, Aug 07, 2026, Huang, Kai wrote:
> On Thu, 2026-08-06 at 21:39 +0800, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > The I/O APIC sets remote_irr for level-triggered interrupts to track that
> > the interrupt has been accepted by a local APIC and that the I/O APIC must
> > wait for the corresponding EOI before delivering the interrupt again.
> > 
> > But ioapic_service() currently sets remote_irr for any non-zero return
> > from kvm_irq_delivery_to_apic(). The delivery helper can return -1 when
> > no destination is found. Treating -1 as success causes KVM to set
> > remote_irr even though no interrupt was delivered and no EOI will ever
> > be generated, leaving the pin blocked.
> > 
> > Set remote_irr only when the delivery result is positive, i.e. when at
> > least one local APIC accepted the interrupt.
> > 
> > Fixes: 4925663a079c ("KVM: Report IRQ injection status to userspace.")
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> >  arch/x86/kvm/ioapic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index 757667fb2bfa..24a7cc3b8b7e 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -491,7 +491,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
> >  	} else
> >  		ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
> >  
> > -	if (ret && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
> > +	if (ret > 0 && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
> >  		entry->fields.remote_irr = 1;
> >  
> >  	return ret;
> > 
> > base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
> 
> This seems reasonable to me.  Just wondering did you meet any real bug?
>

I didn't hit this from a production workload; I found it while testing the
failed-delivery path. But the state corruption is guest/userspace visible,
especially across KVM_GET_IRQCHIP/KVM_SET_IRQCHIP.

> Btw, currently the IRQ is set to irr_delivered for level-triggered IRQ
> regardless of the return value of kvm_irq_delivery_to_apic():
> 
>         if (irqe.trig_mode == IOAPIC_EDGE_TRIG)                                
>                 ioapic->irr_delivered |= 1 << irq;           
> 
>         if (irq == RTC_GSI && line_status) {                                   
> 		...                                                                          
>         } else                                                                 
>                 ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
> 
> 	...
> 
> Similarly, should this only be done when kvm_irq_delivery_to_apic() returns
> positive?
> 
> E.g., kvm_get_ioapic() clears the bits in irr_delivered, so if one IRQ is set in
> it but actually not accepted by LAPIC then kvm_get_ioapic() will not return such
> IRQ in irr, therefore it can potentially be lost?
> 
> 

Thanks, yes, I think you're right. irr_delivered has the same problem for
edge-triggered interrupts: it is used to hide delivered edge IRQs from
KVM_GET_IRQCHIP, but currently it is set before knowing whether delivery
actually succeeded. If delivery fails, KVM_GET_IRQCHIP can incorrectly
drop the pending IRR bit.

I'll send a v2 that gates both remote_irr and irr_delivered on ret > 0, and
extend the selftest to cover the edge-triggered irr_delivered case too.

Thanks,
Hao

