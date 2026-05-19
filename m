Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57D3BB668
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222336; cv=none; b=Oi8d1tLSHNuIf3PhByq5iD6zZrBLi8VLnPn1+gYIjnN13+sBSQU/WqE1UjW3gYvDSIbklcqwxqkWpn1GUn2R/1fjtmQUMmvFfCW++gYJHI8yBhRRF/RJ0MngdwKlM3A5AR7J7SDJuDZ1h+BX5RmTtVxQaVp7dGZudzKPN6BoaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222336; c=relaxed/simple;
	bh=sRc2NkcvEfIct1sxSx0C/IFyIPhCxb/rmsqZTNHj6+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f95YxZy2+7plBOGmXA+VzWYg1IINCMA/P2FJWhfftfLjzW1TOvP0B3UifZxTpitmri64+SxPgBEsS/54kawL71XYLL63G5TGVwr4QGSSwi/uAV2AEO7Ukgo7hbm4qDeMc1iO3AwYhfAbQEYhMmx1udsIUomeynQgWwaY3F5WtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qttdrzbQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qttdrzbQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9b8137828so42246555ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779222333; x=1779827133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cV0r3jKPfp4zv5FaaUB3cGXxaoCrk2SAbq84AyKv7tw=;
        b=qttdrzbQvmgalceQJTTyGqFUG4gib0JVkEcPPUMU+g2l3oqGgj5fDnpVu8ILX0aoAu
         Tu1p8oDDiTnTQMO+9IqyHDY4zc2UIixyHqczxxr6MdeNjNHzUWbuZPRuKLNRiOxdRCYu
         dV61z4layUlmdoHkQBgpFe3pzdtP49E+DKvalFNqa3jroAAPMjp0maHIawyz+2gRxJyu
         kbS/UBgZNKO3LswD/Zgap8IuNbxPfSLc5Pp0Umi5baeSSDcXBp85BU77fr9pR1FCQjL4
         UClufRr2e07s6PMRub+oSSpyAYJByhwg1MUKv0bMRed2E3wF57mModoOttVijlrmgOl0
         HuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222333; x=1779827133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cV0r3jKPfp4zv5FaaUB3cGXxaoCrk2SAbq84AyKv7tw=;
        b=NkeELO3kVM7UG6Waxy9FbZK/H7y3fsu2QZV3jBXmZqNTH81C32LDQxzPro/Toh7K/4
         V77uPGKSvWtcL6eOqQwj8PjCVL83VOhXyfo1je5fCfwFVE3Eh/9t5A38RB2kyq10xYBp
         KOfd0Pn3zn1RnKl88YiJLK021jO3IicOqom2D2X2utPgipyUdIFHVBoVwwasfw5VP42A
         QEGjZOj6tC/zBO41gduOP4Atq91mJkYPN+HZnYwnxlZdIWsUKdKSTqY27HNQS8H+BHq5
         erMs/1PO2Y9pPIkIKsIUaL6D2b4nAomc70/sGeBsODvJs3tvIfiplVI9LYqMb+/zSrQ5
         OlWw==
X-Forwarded-Encrypted: i=1; AFNElJ/FgovZaVSp5kvtehcGNC4roJ2GovxT6tSNnxxzut+X2umglXHy+YzrQU7R+VFwqfsfLM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbE7DLvmIV3DbmDCB6iJ0pDnquxUk8cS+Fo/yuOJrUlQXHn7K
	+ng0JHjUCspA/264M7+FxqLez3XqvB/l9Tixawi4xbDmUL1hrTvzseyyPBzpI1pcwgRMUJjPTri
	ay9HrNg==
X-Received: from plbmc15.prod.google.com ([2002:a17:903:2b0f:b0:2b0:af76:bcc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d512:b0:2b4:5f96:184d
 with SMTP id d9443c01a7336-2bd7e86c6a4mr238530365ad.5.1779222332159; Tue, 19
 May 2026 13:25:32 -0700 (PDT)
Date: Tue, 19 May 2026 20:25:31 +0000
In-Reply-To: <fbb937ae-62e4-4386-86fb-67d9b85c8fdc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <agusSarZr-R_o2xD@google.com> <fbb937ae-62e4-4386-86fb-67d9b85c8fdc@linux.ibm.com>
Message-ID: <agzHO6EXfAe_40F4@google.com>
Subject: Re: Sashiko review email for kvm@vger.kernel.org?
From: Sean Christopherson <seanjc@google.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Alex Williamson <alex@shazbot.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Longfang Liu <liulongfang@huawei.com>, 
	Julian Ruess <julianr@linux.ibm.com>, Kirti Wankhede <kwankhede@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Brett Creeley <brett.creeley@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, David Matlack <dmatlack@google.com>, 
	"=?utf-8?Q?Micha=C5=82?= Winiarski" <michal.winiarski@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Eugenio =?utf-8?B?UMOpcmV6?=" <eperezma@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Roman Gushchin <kfree@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+KVM and LKML, which I stupidly forgot to Cc :-(

On Tue, May 19, 2026, Janosch Frank wrote:
> On 5/19/26 02:18, Sean Christopherson wrote:
> > Hello people with a MAINTAINERS entry that uses kvm@vger.kernel.org as a mailing list!
> > 
> > How would y'all feel about enabling Sashiko[*] emails for kvm@vger.kernel.org?  For
> > a variety of reasons, Sashiko currently only logs its reviews to https://sashiko.dev
> > by default.  If subsystems want to receive on-list mails, they need to opt-in.
> > 
> > I really, really want to enable email reviews for KVM x86, as Sashiko has found
> > an almost embarassing number of bugs that (a) would have been painful to debug
> > had they escaped review and (b) I'm not convinced would have been found by
> > traditional review.  And for me at least the signal:noise ratio is more than good
> > enough.  There are still hallucinations and false positives from time to time,
> > but the good outweighs the bad by quite a bit, it's cathartic to flame AI when
> > it's wrong, and worst case scenario I can simply ignore Sashiko.
> > 
> > But, currently Sashiko is only capable of making decisions based on mailing list,
> > i.e. as things stand, _all_ of kvm@ needs to opt-in.  Before I badger Roman to
> > add bespoke logic to Sashiko's email flow, e.g. to special case KVM x86 in some
> > way, I want to see if there's a general consensus in favor (or against) enabling
> > review emails.
> > 
> > Thanks!
> > 
> > [*] https://github.com/sashiko-dev/sashiko
> 
> Sure,
  ^
  |- This

> as long as there will be no mails from Sashiko or at most one mail per thread.

is in conflict with the caveats here, as per-patch email is exactly what I am
proposing (the current state is that Sashiko never sends mails).

> I'd appreciate something like "I found problems in this thread, here's the
> link, go look if you want to".

While this would be easier than manually searching through the web site, there
would still be a sizeable barrier between contributors/maintainers and Sashiko
feedback.  E.g. to click through an out-of-band source, copy+paste the response
into the original thread, etc.  

What are your concerns with per-patch email?  Hallucinations and noise are
definitely a potential problem, but IMO that can be handled by per-subsystem
policy.  E.g. if the signal:noise ratio is particularly poor for a subsystem,
that subsystem can document/state that responding to, or even reading, Sashiko
mails is completely optional.

Beyond that, I'm struggling to understand why folks are opposed to getting mails
from Sashiko, especially for a list as large as kvm@.  As others pointed out, the
volume for kvm@ is already high, and it's trivially easy to create a filter for
mails from sashiko-bot@kernel.org.  I.e. it seems highly unlikely that mail from
Sashiko will require anyone to significantly rethink and/or rework their workflow,
whereas the web site approach is very disruptive to email-based review, at least
for me.
