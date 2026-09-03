Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFE3E0234
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462625; cv=none; b=RV+8jOsoH5FewMIlVyG1Ig8PTqW2BDJznaMKdEriOQccwem2BLlchqfIKqmMo1RwpmZoZxCz0yebBBtTSPNoSklLTsIzNoBQezxBdLBVqJsZMmo3OlU7NrbXL8ZvTpuNec/1H7hJSm5uQqHuobLGnIcOZa9VnGVIehuiFEpzea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462625; c=relaxed/simple;
	bh=YVXiIfDDibab5+0BuQk36zOYhFB04mk1Ldmhn7OWD4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IxGjOKhXG12k2HNcIle/VVMNAczj2J+KlxCUJOhvibVAtB1xWYpKCGNdDKjHVYrO/8XMxLgOCXb/NNJc9Q6+yZDM05bTAeynBGDvAKBqNod94vqCwhNO2EA+wzvQSUKerRX8XbU4IjgmraTnl4tvy0yuR2TG69kGff16ey2a7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OpgYyJ3s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OpgYyJ3s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G36et1552022;
	Thu, 3 Sep 2026 19:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mxbos8
	yLoUG5l05cktSa/eE5AZRlKkT5dnJabdMoKZM=; b=OpgYyJ3sqPF3icuS6iTwbn
	FOHlBKUKR6wHmG2jdtMQBw4E6g75uWShqPfqjE4eJo1AbZhL0VK4Gl0LpD86w7Si
	rLSJTKqXe0yr6BgUOXttE496jfWlv7FFLcQmdJ4ksWR75asESR/DdAJP99xWXgwt
	fFqEH9UtkzxHmOZImWm0FrM7f56IhNTVZ3Q+luONSgBe/oMWCUwFM1k6+rDgFENM
	HWO8JxCIc9jzpIQJqRpSxT4lSItnf13WyMqj/OHb2L99jz40CLznrhzNPxyjEFAP
	vIbTXcogz/KRD+5/AjpAuQYp55sazeTMlchtWevqwwZbhZPRJSAytGIw11KkgpKg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rpmag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:09:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IuFJp019025;
	Thu, 3 Sep 2026 19:09:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjasgkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:09:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683J8QNv28377652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 19:08:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E2658051;
	Thu,  3 Sep 2026 19:09:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2712C5805E;
	Thu,  3 Sep 2026 19:09:04 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 19:09:04 +0000 (GMT)
Message-ID: <11d6e889-80f1-47ee-9335-4bf267195246@linux.ibm.com>
Date: Thu, 3 Sep 2026 08:38:30 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: dave@treblig.org,
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
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
        Brian Cain <brian.cain@oss.qualcomm.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
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
        xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a99c5d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=mY-fmJR8b8s-Z9VvxFgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXw2J+kTXJGfn1
 WcWhJsEEKsprqlfsqYgONRC4tPrPl/KW2YAz+ydFFPqURQAQrEhHyaP1NbTccY3EX4bWXK+6Wfh
 PZPoupQ6vroqMPTRxYPXyvIlo9Pde8cY9PZtrRMd1WLBLcNgNkdxGXUjOf1al1kQlCaT/fgUheP
 SextymGwkZ+1EyES9LOZGAeq2zltAJg0fzgcv3jDIXME72pp30Fxe/iDyhp5UgQ9hakCCokkZFY
 +cPalHfuleHacrmfeiI5UMMqjUbkCq4OA51vdlSvSxxi9ZhQ5TTNEKTDu7BMXTZlaEhpS/8mZ2a
 kKpHFgwFEH89wGxyzHwgozJygrwONovF7HchBWxVz8ofB3EgcOTZxt19MgnlkyljD038D89HabF
 IuV64srRATcXIQUfjgW2xI7R6EWyQiXukBD4SrphNm8Aaxd7V3oevIPqBqTzL0NaZKvUSsm0X5J
 UfHxa3svtK4RJvpmOTw==
X-Proofpoint-GUID: EDEel76a6KP7UXpBN4hYy29pTPMb3EXw
X-Proofpoint-ORIG-GUID: D_tguMhPXt_pKc1lezcNMaHsq0mH3uUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX/J2dzAAJu03S
 g1YtSBdlCCJIE7nHnAUiSZ725psmXf0F20KoIOuW/wWMyvfzAGxXFvNMLfWO3M7cJsxQ023Xw5v
 v10N19VuKtRa4pfcSVV9QCnTqUVG/vI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030166



On 8/25/26 3:09 PM, Marc-André Lureau wrote:
> Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> the first parameter from Monitor * to MonitorHMP * to enforce type
> safety. The implementation is also simplified: monitor_hmp_vprintf now
> directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> dispatch via moncls->vprintf.
> 
> The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> cast, they are fixed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ...
>   hw/s390x/s390-skeys.c                   |   9 +-
>   hw/s390x/s390-stattrib.c                |  20 +--
The s390 pieces,
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


