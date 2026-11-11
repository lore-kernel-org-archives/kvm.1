Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398570;
	b=E4Y9lvrnLaH78hWe11AC0BqV6xFMFrU11qAVcN5krvfVdMGf2Zt9eRLYt8SKAwgmm6D1
	 DB4aG/Ytw01JABLUngm+SaVn3RaoXUDIHIgY/HNt3SrHGVKZONDNN44Q28EHD9CAYu3L7
	 0MinEOCsbhvt+nThy93G27qUTc3fJhYvrC4kRst7wzy80r5OSLNe18oRJyHWIXjk2EHe7
	 UR9YtmW42O32Ro8DF0r2K+F9uUSlOVD0HR0hV9LosSg22KfG5mOLFj0cLzI9LxkX2JUVs
	 d324JHFMJ7M22MD9pA9c/0G21Mr/WBUepgd5QmkrMuZ2ZPsP6NadkkS6pbNlepPKUoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
	b=cXzSf2jh8it4HUQ8cdeuSa1XzFwuma5Pa4DqB/suE1ATXCIMMCjQPpZqleL7/DPp8px1
	 77+24Lz/wJHbIkGtS4fCrfyaKTrCFXOxmJSgrjweHcbWyqQ5mN+e/P3pUuaWHcEJR/0Nz
	 CiHlb3NnmQBZqffz4z4eeTDj5EvCuGuxjlIxbi7JXwi1mp1AxOvVVbGzgIPK9bsjfAXWj
	 9Prwv7Sx3s8u2UZoYPbd/O2YV+jW5gfthFBt0iMOul+bF1IgV3Au8y8cCACaNDJAex/iD
	 Ic7nZ2rC5ludCuvK4qsk7a8IYokb6WLAJ0MLUctAkZDGt6UYrw3X86TACViXMtQ+QyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Je1CYIjf;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD212606A32E
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD212606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Je1CYIjf
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491aaed7565so1862429f8f.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794398568; x=1795003368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=Je1CYIjfuwflh3C8ZTO7fGiG3VT2JZ4/KZsAnIckMk5yyFTVUjMTyMSMVoowIwUALe
         rIx+YCcQd5d3c/Oo7ywHWhe+3KSTQ7o6rFpU0FKq7oz4uEO2xHVWkEcknh525ow1mgCu
         gWFknAYgozrE3xkB1Hf35d8etynb8NZA5amXxyEuDKuHJdX9BiOMQOk4XO6ih4oDz5ll
         jiNbUTntFWcfE3xAvdYsPO01gTShdzNlx4xruDnGGl89qAWG/eS5QeVSu9Tt1rrguObP
         WWiW9en2E3WuuFqlZwdLZQMuWBF1+OevnHMcH8EoqrsFJwJLse2YUIb6yJUacp0hHv8D
         xyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398568; x=1795003368;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=q2+LphbD/r+iH76OmAkesOHeqtYrLQR1B4K12mxYwwmL8I5eYIyvpbwOJ5lGiCAvKU
         B4JZztcfqR0wpZ7RdVZK+SS5WGKgHnA/7MT0Tg0r0o/TaW+jcZ1hFrSdQC7UExQLZ/7Q
         Lm2WqWRI0RJIN+jpha8XWVhCiZlC/wYOF6apPToy+Byc5nIDSSZIRRUxAVwYIQsrFnTo
         rJe1+S4SMWAa41LTtH7YoopdovefXAoX3/6cGBfUNRWomZ9rsHTZIDRhfNnbXce9kSFv
         W0dViATIac64oGl1kWOprqq5XBxtfwG9XYL82BS+6o0qSIdzfeVuEeHU39aWk9xSX83h
         +g0A==
X-Forwarded-Encrypted: i=1; AL+hErGyNnbIUgEfLK0wuh0DaEcSQyISuNcj53cmtByVLNWA0p6TdronNXxAzwhkvsGASAYjeGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z99NfkzZ6PoqxwhJDnxmraMqW4ErB4DzBNvlB8yI7tFPwp08S9W
	xSdaPllYbE3+alO1B5TeanvFQolaHq4awRWZa5Qx2+9V5qucF7dkBtR4Up5cXaaRg7Q=
X-Gm-Gg: AYBFou1Z+p/5t3917hOaUmHSnWBxqsxV83nd+XLKn970Ybk6eiRyWs2nMw4YbBsHp9b
	9mxyJIfFb4uqw43F757ynV5RolqjJyH8/HY0UHn/37DUH7VnHZvONW7MmJfOK/w8sC853HzDUa4
	+WDOIT7UjoxmMwFzYDB89yQFa23k4kzkBSuLhxzcrTwN+RC7RINKdj18j2TrUQywHknsdWN3L7J
	N4tHg5cXuSkv6m4praF9JRFK1thwjNv9y2Y1ceVQiL3rBbwh9WLrk0kDHgCmWuiVxAioe9fkwhD
	XHUT/qxaO6CILA3KpM9hc0fqxJITNIJU4lzb63s8Dm6KFLh/gu2TlXm5L6ZQemo16taTbU8r3On
	jFdHgFJHwT3KhNr16pNRVJ3KCV1K1VaXhM2iqdJ9PkhtHMKIeI7anL0+yGj8T7XTZaIbGrMBesX
	B7dQnh2YWCDAYcIDgzfXPuXOmVz86oWHdfZAWsaMkKzB0g3/cRjyGep31fCTrth0FTybNnl2qd/
	BKDJLhsC0t8HmkaJH5Uew/4m6maU+lxH8F/nHO9EAIZX0sLgIB2UnaDOb4VSpKuA7jSP6lu0326
	n4F0EM/Xsa5Rl3FCfiZ68vjzgdBL5Tnq1Bq5h2zs
X-Received: by 2002:a05:6000:420d:b0:48b:1a0:5630 with SMTP id ffacd0b85a97d-499c86a10f6mr3780756f8f.41.1794398567805;
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Received: from [192.168.0.167] ([109.76.11.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c377fdsm8869991f8f.21.2026.11.11.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Message-ID: <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Date: Wed, 11 Nov 2026 12:02:45 +0000
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
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 17:14, Vikash Garodia wrote:
> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
> +				if (type != IOMMU_RESV_DIRECT)
> +					continue;
> +

This change is not about requiring a reg though, which is why it should 
be a standalone patch with its own justifications.

Basically the patch should state why a mismatch is dropped instead of 
being reserved.

---
bod
