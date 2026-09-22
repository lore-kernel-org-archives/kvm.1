Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599814A4F1F
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106043; cv=none; b=tjjScCSRpltPoUawwEbSyF1TujejlBXxavTvNRxgHG0jjrZrVOQY/QFNLU4PLNqMrdzu2oqla8jr+iSl+nFH2X9EM5XhBaWBiRRStZWiijn9c80pxCw0hzFyS2YloRM5F5Yy27nEZ/VpULI35HvWJ2GbnEL/6Clo7uZlq7iqYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106043; c=relaxed/simple;
	bh=VfZhuL2X1gTRZxO0OzhM4JExH2t49JX4CNGTbuUaWiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWq7zOiLAc1EYcNaysvDoG2c7X6dxrHyWTbMwSd/WswJ6iPRBEQ3KrS1WQ014TjANEiywr9z/XRfz4h9fpMzLgx6ebuO9wO0iq2alxt67afYqIoWtdhbmhu0mQW6X1VW2rPTYizMrn3tbk3Ye22LdswkS1JsYmnnJm2cKi73mJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCpZrl2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dXoXzPHu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCpZrl2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXoXzPHu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI721h2033272
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	isSEF0IU9c1OXuHxBNGq9pSATtA3AQIYhgVBzOHtvqs=; b=MCpZrl2XliLUV5m+
	AwX/zkHOD/sII1crCEGtG2U/jgpLCl9R5xl7SrsC9BMPS8yupRZaRWKjoSPcfPr1
	G+zk8nVeK5HU3gGbbimKtGhjfcB7JoInF0tNJb+6FNetlQpNQBt5qKW7rHavrjBQ
	kng7Ib17Sxzb4DCO4X0lKQv7HIR0DRlKG41W9jQGC1kpLBZfLxU36+a0/t6N+XvA
	kx3fALA9mTbiRnv0fp89c0relqYJ1KxDBP1EpWE4H4FCFMukDUHfMMSyo/UcI5jZ
	ylDWRa5BwwCWg2GQvwmoLWMtT+zUqPbUTBsfFLPwAt3NMJG1jsSw6iLmigngpwMP
	wU2fSQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c0ky7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 19:40:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33310847fcaso232666eec.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790106040; x=1790710840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isSEF0IU9c1OXuHxBNGq9pSATtA3AQIYhgVBzOHtvqs=;
        b=dXoXzPHu00H6QXZ4W62UlASH+KCXoGsshg84SyvgU5TBQwA2z7n3TpXZO+c4hXZK+U
         HAMKGLw93+P268nX/JY1XzEZ7vpfmhI3XRyGufr2W3YJm+Jsb83yzYoW3jyq5Zi/eFn4
         7EwAleJndcyZZue86hpmijBxLzztsjAKIlSdnEB0DochwSA0QhZjNn0Bl3B9WHW3rNhm
         FekeXLCjOGo8/esSqoqsslNxkbBUD29BKQzRwxe40ndFfSIiaxm/dOpRftmqS3xDnck9
         G3R+1dL+ZefDD9/+5wFir2WKcxpDwdVCwSmybqI9hSpUN7ZEd/V/h5iSlNqnRiU+rdQk
         mUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106040; x=1790710840;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isSEF0IU9c1OXuHxBNGq9pSATtA3AQIYhgVBzOHtvqs=;
        b=econxJX64hR9hkrOwmAY3pR4hjBXiH+GMlqrYam05O0TydHr0dJotsBFJ5H1z4rBUT
         DeHqRvcV163M2w2renDNLbTPFhryYOlgTgCgc6AjgbY6uSgn6GPvs3xsu76WOPmZ/+5s
         u4NqPcTBuVvGtYZgMvBUlSw4jUkMvzKVh2sHThyeQhrOgbozkNjiwBI5OgwGoVFP0p8W
         c+KyskO8J/7mk1BjflvRef9RTBrNSkPdD6r3sBMz8trbZIES3tqFxCnBXO84l5/OTaBj
         XyZgCTfJ6+bNkubxeKUqaNM/ax9m+a4GR0sfy4Mxvb3OQJPO7SRXUEHmD+zHWtfvY9Ye
         Ieyg==
X-Gm-Message-State: AFuF++nhMFecIczvG0xZdh6RWdwvB+1yt7DWrnHmWR4oa5Qk36GqDY/t
	tIAu0IXXt2gJv2mgCcdfQNYgYCshWZRoMdVK2Geb4IoBgjZcMMln86V5XfNz8Ai4CejtW4WAglL
	pcMEPhgWrU58t5q3L/eyqn6iBSO3cGGPnm7QbswFBfdNYp4LRTZAdLmk=
X-Gm-Gg: AYBFou0m2ppDQPCEgKXJM56AiWNnxB2AGN8zfjcGUJWEeQEBb4vRbNYvH54dENiDBPV
	UKOQ10B79ATv2IyR9GHpPZCKECdxhzmPTPTkFYJG80OI5QLc+1xr++UzX2Iucwz5ruj9hSsOQOf
	JhpNYo5beiS28TBsRzD62UVjfBIMh+iBfDt+q/2DU06b0H53j/YjimXtg2oik/jdz/XBzyctv5Q
	nmkMWC26BZfW3nDoej058EGBE+TPgiPakCCk69WyOR3vdqnj96x3gODxkKeijVoL7lc0rifjQt3
	+p38TAx4zb38XEUXKN/2S+tcZVDeP/10k4Pn7se9picN/IMhJRMnjy4q3syBqvjt5AMalTFdqBZ
	X4MmQEW0NfseazLR9TDPATJwdFqsavruEXJJ8xtQOLBU2mb5uafQuyA==
X-Received: by 2002:a05:693c:83c3:10b0:33b:e842:c0ff with SMTP id 5a478bee46e88-33e88b2f9cemr356554eec.0.1790106039626;
        Tue, 22 Sep 2026 12:40:39 -0700 (PDT)
X-Received: by 2002:a05:693c:83c3:10b0:33b:e842:c0ff with SMTP id 5a478bee46e88-33e88b2f9cemr356508eec.0.1790106038976;
        Tue, 22 Sep 2026 12:40:38 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7c63bsm412187eec.10.2026.09.22.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:40:38 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:40:33 -0700
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
Subject: Re: [PATCH v19 05/20] KVM: arm64: Track the type of VM in kvm_arch
Message-ID: <20260922123928.0000443e@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-6-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-6-suzuki.poulose@arm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4OCBTYWx0ZWRfX2y2Qs3kx1/0I
 a4HaI8EL16qlpJuXXBfYC4bEMYk9wItsLFs/PIR48cL2QgrxT8E0WolStflgYUorIYMNJbqaIRN
 BKzurOniWWYc2wRN8A7TCzwiFga1wHEpJ9hoPgwoMkEZlFmMM8PVEGlr2W+wXgI3pQDmFcsoxNK
 g/RdcvcNYI6Mi+H/Yg4E168K2nveKA793Zuj9WIAEPl97+YaXqWH5EYRF3CWqVwHR7QTVhrcOBn
 d9mnVEeTgiO6IqEJbMCaxJrV6m4PSF6/YgC/s+WIcmOQVOLcETkoYI7wL2xOCrkeirQlkT4PBvH
 4BKyYpRisKfSbLazH+LXUB8F9uJLg48Buw40DQ6jCUlKgpw8h8lTPteMud+Yg8Fs+JCbt3qZ6R4
 towQjXtDaIBrG7gyh+hlvo8BnG/UGy+Zsd5Ihbuo3BL+9ezfG+j7/m0Goq4QuoqXrLlzV8i6wRB
 MpOY5hZkYawIRW3spsg==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab2d9b8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Rj_uqbnfv5dchc8eNrcA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: CW_11MgtYOiwNSem-AYhg9VoifBO1z5T
X-Proofpoint-GUID: CW_11MgtYOiwNSem-AYhg9VoifBO1z5T
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4OCBTYWx0ZWRfXzWJ6EserSwHy
 jBzZYg4FybHbR6ZbweJ7QcMBWPbyWfaGNJt4aUtEPDgieigcwcbvfDZOb9+7/RoRneTUZW+mf2W
 mpz6eW9PkL4hz3jcf4LAmtqRCuBFUqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220288

On Sun, 20 Sep 2026 22:28:30 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> KVM arm64 has different types of VMs with all the different modes in which
> the hypervisor code can be run. e.g., VHE, nVHE, pKVM etc. Then there is
> protected VM and normal VMs with pKVM. We might soon add other types,
> e.g., Arm CCA Realm.

Let's have some optimism!  


> 
> Realms support is restricted to VHE host and thus "kvm_vm_is_protected()"
> checks in the pkvm hyp specific code doesn't need to change, as the only
> protected guests it deals with is "protected pKVM" guests. To tighten this
> init_pkvm_hyp_vm() restricts the hyp copy of the vm_flavor to the ones it
> supports.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Seems sensible to me.  One trivial thing inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  arch/arm64/include/asm/kvm_host.h | 22 +++++++++++++++++++---
>  arch/arm64/include/asm/kvm_pkvm.h |  4 ++--
>  arch/arm64/kvm/arm.c              | 31 ++++++++++++++++++++++++++-----
>  arch/arm64/kvm/handle_exit.c      |  2 +-
>  arch/arm64/kvm/hyp/nvhe/pkvm.c    |  6 +++++-
>  arch/arm64/kvm/mmu.c              |  2 +-
>  arch/arm64/kvm/pkvm.c             |  6 ++----
>  7 files changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 286489a69dff5..9b1cf9c59e81f 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -257,7 +257,6 @@ struct kvm_protected_vm {
>  	pkvm_handle_t handle;
>  	struct kvm_hyp_memcache teardown_mc;
>  	struct kvm_hyp_memcache stage2_teardown_mc;
> -	bool is_protected;
>  	bool is_created;
>  
>  	/*
> @@ -306,9 +305,19 @@ enum fgt_group_id {
>  	__NR_FGT_GROUP_IDS__
>  };
>  
> +enum kvm_arm_vm_flavor {
> +	VM_NVHE,
> +	VM_VHE,
> +	VM_PKVM,		/* Normal guests on pKVM */
> +	MARKER(__VM_PROTECTED),
> +	VM_PROTECTED_PKVM,	/* Protected VM */
> +	VM_FLAVOR_MAX,
Trivial but given whole point is this is an end marker, drop the
trailing ,  No point in making it easy to break the ordering!

> +};
> +
