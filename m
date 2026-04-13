Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F773859D9
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068010; cv=none; b=MgWUB3obspac5X9+b5RazzTg8n9CVsxMJTmawHpw+RLn4Jv3bETah7nhx2Yq/ttb9r00SzdpD1qhrdA8Kg5dwHHdbE0OR6+6pSkNuTsu3bd4EwVCnW0zmi9Cx2I5KvOqIFXQp+yHRZtX0bDGUn+vsGUCwOQ/a1+hgUJDUr/8dkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068010; c=relaxed/simple;
	bh=MnmV1DMk2L9tKQeDgY8tuK2Gk8JpE49s/J58DXvrSzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOifsmq4CQ9UaoVDstx600qexug9+8xKvqCiYt9hqHeiAHgzSuYIshvOGoTUvNTy0/0e7fdhq8bvLjbmiTtHFRaqV+uZCArxudXaXGvXEQIR/fhaZtfg2zGnokLA42iTuNQ07dq9qSz3qvclJ0+MYh+SCZDnu0F0vkj5OsVABG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8gTdb6t; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8gTdb6t"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so39246085ad.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776068009; x=1776672809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsUeMZ7qPBBmYcExCUOUCnfkqwQbV+/xuy/YDJ0H7Pk=;
        b=N8gTdb6tJ4VF+Z8UaNLfbPaIKXjWvCckkmEUP/GFo7/iRt3g7ES36Enom8RpYiD3gi
         7k3SIXJlZYmRYMcscJ269N4cepccWgLrjacuGcWhCT8JueYP5AbBnfp2XW4EclNnX68z
         vSYezU6NmeCr1c2ocpHlYChWrwbb3X24JN//w/xUZupf3f43EMDX7LMjMPk9YugsiHa+
         eUjBorIEZy2TZ5bpcv2q0MiB2Drx9y1J6bjSXGLgAH5k+6+zCD6dpyxeyJ8EDSAkdY/1
         r03RXrchH8eSgxF55rfb9JkjX8nZ1pFw4A60WTkue3eerMSlTgFJyFJ9L9Lq0desVqRi
         GfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068009; x=1776672809;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsUeMZ7qPBBmYcExCUOUCnfkqwQbV+/xuy/YDJ0H7Pk=;
        b=r8qVuKrplvwZBHtEffdak/6fn/sH0CQ1F0C86lKBzWjavym7GBeTq3mcQ16xe3UBij
         21qIx7io0IKAMNiFkC0WypBIZ/7I8kCKM6OUT71v1W6U5WCq592YUlYvSS144AEKJ0HA
         WuYG1S7B/HQC9VOOhZrwoJQ4EIRn13xyh2CUAWjYVvXtsEvSW6SHHihKweEMnP8mMe4i
         cTZA9KdZ0lcII5D4boaVvH/Kf9z7hy9hQOT3HuUAz1ouE/Nwsg1n6GoNvtI8dHzoGaCE
         PJQAFocrq1UWQpUhgMTkRfz1nuxJ4LbsNuphLsnsrxO0hV3qCcumJbjp10Kmy4t+QXub
         g1Ug==
X-Forwarded-Encrypted: i=1; AFNElJ8fzCp8qB9bbnvBtiEblAco7dhLaAT5uNLxLpnOm86ENh6fFm24J5IM30PZfLUf2PU/YDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMz962FyRuPbCdrV2kwu2RPfI9Ir9pLGklXMZpcYOqrZ4jsZJL
	Ncuz40X2IsI+iVxYLxdREMNWkNXthEZfHwv4WX3S3XQHfwaYKyj2XFYI/Yf4MJjUcGU=
X-Gm-Gg: AeBDievVl6dJdg5BOvt/ymnWg57rxvhfxe1EOgJ5mtRvoQhDLO5Gwj4dSIC5RhEfW5c
	CX5Wx6bcG0RHLezkveU2ZaAqJSYJMMFTTB9dHyTAB/LNljTtymXIgeFb8Nkx73YIq9jFc0PCnnF
	FZlnKmVQQRVJakaDWfybTWGk3T0KEmMLyH1CI/AvL/5BC9tjorcywFH5HYGVteqfehEJUfZM4yZ
	jHsXsR7OJH7vcFi9Blxi3TY+7pkgvyyqd+j73IfWOrUH5HHX0ub57nelM2AZv52dNHJ1OSJ8nhX
	MuKXoVrJ+IGAvJFl582g57RQR54hbcGhghZvjpZBwTs1hDmDeZeQp7mrBxELSR2+43PNMr+x1CX
	kYAI3l74eaqbCQVFSKOTOBEeB7u7o6/RqeN+qAyCq9OJi62ZWtiKtQAF9DB3fzRpeK1kGWTfwt9
	QnUz+IYVZ8SQibpPcVgNt3GDmYwsdMbq+/Y6U8Cpi1POvnMdGV6rYWGgPU6yw5/NFgVuld3Yg18
	e0jTDDGAwaKaZocvWs7kgQhyT+dV/+mxvm+zmOqFNCbm86ZyDaLqew=
X-Received: by 2002:a17:903:17cb:b0:2b2:4ded:954e with SMTP id d9443c01a7336-2b2d5a2945fmr137189975ad.24.1776068008760;
        Mon, 13 Apr 2026 01:13:28 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? (bg30dj032xp6rdh0yngy.ip6.superloop.au. [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3b66esm109799715ad.75.2026.04.13.01.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 01:13:28 -0700 (PDT)
Message-ID: <e3c33193-613d-486c-81ab-addf73f75f4d@linaro.org>
Date: Mon, 13 Apr 2026 18:13:19 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/27] monitor: Merge hmp-target.c code within
 hmp-cmds.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-28-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> hmp-target.c doesn't contain any target-specific code anymore.
> Merge it within hmp-cmds.c (which is already built once).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS          |  1 -
>   monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
>   monitor/hmp-target.c | 73 --------------------------------------------
>   monitor/meson.build  |  3 --
>   4 files changed, 40 insertions(+), 77 deletions(-)
>   delete mode 100644 monitor/hmp-target.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
