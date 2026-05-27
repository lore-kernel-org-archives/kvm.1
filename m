Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B41A9B46
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904161; cv=none; b=BkyAdKRg30AzCvtvVXl1SnrAy+IgMTcTRMEv5UNYY4nuGLUF6gE17l8/5dMJWDMRoqHWk22zKDSyGRlfS0nL1rO5q0xKSMS6INrr9fRALBCePm672idJPGOuVScrtpZAj8xjz5fJZxWPqkaSstcGkdnTpsiOGVFOwCHCV6c72cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904161; c=relaxed/simple;
	bh=JA9gYKjVWSoYdAznZ03gluIIktumEbS7npLGNPzJyRs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2B4hmf1a2ZuryRFwX1IQHKQVndOIQxpLwhJj9bXXS95HYJCdAGgeP1LbtnVM3k4c1TQlfE89LGDM0Dt+5E5HmPPivRizQUTsulB0cVIXaLdAl0s6AMXx1KKhb4V5PRj8R82+bn/WnJEXRIN2s3TNhtiLCg20UhmMJCWzpb5Uqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zc+oOPuI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zc+oOPuI"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so10940206a91.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904159; x=1780508959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dD4LLjnnbh8v3LNXxw9sJU47ISXAw6BVEmxkNKPtVc=;
        b=Zc+oOPuI4hilmmoN5rn2xqxGOSWPWfsKJyXTWmlEaGdM3LXjFotPhis6X+d5tmfJ1l
         IqMXv4sg4xLKfceXdjYc+08nSdCWk6PkiBKAUNWsh/HQBOOyojmBYIkfDOqvYwatG8EY
         hoVvWUBNdGK77gMJhZdUrdx242dTA92Tui3eIF08Oj2tDVPP5vXqtcvvZK5E20p7f6ew
         B2Ii7VfWqdkBQrtZSSUnjF6fvod8mxK2HxSGnjmRHqZqSZYWaF4J6M7Ps0N0PMoveo36
         iGVeOpZv1sXl7htuA6Qp7dAYwAnl6+1RpyuYegroGVei6PROJs7Gx/CZVCEO9FhIlmYj
         c8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904159; x=1780508959;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dD4LLjnnbh8v3LNXxw9sJU47ISXAw6BVEmxkNKPtVc=;
        b=htm7VoKR1is26jOjTK4cC6LdpIJKIAZG3wxvU2vFh8AVrn6esxZfQFwQ8QxCLdT+eP
         bdi7rCMsuOdMFo0uXIjYLNakNLsm3jXAzoqFQdjy5A/4FGON6m3Nzs4hNwuyp3r4f7K7
         AnhcBpLpp5k4W/kvTSg6yBCwZDWmzZ6zO6s8l21qeYvFrFSr05X1ipPwetkp+HqTHQ9w
         x0lD8kbqd/yckyh21Trs/RkZAvV4WAXPx+V3kdW+EUjJaLki4eY78hEwuDCdTl/kqDZd
         nriLJFWeX0/oxIqrvSubWEW/k/DUUUft0uAz+a5u8GnEJI55l1W/7oy8liOujGXNb3xB
         raww==
X-Forwarded-Encrypted: i=1; AFNElJ+GYiZo9KPurNafnflE+VLmhlNN6hm3AYfv+je8aZ1Zi2IBaA1D2KTKOHcKBzCn35+jvP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoZJRUT/Ne4pxhRbGxN7yJWUQevhWIYYaeft9f6KxC/gu67z4
	48adHZ4qOItoeq+HmNHhxzmWxeLdTzkJkDHHVbgQuwLCwMo6zaFtjPiD7tm3RLTHA2xwxZLn+s5
	kiUBjBA==
X-Received: from pjuf7.prod.google.com ([2002:a17:90a:ce07:b0:36a:3227:69a7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c8:b0:36a:fcf5:64c2
 with SMTP id 98e67ed59e1d1-36afcf56624mr8565041a91.13.1779904158965; Wed, 27
 May 2026 10:49:18 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:06 -0700
In-Reply-To: <20251224014324.1307211-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251224014324.1307211-1-chengkev@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989663546.4071483.13324448017637391219.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH v3 0/2] x86/svm: Add testing for L1
 intercept bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Cc: yosryahmed@google.com, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Wed, 24 Dec 2025 01:43:22 +0000, Kevin Cheng wrote:
> If a feature is not advertised to L1, L1 intercepts for instructions
> controlled by this feature should be ignored. Currently, the added test
> fails due to a bug in nested vm exit handling where vmcb12 intercepts
> are checked before vmcb02 intercepts, causing the #UD exception to never
> be injected into L2 if the L1 intercept is set. This is fixed in [0]
> 
> The first patch just adds the missing intercepts needed for testing and
> restructures the vmcb_control_area struct to make adding the missing
> intercepts less ugly. The second patch adds the test which disables all
> relevant features that have available instruction intercepts, and checks
> that the #UD exception is correctly delivered despite the L1 intercept
> being set.
> 
> [...]

Applied to kvm-x86 next, even though the SKINIT test fails on the Turin system
available to me.  AIUI, there's a ucode bug or something for pre-production
hardware?

Anyways, I mention that because if others see failures, then we'll probably
need to figure out a way to automatically skip the SKINIT test (or maybe eat
the #GP and treat it as XFAIL?).

[1/2] x86/svm: Add missing svm intercepts
      https://github.com/kvm-x86/kvm-unit-tests/commit/8322ddeda22b
[2/2] x86/svm: Add unsupported instruction intercept test
      https://github.com/kvm-x86/kvm-unit-tests/commit/7586f98f809e

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
