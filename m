Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA66DCE1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306156; cv=none; b=UUBkKevjGCIwM0MimAwkE65McePOuxBJlGSEw3eqG+/xxWIqlPaqI8hbipGdZb1mj/gSaArQ/mhfRpFfyt0uF7MqsGnjHjnjL8BeNgkC2Dozzeec5wERq+g82KawCSwOX/DxwNt+tUitLaO50uE82HHZl0ddTgDvbk9ntnRvwBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306156; c=relaxed/simple;
	bh=fXYdAJlRA+IQPnW5YdXRBG+lbzuJZBlONZUgxRFNbdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y9je+00NzCJelqDZgvGLzuKrav4vRbzyXwwmtBEIzEB+wTmA8sCnAZPqXec5OGrVDVzp2BLaxbaqqSgx6Y77gr3vYf1uNHJe/7np+MlH4M7OCskVFJvPj4kc8I0pwlI8E+5TmrfhH5Kbg3DIO9A12gwsAtS1GpAop/4ggagjiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kicG+LSg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kicG+LSg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso839733b3a.2
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782306155; x=1782910955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/fPNUEPtSBMDJFcvdnVWAv/4u4M2GCvtWFxK0tqLmE=;
        b=kicG+LSgkye1WJ9prdsJaB9NslN8z5gkGyCEvxa7pM1tenOZFqWbznllO9CA4Rb7WX
         4G+s6D88r4/Gjl/d6ihhDodI9KAYwjkirrJf9M0v39Py572A2JNvNxOjhk74SkpNLc9T
         TFlXk8WIus9r7NHZLq3NxMuDXYbn2+Jz1wCMMl/623CBU+e1aPIYmkPx6VBpdwfgQUNF
         fZglL/xx8waKRLmC2DvrYsLsdVx2HplMbwuRjxgLB9fNgU+WrkL382s1WkpUreGXN2QZ
         dibWEpHFbWSAmaRFzlxo73Bp4AMxtUuz/tAlDqdhEjcXBCAag/MnJvjETlJEfR8zAbyA
         864w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782306155; x=1782910955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/fPNUEPtSBMDJFcvdnVWAv/4u4M2GCvtWFxK0tqLmE=;
        b=bhO3TcfvlkRNiTls8HT/xidPKti/fh823gDF6v8u+311OijDQ/AERTJb1VSKq7U0Bf
         p/V/l6NyTkm4MsD+6Xqya47ARiEIwMixC+axWWhcRTceISM3MHCBrjELelAdOWP4kBv4
         4y+bzdPdRHIMiTp++Wby8nnIEcTh3IKB1P2145Aqnk5DP2q3BJ66PZsyRkVbPHj9AvLN
         Zh5MHaoX1zA+h5ZeVQjbf6RymxyEUkbJF+VlrgFEy++/aTHcRz7ilaPM3oxB88FfZsmN
         55xmRT5smK3iT1grdBdT51gCOGo1QXBYdOj50EmUcmTCiNWtBCz7G7w45cfoVxdaDYXy
         0ffw==
X-Forwarded-Encrypted: i=1; AFNElJ8CGrLQgGc7ehVR/0ol5rAGbE4+C+QMmI1DbPHqNulOhAFtPSySkedy+KzOwrV6eyZh0Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybLmb2thVYwGJMGk0+GjNjF4BYW0PTDiWcTpwiJFJqgSkq2U9R
	wYJEsHkqhdPrIyFZ4w1r/pOEAHg4s2CWOdn+BfLkKbaobdc13L8FS9Ek8ODzu/rIL040f9GQUux
	opMKGbg==
X-Received: from pfgs35.prod.google.com ([2002:a05:6a00:17a3:b0:842:3bd7:f2bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:340d:b0:82f:abc8:ae0
 with SMTP id d2e1a72fcca58-845a26f7e67mr4105507b3a.17.1782306154497; Wed, 24
 Jun 2026 06:02:34 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:02:33 +0000
In-Reply-To: <7d03539d-2a97-44fc-a9c7-0b3687730157@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <5c254d26-1dfc-4037-8ab6-5f8af6d0501f@redhat.com>
 <ajvTrLNWGgulNJaj@google.com> <7d03539d-2a97-44fc-a9c7-0b3687730157@redhat.com>
Message-ID: <ajvVaYBFjweVcqlY@google.com>
Subject: Re: [PATCH v4 00/30] KVM: x86: x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> On 6/24/26 14:55, Sean Christopherson wrote:
> > On Wed, Jun 24, 2026, Paolo Bonzini wrote:
> > > On 6/13/26 02:02, Sean Christopherson wrote:
> > > > It's still technically spring!
> > > > 
> > > > Perform spring cleaning on x86.{c,h} and asm/kvm_host.h, by adding regs.c
> > > > (the kvm_cache_regs.h => regs.h is already applied) and msrs.{c,h}, and moving
> > > > relevant code out of x86.c.
> > > 
> > > Rebased and applied to kvm/queue, with the following changes:
> > > 
> > > - Collect more tags
> > > - Move enum kvm_apicv_inhibit to x86.h
> > > - Move TSS constants to tss.h, include it in vmx.c
> > > - Rename kvm_x86_vcpu_ioctl_get_sregs2 to kvm_vcpu_ioctl_x86_get_sregs2
> > > - Rename kvm_x86_vcpu_ioctl_set_sregs2 to kvm_vcpu_ioctl_x86_set_sregs2
> > > - Fix conflicts
> > > - Changed srcu_dereference_check() to __force cast (see 18/30)
> > > - Adjust commit message on patches 11 and 26
> > 
> > Shoot, I have a fully refreshed version that I was going to send today (well, I
> > was going to send it on Monday, but life happened).  Any chance you want to wait
> > and grab that?  It has all of the above (except for maybe rebasing?), along with
> > a few more cleanups.
> 
> I was expecting some kind of conflict which is why I put it only on
> kvm/queue.  If it's possible to have them on top, that would be helpful
> because it means I can move what I have on kvm/next, before leaving for
> vacation.

Roger that, I'll see how things look if I rebase on top asap, and report back.
