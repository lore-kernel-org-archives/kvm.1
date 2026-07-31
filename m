Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BB35C68D
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531051; cv=none; b=bpaY12EeQ600d8nXZ2t6hDSKmYE/jeDd8Zuz7cxDtyHUnxrxOcqf8GJhy035iqVb6+qyjoi3PDPgRVRSmZNLgi6SEbEYZDWd/7ZKvCFcCY/Tj+QhWiuSAQBX5K68GazyDCc4NhWe6uV8YRM+97oxrXRDbE8mdwjwQoT4URvfBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531051; c=relaxed/simple;
	bh=Hbhi6+KMjpxoERuBtIxFEqObdZKUIZ5jGtT8v620HxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jAyE4JC6ENlihSH4ZIlLgFC/PyJ2wM1E0Bb2vy3uM5uBPaTVoNNyCH7E5xfRUuKFnDUX7A6ff48pIM88bIGjEANIqg85PVnWzexzBk4SSrgYZApWnnrrgoz1nigV+klbnpF+n8toVSk02FRrQVKSsWdk0a95iBY+JIlCQetEp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4T5ICc5; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4T5ICc5"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84eccf9d899so1909115b3a.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785531049; x=1786135849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MJ+1zz4bd0vi4BfDFozlsEf5MBhzPjdddShFFlbqKaE=;
        b=a4T5ICc5lcZp7DFP4DROdD5iGCI0a9WJfKLLM35beTC+vkVnizUZ9fUKKjZWqQiZk0
         d5vBrS6LwfS2isfF3QCqghlcZJGDLY1aZdpoBuTxGu/l6oXqTZslFNBN630u9Hgy+7vN
         w9Hy0SZxzvBlA9H0szMsGeW0MOZ2k5FGo7et+8gICpfk0wocS++SeR2jzUblxbzDOols
         2Ucp9RkEKMVwwo3iKypc5w2ZHYWVb7mNyERgHSj58Yn5Lxk2HJcCKusjH2obou32T/2M
         WOvxJeCE5IRqgT0tw1khSaLlhZ631UXg06r7rXRxDmxfySZcGL8KrD1hwH6EpnHpMw+K
         WP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785531049; x=1786135849;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ+1zz4bd0vi4BfDFozlsEf5MBhzPjdddShFFlbqKaE=;
        b=ILJvzfAkBcsXY1ZN/gAbbVtYnuN12rg0KRms3OumdmbrPaqRjBDechvQBtklS1r496
         xblPHsjtCSfx9KtheqBoZsAJPMWtNhOLGMLSgKjWEa8Yfly/vjovdwxt8HMWsyHlAmZL
         +/ApXDvsBCbYA9dEJkeguQ07RXsccNtE05GnDmGNdrSptbKXnmixV67iTPVDAHrezr23
         vLv8MhdTRPNM2eEzUkf+w6KkWi+m/efOjDN2SA/aE7Bij6BXBlHlZxZp02Sm7k+p17B+
         WBNdpvHQDSkhPRzDKJGTT+5YdDx8hAp7t65/sUoecawTEm/geEEd6nev1sz1l2RbD8fU
         KJwA==
X-Forwarded-Encrypted: i=1; AHgh+RpObaZ9K50wsh9+tvhZU3N4UBLGKkJfDG/RQNPreEPbBBVu0l2Q6ZzZQchvlH2KixDP+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpIZnEhs6k4lgxM6oCTxk5IoOcqJMYnYANMXPXmU3Lm7dj9me
	OeZ9eY8RTNjsAexUSsBiluWtQoGNE5NrXAgeThy2Z5Oe3FQKWmbZJdctle1mOMomfms/dnl/doh
	HXIg46A==
X-Received: from pfn38.prod.google.com ([2002:a05:6a00:a226:b0:84b:be30:8d22])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1785:b0:848:2f84:732
 with SMTP id d2e1a72fcca58-84ee493ea6emr863311b3a.69.1785531049266; Fri, 31
 Jul 2026 13:50:49 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:50:48 -0700
In-Reply-To: <20260731201140.5AF0C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com> <20260731195612.2697986-4-seanjc@google.com>
 <20260731201140.5AF0C1F00AC4@smtp.kernel.org>
Message-ID: <am0KqJOD-FiC9BXs@google.com>
Subject: Re: [PATCH v3 03/12] KVM: selftests: Pre-set threads affinity in
 hardware disable test when possible
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, Aqib Faruqui <aqibaf@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+Aqib

On Fri, Jul 31, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tool=
s/testing/selftests/kvm/hardware_disable_test.c
> > index f088b4af3ccc7..b4edeadfa3f45 100644
> > --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> > +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> > @@ -36,7 +36,9 @@ static void *run_vcpu(void *arg)
> >  	struct kvm_vcpu *vcpu =3D arg;
> >  	struct kvm_run *run =3D vcpu->run;
> > =20
> > +#ifndef _GNU_SOURCE
> >  	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
> > +#endif
>=20
> [Severity: Low]
> Since the KVM selftests build system unconditionally defines _GNU_SOURCE,
> will this fallback code ever be reached?
>=20
> [ ... ]
>=20
> > @@ -80,22 +84,28 @@ static inline void check_join(pthread_t thread, voi=
d **retval)
> >  static void run_test(u32 run)
> >  {
> >  	struct kvm_vcpu *vcpu;
> > +	pthread_attr_t attr;
> >  	struct kvm_vm *vm;
> >  	pthread_t threads[VCPU_NUM];
> >  	pthread_t throw_away;
> >  	void *b;
> >  	u32 i, j;
> > =20
> > +	TEST_ASSERT_EQ(pthread_attr_init(&attr), 0);
> > +#ifdef _GNU_SOURCE
> > +	TEST_ASSERT_EQ(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), =
&threads_cpu_set), 0);
> > +#endif

Aqib,

Do you happen to definitively know which is the "right" macro to check to d=
etect
support for pthread_attr_setaffinity_np()?  Belatedly, I saw that you used =
__GLIBC__
in a patch that ultimately wasn't applied[*].

I initially used __USE_GNU here, but then Sashiko yelled at me, so I switch=
ed to
_GNU_SOURCE based on Sashiko's suggestion, and now it's yelling at me again=
 :-)


[*] https://lore.kernel.org/all/20250829142556.72577-4-aqibaf@amazon.com

> [Severity: Low]
> Could this break the build on systems using alternative libc implementati=
ons
> like musl?
>=20
> If _GNU_SOURCE is unconditionally defined by the Makefile but the libc
> doesn't provide pthread_attr_setaffinity_np, this might result in a
> compilation error rather than using the intended fallback.
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731195612.26=
97986-1-seanjc@google.com?part=3D3
