Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AE2D59FA
	for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501262; cv=none; b=PLaYb4HVtvgu34Wu9ePF//9Ll+h+q6VxkG/LeJZU9Wqglyli8p9Xg9zImhdrHSr6v/xLWwHKbhdSGWan0bwcFrzCNj5czI41NDrlVQQFq5IdWg4I6qJ4u9wJBFtYhI/zoFzWBFkjnKzfcGYLCB+ZImK2e17aIjS527N847q/iig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501262; c=relaxed/simple;
	bh=WdNuhJSpiIw59uhPoGbadmoYFLeXmSTxOjMeFk22WgA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gOKllz65+qg7RYIKEkUZxXm0OvdHlibXEOQEqMbmC31bEqJSjAl2AEfhPai9DGQmPionRXT15PD/48L0woE9a94saQgnigXtv0DOQXevjYfD0SwDqrmD4hdOZipZF2PE+ajd8KhUuq79GC97bRKJbKq44RIkvPW9jWaN/wO5uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgKK4QDw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgKK4QDw"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso17993645e9.0
        for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771501259; x=1772106059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qi1xpuyJZOkDGlLVuM/nWid1PLrL4DAHlmIcNqS0vKg=;
        b=fgKK4QDwDQDWZWg8pBYeJbAeiEx0B1Jo/KtD2T1AfzzlqoZ5pnyGAi+x7fDhvR88mZ
         wKhE9oZdw7zBWtHBzbCF3NU5509cxD++OKxeGbp4ThV+Qsuz+3uT/YiZNxbFsnADkJlX
         nWZ5Em4INnIafn3K5nwyBEYuIDjVv40cdfsrsoj+WnjuRRCc9Iw4EisbStsWrNosPE42
         y4MHz/tfBJ7d3S7awEtXKh9NLX7IHuW4d4lQwBEkXOe1CJJyFx1qdjFroQ61M4S8gQ8Z
         ozshT2YpRyjqA4AHFixuJyUKXrR1etXyh/QmftiiTpe3J/btaIzY6bOsCxwZcEMQ3IpQ
         DkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771501259; x=1772106059;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi1xpuyJZOkDGlLVuM/nWid1PLrL4DAHlmIcNqS0vKg=;
        b=w+tssO99L7jTLFpFvhjThvU2glESrPCzcAUsnIpCUlnHYDrZDZtpYzsRETOINMGp7k
         Lhl26n5KZq7oCZBjYxCYsgkD5zID/ZDUuvNElXAtKMFVHr+N255Zq+Me36vZqnWxz8ul
         Ww/ZbpjT/oUJQkGmZVeD+P1rmWfWkqYYOfJ960i0xgjXZjzjswELj2c70MPVGf7CcR19
         095q3hv4dKnS449oM96gxtDdWOvIK498Ejggos7gkk4qtZcKcz74l8eWa88ZwJN2rv9w
         6kOQ3NGALAKpDfBDclVaOKF4LnLofHB2AIegBM5tONF4IaJuNSn7M1iH7ZkHLVBWvqcw
         wx7A==
X-Forwarded-Encrypted: i=1; AJvYcCVe1zikNX6+pgwn/qsZ4YLDgBOibu7zoeGIxugqzIjdgCS+0/l6v1nu0UKdRR/igjXSVJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxoNVGGrY5rlDInVMpn5gUKrBVuRaOGRh4UovpmpO6lRTWPBA
	c96Pg466Qhv1O3g+C4JM9z6vQrSFUCgJT9StToFGit39zC3V7RKkEn1J
X-Gm-Gg: AZuq6aLONXt6/9sh1yFjYOKDErsrXgu4yqF08iVVaItQDmKn+Vaf7KqytnTsbVtsuT2
	rgMILIef7MEraGNj94HMZKUJvU0fHIXZyJlmAHsSErf3mySK/gY2mk1rehTOzyv3+hDYEhDWbkR
	oK1ZYRYv5CprlcjwcsSwxrWUE+CUovi/98glT3+wN8JNEn1p1s87AI6n7lbPGCkvI/7vCE3E2yh
	j85G3mUufNA4fubMLrERsQnNr1dyMuTQ7Oz4dKRXA21H2VhKVy82iqRZk7q/BZElAoUOyduqnA6
	7pZj5Ky4d3eAD4cG3arMMzdiKWt6czcy1fLbLZjvJxqKLqwKBuaD9YuEBN31V1VyVusz4SrB2DL
	nRiG9XEMtFU5c8RFdIeXVUOfksQy++yNnSLSFZ6pMypsM/Vhn8XJoJVhSSVvwMCLoKyR9v3hPN5
	ioETovyH23UFbofO07fE+mhw/lfhFx/g==
X-Received: by 2002:a05:600c:83c8:b0:483:6cf0:5d8b with SMTP id 5b1f17b1804b1-483a00a5270mr22880675e9.9.1771501259040;
        Thu, 19 Feb 2026 03:40:59 -0800 (PST)
Received: from [10.24.66.212] ([15.248.2.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839ea454eesm15570375e9.11.2026.02.19.03.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 03:40:58 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <3fb296ed-15e3-4486-b7dd-a3f59fba165e@xen.org>
Date: Thu, 19 Feb 2026 11:40:57 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 27/34] kvm/xen-emu: re-initialize capabilities during
 confidential guest reset
To: Ani Sinha <anisinha@redhat.com>, Paul Durrant <xadimgnik@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-28-anisinha@redhat.com>
 <3b4b7b7b-7fcd-46ce-bdcb-cd1a30cf5276@xen.org>
 <793B549F-F866-4BF5-ABAF-A0537BA8713B@redhat.com>
 <bb43a79b-9ca9-49c4-ae88-f71991c97a58@xen.org>
 <CAK3XEhNHb6D=Moq=wcsFPDX2Dr_TBe7D9Z1EM4J5w3k+hobpuw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAK3XEhNHb6D=Moq=wcsFPDX2Dr_TBe7D9Z1EM4J5w3k+hobpuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2026 11:19, Ani Sinha wrote:
> On Thu, Feb 19, 2026 at 4:15 PM Paul Durrant <xadimgnik@gmail.com> wrote:
>>
>> On 19/02/2026 10:31, Ani Sinha wrote:
>>>
>>>
>>>> On 19 Feb 2026, at 3:09 PM, Paul Durrant <xadimgnik@gmail.com> wrote:
>>>>
>>>> On 18/02/2026 11:42, Ani Sinha wrote:
>>>>> On confidential guests KVM virtual machine file descriptor changes as a
>>>>> part of the guest reset process. Xen capabilities needs to be re-initialized in
>>>>> KVM against the new file descriptor.
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>>    target/i386/kvm/xen-emu.c | 50 +++++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 48 insertions(+), 2 deletions(-)
>>>>> diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
>>>>> index 52de019834..69527145eb 100644
>>>>> --- a/target/i386/kvm/xen-emu.c
>>>>> +++ b/target/i386/kvm/xen-emu.c
>>>>> @@ -44,9 +44,12 @@
>>>>>      #include "xen-compat.h"
>>>>>    +NotifierWithReturn xen_vmfd_change_notifier;
>>>>> +static bool hyperv_enabled;
>>>>>    static void xen_vcpu_singleshot_timer_event(void *opaque);
>>>>>    static void xen_vcpu_periodic_timer_event(void *opaque);
>>>>>    static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>>>> +static int do_initialize_xen_caps(KVMState *s, uint32_t hypercall_msr);
>>>>>      #ifdef TARGET_X86_64
>>>>>    #define hypercall_compat32(longmode) (!(longmode))
>>>>> @@ -54,6 +57,30 @@ static int vcpuop_stop_singleshot_timer(CPUState *cs);
>>>>>    #define hypercall_compat32(longmode) (false)
>>>>>    #endif
>>>>>    +static int xen_handle_vmfd_change(NotifierWithReturn *n,
>>>>> +                                  void *data, Error** errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /* we are not interested in pre vmfd change notification */
>>>>> +    if (((VmfdChangeNotifier *)data)->pre) {
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR);
>>>>> +    if (ret < 0) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    if (hyperv_enabled) {
>>>>> +        ret = do_initialize_xen_caps(kvm_state, XEN_HYPERCALL_MSR_HYPERV);
>>>>> +        if (ret < 0) {
>>>>> +            return ret;
>>>>> +        }
>>>>> +    }
>>>>> +    return 0;
>>>>
>>>> This seems odd. Why use the hyperv_enabled boolean, rather than simply the msr value, since when hyperv_enabled is set you will be calling do_initialize_xen_caps() twice.
>>>
>>> I am not sure of enabling capabilities for Xen. I assumed we need to call kvm_xen_init() twice, once normally with XEN_HYPERCALL_MSR and if hyper is enabled, again with XEN_HYPERCALL_MSR_HYPERV. Is that not the case? Is it one or the other but not both? It seems kvm_arch_init() calls kvm_xen_init() once with XEN_HYPERCALL_MSR and another time vcpu_arch_init() calls it again if hyperv is enabled with XEN_HYPERCALL_MSR_HYPERV .
>>
>> Yes, it has to be assumed that XEN_HYPERCALL_MSR is correct until
>> Hyper-V supported is enabled, which comes later, at which point the MSR
>> is changed. So you only need save the latest MSR value and use that in
>> xen_handle_vmfd_change().
> 
> ok hopefully this looks good
> https://gitlab.com/anisinha/qemu/-/commit/7f7ba25151b6a658c54f95a370f1970c01a6269a
> 
> sending this out to minimize churn and to make v6 as close to the
> merge worthy as possible.
> 

Yeah, that looks better. I don't think you need to move the `int 
xen_caps, ret;` line though so your patch can be even smaller AFAICS.

