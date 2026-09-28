Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3A356766
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790558579; cv=none; b=hW52rAsOf5ZcX8eNNcMxb2ZGRrN8j1csAbQMk3CHMLc6FVVy5ygAwQIqfJRUSPindv1CqlkI60uc+ZmaZNPikfuDHeiP5CmSKiFC9Q0aEMwfoXvYwd8k9soxh3azXraEwyYqqBC0c8OWeIEWsIGn750PJR/MPyptY50+aIA5yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790558579; c=relaxed/simple;
	bh=tzexRqC3K2iiEzwQnm+LnN1j4dKGRAhl6MlLFdP0ios=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yi8LP+MIAXU37JBIFgj+gmkTElmgfN46okaFEbbJ0QlsUPxah8DBlcqdXi0DCHIcNRWvY/u1u+feSZoFwKtUPW9QOfNzAPv9TNlZS8PjwxJvLWboA4xzqlCdPsYHy1dn5A9mQ46H0avTA427YdlBi5lghpb6SsGADGpVxNZzlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ED8x5RsF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sANSnMx/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED8x5RsF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sANSnMx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790558576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYhWmKK3WxSPtzfylUKK2UiUNGYDraSdFFrlfHKnCEc=;
	b=ED8x5RsFUelIP1pXss7EpEnGX8EvDCpPkRD8F0+5sMBTRfEX6EMNNlo7p3vGxW9Wyoduu8
	8XTgajeXxcmGEfPP+9RBTECpv/INuO7BbynuBYE29owSEjsPdTCBAuOK6lxjvEZLZGK2/l
	qMjrqdrQdOVhIyoBkSEBp2iGO6hOxZE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-vZc5nSUyNf-JAQWipWzTwQ-1; Sun, 27 Sep 2026 21:22:55 -0400
X-MC-Unique: vZc5nSUyNf-JAQWipWzTwQ-1
X-Mimecast-MFC-AGG-ID: vZc5nSUyNf-JAQWipWzTwQ_1790558574
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3f521346so2773954a91.0
        for <kvm@vger.kernel.org>; Sun, 27 Sep 2026 18:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790558574; x=1791163374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYhWmKK3WxSPtzfylUKK2UiUNGYDraSdFFrlfHKnCEc=;
        b=sANSnMx/aIzRjBdqOnLOstDYzB7OAFXHo5HeMqADcfKcw0FanKVgpsaQR/pDUxfOAM
         72dWdRJlU3L/XMR3sdvhP4dZ1OMAK/L1f3r8/Q3lVyJH/tESHv2pJgLOKpyB5MQL5+8I
         g3kOP8tBnIEOCFc8HVfCCCayKn9BxbzoEd4R41gVCrVhLdNqt6S3FKyzvPbIDexAhala
         fMWV6ernZonnYn9uVUc2mzIYay5RWieROTkt51vXm++wp05xRmL5PyfdAO1kTKChglkU
         pLsZOC4WcZEEGD45htuTCJT58KWXCrCLjStfnHywlZ2w4HBOpEcbOPF6n8I0fFC14BeV
         ArHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790558574; x=1791163374;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYhWmKK3WxSPtzfylUKK2UiUNGYDraSdFFrlfHKnCEc=;
        b=LetC3XSon8cOW2axVaKHaC4iqFxdFpNi4CbIVTOk/REkGZ3QdRxCbHDRy/nQfBSskx
         HWSjd6rIeIS4AJv+VCfijpX99lb259apIDSWSVplCV4LPOWu4eEoXuBxei3tp6bJEHCO
         Kxd+z8Nux6aiCJiSEVc+isHRSLOnWm7RhglOTJXBwZ+CbD3wJFglWAJwHw92e2CzMiqw
         zMtvjxWSB4+0dpRq42a0v7SeQy9hvsFjfMkOmvWDyuxPUyVyGfIg2AYVXO81fCdgk5Ry
         dMW/tRB5/uW2K37RvG7WXZxtQmjaTc5HsB46HdkYjQLKSxN2hE7dYcmKizh2BAcXUTEB
         +TGg==
X-Forwarded-Encrypted: i=1; AKwUvBwpAH4g4BWSisaHLiwFYj6HpjO/BC6qXU/ifaWA0xIwqJyYKsDHntRoxH+6zm5mY4v+U0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVvElhNTJfLj1WIbWakly+d1r0NA8hsGu3AbV8vk+tcMRy+mSS
	mnpeZy1IYVbDKsjLd13f3x3WfrZJN62qClU3GK6684iiadk5+29/Y/5T071wFr8Rx+KejxFHHLE
	K/J65pG87tCT7RkbbJYSDa8V+atrpiZ7rTBVCJBRuv48ZFoUrPJzK0g==
X-Gm-Gg: AYBFou3oPMtSY7rFE8X33cOJOWKJAgzjy+VIMBzYzRP7mIoAy0tSvE5PpVQy/ZQC54X
	uqJw773M0S3sU7qRNPQdTEvRi2jOB20LCfFDMx7Swst6dF5Mn/N/pLYv2WFrKBThHVhxwAspXyb
	07BveNAYWa8S77n02ltsgg/nurO2/l4pKSxWnMSmlavzJC5Dv4QUFzSAcyUeuPOFPCnUC0SNyv6
	gGyWQzMa4IS7gEXjrxE57RMuENMQoT9E3D0nYdMbGGSscCbDARvqn5cmKIpSfCZMqbOrWh+8POO
	/m8TxJ0D4m6Aj6i5SGhwxEbljh4ZwHd88QrXg3zRLa/pxmN2oAA0n9XGN/HwncepczrN1/fFuIy
	gTM0+15jrA/iB8J/3fl9harb9GrpLpentzbHJaLWLJA==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id 98e67ed59e1d1-3a0dec0d44cmr4614942a91.63.1790558574337;
        Sun, 27 Sep 2026 18:22:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id 98e67ed59e1d1-3a0dec0d44cmr4614925a91.63.1790558573861;
        Sun, 27 Sep 2026 18:22:53 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm24238968a91.12.2026.09.27.18.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 18:22:53 -0700 (PDT)
Message-ID: <e63e7972-f099-4e5f-a2cd-9b87b8d6220d@redhat.com>
Date: Mon, 28 Sep 2026 11:22:45 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/20] KVM: arm64: CCA: Add VCPU load/put for Realms
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260920212845.707-1-suzuki.poulose@arm.com>
 <20260920212845.707-14-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260920212845.707-14-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 7:28 AM, Suzuki K Poulose wrote:
> RMM controls the VCPU settings and most are hidden from the KVM, except
> for the VGIC and timer bits.
> 
> A later patch would add syncing the VCPU state into the Realm REC related
> SMC parameters.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 0e2ab5311e4d8..bcc274df2a915 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -795,6 +795,13 @@ static void pkvm_vcpu_load(struct kvm_vcpu *vcpu)
>   			  &vcpu->arch.vgic_cpu.vgic_v3);
>   }
>   
> +static void realm_vcpu_load(struct kvm_vcpu *vcpu)
> +{
> +	kvm_timer_vcpu_load(vcpu);
> +	kvm_vgic_load(vcpu);
> +	vcpu_set_wfx_traps(vcpu);

vcpu_set_wfx_traps() is updating HCR_{TWE, TWI} field for vcpu->arch.hcr_el2.
Could you help to clarify those two fields need to be updated here? :-)

> +}
> +
>   void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   {
>   	vcpu->cpu = cpu;
> @@ -845,6 +852,12 @@ static void pkvm_vcpu_put(struct kvm_vcpu *vcpu)
>   	kvm_vcpu_pmu_restore_host(vcpu);
>   }
>   
> +static void realm_vcpu_put(struct kvm_vcpu *vcpu)
> +{
> +	kvm_timer_vcpu_put(vcpu);
> +	kvm_vgic_put(vcpu);
> +}
> +
>   void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>   {
>   	vcpu->arch.vcpu_ops->vcpu_put(vcpu);
> @@ -2202,6 +2215,11 @@ static const struct kvm_vcpu_ops pkvm_vcpu_ops = {
>   	.vcpu_put = pkvm_vcpu_put,
>   };
>   
> +static const struct kvm_vcpu_ops realm_vcpu_ops = {
> +	.vcpu_load = realm_vcpu_load,
> +	.vcpu_put = realm_vcpu_put,
> +};
> +
>   #define KVM_VCPU_OPS(flavor, ops)		\
>   	[(flavor)] = (ops)
>   

Thanks,
Gavin

