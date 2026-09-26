Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6464286425
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790429950; cv=none; b=dhEbWxA3hMClqNS8O/QsoPCV4TXgk2gJxXx7iBivn0oTF+ZpqeHmLkvwmBBbjsM49bjMIU1v8CYDsPbHY9sfJzR8a8BQUGPyWNTnQPk1yY8Fjr2KOFiZOpEUg3t3h6qE9tZLGyEl5/YWTRifH/vZiE+sjQqomf/a6TWxHnZH2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790429950; c=relaxed/simple;
	bh=kxpM4woXbVN3C61iCkKOMRV76lDdpJXI6TiGREDFTAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5stludT/GaYMkf1OBjnhETrF/Tc2prkSbb7X+aapBh8uzABiEPeGlBmrElIoybawD2xozIdxa3sVC9ud61Pdy0N2OZ7Mk4LqBXq8CgZBj/J+rm9TjDb81giG5jR5Sc1WUqdjk5UXYLhyhY2a4AHyeqnzMiEwrGp/tx3ZFjRKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3LxcIkF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c0IIjmNq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3LxcIkF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c0IIjmNq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QAnSlx3079069
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 13:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ryy0TaceLombIiL4TAr0+o046iePkO13SoMlmGHBezM=; b=U3LxcIkFYFlytTfx
	jKLMqAGBDdHcRGSfy0eyL488h3TuiAXRHbKaj7yFfM6RsQi2DGKYQR1l4GU8vTBH
	FVsE9fjpyCIH3hhsfyWB+2RtyVBl3cHaimRcA5bJUME2qFn3NxV9PW6qvlRrnXje
	EZ3Yoxe81pVs0c+0h7OdHZyjv/eXPVRL+0tpz+AtiYFTdUjz3FwVVLMvt6p9J4aG
	+9uAgrGKAbdbrQLIfqt+o6hQvMaF5Wm0jGf6WunNnLuB4j6x6IDi9/4r5dyzDMjm
	HMl/oSGx736WTdqJY+JoJM8PGofxMkuJj6k/k/fcnWf+rYABFktjTvUsdb3aTKio
	ojh1iw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx7b9rt1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 13:39:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so3555834eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790429947; x=1791034747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryy0TaceLombIiL4TAr0+o046iePkO13SoMlmGHBezM=;
        b=c0IIjmNqvxBSgN6KIxbAkZUxljzon6eZYc8P4ZM8D76u1hxc5oPJmSsnSqw7zJrsKn
         IwtPNhk3y9BtTfo6zbAXJ5VUtHBlHDl8TTbbSEi7Xo3jNF1uKrcgEdE+nlqAGU9t8kmL
         zwQAAWRavcrr2DZb7dfKOaJwVOUvUf6de3Apkbwmhsi3YzSAtToufM+l3vq9zCFZREoU
         k0GFMc41EQ/SmkgX810Ifck96p3MRBz911n/eMlS0vjShxUYnrsORMSNNFy6RFC9mpW8
         CetqZ0RGK5znVIewF1udpxfvcClssX05T+oTbBvv4RlpqvvY/9pr52Z5VYmuylryiree
         oiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790429947; x=1791034747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryy0TaceLombIiL4TAr0+o046iePkO13SoMlmGHBezM=;
        b=cSPdIBwZ9LDxLBbzr38zr1lRGdWtzIgVitnLSpiHo9NE2EVuvy91aVDuzrliZWlCp5
         TTQpmvnumEXkXz4zuY0kyvIygsajZeVBfwlonNJHQvHypWue4C7+YWMUOfZFo5VGHpkA
         fEQWKoS0m9Fx9XeL8H7+YE3mYDSzw39+UEwW1nzZJWk2T10tyCsxq3OswKtYmNv0+Mw0
         v6Rxur42Tpjj9+gcv9rH8m28FIfLcL8I0nCrqs/0snkmGfmfV5BeicQ82bbqb47VDkKx
         ge4w4aAGVbUt1QPWLHsdtOojQuDyVjKUwhWjH9/+S9LzIoqDEcwqECB+NFs5S037Hv+q
         be4Q==
X-Gm-Message-State: AFq9FYJ74YkekRsI70XYOcgvIjVtepxRHEf5J7iy5g2W8QtYUXz2ZbOu
	X6GFpLx7lnArySOr+xoJychrQZ+dCb/H5iVSPJ6BXTXBJFW/KAxVINGfar2f+cp2OJb/EAXPS9F
	5nN6UXFwnqH0KemR8PFif047VujhBTNSA8KaqL552bElZhVV2abMr50g=
X-Gm-Gg: AYBFou0YLwMMhGVB5WalGMMNBK8G2kwBCJZptgdpss/3koUSkCfiYTQPcPGtDx0FoE2
	/FCrIhKshBPD/mEIZHLybkkHajiy8vRJ9EO8UJprGePn86Ny4koU0tZTOEy3ZQscXRMu4cDLtM5
	fUzU+miNZKv05fsX8CjjJ59y0Ir7qYnTPa2xsJ9T5VGzh8WQmKWUVY/s3aQFuSR/J6TMqy8Ie0D
	cJOk86lElzAioPyNGA9w5KRzE3AcxDGyJoVTiLBmcIKwu+AjL3N9ZeGhRF5SjJdIF90pycRvSP2
	vmzoJFdBrJi+86jey3WiNBKf8eTwQPwpYQiZE1iGtrvJR4NOo53Aevnx6a6RO1bE2jA1yZG9XqS
	u6dcw4rQk5Z35mCvLdEd3Xf/dVJZ7JgSVh7E=
X-Received: by 2002:a05:7300:3b28:b0:328:2ea5:bd39 with SMTP id 5a478bee46e88-342705b94bcmr4840007eec.4.1790429947081;
        Sat, 26 Sep 2026 06:39:07 -0700 (PDT)
X-Received: by 2002:a05:7300:3b28:b0:328:2ea5:bd39 with SMTP id 5a478bee46e88-342705b94bcmr4839926eec.4.1790429945792;
        Sat, 26 Sep 2026 06:39:05 -0700 (PDT)
Received: from [192.168.68.104] ([49.207.195.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141a4a00dsm15522844eec.1.2026.09.26.06.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 06:39:05 -0700 (PDT)
Message-ID: <23f281ef-d724-4fdb-aa1d-408c368d941c@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 19:08:38 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 3/7] firmware: arm_rmm: Configure the RMM with the
 host's page size
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com, trilok.soni@oss.qualcomm.com
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
 <20260924135201.850038-4-suzuki.poulose@arm.com>
 <20260924100313.00003be7@oss.qualcomm.com>
 <d4b768e5-c942-43cf-aea2-c266a8bab353@oss.qualcomm.com>
 <bb4a6fa1-721c-44f8-a8d2-54e80b5449c6@arm.com>
Content-Language: en-US
From: Venkata Rao Kakani <venkata.kakani@oss.qualcomm.com>
In-Reply-To: <bb4a6fa1-721c-44f8-a8d2-54e80b5449c6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA1NCBTYWx0ZWRfXzvF+1cTX4pGL
 MoSkgKzzElUbfGbTqMvAjaiT9z0RE8hsdkMNyGuMnJeq2lnx9VSeQh8IYUzwoE7f+Oq1mhkos6p
 CJ/SZmY4HuBuIg/IxIRICRSPc956Wxo=
X-Authority-Analysis: v=2.4 cv=d8FgWhjE c=1 sm=1 tr=0 ts=6ab7cafb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=lfboiZ0IWGQn+/ls2+s3/g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=VEZfdOmQvSGR4K_WtDcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: g6khdJii32j8bNGfGceG_dcbjC5ofKiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA1NCBTYWx0ZWRfX02dYm9nzJmgu
 16EF1LRH7Y0+5ug9CHRxBp1YdQMP0SbNqZIU9eh6O5JeEkyDMO9I0Kd02Vl0cuoRDtSuPnRch+/
 O7qnUSFGDa+RDUdckD2vGh1WkLlwl9DsNZAJPEnMjmyLyXmnJep7ZsNpK+dzx+4MHwmkQ9Kdill
 Qfloq3xEv9FHQhpd8Nu6ID+nj7+SpTFGpEJWLHnDn2ktSoNugl6xRrsjRjdoBQ0PN84uCmNinE4
 nYbT9+PJsvfnGuSx+xW+w52tPoHM5iOZrt/X0O6HIj/ZKIgGlh++LJTgxCFYsVj+03GXdTgq2Om
 eRh5Q0i5HEmsJTTzLlW0yiYQD1cz/43Z8M6xnGgRxUv90MAHdqNcgKYlplT7GqsdyhVnex795Gi
 lP4hxPhyAf+T3bFokZCEGmrVLMnSzQvKGXFYyUOPs3CYpK+OUgR9cG8jrfeMoJ9d8HQp+/dEGYB
 9iWNCLSQf0QNGXQz0sw==
X-Proofpoint-ORIG-GUID: g6khdJii32j8bNGfGceG_dcbjC5ofKiE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260054


On 25-09-2026 08:26 pm, Suzuki K Poulose wrote:
> On 25/09/2026 14:23, Venkata Rao Kakani wrote:
>> Hi Suzuki,
>>
>
> Hi Venkat,
>
>> Now, with this patch Host can set RMM Granule size equal to 
>> PAGE_SIZE. Does RMM send the request to root to set GPT physical 
>> granule size = PAGE_SIZE?
>
> I don't think FIRME lets you do that and it would be too complex. Please
> remember that the GPT is not just for the Non-secure/Realm world, but
> also for the Secure world.
> So, the Physical Granule size would be statically configured to 4KB on a
> platform unless it supports the 4KB granule size, to support all
> possible Sofware components.
>
>
>>
>> In a scenario where, GPT granule size (|GPCCR_EL3|) set to 64K and 
>> Host PAGE_SIZE set to 4K, how does root handle GPT granule mappings, 
>> when Host send RMI_GRANULE_DELEGATE(PAGE_SIZE)?
>
> If GPCCR_EL3 is set to 64K, RMM must not report it supports 4K GRANULE
> size.
>
> nit: Please avoid top posting your comments and use plain text for
> discussions on the list.
>
> Suzuki
>
>
>
>
>>
>>
>> -- Venkat
>>
>> On 24-09-2026 10:33 pm, Jonathan Cameron wrote:
>>> On Thu, 24 Sep 2026 14:51:57 +0100
>>> Suzuki K Poulose<suzuki.poulose@arm.com> wrote:
>>>
>>>> RMM v2.0 brings the ability to set the RMM's granule size. Check the
>>>> feature registers and configure the RMM so that it matches the host's
>>>> page size. This means that operations can be done with a granularity
>>>> equal to PAGE_SIZE.
>>>>
>>>> Signed-off-by: Steven Price<steven.price@arm.com>
>>>> Signed-off-by: Suzuki K Poulose<suzuki.poulose@arm.com>
>>> Hi Suzuki,
>>>
>>> Some trivial stuff inline.  Assuming that is addressed.
>>>
>>> Reviewed-by: Jonathan Cameron<jonathan.cameron@oss.qualcomm.com>
>>>
>>>> ---
>>>>   drivers/firmware/arm_rmm/rmi.c | 70 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/drivers/firmware/arm_rmm/rmi.c 
>>>> b/drivers/firmware/arm_rmm/rmi.c
>>>> index 3baba931f92e4..c9ea964fd9081 100644
>>>> --- a/drivers/firmware/arm_rmm/rmi.c
>>>> +++ b/drivers/firmware/arm_rmm/rmi.c
>>>> +
>>>> +static int rmi_configure(void)
>>>> +{
>>>> +    unsigned long granule_feature;
>>>> +    unsigned long granule_size;
>>>> +    int ret = 0;
>>> Value not used.  Fine if it is future churn reduction, but I didn't 
>>> spot
>>> where if so. I'm guessing left over from refactoring
>>>
>>>> +
>>>> +    switch (PAGE_SIZE) {
>>>> +    case SZ_4K:
>>>> +        granule_size = RMI_GRANULE_SIZE_4KB;
>>>> +        granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_4KB;
>>>> +        break;
>>>> +    case SZ_16K:
>>>> +        granule_size = RMI_GRANULE_SIZE_16KB;
>>>> +        granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_16KB;
>>>> +        break;
>>>> +    case SZ_64K:
>>>> +        granule_size = RMI_GRANULE_SIZE_64KB;
>>>> +        granule_feature = RMI_FEATURE_REGISTER_1_RMI_GRAN_SZ_64KB;
>>>> +        break;
>>>> +    default:
>>>> +        BUILD_BUG();
>>>> +    }
>>>> +
>>>> +    if (!(rmi_feat_reg(1) & granule_feature)) {
>>>> +        pr_err("RMM does not support %luKB granules\n",
>>>> +               PAGE_SIZE >> 10);
>>>> +        return -ENXIO;
>>>> +    }
>>>> +
>>>> +    struct rmm_config *config __free(free_page) =
>>>> +        (struct rmm_config *)get_zeroed_page(GFP_KERNEL);
>>>> +
>>>> +    if (!config) {
>>>> +        pr_err("Unable to allocate memory for RMM config\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    config->rmi_granule_size = granule_size;
>>>> +
>>>> +    /*
>>>> +     * For now we set the tracking_region_size to 0 which is the 
>>>> only option
>>>> +     * for 4KB PAGE_SIZE (1GB for 4KB PAGE_SIZE, 32MB/512MB for 
>>>> 16KB/64KB).
>>>> +     * TODO: Support other tracking sizes via Kconfig option for 
>>>> other
>>>> +     * PAGE_SIZES
>>>> +     */
>>>> +    config->tracking_region_size = 0;
>>>> +
>>>> +    ret = rmi_rmm_config_set(virt_to_phys(config));
>>>> +    if (ret) {
>>>> +        pr_err("RMM config set failed (%d)\n", ret);
>>>> +        ret = -EINVAL;
>>>         return -EINVAL;
>>>
>>>> +    }
>>>> +
>>>> +    return ret;
>>>     return 0;
>>>
>>> So obvious this is the good path without anyone having to think 
>>> about it!
>>>
>>> I did quick check on whether this was to reduce churn due to later 
>>> changes
>>> but couldn't immediately spot anything
>>>
>>>
>>>> +}
>
Understood. Thanks Suzuki.
