Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8B239E9A
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048864; cv=none; b=H5yyxmneq6LxH1jRyNC+vdoFuYLnpUeHS+oNTPFZr+YXtxbeiCEuusoEQ+tMCHY7kL8PKhT70qoHh1JR5DcFF9tWBQ8k9gmHTNBVt6b9cerw+0qRZ6Gg5Q8Td1Ietc2YjA+2Ve+2BvkbU1JEh/koy8d8KQxi7o3U0UoEtFTxYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048864; c=relaxed/simple;
	bh=ojVHZld94yzFMVFMb2sg5hJu8/kkiqFcoUFdPjRPmM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAUQ7+g9Wkd0fW6Rdx6NzLsZtO0pVi4HMsTGeADpu/ollvNk1plkuIvLYn5a5emNFwKsrYfFlIW86GiF1IpyKzHqW1ubG2gyS4VaFlQ2GCR6E8kiqntANe0dwuPcoFC3Gm+srJM3kJzZAT71za5RqDWUl29hgAyEwiY3GU+RRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jzh9MZf7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jzh9MZf7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2507152a91.2
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 19:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776048862; x=1776653662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRZzF1molMiU0mAe7mBsbNpM+GuMrYExyMffQk1r0Q4=;
        b=Jzh9MZf7N7o3dmnzRTjgBLsUk2IaJkoXOhLTIxR8kk+Pj2lAMKLMcQt6BDXi7UOwPY
         XKTKfcGO+wh2GuG++fpIWnhVAl9urjlhzm0ukj5/HsKs8aek1fVQ2TZwa24PB5pRrjQP
         uTZB/+cTRGPpUAixHJqnmZUKj894v+xHOXDGYstZMUibPt732H63aVl4miJwrH/zx7O0
         WxooqQ56VAni1EHORF5wwvYB7p8Zt0PfpQ66XyOcqLbGCdF1tIJdIv7jLlzMMHGjOYl7
         wMiELJyYhrPTEZB9HIXLTMSvkxh3AGQG/pEsgZwHFNFLVRruoxCzclWaNL7B7G+xn0/L
         QVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048862; x=1776653662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRZzF1molMiU0mAe7mBsbNpM+GuMrYExyMffQk1r0Q4=;
        b=FNWwmbciqThUv2TU/GlyUhaJiPWpWSSnVZOYWAOckoZKRZ8DtB7JRIBXULErin4o++
         TJwtzgANkHdOUvJC4P5WYFtVz3XMFnjalLJT8ai2U1TvWBkv3sboQ4jZPpEW+kwxRdxh
         SS7v86q2hT2pYHB5BtIy0RUxjpIC2nDiHPRteZvIIP8Mvb11UeQpUb6/xAjy58017d+c
         wtAlrTPbBc3pOfuoN2OUPP/wWW3EIHjSkrzdLcI/czpDDzp+ObDzHVZuc01oeMBK5a/c
         nIyC8TCGO/ZU8HJwShX/Snh4vyv93tQtyktquzdikGFmeRL6woYrcx9A5cVnBC263Ke8
         DuOg==
X-Forwarded-Encrypted: i=1; AFNElJ+NHbXBBhyKwnOLabfShmc49Z8LcAOMM1o0zNwVexqURGOStEWHA0POzul/2IQPsLWPz4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPZsuuZoSfgsRl+NLs3i6CSWldIEtVzgaHEf8OlPWj5GGovZU
	s7oGMs2E2Tiw7/V2CAfbsAD35d34t5j1mIDP02HFAYolhCrHgkzbifE48i0RK7IaXrA=
X-Gm-Gg: AeBDievj+O9xQ0XMPvHnZQpNylfelaKhEDqTNieqR6WvCGCIXQ91dGXLh3vjFbESwLW
	Dg6pwsXweWIxfRVoUPmVk/moiwHU4NLO83lJBLqrL/t0WoLu+lwflqpHcz9An13snOYY8kWn3II
	dqAFkawg/MQ9zohm23OUjSBMEhdIDT3Pcy/5SSXkpGVKywxRPWLlZ4Qtj5XbhodZ6aGXJjB8z31
	V4N9FI4OBZcAwrNPVc34ngTTH1NtqaTalYYIlGvUiDImAqA92qGz6Bg62M8H/sUwByVBwbIuOb9
	j0jz7cN2g36wUU4CHjWategViWpjR/jX6KQoz0cVYI354lPybBJLDt3bXGF18H8cqBTdrqZSkaY
	6/F+et74E7bOGaKdNTB1kFCdn2uhrOoI6MUmxHocarOITfHJmcn4L7t/0/67IZfnmcLgG/mz8WC
	iwV9DUP/RomU+rOvUHLbla+thzHuQ6IB5HP6itLzRoZ2BUhy8U4xkLiXOO4efRKcIx0372GeUAI
	k5T4xXpvqrEfB2PMd4elrYED1upCc9x4R4g7q/+l8mgjEZsgGK+bUs=
X-Received: by 2002:a17:90a:d610:b0:35b:929f:7e95 with SMTP id 98e67ed59e1d1-35e42769f6bmr11324920a91.4.1776048861574;
        Sun, 12 Apr 2026 19:54:21 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? (bg30dj032xp6rdh0yngy.ip6.superloop.au. [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4133695bsm13543325a91.13.2026.04.12.19.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 19:54:21 -0700 (PDT)
Message-ID: <23fa80fc-52e7-4a56-984e-1b87e80969ac@linaro.org>
Date: Mon, 13 Apr 2026 12:54:08 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] monitor: Remove target_long use in
 get_monitor_def()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Truncate manually, removing the need of target-specific
> code in get_monitor_def().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   monitor/hmp-target.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 812714ada01..b9b79e8e927 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -93,7 +93,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>   
>       ret = target_get_monitor_def(cs, name, &tmp);
>       if (!ret) {
> -        *pval = (target_long) tmp;
> +        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
>       }

Likewise force the target to deal with int64_t.
There is only one user: riscv.


r~
