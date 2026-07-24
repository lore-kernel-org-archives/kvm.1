Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451E8003D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855720; cv=none; b=H2JyfKCodUH52yZ3PTuwnaf0H5lHYSyAsoTxplzO69Yypr+7aSKnD4Z+wjiN7KkHLOcL+6M1iMaLfLbLCxkarQmo63H0WUaOXH5NUI5bms3tvvFTBTzXYGra4HpHEqCpSGEl54l6Udj4bJn5bYZ41BBIZ77thtj1+Dp37ULCHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855720; c=relaxed/simple;
	bh=gukJnQ/fidrxu6I2IMO9Xl5r2VkEX+ATv+e1LpUZl1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q26aaft6pFgAOkOstpphFfVgrAiS2lR8SWyaBCDcEIIvghCiIuFd00W+tN8x/0UWzSgixGQ6iiYhiLt9xyxtdrRe7ChqiwA2sN/+3biuMRk4Dy5TWuoQ6K0QRRAQmW3wjAf22efsItvpf8Z6yRsJaRT96EtAs27YJ+qsR29v1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmgfRgyP; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmgfRgyP"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so11486845ad.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 18:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784855718; x=1785460518; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTzG3eWbWHLelTuypq5zycVXMDqGngOZQFBOY8+dasM=;
        b=lmgfRgyPcxQH9LeBClt8iMOplMgZcG77F9ZdND1ZD8Ohu2p2AFsW7FSyv/W9S26FsN
         ty/W80d3EqI6qergbq07VRi9lqWLmNqoPrdYX1yb/TykiE51XuW8uIBwxwwi96mw4afG
         aQNEHolPmKEZRDfyKTUu8n/OrHvCiWc3VSgXfgel9+7xE0wL1fB8YB0gyROAn2vRnFtP
         Bl8VeYIBZAENASonfFEwrTUZ/dfH2kd6BdNJXvkG7XLspF3qc0110qK4s2gGvPCeN0ny
         cdR6S7et7aoRMxAaVYtFnLU07DCVeUArX1TvQGLYpNnT++9ajNFru1rACLJuHc7wrFZB
         4iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784855718; x=1785460518;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTzG3eWbWHLelTuypq5zycVXMDqGngOZQFBOY8+dasM=;
        b=SV07MdhR2j5jxEX4TEh4r/uGwm9jdsJeCefGxvrL6sUgnj7976dNSlow+xthQZ3AFj
         GfnxsMa34BOfYbiq0PeV7rEbYvViU5xW4sSi1Jjlz3ELflShB1CfygpIJayNrLuOL+yL
         +4u+MfeAPIN/iVC0N/DP16uC3ro036XSgF8VYw2G4slQgCudVCx6Yoobe7x/a132swVy
         2FGnydzixLZDoBwR5M7hsOFdaJyiAAriqe8gw1pM4rchWchs6gn02oW7HljpKVMMDIos
         v4D1vWYvEBJEe7QaGj0aQz2+pP4243B7Gi86SR3VZsmbhf1BYLUGyf2BzLXal+jNRXHL
         N2wg==
X-Gm-Message-State: AOJu0YxXVuU2j5pn+87d1XUksmoAU14tYeBOGCs3LE57OpmDEQ8Aw6VJ
	B0Zw2qj7hCmMyMxZEg/5dr5T6aW62VolWJ249BfOz9fteBO1MZohj1qeTNfQM2853p6e8AfAB5P
	o5buRnw==
X-Received: from plhe2.prod.google.com ([2002:a17:903:1c2:b0:2c9:a5a0:a677])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3508:b0:2ca:61bc:317c
 with SMTP id d9443c01a7336-2cfa71d8e4amr64163005ad.13.1784855717861; Thu, 23
 Jul 2026 18:15:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 18:15:17 -0700
In-Reply-To: <20260724010336.16FCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com> <20260724004757.131420-6-seanjc@google.com>
 <20260724010336.16FCF1F000E9@smtp.kernel.org>
Message-ID: <amK8pbPT4i4GswBk@google.com>
Subject: Re: [PATCH 5/6] KVM: PPC: Use CLASS(kvm_vcpu_map_local_readonly) for
 patching dcbz
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 24, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The commit title claims to use
> `CLASS(kvm_vcpu_map_local_readonly)`, but the code uses the writable variant
> `CLASS(kvm_vcpu_map_local)`.

Gah, copy+paste fail.

> - [Low] The local variable `r` is declared but never used after the refactoring.

I'll fixup both of these when applying, assuming nothing else needs to be fixed
in the series.  Otherwise I'll address them in v2.
