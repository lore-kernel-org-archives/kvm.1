Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0FF4DBD67
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618734; cv=none; b=eK3Sc4p81Ii+Inw63CmYBgZzZ55KUdt0V0mKBQb5mMws3pPAo28LxVK08a9gEMO6QXnUy4Zp9kb7LzESX4CmASeLxD42B3+abnrDb8EVEi1Kv/Edg5euk0RZ2rVl5bEjomBDwD2buLKeB9BuxZqNXVN/NGxzZTBbthr8SXwSINE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618734; c=relaxed/simple;
	bh=xOjySS4wVaTAcPIFVj16j3n8kYLe8VfIiQVILneXLe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5y0hzWsTTN9fPYKI0EW6BT7y4InSJ5cQk/Sr+9j11HkC3NfeYr7UXlbYcRqCGa/P6033wW+lY3U0/LPM/x+qj3oYqolMwYNeWFHbYnFa0CoZO5qCQfnDExn5zUM/X9J1UHNXINAtIs2em7PUD6FUpdr1bu4xPmeLWZlNG1ATTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJ5WpMRv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJ5WpMRv"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3811ae55313so122248a91.3
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783618732; x=1784223532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PlohkTa49TToddFsPHYAOCXC7VLxt2aDGXSLnxYr1LQ=;
        b=WJ5WpMRvsTCbIPuCpSx3DUDTO0XWZ0LAp3tX57bvpGNt/k/XF++otTCPVM6pwqwsd4
         +4QwAuzSGXjs9khE5QlWpcNev+RL0KeReja9sgI7kLE9tOHj+f+1pbgEGB1j/RDMqC9H
         dqVmd9aD82kGEpS/SgTNPLG+BLNng/XcF/9nEP543IuhT2SMhsnh9/3ElmJGr2meUOJn
         UbhNiEhRAReY2oOX+Wn+t3m1F7fzaJIPwzQ4axqI8kAg8Ob4aCmKrNpVurRzhuTlA0JA
         qmc3qsrQ39dlBoY6dnflpz4vc4D8xatMzeww82gVJkaxbEwI0WLHVfA3lxS5EE2PoV/N
         zYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618732; x=1784223532;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlohkTa49TToddFsPHYAOCXC7VLxt2aDGXSLnxYr1LQ=;
        b=DKGMj3Xz/MXCP+Yt/oCe+/o8VJDU69eEBDFFR35Povitq2vLm48Q9R6tKJ54aXJiBO
         LW+/iDGEQqwLIqPlRbTGAjSDDzgFd6vF6qwvHCvb70tRqjhJMGKWRPPETPhb0+fahcN9
         8YNxM+gS1U7Nj0fkDMZjXujkla2FoAk/GVXnzn+r/nwrgRAY6IRSNVD/kYAcsw73cHKb
         HDIL5eHH09DO3iQlzJokBEHbSIXxPaSJ72wUuIZ68d4UvN2iL+wfxWaytEmdIlKT48WX
         vxh5jo13A8hRGMS2EzK2cNLR2FVKB8MJRZceDmjTK/LVImPUY2CgNMnXln455+t/DTJB
         YI6A==
X-Forwarded-Encrypted: i=1; AHgh+RokLaIrCz65oCZOBRVAMzYgFiRXhKUFlxAsIDhk0Cpzyx6VBAAFuOzLgQ6orC1tM1bDZz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBeUww7M1Fb9AJYgZwHqzZq2QxvosvkUhyWD+bHHy177aFePP
	hqMDeMm//XeOqeE4FfTBoa1CcsYu3WcnloVwWdWGt2gfrKCyV3rAXiV5DIH4bjudhrJrfDprJos
	o5lB1og==
X-Received: from pjbgb7.prod.google.com ([2002:a17:90b:607:b0:380:6618:e058])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58e5:b0:387:e0db:bc32
 with SMTP id 98e67ed59e1d1-38942692cffmr8395553a91.40.1783618731574; Thu, 09
 Jul 2026 10:38:51 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:38:50 -0700
In-Reply-To: <8b35057f72cd281637cf9d4bcbe1d0d753a3710e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706092021.3625908-2-twiederh@redhat.com> <akwrncCjosItvAeO@google.com>
 <bceedaf195adf713db70a1dba743055fe4f20bc0.camel@redhat.com>
 <ak5TojZfR04SWWd-@google.com> <8b35057f72cd281637cf9d4bcbe1d0d753a3710e.camel@redhat.com>
Message-ID: <ak_cqiwZwNBEhRNj@google.com>
Subject: Re: [PATCH 0/4] KVM: x86: Document and enforce APIC base memory hole
From: Sean Christopherson <seanjc@google.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Tim Wiederhake wrote:
> On Wed, 2026-07-08 at 06:41 -0700, Sean Christopherson wrote:
> > On Wed, Jul 08, 2026, Tim Wiederhake wrote:
> > > On Mon, 2026-07-06 at 15:26 -0700, Sean Christopherson wrote:
> > > > On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> > > > > When an in-kernel irqchip is enabled on x86, KVM installs a priva=
te
> > > > > memory slot at the default APIC base address (0xfee00000) during =
vcpu
> > > > > creation.=C2=A0 If user space has already mapped a memory region =
covering
> > > > > that address, vcpu creation fails with -EEXIST.=C2=A0 The same ha=
ppens in
> > > > > reverse: mapping memory over the APIC base after vcpu creation al=
so
> > > > > fails with -EEXIST.
> > > > >=20
> > > > > None of this is documented, and the error is reported far from wh=
ere
> > > > > the actual conflict is introduced.=C2=A0 A VMM developer hitting =
this has
> > > > > to trace through KVM internals to understand what went wrong.
> > > > I'm 100% in favor of documenting the behavior, but I'm not exactly
> > > > excited about the enforcement.

...

> > > FWIW, I did run into this exact issue myself and debugging it was
> >=20
> > What were you doing (or trying to do?) when you ran afoul of this?=C2=
=A0 I ask
> > because maybe there's a way to help developers without impacting KVM's
> > uABI.
>=20
> Experimenting, mostly with pmode code.=20

"pmode" being Protected Mode?  Or something else?

> For simplicity, I use a single memory slot at 0x0. Due to an off-by-one
> error, I gave the VM only 2 GB instead of 4 GB as intended. When I fixed
> that, suddenly vcpu creation failed.

Heh, fun.  I don't think there's a good answer here.  Or rather, I don't th=
ink
there's an answer that you'll find satisfying.  "Unintentionally" creating =
a
memslot that overlaps the PCI hole and the RESET vector is always going to =
end
in tears unless VMM and the guest are doing very special things.  I.e. not
covering up the local APIC base is so foundational that trying to guard aga=
inst
it in KVM isn't worthwhile, because such a goof is just the tip of the iceb=
erg.
