Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFA37CD31;
	Fri, 17 Jul 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300716; cv=none; b=ZLO2h+46nhCmtJzjEJw77CAqGTQTYWA32DC9vh0IRm2JnIIfHztSfRXORaU8Qe8jejpOSozpquTP5rL7Mi17nXdt0iDhDdOt97axicVeTP8o9yCljFnFlX6HQTY07AhsRODUzppORRmi+83/PB6Kd8UkJxeuPr1uic6gz2v3Mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300716; c=relaxed/simple;
	bh=MXLUQQrY4E+D/RSDUhJmd81p27e9rfI8QUnMa3tJamI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3Z89Kjj810r7x77HL1YczgA43k6JhWtE2R9jN7sai5z/mc+jcrmifkZtn7NAUMzN41bloI/F/QZOpcj5mwgr3jZSG97t4w7IAqz/zvRUWDKHluK1JseJTS36547vofg9IQZEs5WrU1BI8CywcyIvjlQ6HaMc2N6zE7+HZJ9Fe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dGvBzN0L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dGvBzN0L"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HEBdrY2243202;
	Fri, 17 Jul 2026 15:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A4X1mgFzkRFqwGmat3k//ttAhmitJq
	iEQtt9tbqffok=; b=dGvBzN0Lq+Kc2oYe+YXY0D/Z5rNUGz+At8mQQ9t0kp414r
	pusKrgU0OV+edqWF6vMLpfjrIzLZDlzTnyuRqT/nBw5RLbaMGHYIQOQLIg0hVq65
	0LEmYj91ZNIj2Xy2+rzBCsHG0soAAXvVG5+tNVCjck8k7wlmg94bPDlgh1n5k7SM
	L8drRFiKv/tyLQXS/0ZGoNtfS7QpFkTLhyk/WpMaMHej6OHSrW28RoTXDMS8fqMY
	e5WrLSmZjU46wVcljoQvCT9nVDTjINUuW8DkCDzl6hKoFCSXkTzzViTckiwgnRya
	3Iv4rpS6/xY/h5wK2QwyNoTlN2VO3cej8iZcdAnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxy2ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 15:04:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HF4g5h015782;
	Fri, 17 Jul 2026 15:04:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwjacm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 15:04:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HF4nBE46793206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 15:04:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC56F20043;
	Fri, 17 Jul 2026 15:04:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD95A2004B;
	Fri, 17 Jul 2026 15:04:46 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.219.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 15:04:46 +0000 (GMT)
Date: Fri, 17 Jul 2026 20:34:39 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: Use vma_lookup() in kvm_host_page_size()
Message-ID: <alpEh0U-70xe_SyB@Gautams-MacBook-Pro.local>
References: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71775f561c4b7fb23b7af0725c6ce232a4b27b20.camel@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vMxC0hlg2atwl_gKU0nXPe0LT5Rh_JRl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX9OW448/WEXJZ
 R7UrrBRV18eYnBh+DQUTaAeBZWEw3ePAX2GN7Kf6MIw+7VkHDnE4BBsc4VpViTxX0lt1I7Lx04j
 ZRjG9PeBp7hOFnWH/eUw6RXWnaBzFp4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX/HW3X6/DFkrb
 aLjyVrrPXIRGbmL1SGFprAaS2DeL6E2EI7O1uKXrMkFRlVZ8vmTpd+NrdgJ0KaYLnT3R+1zk/A2
 DhYfDGUO7hz2vPIyZrn20IMN8gavJ7JavYilRGP8ae9zNHki5Kfr+0yTOsEKW1m88LHGVmJ9s5m
 DnlSgkcOeCKdHmvIDYsKdVpSdaWvKqCuAyMCy1zC1OxyhP1Tm4BRK6sCq/CHtI3QOMG+WeZX1ZI
 rLcJZ9eP0oAtDqNGANu/+iTAdkK8ZhnUe0erBWfvPjXrbGxa4owEmfP4ciea7NBleSdimRJc+cH
 8wTJsfshvVWGef8nBtqci4MXPcPpSGjusXaFwK0V8exb93x/YjU4vQk3CWbU0RfGbjR03NPfqUS
 sLT2zPI14IcYPT36iVS9URrspZpSiwzAr6uEyjGX8/pEBIMoYQ5LhlLSaP1o7dgtdSkMQSXopJb
 xon8dOoxzk7SnkytzOg==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a5a4494 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pBOR-ozoAAAA:8
 a=VnNF1IyMAAAA:8 a=_eWwKsXlZaVYJ8JXQv0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 865pqM6P0hLffkutNXh2fq2xBYKGIEI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

On Sun, Jul 05, 2026 at 09:38:17AM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> kvm_host_page_size() uses find_vma() to determine the host page size
> backing a guest page. find_vma() returns the next VMA when the address
> falls in an unmapped hole, which means an unmapped address inherits the
> page size of a completely unrelated VMA at a higher address. This is
> never a meaningful result.
> 
> Replace find_vma() with vma_lookup() so that a hole address returns
> NULL, causing the function to return PAGE_SIZE (the safe default)
> rather than an unrelated VMA's page size.
> 
> This is currently only cosmetic, as the only caller is in PPC book3s
> support (kvmppc_xive_native_set_queue_config()) and subsequently returns
> failure if !gfn_to_page() anyway.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..d33761123459 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2693,7 +2693,7 @@ unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  		return PAGE_SIZE;
>  
>  	mmap_read_lock(current->mm);
> -	vma = find_vma(current->mm, addr);
> +	vma = vma_lookup(current->mm, addr);
>  	if (!vma)
>  		goto out;
>  
> -- 
> 2.43.0
> 

LGTM, thanks for the patch.

I did some sanity testing for this with KVM on PowerNV system.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

