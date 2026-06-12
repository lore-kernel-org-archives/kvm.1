Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF231064B
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252089; cv=pass; b=dk/qsAd4Nn0NoEDdDIKRkbDU3WhRClJEsIN1q8GurmmLpgaZiqsdi7ubrNJCxDSsJFvWHiDqPbb+TGmmxlnu4GfjpOrMMo8u1q76Zal5rFbEQyS/M0quUn9WNSQy2O78OAOnGarHIH7vNUQ6Q+y2a/1hjc8jk/J6T0XAoHEB0HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252089; c=relaxed/simple;
	bh=pFcYjQxJLFJows4DapA79zhBJ/NxTfG4xcwxU1ZC42E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZA8cZ7xlsr5DotpUE4eCdJpsu9vHbyQBavO7y//LICKtq6aA0rewI/jS8WtQ6dxno9XP+v5Rq6tH2Hi39YixI2zGIvUMI046hOQ7eqLm17CX6ekrL+1ADWCTpV6pQxhsTlOx2yTbe8X4jINX0qay3QeXqzwKJswQMXX09tWIw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PubYHZSX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ervs4f7k; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PubYHZSX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ervs4f7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781252087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aanoHFJLnEDLnEvXMTWEcbmP5gQOZswmMn5yd6IbkQ8=;
	b=PubYHZSX8fsMljtoM/wD878OqT5nstQleQ+yktPkvUZWfWgmrRCwsYcamQqVTX+X4G1RU4
	KaNNF35e33KE41ot4IeqZK/7/mQScANKH1tT5FICwBlvMlTyx+EjHpWN7Y7cwQXsjPOMT/
	ab2QVwTxLyTzvKipNwH24XV94XjSzcw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-MJbkWN9gMVGAnVZ47T9NBQ-1; Fri, 12 Jun 2026 04:14:45 -0400
X-MC-Unique: MJbkWN9gMVGAnVZ47T9NBQ-1
X-Mimecast-MFC-AGG-ID: MJbkWN9gMVGAnVZ47T9NBQ_1781252085
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso7509955ad.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252085; cv=none;
        d=google.com; s=arc-20240605;
        b=SDrOdSXiFcuQoh759gPuA/fsTv9w3AI13I2Altx6ZtL0+wE6Ge2aXpm+VecfhQHMXG
         tEueaMPvi3Ns+U4PWHgZdR0uzPchsHefaRnggm6WzAj4L2dKegSKAdNyGFGVir68jM/R
         r4I2krIUVmHCru24p4fv+QGooXzsj7m7/5WkAgXx6ISb9hOiTbO+ximWQwMej2Zuhu92
         QLpLm3KdM+P6EyWf4F9FFg7ST6ABagUmblaoOmpLtoxwukYcr+LXiZ021tzlr9mdrxrw
         c3ksT9S5dcFe/8+vfC066OpKEtMngddELtfDrI808kNME3HI42ARolqbaDQR/7uzh+4B
         rKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aanoHFJLnEDLnEvXMTWEcbmP5gQOZswmMn5yd6IbkQ8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=c1FToGlxFa/Ko94s0NSDnq2wZUWy6bHCz4PBWaGAn3krw+AS7fyktGGqhOuGtTTBGb
         Kmdfd8+vgnMm1bc7cVM6eXkcOWlQivmF2DUt25sGP2jpUDSfwNFbH4hAajvXKhIXRrx1
         xDs22s0J6BgIcELmrqAlWqRPTnJRFyayNLRhbEVtA5GUNv95/wjaI11nX0ui7iekOIvC
         5h90N8PxkPgWBjQhOKIZAbR2RigQQPGGnXgJjtafvi0tF95octOzWJSqeMrKZL/XaeeI
         x6Ax8O2mnvMAbgpOmteItmKMl+54Un8bY2FhgCik1zptaVwLbF4P8R/r4j5nmMGmzgYY
         wtug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781252085; x=1781856885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aanoHFJLnEDLnEvXMTWEcbmP5gQOZswmMn5yd6IbkQ8=;
        b=ervs4f7kWh9VtqUMFlvw7Fc9HGmi5Jo2bxdijrDMZzBlwt544H2qRgRNkj54CZ9CIm
         rBsu3EdKtxgxqLfHpizsD49FmPUwux9+GlypXZX3m07Ik7WHLjnpLbZ/HKm/C4ibBXAw
         3gd1rrBokpbWUgm3O/e/k3/5+vAV9ySBaSW7BxLpxxMhnpeTilO0XFtfzgrti87rKobT
         4YuRPE+jlkEKgunm5qH4xtvNcMh0pMgaFC3Jb/O8rDVTce6NWeNW+Y4mPhso5PLjMGZO
         +s1Y8UuJl/dCf9jHjLqQIa6TYZlnlBBTtZDU7yqb7NWehS9WgTU3/FVZGSfiDkuFeo2J
         U1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252085; x=1781856885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aanoHFJLnEDLnEvXMTWEcbmP5gQOZswmMn5yd6IbkQ8=;
        b=FGWrzOz5RhMySm8fs7aHwOFrrYytQJE07udA/6wk1e4d952feuyTbeWBeWu2yCXqyC
         BQmFQQmBZK5aPk5RqHdkDm4XB9weMc5tcZF61V+nU8ry5ZjBTElGWk8fBWoO7H75NOHP
         25bcuPqbkeVh+oyikBX+l4G5m+PxgyihY28Yf/236QT4CDH7FQlikdGl4rnPl2MBa1RU
         UnwcSgYRInrPbV/dTk2BTBRpoapxtI/8NxWJ34cRj4YCFR/h3/sMVJzVpeKXzd5J+zpB
         n80+fl5PG8hWjbYHDqr/+yAs2t/+xcX18cqZZGj7BBJdJY1pK5iKQmD4PhMQYEUEzjNU
         xgVA==
X-Gm-Message-State: AOJu0YyLdoq+9+Klo7FRYK4veV/thKKrQFXaWUr1ywJelSl0p0ir4BxK
	7ARFL4dbm5mOw0kpGJSE0g5dmL30zADPassaLF6HTfyhnXvimQZLXPsfCg4l4KhyFRKulA30Bog
	cjcyJkhTGqLgpOvUJHUlI3Ekj/vcps/TyqonxJJQ0Vs3aIqBhBj2HdH78/cT8xiRU8sBAIdl/C7
	D3Kq8mRRTmbdaQsLZQ6uO9COQRZ7/E
X-Gm-Gg: Acq92OHNONT5QMBtI8zVtAOach4BGqjqUk8ZkcT2O+enTjUmsZwaJ+7Gp2f/ldEObHd
	NqH/9ggJ3udoS1gmtxaNuUiXXqQJFlxyNGdh+WwQbUaajVASIYRu10gIA4qKFCmP3OQmPS6xKwF
	5Svxjz8Xv+ZIs/2i7nZDfJkmPvokp0aFuQM/UDwgM6TXxKGvNyBL8/bo4waLTD1r6pro7p8oVFX
	4nExePti418l+fKQTEyBoSiWcBQrT6EGK3h0CUXFjAVk71mEFn9EA2vI5IobHlhqinp3/3QCf5p
	DUpn6A==
X-Received: by 2002:a17:902:e5c5:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2c4106fdd0amr21617935ad.7.1781252084712;
        Fri, 12 Jun 2026 01:14:44 -0700 (PDT)
X-Received: by 2002:a17:902:e5c5:b0:2b2:57f3:8d07 with SMTP id
 d9443c01a7336-2c4106fdd0amr21617535ad.7.1781252084207; Fri, 12 Jun 2026
 01:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-5-seanjc@google.com>
In-Reply-To: <20260612004755.349925-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:14:24 +0200
X-Gm-Features: AVVi8CeED-WSjyZbpTvk-mU7eWZcN4Rl1yQEQRrDRtjoyj5fc2daxaRZAxrWYi4
Message-ID: <CABgObfYAAf4C7823BTNT8LC-hGsdP23U5=NJqGZ1oG=M5+a88Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: MMU changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A big overhaul of the TDP MMU =3D> S-EPT code in prepartion for Dynamic P=
AMT
> support.  The non-KVM changes have acks from Dave.
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-mmu-7.2
>
> for you to fetch changes up to 69397c92de77525f70aa43cf3a47256cef409382:
>
>   KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on emula=
ted writes (2026-06-08 15:23:09 -0700)
>
> ----------------------------------------------------------------
> KVM x86 MMU changes for 7.2
>
>  - Use the kernel's "enum pg_level" in the TDX APIs instead of the TDX-Mo=
dule's
>    level definitions (which are 0-based).
>
>  - Rework the TDX memory APIs to not require/assume that guest memory is
>    backed by "struct page" (in prepartion for guest_memfd hugepage suppor=
t).
>
>  - Overhaul the TDP MMU =3D> S-EPT code to move as much S-EPT specific lo=
gic as
>    possible into the TDX code, and to funnel (almost) all S-EPT updates i=
nto
>    a single chokepoint.  The motivation is largely to prepare for upcomin=
g
>    Dynamic PAMT support, but the cleanups are nice to have on their own.
>
>  - Plug a hole in the shadow MMU where KVM fails to recursively zap neste=
d TDP
>    shadow when L1 is tearing its TDP page tables from the bottom up, as K=
VM's
>    TDP MMU now does.
>
> ----------------------------------------------------------------

Pulled, thanks.

Paolo

> Rick Edgecombe (4):
>       KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX =
code
>       KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX=
 code
>       KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN=
_ON()
>       KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child externa=
l PTEs
>
> Sean Christopherson (17):
>       x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based lev=
el
>       KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE "fa=
ils"
>       KVM: TDX: Account all non-transient page allocations for per-TD str=
uctures
>       KVM: x86: Make "external SPTE" ops that can fail RET0 static calls
>       x86/tdx: Use PFN directly for mapping guest private memory
>       x86/tdx: Use PFN directly for unmapping guest private memory
>       KVM: TDX: Drop kvm_x86_ops.link_external_spt()
>       KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into help=
ers
>       KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
>       KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_=
spte()
>       KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's handle_change=
d_spte()
>       KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates=
 to external PTEs
>       KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_sp=
te()
>       KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
>       KVM: x86: Move error handling inside free_external_spt()
>       KVM: TDX: Move external page table freeing to TDX code
>       KVM: x86/mmu: Recursively zap orphaned nested TDP shadow pages on e=
mulated writes
>
> Yan Zhao (3):
>       x86/tdx: Drop exported function tdx_quirk_reset_page()
>       x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external use=
rs
>       KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for le=
af SPTEs
>
>  arch/x86/include/asm/kvm-x86-ops.h |   4 +-
>  arch/x86/include/asm/kvm_host.h    |  13 +-
>  arch/x86/include/asm/tdx.h         |  34 ++---
>  arch/x86/kvm/mmu/mmu.c             |   2 +-
>  arch/x86/kvm/mmu/tdp_mmu.c         | 275 ++++++++++++++++---------------=
------
>  arch/x86/kvm/vmx/tdx.c             | 208 +++++++++++++++++-----------
>  arch/x86/virt/vmx/tdx/tdx.c        |  64 +++++----
>  7 files changed, 302 insertions(+), 298 deletions(-)
>

