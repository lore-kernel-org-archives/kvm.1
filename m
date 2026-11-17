Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932693;
	b=hA8mQVKitG5xHr5T/GUnUfMYo4tY+aY7m5PX3p5wPFYSiKBwSdc6HQ23A4/nt+BlH9Dc
	 53ixXbxB5QH4kMkMK5GRatuisuvz2cHDX+V2OPVPH60AJOCmS46gnnjG73o8HPYqS/geK
	 Zs2JLOBg6wvQQd3RaY6lWNIM+10om5KjBirE4W/nXD9NfC591NVEBIKzVqaP+PyTj/hml
	 53b2WhSk+X2WJfBTFm0x4Sv5RrXTMgbb8IvB9PiZwz+vULyO0nNh9kx1WHnAOh/pvs00H
	 GXtgQc8wmzArdJN2BOkMJtHyVpa7z5CC5eOd6GLRXCMttwIj0VRNGi8yW3qLGTsPGPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932693;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
	b=VtsTLVYvNyrorPYc3ZPOt13u8IN8CRNmnrmg8+6OT9vKUn3MtMAQb/j5t9kRD6dF1LI8
	 Eg1KRGwBZyCCVarnH4/GRaqcxHVnWbbRSmWSjXJb/tGAz5WZfoGtOjzxlf3f1f9+9yxWF
	 q8Gf0+IK/IBXsXMskZ9i7HOdJfPn5yztfPv3JEJ98oqBuAn3Q1KDRo89mi1J6zcOCZ5+w
	 d8NhT6jecfxM0jofdRfnH85Z/QcgL1cciBqLdLGlKz1muu85KCDwczhanqa4jnh+9pMth
	 GCnVB5sJLucidIkbnO3MmLTT7yB9NRSEDE5wdZwDQyqRF16tA6GkUNorvj+QWNrs6gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=druVJ1EU;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA1606A331
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39BA1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=druVJ1EU
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQhQS534575
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=; b=TOQ8+lCUML5ZO5h5
	H/qF60e2dPbCcKHoYulEN4H55jM5yHe+56cu9z5mHWHJvDpenV3Nx8kiTSJ6jQHp
	bhh7xA0QexaksUp3Rqqb1lIlzXljRLnYmuNw7tWpcyiizbcPqOpo2hqTwloA5g6s
	IaovTRep/vtw6UMFwr6B2eV+EAwdQm6qYPEAvPTlxQHd1lzS1wzhOfJGBzi8jOAE
	rPdLUBbDbWn9VxP2HR6YRcotGmxxAwj7RiauSqrxOxD/Vqk7a9jikwbX8PWixTMc
	cqAGMcFJYiWnFHqMIe6wY6jJAjQr1q2n9s9/tDRnM9QAfNxNVyXdUyiCFV2xKFtj
	DC+G2A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gfr2pgc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:24:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so63273eec.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794932691; x=1795537491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=druVJ1EUXl11VU1FgJPsRuECfDj1i5wVqQsWA3hOmhx1rkPDOoiuhSpvy/64BoqTyu
         A+JJNrM15WxCYs0zBYnNbrL2yI2a9WC/GItF2lhKhpUI1Qy0a7tAl47wE+jS8shdV77G
         FT7oEGtejWvfHgo9G2lbR8y2Yl40FhbuQ1d7zej50s1jSoALxbclnEf6KKDMvhnHEzdn
         BhUzSYfJyPlDDL4jf7u+6BiyHVaSe4NNcASD96LCCB8pnunxRrtRinkbdpg4u2DqVOAE
         SnxXliS/w2o7T+vyhbx8OF0RxMyJpqZFU/KMzqWzSyHRb/zrqwapd0Gyyhr0xZtJOyi/
         /udA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932691; x=1795537491;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=zpDpjHYsVMldUan+Jc3lnF86OkaQpmkS0YDT8N8DS8aePzkz+2qMnN5/W+k/QJH+W3
         ZpyxXo/XyMQa+xOyjZ35+P1IV8vrbBlVfrkE3LEEVXdjEeiHCoo8qp+Mv/TLDnaAXZE6
         ++gwuI0z6icdwyXMLF/OP1HK7gUTJ8hoT0mYLNLOEuOAEH8w6HV9OIIukXSu30mqzOlb
         sH0S/uf/BlXXdSBuo0s4HqVPkvyLt0tXK1VFKoFZX+zlq8dDUMWij+TZmpXkPEE1NpUs
         FjLo/X+UW5y1xDbt3BwC+SdKcryj4lrPpB4eLZ0//7HM0unBOtB7oCx9hJb1N60xGAIl
         1pkg==
X-Forwarded-Encrypted: i=1; AL+hErEibJZpOaHDgRI3Y3w6IcirQTG6l4kUSgE1eDPF14c9O7Fa4eIY5EWQDNjRGbAJ7c6BjS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SlAGYej4RnPpZvHlFgWNDbWDBymQo0lfenb0kaZo9IlwYLjrY
	7L/4WT6zENane9WjnYjifXAfFeh+JvSYHHbjNxCjGYUBd0oF87AO/Cex12jezPseFTC8u7kl2A/
	scb4CJPdoVr7txY82ZMXjy9Jb90WfgP/Rt2Qmmi2Lvh74Pa2fT8oBhzo=
X-Gm-Gg: AZFdTZdHWDxRA/rF4npFZaV6lKy2abGYXoZyiEnmp41nLOqlENghYJ/kmh1MUQet6hH
	vWCqC/KhZ0+qvIsiRcwGk7PAhLL2pLzO22L45YVWv/wfrecZa34/pmi1Q9rjeaQROBfCSPZpD1l
	4+MxfH+mofn3VAKJzgqKo9/neCHE2oG+6HwkpqEODa/9cnT4Zxzqczv40hT4hE1D9VgAn6qwlM/
	SBBEFy/8iJRoVBvE/UrdYsvjJvlDFBjbBBGYWo3TCyXPWEae6tFdkjONFVMfAEYtfcSaVRxw4oi
	gKOxr26W4QOnuKbbxnkoLfv7DCQYJEzYdnUP3o2TzeMGq4WpGRxWYnDWwmYMKmJ27IUUJmwTZ8b
	cHvSTWc8bLcosl3AAVzDVekB9oHLluhOdH8eew/+tSmacwuHfCd0rIbLzpCGRjkeKJZd2uq8vnT
	8qlw==
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266821eec.4.1794932690874;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266785eec.4.1794932690165;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
Received: from [192.168.0.6] ([183.83.140.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm48642584eec.23.2026.11.17.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:24:49 -0800 (PST)
Message-ID: <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:54:39 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        linux-media@vger.kernel.org
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X/rHu2Te c=1 sm=1 tr=0 ts=6afc7fd4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=jbSCbZcLpKDW+DqD08IedQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xx2vz8YcUDPT77_BzWYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: _fMnpaGMmUiOZaRxgkYZtJqM-FaBY7RZ
X-Proofpoint-ORIG-GUID: _fMnpaGMmUiOZaRxgkYZtJqM-FaBY7RZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX5ql2P5yOyerA
 YgfjsJzEjs3OsQfnv1J0/Tmm6+KFmIKjCtObJTtGhohdRn5qjIoZwk4wqGhol7hxK+MHcOhCPHE
 mvshtLv5eefgbsD/IQ4m1GMCY6wudUYgpWX5ROR0XPdSjisWodxi+Fm3FVn4VNzsgMaW7G8rGr0
 vIF++1YswLdcitCEFaeIV2umhSd+GEI6JHscQMXt+yQ482HtiriIXIYOfugJUjZkzo8hZwLVDzm
 NtTwXeskZf9ezI+WsncRlGHkjF6u7y5c8wZQuvPzK04hCmGO1XSPdKBp0TX+8oRQ8bFPe6g0XWZ
 sKYge/hDLf4lBq3XfuCCjJuUJlfR4DIFb0zsiWwQj0ZpSAxIwX4aQlBfzowlxV72R+0gI9vtATh
 eLsI+VgP2wJz/o4TFM5R6bb5kGx5JNc3w0C49CYlPAgLjlMsIbYpx3tDJNwP21iHHzbtzR2WIox
 jHhRDc3ubErD6T+A5Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfXy/DDmevK1L2e
 alc/q2yK6NYrX4ZB1B8WX0dNNLNPA6VGtLA9Dn+Ivw8luOcpIhIMS4tCYILH55YPocjC5fkE2jz
 ivn1eFijCROPzNZRBkuoGJRS/dGhiG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170065

Hi Krzysztof,

Thanks for review.

On 11/13/2026 6:41 PM, Krzysztof Kozlowski wrote:
> On 06/11/2026 18:14, Vikash Garodia wrote:
>> The "iommu-addresses" property describes an identity 1:1 mapping between
>> an IOVA range and the physical memory specified by "reg" in the same
>> reserved-memory node. Without "reg", there is no physical memory to map.
> This looks like ABI break.

The original discussion was to avoid keeping iommu-addresses in the
reserved-memory, if not backed by reg. In such cases, it is more meaningful
to move that entry to corresponding device node.
Given this direction, the schema was defined accordingly and the code is now
updated to match the dt-schema. At least on Linux, I do not see any client
using iommu-addresses without reg.

>
>> The DT schema now requires "reg" whenever "iommu-addresses" is present.
>> Align the kernel implementation with this requirement.
>> https://github.com/devicetree-org/dt-schema/pull/207
>>
>> An identity mapping requires matching IOVA and "reg" ranges. Reject
>> mismatched ranges and report an error.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>>  {
>>  	phys_addr_t end = start + length - 1;
>>  
>> -	/*
>> -	 * IOMMU regions without an associated physical region cannot be
>> -	 * mapped and are simply reservations.
>> -	 */
>> -	if (phys->start >= phys->end)
>> -		return IOMMU_RESV_RESERVED;
>> -
>>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
>>  	if (start == phys->start && end == phys->end)
>>  		return IOMMU_RESV_DIRECT;
>>  
>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>> -		 &start, &end);
>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>> +		&start, &end);
>>  	return IOMMU_RESV_RESERVED;
>>  }
>>  
>> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  		struct resource phys;
>>  		int size;
>>  
>> -		memset(&phys, 0, sizeof(phys));
>> +		maps = of_get_property(it.node, "iommu-addresses", &size);
>> +		if (!maps)
>> +			continue;
>>  
>>  		/*
>> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
>> -		 * that represent reservations in the IOVA space, which are regions that should
>> -		 * not be mapped.
>> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
>> +		 * the physical address and size of this memory region, for an identity 1:1
>> +		 * IOVA mapping to that physical memory.
>>  		 */
>>  		if (of_property_present(it.node, "reg")) {
>>  			err = of_address_to_resource(it.node, 0, &phys);
>> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  					it.node, err);
>>  				continue;
>>  			}
>> -		}
>> -
>> -		maps = of_get_property(it.node, "iommu-addresses", &size);
>> -		if (!maps)
> I miss the point why you are moving this part. Irrespective to actual
> ABI break, why do you nee to check for iommu-addresses before?

It is more optimal to check for iommu-addresses and then read the reg. On the
contrary, earlier reg is read irrespective of iommu-addresses is present or
not. So in a way reading iommu-addresses first would ensure that reg is read
only if iommu-addresses is present.

Regards,
Vishnu Reddy

>
>
> Best regards,
> Krzysztof
