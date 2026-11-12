Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490853;
	b=zUzoMDshWHoAUhXU7PKZP/e3hJdcR1vVmYVF8TNsF+jM5tIVCVQLbYYkUP1b4258QQWv
	 SkhAjFVE9zJdeOh+AQUTH0T6cMZtRHhMK5ehweU1rLf2gelRsGO1/A9+3QOG3bURC8GJz
	 UMjzJzcrVGTpzROvsaJxLVEPXeQUwzZwvkiaPQ7A4zQTO3yuo4v0yWSKtLxJnjySspS8T
	 8gzG7j5ryprtRA8mb2xUyCesg4K21b/bw7tKYatvLccEkjny7ya3oJwlNTSPA/t1Lunse
	 UMaKAs6OcM+fE3zzvFEQMhoOHLw9U4ntOOeQXRTUCGgOmaU0xpAgAlfBUGwCa3wRbRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490853;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
	b=KKoQ94LjPVTN6mCD7JKdECac0rJAPzvbSDw8PTqcsEcIjnhcMYh0/e6UUBv8D2ukE6oL
	 4ggeYbXe6v1Bjf6dXa1OfRyBfhmsbSmmBFGBIgVk+EwXitt1mUnZaFAmyRnV3qX6JJV65
	 PaRlSvi3H9CoHfGrGPhMg4GlzMLd9ZzLhAkUwWAPJtosDjwqjdzvZSu4TAha0LWFf4E9g
	 3k5FSut/EW05RRoPHMe+lL5/Z3s1A0DncsUawWbuUYBCAhBixsuq2arTH0D4O0hleNnoG
	 5jDlRUMgMSCiTze802x6L/EoSC69tdegXNG15rs5pjHhtgoj5/+w/IaI8rHpjUqBxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1ka7+F3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F17606A33F
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F17606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MXJW4p4q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J1ka7+F3
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9Dv5j480051
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=; b=MXJW4p4qCPwmk/Nj
	siwIg8CGYz4mbx14lK8b/4E+PnycciVQXlZJAZ8KGyrp72XmYPlT6XINOryUMlVD
	nDORnlOrglRbxPRrD8Ce94CVNek//0daPypSbJ7FrPd+8429gRKZ31NGBbZDFxDb
	CQt1dWund3Qs79JYMVks4RK/cbVJ1/caZ9wFdGJgKC1/BXyL6IZ5rat16Vwp5mnA
	Ec60Smk3bCyg/RuP0INway6N9K9eppnWti6IFvRizqfIFbF5MzmukU1O7+1fLGpe
	z5VKzpKHuTBX5By+fOfQ2f41A0wbe/foYCdXKRmuYzDkNkPVbdMbfQsP3lTXjq54
	YLAyEA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rvdp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 13:40:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c6c1e082bso15249166d6.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490851; x=1795095651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=J1ka7+F3vP3etLz821DEvFnAK9yZKftEAFZobn6gK8xarwo3HbMt7m0B+d+70dk5qK
         Z5OINJiz/T3nDrt9i8OhxCnZwOQIVdTEfmOrXTpjw3C6I5Orpf6YNyr5seinCwoUvj62
         c8K5y4yUDI9DGCZNv8Dqv4MJWga5zRsyVZ0dT0rz7dbEKeJOaNZKQedhfuIRMFLzIalN
         2d8JUbLgddFR1N6WpZEregESKUBxdWucqX31tTirsSCdvMa6POcAO2+Ii0q+O0ILjpvq
         VDKReKW2BKseBzoc21rvm+lddVyxfz5DBDAmOm7c6UiuEWip6iy/7G04UZH5aSQ4hqjF
         ILOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490851; x=1795095651;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKf18yeaPGfHDQplZJqxsRf6LqNoo+87TaDvh3Wdj9M=;
        b=yvgSZKdsyQPg2bf2yEk3hW3nB6rMHvitM3hVGAVZLlsa3F6Gir3knjfSamQO4/Hqfx
         mR4lCWJ+PtueZQl48fVQ8GC+zfYHI1ckDM+UQEngojHo5eZ/uMzCUQ2ubWfVXODyrf/I
         o6SZcxU7CnUl7LzwI+oKI+kGyWf44Osij3eV6hZw/6DVfrak4uzFQ2h9dfNW1X+hWpcE
         ZOkeZ3KZLyoMWxUv9ToxIHV+xpfsXmJjaBKGaeT8/et4QY6B4mY3jXnMjsmi5eNYSLor
         5AZB6azlrMZWMlOUbEkIXn3zuh/F8EY03e5mm5ECVydhPxcIVmXAh+fLUEb7Je8bU+x1
         CjMw==
X-Forwarded-Encrypted: i=1; AL+hErEBEDevWByPuS07G43riowNZAPIln2qM59vyiFR+/g5BuY0ihmoZ/RWaMCEslbMONp/ot0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kl6XiFwT2pF2O/jU0Ivls7QMm0h7Mx2c6y7UDolM9b/dj5NOQ
	LN8QmjrOeJDk1eMzNz4HzTqpXFHsfTUq8Q/xYkDYmurUNWop21rzIr55N+qs2T4jXyCjdlgZ3de
	WJ3X3x/dr/KXxYnh9mH8pph8N8Unffuf/3JJhJACGhzu3iEvc1MNWvfQ=
X-Gm-Gg: AYBFou2RMfayNFmHKEmHjkUYSaPx7Z6hQlPmRzTAksyKXDoxUz8yg2jYWxYslpSHAIW
	6S2WtZt1+BPE+ehFsixncurhFdQPCtmvdzM5UjdJ4Qt5dbckPAmSJyxiN5tqMag67kAPzy5MHUe
	n3mAENbIA5QPigu+/cMR0jDSBjqhbOH2H3MDvWGEittf4aBRVpnvIm2507FrILehqwa8iVasX1O
	o3mc+sMZlhEarGgvz5xFYIBRMGPzbfGFoZQ4NKIU98m5hL20D8qZlVpas/tj+DHBxNNL+UMdV57
	IOjSQ2xZssgnoLTmxzdcbVB9Dcjn7CRcFyazBoN0ER/+vUJyHKkEqD7NPT/sPtmFZ0QQbwW1Dru
	QaksiYXQtARAhf/yAMCXKko1ixZRDRJh81y271BEMgF7RpXv6M4q6NmFiO5mG5OpjCYSP2Pz/Yc
	dm4t4H
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380791cf.27.1794490850574;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
X-Received: by 2002:ac8:5d8f:0:b0:535:b545:e926 with SMTP id d75a77b69052e-55956e5d8a7mr45380501cf.27.1794490850119;
        Thu, 12 Nov 2026 05:40:50 -0800 (PST)
Received: from [10.206.104.93] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b942e83sm74301171cf.18.2026.11.12.05.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:40:49 -0800 (PST)
Message-ID: <dd62aee3-4f23-4904-827c-7f776c4be60a@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:10:38 +0530
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
Subject: Re: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
 <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <yvkcq3zirv5tz2amfbk52a7smbsqs7jrzdisq3qxzw6xkoxklu@rplx3gvxhcoz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G6eHgKA6y_CLl8eiNDzZFlRle90v90ip
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX5bUY1Phl6MfU
 GZ9GeOvVczZAslmVSv7vY20mh7MMfHvkuiKKT5U0IETXy+oEZt/s5tCRPLaJZkrtj6H9XslQMkE
 D9pi6UvIIh4eqWl3c2uYQEd3cxncALM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXxVhuHWuCk7ox
 /ha4Bi29rTiQwthbtbmHmnRtjNkE1/YqpTMbPOKPUe9PW4D0EkDNiybr0sJ0Igid9KWoIjNMMnT
 uEw+yKFbZknJvy6pTAc0jjPc0BQ9C45mDrmM6jd06d9/682NQ5IODJhiYEm3Uz7yVDkN/spqtnq
 8zqrkEkkI7QTp4NLDkDiEEjCkWFVjJpbKwGtFD2pkwQSM6cJ0zf+3DLwaz5eG1/lfhTbOG1e0MU
 pOv3b97mhNEm/qeRxNGE9xpAfPp+ABTlpyBLT/jN+tKuWCVV/zvjy+WcVqOTvHPJ+SbOCiL1usF
 SLmw9GfvthHneTEDelZUFB5KU1RdEkSFpEA62zAcGD3exccx1qRq0gwKz5BBL7gJp4m3R+sxDSC
 RZ7IvGEDduieNQhyFW1k+Q1SBu97GdANQpcux7jBDPpn0IQchrj4C7WV6RqLikibxctsT9wd3h2
 nzNrSh1+z6U+aWPzm4Q==
X-Proofpoint-ORIG-GUID: G6eHgKA6y_CLl8eiNDzZFlRle90v90ip
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5c1e3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UM6UlptfRCpVODDSDqIA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054


On 11/11/2026 6:33 PM, Dmitry Baryshkov wrote:
> On Fri, Nov 06, 2026 at 10:44:26PM +0530, Vikash Garodia wrote:
>> The OF_IOMMU code relies on OF address parsing helpers, but the
>> dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
>> of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
>> annotation to handle configurations where OF_ADDRESS is disabled.
>>
>> Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
>> preprocessor guards and __maybe_unused annotation.
> 
> Why? What's the problem that you are solving? Why is the current code
> bad?
> 

The commit describes the problem as "The OF_IOMMU code relies on OF 
address parsing helpers, but the dependency on OF_ADDRESS is not 
expressed in Kconfig"...and instead the code had checks for config or 
__maybe_unused for cases like sparc.

It was discussed in prior rev
https://lore.kernel.org/all/20261104160346.GD3951195-robh@kernel.org/

Regards,
Vikash
>>
>> The only architecture supporting OF without OF_ADDRESS is SPARC, which
>> does not use OF_IOMMU, so no functional change is intended.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/iommu/Kconfig    | 2 +-
>>   drivers/iommu/of_iommu.c | 4 +---
>>   2 files changed, 2 insertions(+), 4 deletions(-)
>>
> 

