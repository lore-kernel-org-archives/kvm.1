Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7C314D15
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412174; cv=none; b=b8I3mDiCaC7GjqiVNbCqU55I8u6o5iwpNN1ISiuuJyDV2EDSyZncO3YppksfWY1fFpOQBuU6DMQFezPPnhdd5O71R6UCqRJU7xrnxavTYS/gXnKLmDdi4uRT8UGDjTXvxWHpbAMLAu4yoSsNbHfcRjXqBOhi7fsDVwOrtmn7gkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412174; c=relaxed/simple;
	bh=ruI1D+60LviHu6T85gvnun6dB5PLGiX7hIRc8JYMsR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vunm9ON/hz8CtOkFRABvHN5cnx6mjLFggXnVpBfB8zybqicU0e+rXCpa680NLG1Kf5ugnaDxjpcnFl13ZJ/tNQodo3neU6rXzsf6Boo0JDhYoEExlUtRxacleERma5IaV2lonExdWiLskZ8f9+Id2bPNwAZo3ahBoENElDhBAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VW30oJLi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VW30oJLi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c804e38cb1so1145215ad.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782412173; x=1783016973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrTxHjS5w8g7dS4TjG06CQGwg1aqavnJRIR747VzMs=;
        b=VW30oJLi1YnO21Z9dAvCvWUufqDhrW2+KRY9yPzl/a3CX2BEHLYnxMdAfnspHDt5lx
         eVipj7Vqe04jDp8b9Tgo+I34H/suTWeAip66n9cAPxd5XX0+lOjmSUX+RvO8+z5AoVjJ
         7aCZbO9ik+gIZYCaA8ZCytU1iPHuXn4Mqr48BMDzyIVpNthG1K2rtFvxAy8WroyFbkfc
         xc2zcQGBAM1VM2FArRNOdcwyUzuQu7srXQVlynXY0GIuxWo2UebnQBrUct/By4aoEUAo
         erzUsAI9nT7gj/kc6ret8QhSASmRh+Leci3rzUsmIHooD+r8wT37uHYbD5QBeshX5vGa
         l2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412173; x=1783016973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlrTxHjS5w8g7dS4TjG06CQGwg1aqavnJRIR747VzMs=;
        b=BEHCMpPitGqxD+XqMT1WOI387RRHTjft1HOXJQ0ZUIQF1mIBLHeJgJKMlcCF5UUE7Y
         p7XaUwxUi4UFNBSS5jz1TPXX34OQ4ktnmrNDZFSSyt6KpjcCdFWq6Khe/4mEqTCHr1SB
         t9Es7t3nU/x/V72c9FUFnrPCJCU5IADcyMTg2N15dOaJEXZsrs7hZzqHwTG1R1fXGGoG
         WxxScxsFXvWCp7sOSYcN/ewgskvlKHdrnyu1J02ioVB4YPlejkuJC+/eEHP7cje/gU8A
         AKY7lKZOQcFxTjnwq06+asLkyQsSe/nVP91u6prXpYlxd/yp6sO5lX7GIPO95y9pPF6C
         pcbg==
X-Forwarded-Encrypted: i=1; AHgh+RpUoHcUIfrLxPXj2ppVqcCEGGOrbP7b+O1LLuihR/wyeAq9cmkJJcgozIlYzVD1ZyLEBXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ4B5MP5kwOeL1g1L6VyMkenqQxh6T3YKqWTyesqk4m5OS+18
	g+Il7eypsoNxFW98DvP/UmzYi7/0NTCAL3+KSPQO2snnpZgi83zkuhog6b3wzbRiQbDoUHbVgTZ
	o1RfzXw==
X-Received: from plps15.prod.google.com ([2002:a17:902:988f:b0:2bd:4f41:fbf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d484:b0:2be:3850:297e
 with SMTP id d9443c01a7336-2c7fc792f8emr34372895ad.31.1782412172316; Thu, 25
 Jun 2026 11:29:32 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:29:31 -0700
In-Reply-To: <20260527-kvm-locking-docs-v1-11-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com> <20260527-kvm-locking-docs-v1-11-4fe8b602ff47@google.com>
Message-ID: <aj1zi1XIvFpJtNlq@google.com>
Subject: Re: [PATCH RFC 11/12] KVM: mmu: Point users of host_pfn_mapping_level()
 to docs
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>, vannapurve@google.com, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> After consolidating documentation for host_pfn_mapping_level() in
> Documentation/virt/kvm/locking.rst, point users of function to docs.

NAK.  I want the "formal" documentation to describe the rules and general mechanisms,
not arch specific implementation details.  It's unfortunate the LoongArch copy+pasted
x86's code, comment and all, but that's a separate problem.
