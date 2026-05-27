Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0C3016E7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779906441; cv=none; b=lkPrcZwXNyh0MRN6PjndkqE1gbJl/9wsq5vwkV0yLvV+WBR0RJgSvTeXvsjwfpZHUGHEgT/rAcwGEhx8jIFcDc17LFgz3s4PDdx95iRtLeL+LcASImlUGybMHy6CPADJCM7V5756H0EB1uOHnYwfO75lebZC32cWjKqQA5+2uIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779906441; c=relaxed/simple;
	bh=dyXxG8qXX01Ole+y2VE4c62PBuppQTNY1BIVnBpOcx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQ4/z8FJYesapaLM77jAoC5jKCY6TY8Ng0ff9dVMM9kvMbXuRhqBe6nsblbYOfY/tFLIsFJ/bVfqgQhBmMp4ToXmvqDTbCr0TgbqEOg4qMnr74ItQG+2BQQSvsvKjESAXZoJIa041vSBXuCkFSW157fvTM2Q6/vOJmcZqPzadgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJ1Ik6AN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJ1Ik6AN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82ba4715b6so13006782a12.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779906440; x=1780511240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0wB011PIWABMbZJRSJ2Noc7q0hVsFd1cub89j2zVVM=;
        b=rJ1Ik6AN3XjtKr5j7uK0Rwyrc1xQV3ajKRN/ckuEZOBfmo1cJJRsjnMFtxeNpQqcvB
         wtv7mhGFdy69gX1AjHCFS2SJJI0tzNz9m8Or7arfEdlu5Ro+vQ/hOZ7gfNfp/kNQkZrD
         5P/pSTDbN9AulgYR1HtGJ/YAvm1JrxZaYpCMuK1JjOJq91D/V44+xtbR1ljjlmNdJSn6
         vkuS3oXEw6lGnaUq/QaSRTn1ptPHXRP8oKljFWOGhsQZoYG9nptrP5Yt6hnIS65AHCvR
         8orgHrxPgbUDtxN+mf8ZPDkMI2urK5tQY2h3/dWArHtq5iPLT2o3SElPsTF6QcwaQsyc
         HDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779906440; x=1780511240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0wB011PIWABMbZJRSJ2Noc7q0hVsFd1cub89j2zVVM=;
        b=SwbsnOzBBjDnozfZGjRxLxXuDsLyF5/0+ePPoXWdVkXsKwBmA3xSB63SGxt93IP34S
         tCg2VRgtztkL9WXjnvW0Kj4APa0Ccj0bivcBGxIZz2iHgSAgkk69RIHK8ePaXD2en39b
         TPf9HyH0UJqsViDALkjKgrHKI8Ww14Y7tm7M91DRxlPtZmWdhVleZ3vWX1do+MX5FOcV
         wX3K8pcEzwuDqlp+IWFhQPhZj6o2FC+q+aWUdG58A5Vpae8/ssAtRMMquZ4ZFagTHIvu
         YlNYQUxF3taV7mMSarv+IRUxgAqfDmucBafjxoJnNjcNzNtH1acBBEl9JtDNCsJgKbul
         W+QA==
X-Forwarded-Encrypted: i=1; AFNElJ+oQsMBWEIIOxDfLBXutdzAqbybzUsJnHM9Swe4muBkJBL1+8CmH4nWg+B4IuADWM+e32c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzseW7aUO+GKEOHS3LDwneIKDXf/lqknJ52kyD7RHPfG14lIfcc
	00i7uMqgb6q90VuTcfMOjHZ1jc1p76pui9bgaNccPJ6Hi1ELcEbVP/Da45Uv8yF6BLt/Udvd6J2
	QholiBg==
X-Received: from pgkb19.prod.google.com ([2002:a63:eb53:0:b0:c82:798f:6276])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430e:b0:3a3:a55f:407c
 with SMTP id adf61e73a8af0-3b328cad3aemr26314955637.16.1779906439468; Wed, 27
 May 2026 11:27:19 -0700 (PDT)
Date: Wed, 27 May 2026 11:27:18 -0700
In-Reply-To: <20260509075357.4113-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260509075201.4077-1-yan.y.zhao@intel.com> <20260509075357.4113-1-yan.y.zhao@intel.com>
Message-ID: <ahc3hmTa3TiOTZv6@google.com>
Subject: Re: [PATCH v2 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kas@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	dave.hansen@intel.com, kai.huang@intel.com, binbin.wu@linux.intel.com, 
	xiaoyao.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Sat, May 09, 2026, Yan Zhao wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Drop the dedicated .link_external_spt() for linking S-EPT pages, and
> instead funnel everything through .set_external_spte() for mapping S-EPT
> entries. Using separate hooks doesn't help prevent TDP MMU details from
> bleeding into TDX, and vice versa; to the contrary, dedicated callbacks
> will result in _more_ pollution when hugepage support is added, e.g. will
> require the TDP MMU to know details about the splitting rules for TDX that
> aren't all that relevant to the TDP MMU.
> 
> Ideally, KVM would provide a single pair of hooks to set S-EPT entries,
> one hook for setting SPTEs under write-lock and another for setting SPTEs
> under read-lock (e.g. to ensure the entire operation is "atomic", to allow
> for failure, etc.).  Sadly, TDX's requirement that all child S-EPT entries
> are removed before the parent makes that impractical: the TDP MMU
> deliberately prunes non-leaf SPTEs and _then_ processes its children, thus
> making it quite important for the TDP MMU to differentiate between zapping
> leaf and non-leaf S-EPT entries.
> 
> However, that's the _only_ case that's truly special, and even that case
> could be shoehorned into a single hook; it just wouldn't be a net positive.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [Rick: add in trivial feedback]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
> MMU_refactors v2:
> - Moved this patch to the very beginning of the series so that when
>   warnings like "KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm)" are
>   removed from __tdp_mmu_set_spte_atomic() in TDP MMU in a later patch, the
>   atomic zap change can be propagated via the .set_external_spte() op.
>   (Yan).
> 
> MMU_refactors v1:
>  - rename external_spt->sept_pt (Rick, Yan)

Put the versioning info below the "---" that delineates the diff, otherwise
`git am` adds it to the changelog.

> ---

I.e. put it here.

>  arch/x86/include/asm/kvm-x86-ops.h |  1 -
>  arch/x86/include/asm/kvm_host.h    |  3 --
>  arch/x86/kvm/mmu/tdp_mmu.c         | 29 +-------------
>  arch/x86/kvm/vmx/tdx.c             | 63 ++++++++++++++++++++----------
>  4 files changed, 44 insertions(+), 52 deletions(-)
