Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56C3839A1
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550847; cv=none; b=ifd0pPuNYdgqPcrgN3SnsIwsidVGaG6lGPwfVN2gq8MzXesl04hM07qqvPQs/jFrWtriHL//xvVSsnDLls0J0U89qOqgMaQx4F9SkxqDScj/9gxwZnbI7xheN/1r6FTD16OB4Eb53Y2zFGyInzhfSDl4dtuf0dP1+KwdXZygqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550847; c=relaxed/simple;
	bh=qhGw4WaAvR2D6BZq/c2SGM6eMLuDwIODKQW5IVkvny8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sz1Hs1Bvan8ZPR3jSm0dLY4fAAr1legcU6bjbhH7o1/AH6MUaxCpSdsiiVCMtSACJsp/6WNVQVr25E/NfbKALsrvc/cWy9andJhAsgElBpxZlVjsCW4ZSMmFdc8M4wC6qaavM0n/lMIYE/XpEWL8V1XjLs01Z4eFWpVa3NLINY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AsjY7yph; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AsjY7yph"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84885a4fcabso1198285b3a.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786550845; x=1787155645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qhGw4WaAvR2D6BZq/c2SGM6eMLuDwIODKQW5IVkvny8=;
        b=AsjY7yphxaz7CsR3aAusLXJhUo5WKPYcNfcuuPQcmLBxADJohlA0qP2c65hBZgva9s
         Hl9i/qdD3Xi1MMvbcv/MisLUs0IKheFHfN8WhAK/FQk4Z/yFXb3ZIvjA+d/2TlF0qqRJ
         IMbjfX3HJH8KHSzi+A3PCVrosCw7d1MHhAcTbU3nCE8jB3zzSG26X8F7ATCKfLS9FeU3
         MJtsEEkFLfGWW2ITgGPY75Ol7yy2VRgi+xGRh/eVjLPxP7zLFSt7yK6X0oseYMsQvHjc
         qqP1ChzrGg1W+BI6sJtS10prr48aTiIiju7BbScLbNSSMMlhnhnwzMv+yoS76ymK3Tbq
         lJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550845; x=1787155645;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhGw4WaAvR2D6BZq/c2SGM6eMLuDwIODKQW5IVkvny8=;
        b=Zmeg03J9JaWYlVkOYKuR95orSNNFb20g7HBgUAcznmM0lbArDkPTNDH7wrphVT/jiw
         r2XLezV/FwGeVzZ7hT962DcTxYz2ohzNY+i3x7TIqBjmSqpsV4qms8Admt0VtyWIid4u
         ivkIiF7ifxyQF6jBmqSYVUGmmR5QGptYNzJ2KdKddw6mW7sigfOeleAdk/z3UkB9aXje
         vdAbV/aA6nOwgwFjgZpAyZCn/KkM6S49hKAr7Qv7m+KqOG63J0S/jbHjvO6wdqVPw2gW
         kfoYX2QWxV1z7gQR1zhE6GmPn0XxIYxMnVnbSKGLens42APvs2oA/ojVrM6IQw35/vlO
         Z0Kg==
X-Forwarded-Encrypted: i=1; AHgh+RrsSK+E3tmo3fq49yFvKtBIawf9q0lMJ/PDZC1G/CPkWL4HpHMv3Rm8qv5NyCYiwuMgtt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTqpm0vGc+XZiKNH/9q/6w5cnB0SuD7bh8mdzqW2QQX3WALML
	CX+TrFjW5MTliE+wMrr8rU9hJfmqoXg9GnpAw7c9svX3qzosFlUvFwWSd45DLJybOP+9RNsNQIP
	rDjbyKQ==
X-Received: from pfiu19.prod.google.com ([2002:a05:6a00:1253:b0:84e:5c66:796c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1311:b0:847:9c3a:b77f
 with SMTP id d2e1a72fcca58-84fb55806bamr5778881b3a.35.1786550844921; Wed, 12
 Aug 2026 09:07:24 -0700 (PDT)
Date: Wed, 12 Aug 2026 09:07:24 -0700
In-Reply-To: <824a27d101d5b2e2a8a53fb81f5e4ecf15140a1f.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca> <anuAq2s4mtyw4_Ql@google.com>
 <CABgObfYR+vXBuSm3v5jbbZL8vF=XnocFAnjumdShgXBzod-HCQ@mail.gmail.com>
 <27f2326dc66d6341174c0e510aa518a1297b66ae.camel@infradead.org>
 <anuo_OxfvJbQnn71@google.com> <824a27d101d5b2e2a8a53fb81f5e4ecf15140a1f.camel@infradead.org>
Message-ID: <anyaPHoUfkyxzCiG@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Fred Griffoul <fgriffo@amazon.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, david@kernel.org, mhocko@suse.com, 
	rostedt@goodmis.org, bigeasy@linutronix.de, simona.vetter@ffwll.ch, 
	jglisse@redhat.com, christian.koenig@amd.com, paulmck@kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 15:58 -0700, Sean Christopherson wrote:
> > On Tue, Aug 11, 2026, David Woodhouse wrote:
> > > On Tue, 2026-08-11 at 22:21 +0200, Paolo Bonzini wrote:
> > > >=20
> > > > for_each_present_cpu(cpu)
> > > > =C2=A0=C2=A0=C2=A0 if (per_cpu(kvm_gpc_reader, cpu) =3D=3D gpc)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_set_cpu(cpu, gpc=
_readers);
> > > > __kvm_kick_many_cpus(cpus, wait);
> > >=20
> > >=20
> > > I'm literally sitting here watching you reinvent what SRCU already do=
es.
> >=20
> > The problem, for me at least, is that SRCU does this and a _lot_ more.
> >=20
> > > Which, again, is *fine* given the behaviour of *these* read-side sect=
ions.
> >=20
> > Well, yeah.=C2=A0 Why use a nailgun to put a nail into the wall to hang=
 a picture
> > frame? (other than the indisputable fact that power tools are fun).=C2=
=A0
>=20
> It's not a nailgun, it's a drill. And in this analogy, my observation
> that it works absolutely fine for us with *these* SRCU read-side users
> ... is equivalent to finding the torque setting that lets you put it
> into screwdriver mode.

Yeah, but my concern is that there are KVM users out there that will put th=
e
drill into hammer drill mode, likely unknowingly, and then complain that "w=
e"
put a hole in their wall.

What I want is a strong guarantee that the user can't configure bad torque/=
mode
settings, even unintentionally.
