Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769497;
	b=TQ4nUWIGkJ5kJ5mT0ki0hJaSnBObOKqKBubWsudNQ8RFGPPCWklVSFFhKPAo240SpCzP
	 eo7etlL3IlH2aWudlBpme04HdM7JxaX3AaBGE0sqffjyCsm8ucGLKRLaes8McxOhIDEOi
	 +xr06TdK5+QzVSg6yQBkw5rn6xMSd9C9ZD+3K6aDIN2vQN1qGCy4ddGnMuo/tgDB9PlXE
	 P5hfCuyoOmPPypKz15W92HzrNnbCWnsbjWS5lI6FoHnUAMi11klP4vgjp122Z3Git8c7W
	 rmWHa0K8nP5mpkTW/4ZBzcTCYTR9D+sKkATmR999aNK9F3oNBMBvD9G1t9CeL00DOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769497;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
	b=MJ1aGiaKPt1yohu66uDHRy91Kc7gWtEmMui6gCszDgxbueS/WNud+I67i5bcSRDitSas
	 8OqsW8XNqLuGilHjUG3QB2fKomrEyIkaDyI+1pxuN68kuK9ilxVWzW7rnYS3MWl4potaY
	 jDIsLxM5tuE3Oa4nPJ+5JwcUW3eVeKdyf/cxyQDxtByI6yAxC07+FYnajU/7tcxNYQ3NB
	 XeMs8yv1wwRYPOXSPXJNnR50/2/NGRgtXXUXodAC2zqtw81asPNQC2BeyruXlt4zOqROF
	 XuZ0/74Spx4nMKPEj5ibtfZqwbYbUn6POYremE5TSG4xfX8nfAoA9KtZs/Gt+oM/XFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsRLMs5e;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="MA/L8Upr";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E972D606A330
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E972D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BsRLMs5e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MA/L8Upr
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6T7a2676070
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=; b=BsRLMs5ejriH/lIL
	YB0wgFGzAoAsuPOErC2LXvwXzaNy2zgUGBCqEztreE1rQoR8uG2Vda4z6BphVbJP
	s9A8tMgbYc4ssyexAEE80YfipkYOrkmXHRl+zWq95Z2Uy6tgyMvJkeRt0Mr8IZUC
	uDLfTYwXmqKb5dcStOt3upPfcEoBrdWhhxCBNBCdoVOMLhRX4pA0OvNUBCkTDvTl
	TsN3Aj/0yrdsuLtisWNATXENvMRPVp3T382aezpYGYTX+5oHEl9I+C2zU3tE3KvG
	TY/M5ZGaNcYoRfDSDpEdvBl3PyId13ra4ZXhZNDWurndI0Kvp3kJk9b0izTG1OPW
	FBzUFw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahvrgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:31:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea381ce04fso10349875ad.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792769494; x=1793374294; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
        b=MA/L8UprF2wuU4gh4D0ySRU1xQJU9C+HjGOCrlzC11OW34e80uiVEm6lRxjcTkR/fL
         bAyDIc5Y5q2KmMj4Gz8U/jdzXocoJEV/hAJAfVhUJZujqHA4Up7jl5hnBafhUPAYtJeR
         f4l/fXqNMInAbvgahYGbZAkblS/Q9uHiNJY4E0t7SS863McltXs/67Rp2WPmgCxQ7SVp
         gG8UmXuk0DQvJn07CVWvcuwpY2g4MuGDkfC7rPRzBi5/EHCAxeoR3VX6v1kB31NQk0LY
         HkR3TOSJKssG3rg5bv24v4eyb/L7ifqPUWXkIX34lDaI4SN8ElMT36EYdkR+CJU/dIkF
         Aafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792769494; x=1793374294;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZNaGi96jpsEJgcBdqwPHynn/y7akqS1ZiA7apOF+4CQ=;
        b=OBlL406E8plzemDCdHDE9SZLQxoO1/lRwdFPAaehbo0Ar4CpFZ6qpqm+OzVIs9NgxD
         rXcPz66CE+vzr7621w6vx5s8sQEUcaSvIX0dRpuOzaJTOVmpoTbHx93Ey4sQO17Wr73l
         mRBSbK2S9hFqJyiman7+Tuy8svPZrObKQ9CP0FeGfET8FBfH2CSZ1AH+qkwvhFT/tBMj
         jqsO8lxBXEd76SKqlwxjvoAP/WLsLLEviP5X57wz1IVJR6wlB/xjRUfJ79O+KE/Sojjd
         tlsyiM7xqhJBrN8OBOPZzsaymdSTNPVfSb3Yo5WNo55kl0GTmXzGLhezSSs1iZlOfIpC
         7Y/w==
X-Gm-Message-State: AFq9FYKnzgZ/1s77T7YAs0JfJtoI7hv89EIJXyS9WZ+2WPxlmnyJBUIU
	fa2FAmG9QxXog2w2E/pRqzQgrtri/oDju1UZpc7YWEh1TAvLCO/0lT8UbkH+PhLiPsQUW4hGVbx
	KqY1sH7NUHtML5ny8J//F70qHoKKFQxhAot0kdH/Ebka0psWckIiI47o=
X-Gm-Gg: AYBFou0bPbqkezJZTpyqJZW5yp+BPYl8b7wE4e4jCCCIf9ssbuEiQmx0opnjNLED+xW
	H+Hjkiw/ujzRF+bbji45Ah9Pmxeua0LOccilbgwdiPmhrQ4Yeidcsgy4RWv2LaScY4RYQX7wYGn
	krZzax6US9Vv+ptQbpz75NjhvWP8WGBF39XyL83TvTa/hp5BN5A952YkpGtXF66QIPoJvV5rtsE
	kp8DxGyWLKC6LrchAeep92oo0M1k/4u9d4wIT6fRSgn6ClUzBid/fCQhCd/QaTTs1YT0yHCaAyo
	JTrHMSmt/rlqhf8zyYEaVCUjkqvJkXNTc9AC7R8b8g9iPcAAr4TKyux4OSkGQ6qq3emj+yLXLOh
	c2Nc7LgQzpet2GM5PEKO9wX78DEXI+mUG
X-Received: by 2002:a17:902:e848:b0:2e9:743a:7a9d with SMTP id d9443c01a7336-2ea7c28b349mr20823155ad.13.1792769493516;
        Fri, 23 Oct 2026 08:31:33 -0700 (PDT)
X-Received: by 2002:a17:902:e848:b0:2e9:743a:7a9d with SMTP id d9443c01a7336-2ea7c28b349mr20822755ad.13.1792769492870;
        Fri, 23 Oct 2026 08:31:32 -0700 (PDT)
Received: from localhost ([155.117.96.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea947ac357sm1667205ad.76.2026.10.23.08.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 08:31:32 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 23:31:26 +0800
Message-Id: <DMCBQSJ0B22A.2TDXAXPJNPZL2@oss.qualcomm.com>
To: "slack up" <yxcnew@outlook.com>, "Anup Patel" <anup@brainfault.org>,
        "Atish Patra" <atish.patra@linux.dev>,
        "Paul Walmsley" <pjw@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
        "Andy Chiu" <tchiu@tenstorrent.com>,
        "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: KVM: Fix builds without CONFIG_RISCV_ISA_V
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.22.0.r35.g0a434803
References: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
In-Reply-To: <OSQPR01MB6326DDE9C2F390EA3F0F444EC2662@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX9b7hECKgfV+8
 Co+6J8bovb3N4GFta3HB6U57Imqy8nUqafKYi3nswDaDlqEnv3qk1ZK5VoJM4sTnfwmeZp2Nqf9
 AoUTMoUJU0XIbuSdxUBzQykkWrPJNRY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXyGoUASyrOivy
 EAIKR/lICu4YLm5Or/ld9vzm381sTNJiLS3NZaufMupEUK/PFvA5V6AZxOXuYM1RHxlf7PFlygd
 Vumj4DsYRULDt1hzLtSDOTkRNhYYY4xr5dqTbanPMxHKwy2iJhxa1uihQQrNhufCdEeXUYpF+1r
 HhSt8bwiH3iGC+nGiEUfxY4PxPfp10jYvr0l+XOkswkU2IpAHJOzQX+xJrgEo+Y04InoZx3xGN7
 mQ03UnzYXov+AL10O/BnjtqEEGMm417Xt9TtPXmyvRV0AokmEczBJ26DxTrWAQ/OVGODnOdCUmC
 uOWvBAdwk5lRPZiGJVqBRigQaIkDWde1yF9WoJZWDb4jWRmPNeVSN8jCNU2XC+UF10dnNxF45np
 5SfhTVYD2vLokP0ZswIJddBprKmhSz0lMAp1Qt+yYUej22JSKxMmlDCc1XZkp/ybMRZ8hvFLKeE
 ZysgdAYPoF5fOKebpkQ==
X-Proofpoint-GUID: oG5Hs-swoTpDrmFvELIXLVTsVEjBtRcB
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb7dd6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ilsi1XWDFcrB9FjxRIUvHg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B-Qh9SJ9cMKcPyFv0BMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: oG5Hs-swoTpDrmFvELIXLVTsVEjBtRcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060

On Thu Oct 22, 2026 at 1:31 AM CST, slack up wrote:
> From: Xiaochun Yu <yxcnew@outlook.com>
>
> Commit b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context
> handling for kernel-mode vector") made the KVM vCPU load and put paths
> call get_cpu_vector_context() and put_cpu_vector_context()
> unconditionally.  It also added an unconditional call to
> __kvm_riscv_vector_restore() on the guest entry path.
>
> The no-op definitions of the first two helpers live in <asm/vector.h>,
> but <asm/kvm_vcpu_vector.h> includes that header only when
> CONFIG_RISCV_ISA_V is enabled.  The KVM header also does not provide a
> no-op __kvm_riscv_vector_restore() in its disabled branch.  As a result,
> a KVM build without CONFIG_RISCV_ISA_V fails with missing helper
> declarations.
>
> Include <asm/vector.h> unconditionally to reuse its existing no-op
> helpers, and provide the missing KVM restore stub when Vector support is
> disabled.  This does not change the Vector-enabled path.
>
> Fixes: b5060a4aa33d ("RISC-V: KVM: fix vcpu vector context handling for k=
ernel-mode vector")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaochun Yu <yxcnew@outlook.com>
> ---
> This single patch fixes a build regression when KVM is enabled without th=
e
> RISC-V Vector extension.
>
> Tested on base a804c5742bff (Torvalds master):
>
> - CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image modules build passed=
.
> - CONFIG_RISCV_ISA_V=3Dy, CONFIG_KVM=3Dm: vcpu.o and vcpu_vector.o rebuil=
t.

Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>

Tested on commit a804c5742bff with gcc 16.2.1 and clang 23.1.3:

CONFIG_RISCV_ISA_V=3Dn, CONFIG_KVM=3Dm: full Image + modules build passes
(before the patch: 3 implicit-declaration errors with gcc, 5 with clang)

> ---
>  arch/riscv/include/asm/kvm_vcpu_vector.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/includ=
e/asm/kvm_vcpu_vector.h
> index 6371d5ea5392..ebc619ed67dd 100644
> --- a/arch/riscv/include/asm/kvm_vcpu_vector.h
> +++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
> @@ -11,9 +11,9 @@
>  #define __KVM_VCPU_RISCV_VECTOR_H
> =20
>  #include <linux/types.h>
> +#include <asm/vector.h>
> =20
>  #ifdef CONFIG_RISCV_ISA_V
> -#include <asm/vector.h>
>  #include <asm/kvm_host.h>
> =20
>  static __always_inline void __kvm_riscv_vector_save(struct kvm_cpu_conte=
xt *context)
> @@ -55,6 +55,10 @@ static inline void kvm_riscv_v_exit(void)
> =20
>  struct kvm_cpu_context;
> =20
> +static inline void __kvm_riscv_vector_restore(struct kvm_cpu_context *co=
ntext)
> +{
> +}
> +
>  static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
>  {
>  }
>
> ---
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> change-id: 20261021-ospp-c1-b4-submit-e22dc09faf5a
>
> Best regards,


