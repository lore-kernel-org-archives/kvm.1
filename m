Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493200;
	b=oDP5aY/CzEhI8qSHrDXnXGKphzHNMsaRgCkZRdS5eg9FVkHgYtpcq3zmxj+HgYdjKuXD
	 lNsKONMBbUqY6Dw8obo2aQlqGCMMHUM7yET/3aoD2jRwQreFYW1te+3lBkrk4ixuPrkcE
	 sPhyBt6qSBuHBKdAHvPfL2VEgAiwyUHxJKs3AH3qliuQFGOHVMaOhMC8LCBikeVM0uNc/
	 kc5qZ1fNb/GtGPDN3MnuUWurojSoqgttczwRxr4VC49JddVJplZnhhLMYxS3iQLcng01W
	 1BZwtOLrBEJdt3VVECUyD54E8lWkzHzfL4Xm/gPsHhyVeSC0UIEs4QZ2t+zZGzGEflQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
	b=gqGPXfgrteTRFd1vOGupfs28JjQwJ7TXJwhlHm2cguM+Ceq39j0EX/TmF3dpJUBGcQDu
	 MNfki90I8Djd34VXeIyDsFRHNPaFnz09NJPYzdKYJLQB1Rs3tPz10xwjkNHLcwORn7jVc
	 y7BLqQDOcBKBJBiSCRvVfy9zUfFt03DKjjk2fbms++wnvMXjpG+fcgkKbiom550dEbHEf
	 5/ca9mvRBkEvwdABjClKUbpCCE/cTq28kcnBzad/+vLzbBTIfqVXHE58uqzNNb5OxW3Y1
	 xNNW81P+JTS3i/hsvNfVfzyisxe/jntHV1+qKd/bE6K72TOYpEe0g88952o6JEvLO0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kZgNCjDz;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8036072A1C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8036072A1C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kZgNCjDz
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso42409455e9.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794493198; x=1795097998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=kZgNCjDzv07bETMIK11cdb/uvBRZbV73giXfxQwMZzyTHK4wPxme+erks4m19S/IhN
         cUmGDySLN9pAi/hNBAG4/zkhGD15KaIcLH83YK69msdqB+KjIz+jo+dqRGEwxCIDN3pS
         wv+lj7+q2dNnDNKSmpIAEPa8JJXdj4rT3H++MAjNm7vHmNAJSolee2JBYg6uje1fgh3/
         gC0rFC1SA9Z/j8jTB7Hng0PNzah8keLDOdxWsDRKSNQKbs/2W57p8dv85B9/1IQYcPTO
         teZI/frS3AXhHwAbjhHeomPDiPCMxzOF/KhFhMSrSPzGC5hRSIM5DtL//P3tp4MCh9fF
         eU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493198; x=1795097998;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ycPyXlQxqPcynh4hgD5HOBjhMwhv2JiLkDDxXjwNZ6g=;
        b=M0ghmux6PypZLOIgkIFL3JQQ+SPnEMhixss1fn5WEQLCdx/RhflTZ8+W/gKeVruNER
         Ae4hYesu0LwA/us/orABR2Qbb4v1e4mcLtLdEvxRhrmHfeqACpQaxwCs92EltCTaxhAX
         o4RhYNP7K9RdLoDS5xxr43gA7IzUxi3BRJOvmDhOlu0hamd7AxoIek72qeoUaKJH4aZ2
         CnuGIsG/zNqdL2nka4WXLidGek6zOJXL5kcriAaFrWD5yjIYyPN3Gt335flcvOgWsyj+
         67r3BAYYAFZKeF+ZuRvoacRhSxxboY9kCBSF0nhuu3aod3gHp4jVLG+ZRSjzsDOH4bdR
         Qa1Q==
X-Forwarded-Encrypted: i=1; AL+hErGWleM08zxaiD0uTndcWK7tvbcrDj3HapjkaBA06ZH0ag61hzhWJ9mlGHYzasLRnjpxmAY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6ruXx+lkAc/SDbAiLPpcp5sOloAe84nF6c50rP7EInLf2lZ/v
	XF6F1To5Vq5DgH3nPXDZrbxpB866c5J3GWmQUet3E5uL7Jh59G7tFNpxEoebX35IuBY=
X-Gm-Gg: AYBFou100ZgXT5PZXerdljcT8bN/XldTnX5h0nmcOhyA3hyfXKiJDrCoK5C/xE5r231
	cHwHjo4alvpIdlPbgxj1y2/lsWlVBv82l8THkG0roOhevPyYlaB1K7QtEM1xkbocL/Dgx9LfHB4
	I2/jg7Pmbxz9NTBuPosisxJdHKXW/EuozPnFWeb1x9u/1NExJhYUEexKFokhADsQDvaxNENTw/C
	KS+1rXk7PmnuY/ZNmg8VbheCemie1nF0QM0Ajt7DeWWQc12FmGUzMry6PCjiXyn1CzQwAJ2PLG1
	49VnzjzrPUi/DHYjz2sNuic6T8NKctigL7c3kXaPFO2uKZoZLu+hZ9qGQLPYAhEd5iZpq1pUnev
	puHB4KU9NU3BSU/8vhH0iKqSvdY6rIyn+w8QX1LEQQu69C9VbirB/3qclP6/4ST8rwD/VFVqoTQ
	9BiKAzxHB/iPndSHveMoRrlFqTk3XZL0fFSS6+ti6HydSkoJ6Zj9UjBSC2hHAuXuJke7J+Cs7sf
	iSj/KZ9RohavBRj+93zFJCZQd12LOvHp+hOgCnh65P9OF0hhm9nn0M2iUyZi1Oi2SVZtwGxRfJt
	LPa76bi6Yc8/wan0WNz1SEQ3BD0xnDVEiXG4LK+k44M=
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba0931ed6bmr104812575e9.4.1794493197930;
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Received: from [192.168.0.167] ([109.78.26.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e29d24dsm75906065e9.11.2026.11.12.06.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:19:57 -0800 (PST)
Message-ID: <a35530a0-3a4e-4975-8335-94898aa9abaa@linaro.org>
Date: Thu, 12 Nov 2026 14:19:55 +0000
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
 <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
 <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2026 14:04, Vikash Garodia wrote:
> 
> On 11/11/2026 5:32 PM, Bryan O'Donoghue wrote:
>> On 06/11/2026 17:14, Vikash Garodia wrote:
>>> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device 
>>> *dev, struct list_head *list)
>>>                   }
>>>                   type = iommu_resv_region_get_type(dev, &phys, iova, 
>>> length);
>>> +                if (type != IOMMU_RESV_DIRECT)
>>> +                    continue;
>>> +
>>
>> This change is not about requiring a reg though, which is why it 
>> should be a standalone patch with its own justifications.
>>
> 
> This is about reg, which determines the direct mapping, hence the code 
> is very much applicable to this patch. Please refer this code [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/ 
> tree/drivers/iommu/of_iommu.c#n223
But this change is not about requiring a reg. It's about not reserving 
when reg and IOVA don't match.

So reading a patch entitled "Require reg for iommu-addresses" doesn't 
actually transmit the information of what this second change does.

Which is why that change should have its own patch.

Require reg != don't reserve reg + non-matching IOVA.

A reasonable reviewer might ask "why is a mismatch dropped instead of 
reserved" - which is the question I ask myself as I read and IMO isn't 
answered - which is why I've asked for a patch which reasons that out.

It may be that conjoining iommu-addresses/reg and !reserving mismatch 
are in fact the same thing but I don't think that jumps out of the code 
as you read it and I doubt adding to this commit log would make it much 
clearer because it seems like two changes in one patch.

It would be something like "require a reg and don't reserve on mismatch"

The "and" part is the part I'm flagging as likely deserving its own 
patch which explains what/why but "require reg" ain't it.

---
bod
