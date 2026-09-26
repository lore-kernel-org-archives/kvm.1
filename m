Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214483A59BA
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790415313; cv=none; b=OBluvp/yqGYo/bh7UKvBMdg9aEXQcJ535vUFm/Lgb/1XlP8wT/rFGc2QEL9Lie0U6yZyPJTc/mRRmYirXrrFhQFb9gw2g/mACds1c9Ccns7Z5RAYS5kzuh21tFm7qlOl/rgh5xerDw9LnXKjeJc4EKXZclttSBFijOHysO4WZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790415313; c=relaxed/simple;
	bh=IOwzRdKM7QwykPWkyHVhT/cQftu03zzXPzKJlu9gAZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAlvjeWBjtpAz3PBORJt4IIPUjL85TjwDspiNjAOEiDzA3SafpQfEOmdWabXO4SGap3dvy+aVIhHoJ3kC8fIqb0ka5W8JXFXVG/rB7s15Hpw4rVz3cAUeaPb8MFd0lZVFKgncl9I/OYVlo2AQRM7lk5JbiOMvOMyoZ3RNQ8WnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/EFsaZb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=exBadWFj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/EFsaZb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="exBadWFj"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6OhYa3446971
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 09:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=; b=K/EFsaZb3ia4TC7h
	0CdSFJrJQywIJgZwzaAlar7S6kWwmJhtj0v1QHHfozIZQxO1Xc3xiqLZ09bhYqJ0
	2irG1g8DE/6LijO5sjpFs6At5he3iXbO7vrvrYrD0g/QT2hEnZ/a8BlMyiYtyKJq
	Hhj1Jzw09P4xSvZFUcrkzbrC9KoqzeTGJs+Gx49iUSvmG4BmP/11qglZzhFSiwKW
	jxSxZms/lG89a7Ly5w9xoMQ7xMl89+Zu4YY0Q2+yRy8StDnc0NY6u0KzWk1WQEKR
	wqkitPEEiPjTunPGaNvioYd199ypiFOf1wTvuR1szy9Suf0c9NTM9qbOM0mcv9EW
	3bzwqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6938jww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 09:35:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0b66ecd9so249944885a.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790415310; x=1791020110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=;
        b=exBadWFjcFxfRPdqEB9Y5RMlPHN7snqRF/2Wb7q3kCkneSPVqQwW7ixWit6S63bimI
         O2SDAn5afBg/9BQkYE/hy0gs32R48b0LXJdxg8HE36eRV1Z9yyuwUxy5CKZAvyUqMCI2
         OhKLbVuvA2DQ5CExFjJuEdVbPiljonPuMITuoTIBmLAHnXQ+D9W9RRgRhQXkZCAmFgl6
         GOkMF13V5Ca5T7UeTQNZkYnr1CGZiNYzTEEJWgj5THc8wyLI/EwDchGB48oLr33wz5SJ
         K4ePi05IL7xbSNOQDmrd5usIUswr2xw7Q6zWR/qHhC3D5a5vmSarCB3YQBDgg/mnVBcB
         bvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790415310; x=1791020110;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0a8ywQTFMp/tnfN3u+xSfg3xISyQdBYzxdRITV/pVU=;
        b=sCrO1v3J5CG/SxNq9lRxzdFPUA5H8ikNkALd7qSKmNyVCaGWtMQVNv7BzNcpNzb9Ly
         SgP/u77UhDMf9LpF819NB7YNTGLmnmevOTcIbQmMS05sklC9sxuF2SUM0OXBTK58ONW/
         xsfpsgpAZJcl8J7/sAXUbmT0Xhk/QZz/IJs15vc/9gPchSPvdeEaoIbUtWSGBpOf5Wup
         Pp0QdGG2cYGQHQkP7PaAzXUfjFuaqSYzFSOjJUMNAS5kBotGHKH51qx+/o3MlyB5a0ne
         FdJC9uBShOFOfn01o7RzCswb2mAJUxBAP8TpJ2FyKMfGSqMrNf1fQztAUrP378IOITM5
         d8AA==
X-Forwarded-Encrypted: i=1; AKwUvByIDSianns882WRGDJiduK9cyIid+RyDZmHBGYZNFILx21M6iKwZ8EQ3LccYc1b0K8+pUQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l5WTX3uzri6RqUiNMJATPzy9cFTTnRXbWKjwHVDcmTjj4YJqpr
	YdD7sAr8AuhJlg7AyrAW4LlFUM5g5VpmcTH5lnWd9TXJlLZvZg6uIuOUyL7xQfvkn6odZdpR0nW
	vsUOor+fRiQkn52isGhw0fwHJGmIfOEmuG/tH3BE2vdFRMlmna2q2FGM=
X-Gm-Gg: AYBFou3eqUkbskVvhocTuod/35ce3zDPtpoMAfVSIFNvMATdDv9Nss2GB2JmcJ9KbLa
	xuJloCgLDlcq0qY2kO/I6dyAy9XDBr6mZdabTNTVR64yP1/4X28aK1lS1tGcqJNz+2Ryu/7arlW
	ngTVmpzVxti0pH50YrsYLc1qqTZgEwl/I/N72o7hliT41Zywg6oFvSnSIxJeNuoq1RVxgose0Aq
	WVxr18Zi/JaXZJETanm5fJ7QvUY6DzqL8tNgSpTKmIka7MSkxp+eeKCq259QbfeTxBrPljH9Bwo
	DuvBY1MQPuB3uND9JDqK6U72IN6J9r3DATKtZRwBEOF8CoBB/xG4By7ynfOzrdoJB75P5MJI7Sc
	IR8oiCWLvBbLKS3j5B7lNnSLa4OelcI55NQ==
X-Received: by 2002:a05:620a:3912:b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93c43dccd3dmr935999485a.47.1790415310083;
        Sat, 26 Sep 2026 02:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:3912:b0:93a:2d2b:a5ed with SMTP id af79cd13be357-93c43dccd3dmr935994385a.47.1790415309590;
        Sat, 26 Sep 2026 02:35:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef4fc959sm110478295e9.2.2026.09.26.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 02:35:08 -0700 (PDT)
Message-ID: <5687f0f3-052a-4e16-9747-0be60296e07a@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:35:06 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 028/114] hw/intc: use kvm_enabled() in APLIC AIA
 helpers
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
        Chao Liu <chao.liu@processmission.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Fabiano Rosas <farosas@suse.de>,
        Xianglai Li <lixianglai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
        Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Bibo Mao <maobibo@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        David Hildenbrand <david@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
        kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Stafford Horne <shorne@gmail.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
        Song Gao <17746591750@163.com>, qemu-arm@nongnu.org,
        qemu-s390x@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
 <20260923131635.1894-29-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260923131635.1894-29-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfXy25hzpm1GaRP
 y/KG0yNlHVslZ0K2H8W4qgH8aUxpSYpu75Hjg2/LncLvO6XrDoYpe2dfdj24IOFlNamE5FE4tFP
 EcPdneKKgFbTpyrKGdCDeuLZw4E1bt8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX71JQU3zViena
 s3r0gRuJ5b042H1GJx9d8e8H2mguUaoHtp3OqRyEKlbyoO8FsJ+/aouSg5ZC6FaFff+s3l8x5Zv
 hzBEAJkZlOSpmL0nXEop1Dg09bFYh6NdqYyBb/5aSFXti/VCTPRPqq7/Udp2vZyGJAsIua/qHDc
 WlT6vTC8MM/IITvsw8cVd+SS8EDzQYsvvHaX3zGhNauHztGj7h5dQWOAxu0fqmaJYiN0ghtIbkb
 pRkqXq77nphM+LWtV4uXVfRW3FX2sciyKJfBH0QISBdAxbR0yIXpZYv6J7OjcecoIrMXIhXQzHr
 UVUG+42pgJ9L276OCnK8zLG46bIPHHxOxiRkCkvhgtj9rITcw5U9gh5iFEJHp1fnQCFrWo025iq
 1VsHF/+nFcoY9dGeM9CfvX641Cd2zskrI7x2Q2JtljcviUv8IExRNfBWja19oyKhh0AiItDFTTO
 5saHGIH7wiE7cyo33XQ==
X-Proofpoint-GUID: 8ylPzcvcmYQGZyOzRipgphmmJBgThvz_
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab791cf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gis2z1_H4pcAoy-0X7kA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 8ylPzcvcmYQGZyOzRipgphmmJBgThvz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260038

On 23/9/26 15:15, Yonggang Luo wrote:
> - Replace CONFIG_KVM ifdefs in riscv_use_emulated_aplic and
>    riscv_aplic_set_kvm_msicfgaddr with kvm_enabled().

Can you provide your S-o-b tag please?

> ---
>   hw/intc/riscv_aplic.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index d8e25bfda14..03a0852b8b8 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -167,7 +167,10 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
>   
>   bool riscv_use_emulated_aplic(bool msimode)
>   {
> -#ifdef CONFIG_KVM
> +    if (!kvm_enabled()) {
> +        return true;
> +    }
> +
>       if (tcg_enabled()) {
>           return true;
>       }
> @@ -177,21 +180,20 @@ bool riscv_use_emulated_aplic(bool msimode)
>       }
>   
>       return kvm_kernel_irqchip_split();
> -#else
> -    return true;
> -#endif
>   }
>   
>   void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
>   {
> -#ifdef CONFIG_KVM
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
>       if (riscv_use_emulated_aplic(aplic->msimode)) {
>           addr >>= APLIC_xMSICFGADDR_PPN_SHIFT;
>           aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
>           aplic->kvm_msicfgaddrH = extract64(addr, 32, 32) &
>                                    APLIC_MMSICFGADDRH_VALID_MASK;
>       }
> -#endif
>   }
>   
>   /*

