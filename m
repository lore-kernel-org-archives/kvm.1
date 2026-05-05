Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82C30B50A
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977288; cv=none; b=hhY1Pkblixd1JTR/uKAjEZXL4nGYWHXV5naCBfN5NZEws0MRO07UuWYqr0552ho51n3onHIvlks4APeOOFlaeCwX9yL1C1TssFEJhJtjUoY7w0e2XgxJOmNF3EcrMSNGUi7p7BrFL1ddSM/7TVAMmybPID53XC76k2DJrAF55yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977288; c=relaxed/simple;
	bh=71SfHe86+QqMk29B+Emf4qmrH5aRpRBYETbPuk6Re+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeECGELlwL5n4LGbE1cnZhxEb90oBhEEvWRlea6DoR2t6Tr1tc/XXI3nSUsv14AFpamUnjWL61q7Jl21y3D4OmF+AUtRGjbUsR6bFpMkx4optF8JzUwFo6hueMTpuB6Zo1yMaJsPPEzgoZdIIAJRcx4j5esXtNEt84+QjJ+yhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAh7tNbI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mtwIBqNh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAh7tNbI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mtwIBqNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777977286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G5iBBsggPzYXR9GJe3ptIurXeplKKHmmKRF7qyq2/3I=;
	b=AAh7tNbIOzJp3Cm482BvxhTu4L3WtrS4Q+Qj5vwb7h/d9/Rj3Yk6DAu2EGy3WWcP36ERXF
	fmGb8ph02l1jOvWFJsKqQyI/f7hhgsKwlC2M8FeGDy1+/Ktl6/0io1bBjFmwlZjFdumsAh
	Ct23vmnERrw5DVsjk3uBK8mEDhBgJDE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-SYv1yKeyONCjOSHaOU6qgw-1; Tue, 05 May 2026 06:34:45 -0400
X-MC-Unique: SYv1yKeyONCjOSHaOU6qgw-1
X-Mimecast-MFC-AGG-ID: SYv1yKeyONCjOSHaOU6qgw_1777977284
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so32244575e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777977284; x=1778582084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G5iBBsggPzYXR9GJe3ptIurXeplKKHmmKRF7qyq2/3I=;
        b=mtwIBqNhruj1MAaLC/jV8BHL/Wm0LtZ7pEl3RQftO3cvQHmlXl6T0E0bKGn4ULuPZQ
         q0zvMegc+WXThVzWDL5W8ymCBHvqIIemiiQHjfmK81/j8AmCeDDIPwYqzncNwvVOhDkV
         pvWRfxHXv8DW1gr2kkVXU9IGLxer3ox4noqTFGXXARFOBd9zuwImMd50oiFVXEyFT6di
         wwHosLM9xOu9o7A5Qpupow8v3D78O19aq2bmYBYxTMUcPoL66sCv55BCiHY3WEC8e8NS
         v8GFlf4/iPV755qWpH9B2JBHiRrdP5QJwHAHRQCR836MPfA+7r4Pq+ZbLSEByseQfhvf
         zyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977284; x=1778582084;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5iBBsggPzYXR9GJe3ptIurXeplKKHmmKRF7qyq2/3I=;
        b=oWhy5EMf7zW/UJviXqw672ns+dz1llqPzhc6XgbUgJD8ixtvjAXH8htkLG7pmRQnsM
         f6o+kyfEs6eHHgxDhU3JEg0Ix+N1xkjNBcFq9jxy5iiDHA3NsW8CvzUAy+9R60XGot3S
         TWRAAbXsKl1aamJHFN7NDEb83zQtFLYl329R9a7QL7qcg8EYaD/5KL5P0Ub37gs8+IF7
         hQ/QdVcMqTPz7HlTlLbUD23r17sUTLwKMu7xaTPYsCueAFpK7bgbEyjG1oT5Q5Wfo+eA
         zFE0Kdpo5SI1jA1KPRfGvTcwR4o6DKzVxkmVncI68+7LnK9kLADdqRjFA2yazCUgsJ2S
         JVmA==
X-Forwarded-Encrypted: i=1; AFNElJ/0jVL/SdrS+Fap+hJ3SoQafECcGrG3TvHEEyQQf1tyAPWOAVSwvzejRsH6QlJT2oqYdOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZAa3rUBZM2iW7Y5PdLs+xiir17VV6NRjQ8zfQVt2Y1MMrGkf
	A1E+Rs4pnpgMsZlQzzXBcnX1fSRJ7KWt6M3dll8cf6YemtpMLxReQBKkJv0AUwVITUZWdySaIQz
	cFXUj9l/sW01LjdRbxt4/VlNPX+FgnFxlBtDXrRXzwPTrQF7vV4GMi7GRSGn8LA==
X-Gm-Gg: AeBDievk+FB/RauNpWPcHPo54aP4vhUhsFpT6HXOrLtyhmjP3H2rDLwxvPOU6eNqNMR
	LEDIninQEnZlNSn1zwM3D7QXblYPQvQ1oEzQ+ZgLh6LRk6029vMmb0clAz4b9k+53D0/UJEXuLv
	PWNGabhdlnAXsBoRLRd/Ud3ZG5BBxBucl3m1u4lydcFEKFRCpvB8mG+djxjgfGw+VwWeESbP+P8
	4wzfdTz1jQNKThwjzJEDn4fqfBXa5gNvBe/ugPwDEz+chZ5Jit1pJahuubuWRE1cDmFNcWHphuN
	FPpnevgYGzqQdMGgodE4OW1LNAWofktSu1FkfHaX2MPPPsCyq9BbxFP034mhHFUbbP7U6/rD3/1
	tic6EYnOvogLs1lvJIDqMKV0otg5vAw==
X-Received: by 2002:a05:600c:444c:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48a9866dcd9mr225599675e9.22.1777977283761;
        Tue, 05 May 2026 03:34:43 -0700 (PDT)
X-Received: by 2002:a05:600c:444c:b0:488:a824:fdff with SMTP id 5b1f17b1804b1-48a9866dcd9mr225599125e9.22.1777977283380;
        Tue, 05 May 2026 03:34:43 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb69800sm332344285e9.2.2026.05.05.03.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:34:42 -0700 (PDT)
Message-ID: <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
Date: Tue, 5 May 2026 12:34:41 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel_iommu unit test is also failing
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com> <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <20260505061927-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260505061927-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2026 12.23, Michael S. Tsirkin wrote:
> On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
>> On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
>>> I had a bit more time to hook into qemu to check the root cause.
>>>
>>> It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
>>>
>>> ```
>>> Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
>>> 1473       unsigned size = memop_size(op);
>>> (gdb) n
>>> 1474       MemTxResult r;
>>> (gdb) p size
>>> $1 = 1
>>> (gdb)
>>> ```
>>
>> Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
>> to see that we only want to test the lowest bit here, so it optimizes the
>> code to access only one byte of memory instead of 4 bytes... which would be
>> ok for normal memory, but not for an MMIO register :-/
>>
>> Ugly work-around, to force GCC to read 32 bits:
>>
>> diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
>> --- a/lib/asm-generic/io.h
>> +++ b/lib/asm-generic/io.h
>> @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
>>   #ifndef __raw_readl
>>   static inline u32 __raw_readl(const volatile void *addr)
>>   {
>> -       return *(const volatile u32 *)addr;
>> +       u32 val = *(const volatile u32 *)addr;
>> +       asm volatile ("\n" : : "r"(addr));
>> +       return val;
>>   }
>>   #endif
>>
>> ... but I wonder whether this should rather be treated as a bug in GCC
>> instead, since it should IMHO really not change the access size for a
>> volatile memory access?
>>
>>   Thomas
> 
> Wouldn't this break linux generally?
> 
> #ifndef __READ_ONCE
> #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> #endif

I asked myself the very same question, but after googling for "GCC 16 linux 
kernel" issues, I did not find anything related... there is likely something 
specific to kvm-unit-tests in here...

  Thomas

