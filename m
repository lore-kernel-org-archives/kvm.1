Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086D23817E
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048888; cv=none; b=o1JII7mXjhOE5cbSLNPdayjurdqlpWi4ZmQECeAC4oqLVGAptpLl5x/5ZMZx0Ro2Wxv6f7JwCT1v9Ixbk9EguW5rf5eHLy9bQa4nK8Th9JAufbT1ZBXqfN2P0NdJ5iGV5uDgUc6Y9dZ1M9FDM5BZJG+JA5ri1nGVzqZs2GEOS88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048888; c=relaxed/simple;
	bh=KIyavcJI+PzA95za24c82WTPvSbcwaQI2KUDnAAXcdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fh7HdehXejjJcs2eDipB2kLa9/tyznNBVfX5tdtw6EdiDY5VBNeS0U+68vco+Ockymle1YkDFmzK4CTl/GA16grgHoNp+seyJ4nGJJ9AsGj3IScnWbMwQk2PrTBB3m+IuU1PDj99uzY9dZ+QDrciXqEt15HqQH0/iY/LuiYVFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w74Rfaxn; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w74Rfaxn"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so1261035a12.2
        for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 19:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776048886; x=1776653686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qQhs7WN5alTmwzimUY/uITGqs+KMD+QkfagNZ5IPKk=;
        b=w74Rfaxnl+dR3emDlQ3/zX9ZWY5Da35jYig8KporosoxECoq+D4K2/ZR74/ZGTz4rY
         RkdcIOyluC6q8l416rzZiQX50C3R3gYzdycQlsc2eu4U9Be7nB86LwFbE8yEQzZhAdTY
         lYo9/XP1bJ0PH5oK+llc2PkKhnSY+D3Bzubacz3JzDD4PAqtULl/ZtRcWhu+Hkl82UKN
         K3jz3VaUyZ8ZYVcwJ89/eXYsXHtHkxwuJjSsjhIfNtJzq8Zevc6sISh0etiw8Dw9t39O
         bBlQQ9rykfnx3vfimaK9KZY7iC823Cz4KOWwWeJJUfiOUke3n4VqjUUsqrZyg82TVQWT
         QjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048886; x=1776653686;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qQhs7WN5alTmwzimUY/uITGqs+KMD+QkfagNZ5IPKk=;
        b=OZPhlIPh9VHdEu1BkluGmnPVDrSbh9dFs6g9Y0tX7QBTYV5pyVa5H/BVj0YzXl7LFB
         w8PgRVHGBC+5DHPHxU5PWPL39gJyjA27NF4zMlDFXQ97bGqD4AiYufYMN0TKwHhJcxy3
         7Mx9AttxRsAKm7CORwOqVRlG30gVY34h9n4GSS/ctEcU3/rNHn5ggsKK5iR/J8GaZkFY
         5SF4CcceVILAdWk6bIOwaLkKZ/N2ZM8QLIKksX4kmFfJNaaSF8X6ZBm0rNw+RICRZsiB
         EogEPswVHq5NfoP0rE6esrnCssoTysRCyGWjBgkZu3ExZeLEnXYNqX1uJkVjIgx63vZP
         G2hA==
X-Forwarded-Encrypted: i=1; AJvYcCUgKcQsfcp0KYweuUDwp4K38H/0dPrMWYcoEL+za3HHQQq4Hd1nHBjBgvsoxEKGYJagl/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJQMp7t2cUI2q3qTHOa1qPiDsazk7GqDys/UMD+34xPMnKwNv
	v1Dj6vZZsxVLGe+Sq7yUDMBcgcHpByimR/SZZEoDlD2L13H2RdRY0P0ZIM45TEGoH4w=
X-Gm-Gg: AeBDieuzXV+IzwsOXi6tlEvpFkfhGK7v/RQXjubgiHqR7ZzaGz8XDc2hj+aOzH5bBdL
	sytSFdl2XZoSPLiiraRCs8CxC+lY+BRFeXQSBodH4wWj4a6U4T09+QL4kGTzKt4b36z8NhzsBcP
	U/Jmn3kTh8a28hO/HqNllFQw4EceYUHlHjR92LFx99u+SUoiix7UNxRvdjnppXAOpxUh8PF2eDd
	NdQlUe/9C142uPO9XHR5NwlVXIZxhaby+cqtw+acfdTP/pkoDZGrsSZgj1i5Bxgs/x/esWj3+tR
	20cZMSS9e33GEqnL0mZ4ATue44ryPYP8jvGoyfqxW+aVOgtvH5zCt1VlHFjMoAzuN2KK1EBk7QL
	9rfarZBKchb1+hjJ4jyEJcXHJZtNYbyHt49nVZvdkPOqqNxRTRED0uNUUsPbBBNJPbCev/3TOhw
	i/jSIM3DV+Ea1dZXvKkA7BO+WkZOSrkSwzhSQq8VQbLT9MBXnjGLw/1JvsZNKgy/15BiPQzX1FE
	0Vr6JZFVSh90A==
X-Received: by 2002:a05:6a20:7f89:b0:398:7855:3e33 with SMTP id adf61e73a8af0-39fe409bbc8mr13028622637.56.1776048886144;
        Sun, 12 Apr 2026 19:54:46 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f? ([2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a20100sm8215970a12.29.2026.04.12.19.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 19:54:45 -0700 (PDT)
Message-ID: <1fc32181-c4ad-48f5-80ff-d9195d6206c7@linaro.org>
Date: Mon, 13 Apr 2026 12:54:36 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/27] monitor: Reduce target-specific methods further
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/11/26 05:52, Philippe Mathieu-Daudé wrote:
> get_monitor_def() doesn't use any target-specific declaration
> anymore, move it to hmp.c to compile it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert<dave@treblig.org>
> ---
>   monitor/monitor-internal.h |  1 -
>   monitor/hmp-target.c       | 39 -------------------------------------
>   monitor/hmp.c              | 40 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
