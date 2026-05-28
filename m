Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16522352023
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985438; cv=none; b=Edh+rB8LNdtZ1ZZVbQA/jmOZ8l54FSll65uFlZHJ+vNknAM7uz++JU0YTYT7eTzQbRKzYNcDNv/4WyiMdyFO5ofN3ADT3yGCj5mLAs5ocL4UPfKCb0IIqUijF3CEIvM7O2Dcn0nask6ByW+mZiCwj0ab7r62OML21cRjVflrz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985438; c=relaxed/simple;
	bh=Znz3SafD6WY/1QXyKAELH6Hj2CI/qjVkZBKD0Cb2krQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtU7r1nirN2o+UwZcC8GT0vRyppy0kDJbPIkhcN9DiF6OUHGVpDJnpJWGfKThYcbjOrDHIMCUTtXQs9TgjTW/TU4riwuAv/jfHq3g2qJ7low5635T9gqKcnoPWAvPp2XrOQjkXG0og3MNUzyWLjX6ecWzJJqM4UgucP+w5D7H2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nxNlQIgb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxNlQIgb"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so510497a91.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779985436; x=1780590236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CmlDw32A5+2Pto4vqUfWR06vY0nitO5ujz+6xcc8/0=;
        b=nxNlQIgbVu39BHMHQfGUedM+aznQy2yGnWfhLSD5lT2wFz/xw2mmAyMo9qRfGJyo0K
         B+58hTzR2UPJem00qLY8jW5aFCcF3tZcJrlQdNWD+iVblvvQciL1r8lUJZdDl5IL0/EB
         7UFW4lXwdQjyg+VOC3tJAX4ATrdd+VPUR4uA6JHkilzY+V+PpbOHsex/UZy6qympdLmh
         vq11Soix6BvMDJ85CFsbqntf8FAqEcrTBm98zhB7QoUspHTHeh+Za+FBhv5aeZfkHl3o
         YVRUhAEhhs7eR0TST8t5+O0XQvQ6PdZ2iUH7QlfSIg314ZVhNdcv4tR6n2Pq3Wt+Uo+b
         Mu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985436; x=1780590236;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CmlDw32A5+2Pto4vqUfWR06vY0nitO5ujz+6xcc8/0=;
        b=rsRdEgJCQ9iDVq+VuyEAn+zYxjJYL6hXrqh5PJo0jLM5zM/QBAUqeuK4zgAwXkq5I1
         MSjn2MukFdrNBybnzKGbif4LzuHmOuUyLJiQncJMWk7C31cSPAiWgrS+QRMYogDV84Md
         pTC7Cn3toplLHVjedEQH67qRbflzfTBMMY9xlPnCE3DRLCvQj3n046qiX/gpAn/3iSAB
         YP4KWJ46BjmDeELpufTGunHxEbXmTJS6XdA99WGjKVuJ+mlY0y/WwyEpZTdKgfMrf4VF
         pXLg1kd5V4FnHf8GJX71bI+COqKSqWIgteSfjyU8ocMKNrg7To7fTxm3+iz2owOvwNF5
         pg3A==
X-Forwarded-Encrypted: i=1; AFNElJ864+LLQrg7p80WX7pssEzGX/lAkJ3usItmVs6uGZLRi/UcnG5DSJIbNWU6RkWAaZ7gFkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbELoA1oeSZSTy9fO/4PLV+w4ZWtzMUEr7PHftwmyEMb6ofu9b
	iH3CGSLMVZFX71BK1wT+w4Gs1huMdA17uDVVRI3hCIdsPm9IA6RriOCYGkSYWrQ27SNbwZjMjIl
	epzechao=
X-Gm-Gg: Acq92OHc4GUYLnmSnBpT6YgzujXSra0UjJHoObFefqPh0rYzJ/SEuobS5/msXTrhntK
	/MdSWrjuozsKDhOM6VPXyIW5hJQS+/32S1EXw+bJiLpjLU6S+HoKqjJjiM/5/4L+l0DYN6EXva0
	YwjYlV/QPkpuR09pEdl8wTUxjtqiqsus+qKz4AJ8rxSUd3pAppJ57VTwNBv2Jsg1TpJHJ5YgZJr
	tdNDNjtOdQKZifSXrqVSNO5B8FW4Tanx8SC6wP1cFhuwwRURxsjPSN507DMJJCumEqBN01fOie+
	twh4CIDWG3/T4D/e0FIbOf7LrLEotuWrF18zvv5rCWkQfY2LXitqaBCE5g0kmeDg/QI1UIzm+hf
	EQv5ESpyKU1sJeAuDVu832i2dA2Nlaa2mvyC5pqk8uhPVqnM3Leqqpd//itnFpAWlrNa/jlfnNZ
	An92AOuHWheES9IH9jXCLN3xsvhXTVb300HoFaUnfQBhdTCNk=
X-Received: by 2002:a17:90a:f945:b0:369:9469:aeba with SMTP id 98e67ed59e1d1-36b9c6dcb75mr1635663a91.1.1779985436226;
        Thu, 28 May 2026 09:23:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90be1699sm2444666a91.12.2026.05.28.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 09:23:55 -0700 (PDT)
Message-ID: <376b8bc3-d377-4363-8a83-866a0c05c708@linaro.org>
Date: Thu, 28 May 2026 09:23:54 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v2] arm: add wfx test case
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@linux.dev>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, "open list:ARM"
 <kvmarm@lists.linux.dev>,
 "open list:Default mailing list" <kvm@vger.kernel.org>
References: <20260527111822.1563679-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260527111822.1563679-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/27/26 04:18, Alex Bennée wrote:
> This is based on a similar test case I wrote for QEMU's tcg tests although
> obviously able to take advantage of kvm-unit-tests additional plumbing for
> dealing with the GIC and IRQs.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - drop TIMEOUT in favour of computed 10ms timeout
>    - add comments for each test
>    - use sevl for local clearing
>    - set gic irc depending on CurrentEL
>    - EOI the GIC
>    - display elapsed ns (no float to do ms ;-)
>    - fix some style issues
>    - make test TCG only
> ---
>   arm/Makefile.arm64        |   1 +
>   lib/arm64/asm/processor.h |   7 ++
>   lib/arm64/asm/sysreg.h    |   3 +
>   arm/wfx.c                 | 187 ++++++++++++++++++++++++++++++++++++++
>   arm/unittests.cfg         |   7 ++
>   5 files changed, 205 insertions(+)
>   create mode 100644 arm/wfx.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
