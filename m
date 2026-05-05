Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB9481FBF
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976109; cv=none; b=Z/FugD7bBIpDLwMIwE2Fr0rkk0VBmwLiZN3DRuRyqO6u18eNAlZD0Qlm3cd2F2f0fCXUlrUiqzwe4o6Jtyy8xk5YEPGjnCK1j5e5n5TfVoCOa29nZHn1HBa0lGi2vZUJTycvhFaZG0ielfTGFDilvnUK/H2vfiB6YwZkvSRfYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976109; c=relaxed/simple;
	bh=UKDJHyq6kR+KTaggQU0rUwYmWNFE7XHciXg36o5yv4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm9Y0YekC+4zMyxpShVyZ0WkjXJbWYybkWTjbcnI8iF8dNjGLM8uaf4JudPw1YKaI7Kvc/K5n0bNnCGDTMXUjF1nk/jjAf49LsOwbacUKMX+HoMIq1W9cvqv5hB7G773VdkM889xG9q+TFOQXcV+lGebweBGOIBXlV0yvMdtsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp/5WFCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUSo+jE+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp/5WFCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUSo+jE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1KlKmz+hmhefhSW67Eory1JV8nFIgF9o1/58OtkCEUE=;
	b=Dp/5WFCMKQ2+sxVgh9GZEM7SA8Xf8mHhx6Y+JUnvQ8EUPtTtMsNVrTwsRVWQlCHeg/QLD8
	8Zai0gnDKWdYpRI5JEDOfKQbb3Pozz/5LZWA1n0ckJT3lqGJMvn07HW6ueOPEMIWfjQFtB
	WDREzquCQXnUDxieXatu7kef2+U1sEY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-VeoJpbJVNcGR0JjZodU2nQ-1; Tue, 05 May 2026 06:15:05 -0400
X-MC-Unique: VeoJpbJVNcGR0JjZodU2nQ-1
X-Mimecast-MFC-AGG-ID: VeoJpbJVNcGR0JjZodU2nQ_1777976105
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso2900986f8f.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777976104; x=1778580904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1KlKmz+hmhefhSW67Eory1JV8nFIgF9o1/58OtkCEUE=;
        b=jUSo+jE+aIhaek537rJpcF/TtYXI1KQZ+uqq6aX4Yq/GqL2vPoF3CBR9FxL+Sbkxog
         SCLoDxn8gRxQG/dGHqFiB98kkMInRI7L7PUKBoRpbqqejFcBBS7iLgl7rVGtOHzccKMA
         ZHEhX6ki+6DU0wjPJPOcaB0RkVjZPVPlG2wQKTmXQkWDby0xLAGCT3YbhrAxbTTYh97Z
         UPoog9Wks/e+XCLDhMB5hhIYg20yIXZAKz8AcYaLoyZeouN1rqJPPoHuwjAvZCOQNtDO
         UW77XY1pnGKUnm9hRWMVNUfwXU7wGlG8xbtl4eDIQNIBbO0oduFTFZvgUd7N2fSo49Lw
         3EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976104; x=1778580904;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KlKmz+hmhefhSW67Eory1JV8nFIgF9o1/58OtkCEUE=;
        b=rs2DvWxTq2DKsXIQQQ2dfsZA891sCtLPFf36iehpZTnGBtrq+EwU5LfF2DJtBENEGC
         Y+CrqMq6WT7/3tBR03YKdJrPtQgO5oWc5BOEVQxAa+xAKlQ6pHdEgkleuH66jU+4BRL2
         kkmz2Az0CtgDuF2lKq3JsWmjdvAmniJtr7z4jDfmNnNDy9iLnKd7iBOh1IySQ3k8mInI
         +B4k+GFdIzoR29n/kStyYS5SSiqYuRetsHz5gu0HU8ADpTwSOfggbAXNRsm4hflF2YlF
         7S5cXpIrtEA5SWUys8kp0MwXYFXqaAOBMdWX3d7yWLctL4mu7Bwqn4xRsIlE4s4kxvcZ
         ydGw==
X-Forwarded-Encrypted: i=1; AFNElJ+t1WMea2mno2BzAGTSsl0Lu4i9eu+REhizNbOIrzlufffJxrbv8aL+3mO/jyd5uSbjsJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWF/EwVCIo7q6bRYp90Erdmnifv8UeYKFQlx5KDYqPiobWDTa5
	uoq2ftkNzsauPImRfINQFyN8bn+Rtu8A2CiTqyTSGoqzjvEsTXV1HN0OVGnMHYHDeRiVMMzAOdx
	jPTq1fxORTr1IeqceeZNECE8CUkwXNwIw7t45sBUhYxqQ4QjaXnWdig==
X-Gm-Gg: AeBDietksClGQ533rYEJDmdEtCtzKQj+8uxGJC84f8tU4h9Ly1LdnMnVJJyRcM1lPAp
	N9W+xGrkM2gTGRmN3zdvO3i76yUauSIRuXpIPSiUt3EwPmhUOQJHrZfNHL5vDznr9zIubemkOwb
	1NhLTYn++Tg01WQmh4QuZcRDPT2tEK36BMV6mio2kUAKndWWxfql7EWr0Cm9EwhY6vq7OsOuy6Q
	bpvZnKNJZf+rVzc9+e2ajnel28kGhmifdTalncspHTeY7ianuuINa0jgmBFWzmxwbcwpAvzl39I
	XbTmG19sDTDDvlhsxWAqDp5kfo8KpfseyEpa6IY+GI4qGNipZ3/Ih9+US7UIyflSFAiwMV7TAyn
	wI9egS7N85pREbiIt3cXUMCHic13XaQ==
X-Received: by 2002:a05:6000:2c05:b0:449:af52:6167 with SMTP id ffacd0b85a97d-44bb2f27780mr21688894f8f.8.1777976104598;
        Tue, 05 May 2026 03:15:04 -0700 (PDT)
X-Received: by 2002:a05:6000:2c05:b0:449:af52:6167 with SMTP id ffacd0b85a97d-44bb2f27780mr21688847f8f.8.1777976104202;
        Tue, 05 May 2026 03:15:04 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a4878fsm3436003f8f.9.2026.05.05.03.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:15:03 -0700 (PDT)
Message-ID: <b860aea4-849e-4d0d-83ea-931de4cfc545@redhat.com>
Date: Tue, 5 May 2026 12:15:02 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: intel_iommu unit test is also failing
To: =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240604143507.1041901-1-pbonzini@redhat.com>
 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
 <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com> <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <0e67d95e01efb0823fe07cd556461ad3d9a0709a.camel@bull.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <0e67d95e01efb0823fe07cd556461ad3d9a0709a.camel@bull.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2026 11.53, Clément MATHIEU--DRIF wrote:
> 
> 
> On Tue, 2026-05-05 at 11:45 +0200, Thomas Huth wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
>>
>>> I had a bit more time to hook into qemu to check the root cause.
>>>
>>> It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
>>>
>>> ```
>>> Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
>>> 1473       unsigned size = memop_size(op);
>>> (gdb) n
>>> 1474       MemTxResult r;
>>> (gdb) p size
>>> $1 = 1
>>> (gdb)
>>> ```
>>
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
>>    #ifndef __raw_readl
>>    static inline u32 __raw_readl(const volatile void *addr)
>>    {
>> -       return *(const volatile u32 *)addr;
>> +       u32 val = *(const volatile u32 *)addr;
>> +       asm volatile ("\n" : : "r"(addr));
>> +       return val;
>>    }
>>    #endif
>>
>> ... but I wonder whether this should rather be treated as a bug in GCC
>> instead, since it should IMHO really not change the access size for a
>> volatile memory access?
> 
> Volatile is expected to make sure that the read side effect is visible.
> I don't know if the size of the access is in the scope of this constraint or not o.O

Maybe we should simply adjust the read/write functions in the pci-edu.h 
code, WDYT:

diff --git a/lib/pci-edu.h b/lib/pci-edu.h
--- a/lib/pci-edu.h
+++ b/lib/pci-edu.h
@@ -59,24 +59,24 @@ struct pci_edu_dev {

  static inline uint64_t edu_reg_readq(struct pci_edu_dev *dev, int reg)
  {
-       return __raw_readq(edu_reg(dev, reg));
+       return readq(edu_reg(dev, reg));
  }

  static inline uint32_t edu_reg_readl(struct pci_edu_dev *dev, int reg)
  {
-       return __raw_readl(edu_reg(dev, reg));
+       return readl(edu_reg(dev, reg));
  }

  static inline void edu_reg_writeq(struct pci_edu_dev *dev, int reg,
                                   uint64_t val)
  {
-       __raw_writeq(val, edu_reg(dev, reg));
+       writeq(val, edu_reg(dev, reg));
  }

  static inline void edu_reg_writel(struct pci_edu_dev *dev, int reg,
                                   uint32_t val)
  {
-       __raw_writel(val, edu_reg(dev, reg));
+       writel(val, edu_reg(dev, reg));
  }

  bool edu_init(struct pci_edu_dev *dev);

... it might be good to use the non-raw functions here for ordered access 
anyway...

  Thomas

