Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77B3E121F
	for <kvm@vger.kernel.org>; Thu,  5 Mar 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730752; cv=none; b=i1PLwmXzs2fPukkmYU6ekkroT6BB6NQ2jlJhkzNG5ZX9qdfrwVqTl4QgTuyr4gGoA1xFu+jgz9lSGnmLC0objlw8ru23Zm1pEbXznU0lp6lITSVLG9TSclDssTKkjzCWaWbsWr4cv1TnUqMDi45WclRqCrzSKS/Bdq5PA53d7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730752; c=relaxed/simple;
	bh=NgGfYCv7dN0zD0M0GPhYCNfYtaqld+h0nL/N8ApJEEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+Oayqmq4rXfivYGaqwOaIcpVxOaHJWN+kNSlKWRbGmKVFdUA3dSbKGec2S3uyC3NgcidzJOfjYxZbS3JuOsBwsSddlbSv9E61belnK9RHwz6tkUhENvIKDCuhxym0gdqhOhF03d4igWsLg/aUmrWSMFEPeMqjTZIL9CIObn/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+PCZ1X2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+PCZ1X2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae57228f64so46330955ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Mar 2026 09:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730749; x=1773335549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf8vW7u90JCbplxojwVrRKoZq/g3DU3CoJ/0jiTrQww=;
        b=k+PCZ1X224i/IHh/teOkUr4n5uGMEvE4ynWxnWJ5o2fIjWUEq0F13qDKBBQRQ9NX1N
         QM/Ow5dWjgMyLF6jS+VJrc0SrLdwHA3EFqvV2K5oVRHG9BAkNt2O3W3vJX05GhoR5qi3
         cQ1S8K/iA2VpNqpf7XYVvyOCYGP3jG40kRKCUtQh+K/rTC4SI6OOnTdfuPkQL1k2EIhv
         JEap9nztJdIBLCKd9aswXUww8iacTuN/uE2+07FptHEbYcHJ6VYXZT4ITV62XPuhTn8Y
         Cy0WNjrPCVxh1lo3BbFojbrHoWNwN9n87Qhqk/d6hnI2xgSMVJ5g8Zx1xbhEdcGI2caB
         JuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730749; x=1773335549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf8vW7u90JCbplxojwVrRKoZq/g3DU3CoJ/0jiTrQww=;
        b=kAQoy+1fmx5J53CXOOD8moKtK2GxJwOKVa41UaPhvHn/zJagcCnHtMRSO3Xv/8TKR1
         rTP5YZpJCBQPJ/gjNGxS2elxAtufy8k5yKcf9X5OvsElFFHzyBgpYyok8tzQAEWwtYRe
         Sh2jZaTGlxmXo5Yex6bwN3PC0p0l+fOLJkO9Bz5PsvIYWd6E+iMs78FuR6FJ4jDntGWQ
         b4gW9Ke7994pRDdzjhxn9KtWIgCg7pA/ACYQB7Yd/kHEYyqgOVvlLNdszgBZxZNo0J7x
         CClZuuLgGO2YPvvmzRSZ/N0tMa/SG4tW9QzLoy/WQU94GTpQLYA4vNDK9eIfneJyuyTb
         aZig==
X-Forwarded-Encrypted: i=1; AJvYcCXh3OYkrBWAsDbmvGNbApuOhO/EDAPpysGGA8A2I5plpS5aPf9OnhSoaTOvNuAGbn6dHbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAmU8EGyK0Nqbr70vyzbU7wjY9rOARCUEaMURFPnvC2ynC6+S
	FZtf6s4JK3TKrX0GzsQ/AALxiyTa8poEhCKUylct2b5eSmGm0kbgcNbwoA4vESjgf+O68u3GsCS
	Ic5jrAQ==
X-Received: from plcl4.prod.google.com ([2002:a17:902:e2c4:b0:2ae:3a9f:ab0d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a67:b0:2ad:ad65:7df9
 with SMTP id d9443c01a7336-2ae6ab0f59cmr59198165ad.34.1772730749108; Thu, 05
 Mar 2026 09:12:29 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:17 -0800
In-Reply-To: <20260211162842.454151-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211162842.454151-1-yosry.ahmed@linux.dev>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272515228.1532050.14480018238364788291.b4-ty@google.com>
Subject: Re: [PATCH v2 0/5] KVM: nSVM: Fix save/restore of NextRIP & interrupt shadow
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 11 Feb 2026 16:28:37 +0000, Yosry Ahmed wrote:
> NextRIP and interrupt shadow are both not sync'd correctly to the cached
> vmcb12 after VMRUN of L2. Sync the cached vmcb12 is the payload of
> nested state, these fields are not saved/restored correctly.
> 
> Sync both fields correctly, and extend state_test to check vGIF (already
> sync'd field) and next_rip. Checking the interrupt shadow would be
> tricky, as GUEST_SYNC() executes several instructions before exiting to
> L0, so the interrupt shadow will be consumed before the test can check
> for it. L2 could execute STI followed directly by in/out, but that would
> not handle transitioning between L2 and L2 correctly (see
> ucall_arch_do_ucall()).
> 
> [...]

Applied to kvm-x86 nested (except for patch 3), thanks!

[1/5] KVM: nSVM: Sync NextRIP to cached vmcb12 after VMRUN of L2
      https://github.com/kvm-x86/linux/commit/778d8c1b2a6f
[2/5] KVM: nSVM: Sync interrupt shadow to cached vmcb12 after VMRUN of L2
      https://github.com/kvm-x86/linux/commit/03bee264f8eb
[3/5] KVM: nSVM: Move sync'ing to vmcb12 cache after completing interrupts
      (DROP)
[4/5] KVM: selftests: Extend state_test to check vGIF
      https://github.com/kvm-x86/linux/commit/2303ca26fbb0
[5/5] KVM: selftests: Extend state_test to check next_rip
      https://github.com/kvm-x86/linux/commit/e5cdd34b5f74

--
https://github.com/kvm-x86/linux/tree/next
