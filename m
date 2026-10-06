Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8533876C6
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791265496; cv=none; b=KcAFqWUGfy2bnJAN7D3YnSXSmPPO1ngSQX/i5lmfStewq4syfY6zfy5xW4b8Q2M0lBXZnT+wrrUc24cMP27AY2gV7in5D/i/gQeesAnj/l8L0b/jRsVElvJhg6jHETmnCn2JeQKTgdtIi89GbvNbYF4OPHxwspGn0BIfGWF6uI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791265496; c=relaxed/simple;
	bh=DHoKyepo2fp+kisnl6gLY6MDmj/N/k7KerpVds1Hw9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUIrkAnQ+yavrjZnkIkj36Yz74gVgHdom9tGbh2fuSix4lVRYx/MlpOa8xAnLQpNMrnXjs9rrTlkVYiJLPlTMG+TYHTk7ep5OHYs7n9EbzLMw0Ft8p2ng8dbm5ii2ZSZgBs3Tcf/OBjTJQihsl71iVkzRFIo12m0ysLR6vTBDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvIlKl0z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9Oym4rM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvIlKl0z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Oym4rM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791265492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlbDdSB3PruPRmOdVrnRuaAfzphnBA/AuglJGG/CjDA=;
	b=DvIlKl0zzZGfdR63WLC8txDyBMDlDDPFmMnQfW5WmqhaUNcAOOXWRNVw7iFgAjPFdsZALD
	KP6C+QNCGLvGITOdYLMzbCrJrlitLdZO+Pg9KK38TKqIgeMjOdYVqnkgTBHqVssiSlvRso
	CNEZh1mLUStmVN3u25n/+jgU2uYQAHs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-8QfP__XCO1GXBpA6zniB5A-1; Tue, 06 Oct 2026 01:44:51 -0400
X-MC-Unique: 8QfP__XCO1GXBpA6zniB5A-1
X-Mimecast-MFC-AGG-ID: 8QfP__XCO1GXBpA6zniB5A_1791265490
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df8d1e91c9so46496735ad.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 22:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791265490; x=1791870290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlbDdSB3PruPRmOdVrnRuaAfzphnBA/AuglJGG/CjDA=;
        b=J9Oym4rMR0BKMMoqf+SsuAXXwDP5DrUYsct9c9aj0LuXDQwyXSA6w6d20T2y8EDtiH
         jBaatvkrIMy6XunXRvz2jw8Tu0ypRld+kWoHB5x0Rnavozvdvz3NVlju1ALkvhpkrt5c
         /XxYAZEumjP4Bz5+vBWbOqZn12Hk3ZIzpEBjgzuv4wY0FMGyRtiWVdAzFAbM8RpxH8Co
         kT/Q0mdlP9/LsjeB4spcDY39fZpu0EeJcxrjtI4VOvn1TusdkvctNW+yVZEzLtChG2nx
         Veo2w48OhsnulpIaJP3eGN9QPXE8Et22sz+cCtrIK2j3nwluvM+kaGU9augfzv0hTXcR
         1GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791265490; x=1791870290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlbDdSB3PruPRmOdVrnRuaAfzphnBA/AuglJGG/CjDA=;
        b=Z9DRH88YZbwbQCjjElaiQXdbJDkicvNUxAYApQJbBIe6ftvjX4nJRn4W6dxlqjJag9
         Y/uW/reEJ+nrwqzEbCL6wtrhWvtkUMjtJT/f/21fU8ztKFNAfm4/4AohiVQM3RGkk8Z5
         UlJM45CEr8ozeokZ2v2mGzYQn8KEYdg8xjv3PEqCTHvCvyeUN8f+GHMBGJOCKzhMrpUx
         mKPMKx7PvA/4dLgfAz4QItZJ09iGWd2oth16fMnaBrfdp3edTgqFrPzTnixIfU2yPHpg
         xHgZ6V2JCSvCbtSYq4OvPYVwI8lmSeN20TgiDbGWZM8IoOXCkIqFHcLftB+LyiqHP5lt
         ccgA==
X-Forwarded-Encrypted: i=1; AKwUvBxwvZ8tpH4t6SEmFSsm1Zx9lyd6t25rktX9blqpxNUnT8QZPPyVEg4ivPZEGZ19Y2KGpRM=@vger.kernel.org
X-Gm-Message-State: AFuF++nf6N9o+UKFjJ+pSfiiXq8FHazB1Ed5WtRi8E7KhPUrW7dP2EcG
	5omfdPdc8aRtsZa6bJ0nYnCOpaASU0bMUGQICIpBByOuYrYQWlYH80NXzKTZFVvDopfPp66IK9K
	O0sbey3oSNPvZBQVO3ZjQqGaLCHxB0+HF7SlC123795A0e1BLslUbsA==
X-Gm-Gg: AYBFou3hAgOiWC82R0YgohkFcAxFBLzltD0qpCJ54GpHW+R27JLy6hGGC506gNsUFJn
	3mkOerYkvHJEy6G2mGhUei8deK1R1MeZOcHGbIM2edjc0P7mPYVWny+r/31AF1y9BT8c5ksWHZ0
	HfwlSnodHOOxDlJUFXBv1+Z8H+cC422hA8+8gOSJwukHsGx8lfRZgp8oQew7FfxR4LvJnbYJRED
	D3H/oPLYplpQccanitbNF8vTdOeP+rZpqi+diEejL5/ooK5ZXd/4Vjkqy5H3EYPRZ8MSMJypfzF
	9U3ujJT5yd8xEdI5gxJU5yK7qmbWU38nPjgr/N0MA7ySUEegvTDCsh0GoNEQNqEi7I9VSDg792L
	n0WeSQ+TNKz2MYRdpKdkRWm3p5M4mnVoWuPL7iKAPpg==
X-Received: by 2002:a17:902:d584:b0:2dd:68a4:16f1 with SMTP id d9443c01a7336-2e5dcd90b05mr3770025ad.11.1791265489999;
        Mon, 05 Oct 2026 22:44:49 -0700 (PDT)
X-Received: by 2002:a17:902:d584:b0:2dd:68a4:16f1 with SMTP id d9443c01a7336-2e5dcd90b05mr3769785ad.11.1791265489595;
        Mon, 05 Oct 2026 22:44:49 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ecbdd3sm17417165ad.48.2026.10.05.22.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 22:44:48 -0700 (PDT)
Message-ID: <830e8afc-b208-4972-a45a-32c828c14206@redhat.com>
Date: Tue, 6 Oct 2026 15:44:39 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 21/23] KVM: arm64: CCA: Support timers in realm RECs
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
References: <20261005090754.2140522-1-suzuki.poulose@arm.com>
 <20261005090754.2140522-22-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-22-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> The RMM keeps track of the timer while the realm REC is running, but on
> exit to the normal world KVM is responsible for handling the timers.
> 
> A later patch adds the support for propagating the timer values from the
> exit data structure and making sure the values are in sync for KVM.
> 
> Also, RMM doesn't support injecting virtual interrupts backed by Physical
> interrupts. So, use the existing software resampling mechanims for Realm
                                                        ^^^^^^^^^
typo: mechanism

> timer interrupts.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/arch_timer.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index a45845f4ae4ea..428709f499205 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -56,11 +56,25 @@ static unsigned long kvm_arch_timer_get_irq_flags(void)
>   	return kvm_vgic_global_state.no_hw_deactivation ? VGIC_IRQ_SW_RESAMPLE : 0;
>   }
>   
> +static unsigned long kvm_realm_timer_get_irq_flags(void)
> +{
> +	/*
> +	 * RMI_REC_ENTER rejects LRs with the HW bit set, so use the existing
> +	 * software resampling mechanism for Realm timer interrupts.
> +	 */
> +	return VGIC_IRQ_SW_RESAMPLE;
> +}
> +
>   static const struct irq_ops arch_timer_irq_ops = {
>   	.get_flags	 = kvm_arch_timer_get_irq_flags,
>   	.get_input_level = kvm_arch_timer_get_input_level,
>   };
>   
> +static const struct irq_ops realm_timer_irq_ops = {
> +	.get_flags	 = kvm_realm_timer_get_irq_flags,
> +	.get_input_level = kvm_arch_timer_get_input_level,
> +};
> +
>   static const struct irq_ops arch_timer_irq_ops_vgic_v5 = {
>   	.get_input_level = kvm_arch_timer_get_input_level,
>   	.queue_irq_unlock = vgic_v5_ppi_queue_irq_unlock,
> @@ -1617,8 +1631,12 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>   
>   	get_timer_map(vcpu, &map);
>   
> -	ops = vgic_is_v5(vcpu->kvm) ? &arch_timer_irq_ops_vgic_v5 :
> -				      &arch_timer_irq_ops;
> +	if (vcpu_is_rec(vcpu))
> +		ops = &realm_timer_irq_ops;
> +	else if (vgic_is_v5(vcpu->kvm))
> +		ops = &arch_timer_irq_ops_vgic_v5;
> +	else
> +		ops = &arch_timer_irq_ops;
>   
>   	for (int i = 0; i < nr_timers(vcpu); i++)
>   		kvm_vgic_set_irq_ops(vcpu, timer_irq(vcpu_get_timer(vcpu, i)), ops);

