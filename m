Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A5448097E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157698; cv=none; b=fYZzb/renYASJVcbghSpzjH+TS0BHY3ExxpM20yr58hvyz8EcovL4BDD4RvF9v5uelDgFRHtRiI3/l9BI++WV63WGGKL0SiTCv9MX8K1HaZgPYWtDoz+q/pfWEX6Mk58sSuguCjKg1wsXMOB4NMpH4fhp42n575rsW3my0t5IN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157698; c=relaxed/simple;
	bh=Z4w0jhcQvhCI0bosMo9w46ys/yNsvZhp5zSOIajIGvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JrW0yFBdIETgNM3tOHj0FOeihGWsdPIOkfbESt/7Uw1+W8IK9fXySbctU6Ljkj6IxjbI1Sgcx1ZfY5rRnMMj1RASNvjchWhcaQIt/EIsZtEV0GWo2zKcnu/HFaQppQYzeeNGVggY3ib9M360kdhv2rXOPGgmb3Ve32EDnj6jDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xrv05/ql; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrv05/ql"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso1614935a12.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787157697; x=1787762497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G2Hz1YJdLVa7+hLxZtMeHXHTsMIJrFof6Tpk0CJAbWU=;
        b=Xrv05/qlyVVjlIoQe0a0aqODhxhSwJvjZAuAKTtW4AZyFT8nYFDlza7K2zyU08Gsle
         9tnwX2KpVBe9SIcVctBQ6ij5bc+Ibare0X9VGPjf4lACg6iZo+BVvjE8OzxTEHXoyEBE
         CXxLCGP5hO+QOdW4ELL+hupXj/5SDf843vm+WyRBO4HBY7le97x2hsG5SxnoMjTsXuii
         b42LvktGZJSCrdiMIvoFXK5ICmBSZBsibb8OsK8Uej6RNcN8FkhC59Hg0uwOAW4fFVFS
         0Kz0toVafLfDg/u3zx4/W2RQhnnojZB7+qxHOKlnZD/CANSAG9UKfkvryB78bHEJyPp1
         hGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157697; x=1787762497;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2Hz1YJdLVa7+hLxZtMeHXHTsMIJrFof6Tpk0CJAbWU=;
        b=EzlV46hkgmPlxzUumzGppD5R9VVH10GVcZYJxzWjuaev/yPPIe6IH2PMNgB87vn3S1
         2lIxXIsVovf/N6+03Xbgv2aTJbsA1l6MOHBDyvyCOcimnzsQdYXHi7s6J2Y2bwz2vomb
         QZLvkWmbeiwlHUHKfb7uXUV98rrFXY6DMXXh7I/gJXJleXOqXRgmHkAVWFxb4fGhH95z
         qUGc43y5Kgs8k4luhnV9oJM/6WvutUoH6ScUgkhAnhM/7/b0CNcruzzecVTUHtDfE1Bz
         cc/Hio31WRM0SExhA+xrDghwZDAcntn7dIfHz51Xy/or0/d+a7aHkA0/S2G1oDcxkBgJ
         MKMw==
X-Forwarded-Encrypted: i=1; AHgh+RrxnqAoDnGww2dNRDG61SlESIRrrsnumV1ylz5NhRHa3AuJmZFiR8dXpB7HwQJICD+6lyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjldcn4xKCCx2Zr4trndM7wJpYxIS28UoEr3D9Gx/GjtfcbEZC
	Jeig39Efx0VAKr2OFc6rGkwgOvLjhv4TsEVQNyJncM2RJsL6wp/nsw8KRojhnsOagnQ2WX+557l
	3S6+Wvg==
X-Received: from pfew13-n2.prod.google.com ([2002:a05:6a00:c1cd:20b0:851:c4fc:fe2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c82:b0:851:d12e:389b
 with SMTP id d2e1a72fcca58-851d39598c3mr10615556b3a.14.1787157696399; Wed, 19
 Aug 2026 09:41:36 -0700 (PDT)
Date: Wed, 19 Aug 2026 09:41:35 -0700
In-Reply-To: <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAKSQd8V=wfVrUxeU+fDRgKJBLdiyCkkY2SRY+OoRBNE68LFnCg@mail.gmail.com>
 <abe4535e-c72b-4df2-99be-064479b685ec@intel.com> <CAKSQd8UyzWweM15-9ehaCaYYJYw+N8z9pFon2J+3sehqm=Ukbg@mail.gmail.com>
Message-ID: <aoXcv795N-xmtTDl@google.com>
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
From: Sean Christopherson <seanjc@google.com>
To: Christian Ludloff <ludloff@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	stable@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026, Christian Ludloff wrote:
> On Tue, Aug 18, 2026 at 5:55=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> > On 7/24/26 08:37, Christian Ludloff wrote:
> > >> My understanding is that the revert was considered because TF32 neve=
r
> > >> reached any implementation. If that's incorrect, I'd certainly welco=
me a
> > >> correction.
> > > Both TF32 and TRANSPOSE made it into a product that shipped.
> > >
> > > Not from Intel... but.
> > >
> > > So their CPUID feature flags and their opcodes aren't reclaimable
> > > and efforts to rip out their software support are counterproductive.
> >
> > What would folks' preference be on how Intel should document this going
> > forward? Just leave it as it as enumerating TF32?
> >
> > There are notes in the SDM like:
> >
> >         Intel=C2=AE MPX has been deprecated and will not be available o=
n any
> >         future processors.
> >
> > There could be a note like that for the TF32, I would imagine.
>=20
> Yes, that terse sentence works.
>   Once for AMX-TRANSPOSE.
>   Once for AMX-TF32.

Maybe use a similar approach as is done for the HYPERVISOR bit (0x1.ECX[31)=
, and
have the "Field Name" entry say Not Used, and then use the "Description" to=
 explain
why?  E.g.

  Register        Field Name      Description                             D=
omain
  EAX[6]          Not Used        Intel processors always return 0.       P=
latform
                                  Allocated for backwards compatibility
                                  with software that expects this to
                                  enumerate AMX_TF32.

Or Christian's terse version (I kinda like the terse version).

  Register        Field Name      Description                             D=
omain
  EAX[6]          Not Used        Intel processors always return 0.       P=
latform
                                  Once for AMX_TF32.

=20
> If you want the back references:
>   TRANSPOSE got dropped from ISE #059 and APX #007.
>   TF32 got dropped from ISE #062.
>=20
> In terms of the opcodes, it is like MPX too: no recycling for
> a long time. Luckily there is plenty of remaining space.
>=20
> --
> C.
