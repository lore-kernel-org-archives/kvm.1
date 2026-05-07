Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272183BF685;
	Thu,  7 May 2026 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146978; cv=none; b=qoFXFghZi767juSyWK/VRVv2ksxWk4YQvrM+lJHVyUNGNq8z8DNGw3dc0p5YTn7ws8X02qqrvSUSYqfF9jHknegZ1HlGLqbh748XQwVu8Y1UK81BwqZOF23XTcpj292ZzmV172dgS2THT2LTeSpO080f0jyHeRMKPmcj3Z4hIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146978; c=relaxed/simple;
	bh=lvemOzgsIa001Fj90DJ4Q+Ij0txyPCE+8ajbsSMEXKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5I8tcpdhjsdqr2o4909ZD2MGZyJxK6TEa0TC9UCG1Amu5NuwcYxEvWX9SJP6GvbR7QTrT/3n44yo4N2JopXbVrx5gUiliT4vcRQK0N7rwNNcZ/AmhVQa6fJFi9+BySq/HLCYb7T1t1B71W+AD7Gq99P6MKETjkXjyaXXhSgiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r8FD/V6V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r8FD/V6V"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6476PYjw1080687;
	Thu, 7 May 2026 09:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=x5m3WN724+RqKd+lGU04+qy9CZXUZk
	eD4mn6hrB/xws=; b=r8FD/V6VPYj+ZbGYUa/VJT0phU/QO+kGzfbtIKIHmK0i8v
	dkF+J28nB4Imdi+acuRa7j+9HKWhQtXe7kw+SE8rvA7nQlXMWaffWVLtuHGUhtgY
	JqIOfb/SR2+G9nZrezxnDKDU1byDxdTOAWiWqEOfxhmzN68B2pvc2ptehrcm2/nI
	qKStASGJHfZC2tcvx1Z3flQC0rdelO+yfsA0SKUgFbK7ACPvabrljzL4ISH0NAHh
	maaCz6vOAFJkwvu3aDvcpst+CqmV8EXs5iuXz6HRKUpRm71Xn/InuwxfWFDsJGXq
	ZzrTI3K57eRvN+DOnfdG6N5f1idecvBvMcuQAPUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1ncyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 09:42:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6479dXnK011903;
	Thu, 7 May 2026 09:42:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk2g43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 09:42:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6479gdON46137600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 09:42:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09AE20049;
	Thu,  7 May 2026 09:42:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3CC52004B;
	Thu,  7 May 2026 09:42:37 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.123.0.51])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 May 2026 09:42:37 +0000 (GMT)
Date: Thu, 7 May 2026 15:12:29 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
Message-ID: <20260507151014.fd9d5732-0f-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <Gautam.Menghani@ibm.com>, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qfhrqgSmrrHrScBwDerdck2nYq4gJjZ5
X-Proofpoint-GUID: sVVasQizeNerxqEtffzvIBTvmBulpV0_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5NSBTYWx0ZWRfX00RDdEL7wK9t
 FJa5WH4UpnBJuCSw4CTYinqo3QDyfYyPGWO4Tu/RA6bzj1u1BGr/J3IB+AXBUfZ8p+Bx80UMn+9
 gwEpjDTSvkAKUjeCd+BnHWhKy3EcUCIJnW5jiktafQYaJ89rpsSOd2pg4yl+XjaRyQiHp1yJvSR
 DY1/Bb/wOryI+9FCLa4B3kIT5DZm0l/I7eU4Ti0TAXsyXa8oz9t5Ma2zJ0pt1CYgoESmt5a4CTs
 0vu5zck44vPpvFOHJBD+i6ZphNphusigaAgJGNresoPtLeNZ5JIgfWlbfmrKtgqPjdVqvIG08ju
 Qo36M6woPz2C42RHLsEVnUFpS1aWiT2Kw106XKqjo2rSJLdccNhdnkByw1YVBMD/AMiwACD7RkB
 1XdHffdSH/rkHG9z3L1LtJxEM/xnPo8FCTTcHKZXtI8WYie9BQ9UPaRGAVbk/YcPK2BerccFkZ2
 W7/0toV9lKjfVTuopig==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc5e95 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sf-K9OUI_O-0kvPjvxEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070095

On 2026/04/28 02:15 PM, Gautam Menghani wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Remove the trailing comma after last element
> 
>  arch/powerpc/kvm/trace_book3s.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..5d272c115331 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>  	{0xea0, "H_VIRT"}, \
>  	{0xf00, "PERFMON"}, \
>  	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}

While we are at it, should we also consider adding 0xf60 for Facility
Unavailable? Anyways, LGTM.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

>  
>  #endif
> -- 
> 2.52.0
> 
> 
