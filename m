Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9411F4C8E
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151387; cv=none; b=lRVq1DC+51R0gdVeL/1KsIqsagxlaE366oAS8PyP0y8ofTWOoNWBtyOUe/DOFi98jFxaDtURx8P9Wp8mLOWafdnBQibkyu+PNh2171+klcO9LZx1a/Yg6DUiX2GyCIpC2QDBjVpz9m9rRQBffrHLf0qdJHXFEYoq/8QYjKxqENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151387; c=relaxed/simple;
	bh=YCs8M950JAuLCQ2YRE85jxS3h8DGczc2C6eLQfe4P74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LhtdiiGFBBmf3ckF6y+jpFuxpNpFI3emyA1k9VvY6pRLuM3oNLEP8BZ5ET3fGpdlVJhmI5I2oGkLQaxJSu20nt/LZKN4Y8+GFAufE32WlP5cxEYSs9M9RUsdm8cnlYvZy6j4ksoS18wu2VHG4SRd1DmhoAt8QNqEPZ3umG6mbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZ7gehE4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZ7gehE4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso2785934a91.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151385; x=1779756185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D57BR7qX/ksSC+ww8DezBLoCGR7VBze1tDTk/U+aUD8=;
        b=QZ7gehE4YXvbFZ75CM+g5G3ZmuPlR1Ri4mKr62xY7a5wBHjVqSVwwbiXLIufCv3WEB
         xJYxptcwNh7OpQw7vfOEVeSL1kDPqYgPKaZRTT4KbNfntoXSsisnYV50z4KAartCA8VH
         4AwjjBZSEiZYfSJptsexdJfuKbLWgSr/zqZm92XLzCcl72/B/ZJCGZGQTJC1v18sWAAC
         zxMVkPgixiSThn098cvJA57Hp4aNUxHBMoSnK3zzu5zg6IsOCQbpeJEe2yISyWYOueJv
         KceIdSUCp9RTZFLG3P+pN1zNql/DVomubr0Yrz0CjqeCaerxJMS6NQ0aquCp7t2rvFA0
         1wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151385; x=1779756185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D57BR7qX/ksSC+ww8DezBLoCGR7VBze1tDTk/U+aUD8=;
        b=BtT3V8NUyoUYWImoKwvHSm7q42nxbsewVI23pEqWuhRV44uR7573xWVGquRcmuWZ9k
         BS3d6UnNsVQ0KUl6Yb5mFO2mVIoBxy1MGOkmciNTMOO/lDZDBgFmR/NwbT1TAs0gC03f
         F7ncUFNadzHEjpxM6nXAD6aUYnqU1IiIsQbyBuDoZ1E2XwJ8hvy+CfbVocdkmRD6M2R9
         8nzsxheJfASYi4+qBeEx5160JcpDP3s+VnBRdF3D2J4TFC+t0/s1cZ16YG9eArGXkv0/
         1PwUvWOwpk/BHSwUzNCvpB+fiwjvoZDyNYmjA9oYyxuJUx/0M5yYKushPapmwyh9a+aB
         Lzmg==
X-Gm-Message-State: AOJu0YyjW2mVKe5ubtwK37k9psMER+qLSAp90RAq4RwVG7R2lDohcrir
	D+M+ZyZKHmfvtPlRI/k24J538lZsZqtP9KMJ+2W3MnwTR3zG017T6abbjO06UNGUwk/qngPw+vJ
	0G8Jvpg==
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:368:4cf0:fd0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4f:b0:369:e217:d110
 with SMTP id 98e67ed59e1d1-369e217d36amr3867459a91.27.1779151385200; Mon, 18
 May 2026 17:43:05 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:52 -0700
In-Reply-To: <20251230191342.4052363-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230191342.4052363-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915040899.2224048.16612543702203936591.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/svm: Track and handle exit code as an
 unsigned 64-bit value
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Dec 2025 11:13:42 -0800, Sean Christopherson wrote:
> Track and handle SVM's exit_code as an unsigned 64-bit value.  Per the
> APM, offset 0x70 is a single 64-bit value:
> 
>   070h 63:0 EXITCODE
> 
> And a sane reading of the error values defined in "Table C-1. SVM Intercept
> Codes" is that negative values use the full 64 bits:
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/svm: Track and handle exit code as an unsigned 64-bit value
      https://github.com/kvm-x86/kvm-unit-tests/commit/4d60e2429d63

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
