Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522643DE425
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918288; cv=none; b=MwdmEMlL2ARNJAtDB66TOAJEwEzXNccpTyXFSTDLlIWnE87ITk0Yq+dBdcRbi6T5uvL16YFtZJwVSloV8WBA32TF+d7uY2w+zMWv1m4PQh07Q7jX4Y7cw+i0VUZ5da5Gc+hCOB9Oel3Oq71b3a/1YvH34WOOnod6gMmoBWeuOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918288; c=relaxed/simple;
	bh=qmDAu7n+aXiWAZhqG0j6H0OXWmseGRSQcCW5uZmSAMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1OsAkDfCyEPKp2PqQ3oXA/PWt3svg4vPh0CmQ5Qe9OMrf3I78ZEHnstjUn+1t2SuGe+h14/38HV3q6e6rwwFNAJ4/8Jvlf9lAK5e4RiyavC4hSqDSPoKsaunTmD5/VG1Y2AgPCc0C5msogHGVRkLwbElMO/UTJGPnT7mgZ5nN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RM0QPh2T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dVhK5ix6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RM0QPh2T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dVhK5ix6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EvFW71415153
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 15:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cMZtFPqI8hNTWA+cwHfyRV1eMrPS5GlATqeqgGvpNk=; b=RM0QPh2TvyZl0M9X
	tcXiJ0QupKiM6tIcmCYzEwVF19GqJ/p5JQsH/GW7tZk0MqZ1rbD7He0cMSk++BqW
	VNusMTx8dQd2x4n/N3rq19r3LhrejSlwRaDQkUDKd9ZS4rGR79uBUfm1+QrZ9HqJ
	criz9AonZIG05la00SDz3QcGtzmsYiQVDTAU1+rzG9zVBvc0uzlecdb3gLSerPbw
	D2Nhm7Y7SXf0GXAVgl4uUo9v4wXcFa4OSA8i7beI8tLUM14s99dfCmVLNiTzO5Hq
	L+lHGPQxvP+4hXOkCbOwiIxfJpR7ExMdrIQybFLpLx5yEykygNuzthujd3N2+gEd
	Z1KI8Q==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541r1gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 15:04:45 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6a17bd28f4bso954276eaf.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782918284; x=1783523084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cMZtFPqI8hNTWA+cwHfyRV1eMrPS5GlATqeqgGvpNk=;
        b=dVhK5ix6Ch+iyqCibThNIVYro1/z0IiuUYRDJKbA6w3zF/WfIP72Ap7soI8mdeSAAb
         3eJEqoDIX0O9834236h1ibBVigM2/T0VSI1ahMdZdhvnT8wXmUr+PQ3a1vRrfZWp8qnu
         HiAP+N+maAU0Byw7Jea6jVKqR3o6DAQnLrEwr6Dmr1mTWTMbkv9GX6NP3iJIsMwwap1B
         fFYI9uaLnl6h4k3tw2Glq5qWnsdY+k1H6kfAu+CBKM2f35Jbi7tduOT5ZX5KLcI74tjc
         ZMfBR7O61nkTauMXIKsIYFxZp8lMhgS4lg0fJju77PiRZEjGF3CDImj79N0u4wJyRsIB
         ewjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918284; x=1783523084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cMZtFPqI8hNTWA+cwHfyRV1eMrPS5GlATqeqgGvpNk=;
        b=ORPO4myUuz9Cq0Ki293/rJjKBwnRuYaY9si15mIoJBuCZVFgw2MDROYcoOa1UXGDhM
         4ttNF+jkFZMQBtNiyITput/dVeAt9EVr/icCZN213JnmlWheIkM3mn7/IKI3bEiKYm8N
         D62iD7mUXbdRIOMvEqYix83NSONctJ8an5B3gpzo4h2q6OTyExRaZFwDLLbc5huSJt6P
         KF96hwOAdcryOnj7G9ebfG8b91bERb9Tw9m7HKEEAjtpkVMmI3pC3XYAisq+XvJ65rgp
         tKEQqHpRuEy4INzv4LGvX7fXszkdOiAf7fnrjUc0VrIVBnd7ctsWqQ1dTFirg9lzbQ4Q
         E8JQ==
X-Gm-Message-State: AOJu0Yws3NZrkVH8BeztWuUzdY04AdG87GhVq26+oCuuSg4yB540b8gM
	qAz8ghZlwIPY9L5Nm5j/zlBrP9CPNLnQz47Fk2+7fIKHjF/HBeLMUBD1ereKcKxrywfS7ckKJX0
	wNDLReOo8YloaimLLMp0YnHAjrS1Hk1/9NQaHOy3RSOmllLIaWkFxwhQ=
X-Gm-Gg: AfdE7clMfTJM5bpQ6hdx7Sy5+KCE17KPkaVgEz6eK0aw+tBD9o9WcqHCHMRVSfNOIvb
	sXbsvaBVSmdgGHh+meptggnPXrXBssQCIrDm7MbqbZB6S9xWXQkzghS3HOHCOj+4+dxCT5+9/RY
	kbEeZGRD99Y/lKAj9BIxooX2vI0Y6oYWNfg6j3ANmfvqTlCZyhz1xRqIDzNDLzwFUiFn50T4+iE
	6KqU2tSwMtSkACmxLF8BtbGtLvrCsrJ0UNXt9y/XauVEj6h93jkRppevkYFNIXckTHI5nlzQJGV
	36kp9swyTg5CxtOrKOBUaaVG+3yT2HFgN/YyWAfpuHxtMdTbi9SMvNwIZsZo8JDrgDuPFAkz4JZ
	b9EDqSwNJtSKbUxNJrILOFtCIoKt1D0wMYboTcIH5PznOAlFlEV//u8jbDYK9JA==
X-Received: by 2002:a05:6820:80c3:b0:6a1:1213:3b69 with SMTP id 006d021491bc7-6a30d8a81cemr606235eaf.41.1782918284455;
        Wed, 01 Jul 2026 08:04:44 -0700 (PDT)
X-Received: by 2002:a05:6820:80c3:b0:6a1:1213:3b69 with SMTP id 006d021491bc7-6a30d8a81cemr606185eaf.41.1782918283993;
        Wed, 01 Jul 2026 08:04:43 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm288175166b.51.2026.07.01.08.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:04:42 -0700 (PDT)
Message-ID: <5458b871-11cf-4160-8613-f7b9fe525258@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:04:41 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] KVM: Move nVMX's lockdep logic for vcpu->mutex
 to a common helper
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
 <20260630225619.511632-9-seanjc@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630225619.511632-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zsVLdB4mC76pfQvAQP005Fidxue07kNX
X-Proofpoint-ORIG-GUID: zsVLdB4mC76pfQvAQP005Fidxue07kNX
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a452c8d cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=pa9wa68vPki7ckNWgWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfXzpnFmhGeE5e3
 ZLqM7TCbUPEcTTHOjqzKM2NscUk9UlBXUVUtQvnPIYGklEqQHkg2nVzdYqf9exoWcXLEO5Umn1+
 uB8Qd0epSAviK7uTxmaWu2jv0jGDClWR8/uaMrblq+5Hq6RxGFUCjIu5AnAhncpAlQCE3ExajB6
 ujobk0fXljirApMK9fRyOPMdKqC2YTNkiKICsCk6kiV2+3umoc97FMsOSwhuxUw8u4io5I9VPEN
 4MnjyMbWlLiLxefK0EW7Uhkls6LsmN2R9ApvOjKc4lDgYklSaNoHOGTPn4+iJkcg10lqhQGEAEq
 o4t5Pp9h3xzPx4hD3ZOywRrGpmr6i4fkspCI/9IPhnpNvuoocOBomHUqK2GSZ4GvKHZV8h0MZds
 Iqsn2pSV5CvWOk3SnLiC/EU6a6/srUve1DySzqmAxQnUS8mOnNimvHm3CeLbgC1ILDN3xzr+0+1
 igotY84jb6ISkYRYqfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX0o4ku9d+BKo0
 CtAGjFQ7E2HYcI6EgnvZM6B8xxppVbsVbAD3KHGXPR0zvkx+TMUJKcbA1W5e4MsRrsWg9KQKTWm
 iCx9RVejKWj8naMlegvLsDu2UI6N9b8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010159

On 1/7/26 00:56, Sean Christopherson wrote:
> Extract nVMX's lockdep assertion that a vCPU is locked or otherwise
> unreachable into a common helper, as KVM x86 is about to gain another user,
> but there is nothing x86-specific about the logic, i.e. the assertion may
> be useful for other architectures.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/nested.h | 6 ++----
>   include/linux/kvm_host.h  | 6 ++++++
>   2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
