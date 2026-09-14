Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CE36657B
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379430; cv=none; b=olOLcw6BM0hINSwfYuHyOkCGXiY0a+3F7UsdEvFXyaQCASZ8ogSoxhF/3Ex/IDBobXRFMrsuPNhDa28wKKKAfFBfannm1lN9+cJ8FGV83R6l/27jxciQRyReg6Y1VqRQ5N3EPMVRIQFgMjVo+TmFZdTson/C05kYVOUPGNinTQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379430; c=relaxed/simple;
	bh=kylQFAzh35/Kr/cF4hIu5aA/58qReMn3tf26L0Lxe+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFFMBG5H22UVEhtDCahp1zBc840lf6koxrsi1G2PD74A0vABDy9gu275csWL7Qe+LM0+pHQU6eKwRKr8OpaeB6tIUDbVQvYPBkK7U7RrjwZ77yy34twu+tm4MUr+7POwpCLh2gXQN1zXfTpdxkKiXrRrhFGRzVK6n3F6p1mkAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbsVGoz8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4z2P0ZI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbsVGoz8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4z2P0ZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789379428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS5txPMa8dcMMZaluUjmTNiCxS+esxKMHPUrHUieImQ=;
	b=NbsVGoz8R2on7SV+rhwtAVTRz8nvr+UmgLB7+pXm+2ovzDiZSefXhFzjzr+J8hRJ8Kt6og
	ogzkw6fA/qynID0smZERG1r0lzNZnS5gg+7/Ja/QXudCBRYPbdZN8oPr47XPl16PSYy/z9
	RzPfKzJqwTlBZQbC7jRcHXbciOJiQc4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-Kvv3byCEPAKx5fwfcFATzQ-1; Mon, 14 Sep 2026 05:50:25 -0400
X-MC-Unique: Kvv3byCEPAKx5fwfcFATzQ-1
X-Mimecast-MFC-AGG-ID: Kvv3byCEPAKx5fwfcFATzQ_1789379424
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so4091545a12.3
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789379424; x=1789984224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS5txPMa8dcMMZaluUjmTNiCxS+esxKMHPUrHUieImQ=;
        b=K4z2P0ZI751g6O1022D1CCaiILnXhh+a7PrmmbQVktwoLCFN67l7BWtxmDxlAgNtLK
         ANDszsmSzYPVcHBVVGzm29GGsCWZ8ZyIU6JgN9ua9e2d1Bgbw5wGZZGeMgMCgjNTJADD
         BxRZeGkVFXE9j3tKIY9nSPPubRwC8UVcBkTQLYXWcHQTWZpa2RiqtayJ7L9QFVl6Dz6x
         MPrabX899CF5MLWP8DYBNP9J3pHI5bRU+df/SWfkH4malHOmKFgrrIde4JUD9sSMUNzQ
         F2YZuhRUhye0QBjvl3mjZ92TMOc5LaKKUDo/doiftqNnvOr9JPfTTTD8l6YUcFexgFz/
         r2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379424; x=1789984224;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GS5txPMa8dcMMZaluUjmTNiCxS+esxKMHPUrHUieImQ=;
        b=tGnv5EnQbrzKDNF9IVX/emsYGKqV2lDeOPM/7J6h6xEeNLqfMqq1MNZPfq2KWyr/FE
         whWQQserAQP7sUFHoJgco74MwPGLKoyidx2B98I4z+pwuMRo+ljS0H9rgBWd0GXHBu1X
         9ndxt01mPPxfSoNBe+75k6//pqmljwD2lW5s2WqZ623TnajCzBewS56aJMKZtQCiREjf
         wtmyn2zL7F8TKZrXDnNk1ra0vDtQ/F4gUM7VUkddXVNmYSCdJ9d6rmHkIlSOe0rPaHow
         pWbmrrCyVKcNimjvKNl1wK4iauX+kMUHfzhVZltqFs3w7yUF+fSIAHRzaVI+iVgSHY8j
         9MVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKcylgPW3cOwD2PhnLpZD90tdtFmqmZVPHk01I+KAsanea6bYlAzZW9o8omXdrbAVYGLE=@vger.kernel.org
X-Gm-Message-State: AFuF++kTnyeWn/MuMfC7uU3s+As79zMYXsbEkjRJEZXB2X+MPuFkKl6v
	W0aNVreBDmsQMbHhREnEo0rG8yejhKQiUocacwwX50ix08p8W4vbwPpl51W+ztU3WF93ryFyr0I
	aC88usfUuZb4xiBBDTdsm+OYSCRS4N1y2lN5+eYhcGXlD4vKJAKuUKQ==
X-Gm-Gg: AYBFou24OUzBAnVNdB/WLg2+M0ay7yCKtLYY3acHY3HwR++wdnGMc/QSLXsw5r+Mk8Q
	eE0ktTnlM586z+/MW1BAbA5aF5L0w8WyVQoF/MVQHrghkFhZrA0PUqnkNs95NwMWgPv7YM//G/L
	WDaDj2OEpl1nNMHegqGyx1up9x4nzmGkUj1r5ElEzL+ZZZj3XpC1ldf7kF5nPdXcTNV8nmOVS33
	4vevTSCvjMMbMEGXhnPD7r5bIrUDIp2WELJXs2a5hqz3FYwWnP/T3dFL3a/nGiR2eGKJMf4Wb/f
	H4QhsUEju8O9PtGnVUHMCUNDvOW5GKZHAgAaW+BJu74EaOWU0zYFL4q92KNcL3mXymFuMzZ/EdP
	GR4RxYdplYfnQSARjQufgDi/Fo4V4DMnKQzTvoQw7LA==
X-Received: by 2002:a05:6a20:7f9c:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3db4052063emr3632225637.13.1789379424389;
        Mon, 14 Sep 2026 02:50:24 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f9c:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3db4052063emr3632178637.13.1789379423970;
        Mon, 14 Sep 2026 02:50:23 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm30439434eec.19.2026.09.14.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 02:50:23 -0700 (PDT)
Message-ID: <25706923-8e9c-4785-a80d-b138478ad374@redhat.com>
Date: Mon, 14 Sep 2026 19:50:12 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 4/7] firmware: arm_rmm: Add support for SRO
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
 <20260912083611.2513845-5-suzuki.poulose@arm.com>
 <f00d01d1-8df0-4865-8e52-c85171cf4ca5@redhat.com>
 <4f18aa66-2296-4b63-87f5-6ab493faecbc@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <4f18aa66-2296-4b63-87f5-6ab493faecbc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Suzuki,

On 9/14/26 4:22 PM, Suzuki K Poulose wrote: 
> On 14/09/2026 06:04, Gavin Shan wrote:
>> On 9/12/26 6:36 PM, Suzuki K Poulose wrote:
>>> RMM v2.0 introduces the concept of "Stateful RMI Operations" (SRO). This
>>> means that an SMC can return with an operation still in progress. The
>>> host is expected to continue the operation until it reaches a conclusion
>>> (either success or failure). During this process the RMM can request
>>> additional memory ('donate') or hand memory back to the host
>>> ('reclaim'). The host can request an in progress operation is cancelled,
>>> but still continue the operation until it has completed (otherwise the
>>> incomplete operation may cause future RMM operations to fail).
>>>
>>> The SRO is tracked using a struct rmi_sro_state object which keeps track
>>> of any memory which has been allocated but not yet consumed by the RMM
>>> or reclaimed from the RMM. This allows the memory to be reused in a
>>> future request within the same operation. It will also permit an
>>> operation to be done in a context where memory allocation may be
>>> difficult (e.g. atomic context) with the option to abort the operation
>>> and retry the memory allocation outside of the atomic context. The
>>> memory stored in the struct rmi_sro_state object can then be reused on
>>> the subsequent attempt.
>>>
>>> Wrappers for SRO RMI commands are also provided here because they depend
>>> on the rmi_sro_execute() implementation added by this patch.
>>> Delegate/undelegate handles are also added here because they now use the
>>> SRO/stateful command infrastructure and are also used for the memory
>>> DONATE/RECLAIM flows.
>>>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> Co-Developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

scripts/checkpatch.pl recommends s/Co-Developed-by/Co-developed-by, the same
format issue exists in other patches and please double check.

>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 
> 
>>> ---
>>>   drivers/firmware/arm_rmm/rmi.c | 586 +++++++++++++++++++++++++++++++++
>>>   include/linux/arm-rmi-cmds.h   |  41 +++
>>>   2 files changed, 627 insertions(+)
>>>
>>> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/ arm_rmm/rmi.c
>>> index 5b0e342ce3d58..4f9898ece7547 100644
>>> --- a/drivers/firmware/arm_rmm/rmi.c
>>> +++ b/drivers/firmware/arm_rmm/rmi.c

[...]

>>> +
>>> +static void rmi_op_continue(unsigned long sro_handle, unsigned long flags,
>>> +                struct arm_smccc_1_2_regs *out_regs)
>>> +{
>>> +    *out_regs = (struct arm_smccc_1_2_regs) {
>>> +        SMC_RMI_OP_CONTINUE, sro_handle, flags
>>> +    };
>>> +
>>> +    rmi_smccc_invoke(out_regs);
>>> +}
>>> +
>>
>> The pattern 'regs' is used in some of the 'struct arm_smccc_1_2_regs' arguments
>> or variables in this series, which is incosistent to the existing patterns which
>> is either 'args' or 'res' by searching the source files using 'git grep arm_smccc_1_2_regs'.
>> So I would suggest we have the fixed the pattern 'args' :-)
> 
> 
> I would prefer to keep it "regs" as, unlike the smccc_1_1 calls, we
> pass "arm_smccc_1_2_regs" for both arguments and results. In this case
> we are using a single structure, so, to avoid the confusion, I
> intentionally used regs
> 

It's fine to keep "regs" pattern, then the only place using "args" is
rmi_smccc_invoke(). I think the variable or argument names in rmi_smccc_invoke()
can be improved there to use "regs" pattern. With this, we have the unified
pattern "regs".

static inline void rmi_smccc_invoke(struct arm_smccc_1_2_regs *pregs)
{
         struct arm_smccc_1_2_regs regs = *pregs;
		:
}

Thanks,
Gavin

