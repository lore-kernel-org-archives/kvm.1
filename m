Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D484C47B43B
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962793; cv=none; b=obhRJCAiTswv2ETpqHcOWBBuVpRq8DM3Qt8OUbTendNmsrhSDJNLgvKF37y60Ce3o0fp7Fon5gXAUU8jDJOSXVhRpM2cGyz0Vq3kthI2yho/dEu3+o159u6Kfd8bNOPyGsNLegoUFo4JR4dYWY3Dxvn+tpYrD/lIuCNJQmVhQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962793; c=relaxed/simple;
	bh=jEDr7CZMnktmoXb4NjMcFjZ5CF1yuHZAy1IjGOmqKPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDqJtNJO9x/E53Ox7CjTt36okQDAkxyLrvT+mj8PAsuWzxWSc1LUDRPOfdhjPNZ+Gqtalb4k42Da/JtckWmujnvA1T1TyvougWZ92UayD90ItYgECbJSqBKKy02BJYsUJYGx5momwNstQn38sn22X8LRzZH6eIBzAB3AfQUB5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4BoVorS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=USjTTR7I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4BoVorS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="USjTTR7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791962790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/27OLHjKCfoYXX3QS6shBfqd83AIp/PVTNTv8jw4t/c=;
	b=c4BoVorSVArN5wFbIWRJXcmgcCo+9CbOeK/WZd22G8aqq2ZGkoJp4BTFkuF1xsYyQrmEUM
	YFTiFz4wX42WrQU2Y8ubw025AWeLimDd22HH14blCEUk0nba+FqrRN289OJGWkfaqPvUHn
	KDxFE3ezsInRXyq/6Pt8CTJoz5S/xqo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-jt-oLwkPP8Si8wS2nz2Lug-1; Wed, 14 Oct 2026 07:26:26 +0000
X-MC-Unique: jt-oLwkPP8Si8wS2nz2Lug-1
X-Mimecast-MFC-AGG-ID: jt-oLwkPP8Si8wS2nz2Lug_1791962785
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a470ead068so4100115a91.3
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791962785; x=1792567585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/27OLHjKCfoYXX3QS6shBfqd83AIp/PVTNTv8jw4t/c=;
        b=USjTTR7IxIC/18dU7QUx8EJ1z1yCGGHXPid4yhT+L2Z8L94oWYxVOXCaKYDvKx5h/r
         58YdGQ4X2NR49ETvkEfOCppbQAxrf+vLkpItR9P6CA2lOr05xjRnM7+4nG3ox6VysQlX
         gICVP0cLlWQ0o5Om3p6qH2dkJ6FXc5NLLaXXchHLKT1gufMY0u892SCCj2x5+QqKR28k
         uWwFmr4ZURsD1YkGHM1DoxJxj3ELmRTJq7X1GOKWkLQyIE5sIkSo1GIbfKZP265b4hDk
         LQlWtmDAZZwArPrNxDDwKkq5bRsOYjno6BbHk1ziPgD+usS6BNu3jCt++uDamP/SsuWI
         eRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962785; x=1792567585;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/27OLHjKCfoYXX3QS6shBfqd83AIp/PVTNTv8jw4t/c=;
        b=ScYwIzCRY3sHkIJWfGlLZXqd9XcEWX+5uwGQROHntSvid1ktalpWHWwAxYr0KyXoNh
         avC62xMHQgudDbRRAUT1f9T8xAkZJuD3/SEoRTOVtCAkAZ040yAXyqGT4HR2+WuJsdyI
         tsS3Xs6HW/17BlbSa0Vwnsy/cVXU3SKTkQPX0xsUldAhl9KSs6ojZ+WO3nfH91LBmheh
         1OBttgowf/X2jOthLYmJNae4MVNWG4ojrmITmmbpBo488hw2Qjt1xN4EiltKQjrb7tjQ
         ctESlr1MFa8w+Ii1GMfMf3srcbq1Cen9QpVkh8XXUuozHEpOwFrBzBnjmSQ94rCnav3Q
         Xliw==
X-Forwarded-Encrypted: i=1; AKwUvBw3mD+R0AgDO5k1VEXcMhiJx4CEIIQUno09tyq7lTRkPhQnEO7AhZUspZopqJoYz2dIWSQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsmZ8xy1Md0dMXCH26T8JRpSJlzxw79tQJ5EJPqFr0kjCxi3CS
	Fi61Bi7bJS/csb06nf/uvl/umLjhbceVk2CcV5XUOjiZdKzwIEM0LAGJl60CWhnjEzVct2Yu3Fk
	Qh2pUen2F3C5eik44hP8i18oZlMjdRjbG4qM9OJ/4uQyt8EY/NyqJ5g==
X-Gm-Gg: AYBFou1m6etYOJHgNaXW5JDPg3242ifxlY6ytTAukNbiBshafrmovtvgKTQNVomclJV
	91jCYzwSDKAj8OpoeFNRAKX08eFVJXgUxfhzS2aVQNgnKn4C/1XnmDbsPKarykfaws11eM2f4Ee
	dAafBJiAJvXklKmTwGL10UqKV1r+A9DJSbH7wlYI/1TBHXV89OYwMJ2tSqR/zmQWdeDIg6rpuzw
	PupyaiEuTDf5vY0JHwqvmkGuO55IbaCliuakmpIW5EDUT4u/gUkP//RbLv3zXfCI2DSLcdyKp9T
	svzOJGaNYA6Mvc0aaCRKnn7zsD8DvGBmXtOltDcyHNVAfgjVe9qqhAtORSZ2S0noyFfsbF1u3pc
	BM0UYak5OLyynkJoa4k0Z6LSUNKDSylTI+327a5SyMA==
X-Received: by 2002:a17:90b:224e:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3ab3a9f42aamr10847044a91.23.1791962784930;
        Wed, 14 Oct 2026 00:26:24 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3ab3a9f42aamr10847017a91.23.1791962784459;
        Wed, 14 Oct 2026 00:26:24 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f280fecsm3307221a91.13.2026.10.14.00.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 00:26:23 -0700 (PDT)
Message-ID: <3fbd4739-a4eb-4428-95ae-ead22e7cf9f2@redhat.com>
Date: Wed, 14 Oct 2026 17:26:14 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 02/10] firmware: arm_rmm: Check for RMI support at
 init
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
 sudeep.holla@arm.com, jonathan.cameron@oss.qualcomm.com
References: <20261002061507.1600269-1-suzuki.poulose@arm.com>
 <20261002061507.1600269-3-suzuki.poulose@arm.com>
 <2586e689-c27d-4e4c-8c69-03e24259cb96@redhat.com>
 <8be050e3-8af1-4f04-902f-9bc01b209dd0@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <8be050e3-8af1-4f04-902f-9bc01b209dd0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/26 7:58 PM, Suzuki K Poulose wrote:
> On 13/10/2026 04:53, Gavin Shan wrote:
>> Hi Suzuki,
>>
>> On 10/2/26 4:14 PM, Suzuki K Poulose wrote:
>>> From: Steven Price <steven.price@arm.com>
>>>
>>> Query the RMI version number and check if it is a compatible version.
>>> All RMM feature registers are read and exposed for future code to
>>> use. Also restrict the support to SMC conduit.
>>>
>>> We only support this for Little Endian kernels, the Big Endian kernel
>>> support is anyway marked BROKEN and is being removed.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Oliver Upton <oupton@kernel.org>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Tested-by: Gavin Shan <gshan@redhat.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>
>> [...]
>>
>>> ---
>>>   MAINTAINERS                       |   2 +
>>>   arch/arm64/Kconfig                |   1 +
>>>   arch/arm64/kernel/cpufeature.c    |   1 +
>>>   arch/arm64/kvm/sys_regs.c         |   2 +
>>>   drivers/firmware/Kconfig          |   1 +
>>>   drivers/firmware/Makefile         |   1 +
>>>   drivers/firmware/arm_rmm/Kconfig  |  25 +++++++
>>>   drivers/firmware/arm_rmm/Makefile |   1 +
>>>   drivers/firmware/arm_rmm/rmi.c    | 112 ++++++++++++++++++++++++++++++
>>>   include/linux/arm-rmi-cmds.h      |  48 +++++++++++++
>>>   10 files changed, 194 insertions(+)
>>>   create mode 100644 drivers/firmware/arm_rmm/Kconfig
>>>   create mode 100644 drivers/firmware/arm_rmm/Makefile
>>>   create mode 100644 drivers/firmware/arm_rmm/rmi.c
>>>   create mode 100644 include/linux/arm-rmi-cmds.h
>>>
>>
>> [...]
>>
>>> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/ arm_rmm/rmi.c
>>> new file mode 100644
>>> index 0000000000000..06f5392c982d2
>>> --- /dev/null
>>> +++ b/drivers/firmware/arm_rmm/rmi.c
>>> @@ -0,0 +1,112 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2023-2026 ARM Ltd.
>>> + */
>>> +
>>> +#include <linux/arm-rmi-cmds.h>
>>> +#include <linux/cpufeature.h>
>>> +#include <linux/memblock.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <asm/memory.h>
>>> +#include <asm/pgtable-hwdef.h>
>>> +
>>> +/* RMM v2.0 defines RmiFeatureRegister0 to RmiFeatureRegister4. */
>>> +static unsigned long rmi_feat_reg_cache[5] __ro_after_init;
>>> +
>>> +static int rmi_check_version(void)
>>> +{
>>> +    unsigned short version_major, version_minor;
>>> +    unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
>>> +                             RMI_ABI_MINOR_VERSION);
>>> +    unsigned long aa64pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
>>> +    struct arm_smccc_1_2_regs res = {
>>> +        SMC_RMI_VERSION, host_version,
>>> +    };
>>> +
>>> +    /* If RME isn't supported, then RMI can't be */
>>> +    if (cpuid_feature_extract_unsigned_field(aa64pfr0, ID_AA64PFR0_EL1_RME_SHIFT) == 0)
>>> +        return -ENXIO;
>>> +
>>> +    if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_SMC)
>>> +        return -ENXIO;
>>
>> I think we need to ensure SMCCC version is v1.2 or a newer one here? arm_smccc_1_2_smc()
>> is immediately called by rmi_smccc_invoke() after this check.
>>
>>      if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_SMC ||
>>              arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
> 
> We could. But I am wondering if that adds any value ? If the RMM
> exists and responds to the RMI_ABI_VERSION, it must be so on a
> platform with v1.2 or greater ? The extra check doesn't hurt.
> 

It's required as documented in section "B1.1 overview" of RMM-spec-v2.0-bet3.
In the same section, there are more requirements regarding the SMCCC version
when SVE/SME are supported. I don't see a practical problem if the check is
missed since the combination of TF-A and TF-RMM are the only RMM-spec-v2.0-bet3
implementation (as I knew) where the SMCCC version has been set to v1.5 in the
'master' branch.

Thanks,
Gavin

> Suzuki
> 
>>          return -ENXIO;
>>
>> Thanks,
>> Gavin
>>
>>> +
>>> +    rmi_smccc_invoke(&res);
>>> +    if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
>>> +        return -ENXIO;
>>> +
>>> +    version_major = RMI_ABI_VERSION_GET_MAJOR(res.a1);
>>> +    version_minor = RMI_ABI_VERSION_GET_MINOR(res.a1);
>>> +
>>> +    if (res.a0 != RMI_SUCCESS) {
>>> +        unsigned short high_version_major, high_version_minor;
>>> +
>>> +        high_version_major = RMI_ABI_VERSION_GET_MAJOR(res.a2);
>>> +        high_version_minor = RMI_ABI_VERSION_GET_MINOR(res.a2);
>>> +
>>> +        pr_err("Unsupported RMI ABI (v%d.%d - v%d.%d) we want v%d.%d\n",
>>> +               version_major, version_minor,
>>> +               high_version_major, high_version_minor,
>>> +               RMI_ABI_MAJOR_VERSION,
>>> +               RMI_ABI_MINOR_VERSION);
>>> +        return -ENXIO;
>>> +    }
>>> +
>>> +    pr_info("RMI ABI version %d.%d\n", version_major, version_minor);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> [...]
>>
>>
>>
> 

