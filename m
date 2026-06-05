Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24080339861
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684313; cv=none; b=IutgFbvF8fdUfHbiMx8pkKKIVrTphNx9vd6wJ5ZlhbKodpxeLW/hn7o7gUuq2mUu783snM86YNKup1CVyjI2azFQzOioGROapwhDDtjcu9OVWGWUUKXgHZXkkRAczyfajPubmvIyPbCgz3SFl63eAlGxukzisxTuyb1e646V1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684313; c=relaxed/simple;
	bh=7Hrevctw2kVvIFGvIdYfb1rfMcD0q0BwjcLSfLbmD6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a3r+tAz+De2RD28iGQQaNBG0kOmio0KVwVgc6ptdIaov7xB9Ye0GyF6yI4NJinD65aS7JQkerDJ6gZhJod8jFiaqcKzMEx5dCElkMolKWa3bsc9cXfnpVvglkuvjH0QzSW46t+1lD4AYMtIpPxA8QxPtSuOwN12ZVxeCuu3USpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tC1+45t0; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tC1+45t0"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84238e83851so1380756b3a.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684311; x=1781289111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5k76vOmPeH6EDg2EWxAxgZUvgvgqlPv7AHkxUAsuZSo=;
        b=tC1+45t0t8ieaxs6wVEDOcfx4vZyeTYXR6xfplnUDcKzXN7Y4Y18CXE/4GKLoPWPWT
         xg0Y6IopJK7+Ln4tf6txjXeeL2sRfbgZxjXV8BRDIT7K/QI2ED+0qPNEwm1B0gHnUv7x
         OwHaQJnXuaM9oVyu0nu5EvI5xeh95lbeciWwlNfRwVlokdpaF4A/bsWA3k0cnwWxyB+u
         QCX0/fvhcCfBpJ1RPkdex58MDWhqZ7pQuN4tGfzbkf/32amhVmkUudxmD9mOROkGbB+j
         zkks0c7Hx0UpGvFtme5drQBeaXNW/aqEzOU7EprJhzWWELLJ3HGIw4ldx8OfVi4K7He3
         Rihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684311; x=1781289111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k76vOmPeH6EDg2EWxAxgZUvgvgqlPv7AHkxUAsuZSo=;
        b=jLh0QxKMlJ77zDqVG46nWHOGxScNCvupVGL18WBXat/g1g51NNVPlx1gSnPBgcnPDC
         ohPx43RUI/nw9Ic9Rvz3/Kuymf4sXIoYw5rcdd65wvoDon+Z8mZpwXAF4ZjGz4+UKDeK
         uo1wsY+rR6Ja7jROS7SEL59gPMLu/jOHIjhD9wPc8PC+rQaS9UA1TO9O0d0ZSaxqwM20
         lOs+Xmcnq+L9qSTbAthO9banvK8CyhnHI31CjIpQBvKOmGdI/6gZ7iodaXvEv/YUZC58
         Xzr585nqh3nQzzgjC+u52zO00zSNkbYBuurGPYXde09ZPT8LpG/I5TCo6nTmcz1AWc6C
         Wrjw==
X-Gm-Message-State: AOJu0YwdzPAtuJYIbvu6152zKckwI232T6vxfTeQh0/Lcn1MXRGw15Ko
	On0v9Xi+ZKPKPLfXLSz9VpvQDL3HhuSvPwIXn713IEtQA6vq8YnmWLuVCi4gnkRW2eyIdnDcdgR
	1qEiPxQ==
X-Received: from pfms21.prod.google.com ([2002:aa7:8295:0:b0:842:39c0:1203])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e05:b0:842:5711:9a44
 with SMTP id d2e1a72fcca58-842b0fb8bfbmr4444286b3a.36.1780684311190; Fri, 05
 Jun 2026 11:31:51 -0700 (PDT)
Date: Fri,  5 Jun 2026 11:31:39 -0700
In-Reply-To: <20260602170921.1304394-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602170921.1304394-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <178068414570.2235815.935851291865259251.b4-ty@google.com>
Subject: Re: [PATCH v4 0/3] KVM: guest_memfd: Fix signed offset+size goof
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 02 Jun 2026 10:09:18 -0700, Sean Christopherson wrote:
> Fix a bug where KVM fails to reject a comically large offset into guest_memfd
> if offset+size results in a signed, negative value.  Add a testcase to prove
> the bug, and to serve as a regression test.
> 
> Note, v1 and v2 was part of larger series.
> 
> v4:
>  - Collect tags. [Mike, Ackerley]
>  - Use "INT64_MAX - page_size" instead of hardcoded literal. [Sashiko, Ackerley]
> 
> [...]

Applied to kvm-x86 gmem, thanks!

[1/3] KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
      https://github.com/kvm-x86/linux/commit/eba85fee7fc6
[2/3] KVM: selftests: Expand the guest_memfd test macros to allow passing the VM
      https://github.com/kvm-x86/linux/commit/b7a23fb0ed7e
[3/3] KVM: selftests: Add guest_memfd regression test signed offset+size bug
      https://github.com/kvm-x86/linux/commit/b408b52e7111

--
https://github.com/kvm-x86/linux/tree/next
