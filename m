Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5C48BD43
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005013; cv=none; b=dQyGK3UmMPKOP8QDOZxRbZGqjNAoyVcmxuMwv9VYYxtDRLu5dum5zgpmg1bAaf33FoZgDNbxz2qNUsI5k9v7rYNMDKrOQHFmYxh9YrbeLc8l9dEFtx+2E9Ezk2Zz7emoQaW+NmuRk7XVTYv0n10ggDlOfl+c8olsivD+FcC7pGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005013; c=relaxed/simple;
	bh=jJt54MpFxQg6JNI2urKnLlI3egsp9pP5s8P+shBJ5y4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eM+CRIjzsiwuGwKTcZ7TFQ10pp0CXPpVRus1DmRnWwgYtCWZolLAzAOzyxM9EEZX/yOAxUrFru4KoYV0SUPLolJCJ0UDmwSZfMYu9cLk9Y06jzo31jxQ/fhKfA4wSo16S+MDthdEIUEqa776gJlilxMF3ewWKAXj88rKTIJ9gAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kY6Usk7j; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kY6Usk7j"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2eba42b8dso51823625ad.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778005011; x=1778609811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luNYyBAnxJ4nZFqNusK+zieJvfObwASYFJHRx4I4bUc=;
        b=kY6Usk7jrWMpapK4HX7ghYKfEabNMDy5qQqMp6EqUfRdSJmFQAAzRgM7Wog3gFB2ea
         qHNToW8uhPX8AEHobgjY0BjfumailYHKW4aLUR7Z8i8sVKwMWp5DAPQHjx5kOWGu113C
         3M98RzS4iY7bk/kzW2S0YSTTPR0z5IPzNXl8lE9C7c2nDY2kzAf9vBaKt3IUNOHicMJL
         OzjF/ayfthQabpIzQSX+/mqabx1HOIg+HqDjhHrLpgJXDXNx1gBFgTTFz9A0eXs/9AGw
         FgGQixTlrm9TkkGJD1ebfHii9bWzBmQkJD3SCbY64TwV98fCgjneYlIMoq61xaBJXH2V
         sZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005011; x=1778609811;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luNYyBAnxJ4nZFqNusK+zieJvfObwASYFJHRx4I4bUc=;
        b=DhzwPld5x6zHjkF64vw17Jn+b2Ah3DpQzCfaPAy4kIgbAM5ecgwMoYeI9wspSynN7/
         ZVwU7bXQOnlY3EzH6F7BQOGQe0C6LcSZi+Ig5byjALPsrPM/ueB2ssCHtQ66taeMVcwB
         G2SvXQR8SqysuskV0gzC+zF9SKFdQ4IQR+jGrqDa5Tpxe8dX/MgHBP7ezgazXFdpd8jb
         +VsCINSK9YmGU77xhJUxIwEv24Bf/VbXjUeP39ihNbQEq3bLEHdu7uuovtTUwPIQR70s
         UD0X6U2wwGCEYu9t/EmLluEO4XdwNTVGgvO0t7pdCNg01MksuszCjJVm1pU7N5yZm8nY
         8HsA==
X-Forwarded-Encrypted: i=1; AFNElJ/j8qPRWgcetVeJcvbr6LCE24f9RzUMsS7Ug/HG+XtGmGKFDxQnqLAFocB11FZxocvbJ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3SQQG9G2pc5radT+bhFcNWuCKirK0pPabbkrPKTH52CuczRS
	sPfapgX5Hoo6LG7d5LGpQZDLufWMU/uu5JYowNiT8KfpZsL1JVQ8/7TG94AGFHxvcfqgshSG8B1
	MXPbRrw==
X-Received: from plof8.prod.google.com ([2002:a17:902:8608:b0:2b2:5117:a3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b03:b0:2b9:ff02:a15a
 with SMTP id d9443c01a7336-2ba794c3003mr848615ad.9.1778005010714; Tue, 05 May
 2026 11:16:50 -0700 (PDT)
Date: Tue, 5 May 2026 11:16:50 -0700
In-Reply-To: <CADrL8HX223b3YS8aHr7b=AZZ2J5ga+-SwLQX9Rs9Ep=rMM5wUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504224213.1049426-2-jthoughton@google.com>
 <20260504231048.1184273-1-jthoughton@google.com> <afohshVlK9YcBk-f@google.com>
 <CADrL8HX223b3YS8aHr7b=AZZ2J5ga+-SwLQX9Rs9Ep=rMM5wUA@mail.gmail.com>
Message-ID: <afo0Er7R4MnMP0MB@google.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: chenhuacai@kernel.org, gshan@redhat.com, jhogan@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, ricarkol@google.com, 
	shahuang@redhat.com, stable@vger.kernel.org, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026, James Houghton wrote:
> On Tue, May 5, 2026 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > There are more issues.  kvm->arch.mmu.split_page_cache can be freed by
> > kvm_arch_commit_memory_region(), which holds slots_lock and slots_arch_=
lock,
> > but not mmu_lock.
>=20
> Thanks. I also noticed that kvm->arch.mmu.split_page_cache is
> documented as being protected by kvm->slots_lock; we should be holding
> it here. But we cannot take it here because we are already holding the
> KVM srcu lock.
>=20
> > IMO, the handling of kvm->arch.mmu.split_page_cache should be reworked.=
  I don't
> > entirely get the motivation for aggressively freeing the cache.  The ca=
che will
> > only be filled if KVM actually does eager page splitting, so it's not l=
ike KVM is
> > burning pages for setups that will never use the cache.
> >
> > Maybe I'm underestimating how many pages arm64 needs in the worst case =
scenario?
> > (I can't follow the math, too many macros).  But if KVM is configuring =
the cache
> > with a capacity that's _so_ high that the "wasted" memory is problemati=
c, then we
> > probably should we revisit the capacity and algorithm.  E.g. if KVM is =
splitting
> > from 1GiB =3D> 4KiB in a single pass (I can't tell if KVM does this on =
arm64), then
> > we could break that into a 1GiB =3D> 2MiB =3D> 4KiB sequence.
>=20
> I'm not sure I've fully understood the point you're making, but I
> *think* we can just drop the
>     kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
> line from kvm_uninit_stage2_mmu(). It will get freed when the VM is
> destroyed anyway.

It's not that simple.  KVM arm64 allows userspace to reconfigure the capaci=
ty of
the cache via KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE.  kvm_vm_ioctl_enable_cap(=
)
currently allows userspace to do that so long as there are no memslots.
__kvm_mmu_topup_memory_cache() will (rightly) yell and fail if it's called =
with
the "wrong" capacity, so we'd need to sort that out.

The other issue is that it's not clear to me what happens for large "chunk"=
 sizes.
If KVM is splitting from 1GiB (or whatever huge-hugepage sizes are supporte=
d on
arm64) all the way to 4KiB, e.g. to optimize against break-before-make, the=
n the
capacity of the cache could be significant, e.g. MiB of memory or worse.  M=
y read
of things is that purging the cache when dirty logging is disabled is a gua=
rd
against consuming too much memory when the chunk size is large.
