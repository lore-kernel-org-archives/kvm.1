Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2396326928
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867504; cv=none; b=gTP07NJtvNGclbd6BZKzGslFpuz5RW2fU914+vSXkLGuMH6ZXP3hG2tv0o896ARA9HATr1mQzP9hYZ9HOxOKF+9FfmkkqKZe46cBJ743/AQClWXh6y1J/IDWWGakan7ViwQpyJlefNzUzyzbhz9FWQQ8z/R6qLzN7QwkyXdMo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867504; c=relaxed/simple;
	bh=SM2VBNRKp9SBDD50j4mA8gWj8W728zGFZcoSE8a0jq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QDre9Ib8Ec7DsH7EUrV547cmK4fZd1Ei1akx9H/c6z0Iv6A8DlU59vmnezDM5RhmkWN+h2QEjrh3/i8xATh/f8o60NytMVZGZdjQeOD/XEwWO9IUupnpLSsIMi7cSEKwtFvED/zDWzTZffiKeHv8ulyGylVNSAvC+uYJhORjfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pf26cu3E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pf26cu3E"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7n6mS1588810;
	Fri, 19 Jun 2026 11:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3O6KvS5VBSq83b9tn3tShktu/pYRkt
	U3XtfsJi2KHvs=; b=Pf26cu3EDs+fQOuHA2gc9/UXCiTf3LBjSsAJq7FPpIkfcY
	W0rdQlQEHOhTAy57HFwj2OzqO94MqngiJMMWuRwKBROGTC5k1UycBRLtuxmVDS20
	Si3rA8rIwvBYfsn6YZZZP6xoNg//KDvh2AhJGRc+0n2WC9B8mz424UM0M4PQ2zxM
	ES5FYDqxep2wa9gq7B70+KjNbG4K04sMAGa82tMac3DSot1HtYQEUZzz+IA4K71B
	xen7NQjZ6FWtRwhlouen0Ye2uA8eg/SWYqhwt+zD9ld2QiUnyqTT0hr3hz0r0cpa
	6HkPY5b60gJLdvpzkG4P0y5ytXofKUu+cP9FHWXw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxd00t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:11:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JB4vX6011195;
	Fri, 19 Jun 2026 11:11:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gg65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 11:11:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JBBXnX14484210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 11:11:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D8C058054;
	Fri, 19 Jun 2026 11:11:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E3E958062;
	Fri, 19 Jun 2026 11:11:28 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 11:11:28 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 16:41:26 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Glenn Miles
 <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] target/ppc/kvm: Add support for querying host
 compatibility mode
In-Reply-To: <20260616113915.25589-3-amachhiw@linux.ibm.com>
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
 <20260616113915.25589-3-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 16:41:26 +0530
Message-ID: <87wlvubx9d.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3iQ2suw8ESLnz7w_zGJshIPtghpOaiu_
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3523e7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Ef3TOmN8yebebzy0SdIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX31sOnWwsUNxg
 /zfh3YrPsU62xOrYTRK6QX0hDwHMt5Oje5p9cCSayCbE4skt6U+QpFHGivTqxEmz3Eo9Nys6l3P
 dxGsIfSnhqqgn7eRtxFvX2nJPzP+6kc=
X-Proofpoint-ORIG-GUID: QcZ0WYPSy0C1ZBvosydUDPtvimOSZwis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwMCBTYWx0ZWRfX+R9NWE9Wlq92
 pEUrdXPjT7JuNsBuZJZhRBEsdUDqURm8gNogBwRXzGBCHqFtvgS4hQ6Fr/NPEvkkRrIypLXiwza
 8wG/XMnr/jJMG3JXdQ+83Sc6soQgvx0hyOiE3HuBJ1WS4J2DnTVRcegZei9J7wxPiPBl9kwtfKR
 tENfTvkt/LdzxKCQyD6UkwGtVsw2mEvHV0f9oEmRiz7gBx2UR+ta2gUcy73uPjzeao9w4SDIDLW
 XglmnaEzUL3jwAxY39HPej2U+dm6B1TtrmbOT2PHEywl6wLuYuSvwXUkSrQzAG3ml3CnuBTtW29
 DLtbkWX+0ZYNw+sasU8WZsND9y7qXW8CqdpsT20wvqE0v8I4r5p2pqF2/P+A/tNRpCdDXIkiAhb
 KOSXQlcePghIWAOo5M/KyHB0ZLpJKaHAXz+fGNxdOmC5e7GC7X9KrCNSzgPDVnzEaFyrgAubdkl
 n0hlr8t/1w/hmEsl8rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190100

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Add infrastructure to query the host CPU compatibility mode via the
> KVM_PPC_GET_COMPAT_CAPS ioctl. This allows QEMU to determine if the
> host is running in a compatibility mode (e.g., a Power11 processor
> operating in Power10 compatibility mode).
>
> The kvmppc_get_compat_caps() function queries KVM for host compatibility
> capabilities with size field validation for ABI compatibility between
> QEMU and the kernel. The kvm_ppc_host_compat_pvr() function derives the
> effective PVR based on the compatibility mode reported by KVM.
>
> Additionally, cas_check_pvr() in hw/ppc/spapr_hcall.c is updated to
> prevent fallback to raw mode when the host is running in compatibility
> mode. This ensures that nested guests cannot exceed the host's
> compatibility level.
>
> If the capability is not supported or the query fails, the functions
> return 0, allowing fallback to existing behavior.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  hw/ppc/spapr_hcall.c | 14 ++++++++++
>  target/ppc/kvm.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  target/ppc/kvm_ppc.h | 16 +++++++++++
>  3 files changed, 95 insertions(+)
>
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 60ba215e8611..68c29fbe141b 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1135,6 +1135,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
>  {
>      bool explicit_match = false; /* Matched the CPU's real PVR */
>      uint32_t best_compat = 0;
> +    uint32_t compat_host_pvr = 0;
>      int i;
>  
>      /*
> @@ -1162,6 +1163,19 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
>          }
>      }
>  
> +    if (explicit_match) {
> +        compat_host_pvr = kvm_ppc_host_compat_pvr();
> +        /*
> +         * If the host is booted in a compatibility mode, do not try booting in
> +         * the raw mode as it may allow KVM guests to boot with a higher CPU
> +         * version compared to what host was booted with; which should not be
> +         * allowed.
> +         */
> +        if (compat_host_pvr) {
> +            explicit_match = false;
> +        }
> +    }
> +
>      *raw_mode_supported = explicit_match;
>  
>      /* Parsing finished */
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b94c2997a07f..9e5006e0c2cd 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2602,6 +2602,71 @@ bool kvmppc_supports_ail_3(void)
>      return cap_ail_mode_3;
>  }
>  
> +#if defined(TARGET_PPC64)
This define would be implicit for this file. I think you should target
these functions for CONFIG_KVM. Otherwise you will have multiple
definitions of kvm_ppc_host_compat_pvr()

> +static target_ulong kvmppc_get_compat_caps(void)
> +{
> +    struct kvm_ppc_compat_caps host_compat;
> +    target_ulong host_caps;
> +    int ret;
> +
> +    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
> +        return 0;
> +    }
> +
> +    /* Initialize the structure with size field for forward compatibility */
> +    memset(&host_compat, 0, sizeof(host_compat));
> +    host_compat.size = sizeof(host_compat);
> +
> +    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
> +    if (ret < 0) {
> +        fprintf(stderr, "KVM: failed to get host capabilities\n");
Should use error_report instead of fprintf(stderr,..
> +        return 0;
> +    }
> +
> +    /*
> +     * Validate the returned size matches our structure size.
> +     * The kernel validates that userspace provides sufficient size before
> +     * the ioctl, and returns its own structure size. A mismatch indicates
> +     * a version incompatibility between QEMU and the kernel.
> +     */
> +    if (host_compat.size != sizeof(host_compat)) 
This error handling differs from the kernel code which can indeed return
host_compat.size < sizeof(host_compat).
> +        fprintf(stderr, "KVM: host_compat size mismatch (expected %zu, got %lu)\n",
> +                sizeof(host_compat), host_compat.size);
Error message can be more user friendly. Also your should use
error_report instead of fprintf(stderr,..
> +        return 0;
> +    }

> +
> +    host_caps = host_compat.compat_capabilities;
> +    return host_caps;
Minor: Why not just return host_compat.compat_capabilities instead of
this extra store
> +}
> +
Minor: Minor comment about this function would be nice to have
> +uint32_t kvm_ppc_host_compat_pvr(void)
> +{
> +    uint32_t compat_host_pvr = 0;
> +    int cap_idx = 0;
> +    target_ulong host_caps = kvmppc_get_compat_caps();
> +
> +    host_caps = host_caps & KVM_PPC_COMPAT_BITMASK;
> +    if (host_caps) {
> +        cap_idx = 63 - __builtin_ctzll(host_caps);
you probably need to use clz64() instead of this.

> +        switch (cap_idx) {
> +        case KVM_PPC_COMPAT_CAP_P9_IDX:
> +            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
> +            break;
> +        case KVM_PPC_COMPAT_CAP_P10_IDX:
> +            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
> +            break;
> +        case KVM_PPC_COMPAT_CAP_P11_IDX:
> +            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    return compat_host_pvr;
> +}
> +#endif /* TARGET_PPC64 */
> +
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>  {
>      uint32_t host_pvr = mfpvr();
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 742881231e16..5970e7383740 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -81,6 +81,17 @@ bool kvmppc_supports_ail_3(void);
>  int kvmppc_enable_hwrng(void);
>  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
>  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> +
> +/*
> + * Bit position indices for KVM_PPC_COMPAT_CAP_* capabilities.
> + * These represent the result of (63 - bit_number) for each capability bit.
> + * Used for identifying which compatibility mode is supported by the host.
> + */
> +#define KVM_PPC_COMPAT_CAP_P9_IDX   1  /* 63 - 62 */
> +#define KVM_PPC_COMPAT_CAP_P10_IDX  2  /* 63 - 61 */
> +#define KVM_PPC_COMPAT_CAP_P11_IDX  3  /* 63 - 60 */
Can these be derived from KVM_PPC_COMPAT_CAP_POWERXX
Also if these defines are only used in kvm_ppc_host_compat_pvr() then
should be defined near to it.

> +
> +uint32_t kvm_ppc_host_compat_pvr(void);
>  void kvmppc_check_papr_resize_hpt(Error **errp);
>  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
>  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
> @@ -440,6 +451,11 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>      return NULL;
>  }
>  
> +static inline uint32_t kvm_ppc_host_compat_pvr(void)
> +{
> +    return 0;
> +}
> +
>  static inline void kvmppc_check_papr_resize_hpt(Error **errp)
>  {
>  }
> -- 
> 2.50.1 (Apple Git-155)
>

-- 
Cheers
~ Vaibhav
