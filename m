Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41024A05D
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786801928; cv=none; b=PVJdZuiBJWwOe8eFnR9V60ig001SGDIaPPkCX5ljPkafP/LPQvY2AtvtPVaqPMYnJN4t8eWDDGzQASrqG9QYBpDbN2DotyLOWxDwVJY5eJoUxuPe2Gq4+lL/gFSsb5n2BkAtnUYagXfow5VMWmauuBrBiIoLqc2lKx4S60hM/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786801928; c=relaxed/simple;
	bh=B7/X2KYMUE01aV7JHsV7nKnrexzgkktFWdlESMPN9EM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bXxvr7wYGoKifPIwZTi1DkWSC1d4DqCasu24UM7FBbftvIfVNFdMHux8VhCBtBFe6L+YOEOwrjYqLfX1nKvaCSDO8bYqaWVxXU0r9asUbtT0XC87s5SEywtMSygoVdV92zIMRumx3IOJMUsi9SeCI+YKQAHNaQx19LpzmbjZW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cbInQVMM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=diGtBBJt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cbInQVMM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="diGtBBJt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FDMFxp1168593
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 13:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=; b=cbInQVMMAUgMhWKz
	iTsnU43F1ROKkPfCcswmSZYpB1+J3W54Kn1UEDs7x6iFWBUSgHhZNHWX5N2tEbsD
	LSIZ41ear+HOvA1U2i9ujNUqd7MDZkB8JruzkMvDeQjuC6CrKjvOmduLlPTz/9sv
	f54M4X/PPoPrylI6HV9Xe93BgnVCmUIr3JOdCJSvY/RbmApqJKHOxk++glzY7vzA
	6eCpHNb82yUKna6K5kwpPECctIfuK2krWe0D/sjXkBRCx9gnmT4ZxBHLDfg6Cuat
	lvKmLYNJx3l+Sm19LYr4gxF/I4nNZMlnPxe1EJrujpwKWQwmmXUeq0ih1j0gbLxJ
	G6QvSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwh2yr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 13:52:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936cadb0e8bso173733585a.0
        for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 06:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786801925; x=1787406725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=;
        b=diGtBBJt5TzV4B9CmxKb1pwKT2GnGjUgELu5TXNuTQszPYto/H3Sl+UDLpACgaAiEf
         Wi5u9pBbrND5SU0REn+SN15PppKhBDeuHfWXg+kx8nhr5DThsZ3nCjDcKEjZ2Z97U3lK
         y06hivULT0yAzk7TDoVE71Ltsa8UlOmyKqjXo5e5IykwfXTOqh8/ZolDfFuOt7k+1CAa
         hsnbPUefeccaEDD39x+pZ7jNLEA13QwIEi9sxnQBakqWAz6ZTBmpLwfxHQU2ntlvy6eG
         eTG7A22xSEuKocpZevbTiOzjcoXbR04AfipiEavfVQ54AWnhRSF2OQonEnqiTuqE9z36
         CewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786801925; x=1787406725;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JWImf+Dhv9RqeqR9XP+j0RUd7qOflO4VcouI/KZrK4=;
        b=SLtWp67Zk6RR+w7Gy5sddu1p4HHUKpNoiYQp35RSkl215Xa+HTq/nSzhmvUokR9I8R
         AI75JpCKbNaMwEfx8aiz6IEmaifNQu4gqytx/bR/j/I4q55HlM9fZiNinPBkTqiuFRrD
         WA3PD4swfRCjZ8zTjTO8lsrh0OgI+FHi8oz3kKA73N520dPkvGV/DVMUYCN7OHF4XfY2
         /ddgDNTm8zluB9M4NeDK9MP455uUwlgJkybJvsD4+L2pjNCAcj7tUJCYKw8nhPSnV7jS
         Wok4rx5GTRDgCROLk0sM4txtsO3iEuOffyzQuIaLwGVPuB2F+8a31Y/vMQjsKaZUCFNY
         BAgw==
X-Forwarded-Encrypted: i=1; AHgh+RpkAZ3n8mdhykx47G8LtTUvFQ6Alu82WVpkL33yesmC2GUpMOAYlHF9k2Bgh30VtmZXEqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQXNqLdMqVFdeJtmxJ6J6ZUsHcpYgvYSsPn3H2Nz+U/j03qcRG
	+JGC9RfWx9WFzCMSwMGqkzYT9xez96lZQ37TGu6woxIoR6OBmG2pU5WWxnwPPKdajL3f2tlyKlW
	s8cy0IlS+SNXIrIy/1f5EtvAQDOUY8F485oLB76UTMJjwNS/634liCYM=
X-Gm-Gg: AR+sD12JcNxyPY1bvKPPxxJn5dbiqX3dUNIBKl2zeE+ohsruTg06dXPsy106dZ3U/j/
	0Htjx9ag2Q4/o3N/hkskVuF54Djltlr2uQ2bW9zNj7jTE1eOqxotRuZ0zLmhsUMk5FwmVSFTzlq
	g5ErFNlTasaqppS6wYLkA0XoSorrBM2snQEVFF4a22Gw+t0qdAxHG7o/388RcjbVXxL1bV5uZru
	xwTCZxHbO/ByeTYp3mKxsYIMqDMZ+ScHjSI2j36v+oqxvtURbnbA1UnalCIa+3q1EZ6aYRHH4+c
	cqMfktB6Q6egEPQRcsea6vl+XMSoLjaGilF+5PvhU5EXXoFBOflEv8cXl0kd7fIeiBaEcKrAdo+
	efERXhfjzUKCfPCBDG3yKRbQbeElhBvQhXXE=
X-Received: by 2002:a05:620a:2889:b0:92e:7cc9:a888 with SMTP id af79cd13be357-936d1fd98c4mr1390222485a.2.1786801924830;
        Sat, 15 Aug 2026 06:52:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2889:b0:92e:7cc9:a888 with SMTP id af79cd13be357-936d1fd98c4mr1390217385a.2.1786801924391;
        Sat, 15 Aug 2026 06:52:04 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f219f7bsm16844631f8f.13.2026.08.15.06.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 06:52:03 -0700 (PDT)
Message-ID: <f5beef33-4e39-4458-8d2d-33663de77849@oss.qualcomm.com>
Date: Sat, 15 Aug 2026 15:52:02 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/cpu: Slightly sanitize CPU API
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
        qemu-riscv@nongnu.org
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KAoHKsEO9k0og4x3YlaUO1THbsNRVFjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX7v0GeXmiKbkD
 BQjIgKPaKgKXeHIn/kJXcv+OAaGP5c3cOC2O1uruVAxjKinXKQpF53sJaXbP7U5YqKJLaDny0Wr
 Gy3sMTBLad1Kc/XVVhJilJQ4yPHUy5KLp0iaFU5SN+L7oMDb3bBW6ZVUCoAW8lng22VC9hL3C9q
 b8ohkUTdShO0ls6b6JkqjMWoih1yrnXbM9tzAnMeM1JwPpZXX5awJXlO4VorP5PKxlKaA0ZHHiA
 aKELQgVQ7CG7dlVHpDD+224kqy/oaYEKALWGqaIKfQo6eTCT7VHI40DQ8igOK/+YvoQfb5m9RVi
 9uflNYHe8CB1FPDrToeL27y4cKT9xx8TWGORUp6uGij1Xn+OLNYLXK5/ab83NFDOzczg4En07q/
 +o/9dCxQMf1C5psoaKoPuwiVEbJDJmKkIDL0MmG8mYxHcyPt2Nh9na4fxEMUkXV363MaaSf4OL8
 17vq0N35vfKczTOCpvA==
X-Proofpoint-GUID: KAoHKsEO9k0og4x3YlaUO1THbsNRVFjj
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a806f05 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Ql7IHVpF8h-uniIvIrkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEwMCBTYWx0ZWRfX2agst7P23hsH
 ieZdBOwQJlhM3bInLlhTRJ25486XKilBUC4l4gNR/9ROr/XLm4hQ1FBuJSktRjIEcEVH1vmoPBY
 uQ6danWu+ObkDxhzU6wIyiTOZB7a/Wk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150100

On 11/8/26 20:34, Philippe Mathieu-DaudÃ© wrote:
> API cleanups, mostly removing system-specific code out of
> cpu-common.c. Code churn renaming functions, in the hope
> to make things a bit simpler to understand.
> 
> Small patch set extracted from a series clarifying CPU /
> accel synchronization, itself a preliminary work to introduce
> split acceleration, eventually.
> 
> Philippe Mathieu-Daudé (8):
>    hw/cpu: Correct CPU_GET_CLASS() comment
>    hw/cpu: Include missing 'qemu/accel.h' header
>    hw/cpu: Move internal declarations to new 'cpu-internal.h' header
>    hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
>    hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
>    hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
>    hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
>    hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c

Series queued.
