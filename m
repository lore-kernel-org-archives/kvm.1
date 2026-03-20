Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BB32FF669
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018112; cv=none; b=aLPZLaueLjpWlukcO/WMyFKdG5hmFXZL0MnGZ/xq+lcdM+zXF36j610nseyY3Lupzar64JI1lN4vHsnQ5tjQ0SoXvXZmbtxHb79dF2MumdzmwBb/mbGquN2dSbl40XAUA4ftuXzCskSKyGLqxI5Z/jpFI+LX3vYnlnxEoej8vec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018112; c=relaxed/simple;
	bh=FxA7X8TzM9u3TbjaNsaXnRlkCWHhw+tYNCkUvft4kC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZFDyms0xbrxDgpFpM0LZ35iRIy6ILWMDjCNIFOxJtz5evQuSX9pTXoNSwnXYwqg+2yFladeNRNHinzdXt0d/9n/xG9MxbJING6VAgrdbNr70mdJRbj7RA4tHVWbGguMLOkNfx8VKscfMCycsWyhUPIEEaVrinvHd/M8ymXBUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJxPlQ6c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJxPlQ6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774018110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zd0Dq6GFNiubdSSXsQKDRMdABfAtqb+M1HviNvlCQGw=;
	b=IJxPlQ6ccvLao6KJnODpvAQ+RZhLIZxAaX3M1Q1TcY6PXrsEY9WFDYIhdw10yffbuTSn+n
	uGBEN183nvlRl5UWP1go1ij+4nEkTrxRybsIWy4lODAOoEGNEx5cct4iIOarpAokZpPh3k
	7eQI+mpDcr6AosetTSiEvXv03q4m+P8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-8nEsee1HPVidgZ0gMIZtJA-1; Fri,
 20 Mar 2026 10:48:27 -0400
X-MC-Unique: 8nEsee1HPVidgZ0gMIZtJA-1
X-Mimecast-MFC-AGG-ID: 8nEsee1HPVidgZ0gMIZtJA_1774018106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A04EC18005B8;
	Fri, 20 Mar 2026 14:48:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C622330001A1;
	Fri, 20 Mar 2026 14:48:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7D5A621E6937; Fri, 20 Mar 2026 15:48:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tommaso Califano <califano.tommaso@gmail.com>
Cc: qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Eduardo Habkost
 <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,
  Eric Blake <eblake@redhat.com>,  Oliver Steffen <osteffen@redhat.com>,
  Stefano Garzarella <sgarzare@redhat.com>,  Giuseppe Lettieri
 <giuseppe.lettieri@unipi.it>,  Paolo Bonzini <pbonzini@redhat.com>,  Luigi
 Leonardi <leonardi@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/5] i386/sev: Add sev-emulated QOM object with TCG support
In-Reply-To: <1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com> (Tommaso
	Califano's message of "Fri, 20 Mar 2026 15:25:01 +0100")
References: <20260317113840.33017-1-califano.tommaso@gmail.com>
	<20260317113840.33017-2-califano.tommaso@gmail.com>
	<87tsucvw3k.fsf@pond.sub.org>
	<1694998d-ea3d-4707-bf95-726ba9aee6c4@gmail.com>
Date: Fri, 20 Mar 2026 15:48:22 +0100
Message-ID: <878qbm4kw9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Tommaso Califano <califano.tommaso@gmail.com> writes:

> Il 19/03/26 13:31, Markus Armbruster ha scritto:
>> Tommaso Califano <califano.tommaso@gmail.com> writes:
>> 
>>> QEMU's AMD SEV support requires KVM on costly AMD EPYC processors,
>>> limiting development and testing to users with specialized server
>>> hardware. This makes it hard to validate SEV guest behavior, like
>>> OVMF boots or SEV-aware software, on common dev machines.
>>> A solution to this is the emulation of SEV from the guest's
>>> perspective using TCG.
>>>
>>> This change begins this process with the exposure of the SEV CPUID leaf.
>>> In target/i386/cpu.c:cpu_x86_cpuid() case 0x8000001F:
>>>
>>> case 0x8000001F:
>>>     *eax = *ebx = *ecx = *edx = 0;
>>>     if (sev_enabled()) {
>>>         *eax = 0x2;
>>>         *eax |= sev_es_enabled() ? 0x8 : 0;
>>>         *eax |= sev_snp_enabled() ? 0x10 : 0;
>>>         *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
>>>         *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
>>>     }
>>>     break;
>>>
>>> sev_enabled() verifies if the QOM object is TYPE_SEV_GUEST;
>>> TYPE_SEV_EMULATED is derived from TYPE_SEV_GUEST with SevEmulatedState
>>> to satisfy this check with minimal changes. In particular this allows
>>> to bypass all the sev_enabled() checks for future features.
>>>
>>> Since KVM hardware isn't available, override the QOM's kvm_init() and add
>>> a conditional confidential_guest_kvm_init() call during machine_init() to
>>> set up emulated confidential support using the ConfidentialGuestSupport
>>> structure.
>>>
>>> With this change it is possible to run a VM with the SEV CPUID active
>>> adding:
>>>
>>>     -accel tcg \
>>>     -object sev-emulated,id=sev0,cbitpos=47,reduced-phys-bits=1 \
>>>     -machine memory-encryption=sev0
>>>
>>> To the QEMU start arguments.
>>>
>>> Signed-off-by: Tommaso Califano <califano.tommaso@gmail.com>
>> 
>> [...]
>> 
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index c653248f85..35cda819ec 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json

[...]

>>> @@ -1241,6 +1254,7 @@
>>>      { 'name': 'secret_keyring',
>>>        'if': 'CONFIG_SECRET_KEYRING' },
>>>      'sev-guest',
>>> +    'sev-emulated',
>>>      'sev-snp-guest',
>>>      'thread-context',
>>>      's390-pv-guest',
>> 
>> Please insert before sev-guest to keep things more or less sorted.
>> 
>
> I'll do it, but I don't understand the convention. I'd organized them
> by object derivation hierarchy, so what is the expected sorting order?

It looks alphabetical modulo lazy mistakes to me.

[...]

