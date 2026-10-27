Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125595;
	b=1eSqVBn62gxqCORxrBpOe+NjjVDtzsbfGt/i7fX/cWIm4jEqC4hUR86SI1tAWXKug7k5
	 Lwc/I9agSRkjaN4n/1NYHKHteaX4W9XcsNVZ1Wbx7JTOnCCOs4jqOS3t9mf7ZmNzyUp65
	 bE77xnm9PV4abteAFr7S9YSWQJ9jFPBfu/4rZJWs9gl6xa5364NQv5yaAcCLjtHVM9VL5
	 dg5oE7aNFKoYFC8Yr9S0vXyY633xCFCxm60UCBHVWi0/xQ2mMj3jcSdLbUebCGCpXS+J0
	 OBSgoMziPF96Gq9yugdSmwXg5Qq5PazLmIqwJXKIfR9azXXOsaZMYZia/odFDQ4mBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125595;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=;
	b=NCHcqa+jpzF7xOCMYj7RZDx36hQyddR8yhknUQNNjKaHkWgDueX7XkjZK3B3PYlAlDqg
	 c+H/vghsaRIe8iigNWf126DgPC6c9zzqZqLppv+Tr/5OEylOW/LkBB0X7cNrchNWrvpIs
	 SUewXzkgUdDWTINlutq8h4pvTIA8KEf41avTHb2TrXIlwcNlUfiwpLGQL8pUu3uCeup2N
	 Gm5UiUk0iomzY9lSf/hbT1qhsAfq3UpeoBZD5K/tWcYGCiAWc+KzSWa+KHMePNts9n7f7
	 ueUjaJgMF1lLRSZ8UahsKAwaY3hRApKChFAZtRxETwF209nQXLwJqRynvzTX+Yhv67g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mhWx35R6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iz9OqIxQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D2606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34D2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mhWx35R6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iz9OqIxQ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIIAkV3486333
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=; b=mhWx35R6EzRfQjVN
	1xH7p7SD7YTepkSQKvJRjnJdAwgY3XESWxBjR4e7n6msb3JPozQgoQDg0IxUxvi9
	hh1y0NovGCLazoZMOvJYn2VAHMfRpp6z5/xUwqSWFKtr/SwyQiyWAJkZ36GJbrcZ
	tjsFwvJyI61eqNejUo0z1ji7yPaKzlLipLt9pj3r4nEbWVn/Fzz09FJXK9JSFAbZ
	ZzwCiBOs6tcDrhMUPVudgOC8nrmUw8KJgoNXP6ql2E1i1/5zSNRRCklwLpyCRxdA
	XYxo2Z62g5QP2nNWOWLa+A6cCrxb3JWGzPLY6TIq1iZnyMlyQiHezOf0cPJEU92M
	nJptmg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtbun5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:26:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93dd3c3badbso11254485a.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793125593; x=1793730393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=;
        b=iz9OqIxQwwnDJw6z8didL/q/qDNnCPbH/AITLYqXs8gjrUtfpB8+YmEOEaxsoaUWvX
         /68pY7raCq5P0c7pHXlnP4yqdG+1qkZ37Y+PNdfINtBN6naSWk+2ZSkdIbNs30f4ZMDP
         OwTaJGB1aHxne6ZyfhdfGtSa6dnnL8mSNFNQFcDyy6oROSKX4yxr1iTJWWyW5laE14vf
         kfbfIMPnKhGIRg+RTD7HSkeaYsOa4Z7+EjP3nRVEXH/a5XdoQX5y8j4qxnQhRfseHYT/
         9vFzhv3Rif2lOAZgooVpaW9JV0jCYbbKiFOmNXyowLyy1Pkx4txyQQNnGgfRhQ4IU4oI
         ZO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125593; x=1793730393;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5gtNOSL9DkqGrvLv5HiCmciZ411PQzVsYtj0F/yuWWM=;
        b=LaXf2IBuf/TSHdkmGEvgvbMOj1Uk6IXbCnd/gIaAhHv0J9oh78jZLB1zkYgHNKcgmq
         BtuTRdrquikFsHcyspXTLY8SZUdlLx1+jcSt31oOUryhY48SHQVfiFfvUOhgzZDPRttU
         TTSlDzLM3rXyxpoc7f9NS5GPo7HyUfLZ1Zi7pJyb7F5PcI+2AvLoc64RhhCFBBb0LrOy
         C3IsgkCgS/HfD6+1uT+WVviEBis4tF7ASXHwxVCCQbwhM3FA2E6YCnKiwQ1FQ8O6S1lU
         zwXn6PDoolw07AtcFS0DRe9GXSDqkzOJ2wQvoMdI378gkLH6PzonmvHFkxuTVtXIi15T
         DFJg==
X-Forwarded-Encrypted: i=1; AKwUvBzsvL3GW/fEVcSDgCEMKyXk9xxbfan5yO1Q+ahtLG1HcLOJTGgTlhzQ/o5iGl7a/0Q2z6w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgl+rMa7pZSbTZP7DY+ULPNz7sCa/hLrkdKF7t0dcuA9B8CSEj
	UcuMo4V5iAwdCOjoLE5KAr73NwqxumBkh/pTwbYtKJmEdx+imXvNIA3ToZsn6m1ToJtmTSczbAj
	mJNo0lWOS/DY5+BAHEd1hwhHJ5KtPyfkbdnc+hFC8uAKpVSjWbEzBulc=
X-Gm-Gg: AYBFou3Nsf59Gj/x18t7FM1+B3Vuu08EX87ITjhzt/0z9hf2/nti3vRtKE+kkTetSAx
	E2XR+Y79KAz6ap0IqJzk0gRmQN0Sl8EE9uh2gYTHAoGP3l3ls/SHsHlRl5bSLHWRGHeyr+OWrDg
	YY5XpYQ9YAtv12Mwqru4/Qz6Gk58Wcx0XIUOVPXPvqCGDzuwjbVbyJeuu6FLI8+QRVcxOObEYzy
	e797FrSkuwHJqt8IepisQNXi0/Ywx8n4HXDd2OZjGbF0n+vnJixKSvkozTmdWwHdJCCStSgZYif
	7cTDkh0Tii8b7Nq9UiLKvY384WSlVB36jhzladBL0cU6Br1atZwhmMLXD/BV3wbYLaG6ZF1xVjZ
	lkd4t7abSf4T0xoZ9yDvSs0r3l4w6kQKv7r1rcKeA5VdUAAxy1A==
X-Received: by 2002:a05:620a:2b4e:b0:93f:24c5:f561 with SMTP id af79cd13be357-940ef9457cbmr1583433785a.33.1793125592786;
        Tue, 27 Oct 2026 11:26:32 -0700 (PDT)
X-Received: by 2002:a05:620a:2b4e:b0:93f:24c5:f561 with SMTP id af79cd13be357-940ef9457cbmr1583427885a.33.1793125592323;
        Tue, 27 Oct 2026 11:26:32 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94e6b8656sm23975e9.10.2026.10.27.11.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:26:31 -0700 (PDT)
Message-ID: <5ca7722a-cd6d-47eb-b8ec-4c93ef4d4699@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:26:29 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] accel/kvm: mark kvm accelerator as secure
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li
 <liwei1518@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chao Liu
 <chao.liu@processmission.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        xen-devel@lists.xenproject.org, Sergio Lopez <slp@redhat.com>,
        qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
        Bibo Mao <maobibo@loongson.cn>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Xianglai Li <lixianglai@loongson.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
        kvm@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Song Gao <17746591750@163.com>, Eric Farman <farman@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
 <20261027181400.1752951-10-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX62JCxjVs9CiP
 r3ZocToalV+Hw9PsDU/R05VEUW7+aDdsx7hUkIGgfo2P37F+YemZ1rxMv+iRglJz/ILIwiNW7Z4
 svrFjJF1mNmkqQNd8DgRYm/pyymFlYo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX/cQSftRjH/fm
 W16coWpkuPu84iQAZmaJ7u++rx5B3ulKMRVjD3vQxzjPFhB0xc5n7UXXb+WTL9F8Zu4Uk/FT2hD
 PmgxI2Ol86u/LQSqSeRILQouXJo+3sx0LxsGqebX2kb/X77DnALgkuME+XfWATYVfli1lr+6QKb
 bYecqolChl2xxERAIkvge3MvCpxSz9n6mTbNF0RYgOMW7QbADtHMReJ79Wapdu1TF/3HZaa8jvV
 eQRAY7pZ9IC1An8dqCtGfc1FtnHjoidlb+U3pkwxz0Hw2aJikMVvhNSImDxPywt3FO3ZvmD3+vo
 DPEL7H0zA/ZSs3sYB5rd4QIiQhnqW8zSRlj+fVgkgpKZpkIwSxuVSLGF6QoSCxC7xkAuv+atqHA
 nRQzLq/kpN+jt3vxcjRjZNi8+lbAgOOFiQl8wUbYqrZjiUuKvuRBAwCCQl2x0MSyvEJERGZZ/HY
 pZASHfhdOkJHkom/aRQ==
X-Proofpoint-ORIG-GUID: _VyAgBwi0aO1JrN2RKJGqt2VOUimyw3k
X-Proofpoint-GUID: _VyAgBwi0aO1JrN2RKJGqt2VOUimyw3k
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0ecd9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=R0rOnUjNbK5cqpqgS9oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270072

On 27/10/26 19:13, Daniel P. BerrangÃ© wrote:
> KVM is servicing virtualization use cases which must provide security
> and actively maintained.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   accel/kvm/kvm-all.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
