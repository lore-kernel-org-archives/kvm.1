Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DA3F105D;
	Fri, 18 Sep 2026 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753645; cv=none; b=OxgXI99p1wvXqlAZ0w2gy3DloN5CzAVZ1kh7iYTiuHHgzP3wXkHjyJo8TE0QI0oxzt1z10nW/Az5/P/hb7CupOSGJGfWyBOIsM306y4r0dGoIyKptB43rEoz8LC+LNNN733GYXKYVQd9MOg67j10uN9itGeNFpc1LDYgEkSG124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753645; c=relaxed/simple;
	bh=eX2D8MQdRhq+4pOWVWDJoSjqfwyb+Xr1M+aNMMTwxE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTDI5FesBKPmthaYOPhOvQTKRtw7T/M33VV0qEAPXXxbkQZktA8hjvfkCAwFtyRr1XIy9rQ4CKdhsHRHK/vUWuLsE/+GAN0erTYfzz6iDArymkQ/cKiskaJ6Ml+OSJNVxsx89KMGHil0jgnOWac80RYE1Vk26j3AbSX3U5ZBbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRdRIv5J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRdRIv5J"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IH1pOv660585;
	Fri, 18 Sep 2026 17:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7UxSnGfwu/IJRlG7OayfivP+4Kua5y
	rtKWWb1Og1sco=; b=NRdRIv5JwMV0/sxo82VFgpjnx1/qLJ7EHq7HKftCr+t+by
	H/vgI16WBKzfmE1pWH5IyUjnvO93kK64868Ch0l9BUJ5vBHlRDaPmA6cLXkQQeiG
	ibnnxBtjZC43Ig0porKMxNan7VKx9CWLIvnsi+GqnWKxZA6V9xaqEZQU9dMLqfNq
	hZS0kVDixXRRtQHRhwdozcsCqxR/8pq8ChF+Ir5Uda1y0PFKYiAUhrr27YoFw99Y
	v4PrIUf+2FjeDaaCZOHAlabB47n5sWOe40QwZ9bJI8WhjPARqvUHaZZKChgSJm5X
	W33+oEiDsHHpFw/75SsbScujf6ZpVIBW1FMkJ/iQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eh1nj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 17:46:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IGoxDB964976;
	Fri, 18 Sep 2026 17:46:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjrgc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 17:46:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IHksNE40305122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 17:46:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563902004B;
	Fri, 18 Sep 2026 17:46:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A524C20043;
	Fri, 18 Sep 2026 17:46:52 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 17:46:52 +0000 (GMT)
Date: Fri, 18 Sep 2026 23:24:38 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Fix callback check in
 kvmppc_gsm_refresh_info
Message-ID: <20260918232327.23112614-5a-amachhiw@linux.ibm.com>
Mail-Followup-To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
 <20260918143124.9913-1-kaylovefoss@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918143124.9913-1-kaylovefoss@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI1MSBTYWx0ZWRfXxo0Weyb6Nv18
 oSjAiTB1UtqtWeZjB4+nte5+1yeI0UtL8h4Bsl0vs0oRA/Wz7WgY/YCUzBB3fNt1/Qg2Ixh6ed6
 Ram/0J7IupAwLig3aJjxTHPOPJsgpRndq1Ue8BNw2s5QwtD/k+imM+TpjOjWY1IWIZHNhtWBTSu
 2LoLJD0RDwOQeUb8J16CNnr/jIMytvEbO1ZYvjH4/u6TXof1vftiPozFquxixGnG+hu3YoWnw1O
 v6d5BNneaRcx+Ze5e0NE33qu1W1YaryMuJ2LNTlIQdSVK0wachQAxMGaPHvCmYjYtArwMg+ZCsg
 +8zER/EUduFpoY0SYQVcGV5bUo+3kJh3TLUPRZN7juIMsG/uphWH38RGiaJNsQHcs34ams5wytJ
 SmjcDiRbXEjf1HP+u8G6V28tIZeKm17prUXD79a012uvmXJFQOOukRmRbYVpfhig1VuXGSziyl8
 bya6NUqGFiUJZNTgB8A==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad7911 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=-UEHelddAeA3dXerUxoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1PPkUjuENsZQUl2Q8L4HkEQjhCoVyRfJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI1MSBTYWx0ZWRfX04GLhenJ5PRK
 htoNYj4v8L3oKskVITFKnLNCWrQTH0rtbZUy7E1ZpGJZjijtQOHUAeX/d2JsFhGY3QbYKpZAf0r
 Ivyu3jpeU5uEDoPifFyod7yZzCxcAkA=
X-Proofpoint-GUID: cqYzEWGtmFKJ198q4Na91n3TSWR5RyHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180251

On 2026/09/18 09:31 PM, Bui Nguyen Nhu Quynh wrote:
> The kvmppc_gsm_refresh_info() function incorrectly checks for the
> presence of the fill_info callback instead of refresh_info.
> 
> This can lead to:
> - NULL pointer dereference if refresh_info is NULL but fill_info is present
> - EINVAL return if refresh_info is present but fill_info is NULL
> 
> Fix this by checking the correct callback.
> 
> Fixes: 6ccbbc33f06ad ("KVM: PPC: Add helper library for Guest State Buffers")
> Signed-off-by: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
> ---
> v3:
> - Resend to fix whitespace handling issue on v2. No code changes.

Thanks for fixing the spacing issues.  The patch applies fine now.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> 
>  arch/powerpc/kvm/guest-state-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/guest-state-buffer.c b/arch/powerpc/kvm/guest-state-buffer.c
> index 42843eca6727..aeb586ba4523 100644
> --- a/arch/powerpc/kvm/guest-state-buffer.c
> +++ b/arch/powerpc/kvm/guest-state-buffer.c
> @@ -598,7 +598,7 @@ EXPORT_SYMBOL_GPL(kvmppc_gsm_fill_info);
>  int kvmppc_gsm_refresh_info(struct kvmppc_gs_msg *gsm,
>  			    struct kvmppc_gs_buff *gsb)
>  {
> -	if (!gsm->ops->fill_info)
> +	if (!gsm->ops->refresh_info)
>  		return -EINVAL;
>  
>  	return gsm->ops->refresh_info(gsm, gsb);
> -- 
> 2.54.0
> 
