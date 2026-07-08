Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424053B994F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 05:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487768; cv=none; b=DMVn4xstMZWvL7oum85ZoHTFkJxKz16bxZtPpFNuDVO67sed2y+PFgMOUt/uxQdwJ2FeyTq1X0vdW4I1NMyrmuXG6lJikgmrIFKbZQXdKyaT7tlPXMD/nvBZzcwz3K8Mx+XKlMmrWBY86HxXQY/pYBn1Iw8lW3+yeDKLeiYv1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487768; c=relaxed/simple;
	bh=zBLrk7Jp3MRFEjQkbmH/VozTCyKVIz4MFZca6dy8wVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lcwoGnMHicAdTvkh/wyEoKDkXjzkyfuqH0B8cA6I3nCFL9Ammm9p7IHK6nqeJw+bvJSle8DigsJI4uv5QjRfNJgdzC0gILtA1cKN++J0TwHivITBBjK0S1o146paLq3TTib80wClTtx2YIFbnFakK/di6M1b18RX2IDhbGDAN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XsdzWbKe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MR4/ZvM9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsdzWbKe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MR4/ZvM9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668428RE1656386
	for <kvm@vger.kernel.org>; Wed, 8 Jul 2026 05:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=; b=XsdzWbKeTFvbSjDn
	jrLZKh6BLeZ2s9Lj7/fBqnC1I2jpokEFTkWNRGloNLCU1f6ph6yJqAn5zTP+uJLb
	MbjA3lwudur0pBFrdvkNj97vldBtH5EWeHDhX7ZnW8s7HGDRD/nR/J4ppiTjl6Lv
	QcuWvFhYjEBtMg9THqeQzN7Ztxrtv2U6mf8EaaEP0iJ2CpXMrlEkq67Yr/kD3A4b
	GNrzKXFTIflGNZgNsVakuPWFcBAbdLGaFG/DJ5+t6w/HE82urKz3FTiN/n8uLGJ2
	8tyamKQYk2lq68bcv2dMK5jxwVPajPnn0+u9A7EQx96nimK25XZc9y0WhI4GvcCD
	ysIPUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cssrrhu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 05:16:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so3098421cf.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 22:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783487764; x=1784092564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=;
        b=MR4/ZvM9ftP5gLSV7uJ/KYPT4+1a+iHkSo9lbDb8EHlej0zUiO0n/w/VvTwAukGoLq
         rNyqdbg8FieOMsahoTUdFkfTEhgzEUAfr/1fsxZpgBHb2LwmUNYyx35+O5MuyVpVk6lV
         KE5AN6D8POb7smpDsXLH4tIsDrDH+aqd7px1radio/mlcPtfmQoSHaSmFxGHeKbcnTnJ
         YG79LTzb2g7OfBLx1EdN82N7TFcfJcYnpkEZwjmsRBv9Av85EACLDtxgPPCUNZ3dkaNb
         5jfRFDaubAkMbWkQ0TskF4sE2pZvrmp6m/i6ZgggjAvg3LON37KED35yz29UDAofZLhl
         UUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783487764; x=1784092564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnE3EHzcAAB3wOGkpHX7qlXo6YZQIie9HvI/CCy0uxg=;
        b=iCsJxr9IvwsaWj6BdDiYL+qkoBlculdB4rU91kA2Vwt3Utu7epPCF2k9BhMX4nqeK7
         ssrcMSuRN6drOE7ht1uOR633XwRR24o8zPAVNJ4hbqjqBXET7nvej42E5Uy2klnE6Ihb
         7I7nvJ6/sy6ynv7jMTAIkosXLBcAxe6VHdAqRzVdXs0/4QyyQJ/7z+YEEXFw6p1mdvRa
         A73+sKzylJ/jQuKQhpPBF60FMJti4ZuJ/Lm6pjYv7Hb7ABrirLezhVmDkH60qFsmaSfe
         0f3+JBckqLni0YovETIMLUlswtohDOGPFiBPl0UjhSuoEmbJFtGoPq+ALMWNfpVGxpsz
         A5qQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Uf/Z3zsfFMC+ohxa7uwKY3X37Yim10Ey8ogGi92lfDeDsIzuLwboPlSv4MP87TIcyFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ilIo0sNbAogXEH6RMrpsjsUeY+ntWi2a9TWWs2Wu6iGoSGQJ
	374mHF6gTr1Cmo2IXVXEf+JcpV2FQ71d7PphY7KxLV5q+vcry0bliYRbKum+HNp/eZIyd8cWfE9
	8XpUlfXt2eBbCh1T3fOopUULk7NZ1Gc44AE42EQ1p0L1iCHJmmdiQPCs=
X-Gm-Gg: AfdE7cmb6osbgdmhtHKke7MPEMQM9fO/7/+GfGVAfRrWsKMNN2fm+dszV7Yv3msS9k+
	x3CNzHLsuvQbK0giZ9XJ9UQ6IZ+RXwvZCyM7wA35X42Xn6JEeAjoJivu55sf7RBw0KnENmcZHa9
	KEpTcZ0NQj8MngjlgQh/XmYR/CgwT+PFGwRel8AOwc5E7kgFXokClt8lGm8BEMIc1abgCNG2bNt
	sQbZsQ2Mt1tvYJr08YXxzghxlVauH89jgf1205KLpZgrEhVftG9wQlszWhiMjpZEJ2l4PrDRgGG
	4PB8ZINBoy2qk4PssPkRpl0TiUTDBoaa9VD7c9gQGfDYBUswCEo5+hNwLpadon9tNRU5WTEsjjs
	PevqeWKooY+w7+YGiHxX86E8G1UrZlnN+qgAJwTVvrDQVaREjYuod9AV7fYH0DA==
X-Received: by 2002:ac8:5750:0:b0:51c:7b12:5fe4 with SMTP id d75a77b69052e-51c8b4279f0mr11553171cf.80.1783487763979;
        Tue, 07 Jul 2026 22:16:03 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:51c:7b12:5fe4 with SMTP id d75a77b69052e-51c8b4279f0mr11552911cf.80.1783487763595;
        Tue, 07 Jul 2026 22:16:03 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3676dsm113995715e9.5.2026.07.07.22.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 22:16:02 -0700 (PDT)
Message-ID: <d14eec9b-d6d5-46fb-b808-e59dee5f8c7f@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 07:16:01 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware
 feature
Content-Language: en-US
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
        kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
        peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
        pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
        jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-24-mathieu.poirier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707224306.1202330-24-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4ddd14 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=GSV3El1kC2elkkDfeLwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfXye7wUHGl9lhK
 An2PZotcbOjyIsV1eSKZ+1fWDziiKvHPPyOKaHv+asl0Ua2r8a2X4ewyhbEfJZY5/577nz0a7xV
 HcNuFz3V7/3BLhlKWAfCj7E9lBBYKLmK/+2CCSwS83fJZOYr7Y0ZvkPhi1ChzD0+G2t+3udOF/w
 /xdrXj5COhN45iyito379YDC0TgQQYXA1xHYwmXqwdyt9BAdYMYoI12zz4uU7ayEWyFk0drsKcS
 THyzZBbdt5Wsz+oMSKTplzDbecWcS1J90epVUh9COMnfyJ1SltpMCcKgkac9d9MR9gYDp6uV0tF
 awvruTw4geJcWvOUHFYJQyL0wAcE0M+txLOhCEvaG0jA1WAW8RENFdAbwoujOK8I9utTj0yOs6L
 tdXo7f4e1gwAopDxxhnWMaYcqvEMhprdG3azpZARovXWqeUF1X6f7jU3nGGD3axEvcGdjmQRT37
 C3q+jw78zxjHIPiCTNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NyBTYWx0ZWRfXwW3xBHv4QuHP
 26RQS+u4Pvrt7bMXXqZaGxt+bZvQJIdAgA9JU3ZAk0n1WiLTzQS0XZrxCdAWIw3TpfjKWvNwGDk
 NbXUDWdJfqMokOLwofQE7tC3/TzRLsk=
X-Proofpoint-GUID: AN_oT2kXl4ox6vI5O95yzgISCN4iKJxR
X-Proofpoint-ORIG-GUID: AN_oT2kXl4ox6vI5O95yzgISCN4iKJxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080047

On 8/7/26 00:43, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Some distributions provide packages continaing firmware to be run under
> QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
> contain descriptors in /usr/share/qemu/firmware/*.json listing the
> firmware features, so that environments like libvirt can figure out
> which firmware they can load.
> 
> Define an optional feature for arm64 firmware to indicate that a
> firmware supports running in a Realm. Firmware implementations need
> extra support for running in a Realm, in particular to distinguish
> shared from private guest memory.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   docs/interop/firmware.json | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
