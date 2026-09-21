Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B23C4B64;
	Mon, 21 Sep 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991987; cv=none; b=jeK9Qh+NFmXIaER0hdG63TBD4fPtSaxbLc7yEKw3cwyR6kYI6GSonJoqXlBdH7226O+TmNqsIbvvy+eViFT9+AbvJepx8+zkx3srCaR6xbcMMG8IHy/Mj1297QCeQhWQvbmRecOQ62gXouO1EGEpSByiHO8H5io2f5eKza4Ue48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991987; c=relaxed/simple;
	bh=P5jPS1qkrIzmfP0iv0B8nbaTYixsh2wFPo/ToIHURKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWZMzfz7IVfLjFI2xk5Xz6IMme31mvJHGFpxSl9tZ4dqkrpkARU/vQzqRccPUX1wqyCprS9lJZZtwXLegWo1/n/8MoOkNCPMcJGK4Laq2aWaTKZrJL/wqNKMoub+4WOi7I9GpclAcNBIbIoCnIcsXS3SD47BVqWO6IVIgP5Cvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LG9FJpj+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LG9FJpj+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5biG1169483;
	Mon, 21 Sep 2026 11:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rVDLd6gucClabU9Q1VnKpP2svsAjUe
	Xvhbu4ISNalWM=; b=LG9FJpj+I6j8rzE7IWzTzPBBU/nihzSzaU6FcelQKgGlPn
	fW4EL5qeULkQTeMd74DAUlwY6y0fQP+iWjBkJ1XmJy7zJI2B7JQHKdbyRYBw3RV0
	mZyVNmyyLT5qA71GKG8wiAd46CWO6pmGoAIcaO4OXzakvp3X9t5QYQNVvY8XMX0e
	EPbGbTWc8isuYxRMAdVwMi689uMZOAqNN0PTuZqjIhDQ6FnlN/FlXTExC29M1WPz
	5JIz9dJX0HqFA5QrtF7r0G0KCGwFQAbHi3soUdxsV9r/BVZovn68Xr3UtSaOa/WN
	GVtRVmYqlJfZk3u1JJ4RgIo2Y4tUkNxbjnwIfY9A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1868g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:59:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlT2B2063264;
	Mon, 21 Sep 2026 11:59:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4v9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 11:59:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LBxFpR42074556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 11:59:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CC0420040;
	Mon, 21 Sep 2026 11:59:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18C1F20043;
	Mon, 21 Sep 2026 11:59:13 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 11:59:12 +0000 (GMT)
Date: Mon, 21 Sep 2026 17:29:10 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: use assign_bit() where applicable
Message-ID: <arEb8QNaPzcywaD8@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JA8Z-cASsVrqxiOfk92DbeQcfOgmTtTH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX2MRkXB9s/VQm
 lTxoVUXTPa6eiuem/uVb46ozplf9qTmp/3uALAK3ctZZd9A+P0NxohuWzT0lBQzri5k8aXME2BN
 Z0bpBFSNqX9l3AX8RSZ2zviozcpJUshiQaJNzgngvaPsWY/zITlnpjUDSYbe/kNET51slb1HU6h
 n5h1VYb1Uki+vAWxvM8DjgSDEP35EXOcH9h9cCe0XvzzMFho/U5yX25XTwU0S8rz2PysroFrk7M
 cpEpbgr+240G9+eiUYFu6ewPU+3RlDckOr6BH7aZh/XPCdqNhZpDAo+FAmIB7nK+TLxO6HEmgLc
 HDjoR67uksg+KGTZAEhthLrSJTvtu8R/bpYUjRr8ljQkb4B1+djj7wT9WxgLzxE4YUGXVcoJy1L
 xlb8dHVIGcXHUindza+Dtrlap76jcBsafGUVIXwWreV4kOCe0Cu+MvK9WtMJ2c94mqeDAdZcMMY
 NbsIqO5nkJ8fyrDStdQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab11c18 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=8AirrxEcAAAA:8
 a=VnNF1IyMAAAA:8 a=Z0NEbA_iRV-AWij7CAYA:9 a=CjuIK1q_8ugA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfXw+f82BNwqPEs
 xA8C3MQLa7rTeJ7ktaJBk0tZAROVs43cDuDFfqaWwu+yE5FcdRwfSnKYSKC5LhkIiFhlYt30oya
 XLXcgp6jjWC246ICHTMbRUkps3cEOTo=
X-Proofpoint-GUID: NAZqCAiihzjNz_cSiZPgqzT21N0PBHPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210168

On Sun, Sep 20, 2026 at 10:26:17AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..a567b63a5f1f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2210,10 +2210,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  		if (!kvmppc_book3s_hcall_implemented(kvm, hcall))
>  			break;
> -		if (cap->args[1])
> -			set_bit(hcall / 4, kvm->arch.enabled_hcalls);
> -		else
> -			clear_bit(hcall / 4, kvm->arch.enabled_hcalls);
> +		assign_bit(hcall / 4, kvm->arch.enabled_hcalls, cap->args[1]);
>  		r = 0;
>  		break;
>  	}
> -- 
> 2.51.0
> 
> 

Thanks for the cleanup.

Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
