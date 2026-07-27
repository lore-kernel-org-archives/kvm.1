Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495CC3F8707
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170475; cv=none; b=ZC95yjUF3UVuVdbky8a6819z//+RA2j+L978hpeU+m7DCLsGFVeTyqNGJCVkqu0MPC2mSEj0eSt/GPuJFxHz1N7hZqJ/5aGhpw+x4k1X+InQJyYQ9PwSLzhyeKy6jn1/sw3mu/56dor2q466SIuwOvnzoA9Tjkq++THt1/MCU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170475; c=relaxed/simple;
	bh=1l9qQQn5fFHI0f34R9RslK15csqZZ376J/mDNYFAOo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qxnw/9eKHj/fD68MtqLuUGW3bIt2UgClJPC6oc7Yqh+wQvc5VCLR5oBLf/ZlWWWEfJBBnk2GRSRURVrFodrvdSXp0SNkzUwgBPHT94nicCG9OzlnipuPVWRpiDib9V3/LbhuaCdUnWyoSujiD3Lza0pkEphKxU/Ozns/hbHjdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UxIWk3qS; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxIWk3qS"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e04598adeso2436429b3a.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785170473; x=1785775273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PA/ZQauWXReUddivSfGtSx+I+B1NMIaiiIYPzRcsSKw=;
        b=UxIWk3qSXDfiJ+3UA8nyQ4PCZHB4cvr90pHDPFGMt6hnhBKouova2Wl0Aj0P/PHo3k
         isxsm1WYuAJCt254VgdmRi8l8x21puPRUEDIr+k2WAqLX4iAnO+2o/KsJq0jsctanG8/
         3NZ9I8B12c5BqORXsx65DzZQ6lIfX+WxCXnuAXPmCN27hRJfJ40FbW8l9ZTdgLQM5gPb
         7A6AcMpPK1nT6HPXvFrCpzRPnu6MUHMztWviZrvdyBhoTczBRvX/4Pz9MYJswfDon1tZ
         ZlUoRauJpg5RHhj7VxyE6xWzuAfShAmrUcReJbsCEq8WKu9QJAc+UE6eqq38tfjrWWDk
         7WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785170473; x=1785775273;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PA/ZQauWXReUddivSfGtSx+I+B1NMIaiiIYPzRcsSKw=;
        b=q8oy2f/42GfyatpJXVoi0IjEjcw7SwJwFrHi3evKfj2HMjWfh56ZXTDjYs+KhCBiNd
         1VHqrCKh3V1aOO4RGI71+MK+/6aut2/WNeballR7H2e/X7bZ8cDZhdxmf7sl5Io5SAuy
         JYzd2HRIpbWcVG7UrhCy93K57aqIAdI/Z0zZlVJKpdzNp/88UXgAFUcQQ0nD1rflvWoP
         3OxrKrPICVLauy9Jv+AyPyz6lQJpY2zuzi+tf6mgRnit1Sxfh9CvT0/O/7TG1vrOlIk3
         UuAt99q8ORvMOAuQzvT55VLb3KHfeDK4HYHODcllCAn9gQI11iFJ08e1v0PALP/uJe+O
         k9og==
X-Forwarded-Encrypted: i=1; AHgh+RqxfsYmVis3zRLj9SWn+La+9SkDQl4J8daTylu3802zwrUNidV4gJhzhIEaB/lTkZy23kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyowLbplZLmvK8SHZsmkNkCmpmO27UX4gve6IVH6Kfr/UamLQ57
	rnC3kBqBrFWgP3RBVJsM7TK3y0UAHfO5Zy5GQcKJ+blvTq/yzDVG9gBwB21e5c2IKlUjaRosBIv
	4nCuv2Q==
X-Received: from pfbjw9.prod.google.com ([2002:a05:6a00:9289:b0:847:8ffb:40ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12db:b0:848:70dd:f5a9
 with SMTP id d2e1a72fcca58-84e59575393mr7220185b3a.38.1785170473307; Mon, 27
 Jul 2026 09:41:13 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:41:12 -0700
In-Reply-To: <CAO9r8zNE6E7GYg=jrtRVnyG-2xtkFCrNP6FRiH5ZVgmCRKMLtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com>
 <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com>
 <amd7c9Dznv1XM0kj@google.com> <CAO9r8zNE6E7GYg=jrtRVnyG-2xtkFCrNP6FRiH5ZVgmCRKMLtQ@mail.gmail.com>
Message-ID: <ameKKF_XBAXFCTkR@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026, Yosry Ahmed wrote:
> On Mon, Jul 27, 2026 at 8:38=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > > > > What's the main objection to kvm_mmu_invalidate_addr_in_root()?
> > > >
> > > > I don't love the __kvm_mmu_invalidate_addr() =3D> kvm_mmu_invalidat=
e_addr_in_root()
> > > > callchain.  It's not at all obvious that the in_root() helper shoul=
dn't be called
> > > > directly.  I don't hate it, but I do think we need better clarity o=
n what all this
> > > > is doing.
> > > >
> > > > E.g. when looking at __kvm_inject_emulated_page_fault(), since it h=
ardcodes a
> > > > single root, it's a bit headscratching to use kvm_mmu_invalidate_ad=
dr() instead
> > > > of kvm_mmu_invalidate_addr_in_root.
> > >
> > > Coming back to this, I agree it's confusing. I think this can be fixe=
d
> > > with a better name though. Looking at
> > > kvm_mmu_invalidate_addr_in_root() (or __kvm_mmu_invalidate_addr() in
> > > current code), seems like what it does is find SPTEs for that address=
,
> > > sync them, and flush the TLB if needed.
> > >
> > > So maybe mmu_sync_addr_sptes() or mmu_sync_and_flush_addr_sptes()?
> >
> > kvm_mmu_sync_addr()?  The "sptes" part is implied in things like kvm_sy=
nc_page()
> > and mmu_sync_children().
>=20
> Sounds good. I assume you're okay with keeping everything else the
> same way? I assume you didn't like any of the alternatives?

Ya, I don't want risk delaying this series chasing down flaws that no one c=
ares
about in practice.
