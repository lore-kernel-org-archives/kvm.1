Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE73D75C5
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782646; cv=none; b=UoQYyrcK9ekoZ0EJjE05bSLHF2dXBzOcsNlJreLOBra4gfFDv+7Ofl7pcpBn5faoY+gnhWpPOZh1WIYj2li9c7syI3kInNC6vQ1MjX1bciFN38BuU1GREIt6huQYXk2MivqOOljKeTzZqra++qYB0qL2SZscblqec+6piOVwi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782646; c=relaxed/simple;
	bh=UN4Je6wcA6/RUfs78P/pLdn9tLyXPMVI1CGMtwSK/gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+qk8ghcG5MLni+NBgVKzidEv4/kOTCQj4IkWH1K+BtjICHxrufii1I5BtnX8TNrc5NWUClEApmwW2OLlWTOztB78Pjs9tZDZ9cjIucXnnMaZeqlGB+x8rLsmozG9u/JBKdCmM/bA9sfu19l35mvbHYv+TcOVH6BeurZG8sqft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWSMMVCD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWSMMVCD"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa860e71eso1429160b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776782645; x=1777387445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tavAqjtLt+mm7XJ48qJxWOujWXgsE4WRZCTG66i4cZA=;
        b=BWSMMVCDu9G48AuWUIfCFdZqVzF3kof2cUADeoychwTOE720LC7WCqrUv4phEtV474
         BqacBUVHLEEx2eXixqHPhBmbT+DEAZedzoT7YGpmza8yA5ZSRhreE1o8qjmzW/VrFhv7
         4lIWI8Kne13CjtXNJhYeVHmKUFp/Tdoj/Je8Pelqe2/Oc8BEpcWfRFXTjxlM0mg4NEgE
         +IByJ1/UWi/rJ1M+Ca6WQEsUjGNIkMcBw+YWgp3S+Or2s1qoFUABTbWqe1rUz3b86Hri
         bdqTVO7yN4Jl568tvJuVzJF5Tu1mNusQLrdCuvc7YE6f8hanzzW+fT3kiyuoEfbuJAuJ
         dv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782645; x=1777387445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tavAqjtLt+mm7XJ48qJxWOujWXgsE4WRZCTG66i4cZA=;
        b=g12lR47imPYeFJ/+ESyKm6Jcfb5CDnn81OCWsA2D8iu0aRhsuOBqHl7G6nzX8P2GV8
         03XZUmpg7KMBNcZCUM/61WOCs+RrwKaVwbGNZW6YinJTqVOvONkhvDvEf83AtAFvledf
         Jnx4ko0o7o1g5XLIohievohYro3kpvJWX3RQUiUBdEl72WfUPoIcYSQyzvz7FCAxlgXg
         6/KYeXmGpNkEnKJi4sCk7jp54oglSSh+ys1p8caT28/sC/2iA8fvYnIsjko2Sl57NPxS
         Y6OrcLfyk/kawki5J2l4oKcCnDHG2SwD352OPWqrr1wYksvNJi0QJCP62rKuqIJGn2lf
         kY0g==
X-Forwarded-Encrypted: i=1; AFNElJ+XRtdSktoflrEwmkqtPDnB+FsKdcExd1PctuKBZAMZJvDl/e488YtPHpqLpv2LMsCgJT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiioEBN6klyyCU11SWh06YHabggPGK9Gh/6xlOZxMsUq6trlt
	TsIRKIsYBjdh/wd3KiiaRgjpHgknVwQHYk/qoWRkgq6zc2Ov/GKlR1atmC2A7X4fYqBPRgKjuoP
	bob+FvQ==
X-Received: from pfbdl11.prod.google.com ([2002:a05:6a00:490b:b0:82f:6e26:770b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ac6:b0:829:8041:83f
 with SMTP id d2e1a72fcca58-82f8c7df387mr17715985b3a.7.1776782644459; Tue, 21
 Apr 2026 07:44:04 -0700 (PDT)
Date: Tue, 21 Apr 2026 07:44:02 -0700
In-Reply-To: <DS0PR02MB93214EEAB50391C84CB7B9C48B44A@DS0PR02MB9321.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <43e9c370c07092e6e1342f70d272166a1f3caedb.camel@infradead.org> <DS0PR02MB93214EEAB50391C84CB7B9C48B44A@DS0PR02MB9321.namprd02.prod.outlook.com>
Message-ID: <aeeNMhOM2fc2BW6u@google.com>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
From: Sean Christopherson <seanjc@google.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ilias Stamatis <ilstam@amazon.com>, Paul Durrant <paul@xen.org>, 
	"graf@amazon.de" <graf@amazon.de>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	John Levon <john.levon@nutanix.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026, Thanos Makatos wrote:
> > From: David Woodhouse <dwmw2@infradead.org>
> > On Fri, 2026-03-06 at 12:56 +0000, Thanos Makatos wrote:
> > > Add a new flag, KVM_IOEVENTFD_FLAG_POST_WRITE, when assigning an
> > > ioeventfd that results in the value written by the guest to be copied
> > > to user-supplied memory instead of being discarded.
> > >
> > > The goal of this new mechanism is to speed up doorbell writes on NVMe
> > > controllers emulated outside of the VMM. Currently, a doorbell write =
to
> > > an NVMe SQ tail doorbell requires returning from ioctl(KVM_RUN) and t=
he
> > > VMM communicating the event, along with the doorbell value, to the NV=
Me
> > > controller emulation task.=C2=A0 With POST_WRITE, the NVMe emulation =
task is
> > > directly notified of the doorbell write and can find the doorbell val=
ue
> > > in a known location, without involving VMM.

...

> > I'd love to see if this KVM_IOEVENTFD_FLAG_POST_WRITE works for the
> > i82559 emulation use case. I think back-to-back writes are discarded
> > with this model, while Ilias's patches would convey each one?

Do you happen to know the requirements for i82559 emulation?  I tried readi=
ng the
spec and QEMU's code, and that was just a waste of ~20 minutes :-)

> Yes, they're discarded, only the last write is visible, and this is by de=
sign
> to fit the NVMe doorbell use case.

I wouldn't say the design is specifically to fit the NVMe doorbell use case=
,
rather that KVM doesn't need to convey each write to support NVMe doorbells=
, and
forwarding only the most recent value is a massive "win" for complexity.

Which, for me, is also the argument for accepting KVM_IOEVENTFD_FLAG_POST_W=
RITE
even if there are a limited number of use cases: it's simple (and performan=
t)
enough that it's probably worth supporting even if similar functionality ca=
n be
implemented via polling on coalesced I/O buffers.  I.e. maintaing both does=
n't
seem too onerous, if that's where we wend up.

> ioregionfd,
> https://lore.kernel.org/all/88ca79d2e378dcbfb3988b562ad2c16c4f929ac7.came=
l@gmail.com,
> was a similar proposal for forwarding MMIO writes without discarding
> back-to-back writes.

And if you were curious what the code looked like:

https://lore.kernel.org/kvm/cover.1613828726.git.eafanasova@gmail.com
