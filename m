Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE8238F658
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620126; cv=none; b=CWK8d9jN3RSVXNJpIn0+pxlYX0wh9Y31ti1SBQEjLxIWL8o2qpo5W98FiSz1YtkwQl7pxShSiqxKtrAIMKZwCvpU6wVXDd9MzmUUfi8d5PkkREDnxE3G0aIPNsq91JjNLnFlZjB9Uuj67W5GgegBhbMfPTl2ICwx811xQKlq74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620126; c=relaxed/simple;
	bh=PM7o7yT/Rqooq4IBMLSMsdjoROJ01Ib/Nu/ypwEpkk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ei4p+QJkXUp+tEvdBymJVeJozAGkHoLrQJBpdzKQKHhIFcRmV83t0KBPuYtrxGbgD4xLvCISe5hQ216suUR++VYN8Sq8Td3M6io89VUx0AYSCFvYlPCMvXiElLmKnlLv2+F+GEeZm7y0Xf/RYhIqqBOcnOlpRrj9+KcZhycm6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IemQbq/O; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IemQbq/O"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db87f759c5so33306735ad.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620123; x=1791224923; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCua0pp+YaMex9dVxoGDp0jAQYnIyP+7fQUI4jKTB0Q=;
        b=IemQbq/OnixXiZNmFeFjeYRBndVu0oc89OLyUx9SG/g+a5hBaBOt4Eo9PcLvsJ2Ljr
         YQ7owou9DlPlHx+19BLz5sNVTm1hFQNImh075825vMX6HDVcqPeXpDqXUWMJs+2B9Y7A
         n9FJsn2a6TjtFSKB0mH3hf04+22cneapbnROgvy+iN8xRb1wbUCC9AzfPsmMw+AnWdkB
         K0rX8CgJKLMlURHPyqdcHU6C1/i7BL8m37kLPGHOjkwDJtYMywb7ZW8ZgfnDUdtN6JXs
         GQV745c6INICvSwm3NFOMTMJqisOE6/ikgK3A4Pvd3jBhPXa+QnPFA/UbzEoWb8kb2DQ
         hr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620123; x=1791224923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yCua0pp+YaMex9dVxoGDp0jAQYnIyP+7fQUI4jKTB0Q=;
        b=i4qQPXZptOkvscBBw4gDtVLIhhMeomAZuMHCjnTVrIdlouDZofdcdwtbiYAFuGKQYk
         9vDQXf9BTwNGT1aNAW7/hR0vnRqyIX48eBAO9IHiYhdZ1C8mssOH1KtyIVK23yQZXJMI
         WAgdQESsAyZW8iPbgmDKmY48KIir39Qci+Cn9XfZxEhtwn19bakxjU2t9iHreOmre+tB
         orrOqNs6gDNjU8k+gzpsaeNZbBok+dqksW+MYnlX+4yYn677n6bFv3oCsrYN9quu3O2Y
         hM1uXMUnUlNEk4x6KRhiB/fN1p7qdMkjte4We7rAlMzNwCa1xEtfSKhZXhMl1OoaMQpc
         Qi/w==
X-Forwarded-Encrypted: i=1; AKwUvBydcczOtyWhIFkhJJl6sPDC/wJJRwEudGgnaC7S+/Sp7ydjPj8o84wfQTfBN6hBczXtg/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQXMoURLFvpyOvP98BRwUqzFdjla3vVG5Ue27P2cfAxg+E6bCC
	wS2EuujOm+NiV88utuf8HxP/wM4Dd/9DBDeV37+Jm9TvSJR6pBi7SLjI6l4PIqWhwG414hXXpsg
	IulW+ow==
X-Received: from pleb21.prod.google.com ([2002:a17:902:d415:b0:2e2:bc36:1c75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec8:b0:2dd:b6e7:ac1b
 with SMTP id d9443c01a7336-2df7da427b8mr112270915ad.2.1790620122874; Mon, 28
 Sep 2026 11:28:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:28:42 -0700
In-Reply-To: <20260928164427.4699-1-k@mgml.me>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260928164427.4699-1-k@mgml.me>
Message-ID: <arqx2imW1-OL9IU6@google.com>
Subject: Re: [PATCH 5.15.y v4 00/11] KVM: fixes for CVE-2026-46113 and related issues
From: Sean Christopherson <seanjc@google.com>
To: Kenta Akagi <k@mgml.me>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 29, 2026, Kenta Akagi wrote:
> This is a backport of the CVE-2026-46113 and CVE-2026-53359 fixes to 5.15.y.
> 
> v2: https://lore.kernel.org/all/20260626174620.1819772-1-pbonzini@redhat.com/
> v3: https://lore.kernel.org/stable/20260913155523.7423-1-k@mgml.me/
> 
> Changes from v3:
> - Added patches 3-6 to backport the change from gpte_is_8_bytes to has_4_byte_gpte.
> - Adjusted patches 7-8 (patches 3/7 and 4/7 in v3) accordingly.
> 
> A regression has been reported in the backport of commit 0cb2af2ea66a
> ("KVM: x86: Fix shadow paging use-after-free due to unexpected GFN")
> [1], but the corresponding fix has already been merged into 5.15.218 [2].
> 
> [1] https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/
> [2] https://lore.kernel.org/stable/20260825132543.573783299@linuxfoundation.org/
> 
> David Matlack (2):
>   KVM: x86/mmu: Use a bool for direct
>   KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
> 
> Lai Jiangshan (3):
>   KVM: X86: Remove useless code to set role.gpte_is_8_bytes when
>     role.direct
>   KVM: X86: Calculate quadrant when !role.gpte_is_8_bytes
>   KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the
>     direction
> 
> Paolo Bonzini (5):
>   KVM: MMU: update comment on the number of page role combinations
>   KVM: x86/mmu: Derive shadow MMU page role from parent
>   KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
>   KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
>   KVM: x86: Fix shadow paging use-after-free due to unexpected role
> 
> Sean Christopherson (1):
>   KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
> 
>  Documentation/virt/kvm/mmu.rst  |   8 +-
>  arch/x86/include/asm/kvm_host.h |  32 +++---
>  arch/x86/kvm/mmu/mmu.c          | 184 ++++++++++++++++++++------------
>  arch/x86/kvm/mmu/mmutrace.h     |   2 +-
>  arch/x86/kvm/mmu/paging_tmpl.h  |  32 +++---
>  arch/x86/kvm/mmu/spte.h         |   5 +
>  arch/x86/kvm/mmu/tdp_mmu.c      |   2 +-
>  7 files changed, 159 insertions(+), 106 deletions(-)

With the disclaimer that I didn't do extensive testing...

Acked-by: Sean Christopherson <seanjc@google.com>
