Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C62BB1D
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778693; cv=none; b=kpuxoXAJi9bKfNecFZIYMSc5v4jspjJ5ETsPJe45bvmzg3yWtF1pFsfoA5fkNPuNqumc8xQPgoFIS73gnoSAmCFCQN6D+qPrnaXD3b8XBgFXIiyIrCYmIbgMDcJuJWWGEL2xrFxqhde7VrLptzH/kyJOVNaZAE3N7UQ11NopZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778693; c=relaxed/simple;
	bh=BIEa1jDRUF6boZyHaRLM1vNQoOJQCh/RwnnX37AuaBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fg880xkuDR2PdwqgUtO7D0DmzcAxB2zbx6z4r1cVHqKEBXgdTFyuLGyLfepzbttbu8GVCnbqJyPCEDMnwsPqIUCY8IzGJbooIPNvlMzQVT3juFdz1SMReyuMwYV1wOhzL80r1uZgtFuRRp6Px9ezIpYYeEH3WnZk0gr6J5n0EA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBTJ8yJT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBTJ8yJT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845317fa7e6so5708203b3a.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782778692; x=1783383492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJL4VrpTqf2HxUAZcAI17Fh0ta/C2HFf6BWtqNuolR0=;
        b=nBTJ8yJTCvEQIJCC+YZOmct0thOKuqJXJyafYSJcU/raP0TiZAWynAUuQo5qDeoBP5
         YKLBmVbB3YTAh+aTrq9Wd/HzsTbCgYlydBH40YWaTWIy59yr49srU5PAx97aQTLPvusd
         G/RYWjP8tFYgs2O/2/GSn/I43368OU8QT5jSvwmezW1/fyrrazX5s/08B99KDvG3zjyJ
         UA4wU8JKR2zAkouD+IQhAGuYP2sBS1tddzi9xkILsCBqaEM8vb9mlpuBIYM5mnPU0xvF
         +OilWqPc02+gf8+AXoBZaz53QMk7peEPHwbclmuEpnVhmQyayJV3U9/T23Lpq/YBcPLp
         pHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778692; x=1783383492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJL4VrpTqf2HxUAZcAI17Fh0ta/C2HFf6BWtqNuolR0=;
        b=JiZWBlO2jF4u5rvz6+KEaYF/VNeH0kX0knUoy4JyRk756/xBxFXflcGn2SdLsh4Q44
         FK94ZdTrjMcyEOhWaXuVRgml54/AZ/NP0B8zRmUX3+nwvwosEfotI2ey9EcqZrnmVQWC
         pfuHEhKKawciS7xzqEMGgYsdFwppIWUTCgbBzGXT1CIYq8OkA5F0U55Z1aznDqA8kVcQ
         Nm2KakpSHr64AVmMYsge2BIYg5JDR32L/9uPY8AaOFKCpzdA84BCGQunUHoXZ0FIdQnj
         OJOi5nLNCI+iAgIH17QQ2gz9eL6w7GlHDFhv1jLS4dZ32TdGC8Jxd457+uHcLr4aJDkQ
         XY8A==
X-Forwarded-Encrypted: i=1; AHgh+Ro6x0sYNgtSf4hQI7hi7ge9CiHWNXawTmks9GHtzu/fXQ/m9dFef43I4lMbW+gawqqfdaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxNC3NQL9EehxUwZCJ5Zw8/QVt/k+js3bRa9kHeU3mrWr1ZAB
	eMbt0J3X9CUcdCl1lsZBeKRhXtemX+X82X9u3dYZUNraEtRhkF3mfzKg0OBm14QKtmWYHNGSbB3
	sBULh8w==
X-Received: from pfuw13.prod.google.com ([2002:a05:6a00:14cd:b0:847:8189:3c6c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179b:b0:842:48ae:1d6c
 with SMTP id d2e1a72fcca58-8479f148e99mr1265640b3a.24.1782778691572; Mon, 29
 Jun 2026 17:18:11 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:18:10 -0700
In-Reply-To: <CAEvNRgEW4WBXB+WGo=g7tNHDALc8=usHCHky-bPbhpRGgyp2Yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-5-seanjc@google.com>
 <CAEvNRgFt=pPi1XpwiaZm1-EWyZKa-1qm=QWOhFwBZ2ab_-oFVQ@mail.gmail.com>
 <akLrd4esRyuyrrGC@google.com> <CAEvNRgEW4WBXB+WGo=g7tNHDALc8=usHCHky-bPbhpRGgyp2Yg@mail.gmail.com>
Message-ID: <akMLQnYYWHrmUvxE@google.com>
Subject: Re: [PATCH v2 4/9] KVM: Rework .gmem_invalidate() into .gmem_free_folio()
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Mon, Jun 29, 2026, Ackerley Tng wrote:
> >> Sean Christopherson <seanjc@google.com> writes:
> >>
> >> >
> >> > [...snip...]
> >> >
> >> >
> >> > -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> >> > +void sev_gmem_free_folio(struct folio *folio)
> >> >  {
> >> > +	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
> >> > +	kvm_pfn_t end = start + (1ul << folio_order(folio));
> >> >  	kvm_pfn_t pfn;
> >> >
> >> >  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> >>
> >> I thought we intended to draw the line such that the platforms don't
> >> reference folios, and so this function should be parametrized by pfn.
> >>
> >> I think we should still stick with
> >>
> >>   .free_folio = kvm_gmem_free_folio
> >>
> >> and kvm_gmem_free_folio() translates the folio to pfns and calls the
> >> arch function, named something like .gmem_LIFECYCLE_ACTION_pfn_range.
> >>
> >> Now for LIFECYCLE_ACTION, one way to think of it is that this should
> >> represent the point in the lifecycle of guest_memfd memory where the
> >> memory is removed from guest's private use, so perhaps "host_reclaim"?
> >
> > kvm_arch_gmem_reclaim_memory()?  I don't want to include "host", because the
> > "reclaim" may or may not be host initiated.  I don't want to use "pfn_range"
> > because it's too close to "gfn_range".
> >
> 
> kvm_arch_gmem_reclaim_memory() is good. It'll take PFNs pfn_start and
> pfn_end? 

Yep, I'll just do a pure rename.
