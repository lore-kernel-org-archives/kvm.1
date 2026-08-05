Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32A3FF896
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924554; cv=none; b=kXSb1a+eQWdvAoAfLBnIkVbwBxPkqxyEaMR+Ctisp/5DL3EwuuLnd5vP397KAHPjmNlQzbawHKS/BOgxse2VhOd8+MWNpRti3kpGAm4GnBq8wIsuBaXuho/Y/bPBwgI8MBVVeWhXYCeufhLCKxxprAKXPfbWnWiFWvXoE+4RThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924554; c=relaxed/simple;
	bh=M2jF0Jt2bDRZzymZQmRY6Uui16djwBoVWK1VjhYmc30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4npNz8ugBgV6r3vkpMBLTlYToNLgMqFRVGLL+mYuXzIq51qL4oAdqhwNgiRj7b2ZV60enIWBCLqoGBUn4TVyh2N47wdqBT9Nw0DHOmrmWKmf9Jk1ypbE/dnETO9YGZEDXp0k0h86Sw2bon2oZ2kDGxsnYHsSNhFnkXScWO1b2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TE/KrOhR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE/KrOhR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f7027ca11so503984f8f.3
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785924550; x=1786529350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrcStaMXdkE1hM0cDDyjF0ywdDXESAjsr6s/h+tclqU=;
        b=TE/KrOhR+hPudONkTR1ud9BiEGids6A4j5g+iSX3NQwqqv6UfQ47ho6Hh78BSarN2j
         VWzEyTQE8opn3ybr4nWb3fjO7eL+EqXnotKCRyt60OPtewwHVI83MmxQZ0mugzSrfWSR
         srhdnWhCAL9c4niOLoY674o7bU8UFewIHCw+UewJbpeCNUsTKFEbjz7zh4+rSi11hefP
         WHUIykpewpxsiYaBLNXJsg12u+XR49pDltYLOwA7VaQ5irinX+W/K7zA1hKrKNV9RHOb
         psGh+0pSrS7J7E2cxeXYEt60vzL1QgUcqBQJ4tIDLN8LVd7OttdhMhnvv8Rd22OJaTxt
         N18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924550; x=1786529350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrcStaMXdkE1hM0cDDyjF0ywdDXESAjsr6s/h+tclqU=;
        b=Ke5xMslu1cVbJS/scMDJuaDF/P/RUnLEDCDfMFTMBq8PZH6mMtxdcV5ccV7VQhf+A3
         MBvF0RiJ52J+ZM1kjLTKq9eNnHe9vVoDw+HZIrAQkiZWHl0dNYF6B+rdeqegg1T9K2KT
         TPY1dINiVEXp4G5vJ5ZQfzI63Kya8Y9VFlW/SHx+BZSWq2+cRszjrtdIMDCKiR0bqWee
         4fTgDlE/NufFRdt1j3KBwccc7VHuP4HSJEZC5voetRqF/+RhxBxbKGQQVm+KwdGX7YMn
         gBbBePkG3WqF7saEOsmNheySKoejLBWFXX5ADRSx/16xHVYB9sUExUeU/LYmfpECqBPW
         gwdA==
X-Gm-Message-State: AOJu0YzrY4VAK2S0zXr7BhevpLIzQHHrcMmKjFt/qqMiXr3evFC/ZERG
	AOPTw30NiEj6tzy4eHb9N2yYTqg8fD6ZKH/eh+UTxkhkGMsgFQ+cTfmzeKwCz2aGzro=
X-Gm-Gg: AR+sD13vcN4deMvSsWOWXY3N2O6c0KocAHoTcU6IDdLd6uGsgMEKXiYT24WQPSUoMYD
	YZK0Gu48s8QlDZNElIBXqDlc0+egFOgYFdT5BrNI4gjzoGJvAqDEzKWKZ7o9OsJHEn/k+I4cwIE
	LrZuh+qZpxSUZugyviMHk3LXqFJFwshkWMF9gi2EXuJE4U2R+u+oQquZE/HpO19mXIv68QFIOQV
	Dj1uOVHkuwCsOx58H5Vv0ELc/5a54iZJpljlF/nKQh2NObywnpU1K1yHLHCNuIwyg582ZpUF+X7
	UV6ZyA0j6Tns5MKJaVMoKaxeAbE0KHxEOeBF0wfU9gAFhfiaFk5KjEquaRx6Fgtx1Ai3LSpd6Yy
	szVr5SROxJGXvDbuSZc0KZRjp/CwXQrpaUxNl1xGamUgZtv+viexg6t17DZXhGecQaPixMucdij
	0jkYrQqCUcUEG1qCKRVOkueC9a+r3JQlnVuW6LwucC529LEpCYnSldasbuYbiqKzailXM=
X-Received: by 2002:a5d:5291:0:b0:47f:d072:87d7 with SMTP id ffacd0b85a97d-47fec4f663fmr7081483f8f.9.1785924550297;
        Wed, 05 Aug 2026 03:09:10 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda0cbsm7427247f8f.6.2026.08.05.03.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:09:09 -0700 (PDT)
Message-ID: <ebb8a1b7-d5c8-4be0-af64-1496a7fd29d0@linaro.org>
Date: Wed, 5 Aug 2026 11:09:08 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/21] ARM64 PMU Partitioning
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, alexandru.elisei@arm.com, pbonzini@redhat.com,
 corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 mark.rutland@arm.com, shuah@kernel.org, gankulkarni@os.amperecomputing.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <gsntse4tvbn2.fsf@coltonlewis-kvm.c.googlers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <gsntse4tvbn2.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/08/2026 10:06 pm, Colton Lewis wrote:
> James Clark <james.clark@linaro.org> writes:
> 
>> On 23/07/2026 9:57 pm, Colton Lewis wrote:
>>> James Clark <james.clark@linaro.org> writes:
>>>>>> When running the guest on a single CPU I get different counts for the
>>>>>> same event for a single process, although this never happens on a 
>>>>>> host.
>>>>>> I think there might even be some Perf tests which expect them to 
>>>>>> be the
>>>>>> same, and this doesn't depend on whether any events are running on 
>>>>>> the
>>>>>> host or not. Not sure if you ran all the Perf selftests in a guest or
>>>>>> not?
> 
>>>>> I'll investigate but I'm not sure perf is intended to guarantee
>>>>> that. perf stat just runs the event counters but may not write or read
>>>>> them at exactly the same time.
> 
> 
>>>> Is that true? The perf core calls perf_pmu_disable() when a process is
>>>> scheduled out before reading the count of each event of that process in
>>>> an inner loop. The perf_pmu_disable() clears PMCR_EL0.E which freezes
>>>> all of the counters so they can be read out in a consistent state.
> 
>>>> It's important that they're all stopped at the same time because
>>>> counters might be used in metrics as ratios of each other. So I think
>>>> it's deliberately designed that way and appears to not be working in a
>>>> guest now.
> 
>>> By default I think perf assumes events can be measured independently, If
>>> you want to guarantee events are scheduled together to avoid measurement
>>> skew you need to make sure the events are grouped.
> 
>>> The common way to do that is with {} around the event list:
> 
>>> perf stat -e {branches,branches}
> 
>>> Please see if that resolves the issue.
> 
> 
>> Groups only change how the events are scheduled, not how the driver
>> starts or stops multiple events running on the same PMU (grouped or
>> ungrouped). In my repro I had less events than counters in HW, so they
>> will always be scheduled at the same time regardless of grouping.
> 
>> I did notice something extra though, you have to first open some amount
>> of counters, and then open more than that. Then the second time the ones
>> with different counts will be however many were opened first time, as if
>> some state has stuck.
> 
>> For example if I open two counters then 6, the first two always have
>> different counts the second time:
> 
>>     $ perf stat -e branches,branches true
> 
>>     Performance counter stats for 'true':
> 
>>               106129      branches
> 
>>               106129      branches
> 
> 
> 
>>     $ perf stat -e
>> '{branches,branches,branches,branches,branches,branches}' true
> 
>>     Performance counter stats for 'true':
> 
>>               117013      branches
> 
>>               117013      branches
> 
>>               110364      branches
> 
>>               110364      branches
> 
>>               110364      branches
> 
>>               110364      branches
> 
> 
>> After opening 6 again a third time they'll all have the same counts.
> 
> Interesting. Thanks. To clarify, is this happening in the host or VM?

This is in the VM

