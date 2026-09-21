Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC695013C3
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026450; cv=none; b=b8i6flKNtoGyxEa3uI1SdkBJqWiqkiY/HQPrjFDAqF3Gl22/wUmK6vCOMeUiepLlmkNAsFENGIl7+hiE9P7jv5LVstRXf2G4WGNnx3oq7ZgTkGMhArfmOB+6uD8qtIaqeeQvWSRKE+9gnweo3VzjH7geptPc5DWj4JM2w8/wxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026450; c=relaxed/simple;
	bh=R1peGfGCRuDkyOnmHdifYGmM605I2Y0NPAuHhiZzP+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyEHs/bGHK4Ffvh/iB2L2Suck1op1be8h8odK4A6g44KMkMDTYSUa8a3gRdsZMMOIS7i/XaytTkQujB2kWOV/cxN17aYR2XExtYL+yIZ1QdO7txAOc7VHqeSWn3OiSLSqEpGSvwHphWo1hcbZELy/urPk3pymJE2k7aEM9LEiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIzBAr5/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NiVASZsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIzBAr5/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NiVASZsZ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LKeEOK3260472
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z80fGZcv6BPIL4REfzCrI6RcJShWmT49WjhJXMKxxOU=; b=bIzBAr5/YZDrBmax
	l1lrKwqt/AXF2k3S8USImZugoEgOGjaM7BeHLt/wgHvoz7eSgHPGcmF/GnQ7hKWw
	AVXxXIpaoMMm7xQex8VmfUTelZ8DLkpTOYg07K1uuNJziWJ5/B850e9jvzpkX9M2
	pwTdNHrRtkT9vJ2oGhKQdHlAxZe9b1cEb1kjnGj1JfQ5Yum1e018V7QG3SzMurdZ
	qYBpZL7EjftEzedXWYubyG0HHB/uHSMgmSZraBPpTFk28q2fzcvYi1lEM+EtWJJu
	jyBC0lCVWmE6/ZqI2+sGqlJRoDpTc9G/FJJoJO3kliDc8dcpTXxBoBtNX0fRuwuM
	x0giwg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vh5m2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:34:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so3973486a91.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790026446; x=1790631246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=z80fGZcv6BPIL4REfzCrI6RcJShWmT49WjhJXMKxxOU=;
        b=NiVASZsZqp5mxtmd62Co2IMNqC1MtQy0QCqhibiKhRSmKuTWVRkIh0yjYlifqDWUOB
         ik4u0Q2oSiNHEloNHVOD4S2v6KBJ3yghWaOGVpCmWkUj2gZGzmAqmFe6riTP1f56e8WD
         19veansBq8zQSbwJ/kJ+vPYZmdIUoxRfwWf7iBSGyqrIseqB6svEf/wJ9aiF5cGV5I8t
         mN9ArRbmAsKXpjTg7RLI79QXfVMArholYDIzssENBxY9f06j9uI1/E5f6e3s08ijoRkr
         rTpT2DaIKk1vMXVefAyE158B32x/jQ4Ge5QLLNCXcMqhefI90DpTqXp/e8aGGG87urRl
         h2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026446; x=1790631246;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z80fGZcv6BPIL4REfzCrI6RcJShWmT49WjhJXMKxxOU=;
        b=cXTyVcn5v1WwhwrpOPilsqGUDyDh27Xe1QHP7hxMPeYBAXLV5fDSP7tEwMsmJcg8kD
         fapHK5RH3NSpaKYemMgiQqf7rbh+IDlJVsMGY/qiZUCHRu5OqN0nZFX5UykLnh6paW84
         7raMeyfjbAlSzLOIVssdo+fryKQryg8HwTo3ZPiXV1jsqQ5Yig5Xr5FlahWJwMTILjdx
         p+k0Uw7fAfZcWxNrsNa2yigpGa4r+7SAExNF4yXCz+b7UIRHa1ujgzaWYi/8cCIjLJmZ
         QLzTDiiKElwCUiY+qkQKXVwd+g8KdiJZ2L+xbAXbe4RfLWmYejNDH51eGvZ8l1HZ/uv1
         p2pQ==
X-Gm-Message-State: AFuF++kO7gnGuYRf8Xv1sshEpp4/Pl4PThQAO1pq3IO/BsiTrrA7+5dq
	zLKRJVxzoda7PdxB6ZZCVsPGZI1U/YPcVpJ64WcRanNksAu372K7hQmaAPLzlvlqzdbGwfS+KQ9
	cZBrDUprTatr6izzD/iDzkw2PZXDBiCL4wH/FCe9MjxsKFksD84LOKVI=
X-Gm-Gg: AYBFou3x29aMr7BHsJmuirCFIsAopcQd5jVQCDcwhBenYQt9wvkrMrh8IfvASfXDKHa
	maKK9Knq/R4WprTg1fgqETuHxteCP7tjL9qoisHgCh513w+2LopCOSg5+mKD5VtioYG8oWqcBGs
	ASSHSw5ZerC0+ySWj9oyXsNNo2xuHSvU1hamZekX6nmSNgI8avSPToNORRZ/SEnGLIDl+TJzmVz
	H7BcAes1z2dVg/d0XqF/MaBtDCOYHRkKL/IDpEJ06qWWeCs2ExMt+75ieJfizpqopYHcM4+2G2d
	Umc6cl2ccYF18497ixakL/gP7HKlFQTgiird19axHVnUpMtTm/20f2kSLMLfR9A/UzQgL/oLWQ6
	JKEvnXsdPSDbZweWgcuArLv7r1w==
X-Received: by 2002:a17:90b:5187:b0:39e:6c6a:2095 with SMTP id 98e67ed59e1d1-39e6c6a22ecmr10542569a91.54.1790026445920;
        Mon, 21 Sep 2026 14:34:05 -0700 (PDT)
X-Received: by 2002:a17:90b:5187:b0:39e:6c6a:2095 with SMTP id 98e67ed59e1d1-39e6c6a22ecmr10542536a91.54.1790026445395;
        Mon, 21 Sep 2026 14:34:05 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02625615dsm5648638a91.2.2026.09.21.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:34:04 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:33:52 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v18 1/7] firmware: arm_rmm: Add SMC definitions for
 calling the RMM
Message-ID: <20260921143352.0000014a@oss.qualcomm.com>
In-Reply-To: <d7ccaf22-5bde-4344-8bf0-a5a17dcac0f3@arm.com>
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
	<20260912083611.2513845-2-suzuki.poulose@arm.com>
	<178978126540.2352296.16845657485139032765.b4-review@b4>
	<d7ccaf22-5bde-4344-8bf0-a5a17dcac0f3@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMxNSBTYWx0ZWRfXwggZyprH/xdI
 RlqYgyrqYRa+IEgNTwLoL5ohCP0CpAR0MKb26lj3C+bc4w6DZ+hvQf+vSs1Cj32R9ZLv6mo92iP
 4BlnsDUoaLtANaNF8G96TFA6GLoavNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMxNSBTYWx0ZWRfX7C3SaeTDVBTO
 MN+Niaa3exyq2NznpdXyix+qs6pWT+77uvBw/4FfsSAG3mcQo2m2V/DGavReju93fqZCfmbjnrn
 CpbaI4nHwgOjPpYzF/Z66f3zdV1LD4gguSeIaQ1Q8rfW4hNPIXWxK3AZyLGUGRMM22kyQ/DoUBg
 cbhjlA/DMH4fOP2JfH0pBeyFENeUEGg3ve2AkYJuDcJVvXMOZEozqTmrkRu09ojFrXi4miRKVVI
 Nsv0lHI6Xegn/oR+uGHW8F6VFRdkDpwjxy4UMeD749tkSrPdZ4NNYi+Ooj6BMjbXdpsgxgutCfp
 CxILlddL9EDBDcNTK2Cmw/59Prit6VBELRw6sed30lTXb8tmYnTRl3JT1zZTxPcDiAAPYT1Te29
 TgpYMsQ2RpTsFr2B2ZRgRlK882UrYqwFKIm3exduhr4GVRSHUBCvcJXXhGwtg60ITZxvU9JPUiy
 NdIhgjq5G8YJEWNG75A==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab1a2ce cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7CQSdrXTAAAA:8 a=PlCZfVOHbWhc7nwO5CYA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: cV7QgNKW9xzKCz6yfUKu3cWwB9_4NrZ4
X-Proofpoint-GUID: cV7QgNKW9xzKCz6yfUKu3cWwB9_4NrZ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210315

On Mon, 21 Sep 2026 10:27:46 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 19/09/2026 02:27, Jonathan Cameron wrote:
> >> The RMM (Realm Management Monitor) provides functionality that can be
> >> accessed by SMC calls from the host.
> >>
> >> The SMC definitions are based on DEN0137[1] version 2.0-bet3
> >>
> >> [1] https://developer.arm.com/documentation/den0137/2-0bet3/
> >>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>  
> > 
> > With Gavin's nitpicks and the GENMASK_ULL() from sashiko, just a few
> > comments inline.  Mostly on subtle inconsistencies that really don't
> > matter that much.
> >   
> >>   include/linux/arm-smccc-rmi.h | 497 ++++++++++++++++++++++++++++++++++
> >>   1 file changed, 497 insertions(+)
> >>   create mode 100644 include/linux/arm-smccc-rmi.h
> >>
> >> diff --git a/include/linux/arm-smccc-rmi.h b/include/linux/arm-smccc-rmi.h
> >> new file mode 100644
> >> index 000000000000..214d6228dfc2
> >> --- /dev/null
> >> +++ b/include/linux/arm-smccc-rmi.h
> >> @@ -0,0 +1,497 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2023-2026 ARM Ltd.
> >> + *
> >> + * The values and structures in this file are from the Realm Management Monitor
> >> + * specification (DEN0137) version 2.0-bet3:
> >> + * https://developer.arm.com/documentation/den0137/2-0bet3/
> >> + */
> >> +
> >> +#ifndef __LINUX_ARM_SMCCC_RMI_H_
> >> +#define __LINUX_ARM_SMCCC_RMI_H_
> >> +
> >> +#include <linux/arm-smccc.h>
> >> +#include <linux/bitfield.h>
> >> +#include <linux/bits.h>
> >> +#include <linux/build_bug.h>
> >> +#include <linux/sizes.h>
> >> +
> >> +#include <asm/page.h>
> >> +
> >> +#define SMC_RMI_CALL(func)				\
> >> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
> >> +			   ARM_SMCCC_SMC_64,		\
> >> +			   ARM_SMCCC_OWNER_STANDARD,	\
> >> +			   (func))  
> > 
> > Obviously it is v18 so probably a future thing but nothing about this
> > is RMI specific.  Could be used for ARM_SMCCC_TRNG_RND64 for instance.
> > I'm not entirely sure what we'd call such a macro
> > 
> > ARM_SMCCC_CALL_VAL64_STD() maybe?  
> 
> ARM_SMCCC_STD_CALL64_VAL() ?
> 
> But, I would leave it as a wider cleanup in the tree as a separate
> series.

Ok.  A follow up would be fine I guess.


> >> +
> >> +#define RMI_RETURN_STATUS_MASK		GENMASK(7, 0)
> >> +#define RMI_RETURN_INDEX_MASK		GENMASK(15, 8)
> >> +#define RMI_RETURN_MEMREQ_MASK		GENMASK(9, 8)
> >> +#define RMI_RETURN_CAN_CANCEL_MASK	BIT(10)
> >> +
> >> +#define RMI_RETURN_STATUS(ret)		FIELD_GET(RMI_RETURN_STATUS_MASK, ret)
> >> +#define RMI_RETURN_INDEX(ret)		FIELD_GET(RMI_RETURN_INDEX_MASK, ret)  
> > 
> > What's this one?  I can't find anything in the spec that matches it
> > and as far as I can tell you don't use it in this series.  
> 
> This is coming from RmiResultDataLevel. See RmiResult type.
> This was renamed after we introduce the RmiResultDataIncomplete.
> It is used in the KVM code to find the "level" where a command
> failed/walked.
> 
> I could rename it to RMI_RESULT_DATA_LEVEL() ?
> Similarly RMI_RESULT_STATUS instead of RMI_RETURN_*

Yes, that would make tracking it down easier. Thanks.

> 
> >   
> >> +#define RMI_RETURN_MEMREQ(ret)		FIELD_GET(RMI_RETURN_MEMREQ_MASK, ret)
> >> +#define RMI_RETURN_CAN_CANCEL(ret)	FIELD_GET(RMI_RETURN_CAN_CANCEL_MASK, ret)  
> 
> > These are obscure enough to find in the spec I'd give a comment just
> > to save the sanity of anyone looking for them.  
> 
> As above, they are really RMI_RESULT_DATA_INCOMPLETE_*
> 
> >   
> >> +/*
> >> + * Note many of these fields are smaller than u64 but all fields have u64
> >> + * alignment, so use u64 to ensure correct alignment.  
> > 
> > Obviously this is only going to run on arm64 so it's not critical, but
> > more generally u64s aren't always 64 bit aligned.  So if you 'really'
> > care aligned_u64 is there to ensure it.  Meh, arm64 so fine.  
> 
> Agreed, I am worried about the churn in the consumer code. Also, like
> you said, this is only for ARM64. So, I would pass it.

Ok. A tiny bit ugly but x86_32 adoption of RMM 2.0 is likely to be minimal :)


> >> +
> >> +struct rec_params {
> >> +	union { /* 0x0 */
> >> +		u64 flags;
> >> +		u8 padding0[0x100];
> >> +	};
> >> +	union { /* 0x100 */
> >> +		u64 mpidr;
> >> +		u8 padding1[0x100];
> >> +	};
> >> +	union { /* 0x200 */
> >> +		u64 pc;
> >> +		u8 padding2[0x100];
> >> +	};
> >> +	union { /* 0x300 */
> >> +		u64 gprs[REC_CREATE_NR_GPRS];
> >> +		u8 padding3[0xd00];
> >> +	};
> >> +};
> >> +
> >> +static_assert(sizeof(struct rec_params) == SZ_4K);  
> > Whilst the assert works and is need to prevent oversized the
> > dos never seem to provide any indication of the final trailing
> > padding other than indirectly and I don't like maths on Fridays ;).  
> 
> Agree it is a bit obscure, but ...
> 
> > Maybe union the inner union set with a u8 [SZ_4K]?
> >   
> 
> That doesn't help if the other one runs past SZ_4K ?

You still need the assert so I guess that is already providing
the documentation indirectly so indeed little purpose in the
extra union beyond removing need to have magic padding in the
last element.  Mind you not obvious what that last pad should be
if it wasn't just 'the rest'. So, I think this is fine as is.


Thanks,

Jonathan

