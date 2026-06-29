Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED6217BA6
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 22:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770554; cv=none; b=c484mVdiayj9qU68W4jHgH/FQy1Q/6Y/wptWUrW63do7+lQvPhSYWVIlVpXpzbmm5F5rMKYUNrAQUI/dkiqmAAJofrqzh5AEdUA6CtO16oyt7h166YwGOGdz+S1962N91Mb43TpG7ixeFSLq47vRkbYKNED2gtF4htzoVFmOlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770554; c=relaxed/simple;
	bh=T1ui5rQxsJ4ZDgmKCTatJkmDZuhRypTinUX72gLehS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pwX+n/YYtW7wtbOeutgPJKHqjfkF6OZ0bM7OEf4l79fm8MlM9/0dnF3hzcqT97ean6mys2hx5EiYFkkSqYZ7U2pd8LXs9lNW5qETbfSY+CE36rxuTqBlzJqja/msO+9U2CIImUe3moiYWyiaplgFHq5bDM/Jd5zXRropP1ey74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzqCh1ym; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzqCh1ym"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fb51faa63so3272a91.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 15:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782770552; x=1783375352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMo112Q1QX2gMdVrOPPjVAkdlX7RfH+smaOCRiFcEdc=;
        b=vzqCh1ymYx9GZB4HecnKi8n70qR7O8ppb/Y2VBWYQskaxc81par30iu8ixZaZRwsT5
         LhA7xM/o8zSj3GDsrQQgj7+2uYD0y26le10+bQdNl0SNJGtpx/S/qYg59AiUCzqKDPmH
         HwpbzQrYC5Fk4jSbKWE8JcyWwCkGoxAqc3skOA598braopLiR1Vk04FGTvz/OCo8fAXm
         IVPJ+z8YrmJ/LyI9V3LljZoZ3nff8JN1J1aBOXBOYhQxImQuhF7yvqKOqX/rb/wyHAgY
         Mzas4PPCo1wbZ0AzcrFpEB3W3vAR0UCPciNYQlDf7k0uoLPW8CEaGe20k0m6YW/J4fnX
         fy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770552; x=1783375352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMo112Q1QX2gMdVrOPPjVAkdlX7RfH+smaOCRiFcEdc=;
        b=fV770/JUXO895SGSwYZKUFAONzPlCdDDNbUPLESoIf+D+3dF/THA5gl+fDSyeS0C9V
         O1BEodBKLry6W1cFUsHqavs+3oFiNHEZvkDhNGHRhjeB1Sayey+Pm0evvoJN6BzUJvxc
         DZpWOS6oVjJnHcpu49q55K9CCQSRVpQAvy0KQschR+iHgoBiCj7FSRYggPUUru5QdM/C
         zZPZCjtQj6BAs3/4PwDyj6iRufw3Y8wegYAaRs7iAYXBeTtser11rylx/o1MM1y4HRnl
         HIKIXu71DYSZ7ETTm3yh3piqc1zmnNWGchPcXGi2MvHKJQMATjzq7W67IgAiOk9OlAUK
         at0Q==
X-Forwarded-Encrypted: i=1; AHgh+RraWVl3YSXnxUZo9ujSiuUATWc84Ha1hv1jwsiCWd6QeSDARPLKbEpeteUTOc76mOS1CEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0xP3HECr5WEhYFF7E8C2goxTibFPF3m2pVlLJjUEgN1nmCK8
	nQgrbIoAmHgzfNeFt6l7Tn8xZFYJmTUFrIO6lEwRevkhQouRS6cOwttDI/QEe47aqbpQ85QYAPA
	aXwvT7w==
X-Received: from pjdx1.prod.google.com ([2002:a17:90a:bc1:b0:36b:dbd1:f512])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5447:b0:37f:d265:18d2
 with SMTP id 98e67ed59e1d1-3805337b000mr526877a91.7.1782770552384; Mon, 29
 Jun 2026 15:02:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 15:02:31 -0700
In-Reply-To: <CAEvNRgFt=pPi1XpwiaZm1-EWyZKa-1qm=QWOhFwBZ2ab_-oFVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-5-seanjc@google.com>
 <CAEvNRgFt=pPi1XpwiaZm1-EWyZKa-1qm=QWOhFwBZ2ab_-oFVQ@mail.gmail.com>
Message-ID: <akLrd4esRyuyrrGC@google.com>
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
> >
> > [...snip...]
> >
> >
> > -void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
> > +void sev_gmem_free_folio(struct folio *folio)
> >  {
> > +	kvm_pfn_t start = page_to_pfn(folio_page(folio, 0));
> > +	kvm_pfn_t end = start + (1ul << folio_order(folio));
> >  	kvm_pfn_t pfn;
> >
> >  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> 
> I thought we intended to draw the line such that the platforms don't
> reference folios, and so this function should be parametrized by pfn.
> 
> I think we should still stick with
> 
>   .free_folio = kvm_gmem_free_folio
> 
> and kvm_gmem_free_folio() translates the folio to pfns and calls the
> arch function, named something like .gmem_LIFECYCLE_ACTION_pfn_range.
> 
> Now for LIFECYCLE_ACTION, one way to think of it is that this should
> represent the point in the lifecycle of guest_memfd memory where the
> memory is removed from guest's private use, so perhaps "host_reclaim"?

kvm_arch_gmem_reclaim_memory()?  I don't want to include "host", because the
"reclaim" may or may not be host initiated.  I don't want to use "pfn_range"
because it's too close to "gfn_range".

> Then kvm_gmem_free_folio() becomes:
> 
>    kvm_gmem_free_folio() {
>        pfn_start, pfn_end = translate folio to pfn range;
>        kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
>    }
> 
> 
> And in conversions
> 
>    if (!to_private) {
>        pfn_start, pfn_end = translate guest_memfd offset range to pfns;
>        kvm_x86_call(gmem_host_reclaim_pfn_range)(pfn_start, pfn_end);
>    }
> 
> (and now it is right for the !to_private check to remain in guest_memfd
> since we're explicitly using that to guard a *host* reclaim function.
> 
> Another way to think of LIFECYCLE_ACTION is to have the hook represent
> the point of time where the memory's attribute is being set. Perhaps
> "set_attributes"?
> 
> Then kvm_gmem_free_folio() becomes:
> 
>    kvm_gmem_free_folio() {
>        pfn_start, pfn_end = translate folio to pfn range;
>        kvm_x86_call(gmem_set_attributes_pfn_range)(pfn_start, pfn_end, SHARED);

No, because this isn't about setting memory PRIVATE vs. SHARED, it's about freeing
memory back to the host.  Which is why I suggested the comically verbose
CONFIG_KVM_ARCH_GMEM_FREE_ON_SHARED_CONVERSION: SEV-SNP effectively frees memory
when converting to shared.

>    }
> 
> because when freeing a folio we want to set the attributes to SHARED.

No, because the RMP isn't being moved to a "shared" state per se, rather the page
is being unassigned.  And from KVM's perspective, freeing the folio can happen
even if the memory isn't first converted to SHARED (in KVM's memory attributes).

> And in conversions
> 
>    if (kvm_x86_call(gmem_should_set_attributes_pfn_range)(SHARED)) {
>        pfn_start, pfn_end = translate guest_memfd offset range to pfns;
>        kvm_x86_call(gmem_set_attributes_pfn_range)(pfn_start, pfn_end, SHARED);
>    }
> 
> This is biased towards conversions (related proposal at [1]).
> 
> [1] https://lore.kernel.org/all/CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com/
> 
> >
> > [...snip...]
> >
