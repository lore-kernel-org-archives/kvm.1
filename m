Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6C3D7D7C
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443531; cv=none; b=pAXmkAVYsw8XpkG/sWWAWyF9wTnYwj/ZVPglmLOqiytF0rRgePXPA/b2O+OsSovQUMB85dV+0cb/Y0wEl8Owhx1rsAIcVm1vCxnVKvfu7OOH/CaqqpAhJXXB0j4ztnzZ5jEozIurQvUjINZeT4oKhgpGjOtwPkZEh5Fk2PLrf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443531; c=relaxed/simple;
	bh=BZDtYZD9PUek5ZaX74h0JCPz2wKWkLKfnILf2CsZb/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPLl2sG7gWoH5ja+QvEVVDustpnDp4QQhBmryMwcPLdyJzp7lnCYHI7dQQKoEIXLzhozXuyLJ5UqfW5eck0ldfNakKdGjrOKS0cBGbMoGLcQYLg2G4wlr/0YmIzkVYLXcB1BjxnzYqGXpj+YXDS4Yz6syGJ5cO9xa/rdrLN9Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jd+9Sd0T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jd+9Sd0T"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3e462daeso17236025ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773443530; x=1774048330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Glzf1lRkoTqWUXidwriDm/Hu7F3CSuXg4RCxnpqKPlg=;
        b=Jd+9Sd0TR8Ahl4gwnxbYPqzm5cW8ZEi5z+y8AWiwfRdqI/gXF3x3mmY2gK5JsfiIR9
         L3Hw2i3YvJ0ZM8VKxn0q/fn4W47TiQCl1P+RFXRIjOr22zj+99TXg3MVhR9VOmbyJ/Vo
         yyWWaC1ZsbUmuB7vePLYr8Z+WO/RhGtMQfrnMzsxJdGDF8bInL+EC7YL59c4YLsC2INh
         j8ZrwvrNZcmSQrwFEonTXPg6iKqAwnSfeFIRBcI3SMg5s6Gj0h5yH71K5ETGEcwC0pCL
         Kic9uJtN4c8rCNJvrsO7yCQUFJhcP5IRD7Ppax+G2awGaLmdOorw+Dzf3yXr1AiDvgf3
         D8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773443530; x=1774048330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Glzf1lRkoTqWUXidwriDm/Hu7F3CSuXg4RCxnpqKPlg=;
        b=TCRoGyqLUibvpn8GWi5jWYK02bpN5JggzpGSofXTbcsHa0+eAzdQr10Esg9bmGaMcL
         DzDtXiPCOqvG8+2eqCrJ6QDmkqYsdqTcdEM+PqFOmLp356fMIsQKsJY5V+Nnmt0YiBXW
         F8A6REsreEZtoeWbsSP32/nmW2p2aRCyt9cvJcsy5yY2meULsZZaRkBrsjK4GSIrSuHW
         qgq77/TSPBBoKSof5Cg1C0yJbGsp/1nW7sSc0wnDOdaFLaYCzxZ2JBa4UTiELjsLYY56
         Gl3TtB3GRS/peiEpnp/IhwCDYUH7gStiuJdOknYalLjmdopTeQhTCbYdN79MX0zkQGTa
         P1VA==
X-Forwarded-Encrypted: i=1; AJvYcCWmNAJ1AB7giLlzcCmhpy/yzMEE4oFg+/xVdA46NL8SGnRdx0teVkN0N1SoKiLMoQD+cUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwIClC+KRU+an8EHqeI9DtIt5x1/3ZiWTSxt98ENM8+qY3tA/
	Mi6xRQ2HMA0rWrvEjJNpmzivzewE6011YVIKRigSGbJ+g7hn9D7NgnvuArC4g6ZjNVZhj3QWJ2o
	9owc0pg==
X-Received: from plmn1.prod.google.com ([2002:a17:903:1881:b0:2ae:3f6d:fd02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:2ad:ba80:df62
 with SMTP id d9443c01a7336-2aecab04c03mr48674455ad.37.1773443529869; Fri, 13
 Mar 2026 16:12:09 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:12:08 -0700
In-Reply-To: <067c53cc-b015-43c6-9ba3-c734eff17819@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309193059.2244645-1-seanjc@google.com> <067c53cc-b015-43c6-9ba3-c734eff17819@linux.dev>
Message-ID: <abSZyLff5y-IQ0Ix@google.com>
Subject: Re: [RFC PATCH 0/3] srcu: KVM: Add, export and use call_srcu_expedited()
From: Sean Christopherson <seanjc@google.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Kunwu Chan wrote:
> On 3/10/26 03:30, Sean Christopherson wrote:
> > We've got a conundrum in KVM where we have multiple use cases that generally
> > want the same thing (eliminate waiting on guest configuration changes whenever
> > possible), but use KVM uAPIs in slightly different ways and effectively create
> > competing requirements.
> > 
> > The crux of the problem is that one use case wants KVM to free an object via
> > call_srcu() so that the task doesn't risk getting stalled waiting for a grace
> > period.  But for the other use case, using call_srcu() can trigger a
> > non-expedited grace period and cause a synchronize_srcu_expedited() in a
> > different ioctl (that must do a full sync, i.e. can't use call_srcu()) to stall
> > waiting for the non-expedited grace period.
> > 
> > Tagged RFC because while having the call_srcu() request do an expedited grace
> > period eliminates the unwanted synchronize_srcu_expedited() stalls, this feels
> > like a very crude fix.   That said, I'm definitely not opposed to this being a
> > final solution if it's the best option available.
> > 
> > Sean Christopherson (3):
> >   srcu: Declare exported symbols before including srcu{tiny,tree}.h
> >   srcu: Add and export call_srcu_expedited() to avoid transferring grace
> >     periods
> 
> Hi,
> 
> Thanks for writing this up.
> 
> The scenario you describe looks plausible.
> 
> That said, the cover letter wording might be a bit stronger than
> current SRCU behavior warrants. A later synchronize_srcu_expedited()
> can attempt to expedite an in-flight grace period, but it cannot
> avoid delay already incurred (for example, if the GP has already
> gone to sleep).
> 
> More generally, before adding an exported call_srcu_expedited()
> helper, should we consider improving existing in-flight promotion
> or delay behavior, or otherwise making the "expedite current GP"
> case more explicit without introducing a new callback-facing API?

I'm all for a general solution, but that's far, far beyond my SRCU knowledge level.
I was quite proud of myself for piecing together the incurred-delay. :-)

FYI, I'm going to be unavailable for ~2 weeks.  Nikita (Cc'd) can likely help test
potential fixes.

Thanks!
