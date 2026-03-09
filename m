Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1A354ADB
	for <kvm@vger.kernel.org>; Mon,  9 Mar 2026 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090768; cv=none; b=KmqN4xqJ1UMgZAlXPyZfTRBZY8HKLcNzS2nkL1vD6adnx6g9LgZ8U3M5A9bc2zKYU92kYW22rfWXbqAN7fIZB9dtRTKQJYGRFx/FxrOWz/GPlhLpA1N7oBWhbQMBNkrC42+fL17QnKcNaF2goi7MSXDLGs0of3Sj2O/T59oGJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090768; c=relaxed/simple;
	bh=OisU8/8uhjX0zILNpoyDakUxcHZy8b4fCJ0S1Nzcj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi+Yka1J7rBvwdNP4K8IFYBtSpqP4ymIkuiaVmLe7oC9J2ToheRvU8EO10CPRPcLmFAocwYa2twxSfetCi0Y9iJDE8sQL/P2piCxAVgkK1bgglltbmzFQQLNzuDpZgt/Woa//WnJmS+ZvJipRGx5wDQot20mwKIJnzedSDvty4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwctoPmu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKfUw8C9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwctoPmu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKfUw8C9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HC5NR3280630
	for <kvm@vger.kernel.org>; Mon, 9 Mar 2026 21:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hIRGX75FqhGaD3BMA10Fm2iv
	i9uf9Iqa56+NA2iQds4=; b=iwctoPmuglmq0Tf+ez67wQOU7T44KIlV1E5lOjbX
	bcNC4aXZ4D6Gzwyp3ADUzKFH6lmeJwdOSjiXKTvKwvcMdEtmiZYFyeUzUuiuFp40
	VAbZ/7znO6OIghtb5LL6ebpNHstAtdHXaBxA2FJRHnkD2T0+WCOl/9wbu4uJ4eqD
	mM2ZEaGJ018xRi7699eftmMw1bcfPEGSpTXEwgOPHOFl+8FsH4CMBvh7RyEEyCs3
	tqQ+mU7KJbPRZiY8MrtuIczgqdvj/zKiMWC7r9GdIJXYELL+wfepJMQMi4ggbypU
	qR/ZOUhCgrwm/aFcvBctADV4jotTPmIJvjEdnF4+4E7JlQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csqcyb885-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 21:12:45 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-672c40f3873so204669983eaf.2
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773090764; x=1773695564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIRGX75FqhGaD3BMA10Fm2ivi9uf9Iqa56+NA2iQds4=;
        b=YKfUw8C9eCPcvlazAv+h4dMkhZpYCZUeB2aBSKwHj4rkzvy/OGP7EyczLUS9Q2GPuZ
         XXEe93fRGFT6hSaHwnP9FF1B9+b9y00rNFJoatbi28VGhpQnwE3VYvteUaTzbr2ZYyZW
         lxUDvOSrvnFBiHEIRg/0+O23fbBJvjBfMGz3cnL5bB1v91ion/g+n5vpzCCt+QyFZ/PL
         06uBu7EuI2kSkYbbwH0oDyS6uqiH6qTpF8yWTvJA881Lww7ewajXAY+MEPGXLz2WHwA3
         3dTRm8GO2O5TSRKghqTc4j17aSicIx7ILtgfmOYYa4PXFRhGadjieHcZKJN7r5qXKqeN
         QZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773090764; x=1773695564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIRGX75FqhGaD3BMA10Fm2ivi9uf9Iqa56+NA2iQds4=;
        b=a4/SFxM/mjxXOegFB215DdJGS5TlflQ/xk+SEEeR7AkAgGvSoxwvXaGuZun0QSt85r
         kUwescI22TEawGgg2WrI/L+/yclvkrBEfiZW2VKW0WLAABzGWeLk/YkskjfQ9R2Tgmgz
         6AcWNd+JPb+5BxrBwF2+1hv9eDE5ErzooB+4F8QmqCwmxQtc8FesUS1ijlD4UCRoec+u
         Jee1y0taWx+SjPYp1JwPgkUb8P08UyEbPXtLsZmVpvJdhnkRCTZrD1TKPWirFh7nYo3T
         KQ28Y/Nh6VdjatT9fMMl/wdJlaFqXGblwkL1PKyff78L3qU49BMZ/KWmmoIW3a5KrRY6
         DA6A==
X-Forwarded-Encrypted: i=1; AJvYcCUROc0o7XHjLS/GYhrK9YOPT5WBVJfpu4mT9w0V0I7z59hLTtbIUXdWQRTVm2L9QRwJQ4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywju3VS3Y/M9iG0p1L0LOgM+WZzFx9x8Y0qK8DB8YaC+Mz6ItbV
	aNOt6MGhEeXyQzIRSgvXpLRjQugu6o5CfQBpB7iHow3YJaBf+D0h7yFpbD57QK5d4EP9etKv7Mh
	y3iRGVQunxquzp6nHoTKjIt7dJclQv3Gux3Yg8r5BKNMyoXTrP5KHxUnF8H0eZJM=
X-Gm-Gg: ATEYQzyh7/kcvfaxnIMogWMrlxo3SiBB71SIO/92R7rqTS302BCihnGirB4Xhirfp7f
	WIePIS2Wpkh4j9F3WgZmH1EvIlRpxQVcGAd66XuhFmuYCnKRpIEDi+1W0J3k8Yr2XkJjdSgDAcC
	ecOo8XqAMyiyzUkso3hrBkaJ6QaQbBWZf2pRUNn9LKIGGzFzLblJw/RZn374VDfrhPbZEDXNuD9
	Z15ztLB5R3wSEmIv9mXQ8UKzFqy0/nk8Ptu4bh+xDlR81HS12COgu1NFv8q1YTat/edR2MNFbw7
	MHs3ZjPr61u8LJPvm0vGbbMsmsMQPGttygwzGHGrRxrkDEdztXYCTxuhM1fggZJFAYQwqpR9tSe
	doofAUo+6fXIuhL+3a/uakUnWDTxFa6U=
X-Received: by 2002:a05:6820:1991:b0:67a:1d88:46d5 with SMTP id 006d021491bc7-67b9bcd3839mr7601096eaf.31.1773090764526;
        Mon, 09 Mar 2026 14:12:44 -0700 (PDT)
X-Received: by 2002:a05:6820:1991:b0:67a:1d88:46d5 with SMTP id 006d021491bc7-67b9bcd3839mr7601074eaf.31.1773090764040;
        Mon, 09 Mar 2026 14:12:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bacd85dd6sm3996753eaf.11.2026.03.09.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:12:43 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:12:43 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: fix PMU snapshot_set_shmem on 32-bit hosts
Message-ID: <guxeojlqqz6cfjdilxnuaeyft4cn4lwdrbplat7xgd5w5hod44@uxqymidomd55>
References: <20260307234355.69831-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307234355.69831-1-osama.abdelkader@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfX4f1RPPm8IWXy
 /UBGrQS0msCMMHhkBQsA9NDqP2r3FqvUTuOhcGu7WJiGykRGE5u9ljOEYd64IL8xovoKXS5utWu
 qNNq0+Rwuo6QfSezRHs/09zLtedqLq392650i4RKpw96qXDatEiMw5c9klas7IXXswHYciThpSM
 F9IscPRJXB7moqfvPWt/bv//P53bEQh3AhxaqMcSTxPumt9usyHHu5XAqp5ktHcOru4BV4CGtGJ
 /lPHZrF91zNfA5szC2RzEh7TB0gxkUEwM53t2qNSSuIb0jbFvYhlvMI64+R/Zg4Zk1a6ZADfP10
 M4Fvi6gYUuvcdR6hayHUwgFfWmrLB6kJgaE72LRtIbmtEx7zInXPwYNAoukV9biou5UgpLdgcqN
 ggWJIzJjsYv6r08BzUI7Snmuvr77ZSduR0BV6+h7ZWJ/CCuMRnbhXv6+OSfFAQtm/1zwj3G1Mc/
 RLu74HA5J9Q0z0LlFow==
X-Authority-Analysis: v=2.4 cv=QJtlhwLL c=1 sm=1 tr=0 ts=69af37cd cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tWgbADMcUQFZQAcJDasA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=WZGXeFmKUf7gPmL3hEjn:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: UHW0rd--iGNDQorCF7kftlj3yTOmHJ0h
X-Proofpoint-GUID: UHW0rd--iGNDQorCF7kftlj3yTOmHJ0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090188

On Sun, Mar 08, 2026 at 12:43:54AM +0100, Osama Abdelkader wrote:
> When saddr_high != 0 on RV32, the goto out was unconditional, causing
> valid 64-bit addresses to be rejected. Only goto out when the address
> is invalid (64-bit host with saddr_high != 0).
> 
> Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 4d8d5e9aa53d..045099ca904b 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -425,9 +425,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>  	if (saddr_high != 0) {
>  		if (IS_ENABLED(CONFIG_32BIT))
>  			saddr |= ((gpa_t)saddr_high << 32);
> -		else
> +		else {
>  			sbiret = SBI_ERR_INVALID_ADDRESS;
> -		goto out;
> +			goto out;
> +		}

nit: Could add the {} to the if-arm too in order to keep things balanced.
Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

Thanks,
drew

>  	}
>  
>  	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
> -- 
> 2.43.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
