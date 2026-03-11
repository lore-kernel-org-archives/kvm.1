Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122EC2DF3F2
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262383; cv=none; b=lMPjIxriYqCIfFeLDzcUCBl+897t7KdjnzNlxG8DRXrlN+Da9ERheHuaQfY5XJMr6/JnasTDRiFh9Otz+Ocjz5Ah4k2n4cAY/SfwijYq5h5bmDOlhpJTS8D7yRlknZyuDRW1p3Y7MXsbyJyLht3QP9Z/BenNouhG+qiZhxUPmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262383; c=relaxed/simple;
	bh=o71C/AD5qgvGO5jgpX9yZnbJ7t+Y9wecHkX8KxbFfF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcG9K9ahUtDom42zXhubAXE2A2WRHz99nsj2EguJ/xXc49Ba3iIqiH7V0ev+0U8KOmtbg1xyDTB3Z0hhke4FDUlZs2LBRgYlOs9Iqlx7PF4TaNM778p9m/Jv8DbCtOL20mj2DloZgv78EEq9hYsf5viEWSyXnR3eKI0PQD30w1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrFe4JmT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrFe4JmT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae50463ba8so24027545ad.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773262381; x=1773867181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmyHvPG3F+7VAgjbQPSIEGT763jqLcPD8PY9s1UcjmE=;
        b=zrFe4JmTv57vTYpWMDW9y3uO03kZORYrFKI3nd0ZaVxtom8u94oNXwm85Lcnyap8DL
         IFzNfH+n71Fvlm06VOgraqUvvMw7r/PDWmuB4zHVfTPH/IcFyJCByWXk0KIRyhaENzGw
         PGILaA7dXGxnD2qg22ZdmzSBnPYDq7TH+aCTFpWEee9v1XQ588MU8AmQ69y8Wii04/Ii
         MAD8nwRIUEDV/w02HaRTF/Dg2OJ6eVWXIVeNYhrNlVpBfCkPdQfFWHrmpxL6d+ka4D8/
         F+IO2a1AP/Yl2c/ILECxeIa5i8mIiVe77dGXN8gDAtRtvchvlEVoAIWFRDHzqdBjeQtp
         aOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262381; x=1773867181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmyHvPG3F+7VAgjbQPSIEGT763jqLcPD8PY9s1UcjmE=;
        b=Y1ILRGnvtPQ32KDqi7Mdsn2y5FVHBxbPJmGSXSnJmfTS0k8NUH0PykvhCN62kl6N7R
         pvTnXSMJvlNzkn6WQIcyo2QQndF7h/DqRRCVJTvbDtS9MPEAAV0wV1XgwROhfNiqFrN9
         pos1GdQDZTThsSKBlvc/Mh8mj5jowwB3sFhcSQ5N8zcV27b5riYcEYvZUl9OvkBYt4BW
         61TbV/kqLaWVqEO4TTylNmPTdYRjdmqQUsrYkV2g2PGZnxVnwPkSGWLSyYf4h6oVBQAa
         P4+o95GmTUlgRkZXjb48ppQJndzOMWnl3gU2ngV7dX+0MYS1rKI9tdgMYTzCA69+zL6l
         rxfQ==
X-Gm-Message-State: AOJu0Yz9aEtvj4czpaO13514eQdhb91B5Giku/4FdS3JNzmBBwbxixHO
	o09HSj1ZgpQEtaVKr2Ojn8uyzuN0Bwy74wzGKhGCtTDpFBm59/i87RDO10eKrlDPgNzeeJezPAv
	OnSLzDA==
X-Received: from pgjh18.prod.google.com ([2002:a63:df52:0:b0:c73:88da:d470])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:682:b0:398:b5c0:565
 with SMTP id adf61e73a8af0-398c60e592dmr3501826637.39.1773262381321; Wed, 11
 Mar 2026 13:53:01 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:53:00 -0700
In-Reply-To: <20260310064338.21823-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310063647.15665-1-itazur@amazon.com> <20260310064338.21823-1-itazur@amazon.com>
Message-ID: <abHWLDvJcWlQOdYh@google.com>
Subject: Re: [RFC PATCH v3 3/6] KVM: Rename invalidate_begin to
 invalidate_start for consistency
From: Sean Christopherson <seanjc@google.com>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Takahiro Itazuri wrote:
> Most MMU-related helpers use "_start" suffix.  Align with the prevailing
> naming convention for consistency across MMU-related codebase.
> 
> ```
> $ git grep -E "invalidate(_range)?_start" | wc -l
> 123
> 
> $ git grep -E "invalidate(_range)?_begin" | wc -l
> 14
> ```

I'm a-ok with the change, but the changelog should make it clear to what KVM is
conforming.  Very specifically, IMO, all that really matters here is aligning with
mmu_notifier_ops.invalidate_range_start().

Because for me, "MMU-related" anything in the context of KVM means just that,
KVM's MMU code.  I don't care what other MMU-related code outside of KVM uses for
naming, if that code doesn't interact with KVM in any way.  And for KVM specifically,
it's a much closer race.

  $ git grep -E "invalidate(_range)?_begin"  **/kvm | wc -l
  11
  $ git grep -E "invalidate(_range)?_start"  **/kvm | wc -l
  16

But as above, I'm definitely in favor of matching mmu_notifier_ops.invalidate_range_start().

> No functional change intended.
> 
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  arch/x86/kvm/mmu/mmu.c       |  2 +-
>  include/linux/kvm_host.h     |  2 +-
>  include/linux/mmu_notifier.h |  4 ++--
>  virt/kvm/guest_memfd.c       | 14 +++++++-------
>  virt/kvm/kvm_main.c          |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)

...

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 2ea5d2f172f7..618a71894ed1 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1566,7 +1566,7 @@ void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
>  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
>  #endif
>  
> -void kvm_mmu_invalidate_begin(struct kvm *kvm);
> +void kvm_mmu_invalidate_start(struct kvm *kvm);
>  void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end);
>  void kvm_mmu_invalidate_end(struct kvm *kvm);
>  bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index d1094c2d5fb6..8ecf36a84e3b 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -134,8 +134,8 @@ struct mmu_notifier_ops {
>  	 * Invalidation of multiple concurrent ranges may be
>  	 * optionally permitted by the driver. Either way the
>  	 * establishment of sptes is forbidden in the range passed to
> -	 * invalidate_range_begin/end for the whole duration of the
> -	 * invalidate_range_begin/end critical section.
> +	 * invalidate_range_start/end for the whole duration of the
> +	 * invalidate_range_start/end critical section.
>  	 *
>  	 * invalidate_range_start() is called when all pages in the
>  	 * range are still mapped and have at least a refcount of one.

Please move the include/linux/mmu_notifier.h change to its own standalone patch,
as in, not even part of this series.  It's an obviously correct change (the comment
has been wrong since commit cddb8a5c14aa ("mmu-notifiers: core")) and has nothing
to do with KVM.
