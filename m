Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920223AFAE0
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334194; cv=none; b=h9z2jdklrEP27BMCJJgRRyWuMSExoksSmxK9NOMZ8smmvARI1zMTWp7m7c22cIZU7j1ux95EsVMTzo5tMj4HTRlLJGW2kOE/0oDeMcYj0RZ+LyN7eO3fAh1v6yGBgRHlO5Q60+6PEZnf2LuAWk2f+ylyNRI73qPzlHpfNWGVa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334194; c=relaxed/simple;
	bh=LD7oa8KcPyioel+yK0Sc3NUetJQ669OlzxoAINfKN7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC0LrCerCfshOqHbKWX86a0W3g10aL7d0MYM8hieUbIZkerQt++n34TicEPpag8a+xZyv1PHxybrJlb5dwB9rKmuBIa/TyYmeE97R5yJJzS8YH5RIitdTH+kIsnAp9fWL7eEFv6HlOdnQJIJH3UTWAloXq0glhBK3/q97gEgD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yp7I/guc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYe9YiZ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp7I/guc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYe9YiZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
	b=Yp7I/gucx4Un8aolgmbKt33vUFhSK725/Xf+FNdQZRNpLgxlRmrHW1hiA0Vn3HS278H94R
	b+3tvTrc5OYwGJZeV/rxhAhxxV0Prqbth7bAMu1KmU6Ex3JL0/GunjTdDFdsAetUNa94wf
	238fpdZfH5OanA/ZEu0j3/pU+ez8X9c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-29ScO5CmN1ynb4St4AZR-g-1; Mon, 06 Jul 2026 06:36:30 -0400
X-MC-Unique: 29ScO5CmN1ynb4St4AZR-g-1
X-Mimecast-MFC-AGG-ID: 29ScO5CmN1ynb4St4AZR-g_1783334189
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bab443f7so27036225e9.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783334189; x=1783938989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
        b=gYe9YiZ8oOOZUUbpq7LRkcdqKuLAdzo05etYZu31EVtbMhfK5/GGHnM7QjcJjA2wt/
         OVDoxFt8NgO7EHVruDruytL37ISQWwwSPKyBouWkiqCYpoeVLsu8hi5lXKjzSU+yKw9k
         2Dc+lSUJ3tGpknF+5i3pjIwNmy+NDgomEZL/OgWNBtvLCr+L8lrFPwUQ9zKpYKloiER2
         FkjCsjeTbNPi0iZHo4WWruYNe9Ra9ZKKUsVWEVjKLXu1i8uu+ET1hMrYcn4b1Jo5MRDy
         GD9xGZd+KWJDeyGNEvZ3UmhbU2YJ4pQnUYTJh2cBeIJMII+Kvsx4a9ajVWK3FPY/GcPx
         4FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334189; x=1783938989;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZM4BdMWctJFr4MFciEjlpk6HoaW3JAEbYuXYIcyn7U=;
        b=Kl/dnb8atLPBaVSZ8b9uOOB+ZdBHWCYlEKHgBnaDBS1RNHKSvNwHmRjTKoJh0rdhW2
         AIkO7Kumldrq1qDiE0TTOrB8UR7wPSdmJ+hMdyEJqmarvggCr1ZC7eEY2g2Px6XYHZb/
         WVgAUzOFwFb6VRcOTUb7co9pCex8xHlUa3LChG1GpAHmvNLjtGD27McKUg/3lZWDGcYH
         76wQlVMeY6RjWQAdG4ftVZ5ZWACoNn5apsN6Pj6pf8k8i7w9/SY/NsQQQpurC3qtZDDk
         0Bxm8pWUjYOs7w6nTfAbIunbesVmBwtDmShumKZC8RSiOdF+k8r8M3ry2pSxgeYw28WL
         GfeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/KA54Mq9LF0AXtUY8iQ+jQP/ekJ5RKf7GtjcZ7xfNqmIeS90n+fjZ3rhmr7Xx2kmfNEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFU5zFdqkwikNZte+RLtR3DSk0gDA74r2F6+wZe9ZE1bPxZrhv
	LrOuZ1T7UUBAUNq977VhKo++W2ivVtLF/MaU7yhsHZGicQN7nIHHyNgENT4ExHbXmmmBNueR2dP
	dROjrOmjztZJ4Fmk5V/kLb67ZIOBf62Hy76Re8TcAl3nZnqAw0eBHIg==
X-Gm-Gg: AfdE7cm5HNa3pX/Ajyk4tGidw6BT21TRfANR1WXMSUQckls+id3J1Kg8hzGDYu56JH+
	/QjNXtlkZAWhGxws2ZI/YUo37TBBF96A0VOSsSE/84v0gAWSjiTOo2H+w/aHHIjO16TFM4aFDC4
	2PqSlbH2VExMKa7YAlkuLbIWWa9LZ9kUHA75LmlDhGe8+y72WynlraWuDYIWyr0o7PCITAyEKDZ
	P+eSPvkjEak97Hv/Rrlmsb/vu5dry7phnXXBEgyBA/kxxXfWTJqxw1wZOZFVJytPTA1PWeuPi4q
	5CvrVHg+60Alg1pG5xEe+qgq8UXepNYtfmAXZSTfSk1NT9myYdedwqTAJNgeLz7ULHjSMI+RRdw
	6TynNt1PYECl3fkG0dE6UE3tVa5dOOJsuPv173i7DBDd67y1C/lFo
X-Received: by 2002:a05:600c:8717:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493decb3633mr1233125e9.4.1783334189180;
        Mon, 06 Jul 2026 03:36:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8717:b0:493:c991:8e56 with SMTP id 5b1f17b1804b1-493decb3633mr1232715e9.4.1783334188773;
        Mon, 06 Jul 2026 03:36:28 -0700 (PDT)
Received: from ?IPV6:2a01:599:b25:5a4f:915f:c838:d9f4:60ca? ([2a01:599:b25:5a4f:915f:c838:d9f4:60ca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef23feasm331060155e9.2.2026.07.06.03.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:36:27 -0700 (PDT)
Message-ID: <6e29ac41-383a-416c-bca4-c3d4349beda0@redhat.com>
Date: Mon, 6 Jul 2026 12:36:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests RFC PATCH 2/6] configure: Make arch_libdir a
 first-class entity
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, andrew.jones@linux.dev,
 sbhat@linux.ibm.com
References: <20260602064806.3101025-1-rathc@linux.ibm.com>
 <20260602064806.3101025-3-rathc@linux.ibm.com>
 <7d9e6365-1b2d-4b18-8fb5-d8048fddb7f0@redhat.com>
 <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <efbbe11b-9e02-4878-b61a-f804b491ab4c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/07/2026 08.46, Chinmay Rath wrote:
> 
> On 6/10/26 17:00, Thomas Huth wrote:
>> On 02/06/2026 08.48, Chinmay Rath wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> arch_libdir was brought in to improve the heuristic determination of
>>> the lib/ directory based on arch and testdir names, but it did not
>>> entirely clean that mess up.
>>>
>>> Remove the arch_libdir->arch->testdir heuristic and just require
>>> everybody sets arch_libdir correctly. Fail if the lib/arch or
>>> lib/arch/asm directories can not be found.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>> ---
>>>   Makefile  |  2 +-
>>>   configure | 20 ++++++++++++--------
>>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>
>> FYI, this patch seems to trigger yet another issue with Clang (I used v21):
>>
>> clang -no-integrated-as -std=gnu99 -ffreestanding -O2 -msoft-float -mno- 
>> altivec  -I /root/kvm-unit-tests/lib -I /root/kvm-unit-tests/lib/libfdt -I 
>> lib -Wa,-mregnames -fverbose-asm -S -o lib/powerpc/asm-offsets.s lib/ 
>> powerpc/asm-offsets.c
>> lib/powerpc/asm-offsets.c:10:10: error: 'asm/smp.h' file not found with 
>> <angled> include; use
>>       "quotes" instead
>>    10 | #include <asm/smp.h>
>>       |          ^~~~~~~~~~~
>>       |          "asm/smp.h"
>> In file included from lib/powerpc/asm-offsets.c:10:
>> lib/powerpc/asm/smp.h:5:10: fatal error: 'asm/processor.h' file not found
>>     5 | #include <asm/processor.h>
>>       |          ^~~~~~~~~~~~~~~~~
>> 2 errors generated.
>>
>> Could you please have a look?
> 
> Hi Thomas, back from traveling and looked into this.
> I am using Clang v21 as well :
> # clang --version
> clang version 21.1.8 (Fedora 21.1.8-4.fc43)
> Target: ppc64le-redhat-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> Configuration file: /etc/clang/ppc64le-redhat-linux-gnu-clang.cfg
> 
> I see the above file, asm-offsets.s being generated properly without any 
> error during the make process (used the extra flags for make that I have 
> mentioned in my other reply).
> Snippet from make :
> cat powerpc/boot_rom.bin.tmp >> powerpc/boot_rom.bin
> rm -f powerpc/boot_rom.bin.tmp
> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 -msoft- 
> float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I /root/chins/ 
> git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -fverbose-asm -S -o lib/ 
> powerpc/asm-offsets.s /root/chins/git/kvm-unit-tests/lib/powerpc/asm-offsets.c
> (set -e; echo "#ifndef __ASM_OFFSETS_H__"; echo "#define __ASM_OFFSETS_H__"; 
> echo "/*"; echo " * Generated file. DO NOT MODIFY."; echo " *"; echo " */"; 
> echo ""; sed -ne  's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/ 
> {s:->#\(.*\):/* \1 */:; s:^->\([^ ]*\) [\$#]*\([-0-9]*\) \(.*\):#define \1 
> \2 /* \3 */:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; 
> s:->::; p;}' lib/powerpc/asm-offsets.s; echo ""; echo "#endif" ) > lib/ 
> powerpc/asm-offsets.h
> cp -f lib/powerpc/asm-offsets.h lib/generated/
> clang -no-integrated-as -Wa,-mpower10 -std=gnu99 -ffreestanding -O2 -msoft- 
> float -mno-altivec  -I /root/chins/git/kvm-unit-tests/lib -I /root/chins/ 
> git/kvm-unit-tests/lib/libfdt -I lib -Wa,-mregnames -g -MMD -MP -MF 
> powerpc/.selftest.d -fno-strict-aliasing -fno-common -Wall -Wwrite-strings - 
> Wempty-body -Wuninitialized -Wignored-qualifiers -Wno-missing-braces -Werror 
> -fomit-frame-pointer  -fno-stack-protector   -Wno-frame-address  -fno-pic    
> -Wunused-but-set-parameter -Wno-override-init  -Wmissing-prototypes - 
> Wstrict-prototypes -mlittle-endian   -c -o powerpc/selftest.o /root/chins/ 
> git/kvm-unit-tests/powerpc/selftest.c
> 
> Infact, if I just execute that single command independently to build asm- 
> offsets.s, it works as well.

Ok, I finally got access to a POWER system again and tried to reproduce the 
issue, but I also cannot reproduce it anymore. No clue how I managed to get 
into that situation, but looks like it was rather due to a messed up build 
tree than due to your patch. So sorry for the trouble, and please go ahead 
and simply ignore my objection here.

  Thanks,
   Thomas


