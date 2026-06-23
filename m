Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026572E7165
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205823; cv=none; b=IAu95GvlXz8K2OLSuRJPWCfCm1cFVoEA8fh2hkkcmZ12rJuBVGGsnBPeNG6QetVCk0gUmwGMSGdcwsPFVw/Nja+1vW/xWj0dtZYNn0REHj78++37GHWveDYVZeWcPxRd607duhSGBsBWwKn3oiDcMoG0WCSro1lLB8xBSXYMCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205823; c=relaxed/simple;
	bh=YwQU0edTpPOcCEMgnAQy/uZDQHRrq4a1qIStMG9IHxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXAI6bn8MzaGpTtq7ltT2xVXvwn8YVPtPCDbLmsezBJ2BsOF8j9gqHS4uREhEF5k3bT232+TpqVy7AI+s8KmStkTaY0iyfapO9Y9QBqkKIrrzYbU4Tys1WZy4A9Kf/lcCzYiWIGGa9r/dUzxEhRYb5Q226PstJDFufuNFuqUDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WATvb6KG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WATvb6KG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mO8O1206947;
	Tue, 23 Jun 2026 09:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nxL8K2WXTlj26aahDpPwbW83ats06s
	yiIyU25JcKL60=; b=WATvb6KG2kSpz1XRiGAyEz4Hd2kqoVwje8n7XdoCn3Qjm5
	GTTn6EN1mDyWkJ8NAHXAybHRpFCenbU5BRx6oLhlIa8i6q5T1x8LlMhT1hrMWWcQ
	TxqjijdsUen9wUSZx+eiuegxnokEDTSb6kXNJoix7ac4HlJDghDXnAHp6RFdT8rk
	kt82eMWUxTdnK5opnHlHrDPy4E2NCSzdyTgpQvHqE1APwr3DIn9lU8LO1BS3Rb4t
	05mJrkXiOTIQmB8Gvm//Q4WjRSxUqZ5Y/KG91XbljoktYbYl+EJwFkgwlZVacsHP
	EWtuSEyJG6MtzpRNjyOIIoIJydkdn1sz4KWPsH5w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3dntc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:10:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N94hNC027704;
	Tue, 23 Jun 2026 09:10:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k2eqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 09:10:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N9A6tH19006184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 09:10:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A0352004D;
	Tue, 23 Jun 2026 09:10:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5440F20040;
	Tue, 23 Jun 2026 09:10:04 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jun 2026 09:10:04 +0000 (GMT)
Date: Tue, 23 Jun 2026 14:40:07 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] target/ppc/kvm: Add support for querying host
 compatibility mode
Message-ID: <20260623125128.eb3172d2-da-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
	qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
	Glenn Miles <milesg@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	qemu-devel@nongnu.org
References: <20260616113915.25589-1-amachhiw@linux.ibm.com>
 <20260616113915.25589-3-amachhiw@linux.ibm.com>
 <87wlvubx9d.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlvubx9d.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a4d74 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=c8eYTohmUjy21_sDhEwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfXyPEIALbRZM0h
 xTj6cebBxKlK7QY5pNEupEq+RPGPG1UZlaSrOMK8mq4UmGVSDtG6owTZVy82w2S++4hT+YlSWFh
 KV3GXZD2FsgPjcG5FDVlbWsxCB3UhO4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MCBTYWx0ZWRfX9WvRTMt97/HI
 YXYAWc/S7lnxzCQtfSB90JUmoTOknfsvRiNbboJPPp8r2hchVTlGG5q4QwplrmOp9HRyJqBbpXv
 WiKfIt76l7UIhAcVT5Re+Zw6TuJASUYcRciIepYVSxBg5F5+F2Ysop8Xf1ukVlCk2MWeIDNY5no
 Fw/9ngxdXMvaveE2KhPYTHFshQFL7xIRb196Cy4xXwLzVoLlDdXvSKznCfMgZCRGRw70VpHQFjT
 B9GMyOj2zHSjfKHdt2Ty4piY31Q//BGkNzVdFU6sZyOCkUsuTdcNu4jPDY++zfGZjJj2rj3V7n7
 R0u3weVyR3e29w+vvO+VzwFdsDpOkWjyHBCHE7jPHZ36CmijmIC+9mSMalkiqOZfLBzRAEa8BBc
 /i1gex9M4dVKQiclNxt1G/baHMhcrDpKN5LjQrhKOT/tScZR5lIDUCjT4TRifVUnYucwBiKFyeE
 RWp+MWHm3JUA0EYEqdA==
X-Proofpoint-ORIG-GUID: Ih88yYGl2Rb8pqngCxjJEv_zANeH3jg5
X-Proofpoint-GUID: 15Ao-AsMc8USq7_JtQNAra6zgpDNYpmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230070

Hi Vaibhav,

Thanks for reviewing the patch. Please find my reponse inline.

On 2026/06/19 04:41 PM, Vaibhav Jain wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Add infrastructure to query the host CPU compatibility mode via the
> > KVM_PPC_GET_COMPAT_CAPS ioctl. This allows QEMU to determine if the
> > host is running in a compatibility mode (e.g., a Power11 processor
> > operating in Power10 compatibility mode).
> >
> > The kvmppc_get_compat_caps() function queries KVM for host compatibility
> > capabilities with size field validation for ABI compatibility between
> > QEMU and the kernel. The kvm_ppc_host_compat_pvr() function derives the
> > effective PVR based on the compatibility mode reported by KVM.
> >
> > Additionally, cas_check_pvr() in hw/ppc/spapr_hcall.c is updated to
> > prevent fallback to raw mode when the host is running in compatibility
> > mode. This ensures that nested guests cannot exceed the host's
> > compatibility level.
> >
> > If the capability is not supported or the query fails, the functions
> > return 0, allowing fallback to existing behavior.
> >
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  hw/ppc/spapr_hcall.c | 14 ++++++++++
> >  target/ppc/kvm.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++
> >  target/ppc/kvm_ppc.h | 16 +++++++++++
> >  3 files changed, 95 insertions(+)
> >
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 60ba215e8611..68c29fbe141b 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1135,6 +1135,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
> >  {
> >      bool explicit_match = false; /* Matched the CPU's real PVR */
> >      uint32_t best_compat = 0;
> > +    uint32_t compat_host_pvr = 0;
> >      int i;
> >  
> >      /*
> > @@ -1162,6 +1163,19 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, uint32_t max_compat,
> >          }
> >      }
> >  
> > +    if (explicit_match) {
> > +        compat_host_pvr = kvm_ppc_host_compat_pvr();
> > +        /*
> > +         * If the host is booted in a compatibility mode, do not try booting in
> > +         * the raw mode as it may allow KVM guests to boot with a higher CPU
> > +         * version compared to what host was booted with; which should not be
> > +         * allowed.
> > +         */
> > +        if (compat_host_pvr) {
> > +            explicit_match = false;
> > +        }
> > +    }
> > +
> >      *raw_mode_supported = explicit_match;
> >  
> >      /* Parsing finished */
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index b94c2997a07f..9e5006e0c2cd 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2602,6 +2602,71 @@ bool kvmppc_supports_ail_3(void)
> >      return cap_ail_mode_3;
> >  }
> >  
> > +#if defined(TARGET_PPC64)
> This define would be implicit for this file. I think you should target
> these functions for CONFIG_KVM. Otherwise you will have multiple
> definitions of kvm_ppc_host_compat_pvr()

No, this is not implicit. I had fixed a ppc32 build breakage for ppc32
in v2 of this series with these guards (the same is also documented in
the cover letter).

I believe explicit check for CONFIG_KVM is redundant as target/ppc/kvm.c
is only compiled when CONFIG_KVM=y (please take a look at
target/ppc/meson.build:54):

  [...]
  ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))

> 
> > +static target_ulong kvmppc_get_compat_caps(void)
> > +{
> > +    struct kvm_ppc_compat_caps host_compat;
> > +    target_ulong host_caps;
> > +    int ret;
> > +
> > +    if (!kvm_check_extension(kvm_state, KVM_CAP_PPC_COMPAT_CAPS)) {
> > +        return 0;
> > +    }
> > +
> > +    /* Initialize the structure with size field for forward compatibility */
> > +    memset(&host_compat, 0, sizeof(host_compat));
> > +    host_compat.size = sizeof(host_compat);
> > +
> > +    ret = kvm_vm_ioctl(kvm_state, KVM_PPC_GET_COMPAT_CAPS, &host_compat);
> > +    if (ret < 0) {
> > +        fprintf(stderr, "KVM: failed to get host capabilities\n");
> Should use error_report instead of fprintf(stderr,..

Good catch and my bad. I intended to replace these with error_report()
after my testing but missed to do so. I'll fix this in the next version.

> > +        return 0;
> > +    }
> > +
> > +    /*
> > +     * Validate the returned size matches our structure size.
> > +     * The kernel validates that userspace provides sufficient size before
> > +     * the ioctl, and returns its own structure size. A mismatch indicates
> > +     * a version incompatibility between QEMU and the kernel.
> > +     */
> > +    if (host_compat.size != sizeof(host_compat)) 
> This error handling differs from the kernel code which can indeed return
> host_compat.size < sizeof(host_compat).

You are right. I Will unify this check.

> > +        fprintf(stderr, "KVM: host_compat size mismatch (expected %zu, got %lu)\n",
> > +                sizeof(host_compat), host_compat.size);
> Error message can be more user friendly. Also your should use
> error_report instead of fprintf(stderr,..

Will fix this and think about a better error message.

> > +        return 0;
> > +    }
> 
> > +
> > +    host_caps = host_compat.compat_capabilities;
> > +    return host_caps;
> Minor: Why not just return host_compat.compat_capabilities instead of
> this extra store

Yeah, removing this extra store makes sense. I'll fix this.

> > +}
> > +
> Minor: Minor comment about this function would be nice to have

Sure, will do.

> > +uint32_t kvm_ppc_host_compat_pvr(void)
> > +{
> > +    uint32_t compat_host_pvr = 0;
> > +    int cap_idx = 0;
> > +    target_ulong host_caps = kvmppc_get_compat_caps();
> > +
> > +    host_caps = host_caps & KVM_PPC_COMPAT_BITMASK;
> > +    if (host_caps) {
> > +        cap_idx = 63 - __builtin_ctzll(host_caps);
> you probably need to use clz64() instead of this.

I agree that __builtin_ctzll() should be replaced with QEMU's portable
function for consistency and safety, but clz64() would be incorrect
here. The code needs to find the lowest set bit (rightmost in PowerPC
MSB-0 numbering), not the highest.

For example, with host_caps = 0x3000000000000000 which advertises the
support for Power10 and Power11 via bit 2 and bit 3 respectively:

- Using clz64(): clz64(0x3000000000000000) = 2 (wrong - gives bit 2)
- Using ctz64(): 63 - ctz64(0x3000000000000000) = 63 - 60 = 3 (correct)

The correct fix is to use ctz64() instead:

    cap_idx = 63 - ctz64(host_caps);

This maintains the logic while using QEMU's portable bit manipulation
function from qemu/host-utils.h, which also handles the zero-input case
safely (though we already check for non-zero host_caps).

> 
> > +        switch (cap_idx) {
> > +        case KVM_PPC_COMPAT_CAP_P9_IDX:
> > +            compat_host_pvr = CPU_POWERPC_POWER9_DD22;
> > +            break;
> > +        case KVM_PPC_COMPAT_CAP_P10_IDX:
> > +            compat_host_pvr = CPU_POWERPC_POWER10_DD20;
> > +            break;
> > +        case KVM_PPC_COMPAT_CAP_P11_IDX:
> > +            compat_host_pvr = CPU_POWERPC_POWER11_DD20;
> > +            break;
> > +        default:
> > +            break;
> > +        }
> > +    }
> > +
> > +    return compat_host_pvr;
> > +}
> > +#endif /* TARGET_PPC64 */
> > +
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >  {
> >      uint32_t host_pvr = mfpvr();
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 742881231e16..5970e7383740 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -81,6 +81,17 @@ bool kvmppc_supports_ail_3(void);
> >  int kvmppc_enable_hwrng(void);
> >  int kvmppc_put_books_sregs(PowerPCCPU *cpu);
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
> > +
> > +/*
> > + * Bit position indices for KVM_PPC_COMPAT_CAP_* capabilities.
> > + * These represent the result of (63 - bit_number) for each capability bit.
> > +#define KVM_PPC_COMPAT_CAP_P9_IDX   1  /* 63 - 62 */
> > +#define KVM_PPC_COMPAT_CAP_P10_IDX  2  /* 63 - 61 */
> > +#define KVM_PPC_COMPAT_CAP_P11_IDX  3  /* 63 - 60 */
> Can these be derived from KVM_PPC_COMPAT_CAP_POWERXX
> Also if these defines are only used in kvm_ppc_host_compat_pvr() then
> should be defined near to it.

Deriving these would require using ctz64() in the preprocessor, which
isn't possible since it's a function, not a macro. I tested this:

    #define KVM_PPC_COMPAT_CAP_P9_IDX (63 - ctz64(KVM_PPC_COMPAT_CAP_POWER9))

And got a compilation error:
    error: case label does not reduce to an integer constant

This is because switch/case statements require compile-time constants, 
but ctz64() is a runtime function call.

Explicit bitmap index defines are already used elsewhere in the codebase. 
For example, H_GUEST_CAP_XX_MODE_BMAP in hw/ppc/spapr_nested.h.

Also, I prefer keeping these in the header as they represent the KVM
compatibility capability bitmap layout and could be useful for other
code in the future for any other KVM operations that need to interpret
these capabilities. But I don't really have any strong feelings about
this. Please let me know your views.

Thanks,
Amit

> 
> > +
> > +uint32_t kvm_ppc_host_compat_pvr(void);
> >  void kvmppc_check_papr_resize_hpt(Error **errp);
> >  int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_ulong flags, int shift);
> >  int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int shift);
> > @@ -440,6 +451,11 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >      return NULL;
> >  }
> >  
> > +static inline uint32_t kvm_ppc_host_compat_pvr(void)
> > +{
> > +    return 0;
> > +}
> > +
> >  static inline void kvmppc_check_papr_resize_hpt(Error **errp)
> >  {
> >  }
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> 
> -- 
> Cheers
> ~ Vaibhav
