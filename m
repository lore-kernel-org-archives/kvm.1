Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6F2652B0
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865643; cv=none; b=qtTf0/nAmHFy4W6pd//lF3dDxeuzUZ7O3bAOi6BfGQI2GqZzB/wNh2gb9QWe2uVsSKPaJdDBL/Xr84B7OsKkUB2GrkdF1vQN37g2YFDNNQVj/N+gxMlyPaR4WYj75gwSPJxYWDN3z+UwcHvrP7hXmOLdNA2AXmCoYAogiFfy1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865643; c=relaxed/simple;
	bh=bg7s5beUeutc4QJMAsPZVhIiUNnql3KF4HcjZ1clR1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cambjGd84pv7J3fSiAKCaxFtQqOJsvwog8lJ9ueQho0f4fnwIWH7TfOq+iPiJclGF4ts8fnHwZiDLgnKNwslHvpdVmLNbjg8explHungw1GrfpyWiL+fJWhuBP5ZLYze5gVOOZEnY2f/9PMQoQ92NmqBX7sprwoutdWNvxcmYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKPhP4Fm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKPhP4Fm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso49969465ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776865641; x=1777470441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGDctFIowsbloE7wAkmlGGn1Ww7hL67mBk0hWMdKDrU=;
        b=HKPhP4FmXex2Q08pM8auuLhJAbAKKJTwdVClvH5Ppk+Qzp1cbaMqtabzkMrfl2CE85
         9K4ZQGgieEU9CJhmYjT/23k8+kcOBYKmCDTnGdvrmFAjajXttOkK4dbJOTAkvOSH1tFJ
         x7Hi7fnS3Xmu0qWyXL9Mhh2ftS7QUXFwK2BwCaggy0gg5DZcgh6Dq0fBU+vhL9/sgYk0
         1iG84i4oN/eklgsHQguSzey6gkzvftL6J3m/8JF1rJbjWRWsS95grbnFxYfeLVHHtiQM
         MQ2L7ZmiRpR6FZ730VK35DMWRCu+rnb8+vzgqSPF+CzugHnhp5lo3ipYbkr0OVaGB1HN
         bsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865641; x=1777470441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGDctFIowsbloE7wAkmlGGn1Ww7hL67mBk0hWMdKDrU=;
        b=RWFKAUe6u9VvF0w4Ls3msFB9ufgBbijajK/atCTwberlShGahZJu9Xc2X+YzVJkh02
         /sOlNnBwne+SzHmFr2lptK1lFnfU8N0e15Om5UTYnlrx5p17O+IeE4MEoh8eCDds0ra1
         R4TrB8b8nZf4oQ/zovo1fR02ZYsvLYhQ6otd8coA6FQUwk6kS9a5v04sV6vQpS08JJYx
         E7X8QEmTgvtIYzkxmESkdJjZA9yy5OZnnDwRe4KphAgb5qY/2662DfvBORNB8PSTBw4T
         XkbpcPu0sZ6/Se1XeGAuSmPu/HKPUpO4WNBbLCbk0M80X2ltEsFnoqe3Q3qV/tSsQkYv
         5Hzg==
X-Forwarded-Encrypted: i=1; AFNElJ+iTEhA42ILcHFzxtFcHM5fY02oPBCISCPz74GDGyX2U2PbIVe1pc9sb8nZER+XeWQuD4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOPQvyScSE/eMCSStKHXVwZeazOnPsU1lSpBpMk/++p5U8jk3N
	56plmtulQeVizRc7tTe3kpm7dFy4kl9CgK+2/p+cbhuolkXu8Wu+nn8rYYh9wxJkyxwKBf+DIR+
	SsQ6ciA==
X-Received: from pllm12.prod.google.com ([2002:a17:902:768c:b0:2b2:5557:43c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2acb:b0:2ae:450c:951e
 with SMTP id d9443c01a7336-2b5f9f08968mr236582905ad.17.1776865641229; Wed, 22
 Apr 2026 06:47:21 -0700 (PDT)
Date: Wed, 22 Apr 2026 06:47:19 -0700
In-Reply-To: <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com> <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com> <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
Message-ID: <aejRZ3CIaHLogTRL@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 02:42:46PM -0700, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Peter Zijlstra wrote:
> > > On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
> > > > This as delta? (I had typed this all up before Peter posted a new verison, so
> > > > dammit I'm sending it!)
> > > 
> > > :-)
> > > 
> > > I'll go stare at it in the morning, I'm about to go crash out.
> > 
> > New delta against your effective v2, builds all of my configs (which isn't _that_
> > many, but I think they cover most of the weirder ways to include KVM (or not)).
> > 
> > I'll start testing the full thing to try and get early signal on the health.
> 
> Oh, re-reading commit 28d11e4548b7, I think this wrecks NMIs. The patch
> will also use the FRED NMI path and that's not good when running IDT.

Oof, good catch.  Which in turn explains why KVM's VMX_DO_EVENT_IRQOFF still uses
CONFIG_X86_64 instead of CONFIG_X86_FRED.
