Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E6316197
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882055; cv=none; b=HDHjsfRBXvagCjsqngkvxIUJldMfwuspjpPWc4fGZUF+mHJjuBZ7lMdRt/hV4BYxz3CqDHbQzDq9tv5C3kn3XQIw+/MFlEYswkSinZyPnrvhxKoWdysLEjDRjjbuMEQZf3dkrBuvVSh98LebDG24dKXkeTEUCHY57TQ1kGVZzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882055; c=relaxed/simple;
	bh=6/dknj+VrGBpwMo46vsV4Iz4eUlCEu3wJGCdvx4hloM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=JdWuf/atrEttGrVLhplv9G+WDNbeN4FZAI08tXGw+BdiS1KdIKwYRmCNBUGni/o6cdgrUoophHR/KigfgErMo21W0+tVsad8BFN+3mi7F6Mp0OP1ygnaKJ6cbiL2xBk1FjkAexxIIC7Ve/N2Vmfl0buZUSA1to3w40BO7J+fztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9vjk2y+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7LP0nyc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9vjk2y+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7LP0nyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777882049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CRaXzj/Yb/pGDXSgm8vJvU5eBBp56vb++oimdsyqQCw=;
	b=b9vjk2y+py0xf8xpJQqc5DB+OVjwLnmF7Rq4p8ejv+7ErLCOjwreG26VF8cHsL/pxz1R+i
	K+khhDJxIN5bEKQCBbbrC47ZyPcz4bTKD/RvTGk9TyRpucz+WqzeKAssZR4f9VRcpyn0V0
	SlepeY1Xx4Rn6QzBBHy/yfFvVuq4prw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-5u3l_otzMCWNpUniPdPmZA-1; Mon, 04 May 2026 04:07:28 -0400
X-MC-Unique: 5u3l_otzMCWNpUniPdPmZA-1
X-Mimecast-MFC-AGG-ID: 5u3l_otzMCWNpUniPdPmZA_1777882047
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d9ace59efso640458f8f.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777882047; x=1778486847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRaXzj/Yb/pGDXSgm8vJvU5eBBp56vb++oimdsyqQCw=;
        b=b7LP0nyc5yQO3skcnRqyfo6jmSoWrrtj9VKqMOOTez46XXN6ObZv1+OQg1/2CxGeXL
         PBowOM5LhHaKu7RCkFzHPMFH67nHenUL72fyDpaymDSBBl+Qwrzzk+0FYt/OHk1KTo61
         w05cAnOCk8iBYAFpuMsA6TjaffmoDPEFGrsjseMaiMCInHbD/Jj1gbZ0sTzJIDMp+Uh4
         fF2MVNmfaroW8dYHa/d8hg45fAQddZ+4gaZUR5iRddlIv5fXyXT7+U9rzKc3sOCblprW
         DzMkbH8IokJuMOHawO8E3ZjcC9RCteiQ+KFybgk7myjo5s6n1qWeCjQt7ZxAbArpjx7Q
         4HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882047; x=1778486847;
        h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRaXzj/Yb/pGDXSgm8vJvU5eBBp56vb++oimdsyqQCw=;
        b=UT08vmSZYf+swcFkchNun4SEVS2+alYLnVAbMgl3h21Ng7a1tFNTSVec3bEzSQPIFJ
         5cSUJUe5SLW9hqngtv89X65GOZkP64djE2Iypgw1nWEKdq+ir2BFUp3sq6iowj+FlPA5
         2/hpPRaB62Tx2ckkRgyP37PXhxT4J/TquRjLbL4XW9+kFLBE3Tzqt1TKx+1sWrpUmvGJ
         6Be4KMQHr0ZeYHsQMfPMzfb1iEBhNt1pXH6aWW8N6yybGk0FXdQLTJZ71A4KdqocJdn4
         qc7/V4GgY5iPlfBcq+XfaLGgqMme3OYr50zesNxsaO0hnbKhisw0wYeYKSENqLbUEQ2/
         z+Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+AlhFPkiJjQRXFQUpvv1ZGbDVeu9myPP91Vr7enOEPHKdDIfPo2TWH3tPewJ6fNCifMY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCqO/thHyrX7eDaU+nDfKp23GeP21leSu3TFsFELFXryfax5+
	z2nn52qYZ3kYdOlzWKarWKDKqi2o8YW9Hs4/w08XOaP0DeqyBNp2IXCj6NE+kLtYKVrVQu4R8hT
	OUHVnW3d2IrIl4fUg4yE1zJjF8fYVA29eTIuocY8R7mKbe0CeFbXrxw==
X-Gm-Gg: AeBDievniQLi2HGXPd8I8sV8r7JoJ/l/zWzjQJuLcfG0Ar1cmCg7Xup76Tj4547lxUW
	vfLl1t4LlUtJAGQp+OqhKtERTYH/quUc9hpofWa452SVWCPD7Aq7Oz3CP3wL/TVzQkoyYXnGVYW
	SzqGDY6WwwtHoAZ1ZvBiMCRr9wvPds2DW3FnDmbmzlAEvW/1H171wpFmvRewedjw9gR4HReI090
	I5lqAU0T8gdDlkYnoOH55MRbhigIkj1jODwStzavwFvEhz72OXzn2+4Doz2ut0kRouxMR4LfViT
	QYcwLC/TJvj0tt1spLIg1U3m/Qs+AOl5oJ4VImSMlTHkCbfSByKj8nghAWg7zeHKJSOURtpmj9k
	VMCMoM5atGQO8yFg/iIIWPEUFxYBLFA==
X-Received: by 2002:a05:600c:33a2:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48d0640ec5emr37000755e9.21.1777882047405;
        Mon, 04 May 2026 01:07:27 -0700 (PDT)
X-Received: by 2002:a05:600c:33a2:b0:48a:5342:36b5 with SMTP id 5b1f17b1804b1-48d0640ec5emr37000425e9.21.1777882046951;
        Mon, 04 May 2026 01:07:26 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a9919fc3asm88554855e9.0.2026.05.04.01.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 01:07:26 -0700 (PDT)
Message-ID: <600b025e-602e-4128-9679-f53f32b96e8e@redhat.com>
Date: Mon, 4 May 2026 10:07:25 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: intel_iommu unit test is also failing (was: Re: [PATCH
 kvm-unit-tests] realmode: load above stack)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20240604143507.1041901-1-pbonzini@redhat.com>
 <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
Content-Language: en-US
Cc: Peter Xu <peterx@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8aa24294-439f-4484-b6fc-9327b6fd0306@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/05/2026 09.58, Thomas Huth wrote:
> On 04/06/2024 16.35, Paolo Bonzini wrote:
>> The bottom 32K of memory are generally reserved for use by the BIOS;
>> for example, traditionally the boot loader is placed at 0x7C00 and
>> the stack grows below that address.
>>
>> It turns out that with some versions of clang, realmode.flat has
>> become big enough that it overlaps the stack used by the multiboot
>> option ROM loader.  The result is that a couple instructions are
>> overwritten.  Typically one or two tests fail and that's it...
>>
>> Move the code above the forbidden region, in real 90s style.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   x86/realmode.lds | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/x86/realmode.lds b/x86/realmode.lds
>> index 0ed3063b..e4782a98 100644
>> --- a/x86/realmode.lds
>> +++ b/x86/realmode.lds
>> @@ -1,6 +1,6 @@
>>   SECTIONS
>>   {
>> -    . = 16K;
>> +    . = 32K;
>>       stext = .;
>>       .text : { *(.init) *(.text) }
>>       . = ALIGN(4K);
> 
>   Hi Paolo!
> 
> FYI, the realmode kvm-unit-test now also fails with the recent version of 
> GCC 16 for the i386 target:
> 
>   https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14195195727
> 
> It was working fine some weeks ago with GCC 15.1:
> 
>   https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/13977260961
> 
> When I apply your patch, the problem seems to be gone again in this case, 
> but since there were some other issues with this (with older versions of 
> GCC, I think):
> 
> https://lore.kernel.org/kvm/49f8aadf-6e3f-4d2b-a32a-8ba941a3a2a1@redhat.com/
> 
> ... there must be a better way to fix it?
> 
> Could you please have a look?

By the way, the intel_iommu test now also suddenly started failing (for the 
x86_64 target), either due to update of GCC or due to the update from QEMU 
v10.2 to 11.0 :

  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/14195195728

Two weeks ago, it was still working fine:

  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/13977260962

  Thomas

