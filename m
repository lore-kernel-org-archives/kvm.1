Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216675;
	b=ctXCgYtpNWphJRKkmpMtQBMRjLWGr2SaMjXwruP74i+ghKk00vXH6hGMXyKDBUsGSBWM
	 0ZUF9AQSXHyKH2ysNiLvBJ+2TDVlliWf+fLeGRta/TnrK2jziHo85I3Cjl3wiYBzuM6Yi
	 DffOkTXrLEl38wxYlG4C6qVEAbiaLsjL8G5hWvO8eolE1sYw6xQP/CDwQVjvj42v68Bfy
	 a/2TzQ8OObRPBVl+KvIOQubMv9082deKF/FYbrgR5887cfma9pRcj381Xf74t8huD8vlc
	 fP69RJ9JEsRKQFIAQaSjaI4W2pZaq9e7VoLpYtI7bCHoPRTDY4A1OJQmTjawdc2pPrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=KaufFdBJJM6uHUO0RxAk0mis1hBr3eWXheXkcNAnmWQ=;
	b=bjJHxiQxG8QPNXpveS1buc+b+/nJtO0L3B21gXyaFl+C6hhRDaJbyXdGoOJ4aKaXYA25
	 788IpDMY0kUq6qqlzygspWkWuS9hJCslJZRtV0leNPde1KZgcVLiRKGkz96iyEjyLIBBu
	 Dqdhb50XWY7EkWagsSYbVgm1xZc36JysNp81d42iXYVecBorp6dVdDc8xITF0YeM/gpVF
	 Zel+Z7u7g8lIwDjH5QOMlX/tvHtGddAAzwxdXWC2/ptAuu1rAlE/gsmV0OUpdWnLaAyrR
	 fmwG1X85ZPO2f0v4T4MHlFAmoXeCygbmsEKHNkx+aCE+lyN/mrfUhg9XESJrHNeiS2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MhmMipq9;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915D606A693
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 23:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5915D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MhmMipq9
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5641cd2cc13so1822763b6e.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795216674; x=1795821474; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaufFdBJJM6uHUO0RxAk0mis1hBr3eWXheXkcNAnmWQ=;
        b=MhmMipq9RgPptx/lndDmkQMVJ8aYvft29vz4F2CxWYa76ZsbvX+XLz+/hlu1nA8CFc
         hPAprRZ8mok+/IaSEZoIGIj33oWy1JQE+F4Z/VDkuIkpM95ZZCYalzy02a4GHouPw876
         iUEcF8OYiun4XKyx4z64IimBjdqXDtQMx4cVC+qGBEqD6Cw78Ncv/SZXcJYuHmYhRssn
         KYr2JaahL4vaDTYlwyMiwF3F891zf1CulgkwbJpdQztDKKFx8v9yHhNMlIb5Irf0sLIT
         SqjDZ90eKkT2gkUMqiThhqdfv2eKSOkqPEaD26EwEuLHwPJq1QS/1VYxmh6whHJZPj3p
         Y38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795216674; x=1795821474;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KaufFdBJJM6uHUO0RxAk0mis1hBr3eWXheXkcNAnmWQ=;
        b=jW3iawtnwWJYULlwp0SX7Yzs3unTnboVECMB74W4Y8910v15tgT09wDTjCMHTko3UH
         serTlBt/ojtUYc+7n8Wib15/1vBPPrAOfIIx2tUXBeZlO88BSS4P+u3EtTnqh8IrGHXr
         AewBMqH39zXyVygSkNzTf6mxDa7Tmd8P187N16QJaTHosgJE8nUMN/WN3XNUqf5mSr/2
         ytS0t88f8Q70rrFAq13+DQesYZhseeJONzyWE7km9un7tMB+qNHuuWErOgRtp9QYM1NR
         MsXItHBPeN/Nq57Of+Ghk8KedeLEnplu06W/t3jd6Ar28sOuBMjMCHwsTTs6g6J7NPoa
         2tmQ==
X-Forwarded-Encrypted: i=1; AL+hErGrm0zlrtFCNFGyNxvTQ+VXKfhtjW/xVPezXu1+JBBWLbf+j4vPreZZPcdvDVsBeBM+xqA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yl76uqtrc07gR+T5GTSBfMr9na4n8gc7AeLofgjUNRb/kSd3H
	RNj/HE17atMGdfDk627WFhopgba2Zq89gtW7Ik6ZrFcucaS9l7UHq0nyTHCbG8JFB8Qb+O084jC
	TZKaEaNsvKIYqPa8SPhC0H82Etg==
X-Received: from ilb26-n2.prod.google.com ([2002:a05:6e02:531a:20b0:53d:d5c4:1e46])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c12b:b0:572:86c8:6b4c with SMTP id 5614622812f47-57a07d19c74mr5405322b6e.6.1795216674015;
 Fri, 20 Nov 2026 15:17:54 -0800 (PST)
Date: Fri, 20 Nov 2026 23:17:53 +0000
In-Reply-To: <iyfa5sagkdapb4plle575uhbxbmjdcxvbe35nnlxkqzfqnztqd@mmweqvqmil6x>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185105.626343-1-coltonlewis@google.com> <iyfa5sagkdapb4plle575uhbxbmjdcxvbe35nnlxkqzfqnztqd@mmweqvqmil6x>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120231753.1170879-1-coltonlewis@google.com>
Subject: Re: [PATCH] KVM: arm64: nv: Fix guest stage-2 mapping leak on
 sub-block unmap
From: Colton Lewis <coltonlewis@google.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Steffen Eiden <seiden@linux.ibm.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 06:35:12 +0000, Wei-Lin Chang <weilin.chang@arm.com> wrote:
> > result, every sub-block invalidation followed by a re-fault leaks a
>
> Doesn't the block tracking node get leaked regardless of whether a
> re-fault happens?

Yes, the stale entry is left behind on the first TLBI. Re-faulting is
just what lets L1 accumulate additional entries.

> For this third paragraph can you improve it by stating how the problem
> is fixed upfront? The first two paragraphs describe the problem, then
> you started to talk about stage2_unmap_walker all of a sudden (which I'm
> not sure how much it helps), and the fix itself is not emphasised. The
> combination makes it pretty difficult to get what the patch is doing.

Agreed, the commit message was unclear. In v2 I will drop the
kvm_remove_guest_s2_mappings() approach in favor of ignoring TLBI
IPAS2E1 when the guest-supplied TTL is smaller than the mapped granule
(as Marc suggested), and rewrite the commit messages to be shorter and
clearer.

> > In addition, suppress exact-match duplicate insertions in
> > kvm_record_guest_s2_mapping() when concurrent faults or -EAGAIN retries
> > record an identical (nested, canonical) range on the same shadow MMU.
>
> I believe this is better split into its own patch, it's doing another
> thing.

Makes sense. I will split it into a separate patch in v2.

> > Fixes: 5491980c1a41 ("KVM: arm64: nv: Track guest stage-2 mapping removal")
> > Fixes: c2778d14cd2f ("KVM: arm64: nv: Track guest stage-2 mapping creation")
>
> Since there isn't a real bug in the original implementation do we need
> these tags?

Good point. I will drop the Fixes tag on the duplicate-avoidance patch
and point the TTL patch at the commit that added FEAT_TTL handling
instead.

> > +	scoped_guard(spinlock, &kvm->arch.guest_s2_tracking_lock) {
> > +		if (!guest_s2_mapping_exists(mmu, mapping)) {
> > +			interval_tree_insert(&mapping->nested,
> > +					     &mmu->guest_s2_mappings);
> > +			interval_tree_insert(&mapping->canonical,
> > +					     &kvm->arch.mmu.guest_s2_mappings);
> > +			mapping = NULL;
> > +		}
> > +	}
> > +
> > +	kfree(mapping);
>
> In my understanding kfree() can be called while holding locks, so we
> don't need the extra level of indentation.

Yes, kfree() is safe under the spinlock. I will keep guard(spinlock)
and call kfree() directly there.
