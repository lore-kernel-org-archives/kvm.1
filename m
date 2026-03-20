Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE02F1FDB
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020703; cv=none; b=EqZ3zCz8byg+hNfp8A4iva/CJOye81C7Mo/yaDYOgXQvpl/uSPKnTv0i44+/7rVPyj+T8mn8Qv8pN3DG6n6Gpp8AxCpaTt6eoqnRtdnvOnUduruA6mOtjCDKF8mnZ1qHQ08CCGtdEozIQ8YroUkvCVcHrvG6to5SFFLxxtPtu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020703; c=relaxed/simple;
	bh=rCq7XVY+PmH5XJeSyfZYQhlvO+ZfOFkIeBUPE63g2kA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HA9skEWGIWgD6C0RxgjCn/lEUlbgOEdLAbnfwrgxoX5IkGfkQA3lSZ0ChEx2njM3AxjwItFEiHGSx0GH9XQn4yscYjvWuUUjcTf0Or/ub3bQjqCU8k7G90hj5MCyu5RlbPJSGnMvC9ihtHYkAuNjhG6uffPiA0BciRGHPC6oXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOGHM7Kf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOGHM7Kf"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so2229563f8f.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020700; x=1774625500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ciUNjB6LjluLW5sYgrhRg9Xhj16iAUsYEhwS7K8oIw=;
        b=FOGHM7KfJA9D5ut8KvNrfHlWduEAF/4ebENja1Izmx7ilOP/9ZINVgouWc+vgUxNme
         8KnwHiGTUB0QVOJJcqxOmD1dyFnF2XDzowqry34ZZ7m1+EUduXAHPdR6FiuFJmQogFD0
         Prbj9C1RyDtd/pIsyic4Av+Zn8JKfbZ50iziYjnvywJ6QFI5cN2b7xOxO9U46rG0Ia7+
         7ozT7rjAEFOcGXQhMmv94N3/34BIkWEWLwCDgJVQNtE/RS5MaOMrj6oaW1lheBRq6+A1
         YMg0GnhivKeVPJtykvbSxBsj26EN3omshyFXEw/dMKuy6h9k93H7lRbicam6SBpUI7zH
         aKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020700; x=1774625500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ciUNjB6LjluLW5sYgrhRg9Xhj16iAUsYEhwS7K8oIw=;
        b=Q4/FpialxnuVfq9wfGXbFuDbIPlMB/4ql37LggemKxqnXXzi325UfcOk8eiuVvcpU7
         BbCfHFlp5JOnk5Dad2EMKeVHoRLlH79CuByZZ7o7kAkOCSuXuoB4KkWvNlQppnDj0oeO
         Tvx6yOn9KycTKzEk4zIuoAqdxV7+A2y901aflLL+CY6kPnOSRNx4k80f1qbCJM7N9Xdg
         UbMfan0pMh7YNbIkehizCm3aXpWWIcBlPc5oAy36XyckE8KI4+igRe2YsP+m/1ojFGKL
         peVgp/SLfqMLpVYMpIbcSz7AXv0yZWu+nqBAJRaUdnM8eLXOa6cDv+I+Wi1rbUGIygmS
         J0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMR+d1xZlh8O11u8n7lyfb8xLzoxAod9zgjVx9E/dJALOvH8N6eB31dR+F3R97xQON/OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjRyKMSw841DHYcOp6fB+N6ib2ZAuNckvYWRokzGHlb54ke4AH
	IobSb8mk/3ZV5Im3xhWJxW0HtFWTOMikN399jseczrTzgopEge+gbOZz
X-Gm-Gg: ATEYQzxg2IFmCZQaq7FOkn/b5eUTYR/pCAqmodJhWyjKDwxum56mRZxdCpIb5lyU97s
	vjYaFSHEdXC3u5FwTDhBh0CZSn+EaDwsdX5DVjyFU6ax3A21D/5+vbPMQN7WVfWIyv2g0YgV6ZJ
	fgYxPF8fgA3moNDYmrK/lZKGmJucmd2TH999KXHuTxMHrChphvQyYQ4/Crh6Xjw1ensluibCz4W
	9BkK1w8tYct3kD1uj4J1h39NBp+s+H/b1/6NjB6+5ETKN4GAHSTZY7cDOVirARG1LaAD5pyWX+K
	2GMu1tMJ6I0tGrlBSPNxmZt57ckH8X09V4pxdxDuXlFK5t+d6fhdpClzSSeST3x3UqOEjuWM9+n
	jjXZcAWyosug4b6bGuxycnxN8p3++lqzd6DZR6KoiQl2wP3EhcH+Sw0GmBgN72p52Svq14qyVl5
	+3MkacssELJwzPlRHE+u0rHXm8fjc48Vs/N9Vp2CUuv7tH4k1BEk/ADzlc
X-Received: by 2002:a05:6000:701:b0:43b:4951:6b37 with SMTP id ffacd0b85a97d-43b577233cbmr13088055f8f.15.1774020699830;
        Fri, 20 Mar 2026 08:31:39 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm7678915f8f.16.2026.03.20.08.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 08:31:39 -0700 (PDT)
Message-ID: <cfc8f64b-f14d-4903-bfb8-a71bc1bbde80@gmail.com>
Date: Fri, 20 Mar 2026 16:32:08 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG
 support
From: Tommaso Califano <califano.tommaso@gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
 <20260317113840.33017-2-califano.tommaso@gmail.com>
 <abw3HqBJqEWiY7GP@redhat.com> <ab1ABNvEOlIc2WCU@redhat.com>
 <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Content-Language: en-US, it
In-Reply-To: <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Il 20/03/26 16:03, Tommaso Califano ha scritto:
> 
> 
> Il 20/03/26 13:39, Daniel P. Berrangé ha scritto:
>> On Thu, Mar 19, 2026 at 05:49:18PM +0000, Daniel P. Berrangé wrote:
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
>>>
>>>  sev-guest options:
>>>   dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
>>>   kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
>>>   legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
>>>   session-file=<string>  - guest owners session parameters (encoded with base64)
>>>   sev-device=<string>    - SEV device to use
>>
>> Sigh, I was mislead by  '-object sev-guest,help' omitting
>> information about anything that is not a class property.
>> So there is also
>>
>>   - cbitpos=<int>
>>   - reduced-phys-bits=<int>
>>   - handle=<int>
>>   - policy=<int>
>>
>>>
>>>
>>> Of those properties
>>>
>>>  * dh-cert-file + session-file are traditionally used
>>>    as a means to transfer the TIK+TEK to the SEV firmware,
>>>    with wrapping to protect them from the hypervisor.
>>>
>>>    These can't be used with sev-emulated, as implemented,
>>>    since they require a key derivation  from the PDH, a
>>>    concept which IIUC is not implemented in this series.
>>>
>>>    Instead, in a later patch 'tik' and 'tek' properties
>>>    are added to 'sev-emulated', and to pass the TIK+TEK
>>>    in clear text.
>>>
>>>  * sev-device + legacy-vm-type - these are only relevant
>>>    to the KVM integration, so not applicable for emulation
>>>
>>>  * kernel-hashes - would be relevant if formally emulating
>>>    LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
>>>    not done/used by this series

LAUNCH_UPDATE_DATA is supported in the sense that the called
memory regions are saved for measurement calculation. With this
method, even if kernel-hashes is active, the measurement remains
correct and the attestation workflow stays the same.

Thinking of it now, I could add a small improvement by checking
if the memory region is already in the QEMUIOVector ld_data,
avoiding multiple addition of the same region.

>>>   
>>>
>>> IOW, we're deriving from 'sev-guest' but AFAICT none of
>>> its properties are relevant to the emulation. The
>>> dh-cert-file and session-file could potentially be
>>> relevant if implementing the PDH concept and key
>>> derivation, but that's not done, instead the tik/tek
>>> are passed explicitly.
>>>
>>> What is the value we get from this sev-guest -> sev-emulated
>>> inheritance ?  My gut feeling is that this perhaps isn't
>>> the right way to be modelling things unless there's a plan
>>> for future work that would benefit from them.
>>>
> 
> I know most of these properties aren't used in emulation. I chose
> to derive from `sev-guest' primarily for the policy property
> (needed for SEV-ES future implementation).
> 
> For the TIK and TEK properties, I considered reusing dh-cert-file
> and session-file, but since those keys are CPU-generated anyway,
> I opted to simplify the cryptographic protocol given the fact
> that security isn't the focus here.
> 
> That said, you're right that sev-guest inheritance may not add
> much value. If you'd prefer interface consistency for testing
> (reusing dh-cert-file/session-file) those properties could then
> become relevant. Otherwise, for pure SEV emulation, deriving from
> sev-common makes sense instead; though I'm unsure how that would
> impact the SEV-ES implementation, perhaps we could re-add just the
> policy property if needed.
> 
>>> Another question related to modelling is whether there is
>>> an intention to support SEV-SNP at a later date, would that
>>> imply a sev-snp-emulated object type too ? If so, would it
>>> inherit from sev-emulated or from sev-snp-guest ?
>>>
> 
> While I haven't studied it in depth, I think it will. It seems
> best to derive a new object (sev-snp-emulated) from sev-guest-snp
> because of the sev_snp_enabled() function, which will work through
> TYPE_SEV_SNP_GUEST casting (similar to the current sev_enabled()
> function).
> 

Apologies for the multiple emails; I forgot to explain the kernel-hashes
implementation.

Best regards,
Tommaso Califano

