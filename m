Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A8431E4C
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936944; cv=none; b=mBJ4/px7OkKtA95lvVcV9vBj0+LebZYF6N4X7tapjRqFManFfzGMf9D7UZqobsIO0wdRuuu6wS4i0qIIvkfbne8z6C/xbdokTHvT1fCBAk8H23IwC1nFbhaS+nMh2rmI6Mfn4DC0ppdjSQI/zvheH2FqJGbU0sz6MQrmnuoMDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936944; c=relaxed/simple;
	bh=0zuPEuau0/m31uD+prrFAtbeimkjKSJSogt79zMuhI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LC4B0bLvVQEXlNpYM0s1pA1E/89LOl+CpNQ0+BS+kUWM6HIMHHPIDFlIIT6ziadbjFGvrFQnD8SC/dfAWLgzQBGvv4BOO99eb7fw79Ag/9alvxufDzKghue89xSUy7DxZbPhXyG6UByN/aSUV4kvZSj4o6OSYXvefTidoKxxJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFIwT9vc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFIwT9vc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847b8d76e3dso1560088b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936943; x=1783541743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEUQtaiHLkrkoXMicqMZB2glwhn+Bg+vbzwIL4tgeA4=;
        b=rFIwT9vc4LLvaM5nhqwotJX06pkefh7kQ55Rb8XL2y5jJSNIboEX3xvUlUOs2EUqAz
         CCCFYusNpnmT8xiDRjX4iWwFgrpXX6VKm0ZDFouL04YNNGYAkqUnh1CDIr8i54nt5V+G
         VQSp/nxggEEGtC74it4WLfFCgOBbvYCh1OYOGK7MLntfLD1dLzbuo2qG+josMs4Lffc0
         EAvB3ilg7bzlIgIc6XQ2OTJdduzqsLvLQq7sW99UXpLb3FD/zXRKSEtW5LZlQL/xGt4K
         nCx1ZCV9D2zO87Bcox11CnRoFxJ/jNyIryU6xhHwVxm9NIOQ3NIYCr8XZJSegPDpD4UR
         18IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936943; x=1783541743;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iEUQtaiHLkrkoXMicqMZB2glwhn+Bg+vbzwIL4tgeA4=;
        b=rKKfJ2VPMygKk2rAjNiawhbx6/zbGz2UOcYL3sTDhohmOoEuf295Njjgi7Mo0TGzBP
         Mvp6BgvR45U9/bN4qGaueKUtiny9ARXj3LuGR+IE2zDUoSs8Jawdzr54v6Mv4vfInSPa
         er5srdN8UBkD494oCi/u5hytpIHRJfHarvUjNYZ2qvn4JoVKPm18Qlufiq0Zg3jUcJU8
         oKKGz2g/vfEf8YXvbftxDHnZ/mfpj32CdwWortLroL8OdRNnz+9WeqHCjthfwPuglInB
         NPrXpYGfQwU1/0PxJuL5HFxoGUraXBgg1HRzkSsd8e+a0IJlA3lHwWj3kkX6eYNZk9KD
         dOlg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9HMj53c56XsC79Nkaa5UDBQSFunpy1egat/gtOwWYbFuJIKfLjCjE5/ASGms0FNOZgFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKydSbhe93+bMn3S0yn8qo6TNDZh3oQiwNMwbbx7dHOuWQiW/j
	RLhRuGer4IBbd/rr8THseXxzC29Xh1I+IeL5mjhEiGnOYrfmr/aDoBVfsDuVj+903SENwDpnuVE
	8TEhdTw==
X-Received: from pgwa5.prod.google.com ([2002:a65:6545:0:b0:c99:3b68:c9c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1812:b0:847:7f65:7674
 with SMTP id d2e1a72fcca58-847c0a392b1mr2818478b3a.44.1782936942465; Wed, 01
 Jul 2026 13:15:42 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:15:41 -0700
In-Reply-To: <5ts6z45hsrkia3gh34cjlfglbp2fwcnwutvzdi236pcmubbk5o@jbmv5ej4gqmm>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622164109.26350-1-andrew.jones@linux.dev>
 <CABgObfYzDQN-2OpM7JjoPe32Y=y=FokJEq2oePYbyASUuxy2yw@mail.gmail.com>
 <ev32z6yxkujq3ctb66f6l3e2l5cx2b33ye76mlqvo6jdsydxsk@hwmgkv5rmqym>
 <92a4d803-c545-48e8-ab5c-647bb04f3560@oss.qualcomm.com> <b3agpqbu47bnsfcfzskdfgymyag6y6be5danltshzwiimybvnh@r4773lfg6vfj>
 <21cd2f80-64a2-48ca-9821-7a233470af77@redhat.com> <5ts6z45hsrkia3gh34cjlfglbp2fwcnwutvzdi236pcmubbk5o@jbmv5ej4gqmm>
Message-ID: <akV1bbcTttyS-FxU@google.com>
Subject: Re: [kvm-unit-tests PATCH] checkpatch: add support for Assisted-by tag
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: Thomas Huth <thuth@redhat.com>, 
	"Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, Andrew Jones wrote:
> On Tue, Jun 23, 2026 at 09:57:22PM +0200, Thomas Huth wrote:
> > On 23/06/2026 18.04, Andrew Jones wrote:
> > > On Tue, Jun 23, 2026 at 05:08:07PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > > On 22/6/26 21:00, Andrew Jones wrote:
> > > > > On Mon, Jun 22, 2026 at 06:43:45PM +0200, Paolo Bonzini wrote:
> > > > > > On Mon, Jun 22, 2026 at 6:41=E2=80=AFPM Andrew Jones <andrew.jo=
nes@linux.dev> wrote:
> > > > > > >=20
> > > > > > > Import Linux commit d1db4118489f ("checkpatch: add support fo=
r
> > > > > > > Assisted-by tag").
> > > > > > >=20
> > > > > > > (I should have used AI for this, since it'd be fun to include=
 that
> > > > > > > tag on this tag-enabling patch, but sometimes I still do my o=
wn
> > > > > > > homework!)
> > > > > >=20
> > > > > > Personally, I don't see the point in providing free advertising=
 to AI
> > > > > > companies, so if I had to choose I would do "WARN(...) if ($sig=
n_off
> > > > > > =3D~ /^Assisted-by:/i)". It's more important to know what AI wa=
s used
> > > > > > *for*, than what AI was used period.
> > > > > >=20
> > > > > > But I won't complain if people want this patch.
> > > > >=20
> > > > > The process is now well established over in Linux kernel land and=
 we
> > > > > encourage kvm-unit-tests contributors to follow Linux processes. =
The
> > > > > motivation for this patch is because I just queued an ARM patch w=
hich
> > > > > used the Linux process and it failed checkpatch. I'd rather check=
patch
> > > > > succeed than to have to tell people to remove/modify the tags the=
y're
> > > > > used to using with the kernel.
> > > > >=20
> > > > > We can encourage contributors to also add sentences stating how A=
I
> > > > > assisted when an AI assistance tag is provided in order to captur=
e
> > > > > the "AI used for what" part.
> > > >=20
> > > > I tend to agree with Paolo in that I don't see the value added by
> > > > these tags -- except the free advertising --. Besides what provides
> > > > $AGENT_NAME:$MODEL_VERSION is likely irrelevant without the prompt
> > > > used. And even if we try to reproduce we would get a slightly
> > > > different result :) Then by the time the patch is committed the
> > > > information is almost obsolete.

+1

> > > kvm-unit-tests does sit on the boundary of being Linux-like and
> > > QEMU-adjacent. So I can see why the QEMU position[1] might be
> > > considered over the Linux position here. OTOH, I'd rather not
> > > complicate kvm-unit-tests development. I'm also personally not
> > > that against the tags providing free advertising. The tags also
> > > provide stats in the long run which may be used to compute risk
> > > factors and/or evaluate quality of particular LLM designs which
> > > can lead to LLM improvements.
> > FWIW, I think we should follow the kernel here. k-u-t has always used t=
he
> > coding style, header files, scripts, etc. from the kernel, so IMHO we s=
hould
> > not diverge here.
> > And I agree with Andrew that the tags could be useful in the long run, =
e.g.
> > if there is ever a problem with a certain AI model, it's easier for us =
to
> > find out which commits we might want to have another closer look at.
> >
>=20
> I pushed the commit.

Heh, maybe jumped the gun a bit?  FWIW, I agree with Paolo and others, spec=
ifying
the exact name+model is little more than advertising.

https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d6=
06@kernel.org
