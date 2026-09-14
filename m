Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397C35674E
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364785; cv=none; b=kOGkylLjid9x7UFQHTA19o03PAXkHdnYadX3MegOKxOHQnhno0hxW8OJzdNHbPRuREweOd3QGFjyUupTtUM9VRTrWMpI2iy5S1sgezw5u1/RcQytHCpivRny48VjHYzCSI4tDZO/cmP87gaN58R0oMhcoAnCk6ZQxAU6TLizQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364785; c=relaxed/simple;
	bh=5QhzlNik2vb8WTv+Whr0AIXM6Glk/gD+Fu1duuDW/RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGsAxp/cgM2D11UhgKhdeUBRuHYuwvIdf/TK5z4sH6wBwsXwkh/bNcZI8oEPOQXN0m9EgPhFoaJRmCl4IOmvapHTj7rHMiEuT7qIpPPq3+g5zkY6oJCroUuOXcxQNtDFOPbGjBUCbOhO24mWfYG04+qbHRF1p+kT5Hb4Adhykpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oj78Vep7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oqHWD5Ss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj78Vep7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oqHWD5Ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789364782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YoZj7ULUnXFEUqLzayKbTSzQn3c5hbr/5knd21qzAo=;
	b=Oj78Vep72fcZDtcnB+z9Qfb/2D/xGcNgjf0YdE6lBNiQIz/Uyz3jOhut3NIQ5CUX+geMPT
	/8+oP03vGQpJM53Pndy1gEwTBv2nxwBPMoGPXUSVr0Pp896G1544hQZeUflcs/WfsYWs3Y
	0P3M/U4fRbRknobcMF2JmU/uj34NvUE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-wzM48OSePkyYdZPUXn-fiw-1; Mon, 14 Sep 2026 01:46:20 -0400
X-MC-Unique: wzM48OSePkyYdZPUXn-fiw-1
X-Mimecast-MFC-AGG-ID: wzM48OSePkyYdZPUXn-fiw_1789364779
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso5398237a91.2
        for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 22:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789364779; x=1789969579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YoZj7ULUnXFEUqLzayKbTSzQn3c5hbr/5knd21qzAo=;
        b=oqHWD5Ssinkzr5CNNLm6tX+ob2hDDjBEy07q6mE1mp60vaCNes2N2ieQq1Y+ywmOX+
         WHhDWsAEERT3Uu7oadZAWWiAblPiR85ZzEXhBnrNhkzxw0n2D6Z1NAbS6sp/XpGx0hdV
         aqRET5OjWz0aLcabiAqjgCxjrGRthGMSqLnwQLRhsQ5b0hIv3KWaqvzk4EVeAxUEG+pU
         Ynz40pJ6zQ0Ig2FtrFVIFNj+nOuPk0dUtS08UkO1oGhhdsyWKtbuYwJAp5Fccd1xG0t5
         OPbA1cmXkKEf5RCGopJsAUiOIjMNVu4S6BSUZq0oVh1J8sY9j8b2yyVlp8iq6V7024qT
         Wqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364779; x=1789969579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YoZj7ULUnXFEUqLzayKbTSzQn3c5hbr/5knd21qzAo=;
        b=HInDIdJ7+yfcevtEk39YCvg5I4Z+ybMhfQtByIAK+sr2h8nO6MFD51rxVjlu+T7Gje
         DtGodIEa+l2GpGxwJbs18xzmooXor/Kn4Vq2LsF9rUrzKLM1HEvmpcwCZUanyEOvVV0A
         QxO+Oja/WoqdUwMavAuOw9103mnYDFROLwLX3tYDkILmjtgeu3RS6B6ydDQvlpasWwnS
         N5jG5Mxk/xcSjKsR4Ce8l5KadPCRia/OJOdEHxto2p6H9GFbMWfZC1BKOWUeSsnIqPfh
         1yJgkw3kSkwCZF44wSv40uNHXXCEIOxeZ4B5xRV6IkgLZD3geNCSXPw2hJw76sr8qdaY
         6Nrg==
X-Forwarded-Encrypted: i=1; AKwUvBwLhKPtGezQbcAa5I5aVJxPhXMe01XDIpcGNHlEVRsxBEZqiMDu+G+AUFmmNzYmB90YZhg=@vger.kernel.org
X-Gm-Message-State: AFuF++kQHzUYknnEECfy8KaLgJJBKqiQbhJtNdQoWYXsuhrfSlrhvv7v
	zSV6Tv1I5Ht+6frWVyA3OEkNH+M5yw+WrD4d6Kf12Q0eUE+kh2cnlH1nlT8c0eA0aqYQUeYtfEP
	z0gDnuzAlyrvElREywhcZGmJ7OhVOGqItzHtIBgRkV9AGo94v1ItaOA==
X-Gm-Gg: AYBFou0gs1057/LQdlUvZzvyDztXSiNsxCg4ZZZipRDDehKsvNvM4FNnK2sNeHprmtj
	4E7Wy4XG40qOcSvDMCMLr4K1zjl0lFOjWDPhlQnPJSJgsn92YVlXpACHobfQhgHXhdzZrls+k6g
	76QTEn61jzAs4pMcDWU/Q1Rj5n+9COpG6HOKSw1q4Endx7Dw+e3L1XUrLNw6D19hrYTCrXcz0Lg
	wQAQtc3eEzYHVnj5aGzRryVN5683Q4ZOoxpFwLYCu7xkmAt69QK6x8+tlobjXUr6RiVp7xKzDPw
	Y69u+iNXCLXVyO1vn/Dn66fBrWUj57msc/mz3YzPHS2Yh6xnS6EYzxwp38QTQeucW5O+QNUfbW5
	tGqjkt6aSlivr2bOfnyGpdo75gMEQGpAd7n8pLZHQ9A==
X-Received: by 2002:a17:90b:39cc:b0:39d:b769:3067 with SMTP id 98e67ed59e1d1-39debdffe17mr2617489a91.0.1789364779231;
        Sun, 13 Sep 2026 22:46:19 -0700 (PDT)
X-Received: by 2002:a17:90b:39cc:b0:39d:b769:3067 with SMTP id 98e67ed59e1d1-39debdffe17mr2617413a91.0.1789364778584;
        Sun, 13 Sep 2026 22:46:18 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9d8aa131sm5474141a91.2.2026.09.13.22.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 22:46:17 -0700 (PDT)
Message-ID: <54ac0609-f111-45fb-9c82-3095ddbed006@redhat.com>
Date: Mon, 14 Sep 2026 15:46:06 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 7/7] firmware: arm_rmm: Add wrappers for Realm related
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
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
 <20260912083611.2513845-8-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260912083611.2513845-8-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/26 6:36 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> Introduce wrappers for the RMI functions needed for creating and
> managing realm guests. This will be used by the KVM to manage the
> Realms
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v17:
>    * Avoid nesting if conditions for output populating RMI calls
>    * Clean up comments
>    * Always use arm_smccc_1_2_invoke() for RMI calls.
> Changes since v16:
>    * Split into a separate patch and move away from arch/arm64 to
>      include/linux/.
>    * Also moved into the firmware_rmm series from the KVM CCA support.
>      This is done in a hope to reduce the merge conflicts and make
>      the KVM CCA upstreaming in independent parallel chunks
> ---
>   include/linux/arm-rmi-cmds.h | 461 +++++++++++++++++++++++++++++++++++
>   1 file changed, 461 insertions(+)
> 

One nitpick for rmi_rtt_data_unmap() below. With it addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/include/linux/arm-rmi-cmds.h b/include/linux/arm-rmi-cmds.h
> index 27a0c56944976..fd7ef7e82b246 100644
> --- a/include/linux/arm-rmi-cmds.h
> +++ b/include/linux/arm-rmi-cmds.h
> @@ -76,4 +76,465 @@ long rmi_sro_execute(struct arm_smccc_1_2_regs *regs);
>   	__ret;								\
>   })
>   
> +/**
> + * rmi_rtt_data_map_init() - Create a mapping at protected IPA, copying contents
> + *			     from a given non-secure source granule.
> + * @rd: PA of the RD
> + * @data: PA of the target granule mapped in the guest
> + * @ipa: IPA at which the granule @data will be mapped in the guest
> + * @src: PA of the source granule with contents
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
> + * rmi_rtt_data_map() - Create mappings in protected IPA range with unknown contents
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
> + * rmi_rtt_data_unmap() - Remove mappings to conventional memory at a protected
> + *			  IPA range
> + * @rd: PA of the RD
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
> +

The unnecessary if statements could be avoided by:

	if (ret != RMI_SUCCESS)
		return ret;

	if (out_top)
		*out_top = regs.a1;
	if (out_range)
		*out_range = regs.a2;
	if (out_count)
		*out_count = regs.a3;

	return RMI_SUCCESS;

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
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_PSCI_COMPLETE, calling_rec, status,
> +	};
> +
> +	rmi_smccc_invoke(&regs);
> +	return regs.a0;
> +}
> +
> +/**
> + * rmi_realm_activate() - Activate a realm
> + * @rd: PA of the RD
> + *
> + * Mark a realm as Active, signalling that creation is completed, allowing
> + * execution of the realm.
> + *
> + * Return: RMI return code
> + */
> +static inline long rmi_realm_activate(unsigned long rd)
> +{
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_REALM_ACTIVATE, rd,
> +	};
> +
> +	rmi_smccc_invoke(&regs);
> +	return regs.a0;
> +}
> +
> +/**
> + * rmi_realm_create() - Create a realm
> + * @rd: PA of the RD
> + * @params: PA of realm parameters
> + * @sro: Preallocated SRO context
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
> + * @sro: Preallocated SRO context
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
> + * @sro: Preallocated SRO context
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
> +	sro->addr_count = 0;
> +	sro->regs = (struct arm_smccc_1_2_regs) {
> +		SMC_RMI_REC_CREATE, rd, rec, params
> +	};
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
> +	struct arm_smccc_1_2_regs regs = {
> +		SMC_RMI_REC_ENTER, rec, run_ptr,
> +	};
> +
> +	rmi_smccc_invoke(&regs);
> +	return regs.a0;
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
> + * @rd: PA of the RD
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
> +	if (ret != RMI_SUCCESS)
> +		return ret;
> +
> +	if (out_rtt)
> +		*out_rtt = regs.a1;
> +	if (out_top)
> +		*out_top = regs.a2;
> +
> +	return RMI_SUCCESS;
> +}
> +
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
> +	if (ret != RMI_SUCCESS)
> +		return ret;
> +
> +	if (out_top)
> +		*out_top = regs.a1;
> +	if (out_range)
> +		*out_range = regs.a2;
> +	if (out_count)
> +		*out_count = regs.a3;
> +
> +	return RMI_SUCCESS;
> +}
> +
>   #endif

Thanks,
Gavin

