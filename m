Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32402FE591
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919221; cv=none; b=jQ1g3/btQ+2NuUoAd1acnTb/8KKRW27RvYmIPzsptXtLoDL+bUOWh2RtqlJNOdVFjMxMpp1E7WZjodhA2fhuHJOR6EkqxjGw1Gkpgv32PdTjxOZ89ym1N8LAOT+nSUGINLCfeSMGOn3C0SkXO35RUTYkR/7hWov8mGEbn3YQ+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919221; c=relaxed/simple;
	bh=Jj39zL+GJV5pz6XfWlGleOq47XrMqaJoeqC5FiYFqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPmMd5H2/A0zkmN90/D7L5cROMGUm88csJBFxIydHl1azE1BAIsuB3vuIt8s8Gs483riDL6ECdgpWWunoLQ2c2YJA+ssljBJAlSun1sHm9iN46X7c3ikoeoYj3BqrAkNjJh3fmNrnOttVlvQaGhMdr1DUhRHMd9D12n/iApxzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIdQ8Ryp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIdQ8Ryp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AF51F000E9;
	Wed, 27 May 2026 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779919220;
	bh=TgK7nby6kRUgli945kcu99QXGXKnFG1K2WCPKStffaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kIdQ8RypjArWrLwgdRgDxqtqCW1q8wq5pSjBPwrN3iKtdkGz0MF/z+W9ivfAjOkRH
	 2ea5r6S8q2nUjS1oF2eD/4SL+HiQ0+ITtbh2YHx6aVdqJFk52PUniWbGe7eBAKf6ev
	 dndHxWCn53zzTKJHuTRaT0lvJ9Ca5G9MC+Ip2XaNYqK3lsHTi7ZSJV8DTaQFL25MYB
	 cLPr2/1rATNipRS3x+ITj6btd/euRpD60CC+siGVczJUlsHhl7C+0xTCpEhSC1/HDg
	 QfJs1UiuR4oApa2fCYcTLeUcaZfWMFVq/RZUBqtidd88tCIp61XD8BkLgCVsyecd8t
	 w0COSF2fDrHFg==
Date: Wed, 27 May 2026 22:00:18 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Kevin Cheng <chengkev@google.com>, 
	andrew.jones@linux.dev, thuth@redhat.com, pbonzini@redhat.com
Subject: Re: [kvm-unit-tests PATCH v3 0/2] x86/svm: Add testing for L1
 intercept bug
Message-ID: <ahdpRGN3Rctg6MrH@google.com>
References: <20251224014324.1307211-1-chengkev@google.com>
 <177989663546.4071483.13324448017637391219.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177989663546.4071483.13324448017637391219.b4-ty@google.com>

On Wed, May 27, 2026 at 10:49:06AM -0700, Sean Christopherson wrote:
> On Wed, 24 Dec 2025 01:43:22 +0000, Kevin Cheng wrote:
> > If a feature is not advertised to L1, L1 intercepts for instructions
> > controlled by this feature should be ignored. Currently, the added test
> > fails due to a bug in nested vm exit handling where vmcb12 intercepts
> > are checked before vmcb02 intercepts, causing the #UD exception to never
> > be injected into L2 if the L1 intercept is set. This is fixed in [0]
> > 
> > The first patch just adds the missing intercepts needed for testing and
> > restructures the vmcb_control_area struct to make adding the missing
> > intercepts less ugly. The second patch adds the test which disables all
> > relevant features that have available instruction intercepts, and checks
> > that the #UD exception is correctly delivered despite the L1 intercept
> > being set.
> > 
> > [...]
> 
> Applied to kvm-x86 next, even though the SKINIT test fails on the Turin system
> available to me.  AIUI, there's a ucode bug or something for pre-production
> hardware?
> 
> Anyways, I mention that because if others see failures, then we'll probably
> need to figure out a way to automatically skip the SKINIT test (or maybe eat
> the #GP and treat it as XFAIL?).
> 
> [1/2] x86/svm: Add missing svm intercepts
>       https://github.com/kvm-x86/kvm-unit-tests/commit/8322ddeda22b

So I believe there is no need to split that patch anymore since you
already applied it, right?

Also, I think there was a newer version of this series:
https://lore.kernel.org/kvm/20260312204009.3168871-1-chengkev@google.com/

> [2/2] x86/svm: Add unsupported instruction intercept test
>       https://github.com/kvm-x86/kvm-unit-tests/commit/7586f98f809e
> 
> --
> https://github.com/kvm-x86/kvm-unit-tests/tree/next
