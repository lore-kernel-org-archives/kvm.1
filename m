Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D33C502
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877073; cv=none; b=lRVyqckIxRFkactOwcZPRvBCJfDq4PldSTGZQqaVrwguX2OssMuygb5k+GNzCr7Ml5+Af694v+fmjmV3v8QdlLzGndvjNvO5WLSKFqUsYLtyku7NJQuc6hNJnGfo6+FxOnx3JgAuPzYp+0mFdBGtNTgUCxwVIJKLlNyE/qgYEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877073; c=relaxed/simple;
	bh=9hZvi2+L0oPcPV7DQ9cBNe9ZAeWP2seFBttrtNZthps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1m/AocCi+zUVMAL2aYM6zqGkM3O9XuFfkrMykoJG6BEibGEbuxieRUKhy3PUjhWhzErT8rTEYmLce1Nfmzrgx1r9H8FAP1HfHgNAIasfA1V2hC0zKuwkYC6N2+Movx16BmBf713VtNcL+UZk8tPR7rY20SkCgZTEVYPWYaCR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKB1/ynZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKB1/ynZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d75312379so4241590f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776877071; x=1777481871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbTeMp0F6npNH4gs60DUNZm6vpG8shzFCghJCd+tOro=;
        b=iKB1/ynZv/OG1YUmXA3m7L99BedkdS1Lt2G2VpNtO3caQBGbYt14OqDj0jbb/klZ/T
         VGwDyd0DRP848sMMFXEYyWEJNPGzGNFDaXXJUb0phgK3/8ZUBvMlCV1xNo9c/s43A4SI
         55ZK21fp3sA3X5rPUiJstTSQWh64hJYfigR2ufwyS7pKJZDWgVk8GiN9/KUV1MNJZidc
         ZgX0Md8hxcBrZQB9nRoTe7S1xOQ6AiyFbfpINIq7lsKb9iKn9AxdqmCFqNoM7hC7jwD9
         5ToAv3oaAn5nK0n72FQG6/NTU7xrek0JZXT82pddFMH0yFwmGk1YmD/NEWexBc90HBwo
         +row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776877071; x=1777481871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbTeMp0F6npNH4gs60DUNZm6vpG8shzFCghJCd+tOro=;
        b=JN+GRD8fqISG5JudwuG3GnaXf1G2hDOuBZ7KCjpq4GRSXGbI7+c0zf92qU1pzvwljr
         F4l6mEMZtyrg+0lmgTQAYmFImAZF5j5SjAiX+htTWhTD9U6+1oDW4KwI4E9St7MJfJ9Y
         Zeomud0rpzTheJk8xDXKTHhoKMv3gUTGCvJV+v9+paSRlFA5K2vXNo2ZNeS9teBO1wX0
         XiPIiz70XqqYVeEDJlQaD8DnYWJVSQNM4GrUkZSav1i+rYQFYgXm5ioIbHAvmGB3R/AF
         hORT/aubZiSo23TdTb5VPzMoDjyCEG8SltlBg7no7yolTM71F9F4fibQ/8hu+MF2LSba
         GKKA==
X-Forwarded-Encrypted: i=1; AFNElJ/UPrCeK8YrrMH4nG4dvRbW0Rgp+SEBzR9ex3cu4YBlA+ICSSWD1B5B04+EptoPTDekpGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pjWemjy9rhB+MT4EyZg337ntK1lhCUyBaO7dlRHMlVZbTSbI
	rHW4tbcv7QJeovKMAyfN5SZ3Pa62ZYGOd/AYdhgdfSVOszDJOuhMuS3DpeEraJqJ3hc=
X-Gm-Gg: AeBDieuLWUyoTgHU3UJf7yw4HR9HYyEoF4voZYeumHsj11aEIvVpAEEX2W3QZUbXWwY
	1LcD80E8Tiyi1USY5q0pNkMsevdXcIFhS6qf93r2vbXYDU11sG+sVIel3i/B9qHZtBWdbO0JB+n
	/FuBwLiZX49ysREcvJ6boKCrQw9b7xfd9/yejz+/WIWTiENMeFAhgUnHejvMPjO5JcGolmuk2cS
	BSfRxpuQPXjuXPV04py+WbwLygqB80d+eqbfPnIh7WIL+zvGb+VhA/Lyh/aL82DkwwCntTmNQmb
	m/O+bCgiiKV1qRXNj4nvs6Ur+PCGdIh2ThPODKsVmJlb5IZW7vDCOrnqYVPvXOYTgbFYHJLesGa
	dqJhehbVQahwDFSzdcKFTyLIBou/qVVlcesrJDd2TThvjzVp9Aor8vO3IjrjYzw7AH9pVqtTCwA
	blbbVWoYqVswjsXvzNvO32Req3pY5TpZStxbIJwU6E9SWp6VvlwKhAWkwnZJnMletd4LoajTM+x
	q6S
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-488fb8b9deamr269580515e9.13.1776877070648;
        Wed, 22 Apr 2026 09:57:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm229925445e9.1.2026.04.22.09.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 09:57:49 -0700 (PDT)
Message-ID: <a0835cb6-50b7-4db3-b747-bf3d5a4badd9@linaro.org>
Date: Wed, 22 Apr 2026 18:57:48 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/32] target/arm: ensure aarch64 DISAS_WFE will exit
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-27-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422125250.1303100-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/4/26 14:52, Alex Bennée wrote:
> This mirrors the logic for DISAS_WFE in 32 bit world.
> 
> Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 073454b9195..d79c8ab431b 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>           case DISAS_WFE:
>               gen_a64_update_pc(dc, 4);
>               gen_helper_wfe(tcg_env);

If we mirror the logic we can also mirror the comment,
otherwise the description rationale isn't very helping:

             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
              */

> +            tcg_gen_exit_tb(NULL, 0);
>               break;
>           case DISAS_YIELD:
>               gen_a64_update_pc(dc, 4);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

