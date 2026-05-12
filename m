Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D930DEB8
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624093; cv=none; b=UcTYZsUHY5gsgQRh0txoiSq59ld3ZZvb142v5KDTEjDuGfS+4fFcoxfXBDn7K7zb2s/C+qUzHeuvFuxXWDf+1CFzr5xqC1SX4BGMNs48pyZDs5Bj5p0plzcVpB16/bVpwTiRo6O16RU5uUOofGXiBwwvd0UC+INXEl/EzJ7OAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624093; c=relaxed/simple;
	bh=pqF6AM9Dt3z/nZLVnU+34vRVr3VsuY2L9Aj+wg4BUM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhaxK9E5VMgTT2RrPNuG046seKdbWxD8HB+RZEE3aaitgapjFo5vhj2D5/It1B0sj1Q7nY/9xFHXDyn3ilKX5Qvx9FmQeCtz4gW3QrbSwWOuWCkAzxwjclbeTBz6MjedMhH/Zo2xhy43IHDeu0FEQXMy4cAe6/ZRZ7lpkX4mjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ff/i30hG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ff/i30hG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba115ab6bbso58251185ad.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778624091; x=1779228891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjmOu+NAnIneaobgeMn6oj09x39leAVelb/bJ0HDIEA=;
        b=Ff/i30hG8Nc69n1X5ItYQ4agnlue7qdp8qooiPqpLsMbP7+xYFa73qgTLvlVshMCP6
         HkHk/iMAsl215JEo0GphbyVNs7dNcgCY1SPhBaNbV+3aoQDj2b+64SpgDyK/YI448tZV
         Yv71aGraCMhNZdI5rOzDCSXRBn9EThvvCVshWEfzroEt6jwpBCIM+dyoGW6awr2OMhcY
         miMOIEJJCedj2Z3Y6C15NXn7y9w3TzULski/d96RwDf55A+3zVXxUYSxuAUEG+lCEcU+
         Tv9BqHHBjkXK7Jk7Om1uaofx1sTG4cy78owxHyW7tSTpo36VeF4vy+9fLTlQhb40sBSG
         ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624091; x=1779228891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjmOu+NAnIneaobgeMn6oj09x39leAVelb/bJ0HDIEA=;
        b=QTThSsREyUAUMBrEWdEfZPtxL8ZqD2WVmDh3i7UJR0Uie6yaoZJfjeTqG6WeuVIBOU
         Ae8QjJzQfxlV+dI54DMQIX8aTAAgtewvqxAiukc8aMJkO1AkMiI66YaD2NzUHKFS6Bh0
         +62LQWD1qnUVkIIbn0+GHFz8F3MHhs+A88xw2ymVf35b3zAa/bb6qpz/drgc81FAOpZp
         AohoXr1H2DK3SsBUc9BtOemcCpGIoS+9tfWTDWpjmVkWF+5p+wfOUnvocotfbqNwRXz9
         DntW+Pjrdjxh2vjRk7+8nhOOpTX3Jeyt2voFM+WwBR9tXssshUfAHWSudwkyfbrzTPxE
         344Q==
X-Forwarded-Encrypted: i=1; AFNElJ9bB/3hk2AokTTCCWYWHjG1s9dxUfgu0yELsNMuzk98a8Q69zh5fA5n1uTb3z0ZrqO7yRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo1HGRBOmr0tWC2CWG+YU7Hebn28CsTJfbXlsFbe415fRbRoGh
	hjj+QCX2ITNQkIbaLVX1j4WQnj5ThS1xuiIv3nBf9k8OrHcp0fQtVgxaDOvwhuJMk1Kjb1umfA7
	PnHv4xg==
X-Received: from plwp1.prod.google.com ([2002:a17:903:2481:b0:2bc:fda4:ee6e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f04:b0:2b2:5597:bad4
 with SMTP id d9443c01a7336-2bd275de1fdmr8751245ad.30.1778624091329; Tue, 12
 May 2026 15:14:51 -0700 (PDT)
Date: Tue, 12 May 2026 15:14:50 -0700
In-Reply-To: <CAEvNRgGvjD7TtyHKm==55XaTQtSPCTyF89c-UROe5Q=yXEjtpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420154720.29012-1-itazur@amazon.com> <20260420154720.29012-5-itazur@amazon.com>
 <CAEvNRgGvjD7TtyHKm==55XaTQtSPCTyF89c-UROe5Q=yXEjtpw@mail.gmail.com>
Message-ID: <agOmWmxXlgq7Dtnn@google.com>
Subject: Re: [RFC PATCH v4 4/7] KVM: pfncache: Rename invalidate_start() helper
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Takahiro Itazuri <itazur@amazon.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 01, 2026, Ackerley Tng wrote:
> Takahiro Itazuri <itazur@amazon.com> writes:
> 
> > Rename gfn_to_pfn_cache_invalidate_start() to
> > gpc_invalidate_hva_range_start() to explicitly indicate that it takes a
> > range of HVA range.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> > ---
> >  virt/kvm/kvm_main.c |  2 +-
> >  virt/kvm/kvm_mm.h   | 12 ++++++------
> >  virt/kvm/pfncache.c |  4 ++--
> >  3 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 5871882ff1db..d64e70f8e8e3 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -763,7 +763,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> >  	 * mn_active_invalidate_count (see above) instead of
> >  	 * mmu_invalidate_in_progress.
> >  	 */
> > -	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
> > +	gpc_invalidate_hva_range_start(kvm, range->start, range->end);
> 
> Is this actually not specific to the start? It may be called from the
> MMU notifier's .invalidate_range_start hook, but since we're renaming
> it, perhaps just gpc_invalidate_hva_range() would be more suitable.

Before we touch this name, we need to bottom out on optimizing gpc invalidation,
because odds are good the behavior and thus the "best" name could end up being
quite different.

https://lore.kernel.org/all/ZrJIA6t8S9Ucjqzn@google.com
