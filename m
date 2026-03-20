Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6A283FDD
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020172; cv=none; b=g27nYQm5EmxiPU7iCfI4GeXrdAT3IHApXKgljrtrVdQRJ+rxteq5e/8cxXHbDUeBxAh6vG5Nauoh0UzsagCoBX+YBB352HCLcBpYEv/y4W0kx8M9XSxYU2N7ScMX5MWJbHSm0adElb7Cl6RnEOAxPfixi5Xq7Oi7sfxtUdgvdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020172; c=relaxed/simple;
	bh=7LKaTdRCQb7+t4WRbG5sX4sdcaLKieZ3HxHBVTrGEcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5xGHZVv2yGaYx6cSp3olU5nRQIzbE+QtrsIh9ipJZ+1vDuqprKN0ghlHr/ZanRxnjw4iUjTL1pLCfGEOamTu3VDDtZxvheiPoT02ZFHMkeaXpheVZk74uygZPP/OWT2c6cAhIj5nKEW7N2eJbqs6wlr4bV8g69NAXRu7daC8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeFuSmLC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeFuSmLC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso17210805e9.3
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020170; x=1774624970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZLBiGzqpjQCsZMr+SMhn+yTqMt/Kd2sugURDgwEUZA=;
        b=VeFuSmLCDOIiWa19m20NEm8FsdPXeMfU9d/zhaKAjPOBMZQQYhEpISFwo4Fdn0asYJ
         qvQDutkQqMWV9HWWuGbgKVrrtPJ6ytgnMgp0vvPtDcBSrPsgb3eWDM0uYyFiICU+638l
         kkV5vc6jN1FUmFQm/aaBu6xm9xKba/MEpkVNmCrCOqE3u9C2JfDCNjNKTqtJMS4rOqSy
         b12PkZ5mWH5ClDi73KV1xKaxgEKftKqYDC80nZNEBWBPNqnkVIsRPot5XEaas9Tpm0AC
         RtMb8/+4HRBwLq0FyOkY33F84BPwU4k8NYakEy1QJ0nCpKfcFC+Aa4+j12JEaAzPd9WW
         0GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020170; x=1774624970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZLBiGzqpjQCsZMr+SMhn+yTqMt/Kd2sugURDgwEUZA=;
        b=S1tGXsRTGykh/7UqUYyWOyp2jIN7uFiMh8nHTbA02cnJm2xgRrYYnhYdDhOx2ITmUB
         t8NRL3mSnoiZhomUyKVTFEJzc195Mnq+P+BhXuRk46rgLbRZ+ft8SOCkCsqQTxD8Eczy
         9PXeiZU+DtCAQq7F/nhLdPwIUzDOqX47Ts4lMSnMzMCA6OUk0wuN7NHv+/Wf21r9vu3l
         yaG9jIxzhA6tSxsbdZiBeGgCW6w13UEn3TEv2oDn9ze/1EdEGmMBj5LM/3pdfcWFxeW+
         9hWnvRGZg75WBUlybviBsUz6Tm5OPizhK82fPU2jt5I+ADsHwJgCSuPgqxAtHAUXve7k
         19/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6oh66aijwHQr6b9koZCovi8MwNXY7yI4U5SYcsPf6pwjd5NpoizIu11aFWPOMSsjguds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYa0xWRdCUHklRIq8+5WBn2c/ixx9rwhSVxxg/Z6VrHFUsrBsD
	wA49/SuWpwP31z8SL5kd1f70mtOhLuffFn2UzB2TtS9H4ZdMzzU6pt2j
X-Gm-Gg: ATEYQzyldFesgaVNH/WR+Q7k9tWGXyndCJmKktabvSPUq7QI6TUDCosSG4U0oZF3qzY
	phjO1QlXV47mImCXgLzIJtTSFt1ufrFHWE/opG0D4HyGvbJMS9+YdsYIYM049+PJrgk1Xg4Bn5i
	gYxzdYR6NCWcBBFXlPLka3j8G8IWnLqm4yyPMW6NlC13T5zRAzHA6/aEnJg0h3XwOxk5IrxeaFy
	YirBxirRJ08GiZJlF+NFhpwgWlD5gnJ62MlXY2rNDa7jegILh955w7WQJP/f2GeK+B4S5sVt8oG
	3lZbGKrhD+PZ54upMm18xsEZc9nMpdpPsCdoPbrXsMZe7+3c6wLwBurTAFD1DzLpRdmkjdUGarK
	dDTr256fS8BU24mQjxHsFAT4+QYwLIYrYqVWriHICgJbeLvnXxe1/MRSG+EzNT7HT+mqibBSXSv
	zfn8qKTXthg8JN7++/aIGycJrVqzH2zk8bE5+CI6sVyy48Nq46SpR2iD8f
X-Received: by 2002:a05:600c:608e:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-486febb58a9mr48327525e9.1.1774020169408;
        Fri, 20 Mar 2026 08:22:49 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm80456805e9.2.2026.03.20.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 08:22:48 -0700 (PDT)
Message-ID: <b6149c81-73a2-4f3f-8083-8fe2613110e1@gmail.com>
Date: Fri, 20 Mar 2026 16:23:18 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG
 support
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <87eclfj66v.fsf@pond.sub.org>
 <ab1ALDdqxwSWxPOx@redhat.com>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <ab1ALDdqxwSWxPOx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Il 20/03/26 13:40, Daniel P. Berrangé ha scritto:
> On Fri, Mar 20, 2026 at 08:44:40AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>>>> With this change it is possible to run a VM with the SEV CPUID active
>>>> adding:
>>>>
>>>>     -accel tcg \
>>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>>     -machine memory-encryption=sev0
>>>
>>> snip
>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index c653248f85..35cda819ec 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -1057,6 +1057,19 @@
>>>>              '*handle': 'uint32',
>>>>              '*legacy-vm-type': 'OnOffAuto' } }
>>>>  
>>>> +##
>>>> +# @SevEmulatedProperties:
>>>> +#
>>>> +# Properties for sev-emulated objects.
>>>> +# This object functionally emulates AMD SEV hardware via TCG, so
>>>> +# it does not require real hardware to run.
>>>> +#
>>>> +# Since: 10.1.0
>>>> +##
>>>> +{ 'struct': 'SevEmulatedProperties',
>>>> +  'base': 'SevGuestProperties',
>>>> +  'data': {}}
>>>
>>> This is deriving 'sev-emulated' from 'sev-guest' which means it
>>> supports all the properties that 'sev-guest' does, which for
>>> the record is:
>>
>> Uh, I somehow misread the base as SevCommonProperties!  Had I read
>> correctly, I would've had similar questions.
> 
> Even SevCommonProperties has stuff that's irrelevant for
> emulation that I mentioned.
> 

Maybe I'm missing something, but the only sev-common property not being
used is `sev-device`, since "/dev/sev" doesn't exist in the emulated context.

That said, all other properties are functional:
  - cbitpos=<int>
  - reduced-phys-bits=<int>
  - kernel-hashes=<bool>

Additionally, deriving from sev-common ensures the TYPE_SEV_COMMON type
for the sev_enabled() cast.

So I think deriving from sev-common is beneficial.


Best regards,
Tommaso Califano
