Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D2351C37
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420689; cv=none; b=SdoUBFvWUTFAArglx+HevKbrzH4dtVph1idXDg3vBmWKD7eFM0vsWOkKZbfF8atJwF44Y7xnozRXziWlgCfMJx0/oTL/SLKE7jl3Pxb1K9KaXGYUIVDLiQbEKEY48X4QeuYdgT4sl7AvpTdIe1cCJfjS64EWBb3CqwoZmre866Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420689; c=relaxed/simple;
	bh=yZtfD8ZbhUWOVtqgdCaXlBQFYIVZsgKdxdefJ6np6Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5zJdXAi6ZaIwcLON9AXEW+NVW9N5hlHe/DMyiIcEF0H+CQ+iXMLRMslKVeb4LUZjLy4r8VQXzsFpiD4nNyDWfUbGJBUMfhVtRC/wAKOQf5crJglhPp+R7IgBbChjCemM+KA3VfvJtYSOlYi8JKRehozYfibjxLMm6gZx+o64zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4Ma5kI+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C064yyQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4Ma5kI+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C064yyQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774420687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pf2aP5j0cWMrde9xV40F9uxk8K2GUvZ19JNXNz1B5Hc=;
	b=A4Ma5kI+gUClzeqlpsBX4FPv0i3UO0xYGl6lF2osBMwAwntWpiO61kmHAbvtT/3IhkHFuA
	6X9e+LKSxziH7SIPLU7rxqf66vK2/xb69uG12Kt/LJIMOnDfzzHO5niYwlh5Y0s6El7c3B
	qKv1r58fBTpun3OaW3HWkEBZdvlIuZw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-uy0W9am6PQyFgd0Ttxqi2w-1; Wed, 25 Mar 2026 02:38:05 -0400
X-MC-Unique: uy0W9am6PQyFgd0Ttxqi2w-1
X-Mimecast-MFC-AGG-ID: uy0W9am6PQyFgd0Ttxqi2w_1774420685
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829b7ed8964so4790530b3a.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 23:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774420685; x=1775025485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf2aP5j0cWMrde9xV40F9uxk8K2GUvZ19JNXNz1B5Hc=;
        b=C064yyQPU8pABOjBp+Rhn1/jMoC1gzt8BFDRRlGMe+Qzm8TnIqt5hITwdKeVWovpjs
         NbDj+AlyTSgVmt3lZmj6iLlliWUMT+WJfdtCR7u3M63+5aHugA9RxMc0SIe0f2+z2ZyR
         QeZgo19gHZQHydFbz93UEUig6TGvRth3VN8ReiIKN8gS+l/cbyB8fbp9puaUb5bqNPox
         ciWjXKp7Kr4iwvna+ztYVoFZE7ieSJOYmfVb3HUdALcBpmAs+1ohFRogC6IXM6wQj6LU
         1/aRxj29DCzUh6zD+qtcaNFXm6lYXsRvbNi5IUqcrFqEgpZRt2GoLMPqTNNHnKxjSrFY
         qlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420685; x=1775025485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pf2aP5j0cWMrde9xV40F9uxk8K2GUvZ19JNXNz1B5Hc=;
        b=g6/fx8gKTK+Nncxwb3hg2vofsKXp1AX+vu9sag3VTtpDqqMJP65wntMl2gLUfAHLy2
         Mi0/bSzv419FNZseJG92LV/oxod62143LBUGGabuzaSAbU++cmRoFYdOQZZ7dwf9r0b2
         dT512sT/XG7p0EnFok3lE66fgtDxWfF2gRlMeE6HbOaGjDVgeBG8DU4KAd+vuBAW7iKW
         Wt3cbcdr/HegCWfwR1GnpExLcDha77FZZpRgZtZ1gGKfuqW5/QHRYXbp4gjJJkvZvXeJ
         UitVSTYMeG2y7/u3jAIpRrpMJUKFUDjlvGfqRrsoP6gABaRD90dpbJHxpwI0Mw/lcx7b
         2phg==
X-Gm-Message-State: AOJu0YzNiRTzwbPNDmcPprrRsqHFIHmyN6zBR1wfC7y4QHELFOU7NUto
	vxw8rp6YjyhlBxYUoX9OHyq4AsS/ZvkJAJNhoiZD/WEjtrJDyB0wRIAAIp6N1+7EEZZ1/rD7llC
	1BpLDnVO+C/0tP9BotilatzHJrEpapNOCqsvCXjsB88ZrGzG6vnUvxA==
X-Gm-Gg: ATEYQzx+w2pdeZMn3H1lg6w7C2J5qz0uwwa4y8yZEMEHwbV85MHE8UhKAoSU8uQ7Bg7
	+xiDlWZ4MTM/hjzCD2fCD4eLrNBUSv58h+fN/10GMiCD/lEmEWXctit4V01ND457DKSM+qVQfgS
	+EhmV5b4B9WrgiBIAkjsh/y469br42LFDivMVOGxnFZHsYGgq235YX4D/F3jpXC1zwv+RUlUy6e
	v4lWUPSyYvy6Cb7uxowy5g6keZ+7G7g+UDjeA2G1e4Fntt5bItOOzX9vFg41qJhDa1NlT98R3nj
	PLWJ2EMwxds0zYxUQJPrNoKP6qnwSlG7UKOuLfcO5H9eea72X9x6vFxmxKFoY7x3lsgneFlbAy9
	F2SSwpx88pdUc6Dy3lWAj4iV6/+BmJjpDT5PyNb41125HJVddT8OX5oLpoc/qS/ei
X-Received: by 2002:a05:6a00:1f0d:b0:829:8041:83f with SMTP id d2e1a72fcca58-82c6ded62f5mr2295354b3a.7.1774420684578;
        Tue, 24 Mar 2026 23:38:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1f0d:b0:829:8041:83f with SMTP id d2e1a72fcca58-82c6ded62f5mr2295316b3a.7.1774420684086;
        Tue, 24 Mar 2026 23:38:04 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bbf0c2sm17111626b3a.15.2026.03.24.23.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 23:38:03 -0700 (PDT)
Message-ID: <0b7121e7-3c74-4303-a200-01d2b7c535ce@redhat.com>
Date: Wed, 25 Mar 2026 16:37:52 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
References: <20260318155413.793430-1-steven.price@arm.com>
 <abyAbPIkDn2bGZwd@p14s> <37bc1222-6fc7-48f0-94d3-6eaac420aa55@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <37bc1222-6fc7-48f0-94d3-6eaac420aa55@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 3/21/26 2:45 AM, Steven Price wrote:
> On 19/03/2026 23:02, Mathieu Poirier wrote:

[...]

>>>
>>> The TF-RMM has not yet merged the RMMv2.0 support, so you will need to
>>> use the following branch:
>>>
>>> https://git.trustedfirmware.org/TF-RMM/tf-rmm.git topics/rmm-v2.0-poc
>>
>> This RMM version is expecting a RMM EL3 interface version of at least 2.0.  Do
>> you have a TF-A to use with it?
> 
> You should be able to use the 'master' branch of the TF-A repository.
> For now you need to set RMM_V1_COMPAT=0 to enable 2.0 support.
> 

In upstream TF-A repository [1], I don't see the config option 'RMM_V1_COMPAT'.
would it be something else?

[1] git@github.com:ARM-software/arm-trusted-firmware.git    (branch: master)

I use the following command to build TF-A image. The RMM-EL3 compatible issue is
still seen.

     TFA_PATH=$PWD
     EDK2_IMAGE=${TFA_PATH}/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd
     RMM_IMAGE=${TFA_PATH}/../tf-rmm/build-qemu/Debug/rmm.img
     
     make CROSS_COMPILE=aarch64-none-elf-                               \
          PLAT=qemu ENABLE_RME=1 RMM_V1_COMPAT=0 DEBUG=1 LOG_LEVEL=40   \
          QEMU_USE_GIC_DRIVER=QEMU_GICV3                                \
          BL33=${EDK2_IMAGE} RMM=${RMM_IMAGE}                           \
          -j 8 all fip

Booting messages
================
INFO:    BL31: Initializing runtime services
INFO:    RMM setup done.
INFO:    BL31: Initializing RMM
INFO:    RMM init start.
ERROR:   RMM init failed: -2
WARNING: BL31: RMM initialization failed

Thanks,
Gavin



