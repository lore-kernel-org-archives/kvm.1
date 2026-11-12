Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492265;
	b=tFWqup9B2UjiMTFqrOvrRBIWNaUuHNoJxkuXiWWR8WqPjkgjLVOQkV5eTlFH6ECPXAiL
	 C9GAh88gckQI/b0bG+ZdN633T1YE9Z4bGclI/Qf+WPplA6eemjUCWjGrdJJSb7d987TO7
	 MMknIoBRUg3xBZUODBST+6lvy1ZXkxH5/+OZ/IMTUwQ0OcjGJyvDduxYpJy9vNA+F96yZ
	 C0bJhqrAvvLoXsRMlJZwbHvcfxKjJy8W3Ty5vt8rM7OWk7OjZJxYGZbQ2ACZiLIDpkGBA
	 8ThMCEIhYmftpQjKH2w1w/0d3/mKSTZIUxN3Ln0+Zj6WdmTApebOAAnFyAePt59w62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492265;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
	b=W9DNewz9ZloRN36bE3qeGzFDlStT9g+A6coUiKM0glsQ2vscxYe0/J0+kwwdcypNjVu9
	 bzQstLpcR/Xf/WndooyjlV86Q8fgeBi3m+3+Cii4byc4bBKTA1v/S3MQSmF7/h3uXRrEW
	 q8FmbL4fN3W/Zf46YANcVw8eQiiDSv96q4XdWVEnz0IZ315G0hIvLnHVAOlOUzi3cRaoM
	 y/H6doTX72oC4TzRMa6xBXpHnYAtdmBBL8iWKUlaC/YJcjk+okfk7Hw8vQ9FAiJfdCSuA
	 KLfotc1C2k15ssgc5/rkrP8+W2qe9f5l9XP0NianWTetBEuTk6d1r37n4XbTR/MZdqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Pt8mT/O3";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zkdyv7FZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36D606AE81
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F36D606AE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pt8mT/O3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zkdyv7FZ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAUYOx1629209
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=; b=Pt8mT/O3E+MdfLZ5
	irvIgS8uLB5HnZNSkjqw9uCkzssqONuDPOuy5kilOtAmiJYPSUIGSxF9D13buTDW
	+aiq1LxgbwgdvUSAxVbw1ePXNqBwO48/h8xDkJyoNw2v5Sye+5IkGZ5mYZBhXSek
	9IbJYB9tIVir/trXeHtT9QBeG7HdB6KhiLrlaeALCLDPAhar3kGWHDWv5bKoDo3y
	b1Dsb+rh2gEqjZQn5RcwKEHhw1XJjnEJ/9RV0rfBb56LC0GBgri8dlL94paAxjrr
	w1g25DSeUfIxH8cy9wY4Y9eKbEvUgEKPcm3YmIbx4AGfryQISQPQZM7vH49th1Rc
	Ed87YA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs00q6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:04:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so3274478c88.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 06:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794492262; x=1795097062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
        b=Zkdyv7FZMAup7d7VcnxaVAem3tfHj5MSFqZtrqcidXWFs7hcaVhX1gf27oHzB2TEEB
         kvMkGB0vbGlN6Cd4G1y3J3mO1SN+/1C6MGibdA/X4cUpEUXNV7uVokZvfuX6QJ+Poyam
         zFs1Kc81Xes1FcQ9nO/+M2sg6VuLXuIdD/nHbbswzwV0de4ZZH0TVrlDt6tKfU1GtRI1
         qhvF4mjdOIDWI3rrbHgEk3cUzd6nn/pxW02mCQ6GM8vh8zJThB4l4CWFEqOPXWgftQiw
         iua5SuEaZsKOZPSst79yXKuZHWDTzmjEXt3+cVkHS4UhCuYfJcf9jA1Q7mA3tr0SxscB
         Me3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492262; x=1795097062;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B+CH3/jx2KSH+RRiLFJDBQonfvkStMqSF3XdFCzZT8w=;
        b=kFZmLtwLt+7ZY5Ec38JAiJ31QaMcG4nRRvEiaAVxSDA769uY0BOO1pPJYr0E/HCmSs
         eJWXMiFOrwzusGTPTfgbgfl85A9d8fvx1EFKIgyqSxgG34VE4UtKdLCcw3tWb/YMPMAh
         SL40qMTS7NeHB/11hdjuVPBYg5mymkGSkjeDKvrRSeoxjvprS4TsfCD/J8t0RuSpS//k
         lW+h93DE4UcerHMUruE9nWFlk5sTqiIvVdp7/78USVLXiqb6+/4g/Azeo0au5Jq1bUcv
         UjwyCrSv8rkfUTdcwmsBfmPIygVVhntHlHKZdLL1Z2CS0B9++x69+aT05Sk9dVv0SL9T
         tlUA==
X-Forwarded-Encrypted: i=1; AL+hErF4OXBTw7H+BejVGCgMb/DmBvqHSdDt/ji2hT3zo7mJ5sgHYkb5iOWhiJnyWfBjt7peAyk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eui79Y4vLv9SjeIoyz0b0xhuMQkZzOUV7oFNfr0HB+Q7huL/L
	4e3zZrkMqIbpEz2ZlHD81dCPwXPix9Xz4TZQnUVi+1HkIHmVVm2TbCXL+UZ9fD/aObo5zWHf6dh
	ZlXzaYiU4sIJc+p2SLs9dX63ZC5nY3ZD2T4Q2NaOz14QPV6h0sdnwJL4=
X-Gm-Gg: AYBFou2ocejosLBopyi8Fhh40a9VfkdPGgt4mDvdBdedAlgr1PaMUX37Y5BL7OF2Jbr
	20gXEMcnkDJQwxPhMyDVI9ESJ5UzvHkcBLmoYfbBonKlEIdZOMahMMryTvHfug/3Z1I6q38DdP7
	Ul5TV7FMjtcWlPiB/diODxBTV0IUkiwUNj/47V+Aaasz6wwrWyN4qcbo1Vqbi2Z8P+ZXpQjs4cb
	SaUxmqREZXwJmQGP4T0O9kQP50vQmO+hG2FxVQ2SxuC0+CastI2NW5kcE+e9l2gYGgLeCyVPhX8
	NLifv1feqlT4G+RDq0c8pfko/X6X98xv5CxZcR1UQueQNNdHkch/cFl/8/JDj5GCmHt3Dez6Mll
	tGBuBMDbL851bmK0faRgjldRDYz7dOYpGfDrVzSef02pcbN6pIUeNO03g/tNpYJQqglKCet2FQY
	+dMOP/
X-Received: by 2002:a05:7022:28c:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b3c023c99dmr4854428c88.6.1794492261660;
        Thu, 12 Nov 2026 06:04:21 -0800 (PST)
X-Received: by 2002:a05:7022:28c:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b3c023c99dmr4854412c88.6.1794492260879;
        Thu, 12 Nov 2026 06:04:20 -0800 (PST)
Received: from [10.206.104.93] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5029ecb1bsm14027c88.1.2026.11.12.06.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:04:20 -0800 (PST)
Message-ID: <97c4eabf-16b0-4e3f-8aab-1c56912c27d4@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:34:11 +0530
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
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXxYNHbHluaAlR
 K+Ua+sVYTFG6zyNzjki2aTj45HvdO0+W/4eR5qNX4SNXtT1c44l+IDhfX/TRNwT3cFDiVj1eLg2
 hI9GONtzhRgHFtG41v4tWI1fGv3Ad/Ps6TijmAZDNZYiAOwFDAH5QaQklvdtO9jeCMzdujC5Wdi
 OnxVtbHy32xUqapS3Dih1iz6LFvzJR1W5RZJRHh1Bo6B5TCaEyDqcdGqge/yeC9tCO7geIWN7P7
 xSpY+zJgLvXQwLDPuKSlu5Z/TB1XGxEevzfJMRZrADCcYkeKnuHNHn/qLJUhC72ZWPNPt9hVlJj
 pxl7yEWV2KP2pvRUIQkXE/t1C2J+QuBWuWsuQhm46x+RpepaJJyqX/NdGn2wGyCJiYwoNLjEG0J
 ieh8T+l2xfiS6tR2/mWDcWGPlhW+tRc16LqQCun6yhuB9hOdxrJaKM3WaQO+YszPMf9PbJZcvIW
 IJEX/BL/vkr85tWpo5Q==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5c766 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=DrYjplHx1sOd6opfFz8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NSBTYWx0ZWRfXxu5PYYlhY3YL
 IscauDFG8wvTNVqobcxMisR5BiE8wvL4+9Iy6EIsj4Sho7KNJVWR4M5u3IHGh19stD4BVeAAQq/
 9slAZa7+PXM8XlIPpJLpXrew6wmaMgw=
X-Proofpoint-GUID: 5R-YJ87aecby2SG6VqRPzZYSPZSErVY3
X-Proofpoint-ORIG-GUID: 5R-YJ87aecby2SG6VqRPzZYSPZSErVY3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120055


On 11/11/2026 5:32 PM, Bryan O'Donoghue wrote:
> On 06/11/2026 17:14, Vikash Garodia wrote:
>> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, 
>> struct list_head *list)
>>                   }
>>                   type = iommu_resv_region_get_type(dev, &phys, iova, 
>> length);
>> +                if (type != IOMMU_RESV_DIRECT)
>> +                    continue;
>> +
> 
> This change is not about requiring a reg though, which is why it should 
> be a standalone patch with its own justifications.
> 

This is about reg, which determines the direct mapping, hence the code 
is very much applicable to this patch. Please refer this code [1]

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/of_iommu.c#n223

Regards,
Vikash

> Basically the patch should state why a mismatch is dropped instead of 
> being reserved.
> 
> ---
> bod

