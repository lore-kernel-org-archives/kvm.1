Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDBF19995E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974328; cv=none; b=Q50V0OvkJXAuZPTslat+2BimKeEUfxcyDS0qebfiB1xXvIkqwC6Ztcynd3D7WeZFZ59jUarRAxaUrxYL6xmNte1en4aJBWOMRW2JmdCpJ8N5fZOdZPsZEmSnckTZwMHsUdMfhIrg8OD0qJLAWecCGru3aN/7ZGrimzD2PkSsRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974328; c=relaxed/simple;
	bh=CGQD1MF+kx+ogyGRC5gfAe2LEPosFkI1OVwgwR3xyiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRLdpwOBdhKiPt6a682vadzU6mW3S3K0rVp3rexnl0j4eYJ1fvXnMM2AVew76uGNpC6jif7GbuTu2TBfIk3txpOADcDbnOtFELFpZgmsZXuPjY/2vY3Wuf+ShM4k+SzO4UG2b74WHNzBqLD/XQFJe0cSAY5mhXSjn41P+4yX1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YC5kF+lB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t6cPwvXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YC5kF+lB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t6cPwvXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777974322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZFnklJ0uzsLFOaVRqEVGytAqWFY5sAoTXkf2yj+bS7Y=;
	b=YC5kF+lBfrsOaCZic+CllM9WqDO08RtJI8Fz7P1NNc4mtrmftt3Mxp/GoimjLLFxzATbkT
	6N+3Wja9CXjfBXG+cStNrftQlOXKRjp0kVLmeJvmixcOAYuVZePBVP9WojJmnZsOQURg3u
	vWBcw97qh6UP1iNSs6HdQaNwIVBIKfA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-iNldg0XFNI6i4e9PU-aRow-1; Tue, 05 May 2026 05:45:21 -0400
X-MC-Unique: iNldg0XFNI6i4e9PU-aRow-1
X-Mimecast-MFC-AGG-ID: iNldg0XFNI6i4e9PU-aRow_1777974320
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so36616265e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777974320; x=1778579120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFnklJ0uzsLFOaVRqEVGytAqWFY5sAoTXkf2yj+bS7Y=;
        b=t6cPwvXxvZgTLUi+G8SVPI22MEnwULg3rs2/TorY1I8Viyn/UAFgx7W71bxoYsB1Y7
         vUHC0nhgEc26QxJWIEeIwC9EiCwLHEzfl9BdLmRuDSstyb8AjkvoK94HvcIgegcLlq/Y
         inPPakzqVyninfs8JjDjpDD/ycKQsG7w8Y+clZv0TKsDuCATq2cKQTScYEXzExPgFCaR
         B8RajaLrgh9I0i6fhYsYkXcO9eWI5sX2g+q57z4LyB8k/Qh+/BOMCfzcBB3qCTK/rtSA
         xyvsk6aN/twkN+0WE2jazxIcvHHkTKYl/zf5UfLtVeT4VEcOxDbbJPIrXXhTQW3UyE9I
         e50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974320; x=1778579120;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFnklJ0uzsLFOaVRqEVGytAqWFY5sAoTXkf2yj+bS7Y=;
        b=cthNgZJ33lBT8Pte4v2o9d7HkGYRmPhfkYX4Ln3vTArchTU4ipdju2ClBSACYdMPaZ
         obwwjnHx0N32L5NPIg48bGW7N3jZ1fEiANSeTv++ZvYPwJ1hCy7rUbvsR7HzPF8DEK5b
         iLqIUA3KJLRF6s4EZybI89mWBYCWro6K0qCKFhmOr9sF6B4d/vXVB07O4gOullhfPMA3
         tH8QykUGXQGctLhB0O9oL8LY1uRVhI+qJRqqoABeJrjf3vOLsIM78tjcTcREQKMD56Ka
         FZBsUKTzmwTicG9oGKNw1S7mopRIO1VEFNgFsXZizKOKFYAYml7GiYa4nyStudXvsjON
         JuLw==
X-Forwarded-Encrypted: i=1; AFNElJ/JhCgQm0wLhYCn1C/TDBTEb/EOvpi9h8zuiK0rGo2/1y7FEFMrwnvkjhVHTRYffxCmPP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotexPvFOW//l+oJhU1E1DJD2jn4LPQoMryXYaKjcgNGrm4Fy8
	VqQLZbP9AA0dd4GgCR6RpkXN10nYJ9JeyR+YbLvK256DYXjwSRz3q4+0vDVjPl8c78A6Ir5wTL/
	9MjmHGyrs9+6R/Md8Ltj0xydiaijDZYwfplVcF1T2HAwte+JJm2gSSA==
X-Gm-Gg: AeBDieuZcuevz69PqXUTPn+teSnWmJ8vtwv4qkkJa4e6Ua0DPHCIMbh35T588I+akbQ
	sAaHBYhGtPfcHpMYZdvIzPvN821x0hdHO4fZxjGKWltMO+8tOCQioCQcifW8tzO9jwI+jyzGdth
	ljG+jUS+FhgeRJxOgJM9JJ0ZIEhycm7F6hLkHxnryR0YZZfkuJ0mhyCkIVJHr8Ndk4uGwJetPBC
	Q9y2wW6/HYAiSXd8LFT+fBlbX1Gob7wF2FfAvXzK/kNAVyAa2EwEhfBU7vzjzA+091vAL8+Bj3U
	TdTKLG450SFd+TUAjvgCbQSWUndPCidMOVyrl47/XxMp7AINBwhsdYQP0McjIFFi7AH5VBjSvXR
	230jAn4XdTkFNgOyIYtddc/sGIljQUw==
X-Received: by 2002:a05:600c:8286:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48d18bde32fmr38493135e9.15.1777974320311;
        Tue, 05 May 2026 02:45:20 -0700 (PDT)
X-Received: by 2002:a05:600c:8286:b0:48a:5333:811e with SMTP id 5b1f17b1804b1-48d18bde32fmr38492745e9.15.1777974319821;
        Tue, 05 May 2026 02:45:19 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.115.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm3233688f8f.0.2026.05.05.02.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:45:19 -0700 (PDT)
Message-ID: <6b338140-873c-4303-bdd1-633d69f4a971@redhat.com>
Date: Tue, 5 May 2026 11:45:17 +0200
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
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d4ae6782e30a05ea9d56c38f0c5d296fb6a5c7b1.camel@bull.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2026 11.27, Clément MATHIEU--DRIF wrote:
> I had a bit more time to hook into qemu to check the root cause.
> 
> It seems that testb issues a single byte read (out of the valid size range), as we can see on the following breakpoint:
> 
> ```
> Thread 6 "CPU 0/TCG" hit Breakpoint 2, memory_region_dispatch_read (mr=0x55d72883cb30, addr=152, pval=0x7f62d25f4590, op=MO_BSWAP, attrs=...) at ../system/memory.c:1473
> 1473       unsigned size = memop_size(op);
> (gdb) n
> 1474       MemTxResult r;
> (gdb) p size
> $1 = 1
> (gdb)
> ```

Ouch! That's an excellent finding, Clément ... so GCC 16 is "smart" enough 
to see that we only want to test the lowest bit here, so it optimizes the 
code to access only one byte of memory instead of 4 bytes... which would be 
ok for normal memory, but not for an MMIO register :-/

Ugly work-around, to force GCC to read 32 bits:

diff --git a/lib/asm-generic/io.h b/lib/asm-generic/io.h
--- a/lib/asm-generic/io.h
+++ b/lib/asm-generic/io.h
@@ -38,7 +38,9 @@ static inline u16 __raw_readw(const volatile void *addr)
  #ifndef __raw_readl
  static inline u32 __raw_readl(const volatile void *addr)
  {
-       return *(const volatile u32 *)addr;
+       u32 val = *(const volatile u32 *)addr;
+       asm volatile ("\n" : : "r"(addr));
+       return val;
  }
  #endif

... but I wonder whether this should rather be treated as a bug in GCC 
instead, since it should IMHO really not change the access size for a 
volatile memory access?

  Thomas


> cmd
> 
> On Tue, 2026-05-05 at 09:36 +0200, Clement Mathieu--Drif wrote:
>> Back with some answers:
>>
>> This is the incriminated hunk:
>>
>> ```diff
>> --- <unnamed>
>> +++ <unnamed>
>> @@ -1,17 +1,16 @@
>> -  404395:       8b 80 98 00 00 00       mov    0x98(%eax),%eax
>> +  40441d:       8b 43 38                mov    0x38(%ebx),%eax
>>           edu_reg_writeq(dev, EDU_REG_DMA_DST, to);
>>           edu_reg_writeq(dev, EDU_REG_DMA_COUNT, size);
>>           edu_reg_writel(dev, EDU_REG_DMA_CMD, cmd);
>>
>>           /* Wait until DMA finished */
>>           while (edu_reg_readl(dev, EDU_REG_DMA_CMD) & EDU_CMD_DMA_START)
>> -  40439b:       a8 01                   test   $0x1,%al
>> -  40439d:       74 10                   je     4043af <edu_dma+0x121>
>> -  40439f:       f3 90                   pause
>> -  4043a1:       48                      dec    %eax
>> -  4043a2:       8b 43 38                mov    0x38(%ebx),%eax
>> -  4043a5:       8b 80 98 00 00 00       mov    0x98(%eax),%eax
>> -  4043ab:       a8 01                   test   $0x1,%al
>> -  4043ad:       75 f0                   jne    40439f <edu_dma+0x111>
>> +  404420:       f6 80 98 00 00 00 01    testb  $0x1,0x98(%eax)
>> +  404427:       74 0f                   je     404438 <edu_dma+0x11f>
>> +  404429:       f3 90                   pause
>> +  40442b:       48                      dec    %eax
>> +  40442c:       8b 43 38                mov    0x38(%ebx),%eax
>> +  40442f:       f6 80 98 00 00 00 01    testb  $0x1,0x98(%eax)
>> +  404436:       75 f1                   jne    404429 <edu_dma+0x110>
>>                   cpu_relax();
>>   }
>>
>> + is gcc 16
>> - is gcc 15
>>
>> The instructions generated by gcc 16 always skip the following condition:
>>
>> ```
>>        /* Wait until DMA finished */
>>        while (edu_reg_readl(dev, EDU_REG_DMA_CMD) & EDU_CMD_DMA_START)
>>                cpu_relax();
>> ```
>>
>> As a consequence, the test performs the second dma operation too early and reads a wrong value.
>>
>> Regards,
>> cmd

