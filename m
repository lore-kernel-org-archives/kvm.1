Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D93B895A
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016676; cv=none; b=jc21wRF22yVGbZ1/zg9/ScOMzjbuhbVWbspDohfkSNUxe1wlM6QzxFVkAUEOxT8+pojHkV7DypCz9r6dLnpCeWKNkXhmgtTrrQO+Zn90aSHR5LuonzdaaesHC9W38xycqKIZWyMqFW9Kt8QWIZhrI37aAXKj2W4DLz7HnGL0VzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016676; c=relaxed/simple;
	bh=9MkiEZt6iiIjhQOga6zrNGcvzf8fiBJyYXSvErkmSSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mycpmnzIf/aVbk3EuKTyg6RQNuBCl9SUdo9Zv2ZM07GaouyGr/8Y9wOH5rbxoD5FYeNnoAx/qI9ezCIvadhLdE4dwgdihiERqMaLZzEIvODix8pUXRcTia34D6ndDfZSO1PN16fKiH75HDRVNp4jTljGEeH3yk1TuZif9SxONHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTHRPW/7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTHRPW/7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48538c5956bso18372845e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774016673; x=1774621473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fthiLTuf+I5jeGebor5z+DXDHTxh9yqgwY89zBw9Yfg=;
        b=bTHRPW/7JDytMXVPRw41o8/oLl1DyIRnDuxd3KCsX91CGPIH2/id2e0MAzlA+cfYEG
         XeopWfSxcS4q20QDnfHxx+2BOCFb84emfUVSDFvD8Hm0bkn+RwhRI9KqSWYJMiJFigE2
         +BKTmlApJPQ3OkJTzkSO1CJXNjqIKkt4lpFzOmn25d2qN3TfCJmp/LPLOu5z7RscI0tP
         qC9W1knGiOzHMqTwT05ZwHMUr7LwLqKXL+IhV6Bf+Xs1Iq+49eyp5dIn8ylAlY4ESxBu
         +ykF8v27o3Vjv6A1HyV4N3+7o0ADkixq3wbsFGrzbC3fpdNgtDLARB02Q2yns0r0rWCs
         P3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774016673; x=1774621473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fthiLTuf+I5jeGebor5z+DXDHTxh9yqgwY89zBw9Yfg=;
        b=lpaRCtg1qD9UBG/KPC8rdbzudCdkjJG7CJ4b7UA7YOlrP4HJgNmTN7Oreyw7nLz10g
         1nZaXIfP6N/FyPO2Bb7kurw4GJL/LNNJmzqVAKVkt55SSLyi2rEz+Uu+wpsIBFOtu4BK
         avmSfm/DhNYVchboYAuvWp5qHHi1G/sAw4jQexFBd6j5K+olzfe+bazQIwgPCE8Q4xha
         w7vQ+pAhWPEd27YAHNSBikv5bkwU+Cc3ykIRHALv3AqkcT2MyDpCxOfWRCmllPyLYdDd
         mdNEHbInCXuW2TLK0fYS+VK9ses5PIHd82zyQ3KcLPFJBFrysQXJexyvmXtB9PNgQrEj
         NnVA==
X-Forwarded-Encrypted: i=1; AJvYcCUNFJcSBld8hdIZe6Xkz9SCuzoAEvhqEAUtymxq7Ktv2BAKBCIqBXZri3Oxp1o8+YXkP/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirbPKijvqZB75+Dg1Waa2n0JL4fkHPyQrPknZ5s6I8ir5PXJI
	wPEILVCyAod9aHSP4+nGDAAlcyMVWd7Lsvahd/jgkhb6sBWkmGcn1Kun
X-Gm-Gg: ATEYQzzXjqn0xUy3KtPQisf44GRFdwvQ0cmnncHGuL5of6mQgqAswJeXVra/kQVXw06
	y4uCzyRP9Tv/9AH7Aw2a7Znh5LrtmQDrWpS8iYd/TrEkc+zYAJnEFOEsVGEYtvlUrdBA9wCwli0
	xFRoaTMb04J7X/3dc906V3JBXui3luIyXClij2RvAJ+kG/p5cYmEf7GiDdIBVl9DN6Ec8uadnQk
	C65fpUC4q1DEGnTMI5iC+fTDkOIc8My2ckpJt9Rt6kLy3li0wFUmU7QJvPTKneZJwkpS089nolV
	fY7IGqL6ZXVBLRFeG3G5UPugRbS78Komo+aDBz7yBdT2o5oZWiXFboVSJFF4Vqwzr6V2XU3/OXw
	hP3wHbgU2tioIjBKOb0w14/wWVyP6oenF79uGpjN0MLuQbyAX0aT1xloJDH3A4tL2e+SmpKzLta
	byfeQ6ZmS+B3mSVYPRVM8j6dJxmni62a+Sid1najDbKUzjuO9xLp5mfU/8trat8x8jYX/5I3Phc
	j30ZHrl5iqM
X-Received: by 2002:a05:600c:3b94:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-486fe8ef087mr56191865e9.12.1774016672928;
        Fri, 20 Mar 2026 07:24:32 -0700 (PDT)
Received: from [192.168.10.55] (host-87-27-45-215.business.telecomitalia.it. [87.27.45.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1dd9f1sm24913205e9.8.2026.03.20.07.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:24:32 -0700 (PDT)
Message-ID: <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
Date: Fri, 20 Mar 2026 15:25:01 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG
 support
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
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <87tsucvw3k.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <87tsucvw3k.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Il 19/03/26 13:31, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>> limiting development and testing to users with specialized server
>> hardware. This makes it hard to validate SEV guest behavior, like
>> OVMF boots or SEV-aware software, on common dev machines.
>> A solution to this is the emulation of SEV from the guest's
>> perspective using TCG.
>>
>> This change begins this process with the exposure of the SEV CPUID leaf.
>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>
>> case 0x8000001F:
>>     *eax = *ebx = *ecx = *edx = 0;
>>     if (sev_enabled()) {
>>         *eax = 0x2;
>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>     }
>>     break;
>>
>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>> to satisfy this check with minimal changes. In particular this allows
>> to bypass all the sev_enabled() checks for future features.
>>
>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>> a conditional confidential_guest_kvm_init() call during machine_init() to
>> set up emulated confidential support using the ConfidentialGuestSupport
>> structure.
>>
>> With this change it is possible to run a VM with the SEV CPUID active
>> adding:
>>
>>     -accel tcg \
>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>     -machine memory-encryption=sev0
>>
>> To the QEMU start arguments.
>>
>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index c653248f85..35cda819ec 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1057,6 +1057,19 @@
>>              '*handle': 'uint32',
>>              '*legacy-vm-type': 'OnOffAuto' } }
>>  
>> +##
>> +# @SevEmulatedProperties:
>> +#
>> +# Properties for sev-emulated objects.
>> +# This object functionally emulates AMD SEV hardware via TCG, so
>> +# it does not require real hardware to run.
> 
> Wrap the paragraph, please:
> 
>    # Properties for sev-emulated objects.  This object functionally
>    # emulates AMD SEV hardware via TCG, so it does not require real
>    # hardware to run.
> 

I'll do it.

>> +#
>> +# Since: 10.1.0
> 
> 11.0 right now, but realistically 11.1.
> 

I'll update it to 11.1.

>> +##
>> +{ 'struct': 'SevEmulatedProperties',
>> +  'base': 'SevGuestProperties',
>> +  'data': {}}
>> +
>>  ##
>>  # @SevSnpGuestProperties:
>>  #
>> @@ -1241,6 +1254,7 @@
>>      { 'name': 'secret_keyring',
>>        'if': 'CONFIG_SECRET_KEYRING' },
>>      'sev-guest',
>> +    'sev-emulated',
>>      'sev-snp-guest',
>>      'thread-context',
>>      's390-pv-guest',
> 
> Please insert before sev-guest to keep things more or less sorted.
> 

I'll do it, but I don't understand the convention. I'd organized them
by object derivation hierarchy, so what is the expected sorting order?

>> @@ -1318,6 +1332,7 @@
>>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>>                                        'if': 'CONFIG_SECRET_KEYRING' },
>>        'sev-guest':                  'SevGuestProperties',
>> +      'sev-emulated':               'SevEmulatedProperties',
> 
> Likewise.
> 

Yes.

>>        'sev-snp-guest':              'SevSnpGuestProperties',
>>        'tdx-guest':                  'TdxGuestProperties',
>>        'thread-context':             'ThreadContextProperties',
> 

Best regards,
Tommaso Califano
