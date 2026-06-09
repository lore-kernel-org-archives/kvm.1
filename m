Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549F4014A5
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022737; cv=none; b=SANby4kpVZ7GD8oWJg5kKhMP4IYU7Ms6/YujUJ0DHKS4KY+E2ngojVTFH8GlZcYddd7gVoJ17Mep1qG5yl+X9brjjbs4NLIozu34ct3o6pWzruoDfd36J4I+XTBE90/Tkq1DhkoGywh3o9ERt5iZv8dTmX9zaY5Mrdnno4cSx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022737; c=relaxed/simple;
	bh=HqsnJspr7MhgNDd2ek5sLqT76kHH0O2IhKHvVFMRljU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dp5lGJ1qwwly9n/aaJvHchfmRT8vfeLvHpb0fpMAhJ0b8oiad9t82ixNHzJCerIFOUJo+83HbhV04jdln1nnDtq5wsd9ZsLoa/nFDyYzhJLKk8ixD9jIyu+fpdIbXcZfO/kybdJiGqzAOnSDsyV/oTleAJvcfNYr1JA5XCxPklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFkHuqnj; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFkHuqnj"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8428384f31fso4028877b3a.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022735; x=1781627535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FG5pJEohh/4/UCYhvOwxtO50+NFSevWqQQ6O2IHonrY=;
        b=lFkHuqnjQVDNN3ghAFOU6GMnv+4a10kzBhQg/hx8Rm/9Wb3GrjQc92hNOhNk7v+vk2
         1kB0HmNMMi0NUjAQqbUDIoHrowApTLYAjIfcG2pGKHXP2fKUVD3CFZFbpZi+pt9qnlxH
         6Rf41M8xJH0dg9Cze6Bx52rcloeuHEMehPmhdLdtjP8R2p7mSVlQZZRKfi16gRStt/gK
         J6udmLnAqnVEijoaVNeCrgJIebaBIfb10mmKzkiXb2kiK+uwvge4m3pXrxk39LaShAKz
         mU7qc2wZUuNgLMXI97UYfd0jnqj+120HllJVvEVkwzOOwMflWhaW+7B0c1cnQRb3Y5Hk
         Q8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022735; x=1781627535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG5pJEohh/4/UCYhvOwxtO50+NFSevWqQQ6O2IHonrY=;
        b=Ahb9DtJpIg2AfiAOdzSnHE/D0mmMq8ozyLObecbEcr4RIl2hhF2AwvHyzf6PccSO24
         XKii+3aiavrK1oe85O7a0ItqvJcdpafMi+kJ5RZ8bVLCFMrfDqe4KIfEzcKMjV/rbgpK
         qjhYxs9A6uGl0Rv/b7sMyzGagtIcahsXjALuOZLIAdhxg9PAJLEZaOonXd4HJwyVo9S4
         hPKEzzPHoTJdTmvHpiyipv4AJfT4rTtZg35zH8/NRn59GamOErq1hCxvxA+oN40h+BBn
         bj7ZvmgXRmBux4nUYDMqt2CZR/2biC3O7fIRragG3pY6MyHINji/BCm+9F6QiMb2Y9pW
         4PcQ==
X-Gm-Message-State: AOJu0YxnA+vXeo4xcmCIM+2LsOoFTF1snA5WjI5kMsseiuP+vCbh5jcA
	Zf/sSqlmEUJl4acgaigUMZaba+gXPVkhhshyrIOtIE3tBIzuqAS+fSMwwbqK0KpgllsxgId14hV
	YBFt+sw==
X-Received: from pfbhw2.prod.google.com ([2002:a05:6a00:8902:b0:842:2121:d449])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2441:b0:842:57e8:1bdc
 with SMTP id d2e1a72fcca58-842b0e718b4mr20496704b3a.18.1781022734945; Tue, 09
 Jun 2026 09:32:14 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:35 -0700
In-Reply-To: <20260603231905.1738487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260603231905.1738487-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102228669.2735194.1924923807763838083.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86/pmu: Fix a fixed PMC event filter bypass bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 03 Jun 2026 16:19:03 -0700, Sean Christopherson wrote:
> Fix a bug reported by Sashiko, where KVM will effectively ignore PMU event
> filters for fixed counters if FIXED_CTR_CTRL is changing, but enable bits
> for denied counters are NOT changing.
> 
> Sean Christopherson (2):
>   KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_CTRL
>     changes
>   KVM: selftests: Add regression test for mediated PMU fixed counter
>     filter bug
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_CTRL changes
      https://github.com/kvm-x86/linux/commit/9c6e2463c9f3
[2/2] KVM: selftests: Add regression test for mediated PMU fixed counter filter bug
      https://github.com/kvm-x86/linux/commit/2c725bd2802f

--
https://github.com/kvm-x86/linux/tree/next
