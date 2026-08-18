Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0803C0A00
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045424; cv=none; b=km0eseABdRaptX8hq5VYG4vl9Zw5GsgznfDJSgQqXmYEm7X7yRVb35DbMnjlFwKGUHIzgOX4ZkfgoBXHqxeaFwG1/2cr6bewmbW+41l52eWvEFbCzqyTYXikmoo8emkHWwR+r/0mmnyVJWi3ljNwQsm0DVcy3o+0rKbCN4NyTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045424; c=relaxed/simple;
	bh=u/BWCSgfFG2ljiQOHjptAUguARK/FOBMk//P2B/w9ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK16bF95bN6jyFR8+ajJdsiv2HYgRrOiLquXdAQED4sdZGM9TNo0Gjcfdd+kCInbMUcmN4ME5674dEImQa+sojVjvkUN3iOKNqA5ufZB8tUj002Y/t1fpeMqWAqWKwO8F9rndyU/HXopvyajkm9bqQBOysPG5irLS3Ysn3HgsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEKyJXPV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Haaw5ilb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEKyJXPV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Haaw5ilb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BWZd723329
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LXlibvlGY1oX1qWEiKzlvaaM
	w4T84Ny5R2TwrL3n5og=; b=kEKyJXPV3vXHQfI0ndkDEhzsaBksjjyfmzKyk3wL
	E8vb35VTADnpVtdXr8Vo3IZer8gSLJkSmAVhLXbraQg+HR5San5dk73bGJTnGvsK
	PPx1LaAteWqeAT0oawvIOP/ILSJz5x2I1ymMx3XuYvSzCBG1umUc+glh6jB34P0e
	W+O5AV0Hk0aiW4InxYLzEXR8nE2qAWH/xHwfY1yp39R/pRJ80S0mbWA7iznXXjEq
	a7zOpkKuSo6UeLLt34Bpeme7dEhsBeLMAkQ+6doQao6FhzhZn0NLjJy1Vd/PhUlB
	S04PbAFmmRsf27AjOkA14kaRoNSiYZ7YATJrHwuBH1VFSA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615kqgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:30:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8efad04d884so79644096d6.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787045422; x=1787650222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LXlibvlGY1oX1qWEiKzlvaaMw4T84Ny5R2TwrL3n5og=;
        b=Haaw5ilbsod/XLFpP/i2a98WuojI++mU6d1zOtiHssQELmINlhi8vvSrezR14Q6z5s
         YY5TiwgdEsRlU7zotRS1UFmB4OYJsyIOg3WiMu4I+cyfKd6AmuZ9y/pXp+xinScUtqWN
         JWz41EqRY8LA035DW5xMgbbDFYkIZJhDroEZBAmLBgBEQvvtxqSP91ZOtckYTPFPdUbJ
         w1ykU/Z+f2wV4tlZ2mxvpl35j2Gw1nIo30WNqaX8UvuXr4jrqtfj/8GAIuauIdCDP1zh
         Blxvat6PoIQvnz/iUykTHC+4xsMhImpIXYktsckDZpxJhJx3z58y3/43c3ZBaKm/cdrC
         M9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787045422; x=1787650222;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXlibvlGY1oX1qWEiKzlvaaMw4T84Ny5R2TwrL3n5og=;
        b=psGg2nLgEVtTqnCVJ01kw31UM8VYG+3kPgDBr2pTXV5xMztjIPkrLvm9dCJh4GHazO
         5mkgHDWxqghK3XqppTLEwTVn4tw855Dy1QaWTR0/CNANUyq3WwaZ1S+pr6PEJPEXgN3t
         b4N4kQIRh97ZMFQBSDXSfJO9HDiZGsMRS1EBXtAMYdbpGSb+qYfj/OeXXe7xVAwIrdXg
         kDnzgDBRB5ajCJP1EdtBnhHxGhVNQIcbpO0cQtOxTVkScbCqrvizvmiQcra/S5kqwJHA
         0YLG/2r0kfm2ZWYJa+UQ5CneFvKOxZCJNkORnaQKT2lJD83lFU9iiK9EBHWFPJ4Nqsgi
         1wiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4+RKKVmfFjUwfoJTr3I1p3Onby2NcxxKQUVjXDoLN+kv+Eze4WcM+ieiPqWRfe3g/gfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzrWk/w44dXIyBUPzSTbSqbXLUMtENjsoMsjHTIIq+pUo3DBc
	ymQaKSLKljE1ACpZx0iKoc/f/M9r2QTVlOB5R1QuXvziDSh2pO+tsDqO0mrnQ5XmWy9F46Cp7ny
	CSNhZp9n3j9m4QxJKki8AugkQadKJVNgFyhEk+rMs5M9+iLn8CcrJvjU=
X-Gm-Gg: AR+sD11bMJaize5xlNDsvSS1uu2cPRQW2J01vTZzaXNn/mEL9TkmxcXwUcurZE2XCje
	Uih3uCwNCzUoQEZ+0jGShzFMxf6bZ8ZxwTVg/k0GO0niXxYX93RaiUfDzSvveCq+KojtEjfrpEn
	7wznvP2F/JioDE+2o6d0x+ll6Hf+AB8pY80soWlPrYcx8BgvnxY8oWKbO5XGTBDfv/o6xbngTr6
	hD2FQVbOZQUeDs0EO9Jc2XIrfg+BLrGyFrN835eqZdaeGjUeLFqYzmIOIAywMZRhX9jdwMG4O9g
	yRc391PkDQ163pjSb9oX0fAWCfn0Z2QmlMEuBvEJZvh3C+TM/luHSeuqJhwJH68gb0yzo3j2FqB
	+uiajpCtIlayXukIB8Eki1FKtr8cY+DVgufk=
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2678123785a.11.1787045421751;
        Tue, 18 Aug 2026 02:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2678119885a.11.1787045421397;
        Tue, 18 Aug 2026 02:30:21 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm260422965e9.6.2026.08.18.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:30:20 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:30:19 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/10] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <lpnxdqyekcczbyxo3n7zxpbj7243gixdzutvngpvr24ozmc4jt@nsoblujgprhe>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-2-fangyu.yu@linux.alibaba.com>
X-Proofpoint-GUID: 9LisbOQ3JYoP4wn1cNNFkouD5S6R_jV2
X-Proofpoint-ORIG-GUID: 9LisbOQ3JYoP4wn1cNNFkouD5S6R_jV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2OSBTYWx0ZWRfX5onKU8s4v33J
 j4TcdfyTZfXNp/3LL4SBYzMiIel+0J1yQ6Kj6ioFCTycj+CS2iSB8HpSMTaq8nTvFvsVyMgDdDa
 gY1hpeuKUEtnPytyNsETmSxaaMlG5e4niE3kKeYGucKukQngCQ5+9lutgOu01jyqd6EaHv4tbbz
 xEk4vaDWXpoXeCc2tq8a3tmFrL3i0r8gQtCegXjRfdgbiv67qtE7QreUo7HdIWbCeDRp+m7FseT
 ElyAhzX0K39lM6E8GAbZxSeLxWvPZH405iePXXllfK1z4grw67dwaC1E2Rtwz1pX4U9HPDscQT8
 oBMRQUsGahUXEnY4PwJOyxyk0DU7c34QFPJoPq4KmhQUyBk+5xH6wTMnFG89bpyx849r0CvUWUE
 drk66+w5Zk5yr+QcZtAS74+I+0FX+XbvkrTAioW/WKN/S+hTZQorQ/KKN8zGOWoVHE2c+xHntwt
 EVE4U+J7k5kO8Ai9FwA==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a84262e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=0xFToDSQ33sWTIcn7J8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2OSBTYWx0ZWRfXyVP0GKzmzRPu
 fygNvtyxnX4lODCZQ6VPonJB1ktzlQ9PelazzuNidvKGU4IPV4K2SSMw60nTT8j5iky6STB5siF
 1NyIO3u7fI2jw0B37BTrB+gxe3DeINQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180069

On Thu, May 07, 2026 at 07:36:57PM +0800, fangyu.yu@linux.alibaba.com wrote:
...
> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
> index fc5d0b5edadc..59448125159e 100644
> --- a/include/linux/generic_pt/common.h
> +++ b/include/linux/generic_pt/common.h
> @@ -188,7 +188,10 @@ enum {
>  	 * Support the 64k contiguous page size following the Svnapot extension.
>  	 */
>  	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
> -
> +	/*
> +	 * Using second-stage / iohgatp address translation.
> +	 */
> +	PT_FEAT_RISCV_S2,

Hi Fangyu,

I just sent [1], but I actually discovered that issue when testing this
patch and finding PT_FEAT_RISCV_S2 was missing from PT_SUPPORTED_FEATURES.
So this patch needs the same fix as [1] as well.

Thanks,
drew

[1] https://lore.kernel.org/all/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
