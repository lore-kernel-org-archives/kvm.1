Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7745D5E3
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729758; cv=none; b=cS9JYoRkvLTubKfpS2CAoDv5VN4rTwItqli4omQrgm4II/CgCcj+r7sF2AY3+FxqMEtyVNhLH0jlMLQgx03UTME9KRmO5bU175hbq09ixj9sRpNbeVT4+7k2WI4MgB4vFFDuzq98zFBxlSXDzpV5N8kFxSfjs8x2P0UdK2gGiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729758; c=relaxed/simple;
	bh=PIWskF4ZCDxq/6IDF1GDcUTBGAvDvlEzIt65G4nhzWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EnwubgT8YYNPSwqSXuRAI82Ul26Wv8w7Sdl3GyijsrA1EdzRa3HnzFgQXJ3BeXPEcpn8Ua3IGPai94hQM3lNRVaIKCBf+a0EgRzacepWMGVWUEqWrkgR6BaLF1rXule6aTnhIbibey6xKsFG2M/W8N19yq8qoJmQUF7XZ3pMJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g3snthFt; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g3snthFt"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d52734fc41so17407875ad.1
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786729757; x=1787334557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wog9Giaz/KBaLgyorPP0bksUgKARZV1Z5rNqBOp/oHQ=;
        b=g3snthFtY8ZAbJat7nFP9LdkrBv5L/1Pjg+jfCFz35SvFwOl3CNgYrEkYUy9PAIs9T
         cs2ZC9ANu0HfZuTu9Jfw2AnxB/SfvZxYotDJYScd1uMkLweXKOippTVJNb/WBGwkjJ44
         ggE9i7eafQjGCNQztKUgBodaNv9cgQxEPMnGnMQy1kxzuP/4iRK9HgiJgRsUeQIBbApK
         7Fh6TylTLjSQTnsGcMpF6iDcmkg1dQ/uQ3v2LqHUGo/tb+yNYCEhWOwhiKSlvYxx7+o4
         PGnp4Ub71mFt7hWadNrQBrTLKpwlwQMHMO1HiL2MVzixm3pNwm8Ih/w4sx28pFcfA7IJ
         B/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729757; x=1787334557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wog9Giaz/KBaLgyorPP0bksUgKARZV1Z5rNqBOp/oHQ=;
        b=sKXQJbk5e5uMvSI4PCSjlKPMid7YA2Z1rmOGeHH245op3usKST4sRXL2PVZqtkGFfq
         zh4EdHV1WPb3yH4f04KkKPzykxX0ldxfLljTQD9Qh7K3R8cXGFu39U7R8rmseLA4oBuM
         MW143p9omfDPk64BTdqpOLxYDF6xbIJ1U3bgDxxwVQnIt7gveV8PKseBNi+r8kl4Tjr2
         acGuQR6185+WEbcTOO4JALJHdWun68SY6d5uXTroSuwtrw65/FIxNcNufkR0e4P7jdS+
         CAvggcQpvIiISK6A4DqyJA4kUbWL44RfPkJJt15ontrDZUb8ICSCQEqOjrDjBmOWSAYU
         K+wA==
X-Forwarded-Encrypted: i=1; AHgh+RrC4IYRpf3teQGYyS1avjLBuX+QHJxlHkHU2skTfCcQ1h12/JWxetl7Sl4nGTcwkeSdChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtI3fb55/z0mwGZQ7P2GsEc9ZfX5H7UUGAlqtAd66Pt+nQ77Al
	Tl/Tgt38tQM/YA1eCSmeQyR+GoY73+ckB91lXkkZZqorIZfFdH2M7u8V7a0qfSqZW96Q3YGFDaM
	PM0iy3g==
X-Received: from plbjf7.prod.google.com ([2002:a17:903:2687:b0:2cc:66fd:42ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d0:b0:2ca:6c8:abd8
 with SMTP id d9443c01a7336-2d3b0e435bamr101107835ad.12.1786729756700; Fri, 14
 Aug 2026 10:49:16 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:49:16 -0700
In-Reply-To: <an7J9Gh2DTrtP5vT@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <an7JGuzynPBaYB5t@192.168.1.215> <an7J9Gh2DTrtP5vT@192.168.1.215>
Message-ID: <an9VHNUEx9CPzquP@google.com>
Subject: Re: [RFC PATCH 1/1] KVM: x86: Skip empty TDP leaf page tables
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 14, 2026, Hao Zhang wrote:
> From: Hao Zhang <zhanghao1@kylinos.cn>
> 
> When KVM zaps only leaf SPTEs, the TDP page table hierarchy is
> intentionally retained so that subsequent faults can reuse it.  However,
> a later zap of the same range still descends through retained 4K leaf
> page tables whose leaf SPTEs are all non-present.
> 
> Track whether a retained 4K leaf page table contains any present leaf
> SPTEs.  If a zap fully covers the corresponding 2MiB range and the page
> table is known to be empty, skip descending into it.
> 
> Keep the page table hierarchy linked so that it can still be reused by
> future page faults.  Installing a new leaf SPTE clears the empty hint.
> The hint checks are skipped for ranges smaller than a complete 2MiB leaf
> page table.
> 
> The iterator restarts its walk from the root after yielding.  Allow the
> restarted walk to mark an empty leaf page table again instead of
> permanently excluding the page table that contained the yield.
> 
> Tested on a 4-vCPU, 1GB guest with five repetitions on the same host.
> The main improvement is seen for repeated same-range invalidation; rolling
> sweep workloads are mostly neutral.
> 
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> ---

Does the generic iterator solution I provided a (long) while back work for your
use case?  I would still strongly prefer a generic solution that doesn't rely on
storing metadata in the MMU page.

https://lore.kernel.org/all/ZxmGdhwr9BlhUQ_Y@google.com
