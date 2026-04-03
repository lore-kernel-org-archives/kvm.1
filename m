Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CF3128BE
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254614; cv=none; b=HRpTvU5aTDQ/I534sgzj3wnlHMCEPYOd2yVmm1v2nPQfe19RKhxrBiddx3ByULCPGPQ+w/685tXkziHG0kmoaz734d5q1QoGAM13Gf4ClT49P7RIiqV5T9LA66jgNOv0UqieTz92ryviKugp1h+XQAjjCGMgd540twZ2Aj5VB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254614; c=relaxed/simple;
	bh=h3Lr8YrnJZczhyx4c06GpesYKiIqt9B3A8dczXvnO6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2XvZSe8SsmdijHLC2WG2eWvq9MtDUbyFrJu/dXVUJGHisQ7m6POINeH2lXedI7tWE1Xj2hi6gaNmcPA+I8AbPild5J1ABAPZkwgQfy8Xv5ChZUqIt1IM332BZaWLpnRMarNWc5vdlrLBUWTqZ2QzLNhy6tPu31s8dLQ7hcBrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+b7nwcy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+b7nwcy"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so2526228a91.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775254612; x=1775859412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8AaBDHxBRn2oTT3edYRcnJC1+cZ898m3mOOQM1coW0=;
        b=t+b7nwcy8N/5MrKX/7KRa2+yFds9pWm9prAKERkALkGXe2XhqerXLlk0zQPHK5q3QO
         VuZENDhRcZfHNanrBCrhOcRP/4OSel6Qjh3CnTBEBECsHbsMusG/8wW6KpfP3X7ptpu/
         ZcNXg+IUMnNnGr5Bt9DypRkFwqOOQzzoB/bAi5n+HCjw4uNTQa5VsL/eMt2pYknhKHcJ
         5cAHgJl1JWv9BW0bJu9wef3kArJCW9giTQqBu3Sqgf0IZuFWoxIMtbFWd6ta3+tlMfZ9
         tbUXwGTcntV1nYGtOzbYOtKvniYBhlC0NiUVafjDkqwg2E1MQdp4BSkfSe7oD7cJM+Xx
         EzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775254612; x=1775859412;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8AaBDHxBRn2oTT3edYRcnJC1+cZ898m3mOOQM1coW0=;
        b=FTKN4g01HgGtdIM0Jtpq58BA2VRpxinvpYb3sEOabvbB22OE7iq2jNORnFWuhd7Dua
         mXuvLHuMtNU6YRAK14c9iyy63SmPVc/srsAVaVvkU5fiS6BWW+7/ec/ZmBcNxn+GQRj9
         PRZ3eGtyY2wt9Tsk1u3LZViLf5mLniaxCVKz69DveIPcKCVsFUpMZnsFkoc/znpbBaH4
         Gx6/TYi0b476K2Si3dJy6MAkt7uJkRxbC4pDjzykqEYyur1QfBDN3t6aE4KaAl0p1SEF
         +ynPJYrRvBJSINibQ3DU4yioQyZCRS44dy3eNmxeteFfNM7kkmrQUrDmexNMWHcbdPUu
         tNNA==
X-Forwarded-Encrypted: i=1; AJvYcCXi14nF+5HlOt4lkOX5VT4j7dikFcVLVKsJuje5GXbqIntVxHBAkmMmyCpGLpPyamhE5lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzapCJCkuLFoQTGYouNaFSiSXz8EAtNlkwa9oF0x+2o2kEPzVc
	XI8iwOYiLCUbZrjC8nLSW0PvtcA3UJY+VLvI0A7mRJKnw9Aubos1gHG0DBog5NWI5YDSTlFcPSA
	PPTu36A==
X-Received: from pgid20.prod.google.com ([2002:a63:ed14:0:b0:c76:9bd9:d684])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5544:b0:35d:a276:a87d
 with SMTP id 98e67ed59e1d1-35de69fc997mr3621742a91.27.1775254611684; Fri, 03
 Apr 2026 15:16:51 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:16:50 -0700
In-Reply-To: <CAO9r8zMcRmWmEZhRYh-PguvJhnMcD4zvWRtnR-nBGAZFt8xo1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-4-yosry@kernel.org>
 <ac_7Yg-Ma4UR2nIz@google.com> <adAOS-dKq72VClS_@google.com> <CAO9r8zMcRmWmEZhRYh-PguvJhnMcD4zvWRtnR-nBGAZFt8xo1w@mail.gmail.com>
Message-ID: <adA8Uj64UB-lLO_w@google.com>
Subject: Re: [PATCH v4 3/9] KVM: SVM: Properly check RAX on #GP intercept of
 SVM instructions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2026, Yosry Ahmed wrote:
> On Fri, Apr 3, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Fri, Apr 03, 2026, Sean Christopherson wrote:
> > > >     svm_exit_code =3D svm_instr_exit_code(vcpu);
> > > >     if (svm_exit_code) {
> > > > -           /* All SVM instructions expect page aligned RAX */
> > > > -           if (svm->vmcb->save.rax & ~PAGE_MASK)
> > > > +           unsigned long rax =3D kvm_register_read(vcpu, VCPU_REGS=
_RAX);
> > > > +
> > > > +           if (!page_address_valid(vcpu, rax))
> > >
> > > Eh, let it poke out, i.e.
> > >
> > >               if (!page_address_valid(vcpu, kvm_register_read(vcpu, V=
CPU_REGS_RAX)))
> >
> > Argh, looking at the rest of this series, and at KVM's existing code, h=
aving to
> > use kvm_register_read() is awful.  This really should be able to use kv=
m_rax_read(),
> > but that won't handle the truncation.
> >
> > There are only a handful of likely-benign goofs due to this mess, but t=
here is a
> > pile of manual truncation and casting going on.  In addition to _raw() =
variants,
> > and mode-aware defaults, add "e" versions would be helpful, as many of =
the
> > explicit truncation flows are cases where e.g. EAX, ECX, and EDX are ar=
chitecturally
> > accessed.
> >
> > I'll put together patches, and think more on how to handle this series =
(the
> > dependencies aren't terrible, but they certainly are annoying).  I'm te=
mpted
> > to squeeze this into 7.1 to make future life easier...
>=20
> Just to make sure I understand this correctly, you'll keep this series
> using kvm_register_read() and send patches on top to make
> kvm_rax_read() a viable alternative and switch it, right?

Yep, exactly!
