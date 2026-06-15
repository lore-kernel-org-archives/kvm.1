Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841C3BBFDC
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514299; cv=none; b=LstHw1d6rBqpuGDuVCaEzqh1fHRDPL0sQkQrI1HR90BvzsY/OZUbqf/B6fs227uJMzSE78kSAar20VzE/F1f9dPX/PS6IgsGondlgEAaKaZhpQuSvnTsZG3TTIYYJA+47rOPeRF41DWYVHT0Rwk5tf5ulRuZn6o8zDc7q1prb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514299; c=relaxed/simple;
	bh=Fo7sOFKQ/9os1acoGzbhjwCP08/fnhh0SDVvaAIbpg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7sQLvfWDIUrISGp2HFpvbshIbd1qNHgcy0v+V+PtiYefwMtQ4Q50zvCEuwgKzjqcxtoANHVKI+XcPk1sG6TkjGnErjjzEdvB9SbCul38kw9RVpyPHRLcAMjrF0WyKy3A37fj00B/WzbOjdWgBiysc+HsNkbbGFpoAMgOlMxde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxhZS3kd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BJRtlmXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxhZS3kd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BJRtlmXU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6KZCq3709647
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=; b=nxhZS3kdLd42YA4a
	lQ7rnMrfEAsEyPnHnAMlp+Neo19oqOlE9ijTCrMz63/co+nExjV+b/M5Q5RP/QU0
	mF4AWdRvH05zg23A38DbqU5kGDYT4zih8Ue5JS5n2qddREZ8seXk5JJMQ4J4ppYO
	URiifgFMZeyFUWmVhqqTlrh7PyHJ866y97RCGAWsGJg7bWq9vC/iW2qyBMuhOkHU
	n33WF5nG+7NVtmvSECPh2UHl/Ez47/Sgq/SGlwtaYFsL1b1MQS/y1Srenh57+UUf
	Gyl+Fo3jKq3qOuVeh4TAsPNiRzQI6NujIKSDEfPb8unjrqsazbUBuMUK8QU+n/h8
	erXrEQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery956k2w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:04:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9181f3cc5ecso341043985a.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781514296; x=1782119096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=;
        b=BJRtlmXUOzGKncYWD3E5L9ALao0UgB6ndyGaLQ5uRZVxt/RzxNmDHfNbrqyi4qWe0M
         WpTp6I8N2FN1lxb5Dav7mQhYz+TUPg91WsXGUVcP2DKt4Z4+30fp2ML+9qCw/QglHd5W
         UdWHnNDWiRraAm+xw18kJpB0E1j7VlnbcNO0A5uDb3KmJ448VjDrMbIq9wZidPG5Uth8
         tq5fJtwWsaSuqxqNVClGCw1VZkewkr4QyuJP+m1PdO/axRNq0s5/Jeh9HCuEqTpKCq05
         W5XBfJ5CfG5RqWNO/xTkks6/+rKQVjQqX6tWlLle+8qQy0H04oPGnm1KAU/ZDCcwkML4
         0iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781514296; x=1782119096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jmoc2bqCyy/BgjcOTiLr/yZpyh6nOwhx0eAq/0XyEhs=;
        b=ENkzX9+bwry1IvN4Pf/tbvkRDzf2fbhuecWF5qFyv7JkMN3xs5InIzUAOiOK34X+m/
         oq8GhioK0J2E/t+C3VzWt0afafhlXWVVA01njJZPhBlSGZKvjo3UnXYaux1F1e/2qZ3i
         pE0H6ywBtohaLbfkQrGCyWBVUG0noG4tdoDvVSgkIZrx2bZgjeRjs+XLP8Jf42muojws
         bMjg6MYNwz9XXwl0FzsyNQHlbNr0oEBa+2COoGvk1QXUekw38ZjpgrOQEOqG0BWwr71F
         ZoE+/BVUWb2prjG01w6ZC+120bFSmXdWrObjZnm0MN5+GuAYGibPsawFcWZYwcwFacfd
         Yolg==
X-Forwarded-Encrypted: i=1; AFNElJ8+AB3NK+9QVEgQzIGPy3QWNoVhpB8IwcDTBCD20h3YIixBNbue0CydG0gakWkzlS4S8vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXeL6TRkLusWOMsiKcuvqbw7UtGNJWcAYoPsm+S/1JHlyfKtc6
	r1aF3yNGOvJDt83I8wqTFK1ooQ5loOdAlmynUe6FPTozERb0R/OYdxJZLQWSFuRx19SBEc8vIyM
	6ztY2BURy4yT2pYVqoUeKmgVEeV4EGO9Y7/UFT0wiBUBYGBR3EV5yBPE=
X-Gm-Gg: Acq92OF66EGcwbaqzHpWUpmOAF8qI5KGUeuJaIZhSlYc/vrX6ZXQq17nEUqv+7f4A1K
	hQ5DQSxYJYoqlZsqsBwOG3AdsgfA4Jd4jahdx5txhw4uYMZSQiIF6vOVqbdz3Q32z/vPAimmST1
	8DTN/kJYPPUEPq1PBOnW+KkShGRw5bS+k68fj6rKfipBWxZ8D60oJCvMVVtUNuONauk0OjnmVzO
	gJV9lO9+Md1n5g6FUM7T0F6CGy4Bd1wPYPnoy/J7Tkq+20UPrR7p5Zz0Uo7dJRiFvoexvWwbmpg
	nMQtS6P8SrTuQ05DI93jqpgJrOqAbzBpjMz0DWI7/PB4rnumXIjOjHanK+iIVja8n7029l5H9Ka
	S5RVyS2Qwtc5Yj7Ra3fUQXv6Wp2SQUYeZk8XhKpPmij1Kv+nzR3OrvsoWaibk1i2qRf22FSup
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id af79cd13be357-91619eff271mr1687547985a.21.1781514296449;
        Mon, 15 Jun 2026 02:04:56 -0700 (PDT)
X-Received: by 2002:a05:620a:450c:b0:916:1765:b774 with SMTP id af79cd13be357-91619eff271mr1687545585a.21.1781514296075;
        Mon, 15 Jun 2026 02:04:56 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937948dde4sm3119467a12.20.2026.06.15.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:04:55 -0700 (PDT)
Message-ID: <8e12b7c9-32e9-42d9-a4bf-107a0bfb1a3c@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 11:04:54 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/kvm: Fix CET SSP MSR read feature check
Content-Language: en-US
To: Saul Freedman <fre3dm4n@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org,
        qemu-stable@nongnu.org
References: <20260615033338.1563854-1-fre3dm4n@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260615033338.1563854-1-fre3dm4n@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zCKLkDdUUtlbI7vMklip6lMwnyT_pjj5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NSBTYWx0ZWRfXyMsQZR9AF9kF
 fak0d4Me2Xi3/XYbBBAfd+oW9ep4EiTTUrFqUWgLNK5+KG2miorvN+/UEx2MW3QyUJKHxPk72nw
 RbBJrznH5Nibe/Y1Xz0vBUKjJbtwhz0=
X-Proofpoint-GUID: zCKLkDdUUtlbI7vMklip6lMwnyT_pjj5
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2fc039 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=U4MUTAyXVA4O6JjbmIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NSBTYWx0ZWRfX21NBawt+5L4K
 btnSADcdLR/ALT5ChdjNbiQai5LmB/o5pc/ohXVV/T+kas4xH33ECovKda+iZEVzYm3FN4ERRKV
 uobi/JZCb6nskcSlTxeOWouN1xe/EZoT5ErFgMKcvpnBxyMp+ptEHLRZmADgo0ogE8KWI+0jKDk
 SlXUgSmCNBTyFS3SUHV/IsuazjKhSzolzzbsLsKZrBZFRKYlJpfqAgs9svGywos6DlMUiP/A//m
 1W0HoHnJhV1X8gOF/JOx1Q2qXtl0Ybho38gGs7c3rRIkQLsPTJhnIfhkYPeYejfdG7X1euv9g6N
 u/Cw18G+yN+53qkFb9Taq53jihkXGDlGmnKUV9WJYxXwWRHGrrRW5dZ6aqo6B+wM5Lfs0niSFNP
 F0wA7EWsC3P/3C3Gtt4542O/39IEWgxvoFLpCNQWHUqnSFl4SiuUFUknVJVA2xMi8z4XY5gpZMU
 GsuqQ2mcmJJWHtne4CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150095

On 15/6/26 05:33, Saul Freedman wrote:
> kvm_get_msrs() adds U_CET and S_CET when CET shadow stacks or IBT are
> enabled, but it checks FEAT_7_0_EDX with the ECX-defined
> CPUID_7_0_ECX_CET_SHSTK bit before adding the PL0-PL3 SSP MSRs.
> 
> CPUID_7_0_ECX_CET_SHSTK belongs to FEAT_7_0_ECX. The current check
> therefore skips MSR_IA32_PL0_SSP through MSR_IA32_PL3_SSP even when
> guest shadow stacks are enabled.
> 
> kvm_put_msrs() already uses FEAT_7_0_ECX for the same shadow-stack
> condition. Use the same feature word in kvm_get_msrs() so QEMU does
> not restore CET enablement with stale or zero SSP values.
> 
> Fixes: b6f85c5e4527 ("i386/kvm: Add save/restore support for CET MSRs")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
> ---
>   target/i386/kvm/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e35288..3f4a241 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5021,7 +5021,7 @@ static int kvm_get_msrs(X86CPU *cpu)
>           kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
>           kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
>   
> -        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_ECX_CET_SHSTK) {
> +        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
>               kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
>               kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
>               kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);

I note this huge function could be made more readable using
various has_feature booleans, such:

   bool has_cet_shstk = env->features[FEAT_7_0_EDX]
                        & CPUID_7_0_ECX_CET_SHSTK;
   if (has_cet_shstk || ...) {

Anyhow this patch looks correct, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

