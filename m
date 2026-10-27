Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125539;
	b=1+NyEN+zllnYqBWhFukHIkbEEljAC4cneVFfwkbpEV6ConIkxcW303f3Olaso3h0O9EU
	 D3IVVtcTOEpWmf+rUgxd3jfgulqN/MXJlbT7BuBXLLwasfitlTHUFR2gKySXDXdQ4DY/V
	 XCuAmfdKT0AcOuUINXn/uyStup6KRMvcfy3hFpuWQATdRAY6CsgUzgLD0etTSIDPA8AKk
	 zVB/1k3x6M2nHpyiIJ57TfaDzatbYXXWF7bjpnMx18JQt5X6J42uJwmNBiDjsuQWXyXck
	 psdbZIljZjN2LhNQBlOtCCQZKvapjBijaWzTT4FYmKUBqWsOGPT7BMOyq28TsTt1VEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125539;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4XLiomQ5/ZQQqJIKi2eA86vXUSMhCvCaUYYNDKbeFLY=;
	b=TUXnsEDdho/PXU/DbTwEx6cQcDFSzqhZiuzOb2Y6pTQf78XUWUx+FXu8+89ypkyCBVVv
	 pgNAi+JcBanNnYqK53TvEjbFZrkBAk0C7mqeYWAol4Rrq+Yo44jZHnE4ZGVFfN49XeLLC
	 HblXso+C7ipOfHFPbhO+p2rbjAdQHjiWz0qaBFleklzD8J1ux28yIfeRrMsp4sowC3Ww7
	 h05ManhegcZW7ru2zBEyDmTyQtng2shA6zuZtIeAYC3MWrRdCMcuni2QNdYcHUUlqbr0G
	 38dSyDdK9h9qK086TM/zeg4MeBAmmhw6D77hFsqNTKldRo4uqby2NKhqqFQTQ9lKlgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I+FxSk9S;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C7vgSI0t;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D0606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I+FxSk9S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C7vgSI0t
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RIHSKl3554092
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4XLiomQ5/ZQQqJIKi2eA86vXUSMhCvCaUYYNDKbeFLY=; b=I+FxSk9Sr95xLB2X
	uwvSjsPgTHMJgc5OGaqC61pP5R0e2i4mo3aJTnNe4SNlZwvqaVbnQPRf8dnhsN2C
	8SkDkD0vXIE79p33s/2Sjm5JbtgpTFjp5cAv2XjDL15Kl5HNPFAFi0ogUkxy7p65
	o1OhVdAZXnayylAEEW1OCEXaOtX7swCII77TaEZjk7uNQHd+KEZoeCTiw7fSP3o5
	5hEQIWpJBSqgnHQdbgPpeBrNrdcSIoXM+wDgDomcgLWJHZ7ZVKccvdIJBFgA+E86
	tUEI6pyQl96fQ+jqOGz3r+T2V/+ywGOFkwQlsNfchB6EeF0f8sMDTPeJmeONgkl6
	DcpFQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22p5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:25:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93caf7856ffso13216285a.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793125537; x=1793730337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XLiomQ5/ZQQqJIKi2eA86vXUSMhCvCaUYYNDKbeFLY=;
        b=C7vgSI0tjWsglhB9cNuRTb6myEU/7xSyZNGaU4vsvocug4HZvRg9AqRZIxdEGdZ6ys
         zaBfjih2wWnBcWWZGIS5VH1aNYV1gzB6K9KCMh6gQf2AXLPwCT5L83NYPtkwD8KkZeEa
         iQthI/b5wufWU2piZW+huY3UDsTMwZcZNVPaCr2Qb/OHfQv/u+BX8uzBgQB5L1mnJuNH
         KwsYDE8YqSjFMTZRyu3bf5viA/k3G8SDwTNAoSadK6CXZOEMfXjvfnr2QW+1311CRxys
         X+v7UncOCI7cKazvCODTiC399Tet2iFZY5pdPCP65SxTb2UkTgHzhAdVOsvPaiCjVwTR
         Igcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125537; x=1793730337;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XLiomQ5/ZQQqJIKi2eA86vXUSMhCvCaUYYNDKbeFLY=;
        b=XUAjX0NifU2Xlbosy5N/BEMEsXTKprSGKHW1jR9fgH9RtxKVn9aImUBqxCc3fXL4pc
         vJOH7fu9RXxr0jVrIIx5CCNKgBbfqzVoL8BPQZrIBaLiCNjSGXey5rFE47hGizuNSS5c
         dDPwQ3CTZiYNJTIPEjeJKFVAySor7He+lq3TeSckcNzqbKgi0MetuzKwZJsVBBcwYmYc
         Hj9ooI8bvpbE8XkBXPUtVWEmxfqdUDKra0bZxBJ9sOfU/+G/7eFA1yhQiY5wCGcafW/q
         5VObfGranKceGcPFfwGo9Zlss+e3uxMW7NdhL8G80/f38Ddvgk6/N27XRjWdxnKfNwFR
         fMRw==
X-Forwarded-Encrypted: i=1; AKwUvBziGiMuRuK3X3nYaw0C8maIjCwry91VVV6KrZxgPnQV6dYbIx85YsAU6+swHDzksB+DzU4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWgY4XHY+hchU/285Q2WJtkJ/9M9vhjX9FXXa1GyMthGeA0ZX+
	kIQisxO/mRfo2S3FwJw5X6a1aCjUGR1gLVENiN4jNn4x46YDriEzPAVxGOshtlZK52b/vQ1gaBL
	LNpqQFz+t9ZoCuRou+nG6nsy9WmalLTlDzliHABSdhRtVRc45GPTjLf0=
X-Gm-Gg: AYBFou3HWxU5fBEEL4yDg60qSNF87w5SL22rsWxOGlLZEF/PYW+vm79BwRUw9DJvF3A
	6dQAY7uT9Vqicag4l7fIPvqqbTbAQ7en1M7G+Zy44/9/vHLXc4A2TyRDcxQo4qzrVoaiK50n1rc
	gaiUnXanzkV30NFk216YrJCrtsq8xnpjhfbI9uz4wrjD+4e9p49z0XoogkAhlKmL3Sw9QnkLgPy
	SIuuaD8ZlGYJQ+WibrXuNWFy9eAVnsLm7uzXd18M1BxH3s06DZ0POscd8y+JNTABZN3uFrRRdBb
	MvQSGLehammUfT3wGSsoHO9xgCvCY9iyFCvmyT7zBPBj4PcQQtogJazb27iljROXRFMX7x/Qaoz
	5F9lbitAj6pRCmKh21gBqjqX90aaEZ29YZAebzs6BYccCKUjzHhMAEcdnqJtPWTi2HQkIlVuU8P
	Q/yikYN9EPFWlClgoGbIHbJXI=
X-Received: by 2002:a05:620a:2987:b0:93e:5247:f61e with SMTP id af79cd13be357-940ef8bbf03mr1581123885a.25.1793125537158;
        Tue, 27 Oct 2026 11:25:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:93e:5247:f61e with SMTP id af79cd13be357-940ef8bbf03mr1581119785a.25.1793125536648;
        Tue, 27 Oct 2026 11:25:36 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net. [82.67.153.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm28457361f8f.44.2026.10.27.11.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:25:35 -0700 (PDT)
Message-ID: <d17c2d21-4b82-4fff-b08b-56cfdfe8a61c@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:25:34 +0100
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
Subject: Re: [PATCH 01/11] hw/arm: mark 'virt' as a secure machine
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
 <20261027181400.1752951-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027181400.1752951-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfX12UBYHfqVRKM
 r2Dtk/vYMsG/dWnCudk1DqbCBVbY0pDJEvWqY6KkW+PNeyfJI1PpuqHZHR9XYFW6hidGyKGfzg+
 5psxbSC1oH2mxM0yHkDzfw3tI4IHcH5ea/Aqfii8+fCovW19HHQ5hiJpzMz//3YFF3ec/50oBKa
 YHyKWfdiF9nqgqxXMOU7psgGWRYJmJavFnfisRKJZcwSpXptEmPa3le88rbfrjRYeRlhlE/n3kK
 ++tZJC5hVVsRzGORm/P/Xo8XjDadAvcdFgSrJMtK7CNTH4MfRjcEUNMU3v9Eh4FHACP/P9ihUxr
 IZQ30xHQat8Hv9EVm4PGk3GVjLtwhCt5NL0y3mUnQHtf39YrMQJCgePhzEU9CFkFc1bNjgtm5rz
 Bd/zP2OGetX1E8W9Z47AxG5PR9j+YZd1FwRzU0dPI5VO/22K3ephym1RDM0/NAQkzONRQNZPqow
 EuKmhA5oB9I7rfpruEg==
X-Proofpoint-GUID: P0dWarQOXpXAb9kNEyqT_d2gDfn92RFW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MyBTYWx0ZWRfXxrTGuXDyqd1W
 N+rmfSDTPFF3fNcmzaAJvmV6CylNnZWKuOgldXYtCWbT+GnqV6GcNLrJsv9EPCLcyvmkBQv9QEC
 XXs2tkOsFtHkqtUUdC3+T+Bzb5v5Vgw=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0eca1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=XauY5eRjrSQ0cOF71_8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: P0dWarQOXpXAb9kNEyqT_d2gDfn92RFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270073

On 27/10/26 19:13, Daniel P. BerrangÃ© wrote:
> The 'virt' arm machine is already declared secure in
> docs/system/security.rst, due too its intended usage in virtualization
> scenarios.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
