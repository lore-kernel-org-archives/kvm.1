Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692B37D13E
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053366; cv=none; b=jmTHn5FE0DXv1EhMAnhK94/fm6p3D5rt4YA7+85HTdTqGXbh1EG/8BI9Afeavzd9BGXKkC8/xGTVhvJ295zQigpwxZjgPYChmPAUGnuPhf5QQUn3zG8aMaK06EX7tAjKuq5gOSrNJgUfEvbcVC0ERZiuSTbRkM5cW+4oVAw8qZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053366; c=relaxed/simple;
	bh=ixqjIErdKZiTkU3VW68ytwg7Tww7/AxihDRomyUbjLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOf7XJZSDcF+FspehwSDd4ZndYTdn6lFe+cK6ZNCZSVNl+3J32NP7iyee9FCF7rwwdcac/xLXvyEqUekl+la+2TgsbsplI3C1Pk/+Qr2UGL6dUMjJj2sU5yO7vvzsWNwjWHnYPq39xeZFZwAEJV57x1uxrr6NMnSmq3qb9B/gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PLxZgskB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLxZgskB"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso2131346b3a.1
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 21:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776053355; x=1776658155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oefSW38xN9MALUbzSeF43j8POVD9JWQv4OHtCnV+W2Y=;
        b=PLxZgskBPXM2yITWoXuss8GTSA8udn4mMpHlLSMlIYILTBfq2w7znEqBX71NCqsWY4
         je9fkosCMrvpTyeX4qfuBOxMDmzN9rUyRTLW3elXXCVqWPbf4L+axnRgnGSUZu3cWOCO
         6eB6M9EYwt2XlyyuubYMztSjLKHmq7rn/avmmVMTAHOGTSt/Inz7xkLX9VIHlZiOv+I4
         vPH5nZlHA1KYydGX+cnFDCD5/sDkLk7tnlp720Q3A8Dez00WRCyJ/zWGR8vEY0sA3hWH
         T2bh8OdRGoWnOuzTrdC2zWKZpQvnAD1KVX3Fx1TqbwFB6+gH8XIhf+UHwpqxVn4psv6v
         T9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053355; x=1776658155;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oefSW38xN9MALUbzSeF43j8POVD9JWQv4OHtCnV+W2Y=;
        b=VNAqUoZQ7hlZf7XlVF3tMO/CFH3wv+5foHF2iVTTdQ2njsewxZFnARJhZ2xQU4kzFj
         LzWRsNdoTvsv17ZOIqoOCqGUZwPPv9/LXiIVQE9ipjdvAG8b6UaDwfE8+cjzteOSyWqZ
         9xEFvFBs5E5SDPWTQuMeZJfKgupUrWBeXqSSO+y+2ZJFgm8L8UXo0mgUVS5Zmn6Lp6eQ
         rYKS1OhOmvmVWA9cmNpbbtFtWC80oOsozJnAJmAoyz88CBXWaIK8mmQF/pcrHKZcRxml
         bevYUoBKKexddP5rzWdvjkIMP8jDHxyE9WViKbI8fiSuJqJYL7QSu5PGns13UYK8t/nS
         8xCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cwpkLdFv1pEvyQucwCnbJz6JqrUdiQuAfhLL4DfEw5PcADt7L6vQwvBdjLzI2+51ihGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrhMO/KK8A6IUzqoLvdjr++Z0dMv7ZdYEo0ilEic80Rz8t87B
	G55/VK4ZLu3xdrAiSepOvnXz+pHa4KTcsJIP7RsCocDr0nQz8QUgRqiJ1T1SUyTVbqY=
X-Gm-Gg: AeBDietyRbpFXuOlG6B7qYEICmnviGuYL1ruBYR3VZGx2dXEU0O24r2x9/TIlPyXOrZ
	/ZymQi63JvSlrr+/BkKo/P7JGUCi+UCcklCLcfo+lhuVmWmToWi4tcObfX7fDhrf/9wS7dQae5Z
	5ORmbJF+Et99leAKdCB3WC+g9uyCdXawTCQQEkmwqVDskJ6UMw4Zpis0eHXjE0dNrU+MuqurdP3
	jDEvF93TD083M9R3W/DqJOF6R1Cly2ETpferdW0r+ZSYyVApRTaxBbDnJiCEnagMi8bHL9dYhDK
	eXgc2aUj4JHoAyqWUmLtXauZFcLyuVqa9Yiu3jHow4gu1rhuC8xIAttNB0gVNY5KdubKxsMIVya
	arf48maIKDlzr9a9yd/tu+gNiKpfqL4X3a2bkWe6orkbZW5x1NdWysYxWek4HiT+nt2mVn42QeP
	VrFmG/a7neBlSomDa2nL9Ne2khjb7hulwQ1Lgl7hMrCDIZ3YtGahgdV/zQolf40NyBVIvYtNEsb
	Cm8+k0Uk1bTXBLLtydZm/qBQa2r/Qwzh+Ki6dAZr4LNYD+Sbfwt1J0=
X-Received: by 2002:a05:6a20:748a:b0:398:6ec6:b06d with SMTP id adf61e73a8af0-39fc9631183mr16546757637.34.1776053355060;
        Sun, 12 Apr 2026 21:09:15 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? (bg30dj032xp6rdh0yngy.ip6.superloop.au. [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219cb9eesm8899871a12.21.2026.04.12.21.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 21:09:14 -0700 (PDT)
Message-ID: <c5abb558-42ed-47bd-877b-942876ee808b@linaro.org>
Date: Mon, 13 Apr 2026 14:09:06 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/27] cpus: Introduce
 SysemuCPUOps::monitor_get_register() hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Allow targets to register their legacy target_get_monitor_def()
> in SysemuCPUOps; check it first in get_monitor_def() otherwise
> fall back to previous per-target helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 8 ++++++++
>   monitor/hmp.c                    | 6 +++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
