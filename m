Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536347;
	b=BdDMIJsJcvNAwgpYk5T3nfUyt6gCRFieTfcLlkW/QL1YSPWmWf2fthAcMzoNdcMSywAQ
	 4qxfhREQwI9O5AkLPG6+2eVPllkj5EwDAtF+wRQFo2md0sZZXSdj2e4yycZ0hJgekhKvB
	 PvLyfoEki3aCuwjxGgXlqF9Y7yb8Wx8MovLxMCHe9GPShNq/30nxE4xhCu/P5s4syhLIz
	 tWfyixjON3kMZDC9aiYKpDLPvIz4u50xFHC++iFNtKRQBfEyTWlMn6dz6lkSCWIAyTlYb
	 7whimy1d8ukFYQ8DG1MPfc6la1uqgCfMNsOjG+jdbk4vAVe5tlrnqr48ikg9nRBgRTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=aVV/DiQS9aUfxWsfiGy1Q/fbEqtV4Kq+84dgYbtXPGA=;
	b=ik6JP7xyzUQdfOS16KBLylsmNdyi6Zsq9eWQe9pwqPoEtYeLbzwnKtn0MjN6GKR6JCS8
	 prwrFRjVdg17qLQy2O+FKwXCMcBz+3xVEbFAH1mBhKJDtd5wnTDO7Zm8xkva73WXMG8UD
	 nRh5heVdWwDTGFu+t1GXL1KFLNk49J54SHWidgb8bLMC8DISphS2K3xIqJYJikVMfauhq
	 kLpPVExyKgsFGmnGrGglnvw9trwEmYFjQsVDBNcgVQEHJ2Apr153GctXvQJqwkOd01DQu
	 XNuMZWfT6Kj3IrE8GJfrCZKSKt5aaAzWlWwEjBch0QMpbcD1m0hLTgUvC1RGNLoTYgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mw1QJSMP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hcZgV+ZS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CF606A323
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C60CF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mw1QJSMP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hcZgV+ZS
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFL8Ge1215313
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aVV/DiQS9aUfxWsfiGy1Q/fbEqtV4Kq+84dgYbtXPGA=; b=mw1QJSMPkzhPdgAC
	WXDML3CeNT+ar8JzKKkJz0EtokbT34gjv1QpDPAmWC0z/LP28nDQu8/S/B6f/jlC
	K2mxkL+tJiiSwcTyE11oqRhZLBjzB9n3v4j1CPCjjQ9QE8n7hrqZ7FvAzzGeFEAi
	uZWq3dk3dOAO0k8LxWq5vV6DsxA2CjAtzff9lKiz3db5NFlwEw/7Yf94JcSFaOO3
	GJUY9bCCL3Hb7GYmrmLFiIH7xD2VEePYOI9rpgcvardFC+OU/TLvQtdmwu0ZlFN9
	cx9lbDw8+YmZd3Vj23E/tsuFR0MMQQXbld4j8cp+rMzJR6qcdwS7vVrss8ZMIhOb
	z18Jmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rpjnwy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 16:05:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so3932154a91.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795536345; x=1796141145; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aVV/DiQS9aUfxWsfiGy1Q/fbEqtV4Kq+84dgYbtXPGA=;
        b=hcZgV+ZSoR+jzTwf4IKZ2LBYWl+URXNkwaX0Cht4Ot0YnC9t1agZxP7z9fa/iXszoz
         zhKzKxBOngrh/CENC1V8upFj4uzA3SOjg5jUkepZ5E7a6ON1On2EGthqnzIHHyHD6ZMa
         c9PhFGZFT4t7bB7hQQn32XGCRM6RQ7zbtpdPqj99bwYVX6bHSAQzYmSs6IGLKDIkMn56
         vpy9ShaM0zUpcoK/MF2JhJBFFvTpUeH44yIjbygMzVVxmOkU6Dvls41/IkjQGvBAAsaY
         lm6XMU097i0KI49RwKZIEDDWFha0KbDOg1Cb3tMvkoAmLJEOErxKaE5AVfuWwDW8hex2
         /e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536345; x=1796141145;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVV/DiQS9aUfxWsfiGy1Q/fbEqtV4Kq+84dgYbtXPGA=;
        b=zTd609CVC/nu1HscriDVfB15c2dVEUbXk68tUINWexFLqlE9v4fDt32oZO+aZ+eIEU
         ym3VlnKBcPxYXIKzisPDfjJyEO+v9cQGJDsIglT7gasYapdjT7qmI7h8ToID7KB4DspO
         2JxA8ZE1tGsIHDVKruMJcu89yYHtKPeFJZszLmZGBzpRuv7A5GLYZLmlXTTlozwDEm/U
         bKdIgGN961A6eZ5SgkKNvEB+04ZCznEcnr0mCQ1n1Me8YxF4fP1973j/rKt4Xn7ZlxGz
         a9rp3yfe4Ln9j6R8LWlzY3c6tQKZkCqLIQm+96hLsVXrk4ktF4XHE54s4udVczvehxCH
         a1KQ==
X-Forwarded-Encrypted: i=1; AL+hErHFBaHYEubBiKpYGmlcjMCu3vEqHeJra6t3FShiyzxusG1abjAD8D7mihjbkefTwUCnt3o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aOWpmi+IrXmh8YDAYdR41EevnvWqwmriUYte2ccvBqIN1Guf7
	6L8UbcW0HC7Xx8nV2454svE3Nfokphk83oVxXkGIa682u951mQDKEhpKR6tmM7Dlp1jy5s0rF83
	ggfQ2d+Xvs7pBUHIFfhfuTnJbMYETQo9SzRxWJ1TlI3z2z93APHMSTLk=
X-Gm-Gg: AZFdTZdwyY1LtiO3sms8XXMHyh9kuZHB68z894AzbKvsKk6mW9u5IjpZE8F9u1CYvIw
	yqLENv+E1ZsFdeuoEVanVtLE6ytJuj8BoTe0+tyAaPrI901G/HdCLbctAEsdJPJG16RAwCeThcx
	PLohCALOApmdcmRZf/Y/F0o7/bbOfgi65rNdva8vbAkmXzy9Ct3K+9jTDDQtVY06qzt6Hr8NENG
	WwrqI3kUNMuPEciThIsRJO6nRM5bcw9lTrAbkGgFiGsYi/JktsJDP5MunlYnAkAmSY2hqCmkq+f
	5Xw8oD1qEYow42qT2ZXC72SLt5ObaGvxYPynoOuBk3/++gcFALwRnInnFPqRXTwJSkhszGt5MiY
	IP2H/doXDMuGlHtZ5k2NkSpOPzoxAAi2xD193mId4DlJNfLRpMpaGSA==
X-Received: by 2002:a17:90a:d2cf:b0:3b4:1714:5bfc with SMTP id 98e67ed59e1d1-3b41c9b9dc1mr14552656a91.61.1795536344439;
        Tue, 24 Nov 2026 08:05:44 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b4:1714:5bfc with SMTP id 98e67ed59e1d1-3b41c9b9dc1mr14552613a91.61.1795536343930;
        Tue, 24 Nov 2026 08:05:43 -0800 (PST)
Received: from localhost ([188.253.117.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8e93asm23275610a91.11.2026.11.24.08.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:05:43 -0800 (PST)
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
Date: Wed, 25 Nov 2026 00:05:28 +0800
Message-Id: <DN3KIA4URDQ5.2MNEHHDE6WLAJ@oss.qualcomm.com>
Cc: "Atish Patra" <atish.patra@linux.dev>, "Paul Walmsley" <pjw@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
        <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <majiuyue@bosc.ac.cn>, <anzoso@outlook.com>,
        "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH] RISC-V: KVM: Flush VS-stage TLB before reusing a host
 CPU
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "BillXiang" <xiangwencheng@lanxincomputing.com>,
        "guoyaxing"
 <guoyaxing@bosc.ac.cn>,
        "Anup Patel" <anup@brainfault.org>
X-Mailer: aerc 0.22.0.r49.g9313f0f0
References: <20260817102447.40259-1-guoyaxing@bosc.ac.cn>
 <CAAhSdy2qwdHE7SB2gRK3_PQ6m_bMSfWpvcuSG-31W2yd3-UTKg@mail.gmail.com>
 <285419e5-c4fc-4c75-a765-436165bdc8b9@bosc.ac.cn>
 <CAAhSdy1Q7a+54qn0xNBQBd1eV2ve+Nzqz9uRsWrGSmTn35z8=A@mail.gmail.com>
 <c050c85c-482a-4351-b627-ac074f7f7952@bosc.ac.cn>
 <bddcd13b-b97d-4c24-8f08-e0a239065e68@lanxincomputing.com>
In-Reply-To: <bddcd13b-b97d-4c24-8f08-e0a239065e68@lanxincomputing.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2MiBTYWx0ZWRfX8fzKb/csorUa
 K02PUQadnJ536lkz1OwCqDj9kVrMBZvL9dwkbyawFuUOMJtOYxXpg37AvJy276axvZxWPnC5K4K
 Psh1tuKU3sZYxpkzHf8zbEEz10SBj9QGZ6hAto8+q0eKq049RQecLiCkWXCTJenbKFqf4nFbqKc
 UeZWaWiAOH3sR8RwCq21+tUonu3T8hH75GsB/A1yJM/cy2Jc7/9r347CZkxMbxNM/w8NE3q3Oet
 cfSJTAi8YAYJZWI+fsTchWM539ybLlV2nI4TkHaOJDupwiYfoUhm/Bh7yW44hoIWrXUhZ4uDkx7
 wxzMIZyKncuPC1hNrfC6j2Lr3DpWKP6UE8ZOmHa3PeULcxF94/yquj7Oo6YpcGq6ykS74qRS+RL
 sD3g2Isr8GJXEyDU7K8x4Qcoea4SvUb7WYizcz73Jov52xc+NJJx9iOvTrSt+QE5QkqFU0Gx2Uv
 3Xnna7vpuc2cK6uW1Jw==
X-Proofpoint-GUID: uiWfUbrFjjZ7SjfJ21hyi0i3813sKDZT
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b05b5d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=4BKX8IsyAAAA:8 a=EUspDBNiAAAA:8
 a=M4cLWJfQvEUUaw9dnqQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=bflBWynC2lygM3eL1Mvi:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2MiBTYWx0ZWRfXzXRdUpo6SVki
 2ynjir3f8ao6/wW62s9Z6ZujDcZmsuEl5Qj4Bgpx/YFtyIz+y+HMcTMuZyCIu4+chlOXnL/pESo
 DkYqFN/GzzGkqiSW12fSEiHucN+4yV4=
X-Proofpoint-ORIG-GUID: uiWfUbrFjjZ7SjfJ21hyi0i3813sKDZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240062

On Wed Oct 21, 2026 at 5:32 PM CST, BillXiang wrote:
> On 10/10/2026 5:06 PM, guoyaxing wrote:
>>=20

[ ... ]

>> In other words, I am not sure this case is covered by a full guest TLB=
=20
>> flush to all VCPUs on the mapping update. Guest shootdown looks=20
>> mm_cpumask-based, and host pCPU migration of a vCPU does not by itself=
=20
>> add other vCPUs that never ran the mm into that mask.
>>=20
>> The earlier RFC note has a bit more detail on the flow we observed:
>> https://lore.kernel.org/kvm/0d15b098-b8f7-4080-9f33-=20
>> e8c49c2331e1@bosc.ac.cn/
>>=20
>> Please let me know if I misunderstood the intended invalidation path her=
e.
>>=20
>> Thanks,
>> Yaxing
>>=20
>
> Hi Yaxing,
>
> Thanks for your work. To help review and validate this patch, I am=20
> sharing the two programs below, which were generated with the help of an=
=20
> AI assistant. I reviewed the code and ran it on my test system: without=
=20
> this patch the reproducer triggers the stale VS-stage TLB entry, and=20
> with the patch applied it no longer does.
>

[ ... ]

> --- 8< --- end --- 8< ---
>
> Tested-by: BillXiang <xiangwencheng@lanxincomputing.com>
>

Thanks Bill.

I reproduced the same failure on SpacemiT K3 and V100, adapted from your
reproducer: the guest side drives the same four phases over the console
instead of TCP, so it also runs from an initramfs on a bare board.

  Platform      | Host kernel                | Iters | Hits
  --------------+----------------------------+-------+----------
  SpacemiT K3   | v7.4-rc1, unpatched        |  19   | 15
  SpacemiT K3   | v7.4-rc1 + fix             |  20   |  0
  SpacemiT v100 | Ubuntu 7.0.0-30, untouched |  42   | 36 (86%)

Code and notes:
https://github.com/Sutter099/llscripts/tree/main/work/vstlb-repro

Tested-by: Ze Huang <ze.huang@oss.qualcomm.com>
