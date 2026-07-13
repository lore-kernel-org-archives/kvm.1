Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B8384CD8
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941172; cv=none; b=gE6FEacixbfzhfmsGlAnkB6rOXNoSgleo9lTuo2svafSmohG24wFjtnd3d6f9f4OumUZsq8Tnfe2pfBTiIglbKjYO9LdhfsRDuCmSIZP+Ln4yKrz3e3nB9LmtRmfZevl0NqDtEkCM6NULZxYt1/RC29ucqTbt8ZK0YgVuPaKi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941172; c=relaxed/simple;
	bh=gY0iV1TXluO8rJQJQUReFBeoQb72xIewS14O56S838Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOSCWHz0S2eEnY1PXtGALnvxH6mFkzX2U4bTNpRwDZlE+pqBm9DGUq7Q+uhNovSM1vSMeracgKjhvnwUeUMfrotvE/0gVw1hv6XUpNcyfIWSY+eB3X9fFh6ChHnwqfrLSreYIrXbuQxBTvRQSnv29u3snYga3LcV1qD6WPLMf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NfPGmmLu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CyDq7OO6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NfPGmmLu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CyDq7OO6"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D9dULS952899
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=; b=NfPGmmLuQecF+Ihc
	NPW8D3RkCMUN34Gi83IF95YT1JtRl7pEPbBnUktLR8ijsVvcsjH2Iq5T+ybIcN9t
	kr5cBGWCwXGGTR0kQ822toW34tlRQcwiLDqWycmU16wmS/4eVHpFpXNAY/LI0Kmy
	Aw7MCBs9/kipKuGKhP/XbdA5ctVT6dTImPfrjFkp48ms/ZEh372naAbFqq1zE5Zv
	wDs3GTmXWB2BYLWG1TTLY8H/e5TWwBiutA6vHClPajZyquj44eo1kNRsXDyeIXSt
	FP+LhDslpfkcmhTvir5L8AXSoWXZGd+gcAzuLJesHRMSbUPab+jPOdd7b2Wz506d
	HZscRA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3ga85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:12:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0199faafso34208991cf.3
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783941170; x=1784545970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=;
        b=CyDq7OO6vSJmTSFVRvi4HpX8zHI5c45XJdrEdg0x/zBuKuI8ZNQhonuNvuoru/z62/
         bDPLKgG1mSgnbt4Fho26HKl+Fp/STW1imdNtpqeGfhslxCPa9GedKEFQt+CO4XEv6sK7
         oXSGyzj9rMLxqWAjGJ+v92KbP5y4YnjN4opnkyRCc+zz7r85CIkGB4/7B17K0LtpL2j4
         DiEFHbqDz9IAw/zdsIudYcNMs0mgBUgnUy9iab4dIVyHHr6Js0Ve+34RYe0ghe3F1fpw
         6Lhcjg//R2LIhT7wnxolGKycZRl40Ob24xIuI2AGjfPLdcIf64xMtBx9M7SL7+Y65/Vo
         XROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783941170; x=1784545970;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XsYLOkFKPevp72S9kIelJJc5OWBLLgZB83vPXvaDng=;
        b=hEfHvrY+tYhujyrTekepaPu4kHIlbQLPNfloYYP+kBkaNRAnR76+xBQ3TV8/ecwHHK
         y2IpxkGsmQlailP8Z+21fKVXo1EdTuJYX0BbpyvEn1pMPku/nk0TMqznyLGTLk1J7Fbs
         Ts3rCvCP/A2vhyujUJwAcs/DdqwIS/UqFpZ422untY0MgQclJ9OcBUqOuTlw+tkCKT+y
         eGZuV8OWfvVi7KqDqIVGgjEZ+YZgb4cn9yCOrYQBuS3mlxcbmNKnzb+tnPj6ywaAgZd4
         y/Fn+eV9RexZP7Cjz+u5Xt33cQdxz2aTz3ErkoSA2a+EHhO61aKRRfpS/O7W1eBnny27
         tn4A==
X-Forwarded-Encrypted: i=1; AHgh+RrsGreOdpPPWPuz/wKNGqpW512e8Pd1AONcYszYR6LKy9a/XTU3HycvvRsQHeZXaFbtcAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxppM0Dhu6aHjP5qslU1bHMksbrFuHGyN78NK9hG43oF9WX5U4a
	uWIc4wyfoHFeEYKoeybWD2N+aBUnWkJY9Z0KfndeEVLBZBdPFrxYdipq5OFG3iiwvmtNrUjceFi
	2f3KjHRIqKEQILUtAv1BLSSTkeo3QhKPS/B7vY48e2qHunWzupYRfi8UmzETFILc=
X-Gm-Gg: AfdE7cnV03ZasF+tCHPAqncUsX707HsmkDPi94TeRRKK6AznL5eGNigmUlNbhvgB4Ao
	85kY7XJ0A6iMzo0fcd2i1O0ZaUtn54F2k1TJKei7oam0UF9abRG5fUkBinj5NGEFcJ06ELw9ICa
	qPKy3AdL2ygZjnTn3gFkNBPIZQk1npzqk6Ubkio9ydWLChV7rKUdxTCxMolRkY0UXr+TxrNlVpB
	2egghTxQStioWMiu0UrOnKpxaWrmL7qQxRb6ocDLd+ZdS50BxqWrYWnFSD49i6fJPntOyMB+KLm
	iy3WtVlpA9G0TftDkzZnLLvcz4XZg9s+DKMLF/ce0isWS79p8sVT04/3QuBXr5TvInH4JuOcJEg
	nwVo4SxJ9tBpZnS4qdRF0xnr+zTR5BhAd3ghNbSRDo++REKvak4L1JKv+e3YRLQ==
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id d75a77b69052e-51cbf0468ccmr92571851cf.4.1783941169677;
        Mon, 13 Jul 2026 04:12:49 -0700 (PDT)
X-Received: by 2002:ac8:7f8c:0:b0:51c:135a:5b49 with SMTP id d75a77b69052e-51cbf0468ccmr92571541cf.4.1783941169191;
        Mon, 13 Jul 2026 04:12:49 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccaf1sm632165655e9.2.2026.07.13.04.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 04:12:48 -0700 (PDT)
Message-ID: <61fcf3c5-6233-4100-96b3-00e8b0732893@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:12:47 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i386/tdx: fix uninitialized variable warning in
 tdx_check_features
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706-fix-v1-1-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2RzptcYnBSdbv2_mypaFcc-Iv1qMm_5j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfX6tsRY99p9bTo
 1upwwOs0MKWCxOjJP2VRwRGMFQ2/e4suegPAV2pvyoIohyDLOxgnwiWpisxKIhqr9shh6We+lNw
 ABieQYtCHDfFN/76hJE2Qb4v5zvfjwQ=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a54c832 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNyBTYWx0ZWRfXzcevTevxF9dn
 6RUIB1OAdyUk8pgwKD/pdj6agOITndDqjcfk75jaTrliRz6ozkX5i9UjDZ39E3aki/7n0kne3fM
 RddPhrRxfFRt372LVTlZlX1VKigr9V3fnm6xmkH8xM/6EogKk2Q8i9aunmtnXqEqiiLnCLFjvjh
 1GDKCaakZEerTUm6tSbEdQUtf4lSqc0EuUI9KWnjoaO7BjQNMOmDGV2PcoKzl16bhvTAvVTO9ya
 BQeRiPAXdx8jfXbahZcdKsI7Sc+1dLlibNMbH2+4k3NdNt2LeobC2ZRDpeu5P/QuuQmWWwwg/kJ
 WjDh/1JEfcBEPqyT8fXvOR58fABz0Qzt9JMitDVk+TZycAjM6JsULBJfptmHF8B4auiv5ijMoPg
 Gd4NRpcLVpCjl9oelnOH6iDxEWawzN1zVpuoJ0Y4tSNn4I83+uu2gE6UKQQPmLomKMrcXzDKHhn
 rcdoWJ9aUBc+C9+ttqA==
X-Proofpoint-GUID: 2RzptcYnBSdbv2_mypaFcc-Iv1qMm_5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130117

On 6/7/26 14:53, Marc-AndrÃ© Lureau wrote:
> tdx_fetch_cpuid() only sets the output ret parameter on the error
> path. GCC cannot prove that r is always initialized before use in
> the caller, triggering -Werror=maybe-uninitialized.
> 
> Initialize r to -1 to silence the warning.
> 
> Fixes: 228e40f33048 ("i386/tdx: Fetch and validate CPUID of TD guest")
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/kvm/tdx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index c9c3b05d5fe..8294dbde3aa 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -887,7 +887,7 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>       FeatureWordInfo *wi;
>       FeatureWord w;
>       bool mismatch = false;
> -    int r;
> +    int r = -1;
>   
>       fetch_cpuid = tdx_fetch_cpuid(cs, &r);
>       if (!fetch_cpuid) {

Alternatively, 'return -1;' here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

