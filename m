Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E540DFD5
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048138; cv=none; b=YfewKctp1vQajF5Be2swXL6VnthHh7AbkY6K74k9q+jzMQhSg6yuRcBg9QfyeBXyVQICxkK948zZt2AZTLoV/5bX/imq/Awh9WKD39JZCggAKIlofW9/GHGhYIxFgNrPZn5AN1bZVXhP0IlUVqNNCy8dyqAWaR7j0zFOc8G92kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048138; c=relaxed/simple;
	bh=7mPeZcxTsw7BMGjK9qqcgPlEozZpHb9tCmKMYKhFP2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKTF/fdnx9f+Oa/RF43+3dzGBRgsKWBh/avzQLReyL3U56SlAgSJNUP108hw5juY4frSdhN9oRONLhyMzpwVvft6g+rDHqRdWkD9xGT9QnIEzCWenG7g/1uwlFJ9wkSvPpNnI7bt/VtzPyr9Tqxbh7bn6P9YKIMkQIwrBdOZdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omGQybX6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omGQybX6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a9296b3926so19880565ad.1
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 19:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776048137; x=1776652937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtC7wLtD2z/N/B3RGXLA8q4qYbR4arCwIYuTZlXfiw8=;
        b=omGQybX62HIJFdz8Td/lGU7sCa+qqGYLa56n/JOtuhAAKZx2TaEhSrdwxiNXEdOVUc
         KBe2flg6lzmA0tbGsFo4/DZiq5SzsbD5+w/fdrkssR2TOVVGNJ4XkkO/S6YImxRP2ZBp
         h/ni70QO02B2VGeFHGBZ4+MQGLlNWc4ymm3OgnAjQd8qKu9gGB3Fp6YvtsHiI+45holz
         lDERYA3MN2tISiEENeWi41Z67u0yDswRLlSDmOpfNOV29nanntIpUSYPoUQkSsoNygQW
         sQJIZ5RryybZXLD9mtHKfhMrL79uHvb7FtsDbjL19A0ah9rIuIHnuov6T1PQsPoR6PEg
         zu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048137; x=1776652937;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtC7wLtD2z/N/B3RGXLA8q4qYbR4arCwIYuTZlXfiw8=;
        b=YcdTjxpbIdSjG7MEPeSq68oWwRGlf3Cb0h003vpNvXfLxHFxQRQSJ9S/p6CjuSjSuU
         8ZWlTplTiAoWJsvBnI8tWbOmLicA0/50rIV6lS4GECAltxDcXr06U04ypHNSriNNayoV
         QrPeFLtoSjtCptA88LJmofr39polQwgQ+5yaKuG3FRAFPJJjorRKXN7St8s2UlLILElV
         kIeRR5GdWMpMUD5OJPzYvNTNsI/GVpqHbFm3129zW6ItBVus+rQ1F+8652UP/mV0ef5y
         V1cI+vPxDc328LdOgv1tVEfmPkW50e22LLY/vt8PQfyAAdfgsxmipzdw0Dx0zKkBEmUb
         aCFA==
X-Forwarded-Encrypted: i=1; AFNElJ/4xcRoWFoRWa0gZFB5FGwtCyQoFF/VEuFYIWM+GKARAO0xCBA7MbYlPxvaHhdA4dnprRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT54Z1Yuf9LY0Tx3JJstKLVz5q30IRT9DwLlVJJlBZdIcfO05i
	BUTuPATlV0hqe98cvCDbc6E5LpnwzNFfttSiiAnfJ6Km4GuBQeLIxa4VZJSCF2SVCwQ=
X-Gm-Gg: AeBDies4rka50+IY+KAjp4JMnVJKaqgf9fbtX57mhESqgplWdTWHtNPeKMNg/fdIXve
	J+ITRwerYZAjrVGYwnlettdvIXova6EMY186twcK1IGtbZBGqwHX2uMfYZnyMvP9hj+M2mYSfO6
	MVkhAEUvHwEt5VdsCRa01dgxHF1N/lsPi8ckDTVK8U4nFxbrJR3aP0camVfnxkGRCl2tTLWMeRE
	e8mEL3mJ3xmw/cPw7/Qb7APlXigeyHQZ7ghyEkwWlwzV7iXVMSmmMvR3mkB9yqbb1rZOy1UGgkH
	X4SpIUwu3giFOk2K+XsYeA5CG9MLKK9/6QLd0+alyn77aHDOMj9KF5+dVlv42He5SirnebUFfB9
	9Ec1o0wL9ddrgQ/o7hE0if6ZCPsiYTq3PyNeMdui5/48MievIXeOThihO+Ku3T4oa0NkILV0HFW
	JCmAv9KREQ2MMWX/tim9t0PvC9+p34phYC5WWVoOeySrTWJd7Lia/mr+Ls7mNipl6CG1XjCuLKi
	XIcCYC/9eQsnw==
X-Received: by 2002:a17:903:2c07:b0:2b2:4fc1:f657 with SMTP id d9443c01a7336-2b2d5941193mr110907025ad.6.1776048136836;
        Sun, 12 Apr 2026 19:42:16 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45f192203sm13209245ad.23.2026.04.12.19.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 19:42:16 -0700 (PDT)
Message-ID: <9d6a644b-5aaf-4ecc-b529-85f8884ad548@linaro.org>
Date: Mon, 13 Apr 2026 12:42:06 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/27] monitor: Have MonitorDef::get_value() always
 return int64_t type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> Simplify MonitorDef::get_value() handler by having it always
> return a int64_t type. Truncate to 32-bit in the single caller.
> 
> Note, this handler is only implemented once for the x86 targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/monitor/hmp-target.h | 6 +-----
>   monitor/hmp-target.c         | 4 +++-
>   target/i386/monitor.c        | 4 ++--
>   3 files changed, 6 insertions(+), 8 deletions(-)

Given there's only one use, we could just define that the hook itself extends.

> +static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +                              int offset)
>   {
>       CPUArchState *env = mon_get_cpu_env(mon);
>       return env->eip + env->segs[R_CS].base;

     ret = env->eip + env->segs[R_CS].base;
     if (!(env->hflags & HF_CS64_MASK)) {
         ret = (int32_t)ret;
     }

The test will always be true for i386, but will also apply when the cpu is in 32-bit or 
16-bit mode.


r~
