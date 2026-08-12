Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C93477E3A
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546851; cv=none; b=umZgSHbPCjwgTZmaKfNvLJL+iHirR4+Uh/L4mN3qpy6gJATkej967WXnyWgJ1mj/e81mWPBSkZG0E8dTHddnYMcG2Ebm8ipK1LxKpMazpkHDSKiP1MUZrhBKGr8/ND6v9q9AJUQDmDlhjiwj1hQ77pdTaH60e74FBTy6uijsp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546851; c=relaxed/simple;
	bh=xgk+CgH4afMyfq2ZdDJqEF70UaBNYpLnTTP54DjqXXc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOUYlQXdjaqF+fV5OsEOu4ybSa6R4gfv9EkV9T9YZmjZ/JXNwvzHutJMqvsS/C7yhcj+nHVtSdfrOOwLhAI+OwBCNIcxvigjM7p6EdHf0NCo9FW6AWfkVx3za34cu8ugKOPX+0f7Ddw70sjaN1Z3cZ8ktXnLujQF9A8dmqz8z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okNRH7eb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PgR0F1Co; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okNRH7eb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PgR0F1Co"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDcs0j3654849
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q3UDxR7hJxn5EMNRFope/geP9prYSEawi+pNDGzEyCI=; b=okNRH7ebFYBRXZLD
	loYrwvsUBmcRXI/bRlA/UPyZakEV1GuEoQeVbULhxEel2O3KQ7dA0PCHE2pB4qb8
	IQzLXBHTRHsFPaB3Y71nwv1wHo9Mr6ReiUz+uMAbqDg4VlZZxlcPSIGWPVfmlZlr
	9hmFVh+b2orqrGXcHOUXH8El1cVZXD4gqxI11YBRuRp1FPrJKo+GDNO/sMQHAZlt
	n3vwfAysJvcuEsE4Y3O69alI2UwyzV0+3cPWFvTf+riq1PHDK4x5pF5DNxBC2Hce
	L1NeAbpsvb00SG7NBkNIzIHgyDMYfr/36wyAp8lRCD689mmSxXbz5Euv+jE4BvY8
	evDdOQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmys7g8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 15:00:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1256474b3a.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786546838; x=1787151638; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q3UDxR7hJxn5EMNRFope/geP9prYSEawi+pNDGzEyCI=;
        b=PgR0F1CoHpK9RHAktyspEhoRAmAXBGHzSDF60NtjTrV0fydVstXgY3/LoJfAWXfmSi
         ScM2Z8fPhmdmm8swP3D+lz42N+pLMHW9onJA4AZJ+sXsAdCxAP2Es1g2OE0FipP98BuD
         sgGy830V0X6xTUCN7zItzGsW/pAV5e0yeaF27KW7PxBKoTeN+EzLTw2nBp8z+kSwSu52
         b3nd8WejaOKQJhG1vz+Zo9KqAg6ZO5Iv1dodFEmJXgNbWWCKs0NJZ3CnBvgJXJfTZSIg
         lgRzjrKNbCmVF/2jHF07xeXryDFYmAyWVX5gYuE0XbUjGmW+EgzxrGqMXpF4kVLk89Pg
         NPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546838; x=1787151638;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q3UDxR7hJxn5EMNRFope/geP9prYSEawi+pNDGzEyCI=;
        b=qFvooguWdAraCoT4aaspa2OzgYD65G9ythRod8CrEPzMqdurdXmWKOCjuOCxoSBXqR
         THQEiMLnMp8w18O89lFhSyWqIZmRBUeFi2Fq8AAsnxMxn29dXlSt1cv+jU/l1vYwEBtC
         a+dISd7pz9P2SYaT+5qx6LKS+Ic4seNZonMoxUdzzqXAE3QGBGhJREGepomPaYf6E/tq
         91nNhqujALNFeQUG3EhoP/VtOxQDOc/3cWVykpuVF2vA4XJ03S02uLktNwbR6Uei7idD
         sktykyX/rmCEixcAiGwXQnazu37HtXL3sYGCHCehUMPnoVL6MPxnSFDVuPiCb2oAsrCj
         oMdA==
X-Forwarded-Encrypted: i=1; AHgh+RpP+BX93IpcJmo6A41s6+z2oPxcyDcdklFEGhjXTzbbNtvYlih6/+sNEvSB3LP6E6GL/Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmoa+V0G16uwytR4pKBuu3AsjwJOdeXuMhdzSLIowssL+oNGmt
	xc5A8fPkwlNqcHOvIOFNf8LfDRTzA/0QBFT34wOJQtwpi3laUncU2MEwOZAC/ro9Q9AteDtMaAk
	W4aI96UXgVs9Zh7+td7ykY8SfHeIyc2nPlEGWC/sR1gQoyAEdSjdLZUk=
X-Gm-Gg: AR+sD11m8tKB6xbmOdSbLGrTi/1DinDNygWrpsEM9n/+9/+A8W7HO2YHsqyBvcpFNWM
	xfxJzFTuCFRR3OPIFDHRNVJEJWwYFzSUR0y2mVBhYkdYu6VPPxXyXu4VSDwJVUCBtwpwMCnH7B8
	iju/ap6dgMgZy/TFFovMFkIOKQw9YNdubHxIYhXtgHcowcHuRJwqwTPexCMLMwNdL8wjFDKT1AL
	uoZhB3Bdey3R86gq+bbQy+a2ORYfKOAwqfVqGFJtSilIDVD1lHKrhcOYzW2JpN+n8jTPVNQPV95
	55W2+hC/oifs8LrM+RVx9CNSilL+0wA+yjiKr7tJ32CgwYYRfxaJIup8uis=
X-Received: by 2002:a05:6a00:3686:b0:84f:a640:3ed with SMTP id d2e1a72fcca58-84fb55abaebmr6810616b3a.38.1786546838174;
        Wed, 12 Aug 2026 08:00:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:3686:b0:84f:a640:3ed with SMTP id d2e1a72fcca58-84fb55abaebmr6810182b3a.38.1786546836624;
        Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
Received: from localhost ([2a12:a305:4::40fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d492f0sm1191939b3a.23.2026.08.12.08.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:00:33 -0400
Message-ID: <536fd5e22856840296db301e99b6fa01.guodong.xu@oss.qualcomm.com>
From: Guodong Xu <guodong.xu@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, kvm@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 07/17] riscv: Add B to hwcap and hwprobe
In-Reply-To: <20260701132755.50D5A1F000E9@smtp.kernel.org>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-7-2c61f94a695a@gmail.com>
 <20260701132755.50D5A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX2id1cw4qAOSh
 PvKI5T8c1GNHoufOsl452zkoSOZMPGtASxgzxV3QRTNhbJUFkaXWjLLHpiCP1aUBtrNVpL1Lx39
 mFujCV1fY+XSCNmtofE/5GgmP9TYQXU=
X-Proofpoint-ORIG-GUID: xBZzLfTTnrtaECRBsNSeqsfZvhC6MYOm
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c8a97 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=N3_LGyncGubAy_kLYfEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: xBZzLfTTnrtaECRBsNSeqsfZvhC6MYOm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyMiBTYWx0ZWRfX08lDTzCB/vH5
 65/oZSixOCbcJI1WK8QFs4rY83Z0cR2Z4digaJN0ha3K42zlnsiWKA9RoaEWAnCiBZvYYpCCa82
 d21mBg2FAfYOREjbVispDoT7ejDHJsqjoe4GUjfyivzO+Ow1s+Id044dwUgWvnTz8/v7Jq31ZGP
 gUWFlGP/QroRE2MA6WEcDzXz1DmjRH+38zbKzb45PzrodKfFwSyhUs9PrxOBsYM7IaImE7GgNt4
 6aNA1eMrNAZcEo4JxjWXXeOSuOOZWTsfTJN/SNQ/XIyu4bosb543BzR7Q/6CQpECmuQm7So9XZw
 t8npo/xGZiSAMrRlBmcvF203ohpAArThwEMmjpqo+GBAd5Kj59W0TWDKWvK6y6TATN4zavR9wgz
 zlv5XcvpkVrhro/aAE8HyZaCzfiEemJ4ZLCEVJ1gV0Up/8XT7859Rv3xFLBwwnogutsAsrl7YfJ
 Ip0pizA3pXz+9qpIZ4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120122

On Wed, 01 Jul 2026 13:27:54 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The new B base extension is added to the host's hwcap and hwprobe, but KVM support was omitted, preventing VMMs from enabling it for guests.
> --
>
> commit 1f4cf004cf603a91f99c0c6776c5ca74728ca05e
> Author: Andrew Jones <andrew.jones@oss.qualcomm.com>
>
> riscv: Add B to hwcap and hwprobe
>
> Add B to hwcap and ensure when B is present that Zba, Zbb, and Zbs
> are all set. Also expose B via hwprobe so that userspace can probe B directly.
>
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 0acb7a01ecc0f..58523b3a1998a 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -11,6 +11,7 @@
> >  #include <uapi/asm/hwcap.h>
> >
> >  #define RISCV_ISA_EXT_A		('a' - 'a')
> > +#define RISCV_ISA_EXT_B		('b' - 'a')
>
> [Severity: Medium]
> Since the B extension is now exposed to the host, does this patch also need
> to add KVM support so VMMs can pass the B extension to guests?
>
> Without adding KVM_RISCV_ISA_EXT_B to enum KVM_RISCV_ISA_EXT_ID in
> arch/riscv/include/uapi/asm/kvm.h and the corresponding KVM_ISA_EXT_ARR(B)
> mapping in arch/riscv/kvm/isa.c, KVM's ONE_REG handler will drop the
> configuration request.
>
> When a VMM configures a guest's ISA by writing to KVM_REG_RISCV_CONFIG_REG(isa)
> with the B bit set, kvm_riscv_base2isa_ext() will return KVM_RISCV_ISA_EXT_MAX
> and explicitly clear the bit from the requested register value.

I will send another series to expose extensions to KVM guests.
Let's settle the current series first.

Guodong
