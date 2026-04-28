Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401D2F7445
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413812; cv=none; b=FkrbQO3dqosbkCidOLw/EpOdMa/ncmSJt77Fi7E0z+ZwmzEWk2g7j3MJ0wDQIOXbt5xTnXErGAhbKb6rkBgvkc2skEfaos0NCaF/mSGp1I47YWSrO83fTqeg/gS8ET7y3tq/JS9yGbUzFlgovMJbuqCRh1NJ5vHYo1GAarCb6Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413812; c=relaxed/simple;
	bh=d6wlWfAlNzmZywTUab2iHAN93VEkTjYCQuFqfVHhy5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eCBaOUh5VricY3pwVlBuko8piGEP8Yvuk0qgj+su2L67Z1cHQ6fvb9Sg7/+mUXJg80mvSt0/R7ZGO7wrqFvnIphkH8p1B/wAlSxXH3QcXr1sBBjIIPqzu0Nk8BN9KkDQl0EI9BL+FzDGhNBoqqVdWJqsnhwhAq0Hc3hceAGeogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRv1YDtc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRv1YDtc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b79f4b35b7so60547775ad.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777413811; x=1778018611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiScA0jlgKQS8SiM5Z4RwZdEXof1LD1UadEyrjdi2R4=;
        b=lRv1YDtcdmk275jFOxLQaNY3mF8wzlRauybP77HaYQdA7ZQ9544Lapt85D+GgfySC7
         lykbeilYt/BxgTDxOTsSyPsfBx0CCWhNwBZ+yHkYv5+saKcI8vWZZnzWTk0YbO+Uspk4
         AJwwi2+GfGiga7wSCGFeO6gTaz373/B1HF58VCasQl2ga8X2CRVRErs4cmwc+VRaFs6e
         XaxBKdnExD1PoJcd20GU/B5IULN/3B/2LZ5USZBiQVsUybLv4QyDjTuDZjYaeV3eqonj
         k16/Xc++PxAgXbYWLcZMAV606hRdnXe86ypKehZqLH31bKd43oYxcsORfY118cVFZnaX
         u/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777413811; x=1778018611;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XiScA0jlgKQS8SiM5Z4RwZdEXof1LD1UadEyrjdi2R4=;
        b=JFuyL7oC8Eo4VL1WL9xB7r7qCmWNpyDZC5W9xYXj1MqNmrxXQPNBJc2qYtp6qRgssq
         5tXfG0/Ct6rj7764+G+h/9CVY6bO15+hbbbmoZh2sQPcEgyIeSM2JV40Vbcrb4emrnjQ
         kYqwPvYJAm/c0THZNwqV2J+tcic7f9miRL4IT6FBDCnKX55RbcQ/hZsC5GXLKGnEwKuE
         9WjDFvvZCST0j0+t9RARhKDz4Xn8/9adkdBlzwXDvrMw6MhEAgRyyCK2xAwpzpt0Ocys
         4RRKBxY5t4W4BEutnV6jo2WnUbY3VWufTjYleUgqlCnjs+2KHd02e+reu3/+9erIHG+J
         QSxg==
X-Forwarded-Encrypted: i=1; AFNElJ9sub78AudB40hXngQPSUjJbAfnsXatDXTGVzoHXFF+oXJ+fZHGM6tN8BbNkQMpD9Darqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7T8vPvsumgHxSM9PZ3/hvdDllifbFP6QHeta31A2FC3Z4Zkf
	GzI9CoCXEn1fxMGELWFFQ6E619so8HFJRImPTR5ymi6fxBej2+3BGmPq6WwNssEdYepl3VSXaI8
	stdk+tw==
X-Received: from plgm15.prod.google.com ([2002:a17:902:f64f:b0:2b2:4865:84cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0e:b0:2b2:6cab:313c
 with SMTP id d9443c01a7336-2b97c478cc2mr46645835ad.20.1777413810582; Tue, 28
 Apr 2026 15:03:30 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:03:29 -0700
In-Reply-To: <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com> <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com> <afEEN_4ufBcQld0q@google.com>
 <afEQDT_nv0kdlaBU@google.com> <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
Message-ID: <afEusUxXDpFtZvV0@google.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
From: Sean Christopherson <seanjc@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>, Ted Logan <tedlogan@fb.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026, David Matlack wrote:
> On Tue, Apr 28, 2026 at 12:52=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, Apr 28, 2026, David Matlack wrote:
> > > On 2026-04-27 06:55 PM, Sean Christopherson wrote:
> > > > On Mon, Apr 27, 2026, Jason Gunthorpe wrote:
> > > > > Even though this is a 64 bit build.
> > > >
> > > > Heh, it's much funnier when it's happening to someone else.  :-)
> > > >
> > > > KVM selftests went through these exact pains.  I'm pretty sure thes=
e are the
> > > > relevant commits (the empty targets one may or may not apply to VFI=
O).
> > > >
> > > > 9af04539d474dda4984ff4909d4568e6123c8cba KVM: selftests: Override A=
RCH for x86_64 instead of using ARCH_DIR
> > > > 67730e6c53d70fb31618230f81c4acee9f72eaa3 KVM: selftests: Use canoni=
cal $(ARCH) paths for KVM selftests directories
> > > > 43fbd8cd389faa9760c5152b1c58e893c812953b KVM: selftests: Provide em=
pty 'all' and 'clean' targets for unsupported ARCHs
> > >
> > > KVM selftests don't prevent 32-bit x86 builds though,
> >
> > Yes they do?  x86 is an alias for x86_64 (or vice versa), and so the i3=
86 target
> > gets binned into the empty target provided by tools/testing/selftests/k=
vm/Makefile.
> > And KVM selftests most definitely don't play nice with 32-bit.
>=20
> Are you sure that x86 is an alias for x86_64?

Well, I was quite sure :-)   But scripts/subarch.include disagrees:

  SUBARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \

as does attempting to build KVM selftests on a 32-bit host.

> If it is then we don't even need the __LP64__ stuff I posted.
>=20
> But when I look at the top-level Makefile and imagine running make
> without setting ARCH on the command line on a 32-bit x86 host, ARCH
> will be set to SUBARCH, which will be x86.

Yep.  So the big question is, why doesn't anyone complain about KVM selftes=
ts not
building on 32-bit?  Because they most definitely don't build.
