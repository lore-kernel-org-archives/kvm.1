Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F2155C82
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775229278; cv=none; b=uKIqG3zcuCM0PZw2QghvBQuVgMK4a7v8BRKeNiHsT2kKYwx6B/n/mLcgBUujhvE1Z9VWqm/KUG3gcLKo4EBVRxGPyEwiKlBQN+KIFHvgyLgxFqtWPK5jiPmdMCIywzaalJpIUCCG9j3uW6g+wJY7ha/vh259Cys5mmejO6kH8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775229278; c=relaxed/simple;
	bh=VGcMGW7oKcgyZZ6x9bulluTgflMwqX0MxG2RYwtxwkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EBe3xG0zg9O8hs8fS9IIHqZ6bieWPSFqr0BRi2TORjTS8k++4pc1uEQAkB66fs0c4gjA0bisrB558ln8eh2h7sl3cqmaZGfj8YVWj6RaUOv9tlmbmwuo3fZb2QBdz/LXDe/Je5JR9t9Wg5cRHDtuIWp2wqWvMGqeohxHuE14cSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLbVFxwg; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLbVFxwg"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so1932980a12.1
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775229277; x=1775834077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEAWgNTof2J2dVtuCYSmlMgRv/5iFSQ7fTuMjmecum0=;
        b=YLbVFxwgLsSn9RbLYVabAf03viRr3YjVKH8JjkG/Rskv9e8mXbs1tHOBjJVD5LaP0G
         WeniAiuWd6IPym7BnSXozYKEEchdwQ2sn6cEaagIuB2GYBUZb58tLZH6BVrdgHJT8t5h
         Y1FTs/sJMH3n1+7ZzUw2Q8os9qjVsprtQ34/n7NYV6ShjWZEjK8a40GzsCON3vSJKL/p
         1ayhR0tPsiVVbtO+5hAqFMp24wqY8EAgCJI0/ehCLnQD7b3vVFc7WOvMgoCNxPAXPExf
         fCxd8u7McWlxaZoQSCxTCd6Skw2wNnVF2lveiulnpQ/6SB0YNAzwZeV1WKJvNxpxffrj
         zBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775229277; x=1775834077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEAWgNTof2J2dVtuCYSmlMgRv/5iFSQ7fTuMjmecum0=;
        b=hoRqLF3qt3aRxgW5gXK6OMAqGkvzoifQntjDzV0/j6ruvUl+9nLHg1tnpGchdimup6
         +Li/dspa0Tt6xeHDYlr3AxaVxvGpkToGm6/yvRkLbHXuDsfDkJPHWCPuk/Pd9GBIuLCC
         35K9jZkgye5Nq+Aubw26TrhwjpDj2bFInadCmkldi2XeUlk6cDmo4GIRea0spAgNtEiR
         uFhr7vRP82s5Z9W/HWLy0rmHs9tvWes6m7/DxVshPt6lGMWjDGFQ1fCcBz7TeRo2Uqcg
         i9SVqghp78CBvI2Oc1LySRFPHLz/rpz8bAFRJdf+1vlNzqn7DsGlU5zwIcwhdtPsETRx
         sCAw==
X-Forwarded-Encrypted: i=1; AJvYcCU4/TbAHAQhS5alqd8+DNPRLlIonFaPGpyFSFRyCIxafRHlR8cwrapm5fpPzUZg25CWnjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMkgdXGS30VIslsZ/C85UkmdYzUUcpOX2zyzRhV86oe2CszND
	3Yt12VgH/qYiQ7nz2sENUPCjJvFoB2cXgXOU6ES6K84UI7OHVxRfeKMNs4tN5Din3ihHl3ZJqhU
	JJznyVg==
X-Received: from pgbbo4.prod.google.com ([2002:a05:6a02:384:b0:c74:0:159])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1594:b0:394:505d:fcf8
 with SMTP id adf61e73a8af0-39f17144bfdmr6759557637.30.1775229276927; Fri, 03
 Apr 2026 08:14:36 -0700 (PDT)
Date: Fri,  3 Apr 2026 08:13:52 -0700
In-Reply-To: <20260307011619.2324234-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260307011619.2324234-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177522804925.287216.14341788038408524935.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: SVM: Advertise TCE to userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sat, 07 Mar 2026 01:16:16 +0000, Yosry Ahmed wrote:
> Advertise TCE to userspace, allowing guests to set EFER.TCE, potentially
> gaining some performance. Patchees 1 & 2 are prep work suggested by
> Sean.
> 
> v1: https://lore.kernel.org/kvm/20260306002327.1225504-1-yosry@kernel.org/
> 
> Venkatesh Srinivas (1):
>   KVM: SVM: Advertise Translation Cache Extensions to userspace
> 
> [...]

Applied 1-2 to kvm-x86 misc (several weeks ago, I forgot to send emails before
disappearing).  Thanks!

[1/2] KVM: x86: Move some EFER bits enablement to common code
      https://github.com/kvm-x86/linux/commit/3b27c82ba2f3
[2/2] KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks
      https://github.com/kvm-x86/linux/commit/d216449f253c
[3/3] KVM: SVM: Advertise Translation Cache Extensions to userspace
      DROP

--
https://github.com/kvm-x86/linux/tree/next
