Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD22C235E
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020826; cv=none; b=XOcEtFveovJdYZZZjzk2tpizpnyJ3x0us0KVAE6FxQj6cmpHJVefrfVkcKK1Pj1vRjo52qBgMK1b5tKs8dlTTPe+FA4YlrmjW2RwVhTUR35w93Ohui98l+DjyHt//EdMmb4fQ76EwvOC/bpgpGX0QKmALhpqNaLpHmDffTJUWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020826; c=relaxed/simple;
	bh=t9iw7T85VHcAK0ethlGe7Sy9BR0i3738fi9NS1LnJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvmO6eRmHm9JDJjFbx+XC0g9oAqIposHGGDNrxRxjfLI9BJtwXxWjwcrp6gqBXuUADx3J34m78OSEJ+KKHImAnw8nlce3QghwLJ7Qok1yUkHaFAkMcy34K5bOQNiPuRYgDQX4HIJcNpwWWsLS0w3QNyyJ+bMzo5JNXuJ1e7V77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO8xoa/j; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO8xoa/j"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so20532905e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774020823; x=1774625623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7q5uU/FGHIAi3WQ08qV264szit3ZXeqzJkWmXhZxZI=;
        b=kO8xoa/jBxd+VjNBEkVNKbUCXgFDKVTKmpjBLw/Uoqa1yxwDxY3O2Pme++zaXVCsUW
         iOon2K4kWFLW8o5LXwL7iashEqcoX/4hAXMiaScXFg72317EvMMIFNjyGe5JNkzd6sCO
         y8H8rh6VkAEc3eNHpzb5yepxlRG4jbiByZRtmsZ78N5jLEkA9Auo6OkmJnvW6lxyPieO
         PCtnGVLrxGkIZb8o0cH2HDabLENWQdMjgQUFbHp1MgfURETdF7ANBsgYCBiz2rNWYFDC
         OvusP6830qWKCfeylx1WlqRs5sh5ufZx5VSLqZiZG+qQyj4VwstmG8fI86+dtLQ0Yfux
         df6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020823; x=1774625623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7q5uU/FGHIAi3WQ08qV264szit3ZXeqzJkWmXhZxZI=;
        b=b10PKgg3CclJs3pP+fPnJayFoJfGShhBZy9tXl28LhhHrXs1cKY9xkc7QK8qCWi9gG
         YypWp70CVFaap+hyaM3Y/G3sq+aMThynJ0UlabzXC0kcuM4lr+huFg0B6cWCd7szoF+1
         wQcd29gsbSi6ZQdPgbfFg5wSYbSp4H9Rqr/C/NXh8JLdbGUPn1EIiQffq0NLkBLBLVuk
         VOVzf+Ftw9DoRO7cGlZ6ml3jRwfqbsyJmEUiZTDikvNsK2rlxSjv/h5i6rzhI1ZTIq9V
         yUvTEunJUFVhRPwA4Hry/zRkYM/EjwM1T+3YlML8DIiDZn1qy1KCoziTmsOr0B330NJT
         Ugxg==
X-Forwarded-Encrypted: i=1; AJvYcCUCZoBDuvG/rgBsmyCyk+pARNSxjIhE3pveVCn2gMyV8Ck551WWh1YDy8iyyYKFt8TMyL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlczVBKOhonfnJ+Z8O1fCfqFLq5eh5lMaN1LEQpyQt8yFgrH/E
	WI/dt4rMRZYrDBO1FiOkl9wsrQAtlGg2ZF3dQafXUEpPSHZcNrVgkjda
X-Gm-Gg: ATEYQzzFoD1A/PIcRB3XiU121fUcAqKlr++ZY44GjLaV5BuGhvA13pJ81TH9nJbZay0
	fjBXYJmFbXxW2//ZkDCUhMbappm/XK57VYFFSG81o7VfDK2bcT4VF2tZJBKBYf1w7aAwfFZeN1h
	gBaDd1BF5nEMKqbzlcuLPVlqRWDHD2bwKg+nxmZSz6ql67tSanVgWdEvqVclqfVRI7qUM5zMnpH
	CFdXB9qnO4h1mLfRfg2xYu8EBdigcZpEs5e6TF8PjO6Tzk3WXmPy4UBj2OLLlxbOGOZhVXBQH0P
	F01zUqMWJH/o+E7tVUgZD0gxjb7jPDaLRUBvuPHlpwbYlB3HjUYJUYv2VXHr5fudyuQwRrRe+yd
	g3/7SEv70E+NZSQ4HovGcO4Qa0aWxfrTviis+0ZqlbG23qG6TVPvQidCsh9RPzzL8fUPwL04C69
	YLhw4Bem9BzScewIWomABHtTN8S+Vl/pbF1iIsWWL+s4zPGiEFeTPT2HOK
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id 5b1f17b1804b1-486fedb2545mr60168225e9.11.1774020822818;
        Fri, 20 Mar 2026 08:33:42 -0700 (PDT)
Received: from [192.168.10.55] (77-32-38-61.dyn.eolo.it. [77.32.38.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470393fsm7801957f8f.17.2026.03.20.08.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 08:33:42 -0700 (PDT)
Message-ID: <462f2df0-06ca-4ca0-90cc-aa14ac2d0f83@gmail.com>
Date: Fri, 20 Mar 2026 16:34:11 +0100
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
 <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
 <878qbm4kw9.fsf@pond.sub.org>
Content-Language: en-US, it
From: Tommaso Califano <califano.tommaso@gmail.com>
In-Reply-To: <878qbm4kw9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Il 20/03/26 15:48, Markus Armbruster ha scritto:
> Tommaso Califano <califano.tommaso@gmail.com> writes:
> 
>> Il 19/03/26 13:31, Markus Armbruster ha scritto:
>>> Tommaso Califano <califano.tommaso@gmail.com> writes:
>>>
>>>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>>>> limiting development and testing to users with specialized server
>>>> hardware. This makes it hard to validate SEV guest behavior, like
>>>> OVMF boots or SEV-aware software, on common dev machines.
>>>> A solution to this is the emulation of SEV from the guest's
>>>> perspective using TCG.
>>>>
>>>> This change begins this process with the exposure of the SEV CPUID leaf.
>>>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>>>
>>>> case 0x8000001F:
>>>>     *eax = *ebx = *ecx = *edx = 0;
>>>>     if (sev_enabled()) {
>>>>         *eax = 0x2;
>>>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>>>     }
>>>>     break;
>>>>
>>>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>>>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>>>> to satisfy this check with minimal changes. In particular this allows
>>>> to bypass all the sev_enabled() checks for future features.
>>>>
>>>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>>>> a conditional confidential_guest_kvm_init() call during machine_init() to
>>>> set up emulated confidential support using the ConfidentialGuestSupport
>>>> structure.
>>>>
>>>> With this change it is possible to run a VM with the SEV CPUID active
>>>> adding:
>>>>
>>>>     -accel tcg \
>>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>>     -machine memory-encryption=sev0
>>>>
>>>> To the QEMU start arguments.
>>>>
>>>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>>>
>>> [...]
>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index c653248f85..35cda819ec 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
> 
> [...]
> 
>>>> @@ -1241,6 +1254,7 @@
>>>>      { 'name': 'secret_keyring',
>>>>        'if': 'CONFIG_SECRET_KEYRING' },
>>>>      'sev-guest',
>>>> +    'sev-emulated',
>>>>      'sev-snp-guest',
>>>>      'thread-context',
>>>>      's390-pv-guest',
>>>
>>> Please insert before sev-guest to keep things more or less sorted.
>>>
>>
>> I'll do it, but I don't understand the convention. I'd organized them
>> by object derivation hierarchy, so what is the expected sorting order?
> 
> It looks alphabetical modulo lazy mistakes to me.
> 
> [...]
> 

Thanks for the clarification.

Best regards,
Tommaso Califano
