Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661082EAB82
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411664; cv=none; b=T39c8qMZExnclypvgyPdtEH60+pnsiChASwxJrSotWoysfMQyqLAA1HEZorvWWJWYPnZWD8Kz7PFDI4+1I5uiA4Prm9/Jc8nNc4p7bu0OfE24GpVme4UZbGC9SIzGQ/rA8LPMx7A7vJYlVYpAaIoLLnA/BGKGSsB65C9X5H42f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411664; c=relaxed/simple;
	bh=gtXzY3UzOa0u/JZYAGdbeFTboh1lX32MreW71F1IG5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY3q3Aky8l52X1b88BbtZx3duy+k+L1J43VR/TZKyXXte8GZnQdLBNnB9NkE8O+qqDG62IhZgVLWiXh3nB4vtgkZtEjT60/NkFrJRgqWB6mYaIeqlulPDac1s6s34Qmwo6XEvbyYV8cLFM5uDVbxO6aYFtSPSKGixNEVeIe/kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ztx38cSx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=syQjnQs8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ztx38cSx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="syQjnQs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774411662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgjWcQoj7oLaeFNKzaIEePhWh+sZwFHeBhNTOW06Lw4=;
	b=Ztx38cSx1eOqAUr+PgzCuIDszBtuncRPm56hs9EL3MAvQUCK9BP6wjKuahp8JbUq91Xdat
	4oNHS96H6xqxa6uNh6cKg2w/7dOjPImXOFL/T3KDOo7MJi/0jKWqUrYXvl4fAFUJgoYhT9
	xqewiIk+AqbegNR+9YjWSpU25rLLM60=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-xgVE3ttMMkmXePMyy03Uhg-1; Wed, 25 Mar 2026 00:07:31 -0400
X-MC-Unique: xgVE3ttMMkmXePMyy03Uhg-1
X-Mimecast-MFC-AGG-ID: xgVE3ttMMkmXePMyy03Uhg_1774411651
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-829b8bb5211so16160919b3a.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 21:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774411651; x=1775016451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgjWcQoj7oLaeFNKzaIEePhWh+sZwFHeBhNTOW06Lw4=;
        b=syQjnQs8n5NDTmpfSegh2Pn0Xyg3qHpPieJj09kLCmdbrYTpDbtBsBsV94LN9bHWdW
         6j1ZEf0Bfc5DBjhOfwirmOujvupf56AEiOhDdb/W83IuKY3tJKUnw/UWKQe7Dx0joH75
         CdP9jv7r1s5l0dSCvXyXp9n6eK4SEY/NqwNKhQtx3hhvO916nXpUhr+k0QOKe4BI0Twm
         eBSedNxIvEDVMDrGqIoeKM5N90iYjs3YZDvTu5iGNikyCW0fsuxDOUo/fpyIlr6UwM2M
         WLVV7CftBCwNfSmjR5uaTXzB1N+UGcLU7mFc1E790Kwr/96dbi5SPGhhED1Z/mer/q2t
         oaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774411651; x=1775016451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgjWcQoj7oLaeFNKzaIEePhWh+sZwFHeBhNTOW06Lw4=;
        b=ai6SMyYv6AOja9h+Li34QKV4CcD3N5Q4MXbweDCfNWzio2ehsxO4a/lSUvmVTfOA8O
         lJQUO2L4gBCLwW+04LnJ40UCg7cVwL7WzkoQ1LY2eiuHTPCYimuoQAw1+CwsfbkEfqig
         5GMafuyPBZ2qctp1l74pBjkHtGKupMhIy3TAuUx7O0Zvvfib3E7eZuKqTHzRu1y3JYoQ
         r2d1WnS7EiZXRZyP6x9NwAq3yKG1DEOHQrGBKgd2fITdasrzssRMXGEzBwmFyg0Z5l78
         gU/NCVb+J37fpSY0RXcILcpI/9hD+CWAhN0HeKSR38L7x54IbUH9fFBNt9+mvCxJ82YV
         oPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiag5jw/BmsNhR3RvexIPUDA+VfINYdiLwt99Llm5Xd+TF2YkukQe/gKwuwtKenZDO/Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3D8TsYToZNccoluG5lsMxSREzuxa1DFuheTEcwwyeG2LJb36F
	J75e/+ZAbYjIxkXgkQnrpG6PU8BmB5tKewCo78Czyj8B6AENrl7xpe/K8nNuWbCHh705NCL4PJ9
	V0e5YDEOY4eCFrAQXOMoZ1aTwfj49vVazdsZmKkYxv07OUkXUP8rFXA==
X-Gm-Gg: ATEYQzziKRdtlRC36SUrVJpIn+WJeAkzCkyPBoimCUF2YXRmEKTXix3Il4JI++VudqV
	rZ4Czx9gu0fR5kSJlU8w6JtMcsyPsUzv77t3CRhxrxad6xVXrXfZD9IIKwO32KxxU51UM93wWzl
	JBti8L4yqRzAVewSgwyhHf9XNjr5lTF90zD7ZFvPJ5k0kAF88b9SNatL1KGdvRD3G4r4HvryFUk
	nwNkCI/z72cn3WxY24djWl7ZS4mGndW0CblZcBFDJQI2S9BvMpPwl7b2t4jnH3QpeoF37kmTnaP
	tggEOEeMbeAM8IdIPJ0VZu+gAcNaJ36BMg6Hm3Gri73GK3oaDmuFFFnXg09hqUnjtgYhZtk717z
	GfVVzpUdngLbDEiViwKgm9MBF2PxW22+haOKGMMU3O2w3bpUV5OWHGcaWVkgE0o1u
X-Received: by 2002:a05:6a00:298e:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-82c6e0d1e6emr1790893b3a.46.1774411650516;
        Tue, 24 Mar 2026 21:07:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:298e:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-82c6e0d1e6emr1790860b3a.46.1774411650026;
        Tue, 24 Mar 2026 21:07:30 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c38565096sm8738528b3a.51.2026.03.24.21.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 21:07:29 -0700 (PDT)
Message-ID: <779079e1-7193-46e9-b18c-9ab5e69bb077@redhat.com>
Date: Wed, 25 Mar 2026 14:07:17 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/48] arm64: Support for Arm CCA in KVM
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260318155413.793430-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 3/19/26 1:53 AM, Steven Price wrote:
> 
> This series is based on v7.0-rc1. It is also available as a git
> repository:
> 
> https://gitlab.arm.com/linux-arm/linux-cca cca-host/v13
> 
> Work in progress changes for kvmtool are available from the git
> repository below:
> 
> https://gitlab.arm.com/linux-arm/kvmtool-cca cca/v11
> 

Could you please share if we have a working qemu repository on top of this
(v13) series? The previous qemu repository [1] seems out of dated for long
time. I heard Jean won't be able to continue his efforts on QEMU part, who
is going to pick it up in this case.

[1] https://git.codelinaro.org/linaro/dcap/qemu.git    (branch: cca/latest)

> Note that the kvmtool code has been tidied up (thanks to Suzuki) and
> this involves a minor change in flags. The "--restricted_mem" flag is no
> longer recognised (or necessary).
> 
> The TF-RMM has not yet merged the RMMv2.0 support, so you will need to
> use the following branch:
> 
> https://git.trustedfirmware.org/TF-RMM/tf-rmm.git topics/rmm-v2.0-poc
> 

I'm seeing error to initialize RMM with the suggested RMM branch (topics/rmm-v2.0-poc)
and the upstream TF-A [1]. It seems the problem is compatible issue in the
RMM-EL3 interface. RMM requires verion 2.0 while TF-A only supports 0.8. So
I guess I must be using a wrong TF-A repository. Could you please share which
TF-A repository you use for testing?

[1] git@github.com:ARM-software/arm-trusted-firmware.git    (branch: master)

Booting logs
=============
NOTICE:  Booting Trusted Firmware
NOTICE:  BL1: v2.14.0(debug):67edb4f8e
NOTICE:  BL1: Built : 00:01:39, Mar 25 2026
INFO:    BL1: RAM 0xe0ee000 - 0xe0f7000
INFO:    BL1: Loading BL2
INFO:    Loading image id=1 at address 0xe05b000
INFO:    Image id=1 loaded: 0xe05b000 - 0xe0642bc
NOTICE:  BL1: Booting BL2
INFO:    Entry point address = 0xe05b000
INFO:    SPSR = 0x3cd
NOTICE:  BL2: v2.14.0(debug):67edb4f8e
NOTICE:  BL2: Built : 00:01:39, Mar 25 2026
INFO:    BL2: Doing platform setup
INFO:    Reserved RMM memory [0x40100000, 0x418fffff] in Device tree
INFO:    BL2: Loading image id 3
INFO:    Loading image id=3 at address 0xe090000
INFO:    Image id=3 loaded: 0xe090000 - 0xe0a292b
INFO:    BL2: Loading image id 35
INFO:    Loading image id=35 at address 0x40100000
INFO:    Image id=35 loaded: 0x40100000 - 0x401a11e0
INFO:    BL2: Loading image id 5
INFO:    Loading image id=5 at address 0x60000000
INFO:    Image id=5 loaded: 0x60000000 - 0x60200000
NOTICE:  BL2: Booting BL31
INFO:    Entry point address = 0xe090000
INFO:    SPSR = 0x3cd
INFO:    GPT: Boot Configuration
INFO:      PPS/T:     0x2/40
INFO:      PGS/P:     0x0/12
INFO:      L0GPTSZ/S: 0x0/30
INFO:      PAS count: 6
INFO:      L0 base:   0xedfe000
INFO:    Enabling Granule Protection Checks
NOTICE:  BL31: v2.14.0(debug):67edb4f8e
NOTICE:  BL31: Built : 00:01:39, Mar 25 2026
INFO:    GICv3 without legacy support detected.
INFO:    ARM GICv3 driver initialized in EL3
INFO:    Maximum SPI INTID supported: 287
INFO:    BL31: Initializing runtime services
INFO:    RMM setup done.
INFO:    BL31: Initializing RMM
INFO:    RMM init start.
ERROR:   RMM init failed: -2                           <<<< Error raised by RMM here
WARNING: BL31: RMM initialization failed
INFO:    BL31: Preparing for EL3 exit to normal world
INFO:    Entry point address = 0x60000000
INFO:    SPSR = 0x3c9
UEFI firmware (version  built at 19:33:51 on Mar  3 2026)


Thanks,
Gavin



