Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D53E9F7B
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918268; cv=pass; b=uf8WaEyRiYBDFEtt7CAWmRg99K1wUznwyj/GYa9LN5eTKQYP94UjdLnVX3JgSjm1itqsHDbQVsAeCbHXVReg3LV8Twg66tdSvFeh812hW0hS1NdTE3arPsPV0C5gp5ePkjmFLkq4H0OMPGXj9RemFsB2x2Qkqmo8IKGkCGNEGCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918268; c=relaxed/simple;
	bh=ulPXcPvIAX7bryqiNNlOZt6XuUjo9tL35GJ+kJTPNXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K62W2V7A2FMa+pGNl8/uJzdruKlwDzhR4kYCxuQsIwQMmny/RCAUgGpFk2nD6ESXPI31gmbDC8znI761we82BB+M9B/LCZ9DjasVJsmqmCGSSAi51tuXqsZAoK1TijjEcn03BoENYVXIl4Ym+7UH85e92yvTUpu+vshgQ8tHbUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/+HT2a9; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/+HT2a9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce7d2adef4so10973275ad.3
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 01:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785918265; cv=none;
        d=google.com; s=arc-20260327;
        b=IzqOCk5XM8BvTAzlI8A1Q4bT1XoaaXoINAgjEl2lg8hti9XrgNqJazjX+t00pY9by/
         D3QaKo5mL+9v9VloNTypL/v/uB4kUB+ZBPYMqI3Hg/Zc97j3NKZOs5O30JB/dfPo5NhP
         FX8iMtckIZmFSnKLpPUom+vbM44pLVxcjkzfoQbOUagS32C4tfMWAe9cMs5xKoCJmYVf
         KwWHAeA5ni5uI4dh5lHiCiKOK0308UhO1a+qYR7rou4cVKoOgf7UnFisbPWmWEZksPqv
         stpVUABbVOB/8sLWCVkRQCSG84veYwriUf5kgWv47nan1js503S2C40yCkU5lC/rUofA
         sQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ilhxw2veirKNbzlCVfTmx16i+bT5fevll4XzPqplJsI=;
        fh=XIJZp18IAhtRpouR8f0sgzZSH7QdwNuEXfcolJulZyk=;
        b=k9k3bhh69hpeWdj6FN+bF27drFDj3mhrvTXAm9RqaXHepYyEecyAcHuAbOqv2LE/NC
         TwUilWTnBQVI6mKuinGNhY2Ci/9KLLNy7KHA8y81n5uBXLxXeRW+fG11I/opXBMma7nk
         PIwiMNDjzfKoC0wk0b5Y6xKjXdrQhggiuW9ULXudsxkXVnIAklwG64LVGRe9H0soLWdO
         ctES/m40SnfqH7dtBQZKGpLgnVNJX4hA4SY92vP7uRkoh4/F3Cf3/ZQdxnjexzyDV5I9
         YzddUdBNFeVP5ks8wywochE8x0ZudKfNgT7q3GoIinxlzn6zLRGfBG+0LFtLC2JzEoBg
         6dvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918265; x=1786523065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ilhxw2veirKNbzlCVfTmx16i+bT5fevll4XzPqplJsI=;
        b=k/+HT2a9vwyUbj/14dqTzvCahS5smFheR416XLw/Fja46cThz84RICy377BkfDOEcm
         nIIh54HkNpn3ev5Xo9LeKio6dP/r50p472VURNst59X/iwqqrn7wt5bBA4yJc5yeIQuf
         mCld1da5TI6A5Pbdts0Kz3xMp9w8Zly5DZARILGX+5vE7mE7q2Rbg+oByH+PuiPF8HEP
         69wWzERFrYG679W8snBL5AV+GDKN0KrcQJ6SsaDzw41oe4X6pdJeOXX8tBigox74FOhZ
         kwZ2Jy+6cDN120Ykd+kV9xUmEWiI/w4QQ96pSIZ/2jzsE9I95ykchjg6Z7/I83hUKHw4
         1Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918265; x=1786523065;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ilhxw2veirKNbzlCVfTmx16i+bT5fevll4XzPqplJsI=;
        b=lChkiy+R8hOtt1NZoMTpwUs7A8SmOwT8dshh1cqwV7wopEkCByfnNskUiKLlo4YrYX
         VKoB2jOs3Yc5v2Pg1qGYWY3HX+Hpg7lfaBFTzVt5ijen8BzjdIatcKXeyYOOKCKONhsk
         WVNUVAFoNd1ZiHswH/V9k+BthRz4+gBHHagaFRqrpP4n0xFK7cVBj3FtWV1Q2ZF9tPHl
         cF3RxS6AUVUNNMp/jdjbDNLYKzXeVnZRKo9H4X2wltVmVJfaIqpDV6vkaZ0xoaIxQ3Oi
         lDpWUrPPodFsmXj/LC6Kbmc4PV4JQTVlzyu7ytpSoSvnmxv1K7cFhXYa/TW5yd+fKDn8
         ZXtA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2qOgS4BrjPTdsu/vXYYLSnCPhJz/GfiLln14ruGM94tP1uyEihwJGT31/I6OD0nfccrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywn68NQ7Xvkw1lo+3oYpQnWgU08ZeEncy234EsE1+zoXMwLPHd
	VgXkndRizkat2Jjc4cPbj7d5RpBHo1SY4qTlY1fsKxWuUVuE9SbLz1FbyJndYoTBpJJPWf32JBF
	z+JKCfQRRuMCrRc5UMFup+XjVWo5xfM8=
X-Gm-Gg: AR+sD13cGBgcTwZj/7jCAR9xt5MsiDWpQZU3ziMw0eX5nyqdbAjM14EgFl96vvh+iSs
	IFt+gWO29s97mFfKNVrmHopsKpLX3MPaf+VmVxScavXssy/zxf5maMyR4TPoEJUFInRYiCnOSz0
	E127YaA6UXoAFtUafF8AnQjc3qHrCUJ18guNNldiMRsYmWiqM8q6R8Dd6Tfuu+M21yRTfpPm2Ot
	mCSHUQjIo3bxkqOp6PyCVYJs7ujWD9YHki1GguRJhIsnX59IFnC2afCi1P4MNfdN7dNTS6ucvL4
	RTDwfp34paGGQbd4rxTaT49bkCiuLorN7c/Ckz+Rqz+J
X-Received: by 2002:a17:902:d2c8:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d0ca77eceemr51093685ad.15.1785918264991; Wed, 05 Aug 2026
 01:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804105755.276646-1-kimjw04271234@gmail.com> <anHk2wTLHYxdB0jD@google.com>
In-Reply-To: <anHk2wTLHYxdB0jD@google.com>
From: Jinu Kim <kimjw04271234@gmail.com>
Date: Wed, 5 Aug 2026 17:24:13 +0900
X-Gm-Features: AUfX_mzKLokgmF6DRO-6kt4r_GgkDNyd0Z-pl6gFBWgm9BLihr-9lvkaerzlnBE
Message-ID: <CAH+3ta4uD-QYju=6YRqHvd4Vwa-WAa9T9a65soCzdu49wNxV8g@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86/mmu: Write-protect tracked GFNs in all
 address spaces
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks. After considering your comments, I think v2 is trying to solve a
broader problem than the one reported, and that the resulting complexity
is difficult to justify.

One thing I do not understand is the proposed revert of 0f38453cdb2e.
The original pte_list_remove() panic was reproduced on then-current
mainline with 0cb2af2ea66a, 81ccda30b4e8, and aad885e774966 already
present.  The panic remained reachable there, and 0f38453cdb2e stopped
it.  How would those three commits prevent the original upper-level
shadow page from becoming unsync?

Your comments also made me separate the general limitations of write
tracking from a narrower issue in this case.  I understand that KVM
cannot guarantee write tracking for every way guest page-table memory can
be modified, and I have not established a current-mainline host-security
consequence for the remaining cross-address-space revocation issue.

In that narrower framing, there may still be something worth fixing.  In
the reported SMM configuration, KVM creates CPU SPTEs in both address
spaces for the same GFN and backing page, accounts that GFN as backing an
indirect shadow page, but can leave the peer SPTE MMU-writable.  KVM's
shadow-page accounting state and the permissions installed by KVM are
therefore inconsistent with each other.

Fixing that local mismatch would not imply support for DMA, host writes,
arbitrary aliases, or a general guarantee that KVM observes all writes to
guest page-table memory.  Those cases can remain unsupported and be
documented as such.

If this narrower boundary makes sense to you, I will rework the patch
around the existing shadow-page accounting and synchronization
transitions.  A replacement would keep the normal mapping and memslot
lifecycle paths unchanged and avoid introducing persistent
cross-address-space state.

Regards,
Jinu

2026=EB=85=84 8=EC=9B=94 4=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:10, S=
ean Christopherson <seanjc@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> On Tue, Aug 04, 2026, Jinu Kim wrote:
> > KVM relies on write tracking to fault all subsequent guest CPU writes t=
o a
> > GFN that backs a shadow page.  The write-protection installed when trac=
king
> > starts is currently restricted to the supplied memslot.
> >
> > With SMM, the same backing page can be mapped through both x86 address
> > spaces.  If the peer address space already has a writable SPTE, a guest
> > write through that mapping bypasses page tracking and leaves KVM's shad=
ow
> > state stale.
>
> ...
>
> > This restores the invariant that a tracked GFN cannot remain, or become=
,
> > CPU-writable through another x86 address space.
>
> Not really.  There are multiple ways to bypass KVM's write tracking, for =
all
> intents and purposes they've already existed, and realistically I don't s=
ee us
> ever plugging all the holes.
>
> >  arch/x86/kvm/mmu.h              | 11 +++++
> >  arch/x86/kvm/mmu/mmu.c          | 77 +++++++++++++++++++++++++++------
> >  arch/x86/kvm/mmu/mmu_internal.h |  3 ++
> >  arch/x86/kvm/mmu/page_track.c   |  2 +-
> >  arch/x86/kvm/x86.c              |  8 ++--
> >  5 files changed, 84 insertions(+), 17 deletions(-)
>
> Assuming the true badness referenced by commits:
>
>   2e8a2c1b0306 ("KVM: x86/mmu: Check all address spaces before skipping u=
nsync")
>   0f38453cdb2e ("KVM: x86/mmu: Check write tracking in all address spaces=
")
>
> was eliminated by:
>
>   0cb2af2ea66a ("KVM: x86: Fix shadow paging use-after-free due to unexpe=
cted GFN")
>   81ccda30b4e8 ("KVM: x86: Fix shadow paging use-after-free due to unexpe=
cted role")
>   aad885e774966 ("KVM: x86/mmu: Drop/zap existing present SPTE even when =
creating an MMIO SPTE")
>
> I am leaning toward taking an erratum for cross-address-space modificatio=
ns of
> guest PTEs instead of applying this, and then reverting 2e8a2c1b0306 and =
0f38453cdb2e.
>
> This is all a non-trivial amount of complexity that, in practice, no use =
case
> cares about.  By fixing the issues, we're implicitly stating that such sh=
enanigans
> are supported by KVM, and I would much rather say "don't do that" and doc=
ument
> exactly what is in/out of scope for shadow paging.
>
> Paolo, emulated SMM matters a lot more to you, what are your thoughts?
