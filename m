Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276643A6B77
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018970; cv=none; b=brsaGeHgehYXy/WKa9mkxy/PD+e7XqxjkCsdqrVZQ0BiFJTbLzP/wh2sf1AKLSiJMztWDgb0Omr9Tu5NIY6r4Kphz0YOJgeSqrUWHqgDdZqgnwXLwVII+ZrC25KbUVjaDROEGOZUgs7V1GY9o2uMYVOs/O1xeB4QTYgJxwmY+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018970; c=relaxed/simple;
	bh=vVXQNHFSK6tjoPkl3+TUu/oJYuRR1+zWAmlvDEGgECk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rr8zPJrqxwiohp/k8W5co9EKSR5rKxWYuX0RldP0vLg9c5RSSs+a5bKdJ7xN3EhjjA/enU5gLqskjL7PsfortrtpVzSEWxbpv1vyInwfsWRkNQqprc8Ys2Y/Go53Y0NjnqIXBv0vP3llrT6gWbBKhmRz4bm80qChmFzVVFkcPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUXWVmih; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUXWVmih"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso5817145e9.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774018967; x=1774623767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Zj3pqCGOJKAY2IYhlrVORUKcc3AyQX6JCd7bR8/pZ4=;
        b=nUXWVmihpJbKLY/mmF0OnX7HvxQY3TfhMTLLqEeDwTMfkjWPgAdtFT5bwYtTL5iBxE
         oPlT6DFRsBjZFY0bA2zz3/zUB241TZ5a1xsvWydly0sc0YtPMGGOex8SVyzCmUz0Kt1J
         a7X7R6mTsNrJp2jZgaB0pA4VKKvDFwZDi1O51s5jnEh++ztMj5wjxEmfts+PiTqv/H8+
         KKr+ERfLIKtrWsUOsp/FMWpQ0tw26D9TZACvIdJBM5Fv69extMe+DXv2urq+NSPPeBEq
         4lGkBM6VzG3cA3ROwNO5iKJzCVKYtG45ia86u88WXxOLusmXUX9ZA6juGgbC9MGSIT5Q
         GHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774018967; x=1774623767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zj3pqCGOJKAY2IYhlrVORUKcc3AyQX6JCd7bR8/pZ4=;
        b=hTYTyKE7cAxBHSl3S6q1nfmYOq5z3dWFDJCXnXt+xZDT6jCxU9S4orV/HBzQbyLtlb
         IE/KpUoUJjS2zIVVo43vY5ASqhuxuVW6KP9XX3BkAmjIoXCapWlhvT+950+tTq+k/UyX
         KfKIZOjJvwUIT3yb0DOwLH87YQ9i1ec3h5nPdc+ARhIsuxfyv17DvqCYEqEg6H0sY+IK
         jgLhmV1osX9KX2PYAtiFIK4IT6pGsmMaqRZCk9Y3U7DuFYYaajA92/URWoc7SROIExA7
         DS/sbPqjm0CcgwYEsIf8gV4Oagc1hjABghxWrldi4hdT1ANCpx+gJp8I3rfdIMCAqb0T
         ilbA==
X-Forwarded-Encrypted: i=1; AJvYcCVbtdOsG4IW5KoWPmyXIsdoj+khdNu8eBjgFe2mI35geyVUTJbsrV2iy0iobNfaXxEgho4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbVqLe6BdR/WFe1hfSW6bpL44RZfo3mOlyJnFiWNbySypna4d
	5ui/dfF72qFw9+Z7UhmeKKWd9z2P9gfOmye4qYarQ9lJ2K5grMU74QvS
X-Gm-Gg: ATEYQzzFcm0sBeJzsA8AEQaLLY8DLDJFKWUwibkmYRo2k17YMZWP+TUsFZbPEoOpXno
	+OtIYRlCwBwSaCsuDhAqkUB2rxDYuImOkDZDMrb4EQ4ESDXxWKKKmb3b9h/PfV7AnUTO3C+z4Eh
	jkNvTmJ4NgUFexsrNFrEEDDDnffX68HTwNpIIunxgRwTnpxkQ5O+14HV3yEs2D34OPSEff3hKdB
	iqmRIXPcM+VvuTb+n6ts+k+rdoL1tpMgMvZLFdD5L3I3WGiPmq5N/V5RMrh3v/f56+GL/biN4ZN
	5hCxo2Q5uWBc1QLd1WqW9sVeKEsK5nONOO988pVReP+46haQH53Oo8/tjaDcj09wfaoO0z33+Qb
	vcwKScdz9Szgc9RQl6vGev6dSEJKiFXOrTnf89HEnfUfJv08v7YC4dbgp2DEWfJosGEge/JJyAd
	D4hEwW2VMBSlfJJQ9WhdfXW0/zi6de7kMn3QGAZcBBU8Ul9v2tJPCtkbocom9cT+XC5LhSXqrMR
	UUDERJ8OTmQ
X-Received: by 2002:a05:600c:1d15:b0:485:2ce2:4c75 with SMTP id 5b1f17b1804b1-486febbc648mr48103335e9.1.1774018967289;
        Fri, 20 Mar 2026 08:02:47 -0700 (PDT)
Received: from [192.168.10.55] (host-87-27-45-215.business.telecomitalia.it. [87.27.45.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff109b95sm49229875e9.1.2026.03.20.08.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 08:02:46 -0700 (PDT)
Message-ID: <68682ef3-945f-41ef-814a-8c5bc77dab1c@gmail.com>
Date: Fri, 20 Mar 2026 16:03:16 +0100
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
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <ab1ABNvEOlIc2WCU@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Il 20/03/26 13:39, Daniel P. Berrangé ha scritto:
> On Thu, Mar 19, 2026 at 05:49:18PM +0000, Daniel P. Berrangé wrote:
>> On Tue, Mar 17, 2026 at 12:38:36PM +0100, Tommaso Califano wrote:
>>> With this change it is possible to run a VM with the SEV CPUID active
>>> adding:
>>>
>>>     -accel tcg \
>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>     -machine memory-encryption=sev0
>>
>> snip
>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c653248f85..35cda819ec 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -1057,6 +1057,19 @@
>>>              '*handle': 'uint32',
>>>              '*legacy-vm-type': 'OnOffAuto' } }
>>>  
>>> +##
>>> +# @SevEmulatedProperties:
>>> +#
>>> +# Properties for sev-emulated objects.
>>> +# This object functionally emulates AMD SEV hardware via TCG, so
>>> +# it does not require real hardware to run.
>>> +#
>>> +# Since: 10.1.0
>>> +##
>>> +{ 'struct': 'SevEmulatedProperties',
>>> +  'base': 'SevGuestProperties',
>>> +  'data': {}}
>>
>> This is deriving 'sev-emulated' from 'sev-guest' which means it
>> supports all the properties that 'sev-guest' does, which for
>> the record is:
>>
>>  sev-guest options:
>>   dh-cert-file=<string>  - guest owners DH certificate (encoded with base64)
>>   kernel-hashes=<bool>   - add kernel hashes to guest firmware for measured Linux boot
>>   legacy-vm-type=<OnOffAuto> - use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.
>>   session-file=<string>  - guest owners session parameters (encoded with base64)
>>   sev-device=<string>    - SEV device to use
> 
> Sigh, I was mislead by  '-object sev-guest,help' omitting
> information about anything that is not a class property.
> So there is also
> 
>   - cbitpos=<int>
>   - reduced-phys-bits=<int>
>   - handle=<int>
>   - policy=<int>
> 
>>
>>
>> Of those properties
>>
>>  * dh-cert-file + session-file are traditionally used
>>    as a means to transfer the TIK+TEK to the SEV firmware,
>>    with wrapping to protect them from the hypervisor.
>>
>>    These can't be used with sev-emulated, as implemented,
>>    since they require a key derivation  from the PDH, a
>>    concept which IIUC is not implemented in this series.
>>
>>    Instead, in a later patch 'tik' and 'tek' properties
>>    are added to 'sev-emulated', and to pass the TIK+TEK
>>    in clear text.
>>
>>  * sev-device + legacy-vm-type - these are only relevant
>>    to the KVM integration, so not applicable for emulation
>>
>>  * kernel-hashes - would be relevant if formally emulating
>>    LAUNCH_UPDATE_DATA for attestation, but IIUC, this is
>>    not done/used by this series
>>   
>>
>> IOW, we're deriving from 'sev-guest' but AFAICT none of
>> its properties are relevant to the emulation. The
>> dh-cert-file and session-file could potentially be
>> relevant if implementing the PDH concept and key
>> derivation, but that's not done, instead the tik/tek
>> are passed explicitly.
>>
>> What is the value we get from this sev-guest -> sev-emulated
>> inheritance ?  My gut feeling is that this perhaps isn't
>> the right way to be modelling things unless there's a plan
>> for future work that would benefit from them.
>>

I know most of these properties aren't used in emulation. I chose
to derive from `sev-guest' primarily for the policy property
(needed for SEV-ES future implementation).

For the TIK and TEK properties, I considered reusing dh-cert-file
and session-file, but since those keys are CPU-generated anyway,
I opted to simplify the cryptographic protocol given the fact
that security isn't the focus here.

That said, you're right that sev-guest inheritance may not add
much value. If you'd prefer interface consistency for testing
(reusing dh-cert-file/session-file) those properties could then
become relevant. Otherwise, for pure SEV emulation, deriving from
sev-common makes sense instead; though I'm unsure how that would
impact the SEV-ES implementation, perhaps we could re-add just the
policy property if needed.

>> Another question related to modelling is whether there is
>> an intention to support SEV-SNP at a later date, would that
>> imply a sev-snp-emulated object type too ? If so, would it
>> inherit from sev-emulated or from sev-snp-guest ?
>>

While I haven't studied it in depth, I think it will. It seems
best to derive a new object (sev-snp-emulated) from sev-guest-snp
because of the sev_snp_enabled() function, which will work through
TYPE_SEV_SNP_GUEST casting (similar to the current sev_enabled()
function).

Best regards,
Tommaso Califano

