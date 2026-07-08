Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D81F03DE
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487670; cv=none; b=L6XTjleahrA/PS2G65M6bTmc2ICW6YGHENYzszIYioXvFPm5Qm/uc4IWqgACy5zyzfsgozl9C4hoWY5jK63ZmMAU8vaeaqPSYH2hah/jTv+OwSP+Aa+gzCmyR1E3b8foaMQYqzGWuiTDvRPiu0Nhsbh89bVFN8r9fxfH84xF4iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487670; c=relaxed/simple;
	bh=gO1njp5ye2jnvKGN4PxcMfeuhIlX3n9gHvQCGTXV8mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGVWo/KsSPRtYr/sY9+a+Q1yvx/tPHHgGgPkfHbn0wHcGperQb4UejG2SH2H93MTSMAaDJBW6zIPtFQ0hUp2v0lK8HRc+x4PFWxhCzKIe2KRUE8dwVnaDLpyMovgLYm2VHaYz3GwjoTlYCSoXI45gE6ZHxttz8kioIKzLBhwbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JntHqjhn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VW/8FUQB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JntHqjhn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VW/8FUQB"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842lxS1645120
	for <kvm@vger.kernel.org>; Wed, 8 Jul 2026 05:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=; b=JntHqjhnocNUi16o
	oTyrpJoMakfOX7/Hh0gYKmi6e8PrO6/L0iwG/8nzHxlSWAsaulWqYh+R0/svFbvO
	tA+CJr8yN4z0yRnN9SK4XZs6hZKTiGEr5xkWR4i2u+2Y8wtVf715gAfQ99Y4xGiM
	1ZMqMQ68WMAVmV0bY9wP0PPAqrDUrtJcFY2ZMZNzuYQhh89skIhjNpwHxOgJ+dSJ
	UN85/MghcOmCYuuQqgNraNqFIDl35sP8ZsWs8MUuvS64wRRIczN58PSwbtlxnmyw
	j2Ah+jrbe5Tsp7Lda2U4dn36QB/cxrAz1isLLp/K3+ACEW9uvNKfHdFEud+6BmQ3
	/0L3Xg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0m8g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 05:14:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c33f48ee4so3112421cf.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 22:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783487667; x=1784092467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=;
        b=VW/8FUQBoWedPYiVCeV/9HdtkmA5iudKNsoGcwYVAayox9vn8q5M2oDGVAlEo9VwmB
         o9VRsutluEs8ypDoWPvUv/SmqBEfwAdadxi6T5jHDG6e9Btgf2dKkbUEzYpnc2jW6A8q
         y+w9dbCsh1Ah8OCgDObl0gsqHwdhPAOp40IEbtZ0B6/C6W+tQ9YvVhrbU9JRJ6/W4+oq
         BAXocEIWj8mVqx67zEGnjkJ4Z2/sR/ehurvJwMnnoyTCfkIQjoWKwX5jCSF/eiz8dSJY
         qfcCKaOFicCKxNx6Rt0gHef8EROrYpWsoAfHKlktK1NDiXhREwkMd+lw3fWuCPXVcU6v
         ByLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783487667; x=1784092467;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5w/YIhHfcHwt8m85sXZA9WE7xPsjBhvL2VklZJk6Yg=;
        b=ILPoNTfaBAC+jcqpk4hkbTPeVYRRQ2Ko1mpaYTqikUxiud1/lyJhqIbcrtgID1UcNy
         vY0dyFPMH7Wn/7qEnQxI/8v3flPgBZUz62c0UddBXxLOJZgoPeyYPIC1ae01dcQ5ie/v
         EIGzr1OMMX9IkRPVR4TLgawQa5KIVeA9YGkkv/e5Z2Pw61aVquWXog+y+dpDohhNAGiI
         BljOGGEr6ypcsaVLSxtV9ll59BhUw2xGRdd+HYLM9V+iTduUMHfkhcd/JBxcPrdYfBQ+
         7dBgLl4XPoQQXtKk355MSIRs1Ul0rH4kIq3Xv1fWg0GDYvC5T1F/Wzjb5wcNT7zCypWy
         uwOw==
X-Forwarded-Encrypted: i=1; AHgh+RrHeibi+NW0v4RI+Tvdfj2/MtJ9wn1FKuxP+O5zNTxFYaxOZ+1vePBl0m2D6cdvvcrd0iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9Ihtv5NdWUfuc35Rbk3/aEa2f4ja5IUHIK3jQaDtBbzxNxj6
	k92B4G299VoyjN8MwU+VoVaS9SwFa4f/r2uLT+RGNPjLL1knxowGYQxfViuRanqKvkpla37bpj+
	LFlJHFy/DzUIwAkngmS2DvT1AWSQN17mnQ9oMZjS8kYa2nCmy/g16xRA=
X-Gm-Gg: AfdE7clN3cuSv7Da2rsZVjiovWj+mEdk3Ojs1j4m+cUT9haNUCQGsryLmgPBDNZB40w
	lMQdwVN/Z5eemQPdCc7ZSOzqC+Ia8LOE+YFoS8mK0pVtCL5hjHqO6lLVfp3lCw6Ihz1WY7dpEp8
	7bWBisSXiYdVo2wMor8COxeXOBNxjfgeFMlHIPzcmWrrF39gZ7sxHvb9BZScUMvNtjZHPArq3Qn
	3LOfFLeOK66hg04H6p0ynwSq5zhYRacKvo+1TSrW8yohRZjJ0Clx64TjCf5P9SZSlMhYdFS1nxr
	4F1gBrCDW/z5z5kcKSgedg1AfHK4VVBnnmPMtSt7LwR2bw2IsMO2ejAIEpIKaGDfSLwDJ1jlkzr
	spR3MMi73K5Ity2bjoKy3lGqrJpzQwPGPFx3v4JoOpZez0rgPYQ8CRlA9Mc8ZRA==
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id d75a77b69052e-51c8b4307cbmr10548261cf.21.1783487667104;
        Tue, 07 Jul 2026 22:14:27 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:51c:14b1:8e1f with SMTP id d75a77b69052e-51c8b4307cbmr10547911cf.21.1783487666654;
        Tue, 07 Jul 2026 22:14:26 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e549e56asm32807885e9.0.2026.07.07.22.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 22:14:25 -0700 (PDT)
Message-ID: <3cb18f9f-37d2-4e13-9333-65e5a65677db@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:14:24 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 20/25] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
        kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
        peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
        jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-21-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-21-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YqEvrnD4ygNBpoV5MskEwhW30DwTUUPP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX9nhAZeYzJvFW
 062rg+EKdI25DXAp7WfQGD1o0fJCS1NoW3tK7J6SNqUONwSPfzFcZfqtIz1dk0bxrximXE6yI+i
 HrjE0jpOO9dl0mZtl4RcjFFMggw1tuk=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4ddcb4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YqEvrnD4ygNBpoV5MskEwhW30DwTUUPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfX68BwfwxxsKW/
 s3rhm1Mste/CKH5XOUqdZxr3YxvUBd1jGadxxiGrJ1Yu5P0wj0wMqryOegvxgO2q0hj1wJ+bv7L
 0mHMs95IbmCOp8F9lYYsYye4rmQpBig5PsSEcvfkWh+YuX0+yqX/vOPTq1P6YKOkXcpbVBhI1JO
 ubVxshXFeRr4dZ7dbHCgTA06BLOUJ6am+PIb48hvu4Z0HF4HhKV1496rY4am3odrMgKEYVBCnCX
 Xi/67Isr1LQzPtZ9NHSIY8ZNdVXOOFqu05KsEpPDINPHUlZL8GFMZEv0IsBrSgK6Xi7z+xm9rJ+
 EtoR83hsr7NpU/DpxwaQw1mwVMGwE1X8WuHqTrxE/IOTKKMODBseB2mc8cxhjuAMl+vKNhYPBU9
 9qKaGTYnTMxy98tAeoxzRnvzqofa+zpmZI+SQvMYWYUybs+s66RtdHKVtz0V7ZddccmB1W0xqPy
 HF8mr5Xi2xCMON1VfdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080047

On 8/7/26 00:43, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> For confidential VMs we'll want to skip flash device creation.
> Unfortunately, in virt_instance_init() the machine->cgs member has not
> yet been initialized, so we cannot check whether confidential guest is
> enabled. Move virt_flash_create() to machvirt_init(), where we can
> access the machine->cgs member.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
