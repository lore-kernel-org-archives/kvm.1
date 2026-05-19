Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30D2594BD
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151402; cv=none; b=D4AWnuyNj25XRsqnYyJWi3b6KPJWFg2Auviqo6uaCvuXUP+LRtEuvPvHZCOs81QSYyxy+XdtxBODA5ayGNFEVmBMRDJyz2QOGh3hfFvSlUhPiw+mQDT31gJKIiF/pzPpcBU7Oo8h5+Y9yBPbgbU31zvg9C1pZR0Hv+e96rMmueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151402; c=relaxed/simple;
	bh=qRsPnhBYEICKZLB5dt83iyR7ioJ5uFr9gOpOcCpyMmc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JWR9yhv4Z0bypM/xuv8+o07zE2Hfnw8WVVQguuoQ0f6RHU4uxOd2xmYZ/4I1/v5GNx9VSg4tHSh6WN8b5agHSYwIIQOlDKSdWdCGPZ2PG8x4B1F1PrywukNphZ4JkFKiKdpUn/i7YqgunAC60+2zJ5AgRZ0nE2IpZE4Ei3WT7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KK6JDbZZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KK6JDbZZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa366fb79so4046582b3a.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151400; x=1779756200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGBjT94a+74rvETz8HxBL4S/5E3oNBa6USJdxjpgOKo=;
        b=KK6JDbZZKn/1q6733XNjIMLifcBPKCMaEIgLNV92/Ti9x2S6Y0l9+Gc3nddXqNB5vw
         iBwqPqoutP0F/Vf89KU6Re6ChNm32ndacxmsafTKLtOem8fu6ilaraiePx/ncMc7513c
         ZSBzp245iCVHhFGZs8UnpaCuZlqK7vGUvATJu3ms8Ia01zugITGA0zqAvPmzfPCF4LtX
         AO9UgbxwMSYNm6bgP5f5OYYEHbsgqvQPLR1wKUyPVyjWXMNiZiJz1WY3gwAu9/cEGJvz
         fgvMCxLIGF4HBcPko7xX8t80IF/Uw4KtVHvuUenE+fMeEJToNEkNTfukwWlW2w0IEmZq
         tJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151400; x=1779756200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGBjT94a+74rvETz8HxBL4S/5E3oNBa6USJdxjpgOKo=;
        b=NNgGPheQaBz/DBR8aFS+9azzLdTilcUP7Ex12sHHKn2QbQ7F/lTjo+fQRuWIXLaO8c
         g345PklP+9d7bvBkC9gxNs72TIKsMHIbqwyUqrpvH18SvCsdGbD2W9krVR1DCTqC4Q8/
         7BmZ/rg9Jb9r6Fdx+i8LkDQGGUyat6xPlhfI4jZidUEjH3HDzv5yykgAtrdpSnNr3WOb
         OUCUwes5qa0OczcxwneMZlS4HD8wPxTtyOBqG5lXEHA3XxfHjOpPvAM6ldI9HXbXN57G
         Ak63YQCZAT6HeHRyU4ZJP2KeT+hSNADiV0QB2Hu52lHt1/0Z5T71vT2PvP66x2D9GYYh
         ePYA==
X-Forwarded-Encrypted: i=1; AFNElJ+QGXca2NXsxqiDvUcLvAmyUlKY0CO9B+XB0W8t4icn0HsBBHjQIsAVl4bgQWfbM/Vcjsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xnfIRglE0X6YL4yKSYCfuBtdhPZNGJ2r+BKk1GGQMTmKExcs
	eW8RyiRc2JiZky3jHt8rqWpFhu3mQ9ZeSJqda7OdSD+7iNWviDsP4bh3y1cL5OBR4h7JmITp/zq
	xxiH/aQ==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c7f:cbc7:f21b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3383:b0:3a2:d68d:9e6f
 with SMTP id adf61e73a8af0-3b22ec9695amr20355111637.33.1779151399836; Mon, 18
 May 2026 17:43:19 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:56 -0700
In-Reply-To: <20260428083037.1926902-1-piotr.zarycki@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428083037.1926902-1-piotr.zarycki@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915102047.2229773.8353028347230680571.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix typo in comment in hyperv_features.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Piotr Zarycki <piotr.zarycki@gmail.com>
Cc: shuah@kernel.org, vkuznets@redhat.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 28 Apr 2026 10:30:37 +0200, Piotr Zarycki wrote:
> Fix a typo in a comment: 'vailable' -> 'available'.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix typo in comment in hyperv_features.c
      https://github.com/kvm-x86/linux/commit/b67c030f4f65

--
https://github.com/kvm-x86/linux/tree/next
