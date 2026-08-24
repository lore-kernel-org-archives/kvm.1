Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B02264DB
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570161; cv=none; b=mvDAXv+iD2MEFhMNV5bPDmMFM8omnQzdz+vkCw1+yZ51buJvU6xi/EFnI9xtFnA3A6zblZkaNIU9f9nqeS4Oz3bneKrNrjXWMkvzjKheA5Yj8bcAiApWP3MRbU2TQ8suHEX3I4vSk6Ai8RQ/MayMbFHoGWhqzckgwZ5xovjye10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570161; c=relaxed/simple;
	bh=txohIZtN4z74Wh/xOHrmMgrs7LDupQ4cRkcquDgErOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6fDGhVbwgHTcoevDOEJQW5zb0irOTa2FWlzegAzmeN7J8RF29peAxTgvq+Ciucfe539WDxl2HHJj8ZbfwMtvXcJ68IxxZaMpE1aJ6qTk1LDUpM0z+oG8k+ua6EHTs/P1VK7lTRT75Z7NrfESsS/3+aouM4//jcBhZjUDmJrqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l+yVc8RU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l+yVc8RU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9WBvr1536243;
	Mon, 24 Aug 2026 11:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7fE0EvgkG89C1fNDvBI0IaQBaDJSj+
	jQhlRX+ZYlK4M=; b=l+yVc8RUphVULjNgyGNLbmUpNv3ceNL4GRBuCygKFG684D
	vXpn9ahEvDOfDNlmqQdZwO0pjTIWn9/4qrkRMTdTWRcR0x/Ie+oERlgBOtp+NIXz
	+tGz0VTDhUtmBvFrqUSdvEYbiZVoIukavt6aryNilFWZtUL9eRBWuFZmcwmI3QCH
	pYuApX8i7GW/h7LyFz2YFpbMLGkXlObVPA+ZDggfJpX1YyCHNX79lD1c1kyb5+jt
	qDK3B7+I0ER8UynU6wJiIeqSNfIhb5CT4TqWO1KsTIA056rbXdAmb0FhJm0LHhcC
	QwVAC3WJ9G+qXcmAgCZoc6165Ez82wUAi4XVOFKA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx0p7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 11:15:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OBBIqZ031600;
	Mon, 24 Aug 2026 11:15:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgwe37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 11:15:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OBFnat51249426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 11:15:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2202320049;
	Mon, 24 Aug 2026 11:15:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C2EC20040;
	Mon, 24 Aug 2026 11:15:46 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 11:15:46 +0000 (GMT)
Date: Mon, 24 Aug 2026 16:45:43 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
Message-ID: <20260824164442.c2943bd9-7e-amachhiw@linux.ibm.com>
Mail-Followup-To: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260819045924.11732-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819045924.11732-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MiBTYWx0ZWRfX6W1Y27d4MsjJ
 wyJuFjh/locVd9PcLPOt9TiAPl82GmztCgE4JHax/c6XtxGid5AVDOgegRHXZNWNAH/PEBF44Y/
 x969mML+clgnUGRv8vySapgTUMvqB+Y=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c27e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=7XnC1fpkjExzw9auK74A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qcnxhUkGFSfH1SH601jki6madvvgIFXL
X-Proofpoint-GUID: qcnxhUkGFSfH1SH601jki6madvvgIFXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MiBTYWx0ZWRfX/G4bDefC99tC
 4XUsoRAe44BLdV5LNDe813Gsz3KmCq0x+s3HZ5o2QeTMzsurQbmEiGcly6GtZ7NaLSOvKsf4+jV
 VDQuYqksMvbg2hX6qnGt3JLcJaIdhV4Aih5KE9h8gOhO7xVGdo5ScIaj4pIkVHmSvnn3jqs7ie9
 iCRu0kYr+4DlIHdSjrySXJTAighNrWGdB1Qqa6uCMW/3jbYZ2XoK6fOiv6ppI4gRCa1ILfh4ymA
 Nb23GXvvtPw5uYTF4yThZAeO8tS8okmcoy88i6Pvt2gaD2RikwbNqbRFQQRCVhXRRgHQzt1Nks4
 nR/eL5WMs9h74WOH6HRO//iYkAZvgiXupCAvrzuDenwZy3KGddaEYwhVCmS+7fSSE3GNdWKcNKT
 aptH46WIVOb2kwrT2+arK32XikEZMfGk6gBJjVIz80lxzbi/zhkOTsWteGh++UC334U5WnwqV8p
 SUgTFcFO4NXgVyiFXvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240092

On 2026/08/19 10:29 AM, Amit Machhiwal wrote:
> Sync linux headers from Linux kernel commit 1200d84f4c0a
> ("Merge tag 'powerpc-7.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux").
> 
> This picks up the new KVM_CAP_PPC_COMPAT_CAPS capability for powerpc,
> which introduces:
> - struct kvm_ppc_compat_caps: reports processor compatibility modes
>   supported by the host (POWER9, POWER10, POWER11)
> - KVM_PPC_GET_COMPAT_CAPS ioctl (KVMIO 0xb8)
> - KVM_CAP_PPC_COMPAT_CAPS (cap #250) in linux/kvm.h
> 
> The sync is needed to get the corresponding Qemu series[1] merged.
> 
> [1]: https://lore.kernel.org/all/20260812170854.58709-1-amachhiw@linux.ibm.com/
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  include/standard-headers/linux/const.h  |  4 ++--
>  linux-headers/asm-arm64/unistd_64.h     |  1 +
>  linux-headers/asm-generic/unistd.h      |  6 +++++-
>  linux-headers/asm-loongarch/unistd_64.h |  1 +
>  linux-headers/asm-mips/unistd_n32.h     |  1 +
>  linux-headers/asm-mips/unistd_n64.h     |  1 +
>  linux-headers/asm-mips/unistd_o32.h     |  1 +
>  linux-headers/asm-powerpc/kvm.h         | 18 ++++++++++++++++++
>  linux-headers/asm-powerpc/unistd_32.h   |  1 +
>  linux-headers/asm-powerpc/unistd_64.h   |  1 +
>  linux-headers/asm-riscv/unistd_32.h     |  1 +
>  linux-headers/asm-riscv/unistd_64.h     |  1 +
>  linux-headers/asm-s390/unistd_64.h      |  1 +
>  linux-headers/asm-x86/unistd_32.h       |  1 +
>  linux-headers/asm-x86/unistd_64.h       |  1 +
>  linux-headers/asm-x86/unistd_x32.h      |  1 +
>  linux-headers/linux/const.h             |  4 ++--
>  linux-headers/linux/kvm.h               |  3 +++
>  18 files changed, 43 insertions(+), 5 deletions(-)
> 

CI link: https://gitlab.com/amachhiw/qemu/-/pipelines/2784536213 (Passed)

Thanks,
Amit
