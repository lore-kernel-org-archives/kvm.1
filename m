Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870734D4CE
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976370; cv=none; b=brdKHClmaGwTSl79nHvmhPowUocLCQm1l7ro/BPFkHwrNPohlQkRHlklXbei8mCnlIhlYRYvp61N/R3ZF5ZLElLNUH+hA3UkP47d2a6IcHf7VdMCE1prQlG9rB3nk0g0JLt3YhXqOmtnBickChQTOj2CQyalGPLoeZg+A1GfwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976370; c=relaxed/simple;
	bh=GWnMX23x2XJamjEwXapRQWJTaV9cITtaYuSlJICbUf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uw1UleewhxPm+DG7056k9TAOZ/hN1QbKvIy8/k8AzWMVUZmgMJHZYq81nG9IG+EnpzeRphTwb30QOSv95b1zQ19Tka9ann8xuQ3jiKxxWzp+P5AxFZgsG91cyNWw00CPdZUpuFQaZqAPj44x8W/zWYiuecGCtXEDg3hP4GuzSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPiq7qaD; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPiq7qaD"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1805338b3a.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785976369; x=1786581169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCfHIzte5uq5pyTPXcfl2qziYgmEa+5fHjm4eKgk5qg=;
        b=jPiq7qaDe0a30V2Qg89Gn36iNUPlRi1XEYyRYH1K0Dr4l7Tub+nWn6OeUzloOgXuW5
         amTxzsEgejFZDh8uM9Udje6ZI2346bufIP2McFHBtmbeodkdqBA9qu+YR3LbtDRBMLxQ
         dpwf439DoK6gM8gEmdTJQ5FdpH3ffN5vFQYUQPK6wuaOTNls8mkMbt9IYHHSMTIqMGPn
         IjiQbVIxHH0v8GRLOidFpzAIiJzIft0Emd2WpjRxU3E7kVDk4lphND2gUS7TccWdCZhn
         2+6GiOWgDaiBmgoZFdBBkppoKIYtjRR0Fqctn7yqP2bzGuisRerJHwwpe/rC6Qp1gCqy
         CEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785976369; x=1786581169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCfHIzte5uq5pyTPXcfl2qziYgmEa+5fHjm4eKgk5qg=;
        b=iAKThQytiWEISThZpYJ/CgwA+RpgvGvjdb9eq6UWhd/K1rm81vbMPRB1Gg1hm4ve2g
         BT8oEUkw5P3FD+sHAeOu72gwy19mmrJk3LwcfuFyJQTCHrc7l1+8Dc+pu3155sOIgHLO
         2OQsH8JSEZ7ZizLhtLgWoGzkNev/U0WG9UPrh8G6FZm2kNf81cXRDiX9ZhASVm+sJ6Ej
         HAuR/5N29KAyPm1tRkfw4GQooO+aNlSmlIi0tkN/yxiPqeJK/atAjNzfNx/wvSYIdly9
         h7pRcvguR83bDA8bOyNhft7wZWPzffd5+TTNwxPnIF7tHi5WjyI23yAnwjHtkyjkcRpt
         60sA==
X-Forwarded-Encrypted: i=1; AHgh+RowuAFL4zphjjdPbQMzRrTE72OK1Xzg96zTN0+pTJK4ud6iZ2rHgPQPwkN4SWTxFN918YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgfLGsUBQ9VjrCeoUnz5sxY7oBxDMc+3h+b6C2hIKPaj8wCrk
	54zNtW1yPsoO7UMRTx/DHt6Pv8LukDAFi2ZVLJ4vc5JPfs07wm6bc1/b6BVhLiHpySeLXmJrOAL
	9Gx7+1Q==
X-Received: from pfaw13.prod.google.com ([2002:a05:6a00:ab8d:b0:848:4460:aed3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2441:b0:848:7731:d95a
 with SMTP id d2e1a72fcca58-84f2e1520admr11621536b3a.37.1785976368449; Wed, 05
 Aug 2026 17:32:48 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:32:47 -0700
In-Reply-To: <86cxvxar8w.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717162658.2833515-1-jingzhangos@google.com>
 <amh6OLH38hsO7ZWj@google.com> <CAAdAUtjrnNe1Kn2_Fqtjy6igEEca-6Zd=SSbncswZtnA5FngPA@mail.gmail.com>
 <anLz0HJ9CKuRbTPh@google.com> <86cxvxar8w.wl-maz@kernel.org>
Message-ID: <anPWL-6TBGreqL3j@google.com>
Subject: Re: [RFC] KVM: Proposed uAPI for querying GSI and irqbypass status
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Jing Zhang <jingzhangos@google.com>, Mostafa Saleh <smostafa@google.com>, 
	KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mingwei Zhang <mizhang@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 05, 2026, Marc Zyngier wrote:
> On Wed, 05 Aug 2026 09:26:56 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
> > 
> > Hi Jing,
> > 
> > On Fri, Jul 31, 2026 at 10:26:26AM -0700, Jing Zhang wrote:
> 
> [drop the LLM generated stuff]
> 
> > > While interfaces in debugfs are fantastic for manual, retroactive
> > > debugging on a developer workstation, they are not Dependable for
> > > fleet-wide observability. This RFC aims to provide a proactive
> > > monitoring solution that aligns KVM with production operational
> > > requirements across architectures (both ARM and x86).
> > > 
> > > Would love to hear your thoughts on this perspective.
> > 
> > I agree that debugfs is not suitable for that purpose.
> > 
> > My main concerns are:
> > 1- Why is /proc/interrupts not enough, it should show whether the
> > interrupts are going through the host (not bypassed) and it should
> > show when the host get a doorbell if the vCPU was not resident.
> 
> This.
> 
> Also, there is a very long standing ask to represent the output of
> /proc/interrupts as a structured set, retrieved through a generic
> kernel interface. I.e. *not* something KVM specific.

+1 to not making this level of detail KVM specific.  Ideally, I'd want more than
what /proc/interrupts offers, e.g. it'd be nice to capture what "mode" an IRQ is
configured for (normal/remapped, IRQ bypass, x86's posted MSI, etc.).  But that's
an argument for extending /proc/irq and/or providing structured output of _that_,
not for throwing something into KVM.
