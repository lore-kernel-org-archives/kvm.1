Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA32C324D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375370; cv=none; b=nM1Zp3QIomFcVkDFnwYbxZqvOzDVPiDJtzE0V6J6/4NvkVxMVfNGaJTPlbOS2R9zXlPnr89EP0qlppwoCDGiya4tqtoVOZnCAD2qtT5kv4UlODBdpv2JywekFfBsTsiqt8wou7dgzCexU5mcIrho93k2/6joEsPQtE74+azIndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375370; c=relaxed/simple;
	bh=R7ZX0LE7XGFFQWMOtrASqhk0culrI4MvTKiFsqDKfPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DItylZvgd9NdEr26H+PogHnKMnHPYYbjyuP3Lxy6bMUMMVj2oxXe99aIA8gPlcADdWcwqeO4qlinVwDHomIcsl2Wk95qW4rLlrcDwBYMEPP96yP6KTfQ7E9MvKGKCiGu4rMyy0WJCAySTqQeWf3knaybkibfEKHA1ru2K6BXCr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XK4dDdnn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XK4dDdnn"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7e9b97a73so99997a34.0
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774375368; x=1774980168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1RhgEBpZwcw2mC7/SNEryH9p0tgwRBwIrIydZS7iB0=;
        b=XK4dDdnnnynFzpW4GTweZadTIkILnq2olNCeq3ZltwpBnrxPcz4eUiv4thtOCeYDns
         dm2iUwosQc7ZvN7kUPL71ZCwnXME1tJXFQ0dNa8GDHgjJlfqIkvpGRIT+DqYTFfqGitb
         TUtbdAmygKrUVurPl09sOskVIziJsyBOwebHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375368; x=1774980168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1RhgEBpZwcw2mC7/SNEryH9p0tgwRBwIrIydZS7iB0=;
        b=UwZBYDv1Y+48vD7V0woKC93IydIIBW9GV/IzBjvEF1Mp70CZdQeRj6qNZCFwe6eJSo
         YyqqsEJTYKFrzvHbL4qdn0HEJnNfsiBNDAdY/8S8geGZdCSh5gRHKvEvHXVoUbmvb0XL
         KD+CzjpZKdeaKeuGVY3HCYPlqwK/MusEtQ9xXV8gGRYKdGKqsEAhxdFjKPzxtb2l8qfC
         oWO7vNvXtgaijhhlwBaDQmTROQIFG2nUHDe02JeOy3OY1dhbmYqix95dhNGtNU7A0Rlw
         BgZunfwqUDWVzTBDHbgO7FMx+BdOALYbRv5yUOb+V50ZQwS/XQwwS8497F0+9anGw5Vq
         3J0Q==
X-Gm-Message-State: AOJu0YzCwGtrHjb092PCelzaeETByVZRlVxcMYPH4vkXo7szJKzthFqk
	2cp3BiwfaJbB/rYJGi5NEO5+tH/7hEvv0M9kFbR4BKvq4zTYq1SIzMeXgLszCsTPzNE=
X-Gm-Gg: ATEYQzyonA0sagOUHFyXoxAY6q4bRtEy/YiZigejoDJXC3oGo9m3D+9gAxvAypPSiKV
	48rBQoYux0ttnsjwbdUoa9eNY+zkgLT/7Mx+jZ1r9tre5+ZEPqMyOQ8hv970GT3vGT72+Vy2jsR
	WFIpCFTbpjE+SpZaBr5iv/474MnuFBsHVYo1HrMonFJOzlCiJcPSRkiXwAs/N8YgZuzbaleZdgH
	6kmiT3Uep9jDqvjsRMuwCtqrfR58SCgttVMlWoIF1cKMvkcja5F2YcQPQYLL4taHED0XNz6qWN/
	yXm6e5jD1ZPOymaiE/tZgDmhfAEt8NCMnZHKj7LfKmWZ/yDG9dRlF2Ev20XGKrgYyz3++8boW2T
	BesupqVyqAe7er3BuQotr+lnFtWF7Dxej3xKDsFDwrPFYU/THFPygFDGLmrr33uaMsP6OPy5LZd
	MDVu59FrWfUN2IJBIM85oEvkeZ7EWPxUizmDc0NdYeB0aRzQ==
X-Received: by 2002:a05:6820:1691:b0:67b:e7d4:84f3 with SMTP id 006d021491bc7-67dff56cdbfmr368540eaf.21.1774375367627;
        Tue, 24 Mar 2026 11:02:47 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252fe793sm8840845eaf.8.2026.03.24.11.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 11:02:46 -0700 (PDT)
Message-ID: <091f264f-21f1-464d-913a-1500643728c7@linuxfoundation.org>
Date: Tue, 24 Mar 2026 12:02:45 -0600
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Guard execinfo.h inclusion for non-glibc
 builds
To: Hisam Mehboob <hisamshar@gmail.com>, pbonzini@redhat.com,
 seanjc@google.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aqib Faruqui <aqibaf@amazon.com>,
 Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
References: <20260319000842.1213426-2-hisamshar@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260319000842.1213426-2-hisamshar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 18:08, Hisam Mehboob wrote:
> The backtrace() function and execinfo.h are GNU extensions available
> in glibc but not in non-glibc C libraries such as musl. Building KVM
> selftests with musl-gcc fails with:
> 
>    lib/assert.c:9:10: fatal error: execinfo.h: No such file or directory
> 
> Guard the inclusion of execinfo.h under #ifdef __GLIBC__, and wrap
> all backtrace() usage under the same guard with a fallback message
> for non-glibc builds indicating that stack traces are not available.
> 
> Unlike the approach of adding a weak stub for backtrace(), this
> explicitly handles the non-glibc case rather than silently providing
> an empty implementation.
> 
> Link: https://lore.kernel.org/kvm/20250829142556.72577-7-aqibaf@amazon.com/
> 
> Suggested-by: Aqib Faruqui <aqibaf@amazon.com>
> Signed-off-by: Hisam Mehboob <hisamshar@gmail.com>
> ---
>   tools/testing/selftests/kvm/lib/assert.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index b49690658c60..3442b80c37c1 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -6,7 +6,9 @@
>    */
>   #include "test_util.h"
>   
> +#ifdef __GLIBC__
>   #include <execinfo.h>
> +#endif

Is __GLIBC__ defined in musl-gcc? Looks like that is the case with the
error?

Check a couple of things first: did you run "make headers" and
do you have the correct packages installed on your system?

thanks,
-- Shuah
