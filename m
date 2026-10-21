Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590146;
	b=v8wT7z4BLrLggIjfFFPus8IDSQSYHYZ4qcJxRHUXneSXtXzZgJLA8ifW0dUtFoJZWD/I
	 Wnz0+ZVPawt/DSvLAnwak6I5mTbvGDOdR5B+9izuaB0Bs4XhKagoN+H7qRWtpH04pelV1
	 EXKH81upw7GQvLATxXBUKaGwFVY1yy+iquqfHUd69T4oSE8ZLvmKqfpoEg2UmXtEzCcaT
	 0W4NYBoMP7OdqWVG+cnyKDfC0hOtddeOm4pwtYO7JuX8WYNyhNo7vmdlx3fz5JxKOhdS5
	 4+tbesb+3MuXYabKFN364BAWoDVW/mwpQbdt7vYDBMc9UxYbkGogreEGQvQb/7AtdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590146;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=YoQqnlAh3Ls7KPLyTc5XKOWCZoXoU1An/kpD3CljJvw=;
	b=kWjbgCghEvcY+dIfxpSgWfRl68mmHb3FEaustbJz1Rs4L1OeO1v3WC+cmh9KAxvz4amz
	 tctDlR8aqDjkfKQmEJ3H1cga88gHKlt38uh5mHuG0PNIX4ixyAQKPi3F9TVsuZ3QZrTyQ
	 T4YhwUIVRbLZAmKF+LO2u2UAn8PYttj8p7/XCTSWEYfs5fFBCfbND3K4XKI48mwpN4MQu
	 ftLVwOiznYUOC/k1jwo4t/vXd5bAdbdXAga1Z2nQVe/HjGFKih9IMgf1GzHMdc+YQTRa4
	 QtIjhAU2eX6CGYodUFU5tUQhpOXUgV7iVB3E+Lqp1nli94Pg0cVksLTIFstxB1lZswQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiUkqcwk;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gkTAgGuw;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F160A2606
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C18F160A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiUkqcwk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gkTAgGuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792590144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoQqnlAh3Ls7KPLyTc5XKOWCZoXoU1An/kpD3CljJvw=;
	b=HiUkqcwkvfSqYyLMmvrYh+oQGo7p/D80i9/0Uv7/XKWTdys/W9cw1d1y1mKdVVPUn0a9FR
	lK0hxJCFdFfxbA4bT10M/ONRtkw2jJZbqG8NAICocr0oZBVMbUiDt9cc1O++tgCo9hZdoQ
	2AuI4tGGh0QpDHBbqYO7o/CxjTVAAhw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-94KmL1U_NKKWSDPaqp4dZQ-1; Wed, 21 Oct 2026 09:42:23 -0400
X-MC-Unique: 94KmL1U_NKKWSDPaqp4dZQ-1
X-Mimecast-MFC-AGG-ID: 94KmL1U_NKKWSDPaqp4dZQ_1792590142
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0592d4539so891751b3a.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792590142; x=1793194942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoQqnlAh3Ls7KPLyTc5XKOWCZoXoU1An/kpD3CljJvw=;
        b=gkTAgGuwJDMK6tv+odxYVqAq1lKqWs4USeCmQzBHVC8IgJhbZCzXoGom7vtB8dULRI
         pT8Ig4bBS9SHs3mbi3W347XYpUL1NW/1eaMRQTLC3/TIuIrju60S58VpVXumCiNwmHAl
         +55nY+rRgY1QLQZ01DgI9WdL5q1G6bWWPuORmS8i980nG43to6jjdrxcu5T3/5o90+bw
         ERP8ejY6vO2zouavYGzgerE9G60dpBRNR3VKJQee3AweEfPIHqVyZ1uXRPK9zaHVmqKN
         mEi/UHq7hU32SkgocTgY3anjBANPbOh4HD9x5ntCBMbtGUu7fA8qG5D/Gu9Jgrfah9Jg
         C+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590142; x=1793194942;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YoQqnlAh3Ls7KPLyTc5XKOWCZoXoU1An/kpD3CljJvw=;
        b=W9S6UQZqhNkfYN+UqJg3uIL1Fzo6SrTF/GDyHZdPvEbTGltmeP788fEXqerZuTnJ/l
         nTFnIva9Qpx1BjnedWiU3nXPfmGT7rrwwC4ghii4YVQ8L72A7oilpBp8NdDNnVCVfmpM
         78ZtoeFyYuOT+zq4zP+Otceszj5ddxtj97f2uuX6PrapJIlIHMBSw60/sAuMpOUkaYB3
         k34lkp7IQ/qiSmbAaIlpDHgRdve2oo7spv8Z1uMQcXaCX3O2kAamZ+UlvRBRjx4MsBpL
         B2QfaH6CR7xL1QCHEnlYTR4YcTUcUd0Uuj49CJ1unzt/r/Yca86NRdWbnEhBtsxZiSdT
         ieVA==
X-Forwarded-Encrypted: i=1; AKwUvBymSpexkEihidz8f8afIihmTHc2P5OIpTwzLsVkwu0ZKn3PbehR3Vw5jaRpTPPEvzioQGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3kywuXcoD39hyq7rm/kZwRbizm1wNMPtZtlhRJbpTHYrzcycb
	S6DDqbdpR5gkB3YXxsLK4QlRHLBStVu3z0+U39tMtI0DWA220dBp+yjrymFH62MTDCfWnYeTe/9
	lzS4WoUF6s1aRXlWJEI0WINx9Ztbb3xwyxTv5eaVGKCc7GURmiDiuTQ==
X-Gm-Gg: AYBFou2fgPBUXxIRsiYFCiwGtqjw81Sz41FJLQ9AkS5S8I4aO7WjJDl3l5bLxhZOYhv
	B7CLffihwSnnS0D+iBvfQKk535dIM03WBxwhUYtpdHDlR+0MNVhuFnPTwPATVuNZQY6cp+Irwc5
	D4XbqB7THMf6k/who/KKjeYhXVDaKDMzK6xwo2pzTdkUkap4ldrk9LiAP+Ijbc4PwIZLsqeVj86
	j1EkL6jcEwq8Q8csgQ6iT5HAs+Vfe2Ilqd1e9iHlwCASPeCpR0c7CFz7lm2V8nVJW791z1EtG/M
	juOrp41ROawiao3cUvoKApScIxINpxlEPknWOzI45C19F8ACpb796borPCTxLk8ivkBYWlksFkA
	TlLG9KfP0Hfw4Iswrief/XVpRXFk+oB1xk3MW05zhBQ==
X-Received: by 2002:a05:6a00:a0c:b0:89e:779b:d0f with SMTP id d2e1a72fcca58-8a089dfdbb8mr1587929b3a.37.1792590141852;
        Wed, 21 Oct 2026 06:42:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0c:b0:89e:779b:d0f with SMTP id d2e1a72fcca58-8a089dfdbb8mr1587908b3a.37.1792590141359;
        Wed, 21 Oct 2026 06:42:21 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895cce93sm934064b3a.30.2026.10.21.06.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:42:20 -0700 (PDT)
Message-ID: <784dfea3-24cb-4e70-ab46-b96b4b9a1831@redhat.com>
Date: Wed, 21 Oct 2026 23:42:14 +1000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Kohei Enju <enju.kohei@fujitsu.com>, michael.roth@amd.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
 <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
 <arI197vJkW75p50c@lpieralisi> <arSTQQ5uB6oR-vFe@FCCLS0092175.localdomain>
 <ataBkrIvULJXj4v6@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <ataBkrIvULJXj4v6@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 6:46 AM, Mathieu Poirier wrote:
> On Thu, Sep 24, 2026 at 12:12:35PM +0900, Kohei Enju wrote:
>> On 09/22 10:01, Lorenzo Pieralisi wrote:
>>> On Tue, Sep 15, 2026 at 04:27:21PM -0500, Michael Roth wrote:
>>>> On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
>>>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>
>>>>> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
>>>>> support the Arm Realm Management Extension (RME). It is instantiated by
>>>>> passing on the command-line:
>>>>>
>>>>>    -M virt,confidential-guest-support=<id>
>>>>>    -object rme-guest,id=<id>
>>>>>
>>>>> This is only the skeleton. Support will be added in following patches.
>>>>>
>>>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> ---
>>>>>   docs/system/confidential-guest-support.rst |  1 +
>>>>>   qapi/qom.json                              | 13 +++++++
>>>>>   target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
>>>>>   target/arm/meson.build                     |  5 ++-
>>>>>   4 files changed, 60 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 target/arm/kvm-rme.c
>>>>>
>>>>> diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
>>>>> index 562a7c3c2852..abb56923ad13 100644
>>>>> --- a/docs/system/confidential-guest-support.rst
>>>>> +++ b/docs/system/confidential-guest-support.rst
>>>>> @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
>>>>>   * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
>>>>>   * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
>>>>>   * AWS Nitro Enclaves (see :doc:`nitro`)
>>>>> +* Arm Realm Management Extension (RME)
>>>>>   
>>>>>   Other mechanisms may be supported in future.
>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>> index 776b13027fd8..52997c29a32d 100644
>>>>> --- a/qapi/qom.json
>>>>> +++ b/qapi/qom.json
>>>>> @@ -1288,6 +1288,17 @@
>>>>>     'data': { '*pretty': 'bool',
>>>>>               '*close-action': 'MonitorQMPCloseAction' } }
>>>>>   
>>>>> +##
>>>>> +# @RmeGuestProperties:
>>>>> +#
>>>>> +# Properties for rme-guest objects.
>>>>> +#
>>>>> +# Since: 11.1
>>>>> +##
>>>>> +{ 'struct': 'RmeGuestProperties',
>>>>> +  'base': 'ConfidentialGuestSupportProperties',
>>>>
>>>> Just FYI, based on input from Markus I'm planning to drop this
>>>> ConfidentialGuestSupportProperties base type from my series
>>>> since it's probably only SNP/TDX that need to be able to switch
>>>> it on/off, whereas this series appears to use/require it from
>>>> the start.
>>>>
>>>> I'm not exactly sure what it will look like for v3 yet, but if you
>>>> were based on v2 you'd instead probably just do the following in the
>>>> instance_init function for your rme-guest instance:
>>>>
>>>>    cgs->allow_convert_in_place = true;
>>>>    cgs->convert_in_place = true;
>>>>
>>>> rather than exposing it as a cmdline option.
>>>
>>> Yep, it won't be an option for CCA Realms anyway since that will be
>>> the baseline.
>>
>> IIUC, in-place conversion requires RAM backed by a shared/mappable
>> guest_memfd. If in-place conversion is always enabled for CCA Realms,
>> could QEMU also select the equivalent of
>>
>>    -object memory-backend-guest-memfd,id=ram0,size=...,share=on
>>
>> automatically for the default RAM, so that specifying the RAM size with
>> `-m` is sufficient?
> 
> Are you suggesting that on Arm, we completely get rid of
> 
>      -object memory-backend-guest-memfd,id=ram0,size=$(RAMSIZE),share=on
> 
> or simply to get rid of "size=$(RAMSIZE)" in the above because it is redundant
> with "-m $(RAMSIZE)"?
> 
> Gavin and Michael, what is your take on that suggestion?
> 

I don't think that's what Kohei meant. He actually suggested the memory backend
shall be pinned to memory-backend-guest-memfd and its in-place conversion shall
be enabled when the memory backend isn't explicitly specified by users through
"-object memory-backend-xxxx". For this inexplicit case, where the memory backend
is determined by '-mem-path', the memory backend is either TYPE_MEMORY_BACKEND_FILE
or TYPE_MEMORY_BACKEND_RAM. Please refer to create_default_memdev().

I think Kohei's suggestion makes sense. Besides, I think '-mem-path' should be
disallowed for CCA Realms as TYPE_MEMORY_BACKEND_FILE isn't what we want.

Thanks,
Gavin

> Thanks,
> Mathieu
> 
>>
>> Thanks,
>> Kohei
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> Thanks,
>>>>
>>>> Mike
>>>>
>>>>> +  'data': {} }
>>>>> +
>>>>>   ##
>>>>>   # @ObjectType:
>>>>>   #
>>>>> @@ -1346,6 +1357,7 @@
>>>>>       { 'name': 'pr-manager-helper',
>>>>>         'if': 'CONFIG_LINUX' },
>>>>>       'qtest',
>>>>> +    'rme-guest',
>>>>>       'rng-builtin',
>>>>>       'rng-egd',
>>>>>       { 'name': 'rng-random',
>>>>> @@ -1427,6 +1439,7 @@
>>>>>         'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>>>>>                                         'if': 'CONFIG_LINUX' },
>>>>>         'qtest':                      'QtestProperties',
>>>>> +      'rme-guest':                  'RmeGuestProperties',
>>>>>         'rng-builtin':                'RngProperties',
>>>>>         'rng-egd':                    'RngEgdProperties',
>>>>>         'rng-random':                 { 'type': 'RngRandomProperties',
>>>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>>>> new file mode 100644
>>>>> index 000000000000..42e1d1e7b859
>>>>> --- /dev/null
>>>>> +++ b/target/arm/kvm-rme.c
>>>>> @@ -0,0 +1,42 @@
>>>>> +/*
>>>>> + * QEMU Arm RME support
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + *
>>>>> + * Copyright Linaro 2026
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +
>>>>> +#include "hw/core/boards.h"
>>>>> +#include "hw/core/cpu.h"
>>>>> +#include "kvm_arm.h"
>>>>> +#include "migration/blocker.h"
>>>>> +#include "qapi/error.h"
>>>>> +#include "qom/object_interfaces.h"
>>>>> +#include "system/confidential-guest-support.h"
>>>>> +#include "system/kvm.h"
>>>>> +#include "system/runstate.h"
>>>>> +
>>>>> +#define TYPE_RME_GUEST "rme-guest"
>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>>>>> +
>>>>> +struct RmeGuest {
>>>>> +    ConfidentialGuestSupport parent_obj;
>>>>> +};
>>>>> +
>>>>> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>>> +                                          CONFIDENTIAL_GUEST_SUPPORT,
>>>>> +                                          { TYPE_USER_CREATABLE }, { })
>>>>> +
>>>>> +static void rme_guest_class_init(ObjectClass *oc, const void *data)
>>>>> +{
>>>>> +}
>>>>> +
>>>>> +static void rme_guest_init(Object *obj)
>>>>> +{
>>>>> +}
>>>>> +
>>>>> +static void rme_guest_finalize(Object *obj)
>>>>> +{
>>>>> +}
>>>>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>>>>> index 0369f96b4cc6..9d322a7aad28 100644
>>>>> --- a/target/arm/meson.build
>>>>> +++ b/target/arm/meson.build
>>>>> @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
>>>>>   arm_common_system_ss.add(files(
>>>>>     'arm-qmp-cmds.c',
>>>>>   ))
>>>>> -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
>>>>> +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
>>>>> +  'hyp_gdbstub.c',
>>>>> +  'kvm.c',
>>>>> +  'kvm-rme.c'))
>>>>>   arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>>>>>   
>>>>>   arm_user_ss.add(files('cpu.c'))
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>>>
> 

