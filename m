Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6073286417
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256333; cv=none; b=sjEUR6WCxKNwtNI9OMo+OZEwPF59obTy5q5BF5O/KSqEpkwKCTrD1OIns4Y/Ds1R2LOSuNvJrvH4XAfvrip0qqskmhNEF20HJXMVFO7186nvSX1F6iuoWD9usYRIwSNBX7xxqOrTseQ/4hCnwJRaX2BGf4BBBEt7/sr61wqEsu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256333; c=relaxed/simple;
	bh=liZcKA5xMSphCw/JtZIGkUglVkn1mh/BgOSx/JkJum4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChoQXVBq4VgyyW7ZVjKnQbG2r/Mb+ZIr1zaCbIFAV8C1C/vZp8jN9DiKCs8DXAnrlDWP9yVLjmLuUHy+U52nCdMl8zPnudcA0wZkZ+SY9KYRndcJud+gQegJqxQ4V0ESjkglj8wxsJk5EPMLRtfdFd6buC8cigiouT0PipmW9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BswY/ewp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcIbm5rT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BswY/ewp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcIbm5rT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791256329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHj1RXYmclP68lBct4KNIr5BPd6z8PeEquooINbDID8=;
	b=BswY/ewp3QQ0mo4EGVRlV1vA7OtrOaarA1RTwczJxfJKE3Adyg0tbbtUgQhSEx65zZuPmB
	CB1sjovwhvrE33jH48LLnQcWVLi3DOymQq3DD+hqzcxXN+KZ+c0G5z5XOuk8AYzHf50VD/
	ieeUJ9JMqUsEEsOpp/zgybjCZYMevkc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-awdu6Y91OhGnpRKXI9ZQew-1; Mon, 05 Oct 2026 23:12:08 -0400
X-MC-Unique: awdu6Y91OhGnpRKXI9ZQew-1
X-Mimecast-MFC-AGG-ID: awdu6Y91OhGnpRKXI9ZQew_1791256327
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so3653451a91.3
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 20:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791256327; x=1791861127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHj1RXYmclP68lBct4KNIr5BPd6z8PeEquooINbDID8=;
        b=CcIbm5rTRdwWWvvGvLZ1fq8w0QyLC7ksJaVmEcbrvHTV2RC8ChoteWiA3fisAnxkkQ
         +IAnO+huisSvusyTwON/QBba3ww31981pdOFpVXQfPqijKyvOTyMYFLSY/4tQGVqAeiA
         SUzA9SP0d6sF1CNm0mxW7c+9H6LcthJhDr8qPrdVulkl2HORwrd7t9bg3Cf/P1hf0J6k
         R2oP4lZJP4OH+Y8o6IcBStPzfa4eyj6DLSkmFVXRJUv7eAxbqi+Sw4yvXy9a6gYuxixy
         SlJUXzq0kyRdBa7qLEiBblQnW9M8ibH4O5ZHftc5IUipYDFC1yp91pgJXBBlMY385Q7g
         YZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791256327; x=1791861127;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHj1RXYmclP68lBct4KNIr5BPd6z8PeEquooINbDID8=;
        b=fPg0+J8O86ZIuyOM5SZzrwtztlCZcrjbhP7noXUXWub2cDKanr7RI0VJxPzme23Kro
         Lb4SjNCMfL41RNRWDE51U6fm6O1baJZgZfhJUVoxepKcev9pxdGrJYpS3ie2Am4jKQKx
         WOXiQDvRiZguta2+pGgLGMOunI7h5ebbz0UIVfhiX2XwVBZNtaP3hJ641i5xPA6aUreJ
         M4cEmuNLzmp7+0238q+XUJj0ye9FHr3/mGQSYm/uUztILSxt9yqngNa/ZfL0EafxxaCo
         RMke4i+PCRTxtUOaesE1KqoppE/3yx/r9+xvRsB3cv59mJpIZ2ebjJ3pfpcwkjK4E19n
         zw5g==
X-Forwarded-Encrypted: i=1; AKwUvBzzub1AQUrfMJx7t9/RBy92eZYkNKURe69IhNVyzNZZsD5EplHD2K+38iGzWJSJSLcXmRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJYOgetoplfNeo3LDsqOQVSVVW6OQtcpMvV8J/UR6LXkbZeyxQ
	0CCCHAepT4jPxgbw0Br3xQ87Pelc7xF8l3VV04WmWG5kgQyb+Ke9Ru2NFOLiXxPwjL8RbdEzFqT
	rFwyN51ulnIeBAua6aILhPqwYS29RpfuXEinO6nViKENYpF5H4mIOww==
X-Gm-Gg: AYBFou2sogRkDx5zttGqJt688kXk8tgE/Wn4CvtxB64Ke6lsndHwr+yNpvRVwMA7UMs
	Depjb9u6gesVYdeBVuuZdqX3/HVXIkT9A10gImKWZ2/cVM0XKnh3RczDEl1oB9zJ4oUbpy7se4v
	lknCPm13NLlkCn7al6YNZwifOE2edBZ/6c9ji8iAXxyxGOOBBXlHYoJubyrgtDluHDcSEjNywp1
	XlhHL1o8CYBbMI4jxme2BARCqj0xdzBxHM4KfiBbYEU9ucCMe64O4OcuYKI9hcYNq2tCgjUd0iS
	8565UYdCYZylC5ClP6F3QsiNjrdyDnomjc+5pmEWx5XKNVtEoeWg6GNshYLHwjcnnXIZ9vPA5zc
	DyQX9o1a6TpJFhqLV5//MQPk/prFLGLteH8/mON4L9g==
X-Received: by 2002:a17:90b:2e0b:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3a8737a34cdmr26429a91.63.1791256327291;
        Mon, 05 Oct 2026 20:12:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0b:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3a8737a34cdmr26405a91.63.1791256326616;
        Mon, 05 Oct 2026 20:12:06 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a5ee97f3sm15210795ad.66.2026.10.05.20.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 20:12:06 -0700 (PDT)
Message-ID: <6d290cbf-5dee-40ff-9ca9-af544fdee791@redhat.com>
Date: Tue, 6 Oct 2026 13:11:56 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 15/23] KVM: arm64: CCA: Add a new mode for supporting
 Realm guests
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
 <20261005090754.2140522-16-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20261005090754.2140522-16-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 7:07 PM, Suzuki K Poulose wrote:
> Add an explicit mode to support Arm CCA guests.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 3 +++
>   arch/arm64/include/asm/kvm_host.h               | 1 +
>   arch/arm64/kvm/arm.c                            | 5 +++++
>   3 files changed, 9 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

