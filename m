Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6937C909
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528687; cv=none; b=Uc5yHUK0C99z7yXXCh395PJsL+zEkJ4249s+GlWZLuOkPuzbqkpV6iAm4fxGfjG9G/9Yl7C1v18eQvk3Rh9aDHFdCin/FOqe6JxSchIIoZ1T6jCr3YKcZdYEyLEkmwF441ohdW1hJXDRRz+/DCytIy1wHDhjROAhJVH/g1YTF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528687; c=relaxed/simple;
	bh=0JhCYeImFR4V0eGDTnEJ/nyjZ2keDyW7cUkdNId6les=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6fiSX6QVBtgKgwSkrx5yQXTB+btDxUlgIyLXuFcZL32sucFO7osDSdYlFqBavnq1DWfBM1gSz27vN2m8o+vtYZy/ofe9HPutjhUiqD7f1dIKykzP8QRjNEw+IDLUxbrShft/rUzLTgTvoBffz+SaPWINZnF7GeBWMdzluCutVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jlAO6h9o; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlAO6h9o"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso22754265ad.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528686; x=1786133486; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wFa7S3m8WezLxQGpXonNSJOH22EuxnSJS4gs/cpUrs=;
        b=jlAO6h9oZZehHuxHJSlV57TvTr6KWERVmUNY+MYKPN4CAZvnSJ3op6Om3qiJF1fqID
         r/1weiTMBeGK85h0qR1Ttt/weV20drFScAwrYGS108fM+/A2vMjqKEauv/eZ2bPvC5oV
         IRekuJiTbBNUxQUrkYXOv3rb06XRTcmlK1kLRCSPCim8up/W2OGhYr4kPzUhkbEDZ4UV
         a2P/+ENsJskZktfGyWHfIulHOCMc5uR76jFGaseRaoASZj88cQmENixIZ01i5xxgfQGb
         Yz89a81u/oM471Y5mUJh7COOm2OW0WvNcX2Hgkd/+s+DIxd8WQYC6XXiiYL3pm/c1Ge5
         m05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528686; x=1786133486;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wFa7S3m8WezLxQGpXonNSJOH22EuxnSJS4gs/cpUrs=;
        b=ZJl4nERLJRf8Qo8RIln8ZEUD4Du7fgzBHeUAyWhp/UdH8Tlk6C42aVRtTXuv7rrBPq
         LqxsVyty81hjyfG/pGhPufLFMwLb6LMJ+GxBLthD6AJT8pvXvrkv02bLs5QDR6srNmsB
         BceRPSQWz/2DiJ0KLONvHNKcQM3ohpI2fheoLiqJQiimItvgZzu6QXJlUeGaX5lh6NnJ
         xwDjOaLn6val+Xpkx56SQxzDkOmvnZrL/dCBlRCuHoWaA3THISV4r1Z0D1akws+tuH9F
         DZkqjybguOKRXxlFXtukaqkDnbv3k1rsh+xUATKOrIklwUMVh+tbnzuyicN8jexY3j9Y
         +W8Q==
X-Gm-Message-State: AOJu0YxngDoME+EzqVdoXEqImpTYLB+qZxc5s4cC4abGO/JrysCbTvHS
	kWC1SS4hHnHAG6r9Gv3kWoKFeSinNJ1ht6OVlTDbuXgqOsU731mTq4oqB9l/enpf4Tg2bC7O3ts
	tWbYkjg==
X-Received: from plho2.prod.google.com ([2002:a17:903:23c2:b0:2ca:d6eb:2a36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c9:b0:2cb:14b3:4cfe
 with SMTP id d9443c01a7336-2d0524cd9famr10985355ad.45.1785528685680; Fri, 31
 Jul 2026 13:11:25 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:05 -0700
In-Reply-To: <20260728002236.869865-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552796788.2700486.16602460625671054053.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/mmu: Use LOCK CMPXCHG to clear Accessed bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 27 Jul 2026 17:22:34 -0700, Sean Christopherson wrote:
> Use LOCK CMPXCHG instead of LOCK AND or LOCK BTR to clear Accessed bits when
> aging SPTEs, as LOCK AND could clobber a !PRESENT SPTE.  Specificaly, as
> flagged by AI of some kind, a LOCK AND in the TDP MMU could clobber a
> FROZEN_SPTE and ultimately result in a false negative since the Accessed bit
> is included in FROZEN_SPTE.
> 
> I initially was planning on tweaking the FROZEN_SPTE value to make it ok to
> use LOCK AND on Accessed bits, but AFAICT there's no meaningful downside to
> using CMPXCHG.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in TDP MMU
      https://github.com/kvm-x86/linux/commit/3d679b7cb31f
[2/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit in the shadow MMU
      https://github.com/kvm-x86/linux/commit/fb25ee778aae

--
https://github.com/kvm-x86/linux/tree/next
