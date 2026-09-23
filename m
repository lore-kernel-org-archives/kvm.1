Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755A551995
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182494; cv=none; b=O+MzQUttjMdIzXKTzrd7m8fFkgSwXZMBQ+Nf68uwv4joWbLzVzIt7P51xgHP5Xm27MwWuvzDedPIsrkl9wv7doxzsCtMT3WhqlW0yLMMeCid80kVmVC63DcEu6476d+EjQj53cbx8kBeC5s0C+MaoXB4V5K68hveHTFkgGKpfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182494; c=relaxed/simple;
	bh=VrlzXIxy8Fp+qeOGPoQZqyU4YzmW9HF543x3NzyMjfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR7c0uTFwNFdpSBkHUoVsyOYBNTNUJ9QBjdylRoDUS5qDaX6GcTlULvSMtRuNhnaF9xCeZ8aOx3lTs06JAFCoEB9zVu0Uyn7mPxiSrm0PtaBupacgxUhTEsP42ZW4bS/Pg+GI01VNtgZeqEJH4DOZCn9jsiZ32hD6Gg9kpBu+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Seum9zPq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fNhHf+sm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Seum9zPq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fNhHf+sm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTbiu3798584
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zlDwEtbUvjpRubwATEGCqUpsne2yYQHkp6iqY3VINLE=; b=Seum9zPqFF1bAFs9
	2SAgWuOtEzV4WMAmZskMjMP9xFgcocCq5t/P4Btc3uXm/yPP+5dFmh5MvrsC6Woe
	cL0t9T8Uk0hJD7dxIFSFHKlwoz8kF0IlCF4G+vCAYHnQ5iI/2KTdeJcGSx2awi+g
	zRh0sCoZKCovDiw8hhNMIlveeyEBS1Vj1OLdNgsBWkZcIG4Bx1Im5Y0tYnE2BZgY
	80heXHTTt8VxnPYBz3mzkSgrfEctt7TgufuAh5IddJeFRDHIZOHddDlWhucY9Wj/
	WeQF9cQwlA6a6DWFbbrnt6l8QhQDXPVALVsLhoBblQDFI7hp0SxbGW7fL6jVBLnP
	KHIFfw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb0927-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:54:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3b126c9fso11517545ad.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790182489; x=1790787289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zlDwEtbUvjpRubwATEGCqUpsne2yYQHkp6iqY3VINLE=;
        b=fNhHf+smWP/TcjENWhRQ6hNo6BqvPNHSctWHxlixdKE0eulK3Hx4vNpfNnthImFvCP
         rbDHuvjQvjA7BcxC38aWBlKygMfBmlUaZqRW7PZW16NoaLFkh1PhustARO/psKD5V0vM
         n2JXn4qCfO/udFWQp0FlLiT0VJzYngTdQzngAai5cqqtkLbd1w5dyZjX6LU3pvR6qGn4
         FvpSCa8LvP/4qIIHZ/oxg9WKsbG6gobrGvxda8NS3ssmneWRay5kFyAzycaQoafTCIEJ
         bnPATt43UN5ZDCHwETwyZzYf2XJRO19uIpwL2TpJugBTB+kDnACGf8RoB0O5exRBOc1T
         0PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182489; x=1790787289;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlDwEtbUvjpRubwATEGCqUpsne2yYQHkp6iqY3VINLE=;
        b=0ttgCP8xyasPuzQ2M1zQBTvQEeXr89w6QRBXFcRzM/l1Ejg9ojKRO1F6bY5i63SibU
         EvgxUet9T08QyhmRVgrn8rXPCNOL9ZCg8MpY3XEjsZfOkYCkUIen0MWk4lJwFR+6NF+2
         z8D3UjxTKbzHirW/Gx4BUiQhGhGyTo50yK5LAnezqniYByOmASwI/dwbIV0JkID8KvGJ
         X3QqDNoIpf9ICkRj/9+JEg4s/sN2pwJ0O2vSPAxSnzjfEu2XLl61X8k/lQokPsAaquE7
         AwMi+5MeP6H2fWJdvu+tR+V5thd70JlZY3Oei17E/1K/nlNFt33bHx/i88tOmBNwBj0J
         qdEQ==
X-Gm-Message-State: AFuF++m+ewfMore/DeNRyBUWbSzDHN47XTMKcdX4zgy4XWkVgG48IVE5
	Mb/YDYAHA0mVKazTBJF5gSzZJdcqae+wWJ1LRLL3DlZ/+wmC3AqlRQwylSYwRAYnh1eSvgtkcew
	TJL8tdcU2HObDUrGHtzemr+z6K7nGVZjbAb9Atmqi+BntoOZC8zHehy0=
X-Gm-Gg: AYBFou1Wnf3kpk3SHi2cwvUAIwONhN7tRK40+l3LAo4UWAf9ubZzZ4FemV6SwWQOXGu
	naKZAdi1wWeod7/1ng+HY6o5Nm8lbdc05edZduEhi9W9A4sfw2PYkVbjHCmi4IcJLToCdAqIP0P
	4YVJCjP1V0emRqWMW/6Wus7Wci0jyOaWqgfe7KQducS99WgM/gxpQAyNF4Jl9/gBTRv3NE82T9/
	Ygav1nn93lUM4HherghfJP8f8AdP0eK6LDJYqi3dK75M4FzMOkJiz2Xx9S69ryY2mDccB7tJZWS
	h8sxPyItDuKO3jwFeuVJWz0el9vPWlrfPGCxovhjX/3aRaCbA60vLHCg7glTJSMu2OQbZg4U4UM
	u92k5ZlP0qTyFknwR4jZHMqcuICyT0FDySIEjxXUSObgwRV31edb4CLEtpw0Rg4TmQw==
X-Received: by 2002:a17:902:f549:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2df69d261dfmr29630415ad.7.1790182489376;
        Wed, 23 Sep 2026 09:54:49 -0700 (PDT)
X-Received: by 2002:a17:902:f549:b0:2da:eb8f:b4e4 with SMTP id d9443c01a7336-2df69d261dfmr29630075ad.7.1790182488834;
        Wed, 23 Sep 2026 09:54:48 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f4219sm14535985ad.68.2026.09.23.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:54:48 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:54:43 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
Subject: Re: [PATCH v19 09/20] KVM: arm64: Add VM specific callback for S2
 MMU operations
Message-ID: <20260923095443.0000378c@oss.qualcomm.com>
In-Reply-To: <0d5201f0-359e-4748-92da-946dedf51bcf@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-10-suzuki.poulose@arm.com>
	<20260922152914.00001221@oss.qualcomm.com>
	<0d5201f0-359e-4748-92da-946dedf51bcf@arm.com>
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
X-Proofpoint-GUID: vRwW2SllvmRdpcM1eKXbha5_AUK5kZD_
X-Proofpoint-ORIG-GUID: vRwW2SllvmRdpcM1eKXbha5_AUK5kZD_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX8G+8liHd9C8D
 +exF8GBB2SG9a0gRwhxuvD0d1d9gX1jerV+KaWHzwsuNRjeT3tij+ExuBpSsMUYAP/NIW6QZcd+
 cJZsXj1z/vAYNE/uuZpwORn6lmVOLlvWMrgf6GJCgXR5QjQtpTvvQiq1iQEdehgulUWYQl4lpY8
 jf+ZhsOHmuCDH47EDOpoPEXVY1Wj1zmxyxZiCK87tohKfA500EkVumcHgbQ3ku3HinNlE0DejKe
 9LZooqQv3y5kCJPTOSYAJtjhJWfhriaY5D19oxQSejSgXXdVb1tU8cpXRFhppfEPA7ccBwFPbEj
 3sAjCpv3iD0x6xfqX8LlTY0003LFKoLs6u57YZq42oodD3sz/SOG/nwN1nXzYyXaSn99XUM7nqA
 tRRzR2dlFjRx+G+chf+h6cg8XR7fKF2UZkwQfpT43ZNaNTPypm9BbS9UTh7M8QBlEWLiNgNtvbZ
 iXVD7EX9WoJmc9PXVKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2NyBTYWx0ZWRfX0nyH9aj/f0Zr
 HXlIuYIkVC3yjLb6hNlz9p6ln0Z7kTP6TwqNlYKee3c+ccGCDMguAHWJaE+DnXda54Cu9UZ7DaY
 l3S+LYbw8jtJY43NZB+YVmYyQVW+jbY=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab4045a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=OqzaOk1-375Rtnrp2FUA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230067

On Wed, 23 Sep 2026 00:21:58 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 22/09/2026 23:29, Jonathan Cameron wrote:
> > On Sun, 20 Sep 2026 22:28:34 +0100
> > Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >   
> >> Add VM type specific S2 MMU operation backends which can be initialized per
> >> VM flavor, to keep the handling cleaner.
> >>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>  
> > 
> > A small suggestion inline that makes it explicit when there isn't
> > range operation and a full flush of tlb is needed.
> > 
> > I don't mind either way, but thought I'd mention it anyway in case
> > you hadn't already dismissed it.
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > 
> >   
> >> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> >> index 03f2017a7404a..d97a4a1bca23f 100644
> >> --- a/arch/arm64/kvm/mmu.c
> >> +++ b/arch/arm64/kvm/mmu.c
> >> @@ -37,6 +37,8 @@ static unsigned long __ro_after_init io_map_base;
> >>   
> >>   #define KVM_PGT_FN(fn)		(!is_protected_kvm_enabled() ? fn : p ## fn)
> >>     
> >   
> >>   /**
> >>    * kvm_arch_flush_remote_tlbs() - flush all VM TLB entries for v7/8
> >>    * @kvm:	pointer to kvm structure.
> >> @@ -174,26 +188,36 @@ static bool memslot_is_logging(struct kvm_memory_slot *memslot)
> >>    */
> >>   int kvm_arch_flush_remote_tlbs(struct kvm *kvm)
> >>   {
> >> -	if (is_protected_kvm_enabled())
> >> -		kvm_call_hyp_nvhe(__pkvm_tlb_flush_vmid, kvm->arch.pkvm.handle);
> >> -	else
> >> -		kvm_call_hyp(__kvm_tlb_flush_vmid, &kvm->arch.mmu);
> >> -	return 0;
> >> +	if (!kvm->arch.vm_s2_ops->vm_flush_remote_tlbs)
> >> +		return 1;  
> > 
> > For consistency with other cases and because it looks nicer
> > blank line here.  
> 
> Ack
> 
> >   
> >> +	return kvm->arch.vm_s2_ops->vm_flush_remote_tlbs(kvm);
> >>   }
> >>   
> >> -int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
> >> -				      gfn_t gfn, u64 nr_pages)
> >> +static int pkvm_flush_remote_tlbs_range(struct kvm *kvm,
> >> +					gfn_t gfn, u64 nr_pages)
> >> +{
> >> +	return pkvm_flush_remote_tlbs(kvm);  
> > 
> > For the cases where there isn't a range call, perhaps you should just
> > not provide the op and have the wrapper fall back to
> > calling the 'flush all' variant if there is no range one available?  
> 
> The core KVM falls back to flushing all TLBs if the range one
> returns true anyways. So, I would leave it as it is.

That sounds like a reason to stub them to return true always rather
than call the flush all so we don't have fallbacks added at two
layers of the stack?

> 
> Cheers
> Suzuki
> 
> 
> >   
> >> +}  
> > 
> >   
> 

