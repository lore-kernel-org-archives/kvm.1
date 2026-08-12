Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887745C6F6
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576242; cv=none; b=iXjlIPJLKD5ihriMrPXxYMTWx9+l9FWdQbzK02mFPza+uEySL44hPWVQqeMMtMrGZPBqRf3c4MX2D3IKFW3G6lWK7Smw90RHZ4ge1yUTzxAIYn2iSXz3cGqd9PbU8+5U8pTxPm0civ/CFo0pu3VZ5gswZZbVD/pBYdkoJHhhvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576242; c=relaxed/simple;
	bh=PWilD9xVtNGdO3Uy6TxTN16d1Yo1Ku7NjIk2U429cdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oHqY6sNyyBJ8RABKfH2Ze2pQCRPwnh7frgBQxjGx2bZrmrsTse8wezEPoU7iZFl4fezBN8tSkXrkvj2emh6GpwYTBFsUH8/ABjmc4EZTPTOdQDCCfdZBtEgnbIzRo2rmS6rxDywOuc6Kr7unEiotlndBGPlK236/QGQeQUgbDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLabxtZc; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLabxtZc"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1987460a12.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576240; x=1787181040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RLBNTc88EjJxi9sbuWlT2lHuO+uKsoJ8s8VrdcOLrzE=;
        b=PLabxtZcWzxZi7/DmJu2J5rvbdD6J3wKMLsJa8w45lQPWXIu5vG0rjpwSSsA7qfe5y
         UDjciV/sPb9SuBAKlrMaT+NpMSuvuEgCqqK61Rz6Lnf8Wk3E5QAfc+d0nwXwO2FfIuLQ
         tKlFFlhSlRFwYsF2pqykq6h6duvXcmNYmn23rYJJO0HTRAmh7Uxtyjzxfu+EEcnwPUFz
         cSL4GfAPxW9SN9NS5gUygSQBsC34wMMwvawQB414oJKb6hajuSOgapFY5756vEGdi6Xq
         bLPk0T4x2TOszVti0vSwR3jaDFPbdZvBWnntxhUwMXpUzwHQ8DqiURuSM0lFC8DSFxKp
         YY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576240; x=1787181040;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLBNTc88EjJxi9sbuWlT2lHuO+uKsoJ8s8VrdcOLrzE=;
        b=puUcBKVMd3aAN5qQeCG7sYbh2ajOK9hClZ0m1cp/f5XA50hZ/j+jOjzKvYZ9EmyOgl
         o2uEzKkot4RAdDtGvG0w3jaaBX6rhG8rqmIeKOnQLkMEr1GKAjtJ8ArlwsusrlSpYNjn
         4eQjIWAzsz+/E8+V4vIMmZM756zXxPYe0ryZ6roLVQRjm4R30RFkeIzp2XVyD8FT/wro
         oyYhUjZJJOr6+3svGe2yhCcjANxOEz93y38uFycLBKyBpwO7Bo8EqGqEn+Le28p3CPLi
         Emva5IzLFyHRh5puIoi8EAoQk87RYVyfpt70Y63GKKqi2FljzXq+084eQILKLn1ajraC
         +CtQ==
X-Forwarded-Encrypted: i=1; AHgh+RotBPCRHLZ6ahDdmlQz9EuU5Gnczzc24TsPI/odlRIoa01Id5LminhQAIff5lRaJJf3n8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqgMJZvB5kQaQ9yGH8feLwSfM8dvl/gedN4nujX2yh4LyVVwC
	MEb5vMy8hDgnoPdTr7r6F6pQjqvZzmR432tcl0Ke9xijo+ExDZVkGGryORJkr4drnDWERvN6hAe
	1Gru1jg==
X-Received: from pgbdq25.prod.google.com ([2002:a05:6a02:f99:b0:cbe:948f:d640])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1409:b0:3bf:ba48:ca88
 with SMTP id adf61e73a8af0-3cc550e101amr2768351637.15.1786576240369; Wed, 12
 Aug 2026 16:10:40 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:10:39 -0700
In-Reply-To: <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
 <anxvwV_Pz4UYaxxt@google.com> <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
 <anyiwqi9i0NSv0QW@google.com> <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
 <20260812223707.GD1013044@pedri> <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
Message-ID: <anz9b6CDkhr5D5RG@google.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Fang <peter.fang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Artem Bityutskiy <artem.bityutskiy@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-08-12 at 15:37 -0700, Peter Fang wrote:
> > >=20
> > > But part of this too, is that "DICE" is an industry standard [0]. Som=
e of
> > > the existing TDX attestation format is TDX specific, and moving to th=
e
> > > standard is expected to make the verifier better. So TDX does not hav=
e full
> > > flexibility in choosing which bits go where. There is some. But I'm n=
ot sure
> > > which.
> >=20
> > In the SGX era, a lot of this attestation stuff was Intel proprietary
> > and that caused a lot of pain. To follow the DICE standard the bits in
> > the report have specific places to go inside the quote blob. IOW the
> > DICE quote doesn't just carry the report like an attachment, and so the
> > two can't be separated (not without breaking the standard in some way).
>=20
> Yea that was my suspicion. I'm not sure if separating them was really Sea=
n's
> understanding or not.=20

LOL, most definitely not.  Though I have a naive question at this point: wh=
y can't
the TDX-Module extract the bits from the report and put them in the right p=
laces
when generating the quote?

> But the other part is that=C2=A0the verifiers and other VMM infrastructur=
es are
> already expecting this standard format. It would have a lot of downsides.
>=20
> But the "grow the report" or "grow the report and quote" are still option=
s that
> leave the quote in the expected DICE format, right? Sean I'll assume you =
still
> prefer the "grow both" option for the sake of kicking the quoting
> responsibilities out of KVM.

Not necessarily.  If doing the right thing from a "what's intended and sane=
"
perspective is to put some quoting responsibilities on KVM, then so be it. =
 But
I would like to have a passing understanding of what all is going on, if on=
ly so
that I can justify why the new uAPI is being added when I send Paolo a pull
request.  I'm pushing back purely because I quite literally don't understan=
d why
KVM needs to be involved.
