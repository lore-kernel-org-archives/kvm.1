Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648A19CD0A
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151687; cv=none; b=r32aNkrSNeBBf+gd7LBJP0x5KvETBADW9axQFD21OwW9MiNljq/CqsNQNe0JUulQVShrC7phzCjjoQyeRSP5fuVfcFTFMkQwMN6A56A1TxSGplXN/Jv4DdKE7r+qykknqzOuPAZxNgmC3kMQ/B1CwUzXpByY+BktfV2lq5YPmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151687; c=relaxed/simple;
	bh=m3j/jUNRah1+dW4WEDLMQT3+cERr21Noh7VJ1dABrhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PmPblleMHfeu+FGlalgaNR/fYUN1mlgifD9O73odwQx+S4QitiRZVBcblG7JEd4xoDcsL+wkf9VT0ZnuCUygC1MU4zrqDKaBE0e+imMfzwMKwNM/E10DO4fRvi0vRgd0BsQ/tC8/qhjrHHmvaINbuIuj6SILEYHFZiVbBsj18yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWnx9bSo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWnx9bSo"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8386367b23cso2024007b3a.3
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151686; x=1779756486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ub9UbHUT7ZNpoW6FWYsoG6UQUDaKiRyMjfcCoG4NCLg=;
        b=hWnx9bSoh72BBVxDOFRSMYPJrlcEQp+VsHJfsguOJ3innaMK77AgYq/L1A4bN+Y2Ye
         cQDASk16CzYt96COp1jjmIEG1e8AIdDbhJ7BeuxFYN542MNOsPJi2LoNSTJsRyqEQlAz
         wo7YqTC4KtaMpGjWKjpb9ObZDCD/n9YYuOFd3s+n18tzcQ7Xtwf2orywzi3w37FjWLhg
         7zp5X7RHDDog2xUIXYBVrpkBNRa7OWnJkOm7DBchta0+x8EBzl+XulhWD9jvx0VTPG8x
         Jr1D4SrvXlLbB2Q3p6c/Q3KIvMoILRrusgPdys6j4np7A0SYNaUr2HdU2eYKHiEga4H2
         RIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151686; x=1779756486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub9UbHUT7ZNpoW6FWYsoG6UQUDaKiRyMjfcCoG4NCLg=;
        b=ZipsmA4uGbYd9Ms7yfyxe6ugBXfzgwru3wNInqQ6qs0AOWMDMm2lQcstxzBNh4UtyC
         XmaND4NLetg7l67j5AfJQRfC4PNT/0A5ix+zUIs200dbnL5qN1pfGBvDeYUyxEIZPhX8
         5VHq5Ssjg9AmY0FSiEwFqMJwSYuaItB0ApAHyh+YWYRfn2RvfrnxKTcOiaTzKSRf63dw
         F5yX4lm3JsV/ImPWOgJ7HpvODBw2JsBxBUVic+RZngSQOfyzHfJmNQwEc6yUvGyFlQ+r
         PxTMuikpp+cE7ZO251LHn0iZVqa9pvKohaYKpJaLV4jAjY6YXq+q0HEu5jpYst6zztu2
         NGXA==
X-Forwarded-Encrypted: i=1; AFNElJ9i/VSgoS8p0ppb1QO2b94WsWS53q/wODjGoZpUBYIPVUn2et5SpMLGA7Y9y9dgnOtmURc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFS1Za07uR5/pUkaM8Cx+VXDN81/c4GluirBWy9eeHaxYoIw3
	8UmVtDFxe5jiGi++vPGYYU0CncIhCZHdUJAmLaUOJaubDZQ5B0W3jrZBc4f8jkOwwZF/ENw45V9
	bWY1Ddw==
X-Received: from pfll13.prod.google.com ([2002:a05:6a00:158d:b0:838:29e3:da30])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca0:b0:827:2ee0:411f
 with SMTP id d2e1a72fcca58-83f33bc8fc4mr14476558b3a.4.1779151685411; Mon, 18
 May 2026 17:48:05 -0700 (PDT)
Date: Mon, 18 May 2026 17:47:59 -0700
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420154720.29012-1-itazur@amazon.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915165459.2235320.12336757234010024713.b4-ty@google.com>
Subject: Re: [RFC PATCH v4 0/7] KVM: pfncache: Add guest_memfd support to pfncache
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Takahiro Itazuri <itazur@amazon.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>, 
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy <patrick.roy@campus.lmu.de>, 
	Patrick Roy <patrick.roy@linux.dev>, Derek Manwaring <derekmn@amazon.com>, 
	Alina Cernea <acernea@amazon.com>, Michael Zoumboulakis <zoumboul@amazon.com>, 
	Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 20 Apr 2026 15:46:01 +0000, Takahiro Itazuri wrote:
> [ based on 6.18 with [1] ]
> 
> This patch series adds guest_memfd support to gfn_to_pfn_cache (a.k.a.
> pfncache).  (This is still labelled RFC since its dependency [1] has not
> yet been merged.)
> 
> === Problem Statement ===
> 
> [...]

Applied patch 3 to kvm-x86 generic, thanks!

[3/7] KVM: Rename invalidate_begin to invalidate_start for consistency
      https://github.com/kvm-x86/linux/commit/190cc5370a8b

--
https://github.com/kvm-x86/linux/tree/next
