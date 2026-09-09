Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E23EE1DB
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938179; cv=none; b=Ug1kShfA+syy+abQPvyo2YKk9+uyVufs4Xb0vlfC0I/r01FjvecrsKxbdwm0nc4gWblAYtph+utTPocSgIuY0oqbb6ehMqX2VI/yW26zRmc/43IhfqXsPyEVbMP7OX+X9fhzz95A2w4ubpkzJPUg3yi75lv1tqSoycQeQlIW1CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938179; c=relaxed/simple;
	bh=lNRh4Ug+0jrMIbREJmjMQuXJJOWFiwwwa8CKqxJCEBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW+Y+Hj6L3BWj6cJRLlm8+Tdfsoh3dGwMeV9kSjWBjjr3RKwuy5hrqaaU6MV3RJLCi2+Lsxc22eqPM9O7bARCAtuEBbE/N0GaRflqpQYs2+f/XDlkRV9kRniPKWqi9ipT43fkJ1OT/ujheiXKBFRy26o0RW5raoZVs8wnYLwpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB2CAXm5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBGAZjuY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB2CAXm5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBGAZjuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788938172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nSCBRaPtDIkAJm5QAiHh9cgImBPw7ThpI3/NAdqqvM=;
	b=OB2CAXm52VrvOKukRwZ2RVriqDyieslVzt8rWVrNxgaK6/8AAHgHI9G/wxy0R722xdu9J7
	CCIrS2KqmP7zrFoOu5tWer3s0kEcR/41noDq7/2wCiq+xT/N8jaI6/cZWn57GjBqJ+O3Dj
	hpIQaCdD7uv5Y/0tFUNGcgHYQVuJTmE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-r1FdIvdIOs2N8wRAV--MsQ-1; Wed, 09 Sep 2026 03:16:11 -0400
X-MC-Unique: r1FdIvdIOs2N8wRAV--MsQ-1
X-Mimecast-MFC-AGG-ID: r1FdIvdIOs2N8wRAV--MsQ_1788938170
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so8546885a91.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788938170; x=1789542970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nSCBRaPtDIkAJm5QAiHh9cgImBPw7ThpI3/NAdqqvM=;
        b=BBGAZjuYlG2nBr4SCCKXsF5JfFqIIcUNpm3OVO3w/J5Yk/Lvl5TUU8zfebOS18J3Me
         cF9bzw2PDftkFF3JOAO8JoequCbdLfckCvZobSOwgw5w1nsioWVloKbblVYP1d2H4u9c
         PgZXaNqiUyVHD+yaXaPGR1GVL73pKlzr3UWaGdcbhte0YpnTAs29f5UhMry/sEpNOVQn
         I92aIhnPc0Plmqa874d2n2dMpqTcMEPEwAg4oRYpAgz4hnAJ+mOLXGMu0JukzINoFSbn
         +3BXZ5l/0X5wjnzlXVZkdl0opRa4p40qJ+2o15ZCFomoEK1hoWPQ7FdU5pJWNAc2/Fk8
         +UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788938170; x=1789542970;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nSCBRaPtDIkAJm5QAiHh9cgImBPw7ThpI3/NAdqqvM=;
        b=PzNveheeNdR6CPiIqUIHpNPLZJ+C6B4rVDAAWUeaYPfXWYHtVBUZvhyxTqZzlLQMHE
         pCxt3HVp1TI/6XyN0OQZuK4ydcNVV0vLhubwcVq0en59foU9g9JR7BaffmVPb1fTNR7E
         dXDKifnz5fvDh3QTUzqq41z3p7EwYtq2aM7oYpuQr2FEJe6ggaVlKesMG6JVeJ1fjCtG
         mOFxouRQ2GXOV4NoVp/VrFFsMRr+rHoEB0ovR7+9kUfUQ/1R39nvsbgPrG3KnlJUwZPg
         MPNOWyKZM8kLyNSUuiZEqFc1ZJUl/ljPTCAKjbqORErEy3WwJt8yKms9tUdJrdO6w5ny
         cgSw==
X-Forwarded-Encrypted: i=1; AKwUvByoEFgFIHzOITRKEMnb4wHw0TCZMt6ovUi/hCGAn8zuNbwYH+xYSzFTsHVKVk+YNlexOgA=@vger.kernel.org
X-Gm-Message-State: AFuF++nbUfgYDuaqDMzRNhWF3/d12y3HoSV3EoLiG6/eHWOaIR94wOT0
	G9/YheENECeRvD+LVNUcKFc5IlwUy+dhncmCUOEQMZrIwE/oF9p/30P+qwgGMX9lgCWXFVApPdD
	vqyTqzxkHy2AjKd1iMps0pciKNFfa+tnG5tFkiAAvlWsK5lyzrtqAHA==
X-Gm-Gg: AYBFou0gzpUi9YdDua6uGjdwOOuwgKOD1DnhAdinycRzjfE+Kqw02b17lN/yWMX5OPU
	Y9LJFJyupQpPs+wCZxlqP7DMfujtzE0AvhMrk4DbBA06NMMyfSkFAGKcnnK8aGmDxaQcktvyK+e
	RubRh21nTNi37Crx1Jv2th5PB/hnXkvwzijzn22fkl/Yzr5iTHu6MR+J67veqfSXQAtp6vMCR9n
	2/kJD852R6Hx+UU/5tL0dAu+NHsHc/0IhUqP7lMHxCGQq1clws8QqO3wPdJuILusI8FSdydSFhb
	oUOPnuK7uUi9HARybeQmOCBFqyhfZmIJy2FaQFrUdiJy/dpMWUH7+hzdQou70Y4ifFCIwiNs6rz
	DxyPQpF+nYER79gzsp/qH0J/YnnqTotc5OUHHZP997w==
X-Received: by 2002:a17:90b:5743:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-39b8bc9422emr8480334a91.2.1788938169586;
        Wed, 09 Sep 2026 00:16:09 -0700 (PDT)
X-Received: by 2002:a17:90b:5743:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-39b8bc9422emr8480293a91.2.1788938168914;
        Wed, 09 Sep 2026 00:16:08 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm37441647a91.15.2026.09.09.00.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 00:16:08 -0700 (PDT)
Message-ID: <de7e2d98-2faa-4e16-8164-d7247d31dbd5@redhat.com>
Date: Wed, 9 Sep 2026 17:15:56 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 7/7] firmware: arm_rmm: Add wrappers for Realm related
 RMI commands
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <20260907095942.1140734-8-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260907095942.1140734-8-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 7:59 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> Introduce wrappers for the RMI functions needed for creating and
> managing realm guests. This will be used by the KVM to manage the
> Realms
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v16:
>    * Split into a separate patch and move away from arch/arm64 to
>      include/linux/.
>    * Also moved into the firmware_rmm series from the KVM CCA support.
>      This is done in a hope to reduce the merge conflicts and make
>      the KVM CCA upstreaming in independent parallel chunks
> ---
>   include/linux/arm-rmi-cmds.h | 453 +++++++++++++++++++++++++++++++++++
>   1 file changed, 453 insertions(+)
> 
> diff --git a/include/linux/arm-rmi-cmds.h b/include/linux/arm-rmi-cmds.h
> index 79e2c1f165112..746257d77dd61 100644
> --- a/include/linux/arm-rmi-cmds.h
> +++ b/include/linux/arm-rmi-cmds.h
> @@ -222,4 +222,457 @@ static inline long rmi_granule_range_undelegate(unsigned long base,
>   	return ret;
>   }
>   
> +/**
> + * rmi_rtt_data_map_init() - Create a protected mapping with data contents
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

s/Create a protected mapping with data contents/Create a mappings in protected IPA with known contents

With this, it's consistently counterpart of the comments for rmi_rtt_data_map().

> + * @rd: PA of the RD
> + * @data: PA of the target granule
> + * @ipa: IPA at which the granule will be mapped in the guest
> + * @src: PA of the source granule
> + * @flags: RMI_MEASURE_CONTENT if the contents should be measured
> + *
> + * Create a mapping from Protected IPA space to conventional memory, copying
> + * contents from a Non-secure Granule provided by the caller.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_data_map_init(unsigned long rd, unsigned long data,
> +					 unsigned long ipa, unsigned long src,
> +					 unsigned long flags)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_DATA_MAP_INIT, rd, data, ipa, src, flags
> +	};
> +
> +	return rmi_sro_execute(&regs);
> +}
> +
> +/**
> + * rmi_rtt_data_map() - Create mappings in protected IPA with unknown contents
> + * @rd: PA of the RD
> + * @base: Base of the target IPA range
> + * @top: Top of the target IPA range
> + * @flags: Flags
> + * @oaddr: Output address set descriptor
> + * @out_top: Top address of range which was processed.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_data_map(unsigned long rd,
> +				    unsigned long base,
> +				    unsigned long top,
> +				    unsigned long flags,
> +				    unsigned long oaddr,
> +				    unsigned long *out_top)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_DATA_MAP, rd, base, top, flags, oaddr
> +	};
> +	long ret;
> +
> +	ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS && out_top)
> +		*out_top = regs.a1;
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rtt_data_unmap() - Remove mappings to conventional memory
> + * @rd: PA of the RD for the target Realm
> + * @base: Base of the target IPA range
> + * @top: Top of the target IPA range
> + * @flags: Flags
> + * @oaddr: Output address set descriptor
> + * @out_top: Returns top IPA of range which has been unmapped
> + * @out_range: Output address range
> + * @out_count: Number of entries in output address list
> + *
> + * Removes mappings to convention memory with a target Protected IPA range.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */

It would be worthwhile to mention 'in protect IPA' where the mappings are
teared down. Besides, 'for the target Realm' can be dropped from the comments
for @rd.

/**
  * rmi_rtt_data_unmap() - Remove mappings to conventional memory in protected IPA
  * @rd: PA of the RD
  *  :
  */

> +static inline long rmi_rtt_data_unmap(unsigned long rd,
> +				      unsigned long base,
> +				      unsigned long top,
> +				      unsigned long flags,
> +				      unsigned long oaddr,
> +				      unsigned long *out_top,
> +				      unsigned long *out_range,
> +				      unsigned long *out_count)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_DATA_UNMAP, rd, base, top, flags, oaddr
> +	};
> +	long ret;
> +
> +	ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS) {
> +		if (out_top)
> +			*out_top = regs.a1;
> +		if (out_range)
> +			*out_range = regs.a2;
> +		if (out_count)
> +			*out_count = regs.a3;
> +	}
> +
> +	return ret;
> +}

The nested if statements can be avoided if we have:

	if (ret != RMI_SUCCESS)
		return ret;

	if (out_top)
		*out_top = regs.a1;
	if (out_range)
		*out_range = regs.a2;
	if (out_count)
		*out_count = regs.a3;

	return RMI_SUCCESS;

> +
> +/**
> + * rmi_psci_complete() - Complete pending PSCI command
> + * @calling_rec: PA of the calling REC
> + * @status: Status of the PSCI request
> + *
> + * Completes a pending PSCI command.
> + *
> + * Return: RMI return code
> + */
> +static inline long rmi_psci_complete(unsigned long calling_rec,
> +				     unsigned long status)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PSCI_COMPLETE, calling_rec, status, &res);
> +
> +	return res.a0;
> +}
> +
> +/**
> + * rmi_realm_activate() - Active a realm
> + * @rd: PA of the RD
> + *
> + * Mark a realm as Active signalling that creation is complete and allowing
                                                          ^^^^^^^^

s/complete/completed ?

> + * execution of the realm.
> + *
> + * Return: RMI return code
> + */
> +static inline long rmi_realm_activate(unsigned long rd)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_REALM_ACTIVATE, rd, &res);
> +
> +	return res.a0;
> +}
> +
> +/**
> + * rmi_realm_create() - Create a realm
> + * @rd: PA of the RD
> + * @params: PA of realm parameters
> + * @sro: Preallocated SRO context to be used

We needn't to have 'to be used. This comment applies to other helpers
like rmi_realm_terminate(), rmi_realm_destroy(), rmi_rec_create(),
rmi_rec_destroy() where a preallocated SRO context is needed.

     * @sro: Preallocated SRO context

> + *
> + * Create a new realm using the given parameters.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_realm_create(unsigned long rd, unsigned long params,
> +				    struct rmi_sro_state *sro)
> +{
> +	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL,
> +				   SMC_RMI_REALM_CREATE, rd, params);
> +}
> +
> +/**
> + * rmi_realm_terminate() - Terminate a realm
> + * @rd: PA of the RD
> + * @sro: Preallocated SRO context to be used
> + *
> + * Terminates a realm, moving it into a ZOMBIE state
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_realm_terminate(unsigned long rd,
> +				       struct rmi_sro_state *sro)
> +{
> +	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL,
> +				   SMC_RMI_REALM_TERMINATE, rd);
> +}
> +
> +/**
> + * rmi_realm_destroy() - Destroy a realm
> + * @rd: PA of the RD
> + * @sro: Preallocated SRO context to be used
> + *
> + * Destroys a realm, all objects belonging to the realm must be destroyed first.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_realm_destroy(unsigned long rd,
> +				     struct rmi_sro_state *sro)
> +{
> +	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL,
> +				   SMC_RMI_REALM_DESTROY, rd);
> +}
> +
> +/**
> + * rmi_rec_create() - Create a REC
> + * @rd: PA of the RD
> + * @rec: PA of the target REC
> + * @params: PA of REC parameters
> + * @sro: Allocated SRO context to be used

     * @sro: Preallocated SRO context

> + *
> + * Create a REC using the parameters specified in the struct rec_params pointed
> + * to by @params.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rec_create(unsigned long rd,
> +				  unsigned long rec,
> +				  unsigned long params,
> +				  struct rmi_sro_state *sro)
> +{
> +	long ret;
> +
> +	*sro = (struct rmi_sro_state){.regs = {
> +		SMC_RMI_REC_CREATE, rd, rec, params
> +	}};
> +	ret = rmi_sro_memxfer_execute(sro, GFP_KERNEL);
> +	rmi_sro_free(sro);
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rec_destroy() - Destroy a REC
> + * @rec: PA of the target REC
> + * @sro: Allocated SRO context to be used

     * @sro: Preallocated SRO context

> + *
> + * Destroys a REC. The REC must not be running.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rec_destroy(unsigned long rec,
> +				   struct rmi_sro_state *sro)
> +{
> +	return rmi_sro_memxfer_cmd(sro, GFP_KERNEL, SMC_RMI_REC_DESTROY, rec);
> +}
> +
> +/**
> + * rmi_rec_enter() - Enter a REC
> + * @rec: PA of the target REC
> + * @run_ptr: PA of RecRun structure
> + *
> + * Starts (or continues) execution within a REC.
> + *
> + * Return: RMI return code
> + */
> +static inline long rmi_rec_enter(unsigned long rec, unsigned long run_ptr)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_REC_ENTER, rec, run_ptr, &res);
> +
> +	return res.a0;
> +}
> +
> +/**
> + * rmi_rtt_create() - Creates an RTT
> + * @rd: PA of the RD
> + * @rtt: PA of the target RTT
> + * @ipa: Base of the IPA range described by the RTT
> + * @level: Depth of the RTT within the tree
> + *
> + * Creates an RTT (Realm Translation Table) at the specified level for the
> + * translation of the specified address within the realm.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_create(unsigned long rd, unsigned long rtt,
> +				  unsigned long ipa, long level)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_CREATE, rd, rtt, ipa, level
> +	};
> +
> +	return rmi_sro_execute(&regs);
> +}
> +
> +/**
> + * rmi_rtt_destroy() - Destroy an RTT
> + * @rd: PA of the RD for the target realm

     * @rd: PA of the RD

> + * @ipa: Base of the IPA range described by the RTT
> + * @level: RTT level
> + * @out_rtt: Pointer to write the PA of the RTT which was destroyed
> + * @out_top: Pointer to write the top IPA of non-live RTT entries, from entry
> + * at which the RTT walk terminated.
> + *
> + * Destroys an RTT. The RTT must be non-live, i.e. none of the entries in the
> + * table are in ASSIGNED or TABLE state.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code.
> + */
> +static inline long rmi_rtt_destroy(unsigned long rd,
> +				   unsigned long ipa,
> +				   long level,
> +				   unsigned long *out_rtt,
> +				   unsigned long *out_top)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_DESTROY, rd, ipa, level
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS) {
> +		if (out_rtt)
> +			*out_rtt = regs.a1;
> +		if (out_top)
> +			*out_top = regs.a2;
> +	}
> +
> +	return ret;
> +}
> +

The nested if statements can be avoided if we have:

	if (ret != RMI_SUCCESS)
		return ret;

	if (out_rtt)
		*out_rtt = regs.a1;
	if (out_top)
		*out_top = regs.a2;

	return RMI_SUCCESS;

> +/**
> + * rmi_rtt_fold() - Fold an RTT
> + * @rd: PA of the RD
> + * @ipa: Base of the IPA range described by the RTT
> + * @level: Depth of the RTT within the tree
> + * @out_rtt: Pointer to write the PA of the RTT which was destroyed
> + *
> + * Folds an RTT. If all entries with the RTT are 'homogeneous' the RTT can be
> + * folded into the parent and the RTT destroyed.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_fold(unsigned long rd, unsigned long ipa,
> +				long level, unsigned long *out_rtt)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_FOLD, rd, ipa, level
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS && out_rtt)
> +		*out_rtt = regs.a1;
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rtt_init_ripas() - Set RIPAS for new realm
> + * @rd: PA of the RD
> + * @base: Base of target IPA region
> + * @top: Top of target IPA region
> + * @out_top: Top IPA of range whose RIPAS was modified
> + *
> + * Sets the RIPAS of a target IPA range to RAM, for a realm in the NEW state.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_init_ripas(unsigned long rd, unsigned long base,
> +				      unsigned long top, unsigned long *out_top)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_INIT_RIPAS, rd, base, top
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS && out_top)
> +		*out_top = regs.a1;
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rtt_unprot_map() - Map unprotected granules into a realm
> + * @rd: PA of the RD
> + * @base: Base IPA of the mapping
> + * @top: Top of the target IPA range
> + * @flags: Flags
> + * @oaddr: Output address set descriptor
> + * @out_top: Top IPA of range which has been mapped
> + *
> + * Create mappings to memory within a target unprotected IPA range.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_unprot_map(unsigned long rd,
> +				      unsigned long base,
> +				      unsigned long top,
> +				      unsigned long flags,
> +				      unsigned long oaddr,
> +				      unsigned long *out_top)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_UNPROT_MAP, rd, base, top, flags, oaddr
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS && out_top)
> +		*out_top = regs.a1;
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rtt_set_ripas() - Set RIPAS for an running realm
> + * @rd: PA of the RD
> + * @rec: PA of the REC making the request
> + * @base: Base of target IPA region
> + * @top: Top of target IPA region
> + * @out_top: Pointer to write top IPA of range whose RIPAS was modified
> + *
> + * Completes a request made by the realm to change the RIPAS of a target IPA
> + * range.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_set_ripas(unsigned long rd, unsigned long rec,
> +				     unsigned long base, unsigned long top,
> +				     unsigned long *out_top)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_SET_RIPAS, rd, rec, base, top
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS && out_top)
> +		*out_top = regs.a1;
> +
> +	return ret;
> +}
> +
> +/**
> + * rmi_rtt_unprot_unmap() - Remove mappings within an unprotected IPA range
> + * @rd: PA of the RD
> + * @base: Base IPA of the mapping
> + * @top: Top of the target IPA range
> + * @flags: Flags
> + * @oaddr: Output address set descriptor
> + * @out_top: Top IPA which has been unmapped
> + * @out_range: Output address range
> + * @out_count: Number of entries in output address list
> + *
> + * Removes mappings to memory within a target unprotected IPA range.
> + *
> + * Return: 0 on success, positive RMI result code or negative Linux error code
> + */
> +static inline long rmi_rtt_unprot_unmap(unsigned long rd,
> +					unsigned long base,
> +					unsigned long top,
> +					unsigned long flags,
> +					unsigned long oaddr,
> +					unsigned long *out_top,
> +					unsigned long *out_range,
> +					unsigned long *out_count)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_RTT_UNPROT_UNMAP, rd, base, top, flags, oaddr
> +	};
> +	long ret = rmi_sro_execute(&regs);
> +
> +	if (ret == RMI_SUCCESS) {
> +		if (out_top)
> +			*out_top = regs.a1;
> +		if (out_range)
> +			*out_range = regs.a2;
> +		if (out_count)
> +			*out_count = regs.a3;
> +	}
> +
> +	return ret;
> +}
> +

The nested if statements can be avoided if we have:

	if (ret != RMI_SUCCESS)
		return ret;

	if (out_top)
		*out_top = regs.a1;
	if (out_range)
		*out_range = regs.a2;
	if (out_count)
		*out_count = regs.a3;

	return RMI_SUCCESS;
	

>   #endif

Thanks,
Gavin

