Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC93344036
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 23:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637401; cv=none; b=A5fRv3wNKHJLRUycfBxodKwjvrik4Q0T51mirLX36lJ2aTbk60bina9yrcmYUGL/z2fLxzFSzUfFiiN/AQ+IqIjX4s5+rNDhNFYtC2IoSCfpumIraPvR3cYvNTU0fwXPq3QfYBq1igyv6Ad2Dw/AZF4gwQn5tdcq2NeMV/KLzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637401; c=relaxed/simple;
	bh=xJg953kDIMQCVcGBad5cCy8PqtHYIG7YHEk9BopT5ho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWPu7TyPrvj4py4iBark7HLLZ6LCNvJHO2fdxnX9ED3byacdJ/rxEyW/sF8by+X1LiEYbhlP9nUhHpQgpYEC5tfUsf2BoUmDiKFGZwFOfu3sNwwGSL2C4/EPhiOO6zaVcaMiN/PxQUtBzSgGTXr2hXBkqTxFYZPRcqYS6Qi56PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWS7vRLo; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWS7vRLo"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so33853935ad.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790637399; x=1791242199; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmxfbxC6dKbbrMURHxbUMM8J1sxRM1KRxB+INYiPXxE=;
        b=IWS7vRLoyA5LIuUvN8yPLHS0IdQmcGW8+gItojQrcB0foyFqkg1WH0+n9ReXGrgzQZ
         ypXIMiZGxIZFn5weU+11D7IB0X7frTA4mw3dNJ3Knzz7G1DhD/HrsnCuKSfBvtVPV2Qi
         RhLhn0pOPhnBh/oLZWq+TvnHg/ULjXxS6k5CZB/42GLMBjVCQH2UgL5TrBBwXC6i1YB5
         SjFqoeSTu/Q1PpyEEWM9MU/UOakvs3uP/V4kEWOE/yRh3nNCETjO/VXWM/UZMghWz/52
         ocg+TjDWvHP1G3XFBy20qCGRScYS+ANHb5vwAYchLW+JfyRP/Tbd/x+nhlziz0qSlJPK
         in2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790637399; x=1791242199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tmxfbxC6dKbbrMURHxbUMM8J1sxRM1KRxB+INYiPXxE=;
        b=1JMR6pl7qvg/yzLdmENAEA+VD+qsVWyaYC6m1d6MxNE05vRivZ92MLrqv3G01vlP3r
         7INg8o/LU78/3cH6RuHrZe1oYk/JQhMwoM/fFZ27NPe+M3b8sIsEpk7f+mV2GEpG84xC
         NvV7/FLlarCnpc8XNpN3vrBJf2hOM9/ihMKWJ1YIQNxNi7pAWOzguC1kN909u1BVDS7p
         6+ln9knWmpS5QIo72jBkA6sEt7EIgNcTRRL6QZhgIRmO75PWkxNNWSPtWkdwOvAIstoa
         R+uzVJmzD8/Is06WaTzCWBf2NiVzziq+9tG0lk1MIlhoHHunImMRc51vekD4WjUR7vBe
         mrkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrBA/5QxWX4Qw98v2Ukcr84m+YqFvTAPkCnEVWnMnq8dRkpeEGnaY7dupbgIVp2/jJ2Io=@vger.kernel.org
X-Gm-Message-State: AFq9FYKD2LflgheQI2oOErga5IiYVnbIHedKoXJuefJsxDYwki0ttDcy
	+9tlcruZYC/ML7+eU6D6gPWxOgCdc9nQnzbl0QKY2O8FJENI7pyHcbyJTpaguERAubPbwvwgleE
	nAJF6Fw==
X-Received: from ploc24.prod.google.com ([2002:a17:902:8498:b0:2df:b341:73fa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:380d:b0:2d8:d4cd:dc8f
 with SMTP id d9443c01a7336-2df7de8a7f9mr118569465ad.18.1790637398923; Mon, 28
 Sep 2026 16:16:38 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:16:38 -0700
In-Reply-To: <20260815142218.85067-1-hmushi@amazon.co.uk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260815142218.85067-1-hmushi@amazon.co.uk>
Message-ID: <arr1VgGZmgUmY4hc@google.com>
Subject: Re: [PATCH] KVM: Use kvcalloc() to allocate lpage_info arrays and
 dirty bitmaps
From: Sean Christopherson <seanjc@google.com>
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 15, 2026, Mushahid Hussain wrote:
> __vcalloc() makes every allocation at least a page, so a single page
> memslot consumes 8 KiB of vmalloc for 8 bytes of lpage_info and
> another 4 KiB for a 16 byte dirty bitmap when dirty logging is
> enabled. This overhead scales with the number of slots and VMs on a
> host, adding up to memory pressure when guest address spaces are
> fragmented into small slots.

If memslots are fragmented that badly, then the rmaps are also going to be
extremely wasteful.

> The rmap and gfn_write_track arrays keep __vcalloc() and vfree():
> the 4K rmap and gfn_write_track are per-page arrays, 8 and 2 bytes
> per 4 KiB page, which legitimately cross INT_MAX below the 8 TiB
> slot ceiling; the smaller higher-level rmaps share the 4K rmap's
> allocation loop; and none of them allocate under the TDP MMU,

Until nested virtualization gets used, and then KVM pays the overhead cost for
every memslot.

Rather than flip-flop because of a semi-arbitrary limit that has nothing to do
with KVM, I think we should provide dedicated KVM APIs for allocating memslot
metadata, and pick a pivot that makes sense for KVM.  Or just pivot on INT_MAX
to route to kv() vs. v() to play nice with the "not crazy" rule.

> where the waste above was observed.
