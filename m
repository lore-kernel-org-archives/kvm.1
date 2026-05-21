Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FF282F2E
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324736; cv=none; b=U76gp98nw+97k2hhmfUOvEQ9awTuODDzidLyDC+Kgg9qx0VxkY1YqbJT3U0egdTJoApu6qYllhQ3Lhevc0nVNxS2RQIeVqgP5eZb7Wvs1IJMUtxuxFfpO1qtDojXrZhn+3D7SZqFRx61eq+Eh9+uXVaQqJTWnE0dZtK+LS7aGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324736; c=relaxed/simple;
	bh=SyMNQf23KSDzhFiY5Zt1P+qqyGBKOoYaZaxAPGeN1e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcjYoJ628BgWh1U70U39zM98TTgWQMXCjxuSZMUzscdxdz90zOZ+BQUQVP1vn+TudaPKNfyklsQ3fwZlB/+BKvc/Y37HEIi85eP1AnZk1RxCRyG/9Jy86PDxVt+OCbpXkbZCcYWuUGyqTpmTqN11+lGl/BB/GrG2+AqiR804jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eE0qT8Us; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6Febyv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE0qT8Us";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6Febyv0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779324733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7+8kbrxw3k6r1pEahfY8Z1QQWebSWYvywBVfeppeoA=;
	b=eE0qT8UsuutPyBxWOLHyycIukW5yEoCIFL/ApRhGx6vrjK90dszXNiJXlYxoDHkEaTB3gt
	Bt7EYSwgxB+QivjkFf99FJsaojv8myYXX5XLF/uGQ3mqvNmQThM2UNcaLv42CH+ps/G4yS
	Y+A20+r94rp+/roa4Y+69bWCrRLtN5Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-VHdFr3reP5yOd4zkt_8pEg-1; Wed, 20 May 2026 20:52:10 -0400
X-MC-Unique: VHdFr3reP5yOd4zkt_8pEg-1
X-Mimecast-MFC-AGG-ID: VHdFr3reP5yOd4zkt_8pEg_1779324730
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba86e35aa1so94073355ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 17:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779324730; x=1779929530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7+8kbrxw3k6r1pEahfY8Z1QQWebSWYvywBVfeppeoA=;
        b=c6Febyv0DLk40mXB01gUg+QCMM00qH1k5d1/w4HabMqFLB1ipNWdF3EjneNiS8a860
         dO90TfVuIRgqfRu4SJLb+aL2urbPHZEXflU5LLGd+xmRHL6/EAH4HUgVwZxXcTXXSvyB
         Qlyp4rXUDRG5kNyuwDZqTEC4FSpE2c/FLuCBeUbKgE3qzEAZbtcvQ2XPBjl2k880jiKT
         co4tFFo2vnlGqdpCtJlunRwyaOBqyqB9NND70TI3NCzWGM2uODGWdLkq+koTDZQEN79I
         zF3JXd0NOVhglsiLy9evjBbaDAjmBdXkDw2mbABKjyKFVpRdAvAr5lZht7YFYfU5/VLG
         ofbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324730; x=1779929530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7+8kbrxw3k6r1pEahfY8Z1QQWebSWYvywBVfeppeoA=;
        b=nFDSquotKSZXaT9zwonc7jebuuhaadGTN1WoYjW1cx+MGBxu7Ji4GxddKgQ6KzKTvn
         DM97fe/yY/px/mgWb9lWjDGQrCajt1o+37YboOfsKU7Vaqtx7b7yCAy72XkjCVXrv7Z7
         rzHnjN1mXq6KnJtiRVZXBL5YRlf5WCAtptc7jAbep2/LHiyHB+UOAoztQFMU+brI19p+
         ZBSQE45G0BSQR+MupTnPTsNJal4FQNGZZ/E5wDBkzIyKTNQTbm5ED6EzfYpJA2NbRnkd
         84Zny+aKEOkORqO3UKnMxRm8D7CwnF3KOVZSLZYxBSeUijeTzEYx8wABNhCkxRkEohYH
         et1w==
X-Forwarded-Encrypted: i=1; AFNElJ+mid+r58sFmPLXQ/4yeyqbrtgDYPyfwdzfAnzCqZIJTgQ6UTWhXJFSj8V0dARkzGrvbdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD299qlT9FUWFdhGtBiJyBPCAB7fxYJSr+nUHw+DdU852rQsD4
	SQBf4yoiK778epFAy9uUvHQmtBURcs4AE7PFiWx4YveAhD2JAnlb7ckWYO0gN+ygeKODQoltElZ
	//fuG57p7cpY0W6uD50UGvolWFJJPb8aR613Vi0jjLZGXGOhT0es1WQ==
X-Gm-Gg: Acq92OG4mC3eVaJ9sPbq3xStm7AzST2xkCQpKLW1ReoxvgA6DRmd0HNJR2Ow+YoVO8A
	qmPOWHjTsKwSbX70DxTBzhd7HKOV2786hEQOXjeZRtIWeGEYvpa+CJbaIrLXi1knhQnonsL2Jbs
	e7UvKFYf86fZdZVKk7FdYSh+AdumdAcIFIs1kT0wf5SfFa5XdQmWL43yRO7re5squAYSPm7AiJW
	mxgX15KyHaMsfyLsYiHRyJmaaAD+V9F8H/7BtdZRAowTriDgqN6SQT9zu6LEBgHA9zB2gGGtU3e
	tFRP6qFtp0u+RsLbjew0ftXvctgWTkZoYMTvhCHZevg4devmb6hmps119czg0MBZl1Oz72NLZyT
	7cmYAbPefAxlFejkFhJbLa7dU0fH6/hI05l3zY3TGoOFey7kM/4Y/BXFDWl2idR39
X-Received: by 2002:a17:903:240c:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bea33a548dmr3621035ad.32.1779324729810;
        Wed, 20 May 2026 17:52:09 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2bd:907:2cf0 with SMTP id d9443c01a7336-2bea33a548dmr3620505ad.32.1779324729097;
        Wed, 20 May 2026 17:52:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef1bsm293727375ad.4.2026.05.20.17.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 17:52:08 -0700 (PDT)
Message-ID: <45a953a8-6edc-45c3-b5bd-17f14397ab89@redhat.com>
Date: Thu, 21 May 2026 10:51:56 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/44] arm64: RMI: Configure the RMM with the host's
 page size
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
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com, Lorenzo.Pieralisi2@arm.com
References: <20260513131757.116630-1-steven.price@arm.com>
 <20260513131757.116630-8-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260513131757.116630-8-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steven,

On 5/13/26 11:17 PM, Steven Price wrote:
> RMM v2.0 brings the ability to set the RMM's granule size. Check the
> feature registers and configure the RMM so that it matches the host's
> page size. This means that operations can be done with a granulatity
> equal to PAGE_SIZE.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v13:
>   * Moved out of KVM.
> ---
>   arch/arm64/kernel/rmi.c | 42 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/kernel/rmi.c b/arch/arm64/kernel/rmi.c
> index 99c1ccc35c11..a14ead5dedda 100644
> --- a/arch/arm64/kernel/rmi.c
> +++ b/arch/arm64/kernel/rmi.c
> @@ -49,6 +49,45 @@ static int rmi_check_version(void)
>   	return 0;
>   }
>   
> +static int rmi_configure(void)
> +{
> +	struct rmm_config *config __free(free_page) = NULL;
> +	unsigned long ret;
> +
> +	config = (struct rmm_config *)get_zeroed_page(GFP_KERNEL);
> +	if (!config)
> +		return -ENOMEM;
> +
> +	switch (PAGE_SIZE) {
> +	case SZ_4K:
> +		config->rmi_granule_size = RMI_GRANULE_SIZE_4KB;
> +		break;
> +	case SZ_16K:
> +		config->rmi_granule_size = RMI_GRANULE_SIZE_16KB;
> +		break;
> +	case SZ_64K:
> +		config->rmi_granule_size = RMI_GRANULE_SIZE_64KB;
> +		break;
> +	default:
> +		pr_err("Unsupported PAGE_SIZE for RMM\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = rmi_rmm_config_set(virt_to_phys(config));
> +	if (ret) {
> +		pr_err("RMM config set failed\n");
> +		return -EINVAL;
> +	}
> +

Looking at branch 'topics/rmm-v2.0-poc_2' of RMM implementation, the granule size
is fixed to be 4KB at present. I'm not sure if I have looked into correct RMM
implementation, but 'topics/rmm-v2.0-poc_2' is recommended one in the cover
letter.

Besides, there has checks in the handler of the RMI command to make sure that
struct rmm_config::tracking_region_size to be 1GB, indicated by zero. It maybe
worthy to set it before call to rmi_rmm_config_set().

	config.tracking_region_size = 0; /* 1GB */
	ret = rmi_rmm_config_set(virt_to_phys(config));


> +	ret = rmi_rmm_activate();
> +	if (ret) {
> +		pr_err("RMM activate failed\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static int __init arm64_init_rmi(void)
>   {
>   	/* Continue without realm support if we can't agree on a version */
> @@ -60,6 +99,9 @@ static int __init arm64_init_rmi(void)
>   	if (WARN_ON(rmi_features(1, &rmm_feat_reg1)))
>   		return 0;
>   
> +	if (rmi_configure())
> +		return 0;
> +
>   	return 0;
>   }
>   subsys_initcall(arm64_init_rmi);

Thanks,
Gavin

