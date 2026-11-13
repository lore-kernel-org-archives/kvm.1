Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562600;
	b=fu2+emhBv08+SvPyVjdoFOQzT7xEB8bF6nWgPbMmLmWNp6yiOXdZ1C4SP7WPc9B6RlPs
	 IL9wy7COcIKGYDUWVtV0MidpjV4ev1g858VZIG1sqbZzfGwz6gULt2rvSZCS+zyRJxpMw
	 sNGYMGFH9wDwNbKC5sSX+57T4pzvWnoIk+tdnE8lMeBRpKZkiVZarsC8usHCka10TmR5J
	 lDtWqtz/gaSW2HnToTEP8x5J7SiRZ7UiGu9TVo4U4irLl/EVQ0mgI0Mjap3NdkhBEWkr0
	 yJpmDAdhERrQv6NWHp0yVvlDJcs4UiSaw3EM9/a8TzRwhkzcmxEYi/4D7Un9zxdEzUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562600;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
	b=3vuLf2bZMMceAk7i95h/ObomCdVLyOFMuxSkSS6AyjY4jtkE3kU9PQqHlvlhRa8PLIG+
	 qPHG1zXotrlkEgEdYwb5qu8M2FyZpX+UiLk7OWlOiTkKUFNXyF8SH46MwAaqz77UK2Ot7
	 N15RHkF2ufpBY+OAVzU4nV5laDV/ypa9tUZw3VT5XfPohXSh8XOtW99Ju/shKOYY4l1tj
	 I9yB/D4hfdTvt0vg1VaqVOlUAxrUWSZIqS9pM3JXk5eQp5My9B+H9e7gRVnpfZX9TpQtR
	 dRjGh6/WuF0FsOZME1sRsc5c0PpD/ITH1CpQhryshLt1/ZZ8sa6HDb8cHIgvig/jkFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GVKFGMs1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wak6RPD6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9B606A32E
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C9B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GVKFGMs1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wak6RPD6
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VSiS1527723
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=; b=GVKFGMs1XMs9bbXp
	Zhg5r5J6RwMc42vPpYNxUdrGnsI4Fhw2BdDU0rdu3o0sFmMKaQu1NrcR2rTbbR8R
	GvHPsp+4adGh3QtD7FPMoBIFtRHYLVkbyZChjnR/NLvCdmjR/OrbJPj7fl4qeV8W
	a1ieVPsDJG+7JDIGNw/V8eBuedTZbN9Wy0yyelW2uvkedT6T910Pio8zORxPVIZq
	cgFh3n80GjMVVrvJDu3INzRywdH0D4acbetf4CAQIkFyDea6uPH4cEbOmx5UmaHp
	nwj/BjflK9AxQPPF1ZvcJ3MYKU+dUoOYlXPQrcNKRYBmmtJfK/Ul3Q6ffcQMlx45
	ZG45lA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5r8nvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:36:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd66551e02cso1012127a12.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794562597; x=1795167397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
        b=Wak6RPD6kKAJD2xcOzv6C5pG0152NpqFM7/5txgIakOVGBBCW9mPOqpc/pMIeLfWXj
         3ULZuTnfWPFFAvo9Wa4W8gPIvMYbtquaapskupEKbVPvOmrUW/c4IAurbnXryJI4lsvd
         KrZiayW0emk47CGdeDDttkmvtQ35McX+vLZyuImModRddJIAUa4opiCdlShS94U3YKUJ
         Oz7gDlnZUV4bOm+XSB7bot3Ux4GvtL9voAQ4NIvqu7EnWrgc/31kFvS90bnrjWBiuSab
         H8TcLUW7ZMyTnAv9l3JlI1LZSce59CJwaQJVqMd0eqidWGLUP8vhnMonIflK5AfS20yV
         AyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562597; x=1795167397;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLsQc2gUWWCsMRZXIeMbM6mV7EAFqw0z8J6u3kCxlKY=;
        b=sYL6/CGvNSBuHf1+h9HY/RNhCyNnVaCb60hXcqaYx5/eV0eNfSgW9yPGKu2iBVW/cS
         mZgqu50C23S/u/MVSLLsiRn4/FSqcCXminaKj2rRguK9RgkYYX0z6c0fLjCC66hR2E3p
         4RxwfvALEEvHke/M4XJDhLDmWJENh85rRQUfOnA/af6kUZ4TEI13xu//CiCtf0oJ5NI5
         4Ixbw/F4gQa8la0EEHguQvQJvRw7RKSyIJ5wd9ja1aq8Xn4/24CQVyFhUfu6OdpRhyaM
         CKN3JJXal8wuffd/S4onMA901n+uts95R61+bS2efAENEYmuUeuGBohkn0D/9cSZZkq0
         V2ow==
X-Forwarded-Encrypted: i=1; AL+hErGmtSXiLXwG2BWvC3W60gf0nVjC6ulv4ZI0cdBW5slyD9Tn24BE+MmnJEKksjuQW7MxjZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4yCmdY77mqMGKUzKa5sNdjeP+T6WVOpOqCxi+CFA2+9+cu39Q
	wuFi+NS98WNh51Y5xtWxkHfqfJszqWPK4divxscMwRIVJ8S4NEMZyhvFL1EmFZSr8UzeofLm2fL
	M2ZoBiW3BoOJybnh8Rs8TIz2W6FnWu8I6AvS5rJFTmwnG5Imv2oXW6Ow=
X-Gm-Gg: AYBFou1dMgMoMhYWy/pzZLzsPLBIxASQ14cPXyY0yUe6nkrtQFyj1QKVahFHCWNEcNq
	GrJxpK+/IE5pjHgE/cr9Qkzdgh9jxPnuyverxrcEgf6t3KqvUNodO/hhHyydIB82u3gMbTyASJQ
	Et94E7V9qbwhUiFBNH08v4NRqbBh7vaiur5eUS3B/HSm4b5zQ4mRBTDC4n8Oy8cziiHT+gFsmpI
	4OJcLxD7JbJNglodSKPNsJLBhws2APe1zom6jl3jLe5In9RKZ33qOVvufRgtusorGHAjdVc3bAO
	0zE+V9p3/9HEru/4MD+ur6x5mJLhF2hcylex7Ppi1Fr854v0OmgP3NlDuSu3UUJnUn0snCCqUeZ
	epbkxQciUBe45eSaAslHRkcBlcnkV/E9QMeET1E2eHcMm8EejjH/H+aQdhZQ9XCxTz6EZXtCBMd
	HssVTIgpcUzR333Zz4WW64NxO8vtrkAiXk6370OqA=
X-Received: by 2002:a17:90b:1652:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b1b0a42b8cmr1747885a91.48.1794562597506;
        Fri, 13 Nov 2026 01:36:37 -0800 (PST)
X-Received: by 2002:a17:90b:1652:b0:3b0:9317:5842 with SMTP id 98e67ed59e1d1-3b1b0a42b8cmr1747854a91.48.1794562596993;
        Fri, 13 Nov 2026 01:36:36 -0800 (PST)
Received: from [10.133.33.5] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm3828201a91.1.2026.11.13.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:36:36 -0800 (PST)
Message-ID: <68bb5fe0-9005-4517-aec0-c39021a5b24f@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 17:36:28 +0800
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
Subject: Re: [PATCH v7 5/5] iommu/of: Add support for "iommu-ranges" on a
 device node
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-5-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX038NakgjkRCU
 X330/vu3lbLfTzkSD4j2gW08OewkPui5HGefXS9opOP3Z3mLZKXsoKA0+VaHlqk0I4852U3d/Rs
 7mFyN3zHRiSiHMmByFhkb3om3e23ILCwaL/e5zBiVVkw8Po8SJKgvZyYWBqp7MqczV7QcQqe9JW
 AFGmhwD4F0abZN88BwKr6m2rtsOLI2E0ccmQtgzw4bEkgmyWqbxc3XFyX5ol0WQqRGbv1QQ/EQO
 c/KBZw/H3EzHlDEg/1Br/OSrmqfn92wnQHNoAbqEbJC+pui+dn64Lb9eXM2vKTted4osYas5sZu
 1m8TVkv5/rTpLRi1YurJwYKF5hPdbL66YvJp9mVxdhfDQXoxpqma27jPhevVGFh6ysFwPE/n3lz
 o6vrEAThtOZmi5MO4pTX9lDSvTdirzWAixcxAnl4a2AJeMgak/AgI433DMUIi1/tIeWhxT6lyJL
 VhltaBUqRGGaplLk9Hg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX7ROCXxqJZ9zd
 NYigwVgXqIRIOh7wjcm/LghzNZvTU8chCsuwneHfcI7eVvUzshklO3khD/QgCPKtemsj3lVoUk/
 IWkVyNxjojUWtdhNTKXGZcD8Fw1uIPc=
X-Proofpoint-ORIG-GUID: _5g6RLIGvDHmLcQrkqIu5wDrrayAKcGa
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af6da26 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BUd8g3l6cCjgLUHkIXsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: _5g6RLIGvDHmLcQrkqIu5wDrrayAKcGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130038



On 11/7/2026 1:14 AM, Vikash Garodia wrote:
> Reserving an IOVA address using "iommu-addresses" requires it to be
> placed in the reserved-memory node. But when "iommu-addresses" is the
> only property being described and there is no backing "reg" (i.e. no
> actual reserved system memory), it does not really belong under
> /reserved-memory. A device IOVA range is specific to its own address
> space, and does not describe the system physical memory to make it
> qualify under reserved-memory. Given this, place "iommu-addresses"
> inside reserved-memory only when it is paired with a "reg", otherwise,
> define it within the device own node. It was discussed here:
> https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org
> 
> Existing "iommu-addresses" property expects a phandle, which does
> not make sense when the property is defined within the device node.
> "iommu-ranges" was introduced to specify the device specific IOVA ranges
> when there is no backing "reg".
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>   drivers/iommu/of_iommu.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 00b02c19f27e195fc36c4bc1d91253255147c9ab..e133d3b346feecac7e2bfaec44e4882060ee89ec 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -183,6 +183,111 @@ iommu_resv_region_get_type(struct device *dev,
>   	return IOMMU_RESV_RESERVED;
>   }
>   
> +/**
> + * of_iommu_derive_resv_regions - derive reserved regions which
> + *                                are outside of iommu-ranges
> + * @dev: device for which to get reserved regions
> + * @list: reserved region list
> + *
> + * A device can describe its own usable IOVA ranges directly on its node
> + * via "iommu-ranges". Everything not under those ranges is derived
> + * as a reserved region so the IOMMU allocator won't use it. Entries may
> + * appear in any order in the property.
> + */
> +static void of_iommu_derive_resv_regions(struct device *dev, struct list_head *list)
> +{
> +	struct of_iommu_range {
> +		struct list_head node;
> +		phys_addr_t start;
> +		phys_addr_t end;
> +	} *pos, *new, *next_range;
> +	int size, prot = IOMMU_READ | IOMMU_WRITE;
> +	struct iommu_resv_region *region;
> +	const __be32 *maps, *end;
> +	struct list_head *prev;
> +	phys_addr_t next = 0;
> +	LIST_HEAD(ranges);
> +
> +	maps = of_get_property(dev->of_node, "iommu-ranges", &size);
> +	if (!maps)
> +		return;
> +
> +	end = maps + size / sizeof(__be32);
> +
> +	while (maps < end) {
> +		phys_addr_t iova, iova_end;
> +		resource_size_t length;
> +
> +		maps = of_translate_dma_region(dev->of_node, maps, &iova, &length);
> +		if (!maps) {
> +			dev_err(dev, "%pOF: failed to parse iommu-ranges\n",
> +				dev->of_node);
> +			goto exit;
> +		}
> +
> +		if (!length)
> +			continue;
> +
> +		iova_end = iova + length - 1;
> +
> +		if (iova_end < iova) {
> +			dev_err(dev, "%pOF: iommu-ranges overflows address space\n",
> +				dev->of_node);
> +			goto exit;
> +		}
> +
> +		prev = &ranges;
> +		list_for_each_entry(pos, &ranges, node) {
> +			if (pos->start > iova)
> +				break;
> +			prev = &pos->node;
> +		}
> +
> +		new = kmalloc_obj(*new);
> +		if (!new)
> +			goto exit;
> +
> +		new->start = iova;
> +		new->end = iova_end;
> +		list_add(&new->node, prev);
> +	}
> +
> +	if (list_empty(&ranges))
> +		return;
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		prot |= IOMMU_CACHE;
> +
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		if (pos->start > next) {
> +			region = iommu_alloc_resv_region(next, pos->start - next, prot,
> +							 IOMMU_RESV_RESERVED, GFP_KERNEL);
> +			if (region)
> +				list_add_tail(&region->list, list);

Why keep looping here after allocation failure?

> +		}
> +
> +		if (pos->end >= PHYS_ADDR_MAX - 1)
> +			goto exit;
> +
> +		if (pos->end >= next)
> +			next = pos->end + 1;
> +
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +
> +	region = iommu_alloc_resv_region(next, PHYS_ADDR_MAX - next,
> +					 prot, IOMMU_RESV_RESERVED, GFP_KERNEL);
> +	if (region)
> +		list_add_tail(&region->list, list);
> +
> +exit:
> +	list_for_each_entry_safe(pos, next_range, &ranges, node) {
> +		list_del(&pos->node);
> +		kfree(pos);
> +	}
> +}
> +
>   /**
>    * of_iommu_get_resv_regions - reserved region driver helper for device tree
>    * @dev: device for which to get reserved regions
> @@ -262,5 +367,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   			}
>   		}
>   	}
> +
> +	of_iommu_derive_resv_regions(dev, list);
>   }
>   EXPORT_SYMBOL(of_iommu_get_resv_regions);
> 

-- 
Best Regards,
Yijie

