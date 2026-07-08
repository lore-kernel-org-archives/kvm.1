Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0A43441A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528336; cv=none; b=bxc9/l1Gn5zvB4gTTz7U2qEK/tacaEoIV0uW+wt7IZM/EbvhNquCyRcl03bnBZmur+Zff/e3Lty5Rqg/Sz4HfMnYext8lM12j0yRu0EqNKKVGXHh7oxrqC5w7KXl0fWRm++JUkJnVsnfMZgmn/NJbnWeRqM1lKRDjoaoXV863oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528336; c=relaxed/simple;
	bh=ELAaRNXmufDpWRyw5e4kRUaRH4ehwnkjlievr5haSnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8uzwS4BRp/mHgV9+udFzhH9GzZ0zPHM4iiVNBwwMl1qVuYW+4PBsgVezMNKbV5zU+bYK3rxkwKMrw8kvVfOxNzecfq5uKjlNtTqYFTlBhZos4TtgQRPtMrxwv/1+6enPjfKMvXXikHK+ddIBrWqhUuCK3ruLR9Vj8dido2VPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wn+6kdh6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wn+6kdh6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cce406883eso9223235ad.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528334; x=1784133134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEy5HdZpd0Ibwja5HctRB78dr7i4KUZL8/ZL1JbJtxs=;
        b=Wn+6kdh6UZxcCWDZOPpq1fQoSTBPEyWSJ+Xs4ObfeQdfWXF9NdbM1B88j2qc+7YQeN
         iXrvEaWSkmOTQjNaD2t2oGgDbXUB1ex39Qe8il5U0BHLSOZpGhpucc4Kz/1/pmKDcl6w
         8RcZvTwp7/6NHJdC8yKIPmneyvtJZB/BdTgdmx6OdAyy1t2Y8Dlqtft7I6FPtosuQn1C
         czfOInDTsXhpEdsCy8EKsx61bUziwgXcvQJsACUK7+GhDuxEn8KIdd1K3Q8eAK4q3NXi
         zWpzz8TfjB+s+5vTdLOy5i7AHYJ7n/TnU+3o6MF+x9sfiy5Biouwe8ADUEemLcCUj1W7
         KW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528334; x=1784133134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CEy5HdZpd0Ibwja5HctRB78dr7i4KUZL8/ZL1JbJtxs=;
        b=hKRWoypBuxW6MRNJn41lMhDARokTnebKiJ8PDu30Zg14acXa7kM2xJDi8TzrJOM6Xh
         ksVvSWpnxKqvFB1xRHyAnWJD8QnvC+4xeICQ5TlOylZs/SDSbfyRIS9fEVZn9wJNLaGf
         uAyK9RIYELwBLqw2H3vWRijzrchz4oCr/5V8MoD0fr8eJ86cINe/Vl1RZLix63VtvmLE
         86QDE6xW/Tg77FxUq2CUrsIqq9H7mWK9+xyIMgHpq4mAzNX54VEa+jQycSlmJpFV6PeD
         YN261Tep+t6VU3/LkbRwKb5xYkartwZAxiltcePFmFjIWYDchNqz0HNUaHx6dtcs+8w3
         QnBw==
X-Forwarded-Encrypted: i=1; AHgh+RpqxSxJRpvKoHdiH+8lZHqhGV6RC26xyNumsRgolVNph+sTxXw1u6BaKHoS2ZR/lav9hPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwiLU4YekR8tcvRbS2Rhhwr6JG1pmdsxC9xZf3rQVAZKkQL59
	RNTYtyGv9kQICLx2t93gcu75RazXN4npOIgoqdLyIgP1ZVTKe8RMJxnJBnlD3LWWsjEwaVY4nDj
	l3Ps4hA==
X-Received: from plld9.prod.google.com ([2002:a17:902:7289:b0:2cc:6816:b471])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74e:b0:2ca:e106:8e69
 with SMTP id d9443c01a7336-2ccea371b50mr34257105ad.10.1783528333681; Wed, 08
 Jul 2026 09:32:13 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:32:13 -0700
In-Reply-To: <20260625090057.4864-1-likexu@tencent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625090057.4864-1-likexu@tencent.com>
Message-ID: <ak57jSAPmWn4qR7x@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Use wrmsrq() instead of the deprecated
 wrmsrl() alias
From: Sean Christopherson <seanjc@google.com>
To: Like Xu <like.xu.linux@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, Like Xu wrote:
> Replace the remaining wrmsrl() calls in the x86 vPMU code with the
> canonical wrmsrq() helper, for consistency with the surrounding code
> that already uses the q-suffixed form.
> 
> wrmsrl() is merely a compatibility wrapper that expands directly to
> wrmsrq() as part of the ongoing treewide rename to the q-suffixed MSR
> helpers, so the generated code is identical.

Just a hair late, already addressed in 7.2 via commit 2232959db26d ("x86/msr:
Switch wrmsrl() users to wrmsrq()").
