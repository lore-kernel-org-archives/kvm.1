Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A73EEAC7
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820864; cv=none; b=dz8I839qAzm/1/YpUasZ7zge6LwUiaDqMzAy0LHUP1XpsnYeXLw/4BkG7x2iksbGzmz+xlVFTOx78LAL5T8jkSOR38NcxZRnf1Wwxjlqkp+MMPP3RJT5WT2GyCVKjmT1FoJAa/vJ+POdTb3q3v16adMznxkpLW1VDGZNXcFXWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820864; c=relaxed/simple;
	bh=w6hnYrwGa6fUIEho02iLQbUb4586aB2uHSK/Hsp/sHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhPquq1G6pH11zCgPnzZN5PhggKWlSzfbtg5sVTW5qOVr/symBXcxGgtdmJqb6ukwKWKD82SbNbArcj+8i3xXJfswHhQ34R/g3b1uB5EgLnBfnophSAqurHP4SA0GP/ckfoG1xz0LCxVVMRAbZr2f7FGNGrgHoBzFf07yKmknNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpNUMHaN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tn/CXQ+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpNUMHaN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tn/CXQ+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788820862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L602+dgOHuBuqXjtZSYxQyf+Lxw66t1x8qHXG257FZg=;
	b=CpNUMHaNfUDnX8+wCMSlcEercrwuB8Xmn8f9uH54AY9RfQCTBzY1iz3qtbQPFPhz287fva
	dXSiJmzT5JK7bKQzPA3smh4htnsoKgYc6/Is4ZertNfsQ2OskBzlO0O+3Fxqdo/9gVsHGN
	eJ6QzG+Y0NpZuGKZCOCPgXEbMhrd2YM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-cjCfwX1HPa-fkTLDZClbtQ-1; Mon, 07 Sep 2026 18:41:00 -0400
X-MC-Unique: cjCfwX1HPa-fkTLDZClbtQ-1
X-Mimecast-MFC-AGG-ID: cjCfwX1HPa-fkTLDZClbtQ_1788820860
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db3734d06dso44084005ad.0
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788820860; x=1789425660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L602+dgOHuBuqXjtZSYxQyf+Lxw66t1x8qHXG257FZg=;
        b=tn/CXQ+oas/ULJgVzaznDKIUVZ2KRzuCFHQyLPr1M1Ky0rlzG8CFl8JkHy0ihNrO62
         035nVtvF7E0nbrtDXZbLOD1TuE0mzPkgBOhyMeZsoB+F5HsKBWcI35HdTYEWc+M5WvB7
         EWXHhMJvxRw4ACi3xT8513Ptf/bTnI0ucAnuON3REAZ5hW6mnpBWjX+lWDUIywgc0NXK
         V0wDE1tx2rlaL9Nk5lKKVBWQ6znCwfyjt++V+T5IUTHUnZhftUzyKzRLF+7Uj4byP1kB
         WAO6ytCUWiO90T608JT6z+3IPSBqmpZ+3e8yNrJXU7ydlbnlnxbiH1k6GoR8w0hZyWZn
         1IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788820860; x=1789425660;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L602+dgOHuBuqXjtZSYxQyf+Lxw66t1x8qHXG257FZg=;
        b=Q0rit2BjGnGc7hkNdwWipsDjnag38MzzrQKW9t0C9a2hULY7UKMimAhBREdfUilZMB
         WqgFej4tdY2nPwB1WfBhi9ldQjtmc70wNlw+hOUFXVgemW0bcW6GshqP3y5K6nQ8gHIW
         FN2YTAOVSYvkIyNPZJvxL4pXoG9nwtReLm9+6j6hlLhdYZ+Iy/+XuzJn7HQGJG9nUxqG
         ahzXiOiVqSVt1DbmKYU+pt7IjihpA/JUJVS6wUAUK+w86lNLXTayhcLuUFE2RKPTOSel
         nb52N4R1c4+hmhDmgG/fMNT9UPn4ziiMP3zh4l8MKx0b+b3Bdr0X5s4AV6/hp8eny42B
         j2Wg==
X-Forwarded-Encrypted: i=1; AKwUvBxsExwB24HjjD/MzSkVKenQwYiNvYTegRnKUzzW6yqvxmrDoTtJ1zyQHZwqQ2LJGtUPifs=@vger.kernel.org
X-Gm-Message-State: AFuF++kjzPlngWL3jeIvncP+AHwa7ydnhzi+mCSj9KNC9cgTJfx6sqgC
	B9FHXigrdOBT6yGFTPYdig4X0CbAwe7+RIxngdYH3icbTKKz1MTcInw0c6Kvg11Iqv0dRMvbrlG
	T6VPKBfo55Jr4aV6DPZlHyAKVZOv0yNM5iCLsMBFywS+w76HM2QFbFQ==
X-Gm-Gg: AYBFou2wIfoVxkPjAMOQ5oxZyeWQZPTskipwr4CZIA86ejK7XUEm0ql+KolyYHdm9xa
	fRUqw3g3+S6GLfCz9f2uKNNMbnqWZwdjlZDwmXaXaFBmTalu3MDExImoH59kPKC1fH90Kj/+I4v
	uCmiml5Km9zB+08TBy1+fJOxI65SiZbVYVDzMgEq1dDBfnJ0yWZMf5gpBhFhVq6eDY5er38gkQ6
	Xj2oVGlO9iCZWsO5jYO4enEZ2P4ZMBKiN26trwoT7dF+D+lHfslbWBk1NENi+a0F/AtjnEpNt47
	z0W39KBbTVHg/EiQvn1z5FWGnSpgDazsM+C8qXHaNY+atWjum+qgkPb2k9kNsorRz/YJOSHPsqx
	3UhRS5J6GciS+SSIegs3rYTrpJA3Waj7OYiirZBTL1A==
X-Received: by 2002:a17:902:6ac3:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2db127cde0fmr287844955ad.12.1788820859668;
        Mon, 07 Sep 2026 15:40:59 -0700 (PDT)
X-Received: by 2002:a17:902:6ac3:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2db127cde0fmr287844615ad.12.1788820859141;
        Mon, 07 Sep 2026 15:40:59 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db146b9691sm49351165ad.0.2026.09.07.15.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 15:40:58 -0700 (PDT)
Message-ID: <64533fd0-5fe7-4839-8302-c5b6674bcb5a@redhat.com>
Date: Tue, 8 Sep 2026 08:40:50 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/7] firmware: arm_rmm: Configure the RMM with the
 host's page size
To: Suzuki K Poulose <suzuki.poulose@arm.com>, sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
 kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <20260907095942.1140734-4-suzuki.poulose@arm.com>
 <20260907101446.1DA321F00A3A@smtp.kernel.org>
 <bade4920-2db1-4a8a-99d1-ca2694647ec8@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <bade4920-2db1-4a8a-99d1-ca2694647ec8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suzuki,

On 9/7/26 10:02 PM, Suzuki K Poulose wrote:
> On 07/09/2026 11:14, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] The SMC call leaves parameters X2-X7 uninitialized, violating the RMM's RES0 requirement.
>> - [High] The `struct rmm_config` fields are populated using native endianness, which breaks on Big Endian kernels.
>> -- 
>>
>> commit 1741e17729c2ff5e23bc8bfb00cc50a61f38ebb7
>> Author: Steven Price <steven.price@arm.com>
>> firmware: arm_rmm: Configure the RMM with the host's page size
>>
>> This commit adds support to configure the RMM's granule size to match the
>> host's page size during kernel initialization. It reads the feature
>> registers to ensure the requested page size is supported and sends the
>> configuration to the RMM via an SMC call.
>>
>>> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
>>> index 008a783407b4e..76f91c145e1fd 100644
>>> --- a/drivers/firmware/arm_rmm/rmi.c
>>> +++ b/drivers/firmware/arm_rmm/rmi.c
>>> @@ -77,6 +77,60 @@ static int rmi_read_features(void)
>>>       return 0;
>>>   }
>>> +static int rmi_configure(void)
>>> +{
>>> +    unsigned long granule_feature;
>>> +    unsigned long granule_size;
>>> +    int ret = 0;
>>> +    struct rmm_config *config;
>>> +
>>> +    switch (PAGE_SIZE) {
>> [ ... ]
>>> +
>>> +    config = (struct rmm_config *)get_zeroed_page(GFP_KERNEL);
>>> +    if (!config)
>>> +        return -ENOMEM;
>>> +
>>> +    config->rmi_granule_size = granule_size;
>>> +
>>> +    /*
>>> +     * For now we set the tracking_region_size to 0 which is the only option
>>> +     * for 4KB PAGE_SIZE (1GB for 4KB PAGE_SIZE, 32MB/512MB for 16KB/64KB).
>>> +     * TODO: Support other tracking sizes via Kconfig option for other
>>> +     * PAGE_SIZES
>>> +     */
>>> +    config->tracking_region_size = 0;
>>
>> [Severity: High]
>> Does this code handle endianness correctly?
>>
>> The struct rmm_config fields are populated using native u64 assignments.
>> On an ARM64 kernel compiled with CONFIG_CPU_BIG_ENDIAN=y, this writes
>> big-endian bytes into the shared memory. The RMM, which runs in little-endian
>> at EL2, will misinterpret these fields.
>>
>> Will this cause the RMM firmware to read invalid configuration values (like a
>> byte-swapped granule size) and fail to configure, breaking RMI support on Big
>> Endian systems?
>>
> 
> We don't plan to support RMM for Big Endian Linux. I have now made the ARCH_SUPPORTS_RMM to depend on !CPU_BIG_ENDIAN
> 

You probably need to avoid referring to CPU_BIG_ENDIAN as it's being dropped
by PATCH[v2 13/14] in Will's series to removed unused big-endian support on
arm64 [1].

[1] [PATCH v2 00/14] arm64: Remove unused big-endian support
     (https://lore.kernel.org/linux-arm-kernel/20260907163726.17104-14-will@kernel.org/)

Thanks,
Gavin

>>> +
>>> +    ret = rmi_rmm_config_set(virt_to_phys(config));
>>> +    if (ret) {
>>> +        pr_err("RMM config set failed\n");
>>> +        ret = -EINVAL;
>>> +    }
>>> +
>>> +    free_page((unsigned long)config);
>>> +    return ret;
>>> +}
>> [ ... ]
>>> diff --git a/include/linux/arm-rmi-cmds.h b/include/linux/arm-rmi-cmds.h
>>> index 2fb1f7f86d71e..9aa27697e2377 100644
>>> --- a/include/linux/arm-rmi-cmds.h
>>> +++ b/include/linux/arm-rmi-cmds.h
>>> @@ -12,6 +12,23 @@
>>>   unsigned long rmi_feat_reg(unsigned long id);
>>> +/**
>>> + * rmi_rmm_config_set() - Configure the RMM
>>> + * @cfg_ptr: PA of a struct rmm_config
>>> + *
>>> + * Sets configuration options on the RMM.
>>> + *
>>> + * Return: RMI return code
>>> + */
>>> +static inline int rmi_rmm_config_set(unsigned long cfg_ptr)
>>> +{
>>> +    struct arm_smccc_res res;
>>> +
>>> +    arm_smccc_1_1_invoke(SMC_RMI_RMM_CONFIG_SET, cfg_ptr, &res);
>>
>> [Severity: High]
>> Does this SMC call leave parameters x2 through x7 uninitialized?
>>
>> The arm_smccc_1_1_invoke macro only generates inline assembly constraints
>> for the explicitly provided arguments. It does not zero-pad omitted arguments,
>> leaving registers x2 through x7 with whatever was previously in them.
>>
>> Since the RMM firmware expects unused SMC parameters to be zero (RES0),
>> could passing uninitialized values cause the RMM to reject the command
>> with an INVALID_PARAMETER error and sporadically break RMM initialization?
> 
> Correct, I have now moved all RMI calls to smccc_1_2, making sure that
> all the undefined arguments are initialised to 0.
> 
> Cheers
> Suzuki
> 
> 
>>
>>> +
>>> +    return res.a0;
>>> +}
>>
> 
> 

