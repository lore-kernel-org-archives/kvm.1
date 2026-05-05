Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EC480978
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004101; cv=pass; b=ktNwd6kVkVJcvrk2f5k6igbCuabhD+5QWLKBEEOtOXmPuD83xaaH3Wm8DjuJYimqKD/ZC4XJbIkTZRq8aIrNwEgkhaLDxIGIPVhI6bJTWaupa86lE9OwMxURWqwB4ezqXx1g6IczDZdiJzrttyKP60pEnKNKSIE9QchycUQTK7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004101; c=relaxed/simple;
	bh=f+ypqmN+lQj0IF/Oa+7CTxDcYQldd91C7IUoR3r3pGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUzFElBRXCXNCeMwiupFLrXkh4eJ/UB2klUvS7vFIEPFB7+cEmtZNLe1UnyExf5+0JNYrasgwghBPlRPWYH/6oUATVolGuZr7kCiyrl1q77Qa9pXe7lWHP/NrGuxyk9h4Rmtr+DgTwvgceyWIIKTn86/VkcAdUtcYqgF6mmclVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2iPwoLr; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2iPwoLr"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bba0dde4f43so876802566b.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778004098; cv=none;
        d=google.com; s=arc-20240605;
        b=STNYbsZlPOe2K82zodrIpsv+jGglLHghd03fr2xoa/+yuexeGp87s3xViKkDiYY94r
         m+wq/Q+uZv/G3+bnGJ9ccgkK9ddbaHu8gV8o9OgufcYZcp9ri/sj7Xuyumm5yndf9CkA
         458kBC6A4mQdt0zXjVXKY/oOw5hLOFnJD8BBO+G7gPHeuSD1zmCfEX1B6UjJMyLLoeKp
         DXTV56CJ8iKapDcukJU1zkqo9XF36Bn8hlrl0wK7ib0tbflzGIb4Eq55ScaSEauV54ro
         /0Pg8xpxgQQ2BMHbv2G2Qh3LzQz8lwWU7jEPoZqLGl+Y0JQAOJPGGS9+2pSNIxl63fPf
         4rPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        fh=E507J8PXqhPyTPweWj3KQtQQELQXAVEzpCsBIaod+a4=;
        b=N2yOXV/WCY6QV2aPf9FzdE3JHX2eRz3VV34bipV8w990RKRZ+3IY+TlRB68vZRpR95
         7ZsMP+3/C8w6Sdstg5/XmAS2QCfKjCxgHM9ja0UYzywmCLJIEC43qluS7Ur5sIG+xMse
         rd9DKRq2NxyyzY5bfFQupSNrf6PgXCMDHvwJ1Ot7DLiz9sYCeJJ0aUhZu0+/ZIGbGj8b
         O67qINjxsQ7csBYMVlveWCbdFaEg23hfNOqWjSSDsiQCVqwG9sXIoovUicaeXUbvTSWN
         EdQNyHo7gZuucTTHZCsUP6CnfWCrSdCNYG9k3bmXM8jU8R9nDsACei9cf8ksDHN+Htv0
         YYbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778004098; x=1778608898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        b=R2iPwoLriEdbZIs7QFPcadX0XQOBNAqZKPkb4cQSOmgsII66gC+kw1VRegDRBgGNFx
         aHMgHpysJVtd92bEhROI60a5BN9PlmRal06adw60CmQFseJtTC0RUh7H+/k4tHmr274B
         e9kAAe4deDTS1ByYbJsS/kaRewxd0esQW/FRv/341oaB1D90YQ+7co57XQLf4JYfgFa/
         GuhtEbdiRngj2NpfWlswK6AloDZShpfWaM5YCRRZGlIbUBjBA1BYpk/D7ude5Jsek3tk
         GQsyc5FlbDqcM3e51HpktYcyapenoZF9WqlUIFKU0xnBWWwY0FxnS0yS7PaEuXO2Cqab
         ALqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004098; x=1778608898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nQUZmjv7aHFLMaMFauN5kz/OKqGsuDJKsdlinZQqRbc=;
        b=s0Bo+V42MoR3vpZcGh0RR3iJnxydzaSXy1V8J28xP81RpRaVSzGmNAKGcY/zhw/lHM
         JUic2mcztk9vrWhxwGzOes9mqkYm3RPFaxQqnhNLnkA2nRlSNOdNEyGQIkuiHj3HBuKB
         QQ1GBYdAtOFbc8T5sEqVHJn+VAeSpDM7L08vn2cG37wX3MMtzTwuZ0iUUv0e6OFag+Qb
         R6t0h2mPhMe24SlWFt1VnNnuit+Ws8RYYkM3ziGl+FC9T/3NgcaES2FF2QCfGDSIZdJm
         Yu4/jROU6K2tedJ8Bk9WoGd9JCx6W+xk5hA6Bd9nTPHjwcAYjX/1AX2An/sbDzkJhTZJ
         HDLg==
X-Forwarded-Encrypted: i=1; AFNElJ9cwXKS05trJNAIrjr8+ENj9NMIphBvFBR4DSD8o1/mmPwH3z5FRA4tyfJXmGOrycRFNwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2G+smAPg7D7k7XLk6qrTk9EqOQzUzWeR1ASRg0m1x5VS1SapZ
	PV0K8xRCTPEJjVZbies+g4x+N/zC4d3avPfMX6dHzDAmmj5wtRkZppZtySJnu9Um5BvXc8S+Ilh
	ophL9i70XthvzW4Fd8tOPY677J655NSeAzPABQx3L
X-Gm-Gg: AeBDieveNBx1DSWlRKNSYC/DciNJyTzX85ngy0A1xzmdaGO/f9kqUliUN6nAGpN+Tn8
	5Ri5gQo1Gvx67mI3lfTPY5o8xKnCdK19D4Om6tJEp3l+BVwxPmfWF35DKbEPzYnh/3Apf5BI1si
	Wkph6DrqvlSgk/RVfHcH1FyzvW1hf7ftaCODnqiHn9+qUNTTgJed7ApDsdIzCz0pi+QkPVO2BQn
	65DcKJS5+hvi6ZdwEXqj+Ah9/mkvUHc61cJboo8T3BG7q7uDCUbclXC43MaeIDwpU7xBrtsHo9l
	XiXHZ39Qly0FvGKLpGc2PuDwIa6VO3fYwt6+29iTYIKGbZQJBaUQU6AT0+3ejkVJ0OTDsdq/lER
	cFnCXIqe5O/JXE1NerJvz/3YJew==
X-Received: by 2002:a17:906:9f87:b0:ba7:cc67:488b with SMTP id
 a640c23a62f3a-bbffab33111mr887380266b.5.1778004097049; Tue, 05 May 2026
 11:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504224213.1049426-2-jthoughton@google.com>
 <20260504231048.1184273-1-jthoughton@google.com> <afohshVlK9YcBk-f@google.com>
In-Reply-To: <afohshVlK9YcBk-f@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 5 May 2026 11:01:00 -0700
X-Gm-Features: AVHnY4J0Tr074uKX9gnTkNPmv46TNeS2NEyt9u-k5f94BeNvCS-2m8Zf89eFVRE
Message-ID: <CADrL8HX223b3YS8aHr7b=AZZ2J5ga+-SwLQX9Rs9Ep=rMM5wUA@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Grab KVM MMU write lock in kvm_arch_flush_shadow_all()
To: Sean Christopherson <seanjc@google.com>
Cc: chenhuacai@kernel.org, gshan@redhat.com, jhogan@kernel.org, 
	joey.gouly@arm.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, loongarch@lists.linux.dev, maobibo@loongson.cn, 
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com, ricarkol@google.com, 
	shahuang@redhat.com, stable@vger.kernel.org, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 10:05=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, May 04, 2026, James Houghton wrote:
> > On Mon, May 4, 2026 at 3:42=E2=80=AFPM James Houghton <jthoughton@googl=
e.com> wrote:
> > >
> > > kvm_arch_flush_shadow_all() may sometimes be called on the same `kvm`
> > > concurrently in the event that the KVM's `mm` is __mmput() at the
> > > same time that last reference to the KVM is being dropped.
> > >
> > > T1              T2
> > > KVM_CREATE_VM
> > >                 Get VM file from T1
> > > close VM
> > > exit_mm()       close VM
> > >
> > > T1: exit_mm() -> kvm_mmu_notifier_release() -> kvm_flush_shadow_all()=
,
> > >     with only the KVM srcu read lock held.
> > >
> > > T2: kvm_vm_release() ---> mmu_notifier_unregister() ->
> > >     kvm_mmu_notifier_release() -> kvm_flush_shadow_all(),
> > >     again, with only the KVM srcu read lock held.
> > >
> > > This leads to a potential double-free of
> > > kvm->arch.kvm_mmu_free_memory_cache and now with NV
> > > kvm->arch.nested_mmus.
>
> ...
>
> > >  void kvm_uninit_stage2_mmu(struct kvm *kvm)
> > >  {
> > > -       kvm_free_stage2_pgd(&kvm->arch.mmu);
> > > +       lockdep_assert_held_write(&kvm->mmu_lock);
> >
> > *facepalm*.... this doesn't account for the other callers of
> > kvm_uninit_stage2_mmu(). They will get lockdep warnings.
> >
> > I've attached a diff to the bottom of this reply that *does* deal with =
them.
> > :( Sorry.
>
> ...
>
> > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > index 883b6c1008fb..977598bff5e6 100644
> > > --- a/arch/arm64/kvm/nested.c
> > > +++ b/arch/arm64/kvm/nested.c
> > > @@ -1190,11 +1190,13 @@ void kvm_arch_flush_shadow_all(struct kvm *kv=
m)
> > >  {
> > >         int i;
> > >
> > > +       guard(write_lock)(&kvm->mmu_lock);
> > > +
> > >         for (i =3D 0; i < kvm->arch.nested_mmus_size; i++) {
> > >                 struct kvm_s2_mmu *mmu =3D &kvm->arch.nested_mmus[i];
> > >
> > >                 if (!WARN_ON(atomic_read(&mmu->refcnt)))
> > > -                       kvm_free_stage2_pgd(mmu);
> > > +                       kvm_free_stage2_pgd_locked(mmu);
> > >         }
> > >         kvfree(kvm->arch.nested_mmus);
> > >         kvm->arch.nested_mmus =3D NULL;
> > > --
> > > 2.54.0.545.g6539524ca2-goog
> >
> > And here is the diff that should fix this patch. (Sorry!!)
>
> There are more issues.  kvm->arch.mmu.split_page_cache can be freed by
> kvm_arch_commit_memory_region(), which holds slots_lock and slots_arch_lo=
ck,
> but not mmu_lock.

Thanks. I also noticed that kvm->arch.mmu.split_page_cache is
documented as being protected by kvm->slots_lock; we should be holding
it here. But we cannot take it here because we are already holding the
KVM srcu lock.

> IMO, the handling of kvm->arch.mmu.split_page_cache should be reworked.  =
I don't
> entirely get the motivation for aggressively freeing the cache.  The cach=
e will
> only be filled if KVM actually does eager page splitting, so it's not lik=
e KVM is
> burning pages for setups that will never use the cache.
>
> Maybe I'm underestimating how many pages arm64 needs in the worst case sc=
enario?
> (I can't follow the math, too many macros).  But if KVM is configuring th=
e cache
> with a capacity that's _so_ high that the "wasted" memory is problematic,=
 then we
> probably should we revisit the capacity and algorithm.  E.g. if KVM is sp=
litting
> from 1GiB =3D> 4KiB in a single pass (I can't tell if KVM does this on ar=
m64), then
> we could break that into a 1GiB =3D> 2MiB =3D> 4KiB sequence.

I'm not sure I've fully understood the point you're making, but I
*think* we can just drop the
    kvm_mmu_free_memory_cache(&kvm->arch.mmu.split_page_cache);
line from kvm_uninit_stage2_mmu(). It will get freed when the VM is
destroyed anyway.

So I'm thinking of splitting this patch into two (unless someone tells
me otherwise):

1. Drop the kvm_mmu_free_memory_cache() from kvm_uninit_stage2_mmu()
    Fixes: e7bf7a490c68 ("KVM: arm64: Split huge pages when dirty
logging is enabled")

2. Grab the MMU write lock around the kvfree(nested_mmus) bit in
kvm_arch_flush_shadow_all(); do the kvfree() without holding the the
lock.
    Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested
Stage-2 mmu structures")
