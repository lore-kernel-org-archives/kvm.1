Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A346AEE2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905656; cv=none; b=fsNW3lVqxLKCTh2gIGmCsE08YFcq+4bi5JMN8KCtqWafECgAEKaTD51nSRDuD01szVhYQTHTFdjEpUMUHyXFBO5Pnskfogf+AHPYgYAAvC9SD+ja3WwLqQVOQMbuj2gO3QpYM4g1V5R6LyFEzDiuPVjEW/tM+VNkZYBvjMqSY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905656; c=relaxed/simple;
	bh=VnylfXIZ70oSP2hDN4nujviqjegHcfm1jt5nW9RJes8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B7wgf05d7YwZMIj3fTPMDymqedLSneTIsvTDTBA+jpyWc3N/hAn4TdjUzNGReIQlz5eCGuwXNrdZkXPiF00dCdVe+J/wHFf8ztuEGCcIR0mzyIyjOdUN9WD46ouwZo+8IGs1xBf2vvjFMsoQlQLSl2BkzNwhPgQq/PSri/wkaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAi1TH7B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAi1TH7B"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso75186055ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905654; x=1780510454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsAS7fK21PiDroSowJOs3iMwRvwVi266gNJjjTpdxyU=;
        b=FAi1TH7BqRGO9k4gLZ4fJ0JLvYDpK0TcIPEMOrrARMX1d+7Pw4slkMWW5W3BWGYKN2
         lDELEuTH+rwxEqgrGyC4wVZ15bhJR+Eo5S9655Bmcahu1X3uynWowbd76g+T/JxQ2faM
         hTxvs2sfDFVXpPOcZu46V1ovYuo4o1NMiWxuNtHeYrEDKnOdlgEf5hmYokDo0mbFKgL4
         qyrDk4Gb8TdhqxTlQ/WRWqk/eCLTFkF44f3vNN07FGHZDGrCc8fzUXRXGQff+7PQ/7Lf
         UTrotfs3AhRSaefsaqVAhmTS49rX+SZ0deGnHGc32eV5uCsTNM0e7eo4bo2ckXC/lSVQ
         17VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905654; x=1780510454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsAS7fK21PiDroSowJOs3iMwRvwVi266gNJjjTpdxyU=;
        b=Jx3FE5TCGMEruISXFanz/yLgh4nGsgPZPFC+5RVKppmdGzinTrcRT2YhcsLzAXehjS
         P0ejNWqZQAtlmaqp1W6JkQ/BcG1a20IuBj4ylm59XZfuQen4rFrJJ6MmLPGJ+D0kNgop
         iinLul9Fe7LPivuSFIyVU1B0/LQ/6SY40ViTvQ3NZ1OF4aFZWL50Gndj08X7NIc6+T2M
         KEESFu+Dw09DP0ate1AuXINFhROxPgW3p035ZSkE0lSEzb70zm4/fhtZ1PEZP45QcnEL
         LBVcLxSxMKGudciH8q2e0YhY4ht3fbiPPeXsypfXbIP7i+kgQGRCEVveGmtAsCPh3hjI
         LdwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6DL5LnFiIuX/JcjjVglNbAOFbSLliJL1hIx5jh/+QsUpPANnjfW4eWsSDbEMoa/cqBSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNovRS+V72/7fqCH2C1QQPvpxudK15CPNMulstAjAjY547qANJ
	GRVE1kLN2I76ezC0tbTO240UYLi/zsiKC+6aI9NYb8r8d9sS5l/fAp8YYWtX77XKBf0hy28aZ91
	1DVD0nw==
X-Received: from pllj9.prod.google.com ([2002:a17:902:7589:b0:2ba:f5a6:38db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1247:b0:2bd:c5f8:504f
 with SMTP id d9443c01a7336-2beb0702144mr255121925ad.40.1779905654395; Wed, 27
 May 2026 11:14:14 -0700 (PDT)
Date: Wed, 27 May 2026 11:14:13 -0700
In-Reply-To: <CAO9r8zMGwUszi1xvi4WU1M85ZZWTDTfbQacjBfNDw8+QS4WDOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-4-seanjc@google.com>
 <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com>
 <ahXp9V3o0bWVi1lj@google.com> <CAO9r8zMGwUszi1xvi4WU1M85ZZWTDTfbQacjBfNDw8+QS4WDOw@mail.gmail.com>
Message-ID: <ahc0dRxHXMqOK-D5@google.com>
Subject: Re: [PATCH v4 3/5] KVM: SVM: Fix nested NPF injection of
 PFERR_GUEST_{PAGE,FINAL}_MASK bits
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 26, 2026, Yosry Ahmed wrote:
> > > > +       vmcb->control.exit_code = SVM_EXIT_NPF;
> > > > +       vmcb->control.exit_info_1 = fault_stage |
> > > > +                                   (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
> > >
> > > Do we need to do this in the common path?
> >
> > What do you mean by "this"?  Pulling flags from fault->error_code?
> 
> Yes, sorry if that wasn't clear.
> 
> >
> > > If from_hardware=true, can the fault injected by KVM have different flags
> > > from the one produced by hardware?
> >
> > Flags, yes.  fault_stage, no.
> 
> Right, I meant the flags.
> 
> >
> > > I guess the answer is yes, (e.g. if KVM is doing write-protection?). Might be
> > > worth a comment.
> >
> > Or if L1 has modified its TDP PTEs in memory, but hasn't yet flushed TLBs.  In
> > that case, KVM's software walker can see the updated PTEs, while hardware may
> > have seen something else.
> 
> Makes sense. A comment would be helpful for laymans like myself.

I elected to not add a comment for now, because I'm not 100% confident the nSVM
code is correct, and so didn't want to stealth in a comment that wasn't correct
either.  It's certainly much better than it was, but especially with GMET in play,
I need to stare more to convince myself it handles all the edge cases correctly.
