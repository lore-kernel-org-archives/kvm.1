Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2A4825B6
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725832; cv=none; b=UzcM5GQoD8gEG5zLptJdCl4jqw1gTPBakpIRzLL90m3K9bCpBJeK8GbyVNsyLnVTl8vo574t5zSj2aFRiSX/6Z+ZGV3bO68Wqp3UE958ZbpsJOcaXnWxTNBIxr4cJitRIFVbtzRp6xPKkgNL9Kmcj64msQoO2vtOH2IdOay63cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725832; c=relaxed/simple;
	bh=noKoDpx4dUuDSwuuZTUe91oT6baf4TQ4KDGaAG+Fhbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/D7pIPtrSF3fA+Hhh0IGRETWUuRdDMh1pKIkA/wy32x4cdEO5HQsNSzqT0JmngEe9Wf4jtBiFFZkoMFF9LpZL/syMk5pOwDSjfqmY682eY4klJlN2LXA8RHb0TvrLiDDw9JZ6CTF4pxogP3yTvcSXSLjEJF9fR13W+0AWnjO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DPQ2WXLl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DPQ2WXLl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so265959f8f.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789725828; x=1790330628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C5qxAIhr/CpV8rdb7Qf23Nk2T66hiid2IOqRrMWFtsQ=;
        b=DPQ2WXLl2Fj6ASVlur138kxuNyapO3h5UAaZ7ZbkLtJPkco2Krt4ExQLfRb6x9PxhW
         KDzJsuIvMY4RAAr29yQuHGThZisC5ZLgPg1HiM9HW46ZlUm2LXY/+QEEmFeNvA7OyEVC
         ECPqY/FSbmA/uujOVTblIUaYYmSMpGl19GZb1751rEbCTdX/MamghZ60eyu0eezEMGtx
         KSF65sfxvvlaO+uJyeWXelmb7lM150hqoD+QSMDmNam134yqMATZA0rX+3vyn4h0uO5j
         wE/M9d3Arjf8pPtBb6oC8FLiJYH/HtVljQx8IXE2iSx/DKKeQ4E2HKyXInpdXoFbKNjY
         9+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789725828; x=1790330628;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C5qxAIhr/CpV8rdb7Qf23Nk2T66hiid2IOqRrMWFtsQ=;
        b=vDTn7ctFZMr3TOhewaibl6x7wrLgK5up/Kr/bUQubkQA0PfgT2BJzTc3tEX+3nla3I
         Hn+sFyuHAoX8c6EmToAirvTY5ayYi/LsDUQAISIQdqppEaJSQfAmIiMsEnJYdz8s/OR/
         N0uZigQPQPqKe6NUr92XJMJt675T7WXwfSeJL0JLLEw1StuZ/SK/RPP3sQge5pvE+dqd
         QN0e170Eg+SVjz4FkulcsaaHsmALnJ+b/bPDWQ6bXq42CoBnWt0eWu5YBjfXSzndSHzN
         B99Wu+0+NvRHJWdoCA5en58aB7pDU4MevbbeJY3+Ceoxp9rIi/T8WKT22p5/nXrhAwzO
         3g1A==
X-Forwarded-Encrypted: i=1; AKwUvBzjhH3kMPkBHAkw2b/XcGvxWUMANkMyRwARhfyNYrK15CJMpnaHbShXI8rWwV6pfgn9WJY=@vger.kernel.org
X-Gm-Message-State: AFuF++kV2vwtle5vRlylEpawJ/nkL82A6Y6Q+uu+QWSXN8Tto/dxDsgD
	yqPbKdTBVEHTLQBbaaQGtMSRi8XfjzgNLTXQcL/9TO3HcU+sB+5IdtFLRYBx9fCjO3w=
X-Gm-Gg: AYBFou1aAQbx4/MbZUE00POb0z+/8VuZ0Z9sUlZtCw77YLS9Cb28O0s+v/S4snc48p4
	gLGJnm4aFXbA8kHxB0hqreFWv0QFdVTvicpmVD+TKd7MK9PaxLqIe9GwyFdeUllmS6QnRl8dqSH
	Vppi/6wvy/6a11cDrcFYDtvvMV7R754SBiNH9xh8JX/RV9vaAV2EYRdIq3WxppztCX/EZNPAmfL
	LwfNa7C8JV1cYvsXKuwRR4GNiVF13waRg4kTAxGXsYir707rTpy8tAWumGYMdiUN4wHDCNfLlWu
	Vm0i+MXx/bvZFn1tGmWCZAiNk4fc+mvli7x1wZwEFA9A2vHTqQYE2SPC7vIE/+zZ+W/SwETIgdP
	ryq4ASIwOUqqudZlLh5FOPfKUp4ow3lM82ny6KMF6YTLINBRu4E4UV1YM9/ksdGCyUODnAqhGyD
	/ToIAoljc2qvyvKwrJ9+7p6/y45kd6tZaz1OBYZyWk5hHCv8JWR3/YwZen0W1fs4AwqjYUDiJ+J
	3veLYtrbsmkweo4v9Pu39Cv
X-Received: by 2002:a05:6000:2382:b0:487:c76:4d12 with SMTP id ffacd0b85a97d-4871e2132c3mr2748208f8f.11.1789725827685;
        Fri, 18 Sep 2026 03:03:47 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008678bsm3025594f8f.35.2026.09.18.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 03:03:47 -0700 (PDT)
Message-ID: <477fe308-0028-4ce6-a57e-fefa1a611126@suse.com>
Date: Fri, 18 Sep 2026 13:03:46 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/tdx: Harden exports
To: Peter Fang <peter.fang@intel.com>
Cc: dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 x86@kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20260917110714.1587301-1-nik.borisov@suse.com>
 <aq0GHXV67ROAhILB@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <aq0GHXV67ROAhILB@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.09.26 г. 12:36 ч., Peter Fang wrote:
> On Thu, Sep 17, 2026 at 02:07:14PM +0300, Nikolay Borisov wrote:
>> tdx_* function aren't supposed to be used by the kernel at large, rather
>> they are mostly used by KVM and a very small number of them are exposed
>> via the tdx-guest/tdx-host drivers. Reflect this fact in their
> 
> "exposed via" sounds a bit off? Perhaps "exposed to"?

What I meant was that the functionality of those functions is exposed 
via the tdx-guest/tdx-host drivers. I.e those drivers present interfaces 
to userspace to enable them to use the functionality of said functions. 
I.e those functions are only used by those drivers.


> 
> And this patch only touches functions exported to tdx-guest... In fact
> tdx-host only uses functions from arch/x86/virt/vmx/tdx/ (guest code vs
> host code). Maybe the log could be a bit more precise.

Fair point.

> 
>> EXPORT_SYMBOL* declarations.
>>
>> Reported-by: Michal Koutný <mkoutny@suse.com>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>
>> V2:
>>   * Drop the change to tdx_kvm_hypercall
>>
>>   arch/x86/coco/tdx/tdx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>

