Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D32D0605
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815344; cv=none; b=Dm5H2rpBg6GTxxHqWtAe5sQEwR+z/G1yqW1KHr5yJb/Bwy85lEwWk1lZWh1RLu7OGzM8+X1d8AI9ugYOK9UT70gVMKjz+ZYp38RB0AFsADWsOFUEG6ze1vSI3hWFUi/KtoGFuY4dYZxSVb1kmkOtoAsdEdASSq+X8NGFSuKmZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815344; c=relaxed/simple;
	bh=qKW0gDt1OR9zNac+qy6z7BfmoVnoxS9DLrbycR2L7Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IS31h0aH344Y3I3BTPKxPCRTIPNrmXzBHoIyo1iVkVflv2dXcTkK3d4DYVbNr1yVq3aduMAb+7BFMbcyQWuj7Bb0MltQhPOCOOhcp3ij/fKMK5nlZLjQWVzH4exaDHh9xfS32YmgK/MdZBB6R2W0cz7dAXR1NUWxPYNM+3M2oys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3j8H6T3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cdC76Z1z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m3j8H6T3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdC76Z1z"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IHrp6k1922268
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=; b=m3j8H6T3xSHDlP05
	DsOXnhVYgdQkaXMAbD+dyRy+AFMOxcYEyyreXKq3pvh2a6TG65skdIExkk69fEaM
	EVDIoONshs45w32883LhC9w8I89lO4oL64ceYvqcYHYi34C5ldR31fdJhW6CF5BA
	TpEEVgPucOfEYC1r0Y7wk5N72/YU1dqrkpjDLtiO35HLprybZa0bi2ps3CIx/Y3g
	B8ZxGrJbdNVt4/9xmZEKX8AYE/Fx2ionhnYeMB7nB8ePqv5yeHKYn14BxThV6fNw
	WPkUn5lR+aOoiW158xMUl5Ke6sa70X0PHk+0UbK6JIpT1ZRWN/SwaMjBRThFwqcL
	wuDGUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn42u54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:42:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9208aab5133so30450285a.2
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781815341; x=1782420141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=;
        b=cdC76Z1zpdlMgV/tWuEDNwei5zNMFAS5ge/K7LTPNtoRlcD16lSjUJJHB2LZLt9aDT
         ZEf951KTltXaBHncZn1drqCnBx3ILCbOVMAB+AR/CrayisiTEJh0AOiidSWRHqlpEEef
         9p1yDrhFoVu8uZ55n8osXkR+3/GY0k4lb+rRksz7hAtsVRrUrXvRc68OyoCn1fm9kMiz
         Zk1mVcvf72f9WIs8owrhv33UmqszgEFRs4UKBgS3vLRixkRn2GbQmncvDGYXW9e1WLNO
         CN+7wLbtUmSsq3rVzcBMBxJvbJ/J/Z+0spXm1UKkGeNqPcIC9snnMpmIRWe24IAMS+dz
         mOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815341; x=1782420141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=;
        b=a05xOAPi2YDRtasJSUci2YEtSlDN9CjduaO6Be493YeEU7IyjhWmnKKgF1xBcdtnEu
         Bg4w5l5NCVPvExVFjBZCnybMHdcOMuUGN9/ucI8GVM4WQdgA/ASiGWWsOQ22frXWTmHd
         qbl0UsLZilgAwOaEfPU706lX4VUW1PTcPMa9eeHpcRpMWNhprKkra8AQv+/taDFYxRqO
         KEKVfUwzBsxPP9DWlqMZMs7/4obD8dYAWEsVP7RAy0rsIL0edEsi/rTiL4mcYfTjjvOS
         vAlDhgrezOFG8kmevdhbAdx9iaIO41MQQoGXyo2xRmBA3CtzCStVJZyWknPW0pk9Cvpu
         2FOA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vr4CeHaANoUNDuxQvDvKryoRqrjZq4JuXNqr0l0Xqyj3q+AKRI1TlWCwgT1EuEKz4iYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpAOt9o8ZPEOfobEDWci3y5CcILleZGE84iR5DF8C34dFXS5g
	tXUIhx1nKJHGpPqSq0RLRRIImogZGt7dOJvekTmbFmN12W9nXZXjqLvAGWQs8UoGV5KYcjxu/+W
	dHuQhQED1aytB08AvIt67DET1R6bTIWdx868ZEFbvcA4Hp21VE1S/eTU=
X-Gm-Gg: AfdE7ckstacE6MVW2WCNvLckRwQftzMkK0WdWCxSG69Yl17kbBWPYn7ofZo/sTfh3tr
	PbCwYVEpbcSdDcww3yPMyN+VdP4iaPFNJChHKKQut403pSsWW38SMA9pnVvayC7eR83KtbeVh5c
	/TT1wER4H/zWoD8y0b+qXE/UTZ/EaRXCaalFHbeQexgQw/L2v1gXjFiIiMaVJCrf+ipKDkW8qBV
	8ND6EgwYCMQx0Xh+GauESthUAkUu4Xn5FPm/E0cdXW/5Ynb4EWcDdgMmXWShCvhuQq5x7EWmskv
	olOvKYbSiQFDXZa+mJLWQg/O1iLIWVjbkhnvvRKT+DQIfB3GL6w8f08VDHafIMTsXw/KXcKqrQm
	HJrpoag7dcBK+Smuj3pVVHkiG5ydOO/uPj31UdlnJoQYfcX1Emr12SkuTbvK2YA==
X-Received: by 2002:a05:620a:6499:b0:915:92bf:560f with SMTP id af79cd13be357-9208d8e4241mr111206885a.36.1781815340907;
        Thu, 18 Jun 2026 13:42:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:915:92bf:560f with SMTP id af79cd13be357-9208d8e4241mr111202485a.36.1781815340478;
        Thu, 18 Jun 2026 13:42:20 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc42a3asm1586883f8f.31.2026.06.18.13.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:42:19 -0700 (PDT)
Message-ID: <afe3e819-b36d-4e9b-b9bb-1c978a5b0f8a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:42:18 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] system/memory: constify section arguments
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
        Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
        Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX2T3X2oPD9kyI
 nyb4myONIrnHzGYjPK2Twwk0p7D29l6uKJdv3/fcbWnhIX5R83w38CAszCE2gOPsKDpwbwQ84LT
 K3YHC9dyL/cNADNYot+bHwY00jHcVHMlF2LtjlC9/d5Q2CyPTxLxQlxdLk6LMXprGqAL+vdT72S
 OYVOenzfJ6DfquWH1euPS2LQHFJO00EAEPo9Wl6M1tdCqT0n8NbGzIKMQjx8OVP3Me/wrLnO77q
 jcDxJoEBWscXCqOUf81bWkL99I3wTnyE36Bq2jLpY6ISt7er1KKWKcGYbp7AtAPsZRODMf5jcL7
 mTnk1+GiGj9rjUkUCwlg9+7qoo22X6841uN+hbQY9R3GoNYS3yBC08RytyidTM1eSy4ie9D5Ozo
 XJbE7hdU2++cZiq8OkmaFFueZ8VNCZA2y/5jS7tP8HON1gFQ8CFVnE5Ln2Yuc8MJA7FKJvAxyJ/
 ubrDnUheRBrIHeCzC4w==
X-Proofpoint-ORIG-GUID: p8NhbXW7yAZTHv4PKmajpwdY7NX064A3
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a34582d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: p8NhbXW7yAZTHv4PKmajpwdY7NX064A3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX/wSYSpENrr9z
 4zq4FpwtDrKPDzxpK3QXOtuKMXEBtmPHaIEu/bhIwygeP+tAaphpYQ7xpuSu4MWTqU2Ds8E6nr1
 H4A01fhGJvR45DMt6YKqV05drABtNZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180189

On 4/6/26 15:43, Marc-AndrÃ© Lureau wrote:
> The sections shouldn't be modified.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/vfio/vfio-container.h     |  2 +-
>   include/hw/vfio/vfio-cpr.h           |  2 +-
>   include/system/ram-discard-manager.h | 14 +++++++-------
>   hw/vfio/cpr-legacy.c                 |  4 ++--
>   hw/vfio/listener.c                   | 10 +++++-----
>   hw/virtio/virtio-mem.c               | 10 +++++-----
>   migration/ram.c                      |  6 +++---
>   system/memory_mapping.c              |  4 ++--
>   system/ram-block-attributes.c        |  8 ++++----
>   system/ram-discard-manager.c         | 10 +++++-----
>   10 files changed, 35 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
