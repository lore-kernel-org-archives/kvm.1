Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790F514742
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026045; cv=none; b=CnH1sOL/DXttBCX47NCh/vVadV8FqpPdrT6tJ4lzGSyKJoPWcYjysE85/LBU/xj65w6vM7+fh2GkrjuXLCp/PQG4vEakAjVjOJxFk3a3YVPbgoYQvmvFTx+4jLwF+Pugo4L/9qFmCDlzGv7NdfBpJxXldR1DxejpuG1Rg1bwBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026045; c=relaxed/simple;
	bh=S4xfAqIaDLovmRNalhGiQCzBJDPU9QZ5iqOLO7Rx0ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijCG5iLmJF4lPl3v5k9nXOSrv3w/XZ33aUzIKcg9ThnrAoLjnVs/ebuSeI6sIpe4iYEjS1Xxj74emr8OO8numCLlna5KVcgNh3gGRXU6F0/GZs+TJ4rSCrqR1/DscUXRVjsklPvvn8ie0m/SvqaXaRL5S8fZrHn6soEJFq+lBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eqQ8O7zw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Of2mXILY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eqQ8O7zw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Of2mXILY"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LKf1MI2892147
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9V9V3F7pGrGXJ58UfRgOG3pzS7jz6dKjyIdgzZ9kkkQ=; b=eqQ8O7zw8YlH96Fr
	MQ7TVFu2Ep5Ocr5FzZRIIXRABxzdzTilVRORHzUsG7dPd+eX6lq5tCExX1kW68h8
	J8Eci8XaNtHGBiN8L3fVpzjJpr9vk9NHl9jINuY0/c+fc+TDWz0YqfISorhCKbpp
	YLJzUGy1rNAriFdREb3OTNIECkF9a3vUBN29vwa7FAwpNszMHOSDJV/od4LuTRaF
	sGzNLmmSXqQrY47+qnnOPRmMLh6ZyGJ2UXhRjGgvWLMUJxeePWa7sYGjizCXdDh5
	8guwEu6ROrVhQxfum73qHeMpkXuf8QN2X8GLif92dQeZqbm5ar2+wXK6ALCpn7BA
	S/KfBA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw3eq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:27:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7348bd56fso2823086a12.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790026042; x=1790630842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9V9V3F7pGrGXJ58UfRgOG3pzS7jz6dKjyIdgzZ9kkkQ=;
        b=Of2mXILY716HGlLd/cSx+ZBFzcYf/xppkZSv+VaZUtRHoTcS8CkUc+yybZSPTJjP0i
         16u7uO4bySnLtJJxYo3Qnr+FuxtDaJ/35zHuW8I3coFDSFooCzuQ7s8N2wDdCTPqgECi
         xC7t1hyTNkaBGiVDSJjoKJSiXLLEm2xlCOp9gudEgRtVVeLAG3Bhw1hZHqIIn2oqXsoo
         P6tjVhxt20IRxqU0+CTU2CAn1nxWa+0CE2aub+rEqZSIgUi1qCLJ6McpugyEDP0fC4PB
         b4l3mFzXVOYCke24qL4LVNCCucNd37r1vLy9fS7r8iR0T/yXqm95ZU/f+vOCReT8rNr/
         MAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026042; x=1790630842;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9V9V3F7pGrGXJ58UfRgOG3pzS7jz6dKjyIdgzZ9kkkQ=;
        b=BncINUDsNsPxfo0fbkkZJ9AEoHPCBoaaD5iF5eC1vbGtH2PoCNjMOFh8YMcb3xHjRZ
         OygPLeIc1QRmN3q7cGkGFYz21OAGhg6irEDQCxNE3BILwWAKd0aEtYqVbCEe9spZtzAb
         FF70e5F9poopYw5pDYDmbps3plRr9wWjX27kr+FgGpILkfeph9oGoky4AsPQBVGZWQXB
         q7LFddCDx3DIElwmbDKru21WYdn4d12xSeq1YMVSIrwtaRiwySg8DDiJ/czC3ovTDP9t
         jDIfQvsM6G/8hOOA8rYt0d1t1uH2tiCTkEo6y1QFTA/SSagK3oPnllBGSuA480Gy8EUC
         r9OA==
X-Gm-Message-State: AFuF++m56MqDzcVIzB5E0chRXByhpwKD+wKYf/t4zcB0a0WFr84t3zX2
	JvKNKrkpItSFmOHNQHW6E47BWkyOpeRm4K88JDMcaBS8Tkxkw2JitQrAoSKhLAadGVITt8nNVki
	hFJ4BJs2Ck55yRL5WOe8zkf2ag7BKCJVAffKvhZtQ7FcCNBhXTKzSt+Y=
X-Gm-Gg: AYBFou0K7RuJMJde4zkOQfyafPK0zRs0pGHiGyJHRLN5LoXqT6wLyKIBIPqK3hoWQxt
	2xz6v89lpUH8TUsBbKNoLbBhoudIOKf1KrT3OYTk0BJ2O+gMWvV4qETZz4GLfYktFViom7rg9mC
	Xr8/jyPGDtXWqGtssf4fT3Qdivj88+oftO7KSc37y9VmdvP60AsIYrOoZUR3VYS/01OJfioOp5T
	/W3/ni7PbylRKm4+ygGh55t7H1jbslmXfJ5X1+Wct2232t/xGRIm57H+haggztKkPZWGtkTezmO
	zJlF1jKvvP0ImK5lElKmCSF8aKYlbDGfjwvjak4gK5V+pHPsaffx/NI8UKHcNPY/7OHSU10fDon
	kWiG9BlUnXTOQZdnImg1EJt+mNA==
X-Received: by 2002:a05:6a20:43ab:b0:3dd:a196:907b with SMTP id adf61e73a8af0-3dde41729a0mr297619637.69.1790026041733;
        Mon, 21 Sep 2026 14:27:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:43ab:b0:3dd:a196:907b with SMTP id adf61e73a8af0-3dde41729a0mr297581637.69.1790026041203;
        Mon, 21 Sep 2026 14:27:21 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5e95c4b9sm851620eec.0.2026.09.21.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:27:20 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:27:16 -0700
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
Message-ID: <20260921142716.000073f8@oss.qualcomm.com>
In-Reply-To: <45fb9520-7003-412f-9ab1-14e2a762c816@arm.com>
References: <20260912083611.2513845-1-suzuki.poulose@arm.com>
	<20260912083611.2513845-2-suzuki.poulose@arm.com>
	<178978126540.2352296.16845657485139032765.b4-review@b4>
	<d7ccaf22-5bde-4344-8bf0-a5a17dcac0f3@arm.com>
	<45fb9520-7003-412f-9ab1-14e2a762c816@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMxMyBTYWx0ZWRfX3xJomJHm0ZPw
 aI9SzL6HEhy61AGT/F3WhEusesFUkU5df2te7o30AgzS2isiosgU3soGyWDUZZ/x8KBH2F+5gp0
 mH6vj3TykcE6C7kN56LiGBVB8eDgov8E4za16EDeYUfXdIRtxscG3JXiLJn/GYV8fQ2dL/A2n/n
 DmhUnD7e4VEOnf0ip/WQgS8HTVsG0LqP5PR8znbJlQguYVLkWUaAQrGIXxXs7ZEGAsS5RjPOUad
 IoSYm018Fl64LziKlhcBCdy+N064x5iaHvWuH1O5pc8b58Y6ffwI7xXn3FiIHfHSj1mxeS84uLN
 RmjVoaXzy9fSDR3x7eoGIsBPl6UQTjuWNaQO1ng8p+JhxoT3J95rcuhDnQH7OXQ5gwB0lZDS4SF
 pY9hVEaRvMgPvAoUiPhqF5z5P9c62CR6nwnA4rgVjReSgHrbs+znLxT5p0Wz9NgDDXMeIOHXazz
 NzJuuZt1HC9Eywp6LFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMxMyBTYWx0ZWRfX6OY7NpmUx3Sd
 38YNtdIRH7IY3R8VeIWcgHLbCtJagWMm3EAXhKvVGbvbmYytB79+qXeWZ2msKJHjZyFOVafFEPV
 kYz2arqj2qFRHHW2lf8mCadPSQwRPaw=
X-Proofpoint-ORIG-GUID: pxCIKcP1t4zxT6lOaymlBjJY1tpbn5Gd
X-Proofpoint-GUID: pxCIKcP1t4zxT6lOaymlBjJY1tpbn5Gd
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab1a13a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7CQSdrXTAAAA:8 a=sxcT59CpA4y3w3PZQfIA:9 a=wPNLvfGTeEIA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210313

On Mon, 21 Sep 2026 11:02:56 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 21/09/2026 10:27, Suzuki K Poulose wrote:
> > On 19/09/2026 02:27, Jonathan Cameron wrote: =20
> >>> The RMM (Realm Management Monitor) provides functionality that can be
> >>> accessed by SMC calls from the host.
> >>>
> >>> The SMC definitions are based on DEN0137[1] version 2.0-bet3
> >>>
> >>> [1] https://developer.arm.com/documentation/den0137/2-0bet3/
> >>>
> >>> Signed-off-by: Steven Price <steven.price@arm.com>
> >>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com> =20
> >>
> >> With Gavin's nitpicks and the GENMASK_ULL() from sashiko, just a few
> >> comments inline.=A0 Mostly on subtle inconsistencies that really don't
> >> matter that much.
> >> =20
> >>> =A0 include/linux/arm-smccc-rmi.h | 497 +++++++++++++++++++++++++++++=
+++++
> >>> =A0 1 file changed, 497 insertions(+)
> >>> =A0 create mode 100644 include/linux/arm-smccc-rmi.h
> >>>
> >>> diff --git a/include/linux/arm-smccc-rmi.h b/include/linux/arm-smccc-=
=20
> >>> rmi.h
> >>> new file mode 100644
> >>> index 000000000000..214d6228dfc2
> >>> --- /dev/null
> >>> +++ b/include/linux/arm-smccc-rmi.h
> >>> @@ -0,0 +1,497 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * Copyright (C) 2023-2026 ARM Ltd.
> >>> + *
> >>> + * The values and structures in this file are from the Realm=20
> >>> Management Monitor
> >>> + * specification (DEN0137) version 2.0-bet3:
> >>> + * https://developer.arm.com/documentation/den0137/2-0bet3/
> >>> + */
> >>> +
> >>> +#ifndef __LINUX_ARM_SMCCC_RMI_H_
> >>> +#define __LINUX_ARM_SMCCC_RMI_H_
> >>> +
> >>> +#include <linux/arm-smccc.h>
> >>> +#include <linux/bitfield.h>
> >>> +#include <linux/bits.h>
> >>> +#include <linux/build_bug.h>
> >>> +#include <linux/sizes.h>
> >>> +
> >>> +#include <asm/page.h>
> >>> +
> >>> +#define SMC_RMI_CALL(func)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \
> >>> +=A0=A0=A0 ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,=A0=A0=A0=A0=A0=A0=
=A0 \
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM_SMCCC_SMC_64,=A0=A0=
=A0=A0=A0=A0=A0 \
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ARM_SMCCC_OWNER_STANDARD,=
=A0=A0=A0 \
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (func)) =20
> >>
> >> Obviously it is v18 so probably a future thing but nothing about this
> >> is RMI specific.=A0 Could be used for ARM_SMCCC_TRNG_RND64 for instanc=
e.
> >> I'm not entirely sure what we'd call such a macro
> >>
> >> ARM_SMCCC_CALL_VAL64_STD() maybe? =20
> >=20
> > ARM_SMCCC_STD_CALL64_VAL() ?
> >=20
> > But, I would leave it as a wider cleanup in the tree as a separate
> > series.
> >  =20
> >>
> >> I'm not just not keen on macros whose names to me hint at something
> >> special. FWIW this also matches SMC_RSI_FID() and FFA_SMC64().
> >> Isn't it nice when we have a predictable naming scheme :)
> >>
> >> FID (for Function IDentifier) is in the spec, so maybe?
> >>
> >> Anyhow, I don't really care that much.
> >> =20
> >>> +
> >>> +#define SMC_RMI_VERSION=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 SMC_RMI_CALL(0x0150)
> >>> + =20
> >>
> >> =20
> >>> +#define RMI_ABI_MAJOR_VERSION=A0=A0=A0 2
> >>> +#define RMI_ABI_MINOR_VERSION=A0=A0=A0 0
> >>> +
> >>> +#define RMI_ABI_VERSION_GET_MAJOR(version) ((version) >> 16) =20
> >>
> >> I'd mask it.=A0 Mostly because that would shout that it is only 15 bit=
s.
> >> =20
> >=20
> > Ack
> >  =20
> >>> +#define RMI_ABI_VERSION_GET_MINOR(version) ((version) & 0xFFFF)
> >>> +#define RMI_ABI_VERSION(major, minor)=A0=A0=A0=A0=A0 (((major) << 16=
) | (minor)) =20
> >>
> >> I'd go all in on FIELD_PREP() / FIELD_GET() + GENMASK just for the
> >> sake of consistency + not having to be careful that everything is
> >> checked for fit to keep the LLM bots happy.
> >> =20
> >>> +
> >>> +#define RMI_RETURN_STATUS_MASK=A0=A0=A0=A0=A0=A0=A0 GENMASK(7, 0)
> >>> +#define RMI_RETURN_INDEX_MASK=A0=A0=A0=A0=A0=A0=A0 GENMASK(15, 8)
> >>> +#define RMI_RETURN_MEMREQ_MASK=A0=A0=A0=A0=A0=A0=A0 GENMASK(9, 8)
> >>> +#define RMI_RETURN_CAN_CANCEL_MASK=A0=A0=A0 BIT(10)
> >>> +
> >>> +#define RMI_RETURN_STATUS(ret)       =20
> >>> FIELD_GET(RMI_RETURN_STATUS_MASK, ret)
> >>> +#define RMI_RETURN_INDEX(ret)       =20
> >>> FIELD_GET(RMI_RETURN_INDEX_MASK, ret) =20
> >>
> >> What's this one?=A0 I can't find anything in the spec that matches it
> >> and as far as I can tell you don't use it in this series. =20
> >=20
> > This is coming from RmiResultDataLevel. See RmiResult type.
> > This was renamed after we introduce the RmiResultDataIncomplete.
> > It is used in the KVM code to find the "level" where a command
> > failed/walked.
> >=20
> > I could rename it to RMI_RESULT_DATA_LEVEL() ?
> > Similarly RMI_RESULT_STATUS instead of RMI_RETURN_*
> >  =20
> >> =20
> >>> +#define RMI_RETURN_MEMREQ(ret)       =20
> >>> FIELD_GET(RMI_RETURN_MEMREQ_MASK, ret)
> >>> +#define RMI_RETURN_CAN_CANCEL(ret)   =20
> >>> FIELD_GET(RMI_RETURN_CAN_CANCEL_MASK, ret) =20
> >  =20
> >> These are obscure enough to find in the spec I'd give a comment just
> >> to save the sanity of anyone looking for them. =20
> >=20
> > As above, they are really RMI_RESULT_DATA_INCOMPLETE_*
> >  =20
> >> =20
> >>> +/*
> >>> + * Note many of these fields are smaller than u64 but all fields=20
> >>> have u64
> >>> + * alignment, so use u64 to ensure correct alignment. =20
> >>
> >> Obviously this is only going to run on arm64 so it's not critical, but
> >> more generally u64s aren't always 64 bit aligned.=A0 So if you 'really'
> >> care aligned_u64 is there to ensure it.=A0 Meh, arm64 so fine. =20
> >=20
> > Agreed, I am worried about the churn in the consumer code. Also, like
> > you said, this is only for ARM64. So, I would pass it.
> >  =20
> >> =20
> >>> + */
> >>> +struct rmm_config {
> >>> +=A0=A0=A0 union { /* 0x0 */
> >>> +=A0=A0=A0=A0=A0=A0=A0 struct {
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u64 tracking_region_size;
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u64 rmi_granule_size;
> >>> +=A0=A0=A0=A0=A0=A0=A0 };
> >>> +=A0=A0=A0=A0=A0=A0=A0 u8 sizer[SZ_4K];
> >>> +=A0=A0=A0 };
> >>> +};
> >>> +
> >>> +static_assert(sizeof(struct rmm_config) =3D=3D SZ_4K);
> >>> +
> >>> +#define RMI_REALM_PARAM_FLAG_SVE=A0=A0=A0=A0=A0=A0=A0 BIT(1)
> >>> +#define RMI_REALM_PARAM_FLAG_PMU=A0=A0=A0=A0=A0=A0=A0 BIT(2)
> >>> +#define RMI_REALM_PARAM_FLAG_DA=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT=
(3)
> >>> +#define RMI_REALM_PARAM_FLAG_LFA_POLICY=A0=A0=A0=A0=A0=A0=A0 GENMASK=
(6, 5)
> >>> +#define RMI_REALM_PARAM_FLAG_MEC_POLICY=A0=A0=A0=A0=A0=A0=A0 GENMASK=
(8, 7) =20
> >>
> >> Tiny bit inconsistent. When do you decide _MASK is needed and when
> >> not?=A0 Seems a little too random for multibit fields. =20
> >=20
> > I will try to clean this up. =20
>=20
> Actually, this is used when we don't consume them from RMM. i.e.,
> we never call FIELD_GET() on them. But thats not a reason for
> not being consistent in naming. I can fix it

Too obscure for me!  So if not too painful cleaner to just fix it.

Jonathan

>=20
> Cheers
> Suzuki
>=20
>=20

