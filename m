Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD117D6
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228943; cv=none; b=XvZxw8DozXhUNvXdjV6U+8laTB/SCIInB2cJsSYolgEKCkFFImednnvUSKB+jg7+iUm7bvayC2c5ZJFpvye4t+IfNw58HNmWk1rwyASd1tdn/jSOg3ktGBamDNggPmGLlwZzHw6apDYH1suPFo4uPHKOwnE/WceazJYDxUXZnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228943; c=relaxed/simple;
	bh=RAhvSTOl7Rgl3qFdJKqERV3I+TXPZLa9gQOk6RiQs00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=teC8qQOHfRgvFpQLIdyi38nIMkbXj8YpvvdtOpaJoO6Olv8sg4YQEOicwBmbECf73vetbSC7ZPGbYOQptRrfASQOzV8XTUNU5VzLspO2Vso8T7od1zG1M5yfjSyedofXKZugssEbVVua41pIfHYaR5TYTscT7WcuMSrK/A5EllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=K+pssPox; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="K+pssPox"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so31621865e9.2
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1779228940; x=1779833740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0WoOGzG909MM0b5X+grWf4pnzS/ERqNN9ZfBXJD/DvY=;
        b=K+pssPoxl9Oo7zqI1JA50WRb9rsf9iEnRO6qBrrXqohlYOEX5UZJHZnvqu/5pZLxEg
         Hgcpkl8lxbs2cc+aNfFsI5I0bnzayyY1Lj07SHVTw4R5EPCWh727bZJlAfvONnFOlB/F
         AZnPM6hqk3YQEFUbLT0McMl3Wb4hGroaXrvRwjHsQqliX/auFrktmnY26xOeSk4xp6n+
         dRuDj4xegeXJ5wTTGCuV+vWVaEh35bVDQbVMcp7a/EKRVrW1UtTKloqIdpqON/H7kZzh
         e8fRtZXmW5zkUBTDhDQD/DhgaI6pSQo8qJwVfBRd/VuwpmR3Yu0VmxvL5YQBwEj0yFY2
         TgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779228940; x=1779833740;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WoOGzG909MM0b5X+grWf4pnzS/ERqNN9ZfBXJD/DvY=;
        b=j1FsR9IVG/E7f17psqt+XAd6iQp5UQtbpxN3EFIRQJkh27Y2W8ojN9nAs4Yo+zMhvG
         LJ78wLbdMQLahlPhBvJiT0hXYXfMnZhBpINOrnMr1jKYMoZM5PWJNPBUfXQKUWgyulb0
         OloBKqSBDtSVLGcPPNtGsPcBJp1+MBzr5yrwhqbYeTU3jX8ZyuPO1Zd2NqCDENB/TvJk
         ic0ZrXpmZl8J9dWWT7a7lT8aKa4dIo/fD3VTZziN3B+RrMLR2dzI23YKbO7IE7S0ZAzt
         m+CXXbIkHLDRkUNqidu3hFEQjB4MmMKsVSx5Xc3zbopLjcrH+4tsjMKcT0P/po0YtWY0
         R+IQ==
X-Gm-Message-State: AOJu0Yw8/xQbY5gBzkv7fdjHbwpYAkTjyIASVvhxLWQPZRSqpzYQ+Imh
	IJmu2+PhnfGDW6jPzIOJ131zCSnd3A5hDbtjbgO2kEHw3f/3mq7Bjqs69mNgyyHpBFo=
X-Gm-Gg: Acq92OFB7JkSfxmRbDJ79SeCeOLR0T5Cj+7iKcP/6iWilKmIewFavRayOMGaqBl+Brn
	BYmM9lUclcKELfhX5TndWtTINJ2VuCrrMAIiobzPEOroHnfA6qxmUIDyru5LKgu2yxjY+SEnhRO
	2v3SWuJ/JjkHZput/Q9twIK2Hu6m7Eud3D/3zYbVnqwBzxgoUAayD7Ti5lgUI1vq5S0OU2A9pn8
	QSHsByljF+Wqq53xzzrInleugHf3sUs1+QwHwTTio181vVuGECq22lPu3Xec5k4dfgZNgTvm9M4
	5eRY9gAilDcbRTO13eKwxmVNhQb63hUKgyVtVQzy4NephDZty6QwjnqQqeK1ivt9nj7p6riKdiO
	cWWbXFEdurZ75zxc8m+kfVCXeCIUkVV6Fc8fwPrU9C/fhzmoxVJ648HUoOSLFhxZ0Sn+yWomKON
	tXB8ULM20xbqRV034e0uxapfmC7QEbECr2DgoDtzyUqHnWUrVV9ESEiTdEecn3a1RW0ODDAUNbD
	PdnZd/Dgk7eSJCXexJAAjA8v52WBMZKiRnhGIeIsQP7vAZQFLlnAbnz
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr321820775e9.5.1779228939732;
        Tue, 19 May 2026 15:15:39 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc? (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de. [2003:fa:af26:200:51a:ef03:a698:a1fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm50230700f8f.32.2026.05.19.15.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 15:15:39 -0700 (PDT)
Message-ID: <280ea8fe-a0b6-40de-b183-d83486d81795@grsecurity.net>
Date: Wed, 20 May 2026 00:15:38 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/20] x86: Better backtraces for leaf
 functions
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jones <andrew.jones@linux.dev>
References: <20260514210500.1626871-1-seanjc@google.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.26 23:04, Sean Christopherson wrote:
> Finally re-posting Mathias' work to provide better backtraces on x86, which
> was blocked by a fatal bug in the nVMX SIPI test that was exposed by the
> stack frame side effects.  This has been sitting on my local system(s) for
> something like 5 months, and I all but forgot I hadn't posted it.

I guess you just wanted to wait for the gcc-16 release ;)

I skimmed over the series and commented on a few things, but beside that:

Tested-by: Mathias Krause <minipli@grsecurity.net>

> 
> Most of this series is cleaning up the nVMX and nSVM to play nice with
> multi-CPU tests.  Then to fix the race in the problematic SIPI, abuse the
> VM-Entry MSR load list to atomically detect VM-Enter (I'm still proud of
> that hack).

I see you had quite some fun with this series, e.g. the stack alignment
or the numerous shared globals. Also the struct-member offset passing to
inline asm is kinda neat.

Thanks a lot again for getting this fixed up properly!

Thanks,
Mathias

> 
> For gory details:
> 
> https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net
> 
> Mathias Krause (3):
>   x86/vmx: Initialize test stage in SIPI test *before* launching AP
>     thread
>   x86: Better backtraces for leaf functions
>   x86: Prevent realmode test code instrumentation with nop-mcount
> 
> Sean Christopherson (17):
>   x86/vmx: Drop unused SYSENTER "support" in nested VMX infrastructure
>   x86/vmx: Drop unused guest_regs "support" in nested VMX infrastructure
>   x86/svm: Sort (and swap) GPRs by their index, not alphabetically
>   x86: Dedup guest/host context switch of registers across SVM and VMX
>   x86/virt: Use macro shenanigans to get reg offsets when swapping
>     guest/host regs
>   x86/virt: Track "guest regs" using per-CPU variable
>   x86/svm: Don't VMLOAD/VMSAVE "guest" state around VMRUN
>   x86/vmx: Use separate VMCSes for BSP vs. AP in INIT test
>   x86/vmx: Swap GPRs after checking "launched" status
>   x86/vmx: Track VMCS "launched" state per-CPU
>   x86/vmx: Track "is this CPU in guest mode" per-CPU
>   x86/vmx: Communicate hypercalls via RAX, not a global field
>   x86/kvmclock: Replace spaces with tabs
>   x86/kvmclock: Skip kvmclock test when not running on KVM with
>     CLOCKSOURCE2
>   x86/vmx: Tag "struct vmx_msr_entry" as needing to be 16-byte aligned
>   x86/smp: Align the stack to a 16-byte boundary when invoking SMP
>     function calls
>   x86/vmx: Write to KVM's WALL_CLOCK MSR via VM-Entry load list sync in
>     SIPI test
> 
>  lib/x86/processor.h |  15 +++
>  lib/x86/smp.c       |  21 ++++-
>  lib/x86/smp.h       |  32 +++++++
>  lib/x86/virt.h      |  61 ++++++++++++
>  x86/Makefile.common |  14 +++
>  x86/kvmclock.c      |  42 ++++-----
>  x86/kvmclock.h      |   2 +
>  x86/kvmclock_test.c | 225 +++++++++++++++++++++++---------------------
>  x86/realmode.c      |   3 +
>  x86/svm.c           |  19 ++--
>  x86/svm.h           |  61 ++----------
>  x86/svm_tests.c     |   5 +-
>  x86/vmx.c           | 121 +++++++++++-------------
>  x86/vmx.h           |  72 +-------------
>  x86/vmx_tests.c     | 134 ++++++++++++++++----------
>  15 files changed, 443 insertions(+), 384 deletions(-)
>  create mode 100644 lib/x86/virt.h
> 
> 
> base-commit: 4d60e2429d63dc0c24990114a8afc89e86c187cc

