Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42751D5AC0
	for <kvm@vger.kernel.org>; Fri, 21 Mar 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580571; cv=none; b=VtrLnjFkCrbN6bgr03juftV2lLqzJiDkqinthHk+7LGiFCW7b4CngMMhiDhhW+4nkuQQFfMgHHwDbq1Ctcip71f7JRZNp1SXa/VdXGR1aYIiVFkHdpVbh6eiSxLoF38AgVdVynhuyuVq9cKwAbJT4eWLDoqPgVkyafZsPgjQmQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580571; c=relaxed/simple;
	bh=T49nmdPV7xaIpIaWRNDPAfZByA6TMogA81GNZUxWAGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZZfKKM2WfH4yX1SXECy1CsdL0mlhj1iwW/8LRXXYVgYOGPp9f4x7f3hja6n3BXQiG80pG4w79lyTFtoZk/fYV2DcqcK3oHFaePvrLhMwyrRDgYgx7kxMdnhHn6cVOZNe5EvjeETDObHQNJYI0z0gA5ZFWzwDIQbebAb42clm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o92gqjOK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o92gqjOK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-226185948ffso48335875ad.0
        for <kvm@vger.kernel.org>; Fri, 21 Mar 2025 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742580569; x=1743185369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYahRmDjo3AoM4y6+k6usMjWi0lqC7TSobI4jZQHYNo=;
        b=o92gqjOK7LLNIHCNxCEqhWaO7kG0WO7fz9a+1nJB8NOiztXFkKBCIRLUr1K9qqs9JC
         ADii4ExEZijp/WQSfP21N6YYd65a1yH2dzmjuCB04llFbeO9MIf7MajWUlwCTeNbRCJ4
         5LUpUHwjX9gb6yUOWk1j48drbQK0IA/WTZJc1pxO1KAulSAu29ayaly2D3SF/Dppldgm
         U3t6patflLq75LFFwqz4sXHodeFkohS3L9QT2FY/3xwwBJIL/MrWcmOg9psxBQfZ5VBh
         lZYs2HCqKU8lDBttSDu3q0sx0X6h3iNgDGyamk4AiNt/fxvkbtSDWxqQWmApGgv+PkcZ
         Uktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742580569; x=1743185369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYahRmDjo3AoM4y6+k6usMjWi0lqC7TSobI4jZQHYNo=;
        b=JzpLlx9QKHVHbmHwxZUV3LzE5ZZWlJnBxKFv15vUb8R6ktyBKPWV/WIDdqYI/TJRao
         HTz3rBAHm1Up/DsPP5EuzdIG0Fq4X4VeaHNw0i6GYBYv7owGV0XD8WAfRV5XfQsbEXTf
         gC9KhFkm1XgPIlSoWVl7RaKsXqSsFKllATewQbemymUVYfW0Ydw7qqy8qYvLA+RyDMwf
         ogxo46E0BK8ixPzugVTUwCSWriSSYAl5JgbCX3Zqt1Kf1p64JanQxa8oSkSRT0kU8Irv
         rDKD4KzS1GoudgQ0Re17ApMBZC9FTNcZBULf5h+ik1p+fW/MDEbkIF4fmUVc9VnZTRZG
         DNUA==
X-Gm-Message-State: AOJu0YwkD7s8I6i3av3Wb27wXUW6zKgFywwxFWcaN/JeD/f4QBdSMQ2j
	1yYWY+LX7vsXZjPi2JSgAeb4X+bJ5YqheDhipb/L95Rj/7DWuME/EgRqgnKkl5I=
X-Gm-Gg: ASbGncsQlizEycaaQi6NcpSu9gcqCT/rXqoel8ZYp+eREEcNL88fouMsSvIqDO6ffYf
	LmX7zrtBFz1r3kYOFGxuExvZbZMLGopwjyWSOob8huMc0ORm20iZSCLagmcBICQdSrXEum7n+fk
	5Mo2H6nBJ6RcyNBu9GOdr8PzRqjJUT9Lo03lsFySSsYYMeJ28mRyZ9KeIrHpZuYL98gHlgyUabu
	trO2daQyH1ny7Q0y9kay4qBdQjn5h26ddHHNn2uexPllc5LgREjP/KKj7nz2FY1ipttZNBwZ+BH
	tMwjA44QdLGUOiRIN47XTnRur5+lIDUQ1zSwZqd2YX7fyvXpwkPmqs/Sfac=
X-Google-Smtp-Source: AGHT+IGEzpLgBssNtlnSo2d+4BPwRhsuDuNJMP3F9IXe0w77xd/Vh1TYYLKAw8Fk+vnKaucfwGRFpg==
X-Received: by 2002:a05:6a00:2ea5:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-73905999885mr5137245b3a.9.1742580568898;
        Fri, 21 Mar 2025 11:09:28 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd7a3fsm2373139b3a.67.2025.03.21.11.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 11:09:28 -0700 (PDT)
Message-ID: <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
Date: Fri, 21 Mar 2025 11:09:27 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/25 11:05, Richard Henderson wrote:
> On 3/20/25 15:29, Pierrick Bouvier wrote:
>> We introduce later a mechanism to skip cpu definitions inclusion, so we
>> can detect it here, and call the correct runtime function instead.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/target_page.h | 3 +++
>>    1 file changed, 3 insertions(+)
>>
>> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
>> index 8e89e5cbe6f..aeddb25c743 100644
>> --- a/include/exec/target_page.h
>> +++ b/include/exec/target_page.h
>> @@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
>>    #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
>>    # endif
>>    # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
>> +# ifndef TARGET_PAGE_BITS_MIN
>> +#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
>> +# endif
>>    #else
>>    # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>>    # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
> 
> Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but
> today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.
> 

When you mention this, do you mean "constant accross all architectures", 
or a global (const) variable vs having a function call?

> 
> r~

