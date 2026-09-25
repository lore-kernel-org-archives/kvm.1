Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA3303A37
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376322; cv=none; b=rWhl7CUOYxC49ROwqEv6xFEnr3ZH13eqg59p0ibotVZWo4vT9SjZO9XjVz9mxME2UkqNe6gHhQ4cBoguI+SvoY7By1g/IjLzgM7behexgxxQyL7DxqWRlXFWZwAWm3wF5uurKhUBJfPZ3R0CyTqik53ghDG0R001SycDGYxzs0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376322; c=relaxed/simple;
	bh=d58IzfX2BTkV3NAgWt68ZZUNAGW0raC0vnwSaO3B3XU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0m+DCa39ZgtfvjQOUXuCcOAlLR8zZP40/HfwWeRQXxKbatLLY7dOnsYVVX9xtVIho5yXXViYOAUlMl52ASsm4z7S7A2gxtOgS3wa2pHgnMixkK9PUpKhLkv9tUPxU2mO8YomCKWI5oP9VRxM/gADRt+9yr01OafKZUBahfz0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eQ+ESCN4; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eQ+ESCN4"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d959904658so13561875ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376320; x=1790981120; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xfGnDc70s0gEsOcJlAz1bkWN8k2ppZOVYK2oxXDLKg=;
        b=eQ+ESCN4Yzb4rcK+9kLcfop8jehXga+ejLXGdHJ+Uz/qScexnHZ234OmGPjkKSwCxC
         oqzP02WIgbR8jlrp1gr/fHmGZ2U6T7i6c4Vbb+mS1GlXHdrmF+wbWBnrfxKiy5Yhn7gk
         uP6UUp4qfp+fQGOkiJ4CLQ8PKQjP+h3Fvy7KMn1/1LybYwUESyb/VKikcNnDd1w591NR
         O9HZ4gcOEnxoFIhfLCpNOxfme4SyvocK79PAgkdtlo68jl7KZz8nhiFprGqWCrqdOaC6
         9JmDKHwQkxgI4VqhWHh8LFOoriDFXXILg8OIOyZmnPCkPENR6AFPoxFSS8lI+GZaztn4
         EczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376320; x=1790981120;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xfGnDc70s0gEsOcJlAz1bkWN8k2ppZOVYK2oxXDLKg=;
        b=tyg3eYw8RDGa7eJFH/0hunhAbad0uLSD28hRgzluj3+ZPhKMWVbpYaPe1FfWynBGik
         EXospU1Zio/XQ1EFlZLl2uQo0oh5lJuIGDnlvU0awuWKfkjVq75VM6T7Q4PbZKnfkZ1/
         RgP9U23IHEN7Tuvxpw+EECnyrgr0xjjJNWXd5RkCpxWYm3b2+ccf5O6Vexyo4LR7Bcc9
         58L4U+CepXVG9iJQBHfKBmRzlNSzKRU+GJyOCcaY/JgNF85hXNNDixyUwO4XyjeNw1CO
         NRBVVdGd+wIcc5YUr9CQbCQDjOOrs4mnQUNovnT/6N0Cs59TmzIfelKLpx78Ofda86PA
         eq+w==
X-Forwarded-Encrypted: i=1; AKwUvBwtaU8ffFOIyRBPXMfHs3b8HWtjC5q6okqy40cOmZkK2BX53IWPnfF79C8Ah1zTT44jpGo=@vger.kernel.org
X-Gm-Message-State: AFuF++lhAt1ZYTAWKYWkUjP594IAruKkqqCvEBFkzTRPBHshwwT8Ki28
	gL4PWl1GZAiU4yPh85aqTtutDO2xtTxMJFeqgrTaVtwysErt9HwIHycnTbPul8MLMxSD3GnPmMh
	af6H+bw==
X-Received: from plrd9.prod.google.com ([2002:a17:902:aa89:b0:2dd:bf7a:f211])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8b:b0:2dd:c100:7cb6
 with SMTP id d9443c01a7336-2df7dc514b8mr54999845ad.50.1790376320172; Fri, 25
 Sep 2026 15:45:20 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:55 -0700
In-Reply-To: <20260527202219.1502399-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527202219.1502399-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037626041.2353470.10605793000545531634.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v4] x86: Better backtraces for leaf functions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Mathias Krause <minipli@grsecurity.net>
Cc: Andrew Jones <andrew.jones@linux.dev>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 22:22:19 +0200, Mathias Krause wrote:
> Leaf functions are problematic for backtraces as they lack the frame
> pointer setup epilogue. If such a function causes a fault, the original
> caller won't be part of the backtrace. That's problematic if, for
> example, memcpy() is failing because it got passed a bad pointer. The
> generated backtrace will look like this, providing no clue what the
> issue may be:
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86: Better backtraces for leaf functions
      https://github.com/kvm-x86/kvm-unit-tests/commit/98edcf823feb

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
