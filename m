Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57726384CC3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592749; cv=none; b=FVHEmi0Fn2IugAjkQdvZlrKSlKLGqTOD5bNjM4yXCKRQF0m3Ixu8VWAWAczlfAogTVnFc4ISZ0HUSsHBLZ0LU8uHb9WZxBvPvVEDmYlR4mmvrXDHT4F2Mse5ngjG9i3cbDKkadilP5bOs+rBPbKcWeCiRwqfJJoDfGdJ8tIkeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592749; c=relaxed/simple;
	bh=bhdO4flOs4+fX2Azvk27e0uqGHM7wGRppmyGA81XWPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaElpGrmv3BX++cDI07kwxFVfWjAll0ok2VD95cAfe+NqzqkUySPxICZ5n0IWTOh8kY2eawLdbHflUesEd5arYYrSAX54LwrIVWa3iWEs/fjvNa7tkXnr48gJz/2xVJpbUY8sB9ldE7Us/RbxWa0GxDHh2u5BZCzFAaHafIKjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AkLJdsyu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AkLJdsyu"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Bl6Kf2915495;
	Thu, 4 Jun 2026 17:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p4Xgiw
	pwNcqtviwucTNW1b2BYDRpg+4tcj+RIWFpltk=; b=AkLJdsyug0KcLDZKEvWNeV
	Ru0o/k4Yl8CcfDoghsOW1AYGWfiFEHzrDh7rL32sNmqwC58wVe+2mw11FIfnX5FB
	dioylPtzsQ3DWC0/UApAWHGirW0EUysuP0iMvHDltX8rNlh2fsQYwU+LqU2GKb9J
	lI8IzLAk65g2WPw8Xp1ylFPEUwQCU+87R7ghV09E+tW/0feJa2TyyY6fwCoBPsKt
	JPBoLKfpS7rqpo6rNGoy95k0Wy5T7dv88VBnVi6Qdrqcm1ECGK7fYUDIxauPgguu
	z6wF0p6aZp2gZAcsISpPkzgRnF4/sLn/rBFZ5TOCElNLsIzrBrNdBaQIQK0uFPOg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4h096-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:05:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GsUH5013669;
	Thu, 4 Jun 2026 17:05:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhnxaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 17:05:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654H4xZB31916702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 17:04:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34E9E58056;
	Thu,  4 Jun 2026 17:04:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A1285805A;
	Thu,  4 Jun 2026 17:04:57 +0000 (GMT)
Received: from [9.61.150.19] (unknown [9.61.150.19])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 17:04:57 +0000 (GMT)
Message-ID: <8a8bb28b-0a83-4318-8d22-8cadcc8b44d1@linux.ibm.com>
Date: Thu, 4 Jun 2026 13:04:56 -0400
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] accel/kvm: Convert AccelCPUClass ->
 AccelOpsClass::cpu_instance_init
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
        kvm@vger.kernel.org, qemu-s390x@nongnu.org,
        Chao Liu <chao.liu.zevorn@gmail.com>,
        David Hildenbrand <david@kernel.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anton Johansson <anjo@rev.ng>,
        Claudio Fontana <cfontana@suse.de>, Eric Farman <farman@linux.ibm.com>,
        Alexander Graf <agraf@csgraf.de>, Chinmay Rath <rathc@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
        qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Reinoud Zandijk
 <reinoud@netbsd.org>,
        Halil Pasic <pasic@linux.ibm.com>
References: <20260529194940.97143-1-philmd@linaro.org>
 <20260529194940.97143-11-philmd@linaro.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260529194940.97143-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MiBTYWx0ZWRfX6SKsmZPamKEw
 hAegcVAY7sbaU+kEREWHN2GUhhBw3tr9crTHdtocaSfIbCJJKpBkIcMHw7Ff1B2Ix8o7Y0H6HQJ
 spHetPBInGz1TWOKlVe8G+FaIcTRcwF4wLZUBQatRuu6vpjIyowGRKmYvoJTo2/Fdf5pb8j1FG0
 tBQ+CFu+x9ux8ySAOwqRFFaL/CM4eug3VHkSn/LjjSV5GPHLpzDoaReausjjc32zgMz72rgn9vk
 QUuW/iz92MG3EOlPWb8ju4guenmhJy+bZfoqjJaIJ8rYLdvOdijRBitzK6/8cj6dUJvzBX1osli
 DcaOUkvgE0eyNTbq0sRXQfH3rAOG7ie4ueTuvNyM5OGmvYQJ4XRaKpjx587Ei5/RrjiRoYNa2eM
 mbI5/ttRgtMv4mkrlx0bOabEtGBoPOqFFf74EGxjNzt3fySpc5j7X1y/JFGv75TN3pxBGQ59pq5
 djfsuvLwCyYuSTWrQGg==
X-Proofpoint-GUID: J3p9eVcpPQLcbHVGklWNXDB1k5xVt6hI
X-Proofpoint-ORIG-GUID: vAscEASaH0hUVUHef8uLod7HMrYPWn4Y
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a21b03e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=oNFF6uGEv09ksA5f1voA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040162

On 5/29/26 3:49 PM, Philippe Mathieu-Daudé wrote:
> Expose kvm_arch_cpu_instance_init() and register it as generic
> AccelOpsClass::cpu_instance_init hook.
> 
> Both X86 / RISCV's ACCEL_CPU_NAME("kvm") TypeInfo are now empty,
> remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/system/kvm.h       |  1 +
>  accel/kvm/kvm-accel-ops.c  |  1 +
>  target/arm/kvm.c           |  4 ++++
>  target/i386/kvm/kvm-cpu.c  | 22 +---------------------
>  target/loongarch/kvm/kvm.c |  4 ++++
>  target/ppc/kvm.c           |  4 ++++
>  target/riscv/kvm/kvm-cpu.c | 23 +----------------------
>  target/s390x/kvm/kvm.c     |  4 ++++
>  8 files changed, 20 insertions(+), 43 deletions(-)
> 

For the s390x changes:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

