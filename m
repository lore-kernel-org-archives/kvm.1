Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1003E49F6
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821316; cv=none; b=qe2lJmJWh+CjXz5TVKLbj3jUPsXWmxiN+SMXd5137Uk1gKv0w4Z8esqtNc1QKcwg/lGQWzGhano+2I6UKS+rMQTkS2ttnZ24+xsHREvfoWggb5xYNaleS3+aexA5JieKrel9H0eX3aOWOMkVzOmwe39/zfwjbP5lQckqJS9Aucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821316; c=relaxed/simple;
	bh=wkTjDvro31Z7Cb9CrOFouQ5u3R4WipcefR5jbWng4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqVWirTAZNWv6iPqEt1WUufHlDlcX5lkKAqzFCgrPBiYo19s03aVp6DGQPMQpkWW4CpFH7OXXWk4XDzOveiEEN06VGHeuHFWDepMBltRhiXxBX4eu8CvAqHjas15B/QkM5ShxIn41XRLEwrxdXHIPDNwGn4HzcK0BRzOHCXcbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9WAhsox; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9WAhsox"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49557167508so4851985e9.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787821312; x=1788426112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kb/Wi6oNPcoOC248sdfl/gNH6Pq4KEL0EAbb7WYkBJ8=;
        b=o9WAhsoxAIRld9JGbZIgaeTZNTjm4YB8cYsQPng7L3rrmvV0cZuRc7F4ExpVQqvqoA
         OrqmekMz5S2Y47NEVTnK2ZHpgyYqbIPGOGe4UZZtprHjw4pExoaVB/J40sZBxaGTj32E
         IndRmnKlGJf9StqliZqUEZ972uGNNUbwyM0spIKQXnQ2Ww63trGxP4ipOmzyCzmZgkB/
         feucI8UWIdrtqi1h33hAJfBvbZM+f7LBpAA90RCy4tf8GHQsGKZcXMTc8ZJfebjTMN1X
         ofBlz5mJuuYEuI+i0H63OuKAGwBcr51wNcOa9gqRX4mMBI4RRlX8wMO7wTmm4jrAumgd
         2Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821312; x=1788426112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kb/Wi6oNPcoOC248sdfl/gNH6Pq4KEL0EAbb7WYkBJ8=;
        b=Pky4VvzuZJ+Q7yhYMHdYWHNwkADyO8Pt6MlGN/p5uRNEB77zfqJ8OOGunN0DdOoVxG
         figNfd4opFd9lCna/twH15K/A+9wGgB8A5tKo9hzc8mYqlgRjmHdn7qrwCLqp/jLVvCJ
         eqjrqB0VIxj7Hjqxp0GG5kqvtfXwZyBJfScr6fATInjICc8O6pcjfRbgib9qOk6lsgXR
         JSnQVzJVYXYlUddpC+nYS8Dj/N+vhsRhPcXTWiakW4865+NjClIFSTmv/fkTT/IAXyJR
         nin96LYjKa6CLesNNTOZ9O/nqWE+2N1TzLrY4TV7wKkoGSfobEbk0GObIjyYzJteg4DU
         00qA==
X-Forwarded-Encrypted: i=1; AHgh+RpEGw3Y5wmbmiwc/ZFkQjuykwgJQeIzcKqnPLusPA/xLO+nuVT8YuP9v5melo+XQvNJGrA=@vger.kernel.org
X-Gm-Message-State: AFuF++mMDFLfw1DxCqHJs2tGJjfEG3DwwVoxFWvMmqC02BcjO9zPuN9B
	aaqs8nb0B9Vt7v4Lf6aEDUeVhjb820O99eDhnmD4KV1fTdLOKDrqdYGw
X-Gm-Gg: AR+sD12jLnx45XSSgbBdETCW2MWVg281e/kcqO4qKceMeXJaj7Atkf2V6hrZisM6ESv
	SySImAi4ubohJve1nfZGcb7mL5XURrkZ6aBnuTOPCri/3cxjGk4TTPtU6J4/F7f5zt5rwbvV/vx
	0wfHuDZF1aBlAxEiQR+sFmUTdFcu8BY+CaDbeMTFlEpRB+4+fvY4vk6b2b9qJxUfBEJgw/whAu7
	RcATOM65B+gbzKWgqlY1b/TH2VFTS4yZ4M4LUV/nCk4g7K8+ljmMH5jandZTGkZdh7KvJ2RiYDC
	1awI6MYZfJDYKDFkEjBbvd8jtDiv5HulDMFIniWpAdpU7/25ISXZde+T4Na6e87WxKzhKmGGWYO
	jlAWx3UAvbwCPoKLMAB/vU4Ug0k/D8tNw3za2wLVMCXnFcQ4n6mPZXvJaqv6uNuZKQGNFra8Vm8
	Fr4EVUH5Ndo7BiNhEFOcQLfxx+oMr7yRYLEeh6HfBbdQXC94jiYUIRGSFtafMWOvJoZBFNoSFtZ
	aXbhQCOkZD/O7BCYiDOZ0/Lng==
X-Received: by 2002:a05:600c:c0da:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-499dc820705mr140148765e9.9.1787821311647;
        Thu, 27 Aug 2026 02:01:51 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49236515sm53313005e9.1.2026.08.27.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:01:51 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:01:49 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Thomas
 Gleixner <tglx@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 1/2] x86/uaccess: Extend CMPXCHG user helpers to
 128-bit operands
Message-ID: <20260827100149.10004212@pumpkin>
In-Reply-To: <CAFULd4YFphkN4M0a_gC=vxN8Xgh4WWBGPo8dO-o6A3v9RGX4_g@mail.gmail.com>
References: <20260826070004.8100-1-sarunkod@amd.com>
	<20260826070004.8100-2-sarunkod@amd.com>
	<e32c1437-44ab-45d9-9534-124a9e09f029@intel.com>
	<CAFULd4YFphkN4M0a_gC=vxN8Xgh4WWBGPo8dO-o6A3v9RGX4_g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Aug 2026 15:19:57 +0200
Uros Bizjak <ubizjak@gmail.com> wrote:

> On Wed, Aug 26, 2026 at 2:30=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 8/26/26 00:00, Sairaj Kodilkar wrote: =20
> > > Extend the existing user CMPXCHG helpers to support 16-byte operands =
on
> > > x86-64, using LOCK_PREFIX "cmpxchg16b".  This mirrors the existing
> > > __try_cmpxchg64_user_asm() / cmpxchg8b path provided for 32-bit kerne=
ls,
> > > where KVM needs an atomic compare-exchange wider than the generic
> > > cmpxchg helper can provide. =20
> >
> > Please take a good look at the Sashiko review:
> >
> > https://sashiko.dev/#/patchset/20260826070004.8100-2-sarunkod%40amd.com
> >
> > It looks like the "A" constraint isn't one that you can cleanly mirror
> > from cmpxchg8b =3D> cmpxchg16b. =20
>=20
> Actually, "+A" will work for 64bit targets, as long as the variable is
> 128-bit. The comment in asm.h applies to 64-bit values, where on
> 32-bit targets they fit in eax *and* edx, while on 64-bit targets, the
> 64-bit values fit into rax *or* rdx.
>=20
...
>=20
> That said, the approach with union of two 64-bit halves can lead to
> slightly better code, because the compiler splits the value earlier in
> the compilation pipeline.

I think I agree...

=46rom experiments I did with 64bit values on 32bit it is more the case
that the value never gets assigned to a 64bit (on 32bit) 'virtual'
register. If that ever happens all the operations are initially done
with the 'wide' register and then later split (rather than being
generated as a pair of 32bit ops).
This causes excessive register pressure and even spilling of constant
zero values to stack.
You do seem to 'get away' with returning hi << 32 | lo.

I'd guess the same happens for 128bit values on 64bit.
(This is gcc, clang does a lot better.)

David

>=20
> > Uros, any chance you can give these a good once-over? This seems to be
> > just the kind of thing you've been fixing up lately. It would be nice to
> > get them right the first time. =20
>=20
> Based on the above explanation, these *can* be copied from 32-bit asm
> patterns. Even "q" constraint will include all integer registers on
> 64-bit targets.
>=20
> Uros.
>=20

