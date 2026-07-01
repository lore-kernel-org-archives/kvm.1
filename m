Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C2481FB7
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918418; cv=none; b=P5r293PRzata+wDfjl1ltP3YYS3rMzoMpFZxgouBZBiMqoOWNmcgjM0E+7AakwBKDM/P+RFv3eckvlcH0Y4J48ujPKyRMdiguDj0Yv8dxCjAcAU+/V9NTHEFH04sGlec6EOlP+5DMp3bofFJxlDARrMQNwmX8+mNX4+2qIMIEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918418; c=relaxed/simple;
	bh=J2I/xde4R+mq9rPsOBP7hmzn/ps8KRIsDzt31M00GYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvsqTtGWNSx/bOD+IlelqtDVKmcTbTDKV2OrnOxJVrKt1F74rC3uFXVkcVjbdf218kdUZ1/F74eHh5xf/nUfEuf7B5h+Ur7/BqYtby4OrYPQiJrgzrvNzygAtPMUAwePGBzAdlnMpsrSU1D+TPS9xToOwwAGMUSEeyKhs3emT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pxgQP3aN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OE2ZSwjD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pxgQP3aN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OE2ZSwjD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AGEO3793722
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 15:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5wuRF73jWKw01AnLgPbUYJZTlfclOfzRgiDuT91g36s=; b=pxgQP3aNlawahaiu
	+Or+yg/jCVNOEm5r2VgW/a9tc3vFD3cJx1MlyzkrWXh1enB2tHngiOXP5dYwm9SI
	3BQrTz8PO5ZVrS4+mK8GjDprZrCwrYwJ1GNZQUqFVo6iNNKjakEDPP7t/sifDMup
	8P27j7ClpDs0/efgRFTL5yOMikdf1/NIT3vVeKl4A+AsGY1Qfi5cZP1DYObkZJWs
	TFWDrwQ86NIJ6dZkNsBygCTO9Rbs0O1dfp+dvSWSTfc8eqjjELiS7iZtIS2x6ryy
	2eqOYpZGZt1fLQyhrKXEAarB145s/mHGZrgi2IXR6PigS/rKT7lzYoWdbEJQawHz
	UpF3DQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ah73g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 15:06:50 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5954c5fbcc7so395890e0c.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782918410; x=1783523210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wuRF73jWKw01AnLgPbUYJZTlfclOfzRgiDuT91g36s=;
        b=OE2ZSwjDfO7zQ4TJwUs6UwWPuetpxVLlN+Dza/NuxVqvB/U+XsIfv0QpiyuGgrVzNX
         0CYwth1ArNX87yGnHJr3BGAOQS0UTegh7475dsBk+IPqeIza1w7IYDbRqqOQ81+M9jSI
         8ZNvb+RCfBl37yTfWQhhlBNg2o5LVeEaIwrweFKZBeLUOQlxCMTu5ZX8ANQBtx+ykXGc
         Kw6ZraXcsf+XJBD1woro7c3m4BIROWsXk7OGbtjDmMQ44GtRlMss1ejjppEfd+Q0W0Bt
         lN7o6KuKa2jd0uBGdSsrM1FVZsrcaIvTUcXIme4pIq9pgjnh1vKAXV9OVenXuv9fGdbL
         4RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918410; x=1783523210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wuRF73jWKw01AnLgPbUYJZTlfclOfzRgiDuT91g36s=;
        b=Ifeu+6tIM6lkrROc0V06fmE9vdzSNmsBeN/dp2FvNQNN9Lzu33b1oIiIcHg/bJvitf
         V2Y8emWnNcAkuYr0EnNgccRDDmlA4EjBK49uYvprVlcJWjOMeUHo/5FAXznH8XkQXx2Z
         bl1aGJ16mOHxmg9UUP8QJFchMkZ7SxNsTsPuigDa6nQCtK2+rOgdpQpeiVqGNpuwiC5Z
         OsEBZfdGwEOwqsuM4O2VDhwGsXlpJPfIsNjh2WO4AbLXLA6prEN3CRP2YFc2ZvBdnb27
         jOd59KkVpjWz/PLG0KtKtJ2ngvLoqGcXOOFWeWp0/5PeHbnYeT2kMl2+xBlkA+KMgsTF
         tN4w==
X-Gm-Message-State: AOJu0YxESLlBJxfB5YGzYz5tsz6K7JQjvBoYws4ciOqOghWUeay5gI+N
	E69HFMHgcVEPlSbi9Q8HqeV9UOoJth1eMJCkwed8kbNtpe/g790/5krf5L9d12MFzSGcNPrLNVJ
	VOCirINRS5Go3Elr1VAaHeb66h6zpBxhEyt7ZVuDLjx8I415kh+dn2LscRif1rfM=
X-Gm-Gg: AfdE7cnlxAnHOTX2aO0RZcTcdnK8pSFXbiwp6bQHbDPTx9k7uvHjL8IpaqgzdYNtREP
	gmDzuoXiVSzNVaJ8fo0FGVho+EderIAarJpLFAEllR7MNFqwep0VODpOp6wKOLE5fCG2UlybV5a
	3hShKmeBT8Ox86pklhLpE4W6TSeDf8K4IoBb0s7t1zI1/nUBqwFoRxdCH7AWwGAKYNc5zJQjkvH
	fp5WWq3wjqNT2ptkkce9YOPKX1Owrktl1wPSL4mi3DVm8pCkEwuN8nge6t5Fnaj7BbjAhfLkF25
	7t8KxzrgBdyHfFUOdaJxgMTpGWdCt7LFkzVAu3hLbgTU3q04g07a+3oCrSE97h1f1/Gsn/XoFek
	mxUBHRGmPbu6WN58Bcd0XtBEUaEHe9YWyO+YFoqHJL9KoFA769kle3GhUN8uhQQ==
X-Received: by 2002:a05:6122:1c84:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5bddf5980f2mr835731e0c.7.1782918409765;
        Wed, 01 Jul 2026 08:06:49 -0700 (PDT)
X-Received: by 2002:a05:6122:1c84:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5bddf5980f2mr835686e0c.7.1782918409349;
        Wed, 01 Jul 2026 08:06:49 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm119405325e9.15.2026.07.01.08.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:06:48 -0700 (PDT)
Message-ID: <8932ab7f-4547-4761-a9d5-04639727b79e@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:06:47 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] KVM: Initialize a vCPU's index to '-1' while
 it's being created
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
 <20260630225619.511632-8-seanjc@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630225619.511632-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hnfsjlbTuh6SZhZ2x0WsTBWwtJ3TcgW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX54lNKYg90JVa
 p9rfztLoXzIoT7f3YsNlwS60+p7u4LX/hMAA/1ZJirNmyA/pLAG/wrEiumRHXdGfpcRWbpcBHUN
 S2mPriJ4hXiVAr+n5N15j4TTig/zcA4k+OWBkGKNjQhDExEuifD9owB5DCJ8LJuX/Zu9hA3GTCK
 xPM8MO4WGZZQT40zxdvxkVIeZ58UM5d0hgeUgevl8M+kSO4go9cya24VUYfRQ60W9GHILLRPDja
 /TvoO3gIbak7rq5cXS19/fORw3WMO4SlZozBj0/6JySZI7UZTjnIw7fJUG2pJIa8DtqLPPKMyRA
 JBqrgjrIJwpjbjyMmhD2/EeuVw+AkWdAB9L4xw/Zsf/nJsmjlXnzPLFPdo5D30FEi/8gct8zutL
 LNdkgpeBzLQRIXV5CvDjt/xUkNzmBA+12V0OLj5Cwa9z/DYIcbGyUl9FuUF3ppAJxmqFvidb5M0
 3+xsZp7I3XSKzwJVSbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1OSBTYWx0ZWRfX9MqmB1jcqMpm
 Atk3mEIvLtz6o5mXI852g+4oXhF5sBV+/rxDV3ab9/+KLlmWFOtIZv2xKYCZMwVzexoJi6DB6xR
 ZyujERtPfi7THItgbj1lsyJGQzx4Olo=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a452d0a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: hnfsjlbTuh6SZhZ2x0WsTBWwtJ3TcgW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010159

On 1/7/26 00:56, Sean Christopherson wrote:
> Invalidate a vCPU's index immediately after allocating storage for the vCPU
> so that KVM doesn't incorrectly treat a vCPU that is the process of being
> created as being vCPU0.  This will also allow detecting that a vCPU is in
> the process of being created and thus otherwise unreachable, which is
> useful for avoiding false positives in lockdep assertions on vcpu->mutex.
> 
> Unwind the index back to -1 if inserting the vCPU into the array or adding
> the vCPU to the fd table fails, so that kvm_arch_vcpu_destroy() sees the
> vCPU as unreachable, i.e. so that teardown logic doesn't hit false positive
> lockdep assertions.  Opportunistically add a comment to call out that the
> "real" index needs to be set before making the vCPU visible to other tasks.
> 
> Note, kvm_wait_for_vcpu_online() naturally does the right thing thanks to
> vcpu->vcpu_idx and kvm->online_vcpus being signed values.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   virt/kvm/kvm_main.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
