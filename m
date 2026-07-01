Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB993E3DBE
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918218; cv=none; b=SkoDarQPRnN2n+V/ZPBa1UuQwDQwoqdF5aX0I2iSTeCfwVt11BqkgUL3vA+Y8FQOAzPM+GObdxg0ggfG59tfznG4Wz8Nte20VjdiIOhqcNyTuEW6DlGVEgmuVG+vPAmGG23KZRgugvGGQobxGZ9Vg9ElgRAGK8ORbkYSzXYuJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918218; c=relaxed/simple;
	bh=mPa032KjVqhep+LmasmgeIXAJMos05zkPxFZEAw3UIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUbn55luPAcNFikpIIUtzWVNv2vHEC9tGeTloc4XjnS7eeIe1Ld2dNa9pxDrWWlP9uwivJ6HkdjDm3kaYMM+P5rZAeAtKfq1tQBljR35D3iuyBuJz3hdQjNFXzhNdODeLewyi77VVmNwI8vi8XtgVnjgNrqgrnbz679jh2LQbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PM9TA8JP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iXVynEl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PM9TA8JP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iXVynEl5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8wJM753572
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 15:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PMlxy+ySrUpTNuoFj21YmLboTEdtjJH/cjm/SS08cO4=; b=PM9TA8JPXdauBw2F
	iXt0L+44k6OnEzA4NKbnzVJMPoAUtyalWHrq5uQU0lfNdcp0SppnW2HpEkhSg7zk
	4FPVx3AtU4h5ZZiq6fGCz9OjK0mqEWjmCJFwTYiuhrEc3EqmOUcwbZUxqIhjqFDQ
	rgZV4KgXN+fsXU7+YytOCDUv5aVg+L67+j/K6TeH5ZLFLfOxtVPBGEUyrO6iOYQY
	jElbu30jtIBxxC5JGSpUXm0nRQZ4V6F5BNbYLsEdmjj3lt/kYwuKzlFjn/HEcelt
	kc450xgQo9AlbybbZfvW9lUN7v0GhXKaQPNvUGonpiopaAoRBiJWdJJ0hUzVOaka
	sEJhfg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy3cja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 15:03:34 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9e741693bso574859a34.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782918213; x=1783523013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMlxy+ySrUpTNuoFj21YmLboTEdtjJH/cjm/SS08cO4=;
        b=iXVynEl5U+oRsJZJgomfhMRG5sCunQM9du3jyTsya5+wDD3ihTzWIzoivV+XtfsWp3
         aYnpXD95YLsWetVRfjElF2mEQX8ge4qkcR6lr3g1TCvia2/WEiIc+zjU5zGaeeTnDIVB
         lK0PFeyq69TMD6s8sSpF+vmydgEiEzvftksA1DyhfnvWU8fvr6wnsl0V08vW05+Lqr0m
         RC2N3qMVsrlrFnIyB1AHdkS2txMVvuN59rpy9ONkBoB1pbX4dOdS4M2LI1Js+Svni0Jc
         PKPbu7IzPOMYn9dIjL6Lnf+KSP+gFQvWVAcSJ7IMXwifY4ZB6Oeri6Jn4jPjSz6CZRe2
         uQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918213; x=1783523013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMlxy+ySrUpTNuoFj21YmLboTEdtjJH/cjm/SS08cO4=;
        b=pFMKEm8yWhm9djyDmq7KHDalWyYGx6i1e8nxik3bwXaU9eBqy7uvKS65pUL5Gwqk15
         ckjqWmejT6apWtzQP48aAOtkduI/WqPo7v+98c1xAm83qz0cMsvjgarbcNuubJ4i60si
         t+b+XO9ic1aUfUJHue1+yPBfjLCTK+rbisul7y4MURphADoJFUH6FdD9RbWc956fi+3c
         0K8OxGhJdxFfYkBe7lD1UElFuKGXY3pPiKcjX7l/tEoAcq3QrBqreZNqSi71nXNKd+JY
         fLOcjObBkmnny+Z5nYohKIYS8D+TUvnxE7BrhCb089oap1QtzLeJJLDdtiyhxPm2lt7I
         SyfA==
X-Gm-Message-State: AOJu0YyxnOS9mP2cyMhb6rnJBQegH6y4iHhIXzTDz1rvngvhpMNCJeI5
	eRuSotaCm5yVtkzLU8ECJtPxUiFVJTG0gBtnVXYeNfOtoMWphJoAxBNMdXBd+mOxeaQw0kv5IH6
	3Dzv9mIjvksAj2ChKFMkzQT7LrGmxeQTnx4+22AKoFBEZRymeKKVfsZU=
X-Gm-Gg: AfdE7cn52WoQIW0oV7atzCFk53YkvLjJo+G/l3kGD61o+B6/jlxAVccUNJDCPGsO4U4
	GExb+xpohnEUtKnv5AY0LeQJiwpNrPIdgBX2fuVfDtsCAFD/Ybkl8kq8O6K9g0hRPpkHHVek5uS
	hMqfOJzLLRbykLyLtRhn5JHjb2WMth3pyj+F6r1637HCk0XOvWwokMlQz8XHZd5VJO1O3wzHmk2
	mquVNUZcpRh1Kb+xUtZMzaJzp2r3Wxd/SSOpxGGTIe2A2s/HsrcjtY3hanpf0ECUsgkEcQhF7ih
	qIuxBg4rf52LUbN+TpX3b3klnMaA6rZpPUjoj37aWsOf+tkPVF1Cugr/tYUErlkjhPG4PsQ/jDf
	aeI5KvjybKM3Ai32de03jxvNkwGPrSbrlC+Oz0MEZfD7hC449LN1sbPx32ZITOA==
X-Received: by 2002:a05:6830:dc3:b0:7dc:c4ae:a689 with SMTP id 46e09a7af769-7eb48ab9e3fmr979314a34.2.1782918213186;
        Wed, 01 Jul 2026 08:03:33 -0700 (PDT)
X-Received: by 2002:a05:6830:dc3:b0:7dc:c4ae:a689 with SMTP id 46e09a7af769-7eb48ab9e3fmr979230a34.2.1782918212633;
        Wed, 01 Jul 2026 08:03:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6988270903fsm2379453a12.11.2026.07.01.08.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:03:30 -0700 (PDT)
Message-ID: <3cc822f4-ee86-447b-80d4-d0e38816ce3d@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:03:29 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] KVM: x86/xen: Consolidate checks on Xen vCPU ID
 for singleshot timer hypercalls
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com,
        syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20260630225619.511632-1-seanjc@google.com>
 <20260630225619.511632-6-seanjc@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630225619.511632-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qAXvevRM5LHHBNoebfSNBci3dti6YM7M
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a452c46 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pBOR-ozoAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=exR_2C3_D3Cxa9Nl7fQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX31PM3tBKxHNU
 hcHU/sAscML9h1FRDl0lDZ3jr42irKBqG+BnnHmskv+/X7uR/DbCo3/YxhikA3/D2BqsBvgRy+J
 4GMC+f1R18mx8tN5jtUixC8NXLPX5we2UKfO4CwxXVU/PQUIhg6OXroLs8JQeszJnVuysSQNWIH
 lrknP0aP2Wp+JhmVpunx6VjSAKyQtUmlPFJa/zX+uyhJgH9kGD2vPTcsUsGR6mzR8GaPNLg9z7i
 rU5w0lky4UbJOlulv8tOYOQP1eyp/Vdx8eY7uhhrfcXgWcNf5jKZpBOKyD5I22S5IbcgYfmanaM
 WjjB9h3+St5XId5PSZ74yILh3FKlZdnRhO9XZWCnN+gBz4uTH4MR5MMk3PUCs/kbXC3fwyBLcDx
 yXlRZndGGWianY09PGXLuetfiPYr1H0mTdqWVzlrLfMHUFZCMXMS8YwH3PQLkj0nZR0SjW54fDr
 5VLL/X1kFkuj/HeFscA==
X-Proofpoint-ORIG-GUID: qAXvevRM5LHHBNoebfSNBci3dti6YM7M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfXyJGcigfSJY2N
 cy5r/EDnkOVfuZeI/XOsf877AZ0zLt+OV9aJqNS7FoVSptannpto6MB6EZ60ip0pPXh/ugqW8Q6
 nvAuraQ/Xm/NmnGaqP/P5QKgzeR6uB8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010159

On 1/7/26 00:56, Sean Christopherson wrote:
> Hoist the checks on the Xen vCPU ID when handling set_singleshot_timer and
> stop_singleshot_timer hypercalls out of their individual if-statements,
> so that both checks on the ID are in common code.  kvm_xen_hcall_vcpu_op()
> is already doubly committed to handling only singleshot timer hypercalls,
> and even if that were to change in the future, the function could simply
> be renamed and turned into a helper specifically for timer hypercalls.
> 
> Opportunistically add a comment to explain why the check exists; the code
> looks rather nonsensical without the knowledge that @vcpu_id is a common
> param for all per-vCPU hypercalls.
> 
> No functional change intended.
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/xen.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
