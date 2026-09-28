Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F4B46F4AB
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590002; cv=none; b=kZr8fryqlwLUvTpHDNrIWpyACIEdMOgmBv0SyNYk9FfzeO5feEPZ3SILN7FVuh4aIbSg5asDpnlL807+z0MrSLp1yLx6j2hTTmFhBZvz4BdxHJ9MEQr3Pb92i8LKZ5dHkKlXmCJIDfQN2P+YxKxAjlubdUSJbcEZqVpDcqgYdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590002; c=relaxed/simple;
	bh=L0CPy5TdiBpGLK/W/sAT2sa7ps/NY3kdO+tLgKZjifk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3NPoInDtvpKDZyTOnCAeMoy+KKvs+skK3kggYCbj4QQbNl/XrrN79POB/2Tvt9rJorRTLs73gJibw1dqQYXtzyR2CpBRkxAzGxRS+/Y/FIDorbjxVweBzZZrVayOz0+wgaJYxVawMANEEwZpIRuNWYpv1ouvi3Lb1rL7Z35oKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=djzaeNZn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQqmOi3P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="djzaeNZn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQqmOi3P"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M3sQ322544
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=; b=djzaeNZnmtCVTeAv
	Lq7uI+8RAd3leXu7xRDaDKLPWuDKlNt4j+ajhWfnpZpOG6jVFa+vMuArlYvarxwV
	ABgEHuGWhHG76DzkYnNRCu+H7zfEQPLDXUfNlHnbiqxQlvMUc36BlyCtHeCcmVo8
	61bVeIWG2fiqM/mGerFHT591byAiEA5Oa9XRrL5wqvidELump/7KWbWAz9cVmKXh
	x9iyBeGsSRoQ9Z3caRFwR84fIcwYUTPQpkkFRfisOQUBFEvCfg7RgC5M5SAdPu5B
	tc73WB9rYus90PXLo/XCgAEfkh8DoSus9y1r7t+8er6HmTgoGYec5F9az6UmR6JZ
	PMCIqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1myb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:06:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934956beec8so621740085a.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790589999; x=1791194799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=;
        b=TQqmOi3PREudD75jONM85+mWpXKONEB36V6I36IYwdjV/54+0YgOMJA6uA7Di6OgWT
         qqoVqRaudvqWfEscqEAX/raa2DOfz1L8d6Ypxf3BWy1rxv+T+PiZtbzNZ6X8aGBzVGt1
         eDClcJXKDozj/NdGJa8TiLFk0AKTNhVBRlSsEoSw3bqBs9yuwBcWnIViz2Cb8ngfR7//
         KHtZKHzzpKIgSp+bJGK51HO2T/LUx0iUQTGkQ+xSX34lEocfZOptX2qe5JBkRKs7+rse
         2z4/POaUCB4fVWpPDY4f7ic9BdGX8Gx6xeuSkMnPfkYRtguBMf5wFOjnA4ngwBGre9Df
         PZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790589999; x=1791194799;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CljvZEFQAdMtbaPvMfiOFg0AK10LzPiqYmEnv2ZTMec=;
        b=kRTFYXo02HVohyIqOYLsX81rlLLwFDtJy8gr8vR81AzIwFFHD/5JS2tuR2/Wb1zNNy
         y5ohx59hcoQcgJG1yIEJ2ozY2Fkb5T3GJ/wvAkO0EuXgh6H6KlSbpD1/oeFYMo9G7owX
         RxBFz40cod8uiJi3v6GIcQxb26SGbKccSjJ3PHfS8cIi24FQAvEbs77zCqktFPKCnFb6
         aBO5ihojyrKDjS3S5NAznDmnvMgQD8b7P+kIFPkmaRqOMvKHVzjH9AjbBWaxm+jJZD+f
         VYxaU2hqIemicvjLN/F4JG7NInGaihH5tgBrkcdjv28oYNM8rESy9+ogL4IWm5WdYUrx
         sWow==
X-Forwarded-Encrypted: i=1; AKwUvBwNKCOnFod3QkiYBlTSGZmsnJrxSTFdxcHGg6l2kujPuIkI8a8JzBgKfziPHxAGc4eT58w=@vger.kernel.org
X-Gm-Message-State: AFuF++lK00ZtO/M1HDMzlZs0FYZ4R/qUUvHj8LLG6W2MnNFDk/YtB+63
	hFMf6w/MOUHCfToQZbSmphsFvx1NL/z6f6R0u6fADz/UWCNtD7KRb5p5nO5lUkFtnchVx9h9VcV
	HLHz+AUUblHM10mZtMC+xKUrN9+h3U93GpbbOdGNoTBYqmYTxXej/Nw4=
X-Gm-Gg: AYBFou0thY55rO4RaoieADwDdqLPQfa0XqPwWDEUvoyYLwo9ENKDTX9Im1jMHD6/+v9
	EK1Em2yntqTLA9xymwyKce8Ec/ko6q/G04B2QeXXOqSC2CoNgKpubQSGFmn16l/JaG+Wsdtl5Tv
	OVmkEHWMiyiJOb9/MCB7qs+jzA+iqlO+YnV9jy7zAHt2mSaG7WhshmwkTehpcufZpOw1mO0lZBe
	gl8duIWfDA64Kppawsq8/zSRPAxXqkIp9ZicqKpe+4fRPBDqiouFpJE0r4U/II2Rgghg7UbMuGg
	hZ2Ch3JFlaZrVACoJwlzwt+J7O+LNTGnGIA/wE8nHaq16qkONSTPQTJ34ky24FNUHHZHtX5VekE
	sWWDV5QpVxIc3Td2ti5M5I54fF+k4yqyvoQ==
X-Received: by 2002:a05:620a:2548:b0:93a:2d07:142f with SMTP id af79cd13be357-93c43b833c3mr2024214985a.7.1790589999343;
        Mon, 28 Sep 2026 03:06:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2548:b0:93a:2d07:142f with SMTP id af79cd13be357-93c43b833c3mr2024210785a.7.1790589998880;
        Mon, 28 Sep 2026 03:06:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3625ccsm28028826f8f.22.2026.09.28.03.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 03:06:37 -0700 (PDT)
Message-ID: <b08562d9-cb3f-4e91-a20b-794576079708@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:06:35 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/55] target/arm: allow -cpu host with Nitro
Content-Language: en-US
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-16-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926070057.1234-16-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GKrRntYn_hjIqBx-M7NQKw3yYZt7bjrO
X-Proofpoint-GUID: GKrRntYn_hjIqBx-M7NQKw3yYZt7bjrO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX2sgdkMBiyPPg
 RB8ipjIyf3LujyzNfpwySh4FSuhmhBTQfGlid27Mrz/+ApXWMPmvejjwD2DEIeiqRbb/tYRgFwl
 vEdvAIf87RuHUxpkCZYzcA8AKR9oerY=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba3c30 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=ZfbxjF3Mmzy_Fv5pO5cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX7KizTNFWqapB
 k4yrB0lwln07/nULOT2eaUBUZgkx/YyAJDJtkjchlv9BkaQSgB5yNZjzX4WTGFtkt9PGWjfkG8A
 qbmSrttodh5wO31Q2O/QXHQ6P9yY994Nex8bBn5wga9XScUwhCvDdoSWLtIoAiyy+gZqj6zKlsQ
 MvinV673+xjzjtvPQWE41utV4Poq8nojwqnJ2p1cSqXi10lLCuNBSa+AoUwEgENLgqCFlM/G33c
 qhmS5eOGeaRD4BMmDQn4py9NzKBY2morsjV6fhwilGjHVSjokfekmZiwejo42Rw3id6lBIPXqfm
 8PrzdSMXlDxYwaH1YbNw6CFIv7Kd7ji+CPElbvWSKfWpvvjsy/k/l/7gZ0ClTQjrpPMbQqDrUo7
 9cO2r1ma1KgN1VaW/Q+i4otqqtBnqdjAV3LlE7J72qtR+PMy/lJsLg2ENqM6sfDfJkayaS2yo6V
 Oe7VSAiqD3x+2mztPdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280040

On 26/9/26 09:00, Yonggang Luo wrote:
> Register the AArch64 host CPU when CONFIG_NITRO is set, matching
> the existing initfn early-return for nitro_enabled().
> 
> - Add CONFIG_NITRO to the aarch64_cpus host type guard
> - Treat nitro_enabled() like the other accels in realize
> - Mention Nitro in the host-CPU realize error
> - Set host_cpu_probe_failed instead of asserting when only Nitro
>    is compiled in and it is not selected
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   target/arm/cpu.c   | 5 +++--
>   target/arm/cpu64.c | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 090470da40a..c138c4c0587 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1835,8 +1835,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>        * this is the first point where we can report it.
>        */
>       if (cpu->host_cpu_probe_failed) {
> -        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
> -            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
> +        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled() &&
> +            !nitro_enabled()) {
> +            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF, WHPX or Nitro");

if (!hwaccel_enabled()) { "'host' CPU type can only be used with 
hardware accelerator" } ?

>           } else {
>               error_setg(errp, "Failed to retrieve host CPU features");
>           }

