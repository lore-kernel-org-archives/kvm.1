Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD646AA88
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546180; cv=none; b=iX26Fbm39DT5lM5IRZsLwPrZpQRA+6Oa/ramYvqyU5jHN64vVzpupWQWbAN/HuC1bnj11xaZVPkIfsrTsvHtGTXWe/o97N1yd4n4VKP4IGVaqqVHYmWLwoZq8DAIQMXdl4leKYMUPSB4U37CM4j20vtTh3W2fBfHlSvcsUA/msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546180; c=relaxed/simple;
	bh=5asrc2jI9W+fjogIQv24KVzqpjr4gkEmKAxD5PlfoWs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kd+lWrZFEx6QqfS+FMkkssIQTgWqvWQC2WSIe0sEK8E28hWErUAlI26gRLcnOZHJtNaoFpwF2SPYWqeQX1GuP+NFRMjObc7JAaZRtIkn2TxMNiDetKQ5ZgGPpdFpA0dZKf6Q+D5SM3FYeokR8P7/GXz7POm7p1i3O00MEJBGl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o80EkB7C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfJQwejJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o80EkB7C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfJQwejJ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbmaN3971657
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E+b+RHoMCWxYXvezSsKUzxzNnQdAuHqXWxGDKXSBBRQ=; b=o80EkB7CWNNn9GBw
	JYJi5GYCe2x88f2PyYtW2XHX79WlYYjsHFjJBZCJivS/JbvN6m4CUTY3MKnSFGKC
	kzKjMkkkyUAWhzrHkoY8OVq6TgDsfGpH0EL5HCzh20eTdSzUc2miSpQIbhNP9vnS
	eIkLaDhsQ55bXhNrtgv2cMcMQqiomIYPzHe64n+2gctpD39kp0WKdoFApu/wafrW
	cR+Y26yd7cmevsWTkBoB+EvtPN5o7JbJwhSj3zd1q5Hz3sDZoOvGecfFwOoVtwf1
	P8/6QkZIauJLiHULPJ+be9bcRRScXvmHr/hsJbw66nd1OXY0vsaRTaluVbi84ClU
	bAUsNw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0jgrj7r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 14:49:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so1356791b3a.3
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786546169; x=1787150969; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E+b+RHoMCWxYXvezSsKUzxzNnQdAuHqXWxGDKXSBBRQ=;
        b=RfJQwejJYCosTwAaZi2XkdB2IyVnegr5yzAw97phzAEyi+MkZO/brRgR2WgzjwPjVz
         a08QQqlQl/+MwvfkjqFHe4CCLTPllhCXdcDsqOcZT5PE9Q37zkX3sweMKQpcq5+qGkE5
         HPlf+1ijfwCYcAXrcw6mNb0cF8hV650rQX63fDNHueVTeR0oWGJcxvzTkd7DQTDbWkN6
         shyMsyLGxYMZi3s/8/IQhmSgCVwJsBMgTcjRdRb2pZhR8IafAvs8PN5sXV8TCzqIK19G
         6o+hlubtVI215iNt7swFNZ1TUCxc86MJpqlQQPfxr+FVU8CH132SSZLFz9Fnf9PNImhX
         zUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546169; x=1787150969;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+b+RHoMCWxYXvezSsKUzxzNnQdAuHqXWxGDKXSBBRQ=;
        b=K1ByJiiChebw55ujlpwNyirn0eE3Ob5iDrhyPa/DPRu/iwGMdJp6rKFIXpZAiuLXAh
         gBWvRFTUQSeBza1ZTblPi9il57VT3qJcaYFUXeUpIAv9ONg1p17BNfDX1O7Y7ud4weey
         CfhdRvwZyZ5rjQt1LpQkaCYSofpPP3Q0tLumJmLCL24bVFmLFFm0ejqX2xgymsL0BiAq
         7DSRIg389YKs3/I5ALTzY0sT3iBu23b5sw3Ij3Wv7z7eNAYYclnfHofxMNPFYveVc/LU
         iYD/Qvsw5b/BAe416bbxWmTQZCOBvIilIa5g+MSs6DOQiqccIXGIAOGlJTlj2uWoV9oZ
         jdLA==
X-Forwarded-Encrypted: i=1; AHgh+RoDHoyZwWfhrx+JkzBJfpOYm2+JijIxZdgGJIDgkoX2OKmztgeoc08mnTbrsq2ze6lIwt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLzVvWlNSPOPfWXelUxoc+v1kjQ8OXu05Gwf8HoSJ4uRnuZZm
	3Fg2YZytoVVeo71r012Lhbi3oh303vbr7rLYX/0Gi2rNjeDGocJIzv5seilzYClf0W7fkJlSE53
	8qIanM8HAQyw32c2cHgq6bNozpSebmBqaAnLCvNo9sFg8GUUNfEI4Ru4=
X-Gm-Gg: AR+sD13fMExFeVth0M5hfBhkZ9mX/SnCRvrpVmRvO5ZOTXFgIRWeEp+QotNm9jp2Y1z
	yJdkYYWlavzA6t0ohYZaDgWDVeP/h13NxgU+3Q4rG2Mb29nxiGmd3rNZYYQivt1zOE+2vrxCqxm
	z3/5Jzkc5gfgURBrEyaFCYuHsmPqKtY/v/iPquv6uVOd682dZlI5YQaBPE/mOa52b0JxP5SIupK
	xZqZaoIgbZiwlghGxRzwByGyYUykottTjJ6Cau4ZVu993KYf0DoSErxBQETeV6T4q/V4Xum04Di
	sTutcaXdYFAxGSzlb+zayumigFZ7hcZ2TGVdKUZ66jkne3OFlG08ujiXC9w=
X-Received: by 2002:a05:6a21:6f14:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3cc3f874b6fmr6837685637.38.1786546168401;
        Wed, 12 Aug 2026 07:49:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f14:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3cc3f874b6fmr6837613637.38.1786546167935;
        Wed, 12 Aug 2026 07:49:27 -0700 (PDT)
Received: from localhost ([2a12:a305:4::40fb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d16673sm834155a12.16.2026.08.12.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:49:27 -0700 (PDT)
Date: Wed, 12 Aug 2026 10:49:24 -0400
Message-ID: <78f9d28f841a9b7cc251675ed01a3864.guodong.xu@oss.qualcomm.com>
From: Guodong Xu <guodong.xu@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, kvm@vger.kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject:
 Re: [PATCH v5 09/17] dt-bindings: riscv: Add Zic64b extension description
In-Reply-To: <20260701134251.360BE1F000E9@smtp.kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-9-2c61f94a695a@gmail.com>
 <20260701134251.360BE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMCBTYWx0ZWRfX/gwOZXMmeUzO
 F1nd91EYhsWALAV27WpEAxyZzJmAz11ZqGDve3qIPw4TMNAReCR9l4+ngK4tjJr639OoxSG278L
 8aXAJGCloScEVG2bozUGaEg7rQdD7vGQVMut/ki6bEpapjB9yxEXWgzoZrzzkJLn5hI49fpy5M6
 Cquhl4F/37QOHwga2PU42O5Y3B9mLq/fK/YoUOtHcyRE4Lh32mrQaNErX5THTB9bU2z5ZteARrX
 iDkNq+Dxfr+DyyHXbZKKRgsMzxbVuR6U5jM4Eu3TGtJU2jJQK9u64ThAyJVeQlNcm1xCQv3c+dr
 CM0Xgu41CnrIFqlY28e1klvohuDSKLeFJBzxn9JYPvKy2RddfpTvqTzbC2L+1gcpWazVLCKFT7i
 Zgnx3xzgufsLQrbj5gCC8NSk8t4op0/uBusNWQpMy3VbCpqbT2smw+v6QXS0d0kEid1WqV+IkNQ
 UDGjOIbW1Xjf4jL0Vkg==
X-Proofpoint-ORIG-GUID: cGV5p3UcZhSpNC3oP6xnvnhsNNzUbD0-
X-Authority-Analysis: v=2.4 cv=TNJ1jVla c=1 sm=1 tr=0 ts=6a7c87f9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=8JhW5hTOqIiRgY4thoIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: cGV5p3UcZhSpNC3oP6xnvnhsNNzUbD0-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMCBTYWx0ZWRfX3eo35IWApZkH
 puCM94mO/6D2GLks1OTupdvcp8CyiRR/4tYgh/Z8gUS6AknQtR8P2+a1UnrMhCdCprtAswuSPFC
 7Jq3hA0+z5JVoxadfTfwV35tNSaueBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120120

On Wed, 01 Jul 2026 13:42:50 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete schema validation for Zic64b cache block sizes. The schema correctly constrains the CMO-specific block sizes (riscv,cbom-block-size, etc.) to 64 bytes when the zic64b extension is present, but fails to constrain the standard CPU cache block size properties (d-cache-block-size, d-cache-line-size, i-cache-block-size, i-cache-line-size).
> --
>
> commit 31237d196ec63ec596da17f48f8410b2eee95c15
> Author: Guodong Xu <docular.xu@gmail.com>
>
> dt-bindings: riscv: Add Zic64b extension description
>
> Zic64b mandates that cache blocks are 64 bytes in size and naturally
> aligned in the address space. It is a mandatory extension of both the
> RVA22 (U64/S64) and RVA23 (U64/S64) profiles, ratified with RISC-V
> Profiles Version 1.0.
>
> Document it so it can be described in the riscv,isa-extensions property,
> alongside the related Zicbom/Zicbop/Zicboz cache-block extensions. Since
> Zic64b fixes the cache block size at 64 bytes, also add a schema check
> requiring any present cbom/cbop/cboz block size to be 64.
>
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > index f4dd34d446c02..bbd442cfbd904 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>
> [ ... ]
>
> > @@ -1142,6 +1148,20 @@ allOf:
> >            not:
> >              contains:
> >                const: zilsd
> > +  # Zic64b mandates 64-byte naturally aligned cache blocks
> > +  - if:
> > +      properties:
> > +        riscv,isa-extensions:
> > +          contains:
> > +            const: zic64b
> > +    then:
> > +      properties:
> > +        riscv,cbom-block-size:
> > +          const: 64
> > +        riscv,cbop-block-size:
> > +          const: 64
> > +        riscv,cboz-block-size:
> > +          const: 64
>
> [Severity: Medium]
> Should the standard CPU cache properties like d-cache-block-size,
> d-cache-line-size, i-cache-block-size, and i-cache-line-size also be
> constrained to 64 here?

No. Not constrained on purpose. Zic64b's mandate is the cache block size
the CMO instructions (cbom/cbop/cboz) operate on, which is exactly what
the riscv,cbom/cbop/cboz-block-size properties describe.

The d/i-cache-block-size and d/i-cache-line-size properties describe the
implementation's cache geometry, which Zic64b does not fix: the
profile v1.0 [1] spec's note under Zic64b explicitly permits
implementations to use longer physical cache blocks (with 64-byte
sub-blocks) or shorter ones (sequencing operations across the blocks
comprising a 64-byte block). Constraining the cache geometry properties
to 64 here would reject those conforming designs.

[1]: 6.1.2. RVA22U64 Mandatory Extensions, RISC-V Profiles Version 1.0,
     April 2, 2023

Guodong
