Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8032572D
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017056; cv=none; b=EVPF5Sa+ZrELlMXG6Q1+QBxST5V6iv3gZS8jEMyCFKDdp8a7+vcb3lRNDLfUWMht7uRoia3s69f6ChAYSlOVQO18the0u6ohntgUj7Y8BK01NjkczUgBrPGKjoKEpoRc3OAAQDG3rbfrbdcT5zmpdl+u2NFhDwPreIzwD/CPfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017056; c=relaxed/simple;
	bh=RDsST/BktNabPpVzmXB7CIyrnMznJWjBL2tp4XSThHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ps2nbT56tQ5E9AJOOmUVzv9m3G3bI3cpPkZ8gr7neiDqbVL5bYMxQFoBK+tFATGmH6uTltAA71+jGroHGATmiftHUPr7bRh4SOX5CgkRlybORmKogNL7B9MpR9GuvpAQfZfzgOOBXtfKyQywt/r601sAvCXiPyBM+1zqh2vNgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzICxxY0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzICxxY0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso8018835e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774017052; x=1774621852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwkmTF/CS0VyDJVC1u/aIvu2tt3/nzhHfvzUfjsv28s=;
        b=EzICxxY0PKN2Vi1yjmfDObeeCtZRJfrgAxGPpmZ1b2pad9rfeO03tbQtyNoC3vvpVt
         tWXydSEzIhS4Ai2e7FcNpnuh2VvWiR1GMOEfzd/NS/rBWTEC+4XRteDb/bgKWqK+/Ruh
         AN1Tz2x/+WtZXRHwQZMsfoPUe08oImuipkAFmL3fKdgrGZb9EoXPzp4MdcsUnyx93NGB
         JadsnRykpW9wtBJN0+iKYVa/FFgz5Zx3cgyPqwERCOdQ9LqAso7dcgCK4CAAQjx5Cft2
         QjrHTcRwwIhRegl1SjugHD6FMFrZfaN17HI7GA0h/oqEUYQmYZgRn1B5BvrvU90YcY2m
         OuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017052; x=1774621852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwkmTF/CS0VyDJVC1u/aIvu2tt3/nzhHfvzUfjsv28s=;
        b=pzhmeGexnaRskk9TJE14+sBXW0RfgN/Zfkkh2SBZo7sv9p1OFS+cfiyv6BY6cFd1Os
         dWRAHq2JrYzThiIRzoKQF5WJpKD4nksBr/60pICzPLZAJ/jdnh2JX3R93RaOFMkz4W/C
         6dkTqtyYQ0egBLGPKWOrM1g6+1V8gvHQ8RMPOQBDdC8mJV3ElHjW9ItKyE2tEWmh5oEF
         4yMGjxXhd2HegnQ+LmEz0n5Y8QOqOle3hDy5CROxBj1HB7EjnPxHyY0Me8hCCB/2Kb+o
         tocr9DDe7++g5IlQddnNfEtsb4GNE8kyN1T+BPMrC+W7IJJCpDJbde4iEFVUeaWdye5a
         DgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaTrw4QYE2hMyyyECaCRBXAWS81Jo8ggiVWaEbtG8VTaKeTPjD6uJgxYPYsk5hjMeG/lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtum+KI2vBDrKR+jJWQKaOsSyvl7TEDrltFphkK5qtgLw9vDKg
	EurTr4X9JUmznqG2kHFwoU6TMq5zj5U4JUJkaBScba4wNqSmVuoDJi3j
X-Gm-Gg: ATEYQzx3nOLY8FMTecRV3FVxokDG4KDfAoBfsDlvJWdgo/LUhkS4FvwTO/nT8H+iV/a
	hlrr+OnqYoF3wJVhmoB9cWmnsRz+hx6fkfPrqnYrgOssbqZ8pQXReukQLMBRkwzJj30voYiB7jc
	/6PyPBX/8sBTemx3kBxYOZzLG6sS/DIWH4uPUp71AlcjqjVlfl1VZX0RLP936w1wUJsiMxWKqb6
	uf+rfqo4nwMIrsGI0eXottjCpbwMfkBOb1n+9GGnzmMI77ZiQsGlyFu9EmOm/L6E08yGsme6HMM
	mqS8bhkR0QO/gDfNXeRcHCKbQQU6be9yaHzdqpw/sygA3UDouruzJID8n9s1X262kSy79620nCf
	+NL9VPvJ7pLUtrrLRJFRO/0DJPR83S91BZT5ayMwV5HJa/o/SZZw+9gkfvK8XReaZtHTT4dCOZ1
	4Dh6e8kwVYqh3nLd4P9oGCyrT9tre75XCT/Y1bLOwwafwIEqHgU5fJgOQj
X-Received: by 2002:a05:6000:2010:b0:43b:4ec7:f924 with SMTP id ffacd0b85a97d-43b64264073mr5799774f8f.34.1774017052225;
        Fri, 20 Mar 2026 07:30:52 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c35sm7227678f8f.22.2026.03.20.07.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:30:51 -0700 (PDT)
Message-ID: <71a496c8-9fbc-467e-bd5c-a82142ba558b@gmail.com>
Date: Fri, 20 Mar 2026 15:31:21 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i386/sev: Add launch measurement emulation and TIK
 property
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-5-califano.tommaso@gmail.com>
 <87pl50vw14.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <87pl50vw14.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Il 19/03/26 13:33, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> The next step for completing the SEV launch emulation is to implement the
>> "query-sev-launch-measure" feature, responsible for returning the
>> measurement. In this case the measurement will be computed in QEMU.
>>
>> Implement sev_emulated_launch_get_measure() to emulate the LAUNCH_MEASURE
>> command per AMD SEV API spec section 6.5.1. It generates a random 16-byte
>> mnonce, computes the launch digest as SHA-256 over ld_data, then derives
>> the measurement via HMAC-SHA256
>> (TIK;0x04|| API version || build ID || policy || launch digest || mnonce).
>> The base64-encoded result (32-byte HMAC + 16-byte mnonce) populates
>> "query-sev-launch-measure" data, advancing state to LAUNCH_SECRET for
>> secret injection.
>>
>> The TIK is supplied via 16-byte binary file specified in new
>> SevEmulatedProperty "tik" path; absent this, keys default to zeroed.
>> Example QEMU arguments with the key passed:
>>
>> 	-cpu "EPYC-Milan" \
>> 	-accel tcg \
>> 	-object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1,\
>> 					tik=/path/to/tik.bin \
>> 	-machine memory-encryption=sev0
>>
>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>> ---
>>  qapi/qom.json     |   3 +-
>>  target/i386/sev.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 157 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 35cda819ec..affb5024b5 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1064,11 +1064,12 @@
>>  # This object functionally emulates AMD SEV hardware via TCG, so
>>  # it does not require real hardware to run.
>>  #
>> +# @tik: binary file of the SEV TIK (default: all 0).
> 
> Is this a file name?
> 

Yes, I'll specify it better writing "Path to the binary file..."

> Blank line here, please.
> 

I'll add it.

>>  # Since: 10.1.0
>>  ##
>>  { 'struct': 'SevEmulatedProperties',
>>    'base': 'SevGuestProperties',
>> -  'data': {}}
>> +  'data': {'*tik': 'str'}}
>>  
>>  ##
>>  # @SevSnpGuestProperties:
> 
> [...]
> 

Best regards,
Tommaso Califano
