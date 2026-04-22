Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9531E89C
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876888; cv=none; b=E0e6xZjZcfPxT5nKp1tLrkaQYgEKPW2VZo83YiNhs6dzJL4J3KlJ9ofFfXhYLMY2A/IxFQXPaxvP28bI/2fnYEExXBowy8HGVOanesYqcrE1q3/aH0KLi5JUnfzemxoxTOsQSy9qHYlbru4AHp623yrQYkVWI5ZdywyVG6PIsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876888; c=relaxed/simple;
	bh=vUrzsF+mMOgvPJU8kpqyUoYiDwVTVATIxi3hfooiRvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYXzCVOhXF0Bqp9UxgMigF3r63jZDAJli+bsdVcOQZ1yomCU3lLdM9UAdutiG7Um3Bqhd/B5pp3eKvJrM1IaVpY2RcJ/yCVax6ZGFZd+qxELxkNDEQhVzo1Te2yLEWASO0HRRR77TWU2Zrjznvy7HZ6MGVGOvoiVPjfuuVqujgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQUpt+qb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQUpt+qb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488d2079582so67085715e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776876885; x=1777481685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyX6iB+ghmF0Liu8wzTVBQQmwfbY34crzFr77oC5wv0=;
        b=KQUpt+qbdsgPV+waVkPF6metFFDYy+F0XxdgkW1JvqaiGjCu/vcxGfBu83odj+ROpI
         fRNsOzOQTk9QouJr9D0cCasD5AfjeVu9XV7j8yZLQ0zZXFw3K01QdbsaTUxkODy+JcVX
         IWWutwSRh+5NqqlvPE5XBtYJ+i/YZPNgmoW5T6HcDVnWmYF/fCxMIJ5clv4zLKSOSTtZ
         Dqt7bc2xEQxKYJn3ljClhVVKr1vxW4n91FCIJezy3Y/IBWiCd9crMpv1nOrj3j4xArTM
         FucaxMDqvEwfxTSabwVV2pkySwgl4dzC1nUTtv/a5+yNGcPUYiTh0yout09BfFhjPBuz
         tUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876885; x=1777481685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyX6iB+ghmF0Liu8wzTVBQQmwfbY34crzFr77oC5wv0=;
        b=CsoG+DHQjayv8ZhMyn+h0KDHvlydJvk6YQVQq8zvESh2LpbtIRHlAAOYZGLdwklvuy
         Ypd7sCFv8WxS9NvZfF8Im7YQWzruCD2W3X8oknFJ4giB5apB+tW52oNMYdXADf2hnYA+
         3H2QuOGZ+iWlsmpmi/EpLieCX18dmJDedrn8P+F9EPn3dKyja2IOfFc3EnSFJAkQhBpZ
         f0+aVJIyN9FHGwPSr+/RHR/YWRrfYIgwlfYG04uoQNy/tBw7GXzuzvPtGehIkZ5eJSx4
         uHJFiHthhPSueti/r9wdW82I6exmXcr8lH3AgJX/7Oz2pyVM9z7BSiiC2VI/NpuFXz3Z
         buTA==
X-Forwarded-Encrypted: i=1; AFNElJ83t7FjPauXIql1ta6Qxm0hOA5wlpG/K8rYgfE8PhNTmUDWDXPb0McVk6PjZz5iH1ZG3EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqquSFp4lfZQG6SF+4y8VtfgUAFjR9ipDL74dJnyfEqC2KYg8G
	ZKbIq4uMbhZw7duumg8eArXlkcCHlug5UloCXPcQdsW4eMWpELoFIs7NEPZLpXlWF6Q=
X-Gm-Gg: AeBDiet3efkSqGYlzIOk5sO7PVXi8iAEOXcjGF/+sy+j7SwWdT5/2gaTBQuinPUM3cn
	y94M/x8Ypmz393io+SefAWgqWaJqt/zWD1HsOljLCQc7JvGrfphsmZ74xP6Wr/2LiGV04HJCRl+
	M4RfWwAyKP2M2Hl3WY7mtdHxMHeE0gnSbcK8YDSIc9Fehhip99U0ZSTDo6mlz9gj2gJRq31dJAM
	8S+efHridG2rKitGrEPAIOa+BtjBTikNAQa4yX6uHRfCOOU88R+ZKmFrpvRAlUd2DCapBhzC/9n
	WpoSdRPSUrQVN2h6HzA9Osamw3w5DpbJQ9SkDkhTz3Jj4cgA7ygSWWSQ8EHn3z52o/jAKwQ9Jje
	7Dwx21HqehTjB1MCu72+8LdaO6tZY8OWRvEG6CwyOOyf4FFJxZuvs9hJsPZfKy+PCO5+PckYd8H
	Hjo0DAOyVIybhxMyV87XAIexF8ciGFXbkPa2wKSvzJ/DE5G4eD8y7VB/HbJmb1wuxlVP+Byf2Zr
	tP7
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-488fb7787d7mr309014715e9.15.1776876885245;
        Wed, 22 Apr 2026 09:54:45 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891941e05bsm90327535e9.36.2026.04.22.09.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:54:44 -0700 (PDT)
Message-ID: <080d3c06-a90a-421e-8254-0b834c146784@linaro.org>
Date: Wed, 22 Apr 2026 18:54:43 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/32] target/arm: make hvf use syndrome helpers for
 decode
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422125250.1303100-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/4/26 14:52, Alex Bennée wrote:
> Rather than open coding a bunch of shifts and masks we can use the
> syndrome definitions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

