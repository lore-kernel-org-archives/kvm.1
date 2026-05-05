Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8120047DD5E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000896; cv=none; b=hAnRfE6XmiBBlyuYwJBqN994KbkxIi3ZQ22wegG4m656eFHe9xdQrMrEG8hRXqVMEX3F/yY9FHpK9VxOoNFxrCJEolVWTgcZOyZLbDwffvOb1JHy0MLMbVrgPWrriLbk+c9YmZ7me2q/0yLkr+q2cE/WBnZpqN6Z/wOIl5q+HOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000896; c=relaxed/simple;
	bh=RVol++1GFTe1X+B7wLqZ+eW/rvBv0ex0/tsBE8CqD4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiOH7n8OsW1HmNuNdEEz90j2abG3yETYuAWmmvd9Qp/SKXGXVnwiXwU4HzTgD61FjrYWRXJhbl3scvMByvdKaDKrDkGbrr3ZBwkyCtZYX7RfPD4CxwIvgXBOZLoM1Kpsb/jqaxdma9338U9/Sbf7XtfUPbhmylxbTXfdSPZudlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4MxO6LN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRDbKdcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4MxO6LN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRDbKdcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778000893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y6Kk1qNL+V+LnTbg0SQ7uUfk02/XBolrJz0jxzSGOAk=;
	b=i4MxO6LNBX8+EpoO8ZIsYk7/AR/3OXHLaLKHGPWU4Ww5Yf3I8TkUS7z3E1p1OmEwz5RbkX
	f8tlDjs8oOHnvpOKc6MsqP6mvlvbaJ/9gsF6KhmTyzLo4nifGMdynRTxcgce2G42+iHb/f
	hkj07OIAkLAPAz2q6gmOTll6LZRxBms=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-sMF7_SaCMNi4QHZJtB_qvQ-1; Tue, 05 May 2026 13:08:11 -0400
X-MC-Unique: sMF7_SaCMNi4QHZJtB_qvQ-1
X-Mimecast-MFC-AGG-ID: sMF7_SaCMNi4QHZJtB_qvQ_1778000891
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso53550015e9.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778000890; x=1778605690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Kk1qNL+V+LnTbg0SQ7uUfk02/XBolrJz0jxzSGOAk=;
        b=ZRDbKdcfRayKY5r6SypG39lECTL25Db9UrNktQkPChU7Z+hBsf5ved5HwtUpyGApwj
         INzWbiucDqhui+IYvFNogf17kuI/ivqa1TvSFEuI06r+tMjb+82az6rC6mSywVAibZVF
         MVkRjuAcN3bHp6iuOpRmYjOPs7P/02x/xd8jZWFl/oGlr/567zGwgM3GJAIySEhyeApR
         e9WrzEWEbfiuy6VOWT5Vswp83y2LDFJMAZv46zkaLc40WautA90lkwNd2AYZ27bhr5vF
         Jowfj1YPvwskTDrg5j10qmyB8lf8dYqWlRwZEuUePJ/fwzURwNFynGV32FXP1eykQ+mP
         QKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000890; x=1778605690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6Kk1qNL+V+LnTbg0SQ7uUfk02/XBolrJz0jxzSGOAk=;
        b=YrnXaRArhjWDbKA8gOVMqLkbyibC0wLKuR855ztTK/Fs4OlUbBjeNfOj5cjz7CW1+/
         Y3F+9nRtEin5kREw9Y/5mNK0j5aFzMLhWE7iLH3kmHWpfEEPjQGt8LBHQFcr16ozuwGX
         kx6W4ICkag4HMvJzxwq750a8Bbr1CNlIeZ2Xb4a/8KnkPCH1EG1GNA3RItln6wCDlVig
         E0XmZ2GnfZQTEGskiDKWkkoOwi2Mm+fnMG32t/b26NHaZ/ct/1J4vTjeQ1h+G8EeGwLR
         lRkJF+59VxFI0TEFx0Ci8Zrd6i7AuH3ERWNuwKYiIiEWV5sXIO1RTExlke3HzDO/ELYS
         FAfw==
X-Forwarded-Encrypted: i=1; AFNElJ/KqcqwNFoi3wAirWMpHJSyC6etdIOMC7uYHofvNZWcGTJgosv1889XcYbAvo5w8GPkyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9fdxb0mSpmGhZBKsvZHJA73pRawXYEorrC3ZhsMebq5oPNVy
	pAVDxPUxy4PYcjXGEpcnfl7Q4PNeIZPPAXsXknUrwOLiymuE5cniDbSg1KcD4tH3tOhP4gTIRRe
	IUIHgfc+0jfDfmn5RiN6JBWNhd/wbUlOpTwIMy/RZEyltlV/Tl7HZig==
X-Gm-Gg: AeBDievy3tzCdv4Lw/Y/B0Zo0gQqDSQmLpLUg1OPTh5jvMKAbunLlcrV59nwt5COWhZ
	+0G/77lgPfmz3cFkI2wijv6Kc3qGAXrVFEFkPTNGANT0BvnwOvFe+B7ewN8R8rYkjSCkGWqLMgw
	PxE2tT7I07ruEGm6dp32RT3Xin/a3geLYah2VFyQI65bEO5FtqrPSg1CE1ViH96SpeLWmSsWTvk
	ZIIMOaIAWdc4Ufs0EtEBsHqWXvIEmVoyGz2m9oi0haFq9WmnPYulRkXvuiqUlLY2B7H/wvo+QY6
	Qki+rPZi+bQHP6/qZX7QocgvL9W4jCoRvHt48T283OW1ebSSqYuUop0fqOT7z4TyaTr20EkG06L
	OsuC6ofxtyTCJuVaZFvj9ATfBmB6/wA==
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48e51f32870mr1425395e9.14.1778000890598;
        Tue, 05 May 2026 10:08:10 -0700 (PDT)
X-Received: by 2002:a05:600c:a118:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48e51f32870mr1425055e9.14.1778000890168;
        Tue, 05 May 2026 10:08:10 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm370151275e9.5.2026.05.05.10.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:08:09 -0700 (PDT)
Message-ID: <08939576-e2b2-4b9f-ad72-a4f777d43a46@redhat.com>
Date: Tue, 5 May 2026 19:08:07 +0200
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
References: <afi_HNJoObF10rwz@x1.local>
 <96f57df07e6d39e30557357142b2212e0ea26af4.camel@bull.com>
 <0abf41c113c9425ea4c73a108db22f28290fa395.camel@bull.com>
 <13002aef21dec62205c252f3d12bb42ea59cf287.camel@bull.com>
 <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
 <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
 <20260505061927-mutt-send-email-mst@kernel.org>
 <c7b1a006-a67b-4ddc-8e2b-67fbeb23b066@redhat.com>
 <20260505065122-mutt-send-email-mst@kernel.org>
 <48384da2-7eb5-4044-bc3a-201b09d9cf81@redhat.com>
 <20260505081337-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260505081337-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2026 14.33, Michael S. Tsirkin wrote:
> On Tue, May 05, 2026 at 01:38:26PM +0200, Thomas Huth wrote:
>> On 05/05/2026 12.53, Michael S. Tsirkin wrote:
>>> On Tue, May 05, 2026 at 12:34:41PM +0200, Thomas Huth wrote:
>>>> On 05/05/2026 12.23, Michael S. Tsirkin wrote:
>>>>> On Tue, May 05, 2026 at 11:45:17AM +0200, Thomas Huth wrote:
>>>>>> On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
>>>>>>> I had a bit more time to hook into qemu to check the root cause.
>>>>>>>
>>>>>>> It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
>>>>>>>
>>>>>>> ```
>>>>>>> Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
>>>>>>> 1473       unsigned size = memop_size(op);
>>>>>>> (gdb) n
>>>>>>> 1474       MemTxResult r;
>>>>>>> (gdb) p size
>>>>>>> $1 = 1
>>>>>>> (gdb)
>>>>>>> ```
>>>>>>
>>>>>> Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough
>>>>>> to see that we only want to test the lowest bit here, so it optimizes the
>>>>>> code to access only one byte of memory instead of 4 bytes... which would be
>>>>>> ok for normal memory, but not for an MMIO register :-/
>>>>>>
>>>>>> Ugly work-around, to force GCC to read 32 bits:
>>>>>>
>>>>>> diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
>>>>>> --- a/lib/asm-generic/io.h
>>>>>> +++ b/lib/asm-generic/io.h
>>>>>> @@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
>>>>>>     #ifndef __raw_readl
>>>>>>     static inline u32 __raw_readl(const volatile void *addr)
>>>>>>     {
>>>>>> -       return *(const volatile u32 *)addr;
>>>>>> +       u32 val = *(const volatile u32 *)addr;
>>>>>> +       asm volatile ("\n" : : "r"(addr));
>>>>>> +       return val;
>>>>>>     }
>>>>>>     #endif
>>>>>>
>>>>>> ... but I wonder whether this should rather be treated as a bug in GCC
>>>>>> instead, since it should IMHO really not change the access size for a
>>>>>> volatile memory access?
>>>>>>
>>>>>>     Thomas
>>>>>
>>>>> Wouldn't this break linux generally?
>>>>>
>>>>> #ifndef __READ_ONCE
>>>>> #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>>>>> #endif
>>>>
>>>> I asked myself the very same question, but after googling for "GCC 16 linux
>>>> kernel" issues, I did not find anything related... there is likely something
>>>> specific to kvm-unit-tests in here...
>>>>
>>>>    Thomas
>>>
>>>
>>> This seems to be pertinent:
>>> https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
>>>
>>> -ffuse-ops-with-volatile-access
>>> Allow limited optimization of operations with volatile memory access when doing so does not change the semantics outlined in See When is a Volatile Object Accessed?.
>>>
>>> The default is -ffuse-ops-with-volatile-access
>>>
>>> implemented here:
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=122343
>>>
>>> Try disabling? -fno-fuse-ops-with-volatile-access
>>
>> Thanks, this seems to fix the issue, indeed!
>>
>> Would you like to send a patch for it?
> 
> So then it's this bug apparently:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125180

Ah, thanks, that looks like the bug, indeed!

> will likely be in 16.2?
> 
> Maybe just wait?

I guess we could drop the failing test from the CI for the time being...

  Thomas

