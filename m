Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320559;
	b=BNeh34nLobnj/z/7m+dqq/N67XWDGTYxrASGjqLIDYBAjObF/ywzJTrvY38vs0pkgKwW
	 PNJBNqkZKQ+1E8jrmMLjRWHaRWzHxzYaC3NNgSpDPoJEazRz5C4jMYRUQz4ejWMnWBWpk
	 Fr2RdpLMc9HTtmxrlCcaPJGoFTvDbsm6L2gGrkCcYlnzHR1jScjwyy1pszENR5gozFebD
	 JKY1/5YsvPIcXPnBcEE9Xrgye+Jja3dZbT7QxGBDiNdSnfRDxO3RAYn1FQQreUmoJFmlw
	 rqXmPVnUZP1zKJS98Gwe34tSFidEFkcQddPiOZp49JQCj1H5EkxddiKcWKZdJAB8QTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
	b=vYl90hCFnPntuALExRUIPHvx9d/2ZwEn4eZwDHNEGtKljkuIIp6UqU29Mk+6nQEfRxOq
	 PT1jb/aYgslw4H2NDGqloRErqQL13uqFGPfnayMm4o3QkuQJ4HnnHPX6KBuRFIQ0CKoL1
	 PP3TnVVos5los3DC7M4Zn9F12q1w6Tli2bhds2aKA1nzLsfEGY/FAvDYluGJo833sBBbt
	 bq8jqQ4TcDY065ULVWUHpWJq3u7b5Yl0YvHZh/J5rBu7y5TeE5KqT8pj28OlVI33My0n5
	 XlEGXFijGIyh4dJgVkDELbVHZ8Ne0fWOAu+m8iPqs3D2KCUunmjWZaO1/j9ew/jZ/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+S1rZsg;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB8606A32E
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93FB8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+S1rZsg
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-3b0d11b85f0so1250862a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320559; x=1794925359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
        b=x+S1rZsg7K4t+eNcKA8bN9ONE2k8DAq5dMIW0eRDE/qBx3gUIRLbancnNA0XJL3wuN
         rbv3XHNXNLA+thMDnuUTZl6mU5nEFo4LVh9MAxmWN8TbYGgfWFv4Yd28Q9m/A50jnvX6
         OBS8Qy/wqYLqq3zQv1XmMRjNhixHEUwZ4BVbpeIz+cnyXlnk1LpxwfCeglZNgFz754km
         1dwW6vLRW2pFsGlw3cbbmULYIxHu7as7ECpGXHxEnzpmYsgR+YMPkHXCaRtM7ACwgZjz
         4z2lgKosNm1g1/jdXNvjXd8U8DCX66L+uihyjJ+pbd937my0cer6wMSqTJpAoD/ohHlD
         6eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320559; x=1794925359;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vW6Me650CnRCbqpTMm9ScZes8RV1bkmpcr+ZWjp/+oI=;
        b=nizKmhChsqrW97W0Jhi4TrG8Z+kuHbCWYOJT5EnXVKxQVagPQlvXiR5wUvnvKPqYOL
         gSKnxl9eIsE6ayieuxK37aL0tEBF1ysivGAMNgllgjebiGyvf6OQ6RLUz5KmeJhZoRwQ
         aKLfWXqAGaXBHHfXpGmdVHqzD5TjVSgdMyJ7i6nNmbykGqc7j2VHuwb8WwLEiKQZmVbz
         0epoDjC+DEri+aY2J7fYVE29qcdHTWIFT/49CX8RRnwwm+EG2TLeIH7Hum1UA/2jEaUK
         E68240HMF1NpefANW3e1ggDqmjYnMPr43DabpIPsxA3nPdWwmQT7DDfQ6Wd7Yi6WY3rX
         7g6w==
X-Gm-Message-State: APuU4Z+GwpRd9AvnKqwG0dYn8IOQbtavq7HEqANMnHGlWpUAWDKPPQdL
	G3oX+fm7Dq/GZx4xOJTCcMEzalZ8Y94jK7wHVfwuNQk8mnNCP7UeegTXvn2CDRcBSaxHHg==
X-Gm-Gg: AYBFou0jEtpLrlHqUQQgR05pNGW1/0n2l8aMM+5gAAXhQyqPJAb+FVOnxDFGsxbsR5M
	5plwYi3S8YaLJzRqSiSkSrzdhT2k7R7xfe2hQeciwbB/hvlb4R8BF/932G/0JmTlUPspymNa2gm
	PF5Uj28OenUXMaorj4yx31/E/yosjNCO4UYfDQ4b4UOf9oW7YWi9vaqejaIioWxD1jqqbwABg7a
	vWfCCWc/aJReJZ2in6WbWU2hAvBlkDEglR2LqPHAbLNiWHVi9Py6r53N086GhX8xEk+UwqaoMkX
	5KjH77TDsh+2d6dzl5fXDbjQeEqOvz8hcjQj6hOXm8TVuWeboFDhztLhyoYkfU3SXDoYkYLDaEg
	8Z3Xq/N7LvpINv0/A/Mig5YDSiGGstSQIh4pc44eHu8rnT2Fe13+kE10RKp78owRf8gYqAoYFRe
	ZttH4qxVSJARC33KFGaalHqgFmsXBW6BhATaNOpl5oQ6yuJRrNIu7ge/BpvocfOYhk4bB2X7LaO
	zYwa292EkWKiaLxACyh3qZfsEALwo6liJEMdnLkKKz3LC3w7nkabtaqOg7lo3o6NbxAaCP+hqKM
	R4ZV5FmUX7ix32s0QW/DTS0wsMFD/jV7wSjGmutCIToqyj+WC2V68Q8s2+aR2ELMk/5g
X-Received: by 2002:a17:90b:562d:b0:3b0:968f:fdef with SMTP id 98e67ed59e1d1-3b166cda37emr3135880a91.49.1794320558504;
        Tue, 10 Nov 2026 06:22:38 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db9d1fbsm70817a91.15.2026.11.10.06.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:22:38 -0800 (PST)
Message-ID: <ce2231cc-e554-44fd-b931-5627219b534c@gmail.com>
Date: Tue, 10 Nov 2026 22:22:33 +0800
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, gong.shuai@sanechips.com.cn
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
 <20261110135615.8073-1-tanchi25@mails.ucas.ac.cn>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20261110135615.8073-1-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tan Chi,

On 11/10/2026 9:56 PM, Tan Chi wrote:
> Hi Shuai,
> 
> On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:
>>   2. Use the guest PSCID directly, but allocate a separate host
>>      GSCID for each vIOMMU.
> 
> I agree with option 2 as well. My earlier suggestion did not account
> for independent PSCID namespaces across multiple vIOMMUs sharing the
> same S2 parent.
> 
> Allocating a separate GSCID for each vIOMMU seems simpler than
> maintaining an additional PSCID mapping table.

Agreed. I’ll work on the new version soon.

Thanks,
Shuai

> 
> Thanks,
> Tan Chi
> 

