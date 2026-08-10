Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285EE3A453B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354824; cv=none; b=BwnrdKNy0YE9OqtASp+TIdPZOgUbkci1fWJAUhZ4LQkQCTNzx0fe3Me6sDCc1NgKTPoUc/b64BcGc8Ilf+8SMhCJZMHqw7ocNm6f7/f2BM6WYNfhnO/wd6LKRtpAwOjy7IVv6YKY7iAwC1ChNckdN1TO/PcHrnyOSeUlezkJ8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354824; c=relaxed/simple;
	bh=gi/ygQMt45pvXCcJDJGdyVjI7ItQbNXJ/zqxcguegyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDdhz7DWvtcuKqA+D7MmVaIVXaJkYvhyUtUXM1vk/br4uYXapJzDuPvYdLleOHEdAs2RyYpPBaZOZO0esQQ05sR+wVJA1VO6Lprvk8xDhSTYs+WPz8xfF7CvVr4ggMIBhPYqmEVDlexgk8lpnOzNTgrYsZ1OpnfF/UVyAAHaMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nEKPYyZD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nEKPYyZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+Bu5kSPYEwcQxlkao6p+FiE4TVKyW/3rl5PRQB3B+nM=;
	b=nEKPYyZDrMVnQFJQrPuDiOOG/9M3mEhP+AGPZUZcqwC1Gi6Jld4T9r1EQZ5LfR
	gR6Rh8d+5+Xtnq5a7ykZyFBsJnfQnmOQVI6aXYaNSFWmPf6Iw93ibOEmJLEiy9NS
	pPE2LeFbgIDBp7+jJlzGWvUPf23pduckCmKlvKn1H9LYg=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3PwtpnHlqo6LRNA--.3051S2;
	Mon, 10 Aug 2026 17:39:53 +0800 (CST)
Date: Mon, 10 Aug 2026 17:39:53 +0800
From: "hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>,
	"hao_zhang_kdev@163.com" <hao_zhang_kdev@163.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Update state only after successful
 delivery
Message-ID: <anmcaTppVBo-AZQM@192.168.1.215>
References: <anls-aUppuiFolpS@192.168.1.215>
 <c9193d0a13e39fc385699772ba58b457e41ccbac.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9193d0a13e39fc385699772ba58b457e41ccbac.camel@intel.com>
X-CM-TRANSID:_____wD3PwtpnHlqo6LRNA--.3051S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCryfAFW3ZF43AF1UAw18Xwb_yoW7Gr4fpa
	yUCa9xur4kJr1xGFs2ya10yFy5C3s5Jr45C34DC343J3909rn2qF1ktrW8Wa4DWrWrCa1j
	vr1Yq343Wa4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjfOOUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+Qw7Lmp5nGy4LQAA3W

On Mon, Aug 10, 2026, Huang, Kai wrote:
> On Mon, 2026-08-10 at 14:17 +0800, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > The I/O APIC tracks delivered interrupts in state that is later used to
> > decide whether an interrupt is still pending or blocked waiting for an
> > EOI.
> > 
> > For level-triggered interrupts, remote_irr means that a local APIC
> > accepted the interrupt and that the I/O APIC must wait for the
> > corresponding EOI before delivering the interrupt again.  For
> > edge-triggered interrupts, irr_delivered is used to hide delivered
> > interrupts from KVM_GET_IRQCHIP so that userspace does not reinject an
> > interrupt that has already left the I/O APIC.
> > 
> > But ioapic_service() currently updates that state before or without
> > checking that interrupt delivery actually succeeded.
> > kvm_irq_delivery_to_apic() can return -1 when no destination is found.
> > Treating failed delivery as success can either leave a level-triggered
> > pin blocked forever waiting for an EOI that will never be generated, or
> > cause KVM_GET_IRQCHIP to drop an undelivered edge-triggered interrupt
> > from the saved IRR state.
> > 
> > Update I/O APIC delivery state only when the delivery result is positive,
> > i.e. when at least one local APIC accepted the interrupt.
> > 
> > Fixes: 4925663a079c ("KVM: Report IRQ injection status to userspace.")
> > Fixes: 5bda6eed2e36 ("KVM: ioapic: Record edge-triggered interrupts delivery status")
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> > Changes in v2:
> >  - Address Kai Huang's review by deferring both remote_irr and
> >    irr_delivered updates until interrupt delivery succeeds.
> >  - Extend the selftest to cover failed edge-triggered delivery and verify
> >    that the interrupt remains pending in IRR.
> > 
> > Link to v1: https://lore.kernel.org/all/anSOdijwS6LBbfYJ@192.168.1.215/
> > 
> >  arch/x86/kvm/ioapic.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index 757667fb2bfa..540e5665fbe4 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -474,9 +474,6 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
> >  	irqe.shorthand = APIC_DEST_NOSHORT;
> >  	irqe.msi_redir_hint = false;
> >  
> > -	if (irqe.trig_mode == IOAPIC_EDGE_TRIG)
> > -		ioapic->irr_delivered |= 1 << irq;
> > -
> >  	if (irq == RTC_GSI && line_status) {
> >  		/*
> >  		 * pending_eoi cannot ever become negative (see
> > @@ -491,8 +488,12 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
> >  	} else
> >  		ret = kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe);
> >  
> > -	if (ret && irqe.trig_mode == IOAPIC_LEVEL_TRIG)
> > -		entry->fields.remote_irr = 1;
> > +	if (ret > 0) {
> > +		if (irqe.trig_mode == IOAPIC_EDGE_TRIG)
> > +			ioapic->irr_delivered |= 1 << irq;
> > +		else if (irqe.trig_mode == IOAPIC_LEVEL_TRIG)
> > +			entry->fields.remote_irr = 1;
> > +	}
> > 
> 
> Ah looking at this I immediately realized I misread the code, that I thought the
> irr_delivered was for level triggered as well, but actually it is for edge
> triggered.  I guess we both got it wrong :-)
> 
> For edge triggered IRQ the existing code is correct I believe, since once the
> function is called the IRQ is considered delivered no matter whether it is
> actually accepted by LAPIC.  I think this exactly reflects the hardware
> behaviour.  (In fact, in ioapic_set_irq() you can see the IRQ is removed from
> irr_delivered for edge triggered right before ioapic_service() is called.)
> 
> For level triggered, I don't see ioapic->irr is cleared by KVM, but only cleared
> when ioapic_set_irq() is called with irq_level == 0.  I now (AFAICT) realize it
> is the right behaviour since it should be the driver which dessert the level to
> stop the level-triggered IRQ.
> 
> So in short, I think your v1 is correct, and sorry about my noise. :-(

Thanks Kai,

I checked the Intel I/O APIC redirection table documentation(https://edc.intel.com/content/www/it/it/design/products-and-solutions/processors-and-chipsets/comet-lake-u/intel-400-series-chipset-on-package-platform-controller-hub-register-database/1.2/redirection-table-entry-0-rte0-offset-10/).  
The Remote IRR bit is defined for level-triggered interrupts; for edge-triggered
interrupts its meaning is undefined. So yes, treating irr_delivered like
remote_irr was wrong.

For edge-triggered interrupts, once the I/O APIC starts delivering the
interrupt, the interrupt should no longer be considered pending in the I/O
APIC state that is saved through KVM_GET_IRQCHIP, regardless of whether a
local APIC eventually accepts it.

So I agree that v2 went too far by moving the irr_delivered update behind
the delivery result check.  I will drop that part and restore the patch to
only fix the level-triggered remote_irr case.

Thanks,
Hao

