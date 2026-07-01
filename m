Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CE361666
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918150; cv=none; b=ZoNRq+bZg0+jMkyGyOpZw7T644CHvXrfNbeQbIqK/m3l9aB92aGtTwRhZfApNyhrCwecP14TGdAR2MxhdgRCqaTnmMZ/K3QKoUmCxa9ljyncAo0ek5vRKGzoXt5HWEBeSrnEk1iPVNtnZhNAwyu5i/tZEf9V0A/TSFPV76M4ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918150; c=relaxed/simple;
	bh=3QJeB0aFdqaNT8Ic4oRbRnKj+cs8QJw1IGMOciSojac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emO4kSH1+5JxRIIVOAYiyAlbMnBUQO9OkGKRQSxqxhdIcCp4jEtvDuBwemfBhQk58Wlt0i5LjgbcPkVsnPR5XGefXXwiMGNGGhxG22p1vwJkdlsFZoSfwswAaDEIvXmWKGJn+TscMwAEQ2rJOrvsdNwaf0bbRABZv5S5lJ6DdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VehVdPBN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fk84VZfM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VehVdPBN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fk84VZfM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8hUA744622
	for <kvm@vger.kernel.org>; Wed, 1 Jul 2026 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w/owUaoB1wsGeAH7DJfpqe29zlU3235g4J3UDh7oFQo=; b=VehVdPBNkHRBtB9t
	nDJBCxfcZ48e8H4HxgZzOq9RVg6Kbo8ieIoEUMy0ud7mgW0Qg27WIhRW2/6aEI4N
	e2U50dEmFbPQ9rEKu18WcS4Rpz0Z+WYifeigvFT5ZuL4i5GTD4IojofxpcKBPBHY
	6TiZ8CCGeL78kQ3fpgvPV5bp3aflmeYo6M9EC+YZhoxHBO88Wvq1foz7WWawPoGf
	BJlBLeY9Pr5ONb8PjZMuQYEusiOe/qfJDHe0Ah2vSSgJkF+cmkNv9++wCjb1pPvw
	fgbOgCr2jLqtadyDjwUcqlMI9MmdZWy4WXKJVmedc4k/tQ/A6/qUfKi9JJAth1zU
	CioTNA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4x0tj3q6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 15:02:28 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e60737a964so1012330a34.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782918147; x=1783522947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/owUaoB1wsGeAH7DJfpqe29zlU3235g4J3UDh7oFQo=;
        b=fk84VZfMMiVk7Qoetw1xBZUr2w3gTzIjYmnV8N8iGgU6i0nVt5ob9inuoHLMZ36+xV
         8zqkdod3n4Xq67AKIT0L/UE2F5mL6O8Vy2KOD2wK427AldAkWZ3tZZYf8EV/hPf96vQP
         juPfGqpsGIn6bblyqX9Og5smUqU8NTEYNBmn9PM+DI5e87psDTasGcaIUyG3yrjXp+jJ
         NleHx3YBwHGCTbW+WsfEAhI+dQT/1iTPumH7fuj+3jDAHmEaanAMOmGG/O/xNfKLE5dC
         g8DJANp7uD7agtFyvOpFjeAfFMoJT/G9xGpez9ozJc8ADutHEtQwRlFLIeCMHV31gyae
         0+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918147; x=1783522947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/owUaoB1wsGeAH7DJfpqe29zlU3235g4J3UDh7oFQo=;
        b=Bgqw2JHdXVSKTKkVusYn5DhWjgtqm3tGu0ByZBEE7mU0nQg1t2fv9OQarrt6bUZrSd
         p+Ffix6QjByDlZ77xpnF9G2B101umfLCnQiT26CxmML5NhbfIaTsR1JduCwKnT+CFhLg
         F4xKMvdtqozwkPCLdKaPhL/NVnGElvLWKtolEUUSyywFLjZeTGcOgiL5X6Lmm0tPj3AA
         BB/LliE3MAkPBRa/DMfbtStNkN/5Q5iPiR79h0EvCaCSmzqArAX2cUfyK2gGYj3Fudk/
         jc2xA7mtn64iHkWMozEb3mllbHmodV3zkxtJu7AbPXtXKBFkdPNXWro58XSqOcoOQjCD
         t1gQ==
X-Gm-Message-State: AOJu0Yy+UaECcbcS5TJc12+geeLu0+othRKftDCKC3Z+FhbXVkM7GlXC
	J7N4QpZCMePqEsSN+yFrYedo3UjEZtnqnFu3ZK13gb0vvWAyx7oh/oMii6pvIxQrBIGq2BxT5Gc
	EQaM7QVsOt0PS9gxy/ahqYW3rCY4/QnksoGP7f2WoIyxPUKY0r9R0Bd8=
X-Gm-Gg: AfdE7cl1RyReXxnc7aArbxiiIoxuzEdlnbaRHBB/rOpDofaCFW0+LBrC6RuoIvqekKa
	Io4ApzGLtSTk1ehGH9nyUOI9e+VveYIk31WF2gRd6uxIpz5YGFjHcpfgJD7jVy/zOyOWPzH0dgr
	lWoCMyBLLVPveLczpjQ1Wepgl8vtwUbfGBCreqblDhRCiegmUd9aY5S/AX7to8YHkBx6wyoTmnd
	CfIGmYKojFDPmqmfMnGTCUxfpydwmWps430y2Wub/QyxMQGEhD2JuFogCpP5unmlzsIVRzQX+lC
	Qa/WqRBPqfgL545iriF71cOCRGh7PtATTVeRQQbHyt40y0gXf3i0R78805xSAPoRLq39P83cq+c
	02wGwMdtwHNgLxRdhbsqs5luGBYPzOCkPGQUlJLCRj+xwaadxqQaOTdMq1pGXLQ==
X-Received: by 2002:a05:6830:2546:b0:7e9:ff97:5e3b with SMTP id 46e09a7af769-7eb504a97e6mr742421a34.15.1782918147441;
        Wed, 01 Jul 2026 08:02:27 -0700 (PDT)
X-Received: by 2002:a05:6830:2546:b0:7e9:ff97:5e3b with SMTP id 46e09a7af769-7eb504a97e6mr742339a34.15.1782918146764;
        Wed, 01 Jul 2026 08:02:26 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3b6531sm2874734a12.10.2026.07.01.08.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:02:25 -0700 (PDT)
Message-ID: <16b10164-2d93-49c7-9745-70b03420e871@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 17:02:22 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] KVM: x86/hyperv: Check for NULL vCPU Hyper-V
 object in kvm_hv_get_tlb_flush_fifo()
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
 <20260630225619.511632-3-seanjc@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630225619.511632-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o0eTPwExLF2R2ypawU6scNKPk1H107Wc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE1OCBTYWx0ZWRfX1uw3kLBdEjAY
 7zZG+Gsvbm7fC45K+P4Tc0QG4YdbfFPBcB9Pk8kRdHUaFvshldGgjEQ3PzuCfM0NsS13ChQGR0H
 Ff/c8EaEJen04Cg+5Aa3XnkprrBh5HQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE1OCBTYWx0ZWRfXwehM0PiFjWWm
 tbwAASaZVRbuM3FnFGiUkqk6sbjNeCKUv4xXCLgk3XvnvGo8uYRzEo1aQkfnFyQEincoYWxgAC6
 2lGz2sywZi/FEABG7OHkRWe4VgvzEVZ5kY267jNz8oEhJp8zqQqFv1ElU6hORA3F266DNIHfQHh
 m2tnahhVupY2fX0PA5h/R3HqX9L0uE6UH7MNypiYMXMeGfjwZUapV2O9IuBzVQ2lr94XeU8h5Ij
 Vuz1lA110SwSXKY1kOX20m7Gf2jiybEwT1kzmUJYT6Z+sJLw+dWWCpYD7GWksKGMKgTX1zjxoE0
 xHZub7H9oQN6oK4kNJJNcwsNZpzEAN82T0jlsggU9DAmXuOFPiv/elNKIlw0nVc/a57hg2Ts6TC
 81njtKR/Kw5vj2gLeR0uFsIq7tKvtELHyS9ODxo2zRQ26N/KMf3kF3f92Bmj6wFQHNEork6OUhm
 DntAgbJCRiNwamiOtjA==
X-Authority-Analysis: v=2.4 cv=T5+8ifKQ c=1 sm=1 tr=0 ts=6a452c04 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: o0eTPwExLF2R2ypawU6scNKPk1H107Wc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010158

On 1/7/26 00:56, Sean Christopherson wrote:
> Check for a NULL Hyper-V object in kvm_hv_get_tlb_flush_fifo() instead of
> relying on the caller to do so.  This will allow fixing a cross-vCPU race
> where KVM can access a vCPU's FIFO before it's fully initialized, without
> having to jump through too many cognitive hoops to reason about the
> correctness of the logic.
> 
> Ignoring changes in ordering that only affect the aforementioned race, no
> functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/hyperv.c | 11 +++++------
>   arch/x86/kvm/hyperv.h |  7 ++++++-
>   2 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
