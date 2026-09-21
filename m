Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D1488DB6
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034394; cv=none; b=nt9v9VvsRy2F5PowYsCQ1Kdn+D0O5JWIFInP8j6i1lcmz5i8JtgGIaDutM5ZgLWcLZPQ03DL7FqdEn3s5bAKnzg8ZuBpxmKMwXgwcLb5ENkblj42qKsvsBfMk9Z6IN2Jz8iAKuhUf9BhF19i7X1LiBrZuemxjA7zqtHITQ3rnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034394; c=relaxed/simple;
	bh=40F1RAle8xpGOeW96UB300PYIJoZdR8AaAbR6LOUsZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5Ky0hfPnlKru4EvjoU+Y1fX/fwUrp4mni/ALYaPkdPVVWENC/CTjcWOWJ0exovNqnLAXL0oVGQ62qSGFUS0DHmdzarJqFYOgNo12zJqTs7civLRpIlzKUBqjAucD94C/yKbe4y7YAYBvEfUaHt1k+nrX+2iynOmLzYUl2+tfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlwMVPOK; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlwMVPOK"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so2776990a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790034390; x=1790639190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXZS6wRa+Ih1M51x+2eSNxggnZ1Bmi1BzYCR37D9wnE=;
        b=nlwMVPOKccY0woEmPlufegeAfKsU97W8uaJT9ECPQVlJ00uJaRCSpQByEwV5B9tO48
         xMMjEwrIF0wZrtFstpgLQZw6DSShd0vg40KA/pKX5RfOX1Ef2i/E5IqHnpBo3xMJDU/h
         /X9fm0wt6RkjKOKpMWeBKITPPWbTldcRC5HTS94C87BghZAfs1HBdggmYCMeyJaByK39
         tzr1WLUKPqYhpXqvaoxEEUasTrYjHxVaInB/NIC1yHxNcJD9afwDE0x0vcKQZ/6ADA+s
         vnlBpy7xoY/KXhRkrauL1u4dLO4daN+XIDc27wIwJCpsijbXmwvuqyq8AA20gX7/lJbt
         /JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034390; x=1790639190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXZS6wRa+Ih1M51x+2eSNxggnZ1Bmi1BzYCR37D9wnE=;
        b=0axi4jgp1O+Wj6F+Cq712KduGQVXebKNpbab1/+IYDdUhpI6SYe4grH5iPnmDOLo/F
         BAbTeiS+obPrAKnMNVGtP5hixSda/el5HOtplstw0u3Z1Kn6SiYJn9LRsnEgcNukiUn9
         RXMTMZ9gyMDotbBx1Fh4+Mq7LcGMji9bJcgZ7PX0549BgUdXDUfTdIiwUhdORws6xzSp
         /Ctx0A8hQX16drvys1FVa/dI2t95DRW0QVgvAaFHg5hQ+ezqQSWhbWNRGVwuUI+tP3G6
         GnKkPoiybgmDmDxPXBoqERExDENIKSK1pQmQyJIBmJdGDzb75BQMa6tgL7Gd5PVyKqay
         FhNg==
X-Forwarded-Encrypted: i=1; AKwUvBxU9m2vLtAWkowmnOTvNDKaxEyrQt2OFAEZm96BDLrqBcc98x/g1qX31O1307CPYE9Yc+U=@vger.kernel.org
X-Gm-Message-State: AFuF++kGH0urlM/duNKzCf1bQ0vmxkziILgqvDwRaMhuymFMV0wGbm9V
	b2EyKiVhNC3e1wLNL/SIEe2DDkP5CtGhQMNNWeIq611mEjx+IY/P/3ZMUjNEzfqsgUBACPMAcTN
	xtpJm0w==
X-Received: from pgei10.prod.google.com ([2002:a05:6a02:526a:b0:cc4:3178:f54f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:8053:b0:3dd:a008:dc42
 with SMTP id adf61e73a8af0-3dda008e1b9mr11530455637.48.1790034390008; Mon, 21
 Sep 2026 16:46:30 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:46:29 -0700
In-Reply-To: <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
 <arG7delLjerkKbYQ@google.com> <2df88806-4583-4bf8-b699-43eb6217399b@intel.com>
Message-ID: <arHB1SACk4Z9kJq3@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, Dave Hansen wrote:
> On 9/21/26 16:19, Sean Christopherson wrote:
> > On Mon, Sep 21, 2026, Dave Hansen wrote:
> >> On 9/18/26 14:32, Sean Christopherson wrote:
> >>> By creating these system-wide thread pools, TDX has effectively created a bizarre
> >>> M:N scheduling problem, *and* introduced a completely avoidable noisy-neighbor
> >>> problem.
> >> To be honest, I just want to chop all of the complexity out of this.
> >>
> >> I want to assume that the TDX module can do one quote at a time. If that
> >> quote takes too long, software kills it and lets the next guy do a quote.
> >>
> >> I don't even want to know that the TDX module *can* have 1 or 10 or 100
> >> quoting threads. I just want one which I can make sane rules around
> >> because 1 is *FINE*.
> > I'm not remotely convinced one per system is fine.  I'm all for one per VM, but
> > I'm pretty sure the SEAMCALL alone will have a measurable performance impact,
> > especially when factoring in that it will require a VMCS shootdown to do VMCLEAR
> > on the previous pCPU.  Mix in a few (tens of?) thousand more cycles, and any use
> > case that's trying to boot a decent number of TDX guests in parallel will be sad.
> 
> Sad, but way less sad than the folks who decided to offload their
> quoting to an Arduino attached over a fancy serial port. ;)
> 
> I do think we can _start_ with one. One needs no ABI and no policy bike
> shedding. If my crystal ball is right, we can stop there. If yours is
> right, then we can go build the stuff we need to make it scale.

My preference *was* to not have to find out, because those types of scaling issues
tend to lead to a mad scramble and angry customers.  But...

> Oh, and folks can _theoretically_ do one quoting instance per VM. But I
> think the overhead per quoting instance is in 100MB ballpark. 

MB with an M!?!?!  What!?!?   How?  I was assuming my 32KiB threshold was fairly
conservative; what is the TDX Module doing that it needs 100MiB?  That's insane.
That's literally 3x the footprint of some full-blown VMMs.

If it really is 100MiB per instance, that definitely changes things.  I'm much
more willing to roll the dice and hope quoting is never a bottleneck in practice
if it means saving 100MiB per VM.  Yeesh.

> So a bit rotund to be per-TD in practice.

LOL, yeah, a "bit".
