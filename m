Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F604B8268;
	Wed, 16 Sep 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576631; cv=none; b=O1GQAMLOqwHRaJW7/eOuqG0P/S6OPp010SH5853EipTpsQZspZg2gJN+07yfKJLIq4ZOfNQk/4UO+8RQHTi8P8BY8w6pzs8MAgueGawG4I0RvhqatQzry7MdDPv9ex1ZSFcz4J+MGM3ZQ6qUWx9PNNI0My/N8i4sfrvpvovVbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576631; c=relaxed/simple;
	bh=sRY+cGpGm3zGrKhgBCk7CbfClyOL44bxZ4cXykXvzj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B95pA81CurODjXJdOOB1AT+fibQm3pH0pkkDEYV4+RpTiWss9DD7KCGi7RgJdxzZzegYfjtrHBmSprM/mdyZcQnVY7fbwv6EoPd0UFWM4kE+FbgwjLid1dsD8Sg9mwCnv35IwtzPHrIoQrYSL+K+0NjdDjb0f5qm3FC51unZteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IwP6T6gP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IwP6T6gP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1j252330393;
	Wed, 16 Sep 2026 16:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BNkbs2qytjyos+7V4dOIKR0RNsDNsj
	1EDx92GHAcS/k=; b=IwP6T6gPU47hFt4aMJana2voTkuh19VKxzGiR3jSQgL3eR
	z1d6YplV9XBj3komtV1onf8KIDHfhwhTU8SbBWdXnSD2y3pNveds177LXR+qw1UO
	Rh0MeX5sx0Qi96zbeaf2Gff/nuny1TC83YvfSl2no9WSEls7RZkyHDMHXyugkkYl
	V0l0GhZT4MgC6y14hsnASHOlxETAPLZKJ8hz8DjXy0xpAKmJ8Exhp7hcNg7ptHhJ
	/J9jCR1SoVSwbFAm2Dge9Lxx3Q+Mib7Sun2JbWiGdaDkrAU7KzZ2gNet8ZWV3E8c
	lkv6k/u0PeBqL3wHBQX3LqW/EgA343Z552rVZw7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqdqfx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 16:36:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFe4631625398;
	Wed, 16 Sep 2026 16:36:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsfavb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 16:36:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GGatqr56164692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 16:36:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A72C520043;
	Wed, 16 Sep 2026 16:36:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EAA20040;
	Wed, 16 Sep 2026 16:36:53 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 16:36:53 +0000 (GMT)
Date: Wed, 16 Sep 2026 22:14:39 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Fix callback check in
 kvmppc_gsm_refresh_info
Message-ID: <20260916220833.d3e69a6c-3b-amachhiw@linux.ibm.com>
Mail-Followup-To: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com>
 <20260916140742.636708-1-kaylovefoss@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916140742.636708-1-kaylovefoss@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX52PsC0mYQ6mV
 dEkY3Un9c8T62GB3TS6FGESNC+oRudPoRqdZ8tC22pgYi815MA5m84EehKQDctTTun1RMwDHSxS
 O7gi6UkTDZnquTp3PIBGuUql8o4vJqt7eWyK2CM3jfUELRVOSNnp5QJZIA1Uj/8uvveJiFqv2Tz
 Ob+LeDYTDBm0DlI7JcMpT3XKBFPQK4JtF2JIgGkrO30H0wq5Y95nHknU3yV9p5nVmylu3BTNVAN
 Dp/UKwyY2RGwIRD2nJFsEk2p8VXEOiLOm33ll0N9Rjv7qa6uraEBAUCg66vsLHsVtVQ9tSYK6jb
 8gKxBJ8n5G+n6FUuIZaqul34EkFoeZkekb1QnZ84NCqNAMAw5miuPQ06Al++XvHuRL7q39fP9ac
 8hWsgCgMHQOgI8CscQkN/jiCNhC7tB6/jRNxZD+62cQukNpkmwK+pVGhx0+AuWOOWnylL8qWtR9
 bCo3dAL05r5O/QPLEJw==
X-Proofpoint-GUID: 9Bm1xF8AwJmxPHLh09qWGITziDfQ2SgZ
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaac5ab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=GZGXQFM_8ITjCaSgkesA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: bwqC2wG4ZO6EPzLW9N5SJBmsOmiKHtL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIyNiBTYWx0ZWRfX/si6wCktr6Ke
 cihE7l2KCfFFCsdVka61Su8s1zS9brTAlKwjFmjpobfXXxyKgDKRLnsx5bdjtWPoHRKRG0qOv7D
 uc71H2zT6DW+oJjZCa5rQLGJMUkx7fE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160226

On 2026/09/16 09:07 PM, Bui Nguyen Nhu Quynh wrote:
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
> v2:
> - Resend; v1 was mangled by the mail client.  No code changes.
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
>  	struct kvmppc_gs_buff *gsb)

The fix is correct.

However, the patch still does not apply cleanly:

  $ git apply ./v2_...mbx --check --verbose
  error: patch failed: arch/powerpc/kvm/guest-state-buffer.c:598
  error: arch/powerpc/kvm/guest-state-buffer.c: patch does not apply

The index line in the diff (42843eca6727) is a valid blob in the tree, so the
patch base is correct.  The problem is that the context lines in the diff do not
match that blob.  Concretely, the blob at 42843eca6727 has:

  line 599:  \t\t\t    struct kvmppc_gs_buff *gsb)   (3 tabs + 4 spaces)
  line 601:  \t\treturn -EINVAL;                     (2 tabs)

But the patch context has:

  line 599:  \t    struct kvmppc_gs_buff *gsb)        (1 tab + 4 spaces)
  line 601:  \treturn -EINVAL;                        (1 tab)

The indentation on those context lines is being collapsed during patch
generation.  This points to a whitespace handling issue in your git
configuration.

Please review it and then regenerate with git format-patch and verify by
applying the generated patch file onto mainline.  It'll also be a good idea to
rebase your patch on top of mainline before sending v3.

Thanks,
Amit

>  {
> -	if (!gsm->ops->fill_info)
> +	if (!gsm->ops->refresh_info)
>  	return -EINVAL;
>  
>  	return gsm->ops->refresh_info(gsm, gsb);
> -- 
> 2.54.0
