Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DD486637
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846962; cv=none; b=cHI21I260SudxjDe6EzjUZkOnmyjPL+F2KpPWCCYonKoksJnaH7KsNfeOZmL29Qrbx7TcKhJjz37sIPzfkNIMwylwKYPfQWq6XJzUWpQz1sQaszzhomQXrLY98Ao2L/JN2dgzn4tW6/eEu9cXWcA6hoji9gg6T0ougDkWRLOIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846962; c=relaxed/simple;
	bh=bspMHm/+7BJ6sEbPXtiqPY6IEPZvLrmFpAFlmwvuwos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nZuW9E6L4dvAkw2gws/4XPhG/oDdgumE74wJFqy4SF6qcbbYnLYJxmt4gIO9woCzD8ZTUCgY8e+yYRTkZtmDXWpGyjY4C/Epe4r300J/Bh8a+WRVDwPqDnA9MID6O5XR1EQeZI3XaPp6DSxT0aY5xbtfquYizsLqYX+KvaturfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VS3M4rli; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VS3M4rli"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so61841a12.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787846960; x=1788451760; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slPt1HQ5wTtJetf35tHeOwsTi6sWrICDhVKy8b/54DU=;
        b=VS3M4rliiihpALWJ3WjaxvNFIfGOJsjWVMP3niADt5bIzoxbOL6gTJ4z8vpuP65VAC
         10+SP5IAvvQ7AkiNvo0UnZG0GqF5yogGKjwCot2VOk7O8rHEmZCG2sjrkow1ZeqFiaJS
         cg7pdxYex4qqTPzKBgd8z7l2zRbJOy2ui0Gh/bwNsvHspYfK1avctGuzqbY3yl/csOLp
         xoxn337i9SKAssKAfiyZ9B9Cd2+ve2BKxc3zija/a03jPD7nx1rP5cCyQ/EijqTtFVfh
         XjyMhO05sQjySB785m7DAvci1l8aYTvYvzUXjl5uKFExgHcLR30ddLdCfpTYnYryWlJa
         iJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846960; x=1788451760;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slPt1HQ5wTtJetf35tHeOwsTi6sWrICDhVKy8b/54DU=;
        b=dYfOBZIPtLea/pOJfMTbcz5k0QaIMJXGqanfcP1tA/U8s1peCDJgWyghbnUCTt0ER4
         EeTXg52u6ncY2s1nfS20SG+U0OnV47Jf45Ujqz1VE5JryPYO1J19yJd/NU2PZ2aN/97N
         0LaOhhW+Y8DFoFVRh2NpT2xeJyreyBwkYR5NhGnZFJ+H/kybANvKbqsQuNAgdP/YaG5u
         653PulpOXaysHPf5cZEWp1bpYLPkXr9vXfq5HjkdOEszSguLMdHMeWJ9zZG9hyncKn95
         7/wLNU/4sbzeLwEQ7+WBzpOCFBh9tr3snLGhyhNEkk5yJLFUsWLb/82ZG+EFsNDTZ+1g
         QCjQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/bg4xiUQDcz4ngGj4nxtJGo+wBy1fpeCQzYWuICQ0qGpFmIWp+VZfuuUc0d/HIyihESE=@vger.kernel.org
X-Gm-Message-State: AFuF++nnIH+1P0Lc/77Uozn/cPCg/W6c1/+150o5uzrtGImA+ADgDWO7
	8is1Djnlv1TIrrrxZt+WzQeE0l7tYtA2fF0Exvc6f7n4c7rXSzZuAbYZ5ElYKU7EUGhD2o6MfAI
	Ww8hyTA==
X-Received: from pjxu21.prod.google.com ([2002:a17:90a:db55:b0:381:1b76:a387])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5405:b0:38e:67e1:15b
 with SMTP id 98e67ed59e1d1-396d0de4c19mr649220a91.6.1787846960168; Thu, 27
 Aug 2026 09:09:20 -0700 (PDT)
Date: Thu, 27 Aug 2026 09:09:19 -0700
In-Reply-To: <874iggnijm.fsf@172.16.32.78>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826184449.814130-1-seanjc@google.com> <874iggnijm.fsf@172.16.32.78>
Message-ID: <apBhLyItjuG3dmF1@google.com>
Subject: Re: [PATCH] KVM: x86: Zero reserved synic flags when delivering
 message to avoid stack leak
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > Ensure all reserved flags are zeroed when setting the msg_pending flag as
> > part of SynIC message delivery, as setting only msg_pending can leak seven
> > bits of kernel stack data to the guest.  E.g. gcc typically uses a
> > bitwise-OR to set the msg_pending flag, without initializing the on-stack
> > variable.
> >
> > Precisely zero the flags, e.g. as opposed to zeroing the entire structure,
> > to make it somewhat more obvious that the flags *need* to be zeroed.  E.g.
> > it would be quite easy to misread the initial read of guest memory and
> > think that zeroing the entire structure is completely superfluous.
> >
> > Fixes: 3a0e7731724f ("x86: kvm: hyperv: simplify SynIC message delivery")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Teodorescu <fane@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/hyperv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 604651cb2739..8d2669d8ef34 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -802,7 +802,9 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
> >  		if (no_retry)
> >  			return 0;
> >  
> > +		hv_hdr.message_flags.asu8 = 0;
> >  		hv_hdr.message_flags.msg_pending = 1;
> > +
> >  		r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn,
> >  					      &hv_hdr.message_flags,
> >  					      msg_off +
> >
> > base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> (although, I kind of like the idea of zeroing the whole structure with a
> comment that we don't read it as a whole from guest's memory too)

FWIW, I actually wrote the code that way the first time, and even with the
comment I was still scratching my head a bit.  I think because it's not at all
obvious that msg_pending is a bit in a bitfield, not a standalone boolean?
