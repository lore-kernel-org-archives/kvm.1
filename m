Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC416A956
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160137; cv=none; b=el0mTWETJ7JOmtqyMcHXLh4nuzKyDrkTJZS5bbxIZFZM/AIdHxRcNptCQAo2ZxFo2S+c6jhX97/wV9wbcJQgcS4D2KnNMk5yVmR3KvAfXMU9vlp6Amr4tptZ+5HFAr7jhDa/f1PmCJJ6GqZ8cMZU9CY3haHCRi76kmrzOctAU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160137; c=relaxed/simple;
	bh=IFzL12TFCTlw5ExHOTsYYWhPgNIhCaregt+isgPqhsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQCH/49tULtJ0YED2gMbqi16KVM9tL3gVeuaGboV2wVIfskeURTNqTqaReT1Dn8gaGl5uaEZ4Ked5eOHgvmY7fP9KFDznzJGFBqaovCzXUURewDznZ4Pg+RyIAWIvlTVwGpqBo1zgZzAySx2FXPRqMiR/sKDJ1ap0AN3oDfBmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTmUZis8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZBSewjV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTmUZis8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZBSewjV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GPD43712069
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=; b=VTmUZis8tWDhTt8U
	VeZckeFr8v5SnZZfR+NBoi8gkkReLBu+i6IXrZd3+FA7e5Esb/Dq2hdwg68BNa8l
	5Z1ujChsqvbIHsYUnI5JHvZsuxkuvjJnWGT/WcZ4hmt+Zip87kzKRdFiwqMJVpOX
	GHrZb/WUDTVdJv6VIJJUL0W2FZMZRiSWl5hUhsqqJ75o6/EUwCDBcVy2Y7G/Q4Ln
	eZmuuwyAIDvuU6GndY0e/8RYDeuDI5bD0y1kaw97egMBzsCIP2UzcL1Jk6Il9Hlt
	4pECnA5LhpiKdVD95LOqVYhLLPKkJzXj/nuiMV+7zOyVOYz/Bm1MJMhabHCpqsnD
	wLrg7Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ua0rv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 06:42:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175b7946d5so63941271cf.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781160135; x=1781764935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=;
        b=aZBSewjV4A0N+juoAVPukCmdNn7f78Dbp8RGhCxFplWhEcL9gdl73URcfN4oV9d+Jw
         5DVXjFVbPsgRBqyZxtU9a4p+V8PU7R8mgJyzdqxnAGnQsrXH1YBIJX3XuYRK2AewJey5
         pMWidx3gMwRPMXygR32Qc22/FTx8iXajrlx1V6VwM75cFYajK1+FkutuNECcMngvRhVn
         T49jy3WzeJ1ncsNCUBVdDRDatF0doFiOUwxcat6o61OhJh3ykQvOCDxNXf07I0rMg8RT
         5pbXqVW7ktp1i1wU+W5PskulH7Wq3l7+H7JgX9kItxlclWhe8x+ObF8B17a63WwH8E9W
         Hf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160135; x=1781764935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YECmlo7aJiRbP47VD/l+b+/MFnM13XFMeUDH51iOGxE=;
        b=mG6c1+s9G8wPTJLovpLylAPAMYym4AmYdg33X1rbqJsRjBbhZ/LN6DacvVaLMv/gXq
         YH6XIYKEmWxNxGNjpJmky7oOr2OsBc5Nhiis8wCzS1FUMrVrVkKhP3Y50Kw7geKrvWKe
         oeol4a6uxmzxLDjbjlEFEcepMCD5pkrGC/a75C3nR5Nr7T2w1bV5QSQXOaPXJWGdj6Uf
         UOOxC7Xekb0lwbLkwjFLLBz+hkn4a1mbQKGGPm1nHkPpDiwkRhHd8+Z13sm/Mc7xNf2M
         T5o52z5rJ7i2hwsf7CxOj2SKKUFC/KKZz3oc/2mPD7+FFkIsEGvRiWwkT2r5TalvCYUZ
         8vKg==
X-Forwarded-Encrypted: i=1; AFNElJ+aUVn4I55nE3UqVge8Ji9UsEKrY6SUBb7jTOz71Y8HWXtQMgBlZT7wvxJbZsQPEJIve4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08Ad1yXyVvn0iYK25KLvyml5equXdVUBhh5TyDpcrIwve3BqV
	HbQgw6Y9XYIEeP7ejAuum24xlubn9yEnjTnos0PYUW41x2JfwnqbHm4BqpKsRXbNuMFXWB03oS1
	2iqBLbPWFOfv5hajyfvwIi0CJH6wunHLZYmjId6n7idpIK+CHMfEceqCkF5TOcic=
X-Gm-Gg: Acq92OF6PwwfERf78k2lSAF72EfckBGcRqliGEtFNw2ChSgH7dso45TEoDM9xTzIHKL
	bpow/kpWnGlER2zpLsPoV3jm4IBjM+OiSPSdoi258pVReo9Fpv8AF6exuyRPdy/CpvfCX4BmIgF
	1uCeENGE2XEJ87ljfnVRYdcZacnvKC+Tt8nmcmea4kACGwOdk14/bWASI4n0bVOoMu1d9VhN1ep
	15PoPhMVKNPoDdat29avE+D1nCbSW8FSC4RtmYGtng06xSGcjIrbq5M17SlPJk91F5XxKtam5bZ
	ywgY4WSRuS8mLDjm5AGbghS7D2yRhJgJHuWZ3GhZp/U3/3MNSw0pZGHY2Ln44rhAio4ko03pZNw
	DCB3IS3ICE1m16gmXHGxGeCqKSpLLFSfMX2+a9eInsM8LL/Ly0fY54hTEy2njUc6FmrwzX7p90X
	sJRB+FoQ==
X-Received: by 2002:a05:622a:6:b0:517:899b:7f76 with SMTP id d75a77b69052e-517ee1d5fa6mr22342371cf.35.1781160135072;
        Wed, 10 Jun 2026 23:42:15 -0700 (PDT)
X-Received: by 2002:a05:622a:6:b0:517:899b:7f76 with SMTP id d75a77b69052e-517ee1d5fa6mr22342181cf.35.1781160134634;
        Wed, 10 Jun 2026 23:42:14 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65868049sm10401516a12.24.2026.06.10.23.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 23:42:12 -0700 (PDT)
Message-ID: <2610e4bd-7ddc-4880-808d-3f55bb166938@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:42:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ppc/pnv: Remove Power8E and Power8NVL spapr cores
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-4-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXxH4EFHM7p/su
 rJuFozShRUO0STXhcceKOoD3er1pujgALX8q0GAjwe5w7jns4+j4wC3xxzP6WU2L7FOXBz5Kzev
 FY7Kt45POJtQVFTMfXchm/Qe6NErOto=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a58c7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VnNF1IyMAAAA:8 a=-EoAAwLr4A5xMGHcZ-0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfX7W7y2GW1X5I7
 afyiA/BEGKoUisEmnX2hE4iGqPdh4DhQ8p5Om1xBZeJAUA7PBeog+FczufHjiDyq0an5n2wtULM
 FAZu/7GJg7O28rlyrA8KfN2jXd+N2Bkd2uNkiYpUybmi5zTZjuf2r5I/MUdX5/ZlK7EOkgu75CD
 QXoKX8WBPt+ToqNVj3d+9TiJtnZ42G1ydGt1Z0jK7B/6OL/YK9fE4un3T0/8eZ6lJ5sVlsO2KyQ
 JKyhsJUhijKC96C/OHblPOHkYtw6ln069u7GQdeFOocae9alslUhCGoENQSIdMc4O9mixT2l8dw
 y0BegR54SyfFGwadC2UYGXhX7kNY1//4Dqm8iixgC30waa0cUYiFj3hN1guY0Vd4us4Q5R9cLtc
 MCuDSUV/m8RuvgmzIXnXGMjw85xofN3peHfoUtjgTsef1ef7ZW/hKOoHwT1kroLUhGAK+UuugSM
 W3bXjqSw+bhnASVgEZQ==
X-Proofpoint-GUID: xTzzC-mVu_pDuO8FmK09gh7HD5kSDErR
X-Proofpoint-ORIG-GUID: xTzzC-mVu_pDuO8FmK09gh7HD5kSDErR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110063

On 10/6/26 11:07, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/pseries.rst | 2 +-
>   hw/ppc/spapr_cpu_core.c     | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)

Squash with following?

