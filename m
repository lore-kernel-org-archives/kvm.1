Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168A3FA5F9
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815326; cv=none; b=BXMTLwYZ4nw5y0vgU7DhLyqC3WE5FIS/ctqJUECT/jhIjcCvfrjl28kpov/hY/syAsPnP31ArigjipvYKxmBxxmzBm4i5mqJGW9oYfeSNIruVgmuM/JBA5lr6KJmF0jOy0/qHq+6zJynqwS3gaym0TUh0bVwYgt0xj9jctBc+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815326; c=relaxed/simple;
	bh=oyub+okOCTTRFx64T8F+EidUoUn3TZG1WGvWrxz0qn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmPoPFEg8OVQ12ojMJfqjzsFY+elfQwVnSr95fMHs37mddvZ0yCdqLTJLPh2C2AudfD1J9wTtdQEEHVP8cA2q2Eclp7fkAvBg/4dkR56S4cIHAzO4VaN688wbf7GgQnzYcKS26otmPhb5kVjjjFDoiiQDisn0d9incIXpMTvtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PgKinR++; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PgKinR++"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QAiraP1587136;
	Tue, 26 May 2026 17:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=iOsAGGBxu4y/bLdZ8NQ01bqe1vgK58
	XZkO1H7AH6E50=; b=PgKinR++mc4HlNP/j9C0VTg7vA5k/NEyEyUC0uUWTnN/LF
	fjydWH/BrREK8rUGU1a97U13DaHG6kA0FdOUEwGpSGmnnvH5dihUTl0zUFn7ZjqN
	QJLtu0W6Av/cb6NAt0/QYWqZ3wlbs+cNH9H/XdUGFOekMDhwR/oThYZyLDnIUvO0
	QeNIG5/cYehCnrB5UqhaivNQonYb1JqBGaVHKdh+1QyHbGyI806zVxaVygNP9vcg
	8//woSIyvMSs5NBEKtebozy2Yhdqwoc599g3EJKJTCPK0T+F1ccg32WH4+kBHD8l
	0SzG44YikllBHCgcP5nVDJg/RaYggVTduNh+Oc5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2dbqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 17:08:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QGsEJu019321;
	Tue, 26 May 2026 17:08:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxw2gjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 17:08:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QH8aX561342094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 17:08:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 675092004D;
	Tue, 26 May 2026 17:08:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3443C20043;
	Tue, 26 May 2026 17:08:36 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 26 May 2026 17:08:36 +0000 (GMT)
Date: Tue, 26 May 2026 19:08:35 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] s390: kvm: arm64: add HAS_IOMEM dependency
Message-ID: <20260526170835.185462-B-seiden@linux.ibm.com>
References: <20260526125220.1560451-1-arnd@kernel.org>
 <20260526125220.1560451-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526125220.1560451-2-arnd@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yj7rzREyNzZpKVzIe2eccHAeGW062O3G
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a15d399 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=wJm73L_8nNjvlac3yTgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfXzPBqabrkDsT8
 CrU3MOdVj0/xs/k1xKvb6LOhmwydm7dXHEbKt8yx1cJ23dY3+syrVDaS1SVyfomOYeHarIsjmmu
 LqOdwIEfw8SM53b8Yk2oFZM2b9AzJlY+N8eNiCirf6kyjlk5CdcPfOfzAvMnWNt+m3Q41iV7aAx
 fEk/fm4FKuDLZkc6Ivd3C20Xz7zUigtk2aaLKo4fpWfNW3pWW9oZBTfu8nKrUjecbsVpfdB9DSw
 b07e3mhQB/xAo/xWIH9ayC8RMHeDd+KHH6MIQVM0PFOBd1ZLi//nYiIOPfI/T4twrD+/e4Y818X
 FbbHOu+AtG9V+G4KgV9yqhdcxBR6BDZliJjD4LndWCiNkAad0R+xpt3F8EQbCuNtm5YtEeKWJt5
 wWaNVIK6mZz41EttfYFpgwhSOvBAR11uWr4z2gS2nPLb/oV4Qehe5YldRXttBtxx9jVyyuYQ8p+
 mX8Fz//6U/rjwUzTDfA==
X-Proofpoint-ORIG-GUID: Yj7rzREyNzZpKVzIe2eccHAeGW062O3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260149

On Tue, May 26, 2026 at 02:52:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arm64 kvm driver can only be enabled when MMIO support is part of
> the host kernel:
> 
> arch/s390/kvm/arm64/../../../../virt/kvm/arm64/mmio.c:120:27: error: 'struct kvm_vcpu' has no member named 'mmio_needed'
> 
> s390 does not support MMIO if PCI is disabled, but in practice one
> would not actually need kvm support in those configurations either.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is currently needed for randconfig build testing the
> 'sae' branch, it is not yet in linux-next
> ---
>  arch/s390/kvm/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/arm64/Kconfig b/arch/s390/kvm/arm64/Kconfig
> index 42a1be50f6e1..65b9dc25fe62 100644
> --- a/arch/s390/kvm/arm64/Kconfig
> +++ b/arch/s390/kvm/arm64/Kconfig
> @@ -3,6 +3,7 @@
>  config KVM_ARM64
>  	def_tristate y
>  	prompt "Kernel-based Virtual Machine (KVM) support for arm64 guests"
> +	depends on HAS_IOMEM
>  	select KVM
>  	select KVM_VFIO
>  	select IRQ_BYPASS_MANAGER
> -- 
> 2.39.5
>

Thank you, 

I would squash this in v3 into the patch that creates this config:
KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild

if that is OK for you.

	Steffen
