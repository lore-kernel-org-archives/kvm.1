Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9C394492
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 22:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268375; cv=none; b=QTUG2rhmIRRbI5c4War5rp6mjuHjwqbqIVFarWrQ90exgcX6OgXN5B34AAAzHdZs0W2R8b8uTMbxUjDGD65fCEew6sV+pNz6RbERIES5tCjdXCLhBsxHdyvslW2zopvBdKI3MjtQBxEc1QsalW2REOzpCRJ9NV5ZzuRDOSubrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268375; c=relaxed/simple;
	bh=9cUzvya+BCsPP5G3W+ZtfxwbI/IVE1JN1gCyf+kSSVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezXvr48NaioUQ5pyUzRYT+py1aUDc15VNL3ILwWGhCah0h1qnu/0U6Gfn9JTuon2RxV3MXqyRj8gVvhAqgjzK3N++DyiLWb2uOTfFly4FWgZPcTCU38vhQ0O0oyLB8Nvmx7Chi4Suk+k8xOIvOPgN7ss0AQ6Q1sr9hotSmghzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBIWXsqC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBIWXsqC"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so1352825a91.1
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773268373; x=1773873173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeCC3Cvq37Q5WNeOtxCbIOXNLPFl2HAffz+O11E5jFY=;
        b=bBIWXsqCA4aKSv4gXqoRRchkynhwHRQaOOVP9ExE3WDVmfWb4I28ztbHnKUZeO8++2
         +fpXfyoyXz7SjneI3O9u+DNIV653OXVEikkXbzK9CqSAekHVh9LA8YFWJrd0ZxnK4TIk
         zwAnlo/NTTZhkfRQ2wKU228vhB739ZMvoteyFkSA9LIpXjZJ6eHAaZF1KXOh/XDzVlVt
         zSgh1JFd2wHIbtmHNSHKLW3XiKkJ9r7YXlNjMVD34+IYQy7EZJNzv8n8Be4WZRPx2+ky
         MNGIVNXVjfKy0oYNMUQmHfK+1ZdoHkJZktc47MleaJNz6ab5/dd8Y0GhV01HsMTKIMtM
         razg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268373; x=1773873173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeCC3Cvq37Q5WNeOtxCbIOXNLPFl2HAffz+O11E5jFY=;
        b=UxtPXG34S5SjPR4bEwIdsNcv3wADKllMGGbLDIk+99RMPDtWeCUM9RMZ5v5ofsrmy6
         Z4ucXv34zAuxw3LO/ak0BJV9FtIUoWZLenFk9U6J1HbJhHhRO8BJYRpsnSn0xe63kzCV
         k4SySnqqhlHYjQHtEqqrIeWA78f+zv+O4REZcg1vCcuoPtF3JXVcrMjF0f+o+oEE5OP5
         se4BUW7zeLYLUKdlnlAK9uf8qxmunusrfZY6aJCaJCuieuanNFvN/88Q6poDa2yzg+5U
         9NG1o5UeiT5O/b6yr3WrgnMbewAx2IzwWtkHw9Pu1moO5ppIxG6z6h3eZhX4c7q/Vbj4
         Oc+g==
X-Gm-Message-State: AOJu0YziravlJ6weu7OfzUyWnElAM7X9pxDdiXTPXN/sA5zepmGP8hcP
	jxpZOmc+EDz7MrmNBWV5btxXgq87wrJ38b+OwgvWlF8sHRU3K9B4V+QJ1wE9qMK71xdP/7uGUel
	qVHNoAQ==
X-Received: from pjpq11.prod.google.com ([2002:a17:90a:a00b:b0:359:803b:2e2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d44:b0:359:9885:3bb7
 with SMTP id 98e67ed59e1d1-35a019e9a33mr4130509a91.32.1773268373208; Wed, 11
 Mar 2026 15:32:53 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:32:52 -0700
In-Reply-To: <20260310063647.15665-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310063647.15665-1-itazur@amazon.com>
Message-ID: <abHtlGP-vSxL3sWs@google.com>
Subject: Re: [RFC PATCH v3 0/6] KVM: pfncache: Add guest_memfd support to pfncache
From: Sean Christopherson <seanjc@google.com>
To: Takahiro Itazuri <itazur@amazon.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Takahiro Itazuri <zulinx86@gmail.com>, Fred Griffoul <griffoul@gmail.com>
Content-Type: text/plain; charset="us-ascii"

+Fred

On Tue, Mar 10, 2026, Takahiro Itazuri wrote:
> [ based on v6.18 with [1] ]
> 
> This patch series is another follow-up to RFC v1 with minor fixes of RFC
> v2.  (This is still labelled RFC since its dependency [1] has not yet
> been merged.)  This change was tested for guest_memfd created with
> GUEST_MEMFD_FLAG_MMAP and GUEST_MEMFD_FLAG_NO_DIRECT_MAP in the feature
> branch of Firecracker [2].
> 
> === Problem Statement ===
> 
> gfn_to_pfn_cache (a.k.a. pfncache) does not work with guest_memfd.  As
> of today, pfncaches resolve PFNs via hva_to_pfn(), which requires a
> userspace mapping and relies on GUP.  This does not work for guest_memfd
> in the following two ways:
> 
>   * guest_memfd created with GUEST_MEMFD_FLAG_MMAP does not have a
>     userspace mapping due to the nature of private memory.
> 
>   * guest_memfd created with GUEST_MEMFD_FLAG_NO_DIRECT_MAP uses an
>     AS_NO_DIRECT_MAP mapping, which is rejected by GUP.

First off, I'm _very_ excited (like, super duper excited) that y'all are
contributing upstream, and especially that guest_memfd is getting traction.

Second, I acknowledge that I am quite, let's say "particular", in my reviews.
Some Googlers have made joking bets about how many revisions will be required to
"get past Sean".

Third, I also fully realize that the ability to engage upstream is almost always
beyond the control of individual engineers.

Fourth, what am I about to say/type applies to many companines, Google very much
included.  In fact, our less-than-awesome engagement in other areas of the kernel
is in large part *why* I'm typing this: I've seen what happens when upstream gets
too frustrated with one-sided relatiopships, and I want to try and foster a healthy
relationship instead of getting to a point where I (and/or others) are so grumpy
that it becomes a horrible experience for everyone.

All that said, I'm a bit frustrated when it comes to Amazon's engagment, and to
pfncache in particular.  I have invested *significant* time and energy over the
last few years reviewing and collaborating on several series that, for whatever
reason, were completely abandoned.  Off the top of my head:

 - Coalesced MMIO [https://lore.kernel.org/all/20240820133333.1724191-1-ilstam@amazon.com]
 - kvmlock mess [https://lore.kernel.org/all/20240522001817.619072-1-dwmw2@infradead.org]
 - pfncache optimizations [https://lore.kernel.org/all/20240821202814.711673-1-dwmw2@infradead.org]

Again, I understand that priorities shift, e.g. that the whole coalesced MMIO
thing may be obsolete.  But kvmclock is most definitely still a mess (I *really*
want the above series to land), and obviously y'all still care about pfncache.

What makes me especially sensitive to pfncache is that, AFAIK, AWS is the only
user of kernel-unmanaged guest memory, i.e. is the only user that _needs_ things
like pfncache and kvm_vcpu_map().  And that suite of features in particular has
been a source of pain, both in terms of bugs and ongoing maintenance cost.

Which, on its own, is totally fine.  By accepting code upstream we're also
accepting responsibility for fixing and maintaining the code.

Where it becomes a problem, at least for me, is when I invest a lot energy in
reviewing a series and brainstorming solutions, only for the series/thing to be
abandoned for whatever reason.  And seeing a new feature-of-the-week come along
from the same company only exacerbates things.

pfncache is especially frustrating because kernel-unmanaged guest memory isn't
exactly trivial to support in KVM, and it's obviously important enough to add
support for things like nVMX and guest_memfd, but yet not important enough to
bother putting in the effort to land the optimizations.

By no means am I saying "no".  This series and Fred's nVMX series are very much
on on my todo list.  But, reviews may be slow and the bar for inclusion may be
higher than you feel is justified.

But the main reason I typed all that up: please communicate to your leadership
that sporadic, unpredictable engagement is making upstream a bit grumpy.  If your
company is anything like mine, I know all too well that it's very difficult to
quantify the benefits of staying engaged with upstream, and thus very difficult
to get priorized.  But leadership tends to react quite quickly to "this is causing
problems *now*".  We're nowhere near things being truly problematic, but maybe if
you can complain a little now, you won't have to complain a lot later, and everyone
will be happier.

P.S. I'm going to be offline for the next two weeks, so for completely unrelated
reasons, this first round of reviews is going to be extra slow.
