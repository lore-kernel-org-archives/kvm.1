Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7030F92E;
	Mon,  3 Aug 2026 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742577; cv=none; b=Uf4AQEE9l6vCiEV4ZJBiYKUfJfKC5H/EtYf3AF0CXCnkE4th8GyxsXM+RtZu9wEQMuhfCl4f5CwSe3PNZ5O4JchbH2ulSE8GiLuJkzSKzFhTap8y1Htz2ELPepkRUxsvIiQ2OxhHmut3YHY0BNlhKPgP2batdlFGcfN60aVZCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742577; c=relaxed/simple;
	bh=MLbthMci7xN7+BaVXFIclZZ6NUEKVjykn9NnESRWsTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYqCMAAJQG3xExUGItVGCTJLBkrFMDFY4ervolpQ26ekCw3TmU4fJcaVgPlScaV1v76vTGiUU2sjecBAxKkXrmnoOpOy6/nP4Vpk3yYofWoUhwGs0OBGeQM/WvZrmMw3AEanbUg3C/O7UximtZTgds3fOvvJjgY/z4Sl8Wz8kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFr8Kgi/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFr8Kgi/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmGmO161234;
	Mon, 3 Aug 2026 07:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k05fDa
	9assDlL2WtWM9/r84vAk05owIhLl+YB2vjjPw=; b=sFr8Kgi/vtPigOZPhtzrJG
	y2Tnsfz2pcc5H+6+eAnpHFvUMT1NkRXJDZzshgrQVcYkFAmBk2GK3intxctdS48b
	J/JeZ+Sscx1mXu82of0sw6HxGHnL0jTmx9G/6Z0SXzrqlVrBzBkN5jYiGBaW9w4i
	blV+zqFRTda1Lzt/oXRB7Rqb/oNRz6A1RgGPM41Th4VUIi7CelQHSdurMid7Y6O7
	FXuLaqVkbafNGjiC5kvjGXVSv3Zb9bscxjGl5CroKsJm2/HXIgIf1R8PTSQjLf+O
	N7Sr3Gsp/8yOl4Hv6YAtnecENWUmStOZrjNDTvQk/TItYYIOWtQxsCmyFFWU+RJQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hfev3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 07:35:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6737QKQo023118;
	Mon, 3 Aug 2026 07:35:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qce7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 07:35:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6737ZsJK50135502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 07:35:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FEEE20043;
	Mon,  3 Aug 2026 07:35:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135C72004B;
	Mon,  3 Aug 2026 07:35:54 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 07:35:54 +0000 (GMT)
Message-ID: <fa4af6fa-d1bd-4e9d-95be-54f12f5a317a@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:35:53 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in
 the main KVM entry
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
        Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260731173842.2649391-1-seanjc@google.com>
 <20260731173842.2649391-6-seanjc@google.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260731173842.2649391-6-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA2MyBTYWx0ZWRfXwQDhXiUV1+sT
 5hkwuVYobhdniXMnTtLhNh1stBxazBPQK7n9YweoHQGOv77Xk5loWN8t+O9IJ/RW5rfyMqQ44ye
 1hOjmcmRwMymw0cD87Qwd/E9+b/IxHY=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7044df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6y9mIIUkAAAA:8
 a=VwQbUJbxAAAA:8 a=W-_n0kkjAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=Ecsn7Dsdv0dABK82YRoA:9 a=QEXdDO2ut3YA:10
 a=BT1tkpHCJze4Rb8jY6gx:22 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA2MyBTYWx0ZWRfXxReA4K/9qVKe
 FSrI2zQV5Nub9KiPM6AHsQzoVrDIP3X0JYZq4t4jThVMaJ76D/t7jB0yO2jMnD5gpSV0o8/K6Pa
 r3O+DOu0UgR7zu9BoxN6y0LkXs/+lCrO10PJB8YuNX0SteRasf4afH3G11cC61houAMNod352We
 0mRqe3pmjWuzbce3bquuc2WA9o2AFLv1tsc79vR/K+Bp5Xb4w6ZJKUFEKUrn5jTpgJMUwc/SAVt
 a/EeeTe6v3GlGf5eX2iKVFGkFAFH3wjGZFdcCuwscGniw6XmEdqfByc8EDWieTalAEvyo5mHtwh
 NHl3uPYCZlBj/Pw/re1vHGzQ75F3TYtUhihuTGAlz/LHKACbfr6w3uKqbt5E57Wy5tV7E4KlAmp
 umhyL4pqLNV9b6I6Sfre56S+cf3Q8zUzSBTpyIIa55eZc4xmAi15kKuYqD3WGSOalUG1KzboHYq
 i7UBZrb8skjVytjHn8Q==
X-Proofpoint-ORIG-GUID: BMtiM_6KjwB2zCvVIQLi2eE-84xAVp0b
X-Proofpoint-GUID: a_GsYzzJSCtyJczOgPWtAuMatbdLdtUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030063


Am 31.07.26 um 19:38 schrieb Sean Christopherson:
> Add myself as a reviewer for overall KVM, as I have been helping shepherd
> a decent chunk of the virt/kvm commits into the kernel over the last few
> years, and I expect to continue doing so.  Of the 270 non-merge commits
> that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
> and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
> coming from non-KVM folks, e.g. from treewide changes.
> 
> Note, this intended to purely be an efficiency and quality of life
> improvement, for both contributors and myself.  There is no implied right
> of succession or anything of the sort.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oupton@kernel.org>
> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Christian Borntraeger@linux.ibm.com>


> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c79bb25522f..556ccf640516 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14047,6 +14047,7 @@ F:	kernel/umh.c
>   
>   KERNEL VIRTUAL MACHINE (KVM)
>   M:	Paolo Bonzini <pbonzini@redhat.com>
> +R:	Sean Christopherson <seanjc@google.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
>   W:	http://www.linux-kvm.org

