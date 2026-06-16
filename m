Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DD33A9EB
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629988; cv=none; b=Y9xwqZNa3AK+zEQ5DVquk3gfvUvjYPtj6s+1c/gTAaT/jv2Q6HFD7qFpVwRV80wXxCUQw8Xzh9e1uefgFoQF7XF6xy4muA/2aId8j3ka/cL15dELkrVf215vs23Jx+Y4C0Fxr7brBXoSoF0yxAfKDFNMCgFmMnSfLAJq5DrJW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629988; c=relaxed/simple;
	bh=j+chinBo79ky7bqmVyp62lyExiytJOXtouVlfQ1T9AY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWAESsvYTXSOnw73UOjY5vMpMclQLvpcFzV+t64AEPJJdXu0/0yZy9cyblvEHjC6Fcs5BdFaU7MNxxug3BolDVfHN8MunUTef9Rz8Z1YpTuL3rfXnM7063kLugvD+CO9/ohfBLk1dt5ZN3wOKFEDW3KxTMsKCyIwdwZjP+r0Byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PP9158g2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PP9158g2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6a2ee8cc9so5889015ad.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781629986; x=1782234786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqbxHWXFnYEggk+ZHCyr6jaSIQ/DL3Iz7LICT1+s4aA=;
        b=PP9158g2dfZD+cTtInTyzKpet41PdktxsS2GTtUDwKifXOOjnaqLhi9Do1BRQz4zLK
         QpG496ykknRNFDsdwl4nD/O7dhyYdMDNF5HNYTSJCAZ2PuXczXLnwh/jxQe8PaQlHP/N
         Bp9jA2jsie2RaLt6xulFaLmmUqIOohM+C1Rj20hvqpoVDSLh05EZ8rkJURx+sQR52ono
         sbHBG6xfXflzovNi1OkQ8Hr2ek6TNR9EoJHcMlz2hrFSoIGRZ/mvCAMPlRtiV7mncWMG
         e7eral6jFB31lPAKThLGrOBYtVgwQo0Wu+P49sFlIRFBkiOlGrTxkKSGwyO5q0c7iZvG
         Y/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629986; x=1782234786;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqbxHWXFnYEggk+ZHCyr6jaSIQ/DL3Iz7LICT1+s4aA=;
        b=k/66oryXI4cnF+jMmeUi30zHdjkbMYX9znP4Y9qLW3fcXmvXt7FSRqcHh6ufHyZVrt
         mpnpI158wMWpaWBgero4stSpsXDA+U8OXMSvOXC9pCiF4/v+Np2MCMYIi3SxxuJHFhbZ
         29Oikmii/7qevQZw42XZdxsf9fa+URAVvgEYDyrmYkpOTjtuxNLo9gU+AoVFq3wDMxOk
         WU/QNTuSvSQ4BmkdGUifZ/1G+3Up7Jk4ID40jwRgf0tkhfyYKsbuKvQ0uJkkofWPz/Tu
         QDOs80M4381ATA/7TdqYIqti9I/EEVqvvHW0MncM3ONaiUnGE5jSKfrDCEpd/l+EZpHg
         iFVg==
X-Forwarded-Encrypted: i=1; AFNElJ9gZrKuDgGprpUFkviq1uR95wy+mIvqGET71mNnc7xEF2l+RNyk0Do+U2gCyamS0DMg/Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9Mw8XInxEExAhLy8gWhaO7p5LWLB92iNy/nGwRy7OWRxFl1v
	srv1w9azI2pHgBcn9Oaxam7Niyj7Eyoh9NOSGzQCzdgw64eM36/VsUbUxCyrxZXoZE3YuQPl4Yp
	8kWhMvg==
X-Received: from plqu9.prod.google.com ([2002:a17:902:a609:b0:2c0:af9f:ffbb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e5:b0:2bf:128d:f7ff
 with SMTP id d9443c01a7336-2c69a15d10cmr47559695ad.16.1781629986207; Tue, 16
 Jun 2026 10:13:06 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:13:04 -0700
In-Reply-To: <CALMp9eTc=mUWb15J_px59=LcTEC6Q8ec2UbnkpwBoWhunaeKFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com> <20260612230113.684301-6-seanjc@google.com>
 <CALMp9eTc=mUWb15J_px59=LcTEC6Q8ec2UbnkpwBoWhunaeKFw@mail.gmail.com>
Message-ID: <ajGEILz_ldZe-Hbq@google.com>
Subject: Re: [PATCH v3 5/8] KVM: VMX: Prioritize DR7.GD=1 #DB over CPL>0 #GP
 on Intel
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Jim Mattson wrote:
> On Fri, Jun 12, 2026 at 4:03=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Note, neither Intel's SDM nor AMD's APM says anything about the relativ=
e
> > priority, hence the empirical testing.  Arguably Intel's description of
> > DR7.GD:
> >
> >   causes a debug exception to be generated prior to any MOV instruction
> >   that accesses a debug register.
> >
> > implies that DR7.GD has higher priority.  But that's a fairly weak argu=
ment
> > as the statement would still hold true if the #GP due to CPL>0 had high=
er
> > priority, as the #GP would prevent any access to a DR.
> >
> > Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr re=
gisters")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/emulate.c | 7 ++++++-
> >  arch/x86/kvm/vmx/vmx.c | 6 +++---
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index 127a21eeef66..b4dc57fe0bc9 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -3834,6 +3834,7 @@ static int check_cr_access(struct x86_emulate_ctx=
t *ctxt)
> >
> >  static int check_dr_read(struct x86_emulate_ctxt *ctxt)
> >  {
> > +       bool is_intel =3D ctxt->ops->guest_cpuid_is_intel_compatible(ct=
xt);
>=20
> Hmmm...Have you tested VIA?=20

Nope.  I'll loop in the Zhaoxin folks when I post the KVM-Unit-Test code to=
 at
least see what Zhaoxin CPUs do.  Zhaoxin is taking over the Centaur CPUID l=
eaves,
so unless someone happens to have access to a VIA CPU, that's probably the =
best
we can do.

> Or even Hygon? How compatible is "<vendor>_compatible"?

I'm confident Hygon matches AMD, given that Hygon inherited pretty much all=
 of
the Zen errata.
