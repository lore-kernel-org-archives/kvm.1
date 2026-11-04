Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833367;
	b=NBuZd6K4I05DY2pj14vzDDz7GNDVJOrAUz7Qa7rEYUYtlp0JIGYONEGuKK0OyNJB3llk
	 DLNBjk2Izot8X2WNiES8ZOv+aPcr53Ph8bc4bRz3zccBZb/eU4lmkBFoY7d8ReYytYMv1
	 PRj9fXeQ6XC+PnKxDjE4ZzL7Tf08aSpPaWFsy3DMc8n/Kz13gmvEw/0d/CJh8kzqB7kHp
	 IPAazGH582Df3f5+GSPIvRQa0Fhp1C28ExnKUBWnPPwmj5kt8lDRx2B41TMDh+ITMPJXj
	 ESafvdQfbG/cNHAxkwbcaJsfmbRLagOpvLxI5IGGhNipK/yQ7oRInYPoaytHGs2bhfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vyyO2xQK9gWshEcz/n+cFiGR1SxpAHdL0Hq3aJ/xFWg=;
	b=MD0HkGE93AkNzGILQe3sUfiViGjHDGFMyZ/ip75cIPkx6QsOJ8CgJv8XoJuHxQ7dpa6C
	 vJ1tROcGtzQ44kmlBQhYyyLhbClIHxTOYs11/+IhpJTTtCRKnV2vRg7emUpmArSGhaX42
	 +2YIzg7nUNCwPSbLU8AQbMI2mjFdiY0WYV6VNUKWQSGFj1RoK/vgBC/OcXPmr5R4ODIbB
	 +r0HuR1S7JyptClNYALEF1KyjAzfkndWkbk0WoAqES+h67Zgwg/nU8RAuTUSDL8rkIurI
	 omlycDGWG+mQ4Tq4ivVDQBctzB6J9p0+HpeOxdy+sJnx7i2wGoSdHaF249J+ae36JOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a+oxHKEw;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DC606EE91
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 23:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 713DC606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a+oxHKEw
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd65285537aso552477a12.1
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 15:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793833367; x=1794438167; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyyO2xQK9gWshEcz/n+cFiGR1SxpAHdL0Hq3aJ/xFWg=;
        b=a+oxHKEwZrv75w7v6JN7rcgSeAAqtvc/PA3NHJk5l4FuvuHozMILWxVrbPVO0yGA3z
         02X/mNkPlyA8ROX2R7TQVPWKEex0wDVf3FXiYuCTRpilW0u5yEn4TTqGu2dPfc0KEPlf
         E32NzKWvcCbPmM8257xAoMbI+yU38XpkYECmBly//I2zDPCVMuQqwS0MZx1qC+j9Lgjj
         iZL5xQq+qqDSELZ83j2o9SPHAy2NaSYa3uKUljAkiPgfCl9LLPmZqQfgsYRkaSKQC8Iw
         YZJuXnFHnsN9HVvazcBdkSOjNuSKWWQjCqvLl6eNkOeUhPPiFGUFtAaaNpTer8eTJb2v
         HBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833367; x=1794438167;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vyyO2xQK9gWshEcz/n+cFiGR1SxpAHdL0Hq3aJ/xFWg=;
        b=XTgOP0PEhS+Wv+Ygo0lz3cwKogQ2bUvcGvhQ8M3n/nEdKGAiWlSpLZNYKkms10NJTQ
         0oCTNQysdmqbNQ1TdWkj/FRwJs2bytgu+B/ak8zFh+Gqb6aJSyffYaRNIiRmqWXBmeMw
         uct7zagPVGeZWP05E3MUUqqqRKuz+Nruz5Qlg/7RnMoB1ipi7BHEZExzI+CYbNaxZDFN
         7wBW06QQq+2WTOalu70kJKz2p/C6AuyQW2OeAtQsFiHM60KyI2NAtbXq4KA7l6wayKbb
         laXmxvhC8QMYdp6eWfrb10HEv2b/LWCSYBaGdtk5PwO1qHs464gBNpa9Oef4zrTZAaif
         ra+Q==
X-Forwarded-Encrypted: i=1; AKwUvBx3gqvQT1ht5VBYxSchFb/ZSL/fgddajFTz9+a6+2t7sPEzLxzQIMg9ncXzs7+ZudaKTwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JsIxsAeNMBr+RFG2jZe+6hT1AXpLd2t9L2HAwuaYWm57f4HyL
	WUgAxObZS52znNBBy6bGZGs4bz/aHIZdxIUxhxfgHPTQKtynUvAQm7UMnPz9GnocjKkz1bXkL0I
	/1bV0Fw==
X-Received: from pjbqi10.prod.google.com ([2002:a17:90b:274a:b0:3b0:9569:4e9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:5d17:b0:3ae:898e:a123
 with SMTP id 98e67ed59e1d1-3ae898ea1b4mr10835418a91.14.1793833366550; Wed, 04
 Nov 2026 15:02:46 -0800 (PST)
Date: Wed, 4 Nov 2026 15:02:45 -0800
In-Reply-To: <20261104193635.333141-1-sashal@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104193635.333141-1-sashal@kernel.org>
Message-ID: <auu5lcHexLy6pBe-@google.com>
Subject: Re: [PATCH] KVM: selftests: add empty install and run_tests targets
 for unsupported ARCHs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 04, 2026, Sasha Levin wrote:
> Commit 43fbd8cd389f ("KVM: selftests: Provide empty 'all' and 'clean'
> targets for unsupported ARCHs") gave the KVM selftests empty all and
> clean targets on architectures without KVM selftests, such as 32-bit
> arm and i386. The selftests Makefile also runs install and run_tests
> in each suite, and those still fail there:
> 
>   make[1]: *** No rule to make target 'install'.  Stop.
> 
> Add empty install and run_tests targets as well.
> 
> Fixes: 43fbd8cd389f ("KVM: selftests: Provide empty 'all' and 'clean' targets for unsupported ARCHs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Deuling AIs?  The other patch seems like a superset.

https://lore.kernel.org/all/20261014200152.1365147-1-sashal@kernel.org

> Found with KernelCI-style TuxMake builds that record per-suite results
> with KSFT_BUILD_REPORT. 32-bit arm builds now succeed without installing
> anything.
> 
>  tools/testing/selftests/kvm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 03d91f00092f4..3881df8d5b2b8 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -13,4 +13,6 @@ else
>  # Empty targets for unsupported architectures
>  all:
>  clean:
> +install:
> +run_tests:
>  endif
> -- 
> 2.53.0
> 
> 
