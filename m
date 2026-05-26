Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B13ACF15
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833523; cv=none; b=JGqXGKvGo4tgOKeYPxAlGVMOi9SuuwvneK07xjWOW4VOuQusHihgjve8/9McH/87b+YDTOidZpyZ7IskXm+ef7Q7cBzi/ruOeNUCXnHb2uXb6A5nhjO1wfK9Q7eGter543cunZ0S16O9L++uf/bNxc91DtWiaLVZ/Q8EKMJcFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833523; c=relaxed/simple;
	bh=QETJXtFW89YelLvPrV3cC5nYelzabIovdt1Q7yj14AM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HQE0Xpufex9wfP/C9jidzq/GQWaZayDynD+zuTf0GOWuImPm4DYuS+d3it+EQOyFOKY/QobM7+EnvdZddavURhWy9xu3jLkb6is/7L77CSveLu65G+3rn+1oaO9s7/5xViGVjcIDKfBbEY99BRCpbceggUkAbzBSxAjREyIubvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzftxEeC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzftxEeC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c935e048so6868609a12.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779833521; x=1780438321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPJ+Q5YuskHG4t4oPMj5BgcGZdJnoOYiH8MicZnv6k=;
        b=YzftxEeCgG4KlRspGIWnYsmb5a6F1Pv4XY6wxtnBEjeDLKjKxN3yzVz0G0z57Fwany
         rfjgDXwdttzawkjjELIXAKIfVd7V/6ioG7FKNNsBHnG7LTX2YSVvF2688GJOZaE72ueR
         Xrh6sbIsjBYa+YEVRjYW1LtrGxCuyaOp7uM/GqdDklvEGzI9Yb7Unx4htl+pNfwjqWY1
         8ntMcvY9CBhfFFD9Cz/usQhkH8YZmInS4kDmy1dogwkudTsLpnVzTEbn2/VYO2moppgu
         ct/d7E9RDmr+UW1V2uhxxIz6oGBnyJKwgRKBN4dV545IlqEEnaJqFQW4PqGyB+XwAm4v
         xQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833521; x=1780438321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPPJ+Q5YuskHG4t4oPMj5BgcGZdJnoOYiH8MicZnv6k=;
        b=bxFADTi7tGNJatW2eExphbL+vPCn8B/GNKiDNAoWuAJAYgIQ89dVTuMn83cdjBWZ7K
         IY/0wgEQnEYd0AG07fRr6IMqZgIUcDEzMBivVcQ/4utKBtdmnABjp4wVO+LWH3EX9JWD
         s81YTpWVFyy043Xi+CqWulDS+Su2emCmND/PRriQONxM46YEDHZM69711vgU/4C36Nfj
         O+eL9qtK62y7F21go6Scynf077ocbheU1OChOBoIU4QWcnlrcJmdmQvbQEoGJxUmWSkm
         eceWZOX621CnB/rJ0nHqYu/Lcojlspr+nIK3j7nJoBuyXNwH890A25wglxte9Xh2+0Nv
         k7EQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IqdWr/ROj+5HAoDuubnC6jAxUtlGBa27qkuA4/ZbktW2/GLaC1gLQg/bW2iRmd0g+KCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBpfw8laEQeO9mdDWc/CqcQKDhWxVtfHWMOZ6l4ixQ//TReb8
	3K6tT7otx78Gqtw2iDHvviK8C8JE2cTTgK7ZArvfktrEO5XbjnIbrhFcnPSsBLyIO9T6ToHNrBF
	MancVvw==
X-Received: from plzv4.prod.google.com ([2002:a17:902:b7c4:b0:2bd:d2c2:2776])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c3:b0:2ba:a7f4:15b0
 with SMTP id d9443c01a7336-2beb08a91a1mr193820695ad.19.1779833521237; Tue, 26
 May 2026 15:12:01 -0700 (PDT)
Date: Tue, 26 May 2026 15:12:00 -0700
In-Reply-To: <ahXs2mVqtahs7iG7@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <tencent_744B87186CA59CFD106992329A6510F7F60A@qq.com> <ahXs2mVqtahs7iG7@google.com>
Message-ID: <ahYasC7AX3yYrCLR@google.com>
Subject: Re: [PATCH] KVM: VMX: Use _safe MSR accessors in LBR handler
From: Sean Christopherson <seanjc@google.com>
To: xuanqingshi <1356292400@qq.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 26, 2026, Sean Christopherson wrote:
> On Wed, May 27, 2026, xuanqingshi wrote:
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > index 27eb76e6b6a0..94d2cbffcff4 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -293,6 +293,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
> >  {
> >  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
> >  	u32 index = msr_info->index;
> > +	int err;
> >  
> >  	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
> >  		return false;
> > @@ -309,12 +310,12 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
> >  	local_irq_disable();
> >  	if (lbr_desc->event->state == PERF_EVENT_STATE_ACTIVE) {
> >  		if (read)
> > -			rdmsrq(index, msr_info->data);
> > +			err = rdmsrq_safe(index, &msr_info->data);
> >  		else
> > -			wrmsrq(index, msr_info->data);
> > +			err = wrmsrq_safe(index, msr_info->data);
> 
> I don't love throwing a value at hardware to see what sticks, but given that KVM
> disables interception of these MSRs, it's not like there's a better option.
> 
> No need for a v2, I'll rewrite the changelog when applying.

Actually, I'll post a v2, because I think it makes sense to continue using the
"unsafe" version for RDMSR.  It should be impossible to reach this point with a
bad MSR index, i.e. we _want_ the resulting WARN if RDMSR fails.
