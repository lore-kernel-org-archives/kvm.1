Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953A4A8432
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269135; cv=none; b=FiOkNvcMsWOwQdeh+PaGG5L+TvncOKpAsv6DU0ChyQXI6o4pXwfzXRI+xpPAGBoNZqn1coWzzX58I1WatJ82Lz/YEk+I40J1ezj3wV1SVjkO1OrxhzZ5d8xBhpBEh18AIbqSBZ2aNKXoH9pPXEGlvdNAhz1JBTiSzuVizGe8/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269135; c=relaxed/simple;
	bh=a8A9yqjmhJ/+cI4yw1HQmLXjHtbCYV7LwVPgha5XwhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xr8Jc2Mjm4AB1yCWmprYDjqHaIkFL4HWNGCsfEhDhpHgHvxF5eXGIbQCi/YLW5z3nXkjIh8LQ8B914VKmSuMS5A3r1/i4WlsopOKAXAG+ib/XUQxYaVFA2JXvTZBbTN1Uibv3k5b4gxdyBnUcTmXmpLp0MkoLfx24n9MBG/sxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xu0+sAhP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ReYozX6w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xu0+sAhP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ReYozX6w"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OFebRb2855009
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rFAGiOFg8Ohk1lbqGxk4BCZDcIv/T4pj8Ax5ybWtFqY=; b=Xu0+sAhP7595qGZV
	puFGsMwbl6q6Rc7svCwZK+AFgMMAFmZn87UZ8N7stAWgs0b0fX/qeHfXEwPqf/JI
	jtokQwdafNIMplnB+yMcLHyw+cW2OteWLk0U7jB5dum0+Gi/XCATXkWIncHTNygg
	sddbbfhSpaQFHFNsp0+KMdS+G74Gb/U83Q3pe+ucyP+BmwIwCjbJI5tR4fVCVMzB
	zgp1sV3lLSGYNFQktGsggcc3+d5FaiXwXpabwwiX70UTB3IMx4MV9zwSKRVDeG6R
	nJ4WDyHPLzInzX0l+Ks9kur02sJ2OKBXTJZnHpgLhC4ExgQQkv/n6naBb9WImHBw
	uIJqUw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvsfgump9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:58:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso81195a91.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790269132; x=1790873932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rFAGiOFg8Ohk1lbqGxk4BCZDcIv/T4pj8Ax5ybWtFqY=;
        b=ReYozX6wZ0XKv5/Q/AWdJO6IuwKbPeRxTuSD5P7PpFaaxt/F+VcfwYuVEsC0JRkijU
         7euWswj1/R7HuHlt33AXroPLRqGF5lsHzOTUEHI7QDQtYblmXXb1PWFC7dH4xUxldNQv
         AzxXJWSKwrWde6CzZtGey3KyeSQ9FE3/KLPLHNxkOzQksAzAMSyhdMGfjf6Ba5lScj9J
         kVgdxhQARjx3v+6ijHmVFG6gRAkwty/a/B1eh736ySL2nEwjzV3WzIUcK2wclVb1n4dS
         ukFzCCG6Mr+itK76Xo75XU2H/BvX43MgJ50OcpF3iQS+8es1uvm+5dtrEldHQT358TAX
         loAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269132; x=1790873932;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFAGiOFg8Ohk1lbqGxk4BCZDcIv/T4pj8Ax5ybWtFqY=;
        b=nf/Dv33YEGS8TAuH9JnMQPQrVuv2VqrgHWxUZJUXg0Y35eN4+hWahAepK9eCJRTO7u
         CmVhDc1i0/qz+lB8mdMTBqCJ+t6k/2fte5QnxeW0ZOZiEG2lE9E6z6uhsqq/Q/g/Z2CR
         9hdLhybmOXQyWkkKGDfIklWJRVVo9Q1RlzZ8yDllRelVq2K1q/Ueztp/W3NQ63IFHeKV
         t6JD1ayuW1164Hxj/UScR2oVsT7bQri/z1v0PBWy1PP/1Hoi6zCUFaweWfhjQgkBIDCT
         ApbddKMpEmUZOEzhQw4vZkZQ8Pg+c/zv2FKlF1Bv5rin1y9vfT62O/QGNbvXwdrEfw/w
         8Anw==
X-Gm-Message-State: AFuF++mRSkLQZ8wgwckHCbvT0tBPHYtS6T1Mij7g6s3sSTVRcudhK88N
	1aT/IH9Mn1CfiQg4W/46eXKkP+CgtjUvYTqeKZfnwsK/9Ym2D70Jg3sTb0+U0om6cDLyVyP5kvh
	IwNfFKCLZbsJDgV6RxNdHmEovQDpJxRiIaYuXzcUJT3VwZX8FM38QG3s=
X-Gm-Gg: AYBFou02lRvgmbhP3aSH/5CMPhJ9xutsf0um4mM2+p+dlko5moDDYIEwkSI/mgzUnZz
	M4n5ou0JBxR7VtQ9xPIgSI3jnmO01DYa9IozxfWiSdK4U/43Vzsp9oLiuWlrzr9Gvs7DLOi9zfg
	PcAFhwTCfhdYGDyxQkDfcDDLGizU996ZSxXSLl5JrUtYckTRaSBATcb84WgGD9XEnE4VnAaJs9d
	vlpEBgAF3JUw+yxkFlnQA8Ynkq9dpO/oHGtGgjVuLc1G0HnAWj7/l0QFND1512hS5/iBVXaN2t8
	dQvSwvqUjnTzpiaaqA/B4MvMnYB5AgVqNcHC4IjiBshdYKwmoqIJM9kVdQPx9FODeLBbYLUxpDE
	vMf3VQlPbeTbQ171qwwUxzIGZn5PpyHKjWgKlt6E+1ROOdI7/sIN1Gnw=
X-Received: by 2002:a17:90b:3c4f:b0:39e:6c69:7775 with SMTP id 98e67ed59e1d1-3a09898525fmr2917444a91.30.1790269131557;
        Thu, 24 Sep 2026 09:58:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4f:b0:39e:6c69:7775 with SMTP id 98e67ed59e1d1-3a09898525fmr2917416a91.30.1790269131105;
        Thu, 24 Sep 2026 09:58:51 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0a8d290d0sm2047321a91.13.2026.09.24.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:50 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:58:46 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v19 2/7] firmware: arm_rmm: Check for RMI support at
 init
Message-ID: <20260924095846.000051f3@oss.qualcomm.com>
In-Reply-To: <20260924135201.850038-3-suzuki.poulose@arm.com>
References: <20260924135201.850038-1-suzuki.poulose@arm.com>
	<20260924135201.850038-3-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfoodARf c=1 sm=1 tr=0 ts=6ab556cc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=iEv2s1z673h7nQAfKJgA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: bVuArRbERuOip6a2v9f9u_1e42BokzpB
X-Proofpoint-GUID: bVuArRbERuOip6a2v9f9u_1e42BokzpB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2OSBTYWx0ZWRfXz0sKt/gkSVrv
 guuIE3GLB81GB+lu3HldB8P2rbosJedtIN8HBb78XcwWvdxd6XpnML8jdCMzwoQCaf+X2v7rSzs
 TJJ/frN/msPemR5jbbanUpXPpy2nxEs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2OSBTYWx0ZWRfX7gr44KE2yKCe
 UUce0M+mJhGaVU4cttvH3uah+uWtgueUCqXtb+MDG+5wFOas6YmlaYRP3LHwCDeUZi3o3oTOG+K
 bU+xElL5vviyP+eWEi9311NmtAOHa2v0QUNGL1xtav2kISm23L7eEId0gk5RiFyxwasRhINY9ny
 AAg03SCpwMr+XAW7/qeOzvjGLWnk3tV0HcgtgcT/tgwA7wFUqgCHNT8XMCW/n9BrZ4UZ+/37IMy
 eJ10qCogLbcZNnYjoNHqvlku1A9HF2n2cLIoxg6Ws7aCQFFZvNwKuK8S2+Aa3JBuIFUWfEgiAa9
 pvs5UPqglMXXwuAPuoXPjFzsFYofqPmxiZFlDJRfQPF1jNfX6E4YRGGDgPK+AEgQXExKnjT65Qk
 Cre6EsJBkbwV/u9t6wuCbCnbM9+I1sr/gDhzu9fDJ1bAcFdx061V2s7PlDO5mea4SLarvfuKpz5
 mUCBzWzJ81gfosGQrUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240069

On Thu, 24 Sep 2026 14:51:56 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> From: Steven Price <steven.price@arm.com>
> 
> Query the RMI version number and check if it is a compatible version.
> The first two feature registers are read and exposed for future code to
> use.
> 
> We only support this for Little Endian kernels, the Big Endian kernel
> support is anyway marked BROKEN and is being removed.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
