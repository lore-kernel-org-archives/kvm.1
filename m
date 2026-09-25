Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E64E8DF3
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376306; cv=none; b=Z1fuCuszAdg5RLrAFqCU1JvJPBAA79gpADTfx7VdY4rws8MncUW5EJvKqHPVn1VCFn1Tm4SYZuLXOWbyfX5D3U4QD6ViPomNuG5oMqbz3HzaEs6fBCdapWFEMPUh0KstCUcvlYKepP7XOX//bT1szvPaOaqWViWPjxba96EKA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376306; c=relaxed/simple;
	bh=oluzl8LBDUZPNZm2HsXfzuanivWf3PdYjuCE83YYad8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htHzkaOAfJmJpGug+3DQG3MiMunkOt/uy9r4eJh3y/hfL06cP2KfJBUCSQGAjor5eemBuTY+ZLY7Lgo/VxjAysdayy1Cqmdp94l58hsIFs1rdcVksZKYW3xWJSIITaMJp/RUHkECUlLmR99KF43SC21eL8tAXOT/nvZBYA3noo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dckwRG0l; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dckwRG0l"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc7337e2a7so12052885ad.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376304; x=1790981104; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqtGrJ5jqflW5xBMt0Uv8Bmx2KOs025F8InGi5xIw2M=;
        b=dckwRG0l3M37qgxaL1UHaW/xBP/Gl69ZqqGbUBVB9Nh0EBjuYnORKtbXM/bhl6JvR3
         wBF3EbMEYDNrBsQPU9pK3j2Q/p/7W6IxtAtHwBepAQQ77lIGKjkjts9lvCLteJT0HpBG
         uIxLtfB5+sXKn216fnnVsvGAIwgdQ23FF28SunXFStDSx67BYxA/O+bzLk2P9NQ5pXMo
         B4VXl4AxUN+1JjSlFWwAWvkBIQDnJZNlovLxTzSq2rZV5/mz2UYbdvGEIRfeGtMPOp9G
         CnUe+ZQzmsT/v08aDvZGGOh9BEshAGcY3jZebNmrxwlqEH7is0o0/bxCYNRDgyYeUpt/
         MjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376304; x=1790981104;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqtGrJ5jqflW5xBMt0Uv8Bmx2KOs025F8InGi5xIw2M=;
        b=Gn0KYQUWV0f4kPyPAy3gMbQq6FeGuaD2CgQCjBQup1bsQuZybL3PJ4s8+bkXzi+nc8
         WodC1ACTU/MmuQ3tS1NDdSkxJlK+r/w9lUzWe3+j1AsPCQB8K1+Sg23RxAsNiS8u7pPq
         lzBfEiLeHG7g363f+Ht7JZV+FVJGAC+JziCSGJzOML9pcawAv0OmeTIxNzwlieIpsuNX
         E69oavvmhq6qTNMOnjhAFKVrjA/qL57PXMoVJXFUnY3wyg2Cq5F+HkQMeuUNH7QZjhvE
         z/9RIfOkQizVqmFhn8GmJb+RK99HDZKuEr8G2BQ+EnC/SqlCsTWXWFEVk+pLwJRV2Z1N
         g2MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwN1QBpzj865BbbtWU3UdO1gc36hMmwta6Vk/g/q+R3MmK4UaRjdoLCklmR0HVfAa0DG0=@vger.kernel.org
X-Gm-Message-State: AFuF++nIEI3ryBQnzavMYbOnRGexowbXPFR7jB6NBXJfQiF2ej40hMGJ
	JopMUnrwEJSvBlglNVpJ/wcQ0NW4xI5SZubabvdp/YTfyjiOh3HZn3Q5WV1PcCbnUoTaZCKz4Od
	vr5IoMg==
X-Received: from plhv16.prod.google.com ([2002:a17:903:2390:b0:2df:980f:45a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c8:b0:2dd:c100:80ba
 with SMTP id d9443c01a7336-2df7e669010mr56323425ad.53.1790376304089; Fri, 25
 Sep 2026 15:45:04 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:50 -0700
In-Reply-To: <20260519080127.69056-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519080127.69056-1-imammedo@redhat.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037624996.2353293.17045219308855902250.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v2] x86/svm: work around Virtual
 VMLOAD/VMSAVE bug on Naples and Rome
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Igor Mammedov <imammedo@redhat.com>
Cc: pbonzini@redhat.com, babu.moger@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, naveen@kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 19 May 2026 10:01:27 +0200, Igor Mammedov wrote:
> AMD Family 17h models 0x00-0x0f (Naples/Zen+) and 0x30-0x3f (Rome/Zen2)
> have a hardware bug where Virtual VMLOAD/VMSAVE causes spurious VMEXITs
> on VMLOAD/VMSAVE even with intercepts disabled, when the VMCB physical
> address as seen by L1 falls in [0x78000000, 0x80000000) range.
> Reserve this range on affected CPUs so the page allocator would never
> allocate the VMCB there.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/svm: work around Virtual VMLOAD/VMSAVE bug on Naples and Rome
      https://github.com/kvm-x86/kvm-unit-tests/commit/1cb376031ed1

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
