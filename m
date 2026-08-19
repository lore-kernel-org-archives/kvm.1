Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE429E10F
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104124; cv=pass; b=P/VfE98vd4yj+Qsw7KxXy5KekdT2uAJK7JS6js71vBb7Ttmyv2P19I8Rs2njaCkZWdiGG6OumODnmrk05cvVem6dM7+il0RxbWSgxC2gYyuaFFvU6qV+S3wvjoL4sZsUAgcrfe2iija6GX26gHhEwKIesJCcUo4stWxj/6+/+Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104124; c=relaxed/simple;
	bh=0joFlQFKze2VUT6irZ3O1wZRJqUgaSpfC8SHNl1LCZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSFzRGNQV2tMCX4FQ72zwTxyFJ3SBp7dV3/fKK0aqxUYc7Gbrsr2ouf+K4Fqkfkz1xv6Fu2AyZ8MhxsuYh2JYifrBGt1O8oz8Udqcg16yMJHpAOEL1SeALINAzRI87R/HZ3lorjhlkrMaIiMedZlhkXJDzMNCyRFcDVB7otzIT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8sUS/vw; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8sUS/vw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c169ae1cb26so307001466b.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 18:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787104121; cv=none;
        d=google.com; s=arc-20260327;
        b=sJCpML5+6PKr54CeOlhO3LE5BL+iaqQsQHGaUlRd2iKGkzvQ6v3wml82J5BRoMeTzJ
         4bGUtF/tSwQxIIeh1wSe3K4lpPBsw5bUtw/fKUy0yF5IW5JS9Cv9GpDia+y6YwXBtkjo
         VZQnRfy5myY1PlofWwkk6IASg8EjYxcmJMbPJQ80+0vmZ9srU5UcaQPNc/D97juo5N26
         0AY+n5R4fOuS4/fvQHU4gPtNPUmbb62RGGh9sME5/o7Yf6HRKu9xBjnxVCI1Sf1Vgjee
         PIeltkoVJxgA4kTKkfxdEFrsbmSgS7A01Pz2ny00szvG4J+r00Dm0fFet+eePPb2ex1Q
         TqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        fh=sIMwNpzIMQn7VBjLAid6rzeAbg4EwMyCSnl8+DdDeRE=;
        b=SnCD3BQu6rSZpepfMwXsPj2tXFSLl/cAPSb+dKi1JaQrX60MECtyL7aDZfEduNe5oZ
         a3FD20k4XUkoaTROHxZOCq9vb4Cylo57ButUXDZ1ll4oEJ4Xy6UWASY2Ml8bMrgKWHBh
         zs32eg64JgKy5dZgeQLx8y8KXqgi+RY09mcvjI3A0j5laVhxi5rlU8q8/fvX+J7NzLhm
         lVbs3YGWQR+JI1yNM/LSv7XZYXG+WpnTGBvtJ4lSXY+rK4qSdc8TwPOMdyMRdhIJ0cBy
         rwzhZrOawyT4lVnu0KP7wThNk8QfAwRKmrPhSnM3IOQ8gTen1pXHGAaU44ltzlzyCAlF
         HmyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787104121; x=1787708921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        b=r8sUS/vwemYzO8YHnfPCZnxrOz6R+5DUyUucBpcO/Po6JBzwjYqSSVhhgA/ZcaDnRA
         4pn0ZPmCciXgfhUlTXRzdo88hd/YFQFpE9jmQzcEK0NmARHA3+7Rr3EiZR3JfOkyO9Pw
         nvowT+715Kex6znGdrKkOHUpwy0wmRc2rFxkCOirFIGw8Z3GYYc//ieJz+18CwjIo2Uc
         UALOZZJmuwueJj7rV6Af/EUv5D9UR6ypM6YrE/RO67B3kH1O5ZGPwwY3Cq8OzwTQbibw
         m/aZGk8y09vopjHNjSdQgwEUmOPfS9KCnnaHWghPxjMY+kp4YAgJ0b2ZbLKbG7OE9B7g
         tdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787104121; x=1787708921;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsCtmvkS36zvX0w2r9pYrglPyEHrvikivJeQKgrGG38=;
        b=kvt9NatqJKyvSWEOhvuO8BjbujrdKPXdYwQYFXOnSGH9+9ugC6gGgj03aU8it6Kqij
         nlRHAH1LlkFeRwcxhlsx9cPY80XNElqFGENOLqKVX2UuhWm6G5CEjNoXaQVfzuolwD0E
         62r1VgwapM9VIzHXJxdiv+AsF5bRr5Aslctv+AHPX14ZEZxoa9tX66H6karUxaFvmoII
         KLnSuClH12PjvbLlE4g84m4f3g9Shbhu3VctW2Ifv6TR4avl/m1z7/mDc9mnvwD4sqpc
         4JozGqoogBecWDTkJkXPrpMxD1fQLEEmICRutPe4maD5uZp9ZMwkveVNeq1yLtkA0z5g
         Nwfg==
X-Forwarded-Encrypted: i=1; AHgh+RrcIGY7/9qYGrFV1lH9X7N1G7a1q9Fh/rvoHGrq+zhZykYszJanGX9lkVlzMlOUbCuHH9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmsWTBtIeHsodNnOoMVfiAU2lhqYHSglKsxrexeFt4Pmys4DGn
	O7ZxYmRtZE2egioCwDF1Pz9c3j512jY5c4AkwANCjFaunsC32Qtzhp0oKQprohmt4rI1XMnFjDZ
	Ds929Xx/z3dFwzTmVjVkrzapZ5CPNQEU=
X-Gm-Gg: AR+sD11wDVABboD9KeSgVketFo/0Kr5n0P7yQJiu0/VsUh8mDE6hBeSY1jnUG0iRQkQ
	YIiNTZSVK82G/qprpDbMwoMtzY7lBtf097ym9qs28lmKxOK+4PqNaHeM/AzyIxlH9WdHdiO3Huu
	NMa7PLbnFWKNZe1UxOceyZxseYithZjndHClY7bs8uo0xKs8JyaJrkPXg3lCjS+5qNr2hxujF0z
	2e2JdXV+IPInAQKm/yULNDh5u6HFEhZwYIKd8JPobCDBKDMTBWogDdQFhTiCbTzM48zyJeo9ItF
	sJhDqvmSx9uMd0laGO4i6WOhsdUsPIrWqdF/9k8YjU9zWnFfpVL1lYa50dCwaao8pLW4ugukNC1
	kBQ==
X-Received: by 2002:a17:907:7b9b:b0:c21:4698:ee9e with SMTP id
 a640c23a62f3a-c238d4350f3mr56079666b.7.1787104120708; Tue, 18 Aug 2026
 18:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
 <abe4535e-c72b-4df2-99be-064479b685ec@intel.com>
In-Reply-To: <abe4535e-c72b-4df2-99be-064479b685ec@intel.com>
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Tue, 18 Aug 2026 18:48:29 -0700
X-Gm-Features: AcwNN1WStHFp7p4p1eOrc7FqRDLjsrfvmvwB_O2N-MMedPQitFU8wUiQ0JSfFx8
Message-ID: <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Sean Christopherson <seanjc@google.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> On 7/24/26 08:37, Christian Ludloff wrote:
> >> My understanding is that the revert was considered because TF32 never
> >> reached any implementation. If that's incorrect, I'd certainly welcome=
 a
> >> correction.
> > Both TF32 and TRANSPOSE made it into a product that shipped.
> >
> > Not from Intel... but.
> >
> > So their CPUID feature flags and their opcodes aren't reclaimable
> > and efforts to rip out their software support are counterproductive.
>
> What would folks' preference be on how Intel should document this going
> forward? Just leave it as it as enumerating TF32?
>
> There are notes in the SDM like:
>
>         Intel=C2=AE MPX has been deprecated and will not be available on =
any
>         future processors.
>
> There could be a note like that for the TF32, I would imagine.

Yes, that terse sentence works.
  Once for AMX-TRANSPOSE.
  Once for AMX-TF32.

If you want the back references:
  TRANSPOSE got dropped from ISE #059 and APX #007.
  TF32 got dropped from ISE #062.

In terms of the opcodes, it is like MPX too: no recycling for
a long time. Luckily there is plenty of remaining space.

--
C.
