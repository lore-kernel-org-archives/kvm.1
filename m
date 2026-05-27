Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3071A9B46
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904201; cv=none; b=o8jTPGMGinVa5TMKmg+1xSzNPVU0M2oNdgf+PzsPwvHNhae8tGPMxLwpu/yoZSCwYM67E55MBIXH6vdWfkyO4/Zjy1kTZxsIA6UGVXZAWUgKnLqDw4gulaKNy2dr94R6PUTaRdhFtdLB1uRgxqMRujEDGzHq/FWYx0DFXHqsBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904201; c=relaxed/simple;
	bh=eMA8bTVP4UAEFx3qcw36WgikEIm/W3nsFDbSw5DKxfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdpzHYmgwTgC7GEzRWEef+EDl6ytI8mo0BA9iPuJje41j3+ADZn4UbzxUHn9Xw5NiV1OzC8vZZiF9NtNvgvofOL4+N1Wxh3oWScgQbv+4FmoLvSdxSTHyAS88chUhPijdKAlZ1RZgmQBfiZQ6KBkxRCdb7X6ls3jzVrtFRpAxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCKR/slz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCKR/slz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-369ef27fd09so10004203a91.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904199; x=1780508999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+J2J4qpcUT09S7+Om94oqDFXFnrnkuv6ZMo8SnRIdBI=;
        b=aCKR/slzUp2v5zIyWbpXujga8mFQnw+NnP8SUIjBFirl2A1jdesPrZtCgVXjfRO8E4
         7PhOYwRgX9BMHQBCTOtzXF1gYK2jNQ1dJIm73s/wmfN2L4tklbFu5Rp4zsOL5InSRi6c
         G+TbR10EByVyEXnSzZT0/WPPhG+QpH8/7aCpvSV4gA5oQd408inXSHHV1q/sdKsIyhp0
         uXhJ8aS+1gYmn+GqdnJrAA/bZhwu6fBTOHDCmbicgQuYPHzsemrCf3lwXVwxTGCX2UqO
         d//btAlC3lpfKbl09cnj3jHw4vAL4TCz0IV2Y1d177p7P5j89RvPRoODKbjybehkTubl
         go7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904199; x=1780508999;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J2J4qpcUT09S7+Om94oqDFXFnrnkuv6ZMo8SnRIdBI=;
        b=JIn770H9qg0UkxweYKA3K3ZS6IhxMyoGS8DElV7JlOkIc6/ARPBTM+hx43s/LOYRg4
         mNEJDFQ5ZwEs9mY4flbow8qh+Y9UqIZPIwWOC1Y6eDwvXT9Df1Z1aNGZABMGP4ouPqwn
         C9Ck9NRkW7CKQZSjixn1a5r1iDfyCawmOoEw5PnyGh2fjDCxux0OGT02v6oQDD2kahsn
         rqpMchQprCJREKV/WyGlAs9xjEpsibsyDZyJttjkiXZDk+yC0VCSDyiqWh/sLX8T4VUP
         3qHIlDv3MpShZfFtG+wiMtJHJPjM4a1QY0qkYEViat2JPvF/uYRti7siDbAaPXwsQLzh
         qXNw==
X-Gm-Message-State: AOJu0Yyk33PZQd9MvDQQj4ePcDsLRkr0gpupH6jdn8z8k0PTgdydOkrR
	zgMSUxZ8HeTA9W6977swUPFvYFE+Km/8YqWnjE4lZzG4cckERNQKCQGdZqrh9WytT7yHO2rdzuV
	MS0NjgA==
X-Received: from pjbmv22.prod.google.com ([2002:a17:90b:1996:b0:36b:3fb6:4476])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44f:b0:368:763a:17b8
 with SMTP id 98e67ed59e1d1-36a6741dd0bmr13982912a91.2.1779904199133; Wed, 27
 May 2026 10:49:59 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:12 -0700
In-Reply-To: <20260514211237.1629774-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514211237.1629774-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989665150.4071709.17279192205297741246.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/debug: Verify DR6 is always empty on
 an INT1/ICEBP #DB
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 14:12:37 -0700, Sean Christopherson wrote:
> Extend the single-step + INT/ICEBP #DB testcase to verify that DR6.BS==0
> on the ICEBP #DB, even when single-step is fully enabled.  Per the SDM:
> 
>   The INT1 instruction also uses a one-byte opcode (F1) and generates a
>   debug exception (#DB) without setting any bits in DR6.
> 
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/debug: Verify DR6 is always empty on an INT1/ICEBP #DB
      https://github.com/kvm-x86/kvm-unit-tests/commit/027ea799b859

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
