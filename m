Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BF3624BC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607561; cv=none; b=ZArj3efCcE3gKe7w/jL4dG7QuybKxLkBOi7oLEdFE0Fey1jS9CNYiQU0Ybrs9zly3hTxiMW5wILAW8HUCftNhzipllhDXilxQMZ9q2cHPIXd7OwrGbzZbknrNMCS+rUBBYmfboYXA8sN1Lz91VeMvbQTtsAXPoqxbFiFSLGeG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607561; c=relaxed/simple;
	bh=6dNjUosCEpzrpS3GJZWzdRapyh27SgAfMK3gEEMFVsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq9XQOi9n9UEtxTjjMa5wJTF7H7oqZwf0/STlXY6sdpo6HuhGt5NtC5PoZ9RmMvZMATOKmIIh3Lnb3c8D2nMezqsn3sZ4x3vwtpgzz/BaJV/x29bt8r5Cpq1ghD+fSZv2kG1ViQPZalnpS5ThCZ23YGsOm4QH/cUfhp6opedUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZOW6PBnn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZOW6PBnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UP0Dk5UtVLP5SgK5sD3o3vm0tvtuULiXOnAHRgsOwTk=;
	b=ZOW6PBnnqYpTMhjaGr4emvub4g6irtLk2A1Q5NZII9lpdxtgQzXLg2Y47tMOyy
	k8Ms8ow9etS/cGOOHDEfJ7C5YjOUDrSbUBnt6xmjJ3SX6C1DQgns+EoBr1co/4sR
	wZNxf2Bq3KrVdX3yQyiGWT694wxujrF3DUjMagmBVi31s=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXNiqxd31qrq9nMA--.8857S2;
	Thu, 13 Aug 2026 15:52:18 +0800 (CST)
Date: Thu, 13 Aug 2026 15:52:17 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: sashiko-reviews@lists.linux.dev
Cc: Hao Zhang <hao_zhang_kdev@163.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for
 duplicate edge interrupts
Message-ID: <an13sYh4gCyGbMZc@192.168.1.215>
References: <anwwV80QWHxemrWS@192.168.1.215>
 <20260812085229.4EA541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812085229.4EA541F000E9@smtp.kernel.org>
X-CM-TRANSID:PygvCgDXNiqxd31qrq9nMA--.8857S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDZw4xJF1fur1kXry5Arb_yoW5KFyfpr
	Z0k3Z09rWkJr1rGF9rZa18XF9xuwn8Jr15C3yDC3y8Xw15KryvqrZ2yrW0qa4rCrWrCa17
	tr1rJ34rWrWkAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUtPEfUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hQF92p9d7SvwwAA3A

On Wed, Aug 12, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] KVM's IOAPIC fails to latch edge-triggered interrupts if they pulse while the pin is masked, and fails to deliver latched edge-triggered interrupts upon unmasking.
> --
> 
> --- Patch [3]: [PATCH v5 3/6] KVM: x86: ioapic: Preserve irr_delivered for duplicate edge interrupts ---
> commit 691f4f74cce4e2c3436bc9f3cdf594c985c284e3
> Author: Hao Zhang <zhanghao1@kylinos.cn>
> 
> KVM: x86: ioapic: Preserve irr_delivered for duplicate edge interrupts
> 
> For edge-triggered interrupts, ioapic_set_irq() clears irr_delivered before
> checking whether the new edge is a duplicate. This patch moves the state
> update after the duplicate-edge check to prevent duplicate edges from making
> a delivered interrupt appear pending during VM migration.
> 
> > diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
> > index 24a7cc3b8b7ef..676effd674f9e 100644
> > --- a/arch/x86/kvm/ioapic.c
> > +++ b/arch/x86/kvm/ioapic.c
> > @@ -230,11 +230,11 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing
> ioapic_set_irq(), does KVM fail to latch edge-triggered interrupts if they
> pulse while the pin is masked?
>
> Earlier in ioapic_set_irq(), the IRR bit is cleared unconditionally when the
> pin goes low:
> 
> 	if (!irq_level) {
> 		ioapic->irr &= ~mask;
> 		ret = 1;
> 		goto out;
> 	}
> 
> This appears to destroy the latch state for edge-triggered interrupts that
> were not yet delivered.
> 
> Furthermore, looking at ioapic_write_indirect(), when unmasking, pending
> interrupt injection is restricted only to level-triggered interrupts:
> 
> 		if (e->fields.trig_mode == IOAPIC_LEVEL_TRIG &&
> 		    ioapic->irr & (1 << index) && !e->fields.mask && !e->fields.remote_irr) {
> 
> Could this sequence cause latched edge-triggered interrupts to be silently
> ignored and lost if a guest temporarily masks IOAPIC pins during interrupt
> handling?
>

Sashiko seems to assume that an edge-triggered interrupt which is signaled
while the IOAPIC RTE is masked must remain latched and then be delivered when
the RTE is unmasked.

However, the Intel 82093AA I/O Advanced Programmable Interrupt Controller datasheet
(https://pdos.csail.mit.edu/6.828/2018/readings/ia32/ioapic.pdf) states that 
edge-sensitive interrupts signaled on a masked interrupt pin are ignored, 
i.e. they are not delivered or held pending.

KVM's userspace ABI (https://www.kernel.org/doc/html/v6.12/virt/kvm/api.html#kvm-irq-line) 
also represents an edge interrupt as a pulse, by asserting the line and then deasserting 
it. If that complete pulse occurs while the RTE is masked, there is no pending edge that 
needs to be delivered on unmask.

This is also separate from this patch. The patch only preserves irr_delivered
for a duplicate edge interrupt that is coalesced after a previous edge has
already been delivered, so that KVM_GET_IRQCHIP does not expose the delivered
edge interrupt as pending.

> >  	old_irr = ioapic->irr;
> >  	ioapic->irr |= mask;
> >  	if (edge) {
> > -		ioapic->irr_delivered &= ~mask;
> >  		if (old_irr == ioapic->irr) {
> >  			ret = 0;
> >  			goto out;
> >  		}
> > +		ioapic->irr_delivered &= ~mask;
> >  	}
> >  
> >  	ret = ioapic_service(ioapic, irq, line_status);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/anwugm-oU0v1VM-t@192.168.1.215?part=3

