Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FED471CFB
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056347; cv=none; b=QD2L3Vt2CeWzVXUB95Lmk0mSRfi7vMwSFmW1wGLDWq8Yvsf3ioILx9xmwuA5HzQWk9NYkl+NRP5SUlofMtZyGMS82SczSVs95M/nSnkwu2faSrPsUYuD0Q/D4dqMpCaeu2QPKRZXCEEyoHneVrzWhfB+Zzn2Bc1rfr3Y1IOerZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056347; c=relaxed/simple;
	bh=TwLYjHrNgH9/QEEvGWBb5ZWmCFj79XAp1biZL0f+zJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p82u6Xi2ZEQ49Z0m22DphTIv8CIvzbCwOhTeW2wxXHFvzGe8EbjFxdzqpJwpOX+znWeOp/YQhL9XkqlmNtSauHlS7EWy6GLtl5cwVL7+BYwBXbEbJ9NJ0Ck5rHTFdVowLlF/1ylYpc4qB01Srvg/tl3GS73k47PMGPix2nmqDTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rVkiRI0U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rVkiRI0U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAVWms2355706;
	Tue, 18 Aug 2026 12:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xmv+01
	hznGjZgAA1YW+EuV/P3ZvDSfWfrdCOOtSJBZ4=; b=rVkiRI0UssS4pX/POE+jK8
	75a8lE1wmYrHtad/g4RfPMSj185IknqxcVhJzxf8/e7UdpYLI9xdSCtiMh5hMLDv
	nEtHq4rab62tklif7hvkK0yLOcEVqCngTcD4+MAy4NhHPW/39VqEopM6+XnxUsn/
	ix+MvuIR1VobBAbg606U8tjXTQG6seghKPDOao7I2R5HMjHftQoSd0Wl7ugllG60
	iPR8SkwI0TF/RnnYf5ip96M306kLjc+ZZCzfBTbBeFonyxK8pr11Ci21NtmZS4vT
	pbb+0UxhSBXeSH3kH/ovYYDtW//fDIqpDlTFh5wme7HFcZNzJIIldRouAdiL8fEA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqr3un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:31:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ICQKbY020416;
	Tue, 18 Aug 2026 12:31:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngay0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 12:31:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ICVLhB18678424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 12:31:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA1658059;
	Tue, 18 Aug 2026 12:31:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AECB58058;
	Tue, 18 Aug 2026 12:31:16 +0000 (GMT)
Received: from [9.61.88.99] (unknown [9.61.88.99])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 12:31:16 +0000 (GMT)
Message-ID: <c03ecde4-100c-412e-91a7-e0b8eb7f6887@linux.ibm.com>
Date: Mon, 17 Aug 2026 14:08:11 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/49] monitor: change HMPCommand cmd to take
 MonitorHMP
To: "Dr. David Alan Gilbert" <dave@treblig.org>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Ani Sinha <anisinha@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
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
        Max Filippov <jcmvbkbc@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
        kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
        qemu-riscv@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-31-e53fc35bc550@redhat.com>
 <aoIw5i_T9xYZ32SV@gallifrey>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <aoIw5i_T9xYZ32SV@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX9kbmt3jT1THI
 1DTSxZz7PhXQulHeaLRj6pQ5taTy6aCctG7VUKiIvoC5sn8dWUveahtjlDHu8syAo5vZSmHIQRR
 musqzEkKKA555RcPNESgvuzeLUMUwLpyfLCzWz9wJnnnSD9YCeSgXZSwC3AYr3jBMx4WiPKyfwn
 sDVXwFwgDzri9YTYnaunez4Ft8QyIP1hZ/9O3OuCRHZBaz02hkMbPlTzNTsjs3H6+rdQ+hkp5Gw
 FVEjqUVdITctVKIUswGWGiGDe32ZFT/bJ1yEMyxsHg5YD7pHfnoZxj6WF29WVryH5m3Txl92Z/k
 MJDuLJDbYAvtwm2o0aVLNJSkVYPK4+UPQP49RxQjpaE7ssD5vrp7L5016oH34ZSyG0EkIQEXJWR
 0dbwBC3vbJ7qxglCS9RbUqQPjPPUB30z6CsHWSRGQViWLVpmzx8TXM+tdfV9tEEezXqfoTtM9KP
 eUnX9imDoAwnIGqA3jg==
X-Proofpoint-ORIG-GUID: wbG5QAZcn_8JPq7N2sJJMyuRn4dbOM1K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MiBTYWx0ZWRfX6yd4Ng0ah684
 hqLLmDUefkN8j+1w/9O6OCVbU7QA3u9faIKbcpo3+Qmje54ej8TJpIXUnKfMQMlx96+3vc0VPu/
 PrvKyJthYmuPmK07wdItco007ZnkeSU=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84509c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=3WJfbomfAAAA:8 a=VnNF1IyMAAAA:8 a=6ru9w_5K15hS-t3OnE4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1cNuO-ABBywtgFSQhe9S:22 a=JSVlQr4fib6YhFFKv7Hz:22
X-Proofpoint-GUID: Qnuhu8KQPs9FZttUWEPShqesQoGH2wRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180092

On 8/16/26 5:51 PM, Dr. David Alan Gilbert wrote:
> * Marc-André Lureau (marcandre.lureau@redhat.com) wrote:
>> HMP commands are specific to the HMP monitor, so make the cmd function
>> pointer in HMPCommand take MonitorHMP * instead of Monitor *. This
>> strengthens type safety and makes the HMP-specific nature of these
>> handlers explicit.
>>
>> Handler functions are renamed to take MonitorHMP *hmp, with a local
>> Monitor *mon = MONITOR(hmp) added where the body needs the base type.
>> Following patches will drop it, since most functions are HMP specific.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> 
>> ---
>> ...
>>   hw/s390x/s390-skeys.c           |   5 +-
>>   hw/s390x/s390-stattrib.c        |   6 +-
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
