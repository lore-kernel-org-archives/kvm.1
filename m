Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A7481B1
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056459; cv=none; b=LBU7Nr8AP4UcN6KqlIKW0TcsQ1S4odXmeEiEl191UqpoKp4jZvZIi9hTzF1uauqgXPw2lPPz4FTGyEWTUFMiJBmNrmEuFFYf8MOUPfzZjT0/ylO1AQnCtFWTTUCF/v9Txz9HntphmBxrlboWwt2qXLzGRSLs1Y7+eLKQJlFYi0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056459; c=relaxed/simple;
	bh=NszodI50ve9a6g+pjtNG/DG1p9tVpz1K9S4rBh4kzc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNG/qebLCy7tXtY13H03rK8OTxRrT+hl0B2X1+A0TpjqC4NEk4K65dboQvbKC11Xno3dBY5Zw4zjqTd/XdcPhKjO/zAREOSCv2yuuugGP9Eraly5dTSjSxfhbtLNZspQ8p2VY339XJAjT/7on+UOHtdLrcTyY7jeYLmWo8OQvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QkqSMCOG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QkqSMCOG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVemZ069954;
	Tue, 18 Aug 2026 12:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OVrVAH
	poCf/BmBSpErJpQ/RLzWgLb76r8JlqJTLkKus=; b=QkqSMCOG3VpgwNIYMnc00Y
	STZW6sRTh4bjLZD1yyzWsfpPpestmCZVeuwt/vNBiXHuG0H5zzJFooXoIL3Wp2M1
	hBNgHzI56cJmCj6syQ+JcwL5JZYPWQEfpkI4CSKRTjePP3AoUDkwTLlNYhwO11ks
	eKyYxBCuegurEiZhAVYwvjyDgXmE9gF5AKwmMF3KPGU9KGVaZrYbQ326TZLRRILZ
	8eiLFvjWHh9QWAwF0DR3JBpCCDxC2esBFCblzcQhF5EbiiFE6T181MPyZs/wJLx4
	SOss8KhatLInh/QuxbFlSW9Cp+PSO+7ZFbPGHuNZwVAzz69sB1feu2VQhQuS79BQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt7m33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:31:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICQJ19022995;
	Tue, 18 Aug 2026 12:31:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yaww7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:31:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ICUrpU20906588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:30:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5385805D;
	Tue, 18 Aug 2026 12:31:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19455805C;
	Tue, 18 Aug 2026 12:31:27 +0000 (GMT)
Received: from [9.61.88.99] (unknown [9.61.88.99])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 12:31:27 +0000 (GMT)
Message-ID: <3c4cc077-ffe4-44af-9bcb-1c0c0a7a0531@linux.ibm.com>
Date: Mon, 17 Aug 2026 14:11:14 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 41/49] Guard HMP command implementations with
 CONFIG_HMP
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>,
        "Dr. David Alan Gilbert"
 <dave@treblig.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li
 <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>,
        Yoshinori Sato <yoshinori.sato@nifty.com>,
        Artyom Tarasenko <atar4qemu@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>, kvm@vger.kernel.org,
        qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-41-e53fc35bc550@redhat.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-41-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8450a7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=6vjvu8HhQ4Mt8ipGFg0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX+VhBvebHoSgA
 bdcBt0hUMx2u3qzgtd1xVcohZkWYklfgUPDdgR7rZy7Ov9aplI0vfbF/yFds6jFpAV5jaXsD9r5
 vLFuPnnMgBhpt73IxxiWYe1P/1VypCk=
X-Proofpoint-GUID: yTn3FZ6qFt7CciM6GCDlfTK-glHalj1s
X-Proofpoint-ORIG-GUID: _zrDuqqnAULRzyly31YofOxyJFNp9p2i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX//3f8rgbsedR
 eR4KjqWFae+GjlIG+s/6t5LB7iABK/UnLTK9tR9eEXE20dEZQTTjuB0Z+99eZR30uLMI+h8XSmQ
 kvaJxl3Pifo7SK5JWjLTmwpnpdQtRFayZLVlXrrOPAuE1HgZxS1/8QtCBqN6WZ54IsMo7SGyqUq
 1Zt7+tdQ1ntHUm5PQsrP8ZjubIw2Y2vcQKDt3mGYU2Wkt5tDSbKJE2pvJLaqdcA52ZU5tQcSmpS
 Ykin8+uHFX4eIpOPiR4zlPtJ/fg4obtxU8wcEEdMPbUCW6KiBCfTcD8GYsFSkCG7Tk/K7SAU1po
 BxHkDT8u/UqmxAcZNucYkRlf0h71UANwH1sLFnJZjl2apo6S1F/o2GDOzIgzkc3L2nWPfirPpFS
 d2nPgqO7zuGoPx4XS6RU5ZCwSCA7/f2J5JrCGAySZeh3Dd7wAw6RIFCM2G1DN5H6xE/iqWBkIMf
 nrXzrOttlJ1NKrR2tnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180092



On 8/16/26 3:13 PM, Marc-André Lureau wrote:
> Add #ifdef CONFIG_HMP around all hmp_* function implementations and
> their HMP-only helpers across subsystems.
> 
> This covers monitor_register_hmp* callers, hmp_info_* handlers, and
> HMP-only helper functions like slirp_lookup.
> 
> To link succesfully, use empty cmds tables in hmp-cmds.c (to be removed
> once meson build-sys is updated with !hmp support later in the series)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ...
>   hw/s390x/s390-skeys.c     | 2 ++
>   hw/s390x/s390-stattrib.c  | 4 ++++
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
