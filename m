Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFDA4EB877
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116953; cv=none; b=BGgDNQMXkGlqoJ0/8eNJbjSuSNWXB3BQjDz1TeMqI1CeOZQ7Jym/CkoPVCtcPP9BJdJIpMQTka00Lg6P9BTyZqjCHmDKgWn+QL0ZU8uvhLUUL6YY6+qJn66cfg4Lh8opRGyY8httHFhxtEQKQTDHDGcSoTABtOESyvlpsd+cR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116953; c=relaxed/simple;
	bh=TuulLzPlORgXvFolK/4BKymKSY5UdUG0I9DOV79/2LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijNt1QG60d2kb8iclqOtM4HqTmBVsUnJ/MpjoBu0NEfXzx77fBikvQhTOuNyb68hkksU/kANwXGyQGurYGWUrANaWEbaJR5i/FXtlmXy0+X/v9FrcvZHeN84Qi/CfqDd/G+X3lvfC2cp/7cQid5Q8JKh4ZX6fAWeeBvWUK6/cVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=my4HTeXu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ILtFyRuo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="my4HTeXu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ILtFyRuo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI76Aw1348915
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2xvk7yaRvmx3POKolJ3kCG15kscgZd6Hbrm/vBfl0Qo=; b=my4HTeXumBECvXzV
	j4c3b7Ko5e6iN9r2j3NaIr1WpIryDMswNKztKULaiH8U/S7ed7WOZ7+wYlE1HGpZ
	Hjt7hlE+tqLbaKwoCMBzhnekwiW98RiuAjhMEWROURtje/dnsQNi5K9t8cLsfksg
	OK5dM07a0eZwN2xql6E+x7ZfZEREKFLZPhzP9ZLMIgCam6nPMdqMyypmmVAAAYrv
	cun2124+4GbE74oUkP+6ObMz39ad7IIGsV7TCdtRhCrD78bkU6Z2gexaPF3J59kR
	LDm5IvrdJQsW9cIS9LhubQ23adBqpJUs9wuxdR6EaJcni9Eeo5LQzoGg++obw/VM
	PV28Qg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux861dk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 22:42:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-331b2ec616fso1091618eec.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790116944; x=1790721744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2xvk7yaRvmx3POKolJ3kCG15kscgZd6Hbrm/vBfl0Qo=;
        b=ILtFyRuoul5qDT04Sr38TVkpnLLidnNaHt4kiE0isfngZCnS/osDgwLxP1O3pHgaCI
         DeKP5m40Q4lblrBqaeOZdT/Z7RkyjxiEydRQq8wkz9fatnXqzF7Rhf9Tam1wJeOx0BB6
         NvO3OutbY/7KQ+mkeXUKNZ/pF0CkBDlExh+eoAwK6AVAjB0OwddWXGNzf5uGOlHyP2Xe
         nykWXrDmF6Pv9p4WnU2WQlIPPBePkMYNVFMOV4VX3F9vCkdPFAjTeRRThI5p2Ztz9SIZ
         gtkIU2mw1Yq6Nrg6GOgH5gMPSmgt/jTegG8Gej2CelVToP8sBs2iFM1CSNqZs17f7Sub
         beLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790116944; x=1790721744;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xvk7yaRvmx3POKolJ3kCG15kscgZd6Hbrm/vBfl0Qo=;
        b=icGV23CDDDcILcTGsOQXFFMUh/BMXUORkNkXYaJYL3/pUtkDpW3wUOmW8bvm785tN3
         MNsFvE9pSpj1Tl3If2qLCIWIRBOWNNwA4akfUKEF2o8EjRyRsnZl/A+vneolhMl7HI9W
         gSTjCpF8Zk/F2AFo2b4v8l3bKElgmCPXI9E+joXJ8bs2XmczrTlKfSK12Qy7qe/qMoQy
         4wAEzWibicXQGdrtec/mMra0vg/5nuQSlpD7gTZEXHy97SWpDCHHY/yKi250Sg2J5I9a
         niJLc4uZBYRL72BtBdqPwVKnu5NUpNQhldR2v7u/Wz7tNl3ZzzL2CBEkcW70mx89AYRu
         d8Vg==
X-Gm-Message-State: AFuF++lkVTgkzuQPCUvfg0Gum355h1e8U9o9Bi4q8uB5RVlrZPHCBMT0
	D06XOdd+MUKKWK1RTkI2G6Md3+3Z5rIl3uqqigY4UToyzH71bSN89I4TOJ35NTTRKX0kVMR+aq4
	nV3gE3wttvGYia/RH9rtGbQciLSWD0IPrw+q4WXYMcKZCHmpmBsB8G2A=
X-Gm-Gg: AYBFou2uUW5JgGTtpceNR5IOBJo4kc+Y4YjUIvOfNRqPcFXinYBeMsLC7GT+YFbIsjO
	tpKd7L6a+hy6cbfZbXUwf8fiuwvEdlztjrHfF2cul1RDq5d7ItWCFoAMrF3YOVTbblXRckAI+tx
	EWNQOjElZkoG2b353ubtYTnm/tJ8BNjZRm4YwGLwiVc1HD1J8BhLFLYNUwlqQVqnUF6ejdgV0vU
	jIr1VVkqPmOxbNx3HpuWp2C1ADtlmItmWtGhVhRewKMdHf9AkyG13L+OhBu9ClwGWghXU4yk5wG
	1wzhRvkUmy2u0P5wT1o6sAhnTNog719qjRcPXANRHsezrDLFrfzwx/FSe+4E8DNRca5v5wiPuNp
	DbxdC+COAHq0PXyVzaIiZ5joZ3UXvesjf3skowionV60X/m4XVA0pQQI=
X-Received: by 2002:a05:693c:6211:b0:33b:de13:9574 with SMTP id 5a478bee46e88-33e8dbc4479mr743989eec.19.1790116943622;
        Tue, 22 Sep 2026 15:42:23 -0700 (PDT)
X-Received: by 2002:a05:693c:6211:b0:33b:de13:9574 with SMTP id 5a478bee46e88-33e8dbc4479mr743958eec.19.1790116942985;
        Tue, 22 Sep 2026 15:42:22 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e48e3esm1266199eec.26.2026.09.22.15.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:42:22 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:42:19 -0700
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
Subject: Re: [PATCH v19 11/20] KVM: arm64: Mandate VGIC v3 for for VMs
 running on hyp that don't trust the host
Message-ID: <20260922154219.00000999@oss.qualcomm.com>
In-Reply-To: <20260920212845.707-12-suzuki.poulose@arm.com>
References: <20260920212845.707-1-suzuki.poulose@arm.com>
	<20260920212845.707-12-suzuki.poulose@arm.com>
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
X-Proofpoint-GUID: CJ9bc3SCKjWD_Yz6bhqZFAra-GYBtWBa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfX9OcyXIumbGJQ
 un3OdncxN8KQ0cxqXi6k1pwWU0XZki5GqbXgC0oaAAQhiwBppHtDmcakPyqBHb5oFU9awOgRy0e
 aD3MX/zuzI+G71OVqg+ZBdLxFQcugqQ=
X-Proofpoint-ORIG-GUID: CJ9bc3SCKjWD_Yz6bhqZFAra-GYBtWBa
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab30451 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=7nvTRwv7b12_b2Z3:21 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=99P15FIpgWgLHUSX_UoA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDMwMyBTYWx0ZWRfXzYeDREPjteMN
 5NvfSayvM+SvcjimUHO4U3nvi2Taf0GUvHRHJIiVw5nKS0hh8e9ZnktAOJfoNM+mkXO9TsmcBhP
 UPqxU9xwMnR/DDRkndDH/FbaS4jw1Ozj+OTizp56L1jXldTsbWIxfp5qu1HODsHh+tbZaLQ7vTV
 4ffWz6TTWRb3qfnz9gY8C1l9E559vvUsEGgCTCv8gYO++oQXTW+6QpvwSFZk3FW2s2fR+ODwkrD
 0dlNlkaR/BsGh2bs89rVNFW7fTN+dsG0z7spgtnQAIrYyN4NzH/QaJc/Lul9VDwA5vWPcdF3BxF
 GBgk4zHRc8U8rzH5ngDN6EKbluhPY154qVl9F2OpS6RAZpY5d/d2YjhSr0VeXvEFVUlL1FKv1tO
 i+pkrA2fhiAiC1Dax6OAUiLV7NnFi6DOhbo9h7gFfYQazqcomVXgYxemSGxCYFBW7koKDBqdYFs
 1xar1Qx3nlQkrHP/XNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220303

On Sun, 20 Sep 2026 22:28:36 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> pKVM and RMM, both do not trust the host. Add a helper to detect the VMs

Maybe don't mention RMM yet, or make it clear that isn't here in this
patch.

> that have "distrusting" hyp. Use this for blocking ioremap of vgic-v2 into
> stage2 and prevent creation of VGIC other than v3.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Other than minor comments, it feels to me like these first 11
patches are good cleanup even without the RMM stuff that follows.
Perhaps can get these upstream faster than the rest?

Jonathan

> ---
> Changes since v18:
>  - Cover pKVM guests for VGIC v3 mandate.
>  - Merge the VGIC mandate check in here.
> ---
>  arch/arm64/include/asm/kvm_host.h | 3 +++
>  arch/arm64/kvm/mmu.c              | 2 +-
>  arch/arm64/kvm/vgic/vgic-init.c   | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 3211543a85b38..bb156a633ab75 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -328,6 +328,8 @@ enum fgt_group_id {
>  enum kvm_arm_vm_flavor {
>  	VM_NVHE,
>  	VM_VHE,
> +	/* VMs running on a hyp that doesn't trust */
> +	MARKER(__VM_DISTRUSTING_HYP),
>  	VM_PKVM,		/* Normal guests on pKVM */
>  	MARKER(__VM_PROTECTED),
>  	VM_PROTECTED_PKVM,	/* Protected VM */
> @@ -1546,6 +1548,7 @@ struct kvm *kvm_arch_alloc_vm(void);
>  #define kvm_vm_is_unprotected_pkvm(kvm)		\
>  	(is_protected_kvm_enabled() && ((kvm)->arch.vm_flavor == VM_PKVM))
>  
> +#define kvm_vm_hyp_is_distrusting(kvm)	((kvm)->arch.vm_flavor >= __VM_DISTRUSTING_HYP)
>  
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature);
>  bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index cf293d09e940a..413c4b114d75d 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1251,7 +1251,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  				     KVM_PGTABLE_PROT_R |
>  				     (writable ? KVM_PGTABLE_PROT_W : 0);
>  
> -	if (is_protected_kvm_enabled())
> +	if (kvm_vm_hyp_is_distrusting(kvm))
>  		return -EPERM;
>  
>  	size += offset_in_page(guest_ipa);
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
> index 4012df6002ea6..874025513afcc 100644
> --- a/arch/arm64/kvm/vgic/vgic-init.c
> +++ b/arch/arm64/kvm/vgic/vgic-init.c
> @@ -84,6 +84,8 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>  		!kvm_vgic_global_state.can_emulate_gicv2)
>  		return -ENODEV;
>  
> +	if (kvm_vm_hyp_is_distrusting(kvm) && type != KVM_DEV_TYPE_ARM_VGIC_V3)
> +		return -ENODEV;
>  	/*
>  	 * Ensure mutual exclusion with vCPU creation and any vCPU ioctls by:
>  	 *

