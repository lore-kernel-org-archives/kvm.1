Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F02566F7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904195; cv=none; b=shTRBnen4FT2UjB+nDh/L/hnUX4oH9Co1fnZdwi9ClqrtH+LbTejAc+XwD+eHZeOk3bpGTT5vt1I+YjCZV0/f6geIvcS50QJAGp4662XUCwtr3ZWOPWmm0O97nXMG68zvWv1xiPXnglQUayfHNifXYBrIgoOWmB+bJdwqVGESYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904195; c=relaxed/simple;
	bh=F4Hlyd+GpSm0Z2LkgQfzpT0lv+QwA1pfQeq7sLpUQgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tO0MaUCL+b9gUiln+oW+TudO1vCZg8a2+c4ZadpsnPfilNNFfvQeX2d9lt2R8w5eJvTipqd0TpvcSz3+qUj+eInQmCO6xrqxCHZDZ04rAshR8arZjzVeGC5+j/JfhWTQq1jxBUNwYmQS1fuLQN6OIEP9D+myqaXi95984ccJM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiAe4Fvc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiAe4Fvc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2beff6b6e74so1655155ad.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904194; x=1780508994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vFuRqWevkRq7vzzLCSXJYewssRkVe7M8beLTocDNTxs=;
        b=OiAe4FvcOsOLtj6WnoS3IU9G+dcCxsrLDM3ikFm8hLTKG0IeIV3u2patFBLJvZschg
         OcnW5VOKMNK/Q/WyHlfhOp/IBA+/4hOLUQfmxwaeBeAULLlNidXTezuhU/BwXdLZvrSw
         J41lbUDd/5Ur3myvryazv2SaaXSdL46/yx8/+81YhO3uLtUM0P2GNlr3dKbBmvYtQ2DF
         4Lc8jRPXOQiKpA45C5NUUukd1tJKB5Z6CgnQxYLSlrghDeI6xS77WF7EwI/qABdzAoBg
         4n1c6NvkZw9ss3RIVBwBnYkqY5qLssEGhZkyfYL+kjwjhAGnojrAeuDYVo54QucY+u1h
         ye6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904194; x=1780508994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFuRqWevkRq7vzzLCSXJYewssRkVe7M8beLTocDNTxs=;
        b=bmZNX6jtuy2Lbqx1bNZaC14SibhBBJSBBOItVtWxmMGdgeLBPqxWd0Hj8M1lxsRazw
         BydNxq6jpDfBwzcXodhw3YLq215oLsqyLP5F35Fetd1d2biH85XiGF72O/O61VqF02tU
         siXMOu8p9ALH5CyP0xv0Ns90ulU2gwYKwPRbMPIr3ITRVGhG/hWnc092dt2VUp8Tgiib
         Dfbm9ZS81lOTl90WGkngRC3Mcle/rRLONBPrvFpNr45qP1yBBI+CVNfFdRs8b62bRj4k
         R9LPgx0FvCGZPBQE0dnYPmmGva1MuzfO8tocuSVPLNmNt5/YoCPuWD7QKMrbNMU/cFJO
         lERw==
X-Gm-Message-State: AOJu0YxTvjvjfJQs4yJsGttAjH0HRIHgBUamRh1AQoqhUe4//Z3kR4rq
	Vi7rBnWeCc+63RSJppB9entuJir6uBcwPEvAHwJzbvMGgAqtqi2Z+qz1wUykjdNIPfUTQ48Pjl6
	Dw6LOvw==
X-Received: from plsh9.prod.google.com ([2002:a17:902:b949:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf08:b0:2b7:aa20:3c61
 with SMTP id d9443c01a7336-2beb083ee1fmr257921605ad.33.1779904193675; Wed, 27
 May 2026 10:49:53 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:10 -0700
In-Reply-To: <20260514210708.1627866-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210708.1627866-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989664829.4071634.5034543633587101687.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/apic: Verify LVT timer register mode
 reads back what was written
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 14:07:08 -0700, Sean Christopherson wrote:
> Report a failure (but not a pass, for brevity) if an APIC timer mode change
> reads back a different mode than was written, e.g. to verify that LVTT
> reads via x2APIC MSR are accelerated by hardware and access the backing
> page when APICv/x2AVIC is enabled.

Applied to kvm-x86 next, thanks!

[1/1] x86/apic: Verify LVT timer register mode reads back what was written
      https://github.com/kvm-x86/kvm-unit-tests/commit/c490a16fe1ca

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
