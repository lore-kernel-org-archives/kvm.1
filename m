Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35D4BB282
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949283; cv=none; b=Q1PlVmLax2F+CXNwstjuDrdJSACb/MYPxrNqs3Q5WRitNAcwiK12gKRrhKsjB7SOhqx3CtewVRJGDzEODBHJx+xbOZOalxbDXEcRdUY5ea8HcwFxPkr7QJu+rWDd9l5EsjfTuJnEyOmh9cyJzWc5Z8w3aoEEgdPGMO78I1IJsqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949283; c=relaxed/simple;
	bh=KTUwSAw2KqK3Jo3fjMAfYHRYu+1UTZXFA0vNXcwmGJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CiwGMOl2tpZ87Y6Dm7BQsVoFZ86Pnn7lFdAf/hHRvjwZ6JE4ja8ARpKyocxGqSYB/kL5nj83WfwT9lvn8InjUQ9rsZG3bYAy5gSeXpbiCgpZbgA8THZh43OUc1j6YvtdrBmuQ1fr0A4W50b1YMB/0WoD6WfZjqJvY8mVxtmKRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MI2D2Ius; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MI2D2Ius"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a4f7eb79f2so2035515a91.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790949281; x=1791554081; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1lBW1x3XmBH5mOfd18Qg+ztVcEBJ153cF5DJ7M24HI=;
        b=MI2D2IusPK+3dmfNAc6XEW1/Nx1Ed+OlF8lVIp+RznTH1pg1H0w5JgK6uRBhMPHYbw
         EWf7bU9pvOm2WTCKo4vOLsa/N2BleTHB2V59OOjU7uTVxNWznwPyrDb0pbtynwiZYKvS
         otff9lATlAPmoSRC2I6sqV2633Gd+E2aRsFpooBPN3nb3wV2NZEypcdOaACh1k0mkOiB
         0LuELor7u9tLzRA5VTK8QNdKshXMRfDHhrLaNy6iFFECLurO1Bg3KuGuCS1XwpYrMTyh
         uaR/7yix9cxV0VT6tJLjr1oLQAMG9/HrnJLIbM36kM7atIc28DcaY0wg2o/vOfmC0iln
         r7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790949281; x=1791554081;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1lBW1x3XmBH5mOfd18Qg+ztVcEBJ153cF5DJ7M24HI=;
        b=CmMhLEBbkmhEPiEUl51LQPgc0c626jjvYo3GyxAr7/eSrHRY1DabhigXB21ZZHFMe0
         KTzz7wy6+7tH6Itj1W+E9USsk5Fd0LVldChwb4xaGTsqqOaH/y9iJOqCHln15hvQEJ7J
         bAXGnKaM1iYqOWf/BXX5IYbJ77CF24yag7lJFJPekzmXpMEhBSbRqVLYL7fzKNyp8sTq
         G96a9wVnJv4fxavdwPq1VCRIo1jvROeoYgdU66VEV5IBEkUO2vhl5jktUX+hBUfgZnei
         Nwu1ZEEFc/X2rUhMHIXLVer1Gi7z6m+CXsPo/aKdpYI5FXhhoCPHLvToW3I5YGos0WiS
         QtAA==
X-Gm-Message-State: AFq9FYIk4JCYNDmLEsV4rETHUh1Bbj0Gf0og8n6XgntyFvk6SsKdMsgR
	nPR3MGCLVfVcxd32m8LpKq1gH7woro5C7iTlBhG5e4PwPwg9O9Zj45Gv6RRkuTCdB0d5XhhFlKW
	mE5C6bg==
X-Received: from pjbng11.prod.google.com ([2002:a17:90b:1a8b:b0:3a4:788f:51c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:38c6:b0:3a5:147a:3b60
 with SMTP id 98e67ed59e1d1-3a6ce853a89mr790042a91.52.1790949280652; Fri, 02
 Oct 2026 06:54:40 -0700 (PDT)
Date: Fri, 2 Oct 2026 06:54:39 -0700
In-Reply-To: <20261002091343.02E3B1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-11-seanjc@google.com>
 <20261002091343.02E3B1F00899@smtp.kernel.org>
Message-ID: <ar-3nx-8eS9UwVNx@google.com>
Subject: Re: [PATCH v2 10/10] KVM: Pre-check uaccesses in KVM's APIs to
 read/write guest memory
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 770a2c3bd4458..80b19d47840b2 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> [ ... ]
> > @@ -3211,6 +3211,11 @@ static int next_segment(unsigned long len, int offset)
> >  		return len;
> >  }
> >  
> > +static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len, int size)
> > +{
> > +	return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > PAGE_SIZE);
> > +}
> 
> [Severity: Medium]
> Does this helper ignore the provided size parameter? 

/facepalm

Copy+paste fail.  I distinctly remember fixing this locally, once, but apparently
I clobbered that change.
