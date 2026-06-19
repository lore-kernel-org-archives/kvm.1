Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075D1E4AF;
	Fri, 19 Jun 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849094; cv=none; b=uEx6lbeVa7/WMV9+ObSjV8aE5CftM1KHsCFlAYAQk56uD4GzUetRkdm4CDlHb4h7x8c8KHG/sWNZR1tsyJwF9AY1kT8IqkI+6FdJNsxlkhJFMUovbzQQWZ47jr5vo1X3iB+VxF1MzhE54M1LBgKuu7MWZ8YCuR98hYrDHQrFygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849094; c=relaxed/simple;
	bh=fkME/WtDXBLpQgzMF8R1M9EG1UJ0viYk8neQkwvsnUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJShNZAxVojSbqMbuPxaHkND+qhxPY+4EzAG2zi0TET0vvi1Accs7on40J2UXlW3WcVZ+dG7zhwHGbY9XtzNU7Oj4bayMs2GU89YJArUZpndBTphhBjXIniW6FE1TubH0Hz6aKQPijkIz4aOKxLZjYHn2joiENiEzTuJwzMdj6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4mCothO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4mCothO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3ITxO1152775;
	Fri, 19 Jun 2026 06:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cYSiXYIja3s/exHnYrx+tpMT5KHrPd
	scpPPy3yBJQqA=; b=n4mCothO6btV4LJ47txGyE9V2F70HBFQP7tOkn/fO70Fr0
	t5AdeT41vZJ9pZlJKWy03vk+awhx+E0oxrmHOdBk/pBhvbcVAsz70w/MGOByfkVE
	OXW/xcnT7+6ndzuUxM7ggDwcLkuTZjyPs+98px5VW4lsocKPEYqztq8pqsC+5fUh
	cV1EfGwzxi9Z80QwK3hQtrcH0Z2z0gGLcwtEAmiZ5DOk2ZP/ozlQl9sAtiZhrD4/
	xdW/vu76n7Fn+qR0OaNkyeiKNYc8ZF4xDlag1xngVpIr7K+OWqgghJBj+a2ecF3i
	AgmUfht1Wl1qyOBey+2bk+ZzgwI+uoPC85JQZrvw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtv1ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:04:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J5nbv7027651;
	Fri, 19 Jun 2026 06:04:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fdm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:04:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J64Sif21955138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 06:04:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1AAC58066;
	Fri, 19 Jun 2026 06:04:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7C4458063;
	Fri, 19 Jun 2026 06:04:22 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 06:04:22 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 11:34:21 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v4 2/4] KVM: PPC: Book3S HV: Implement compat CPU
 capability retrieval for KVM on PowerVM
In-Reply-To: <20260616123314.82721-3-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-3-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:34:21 +0530
Message-ID: <878q8bcbh6.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: GRjfG2396-rjN3sk0NeC9ICqeqVxAua3
X-Proofpoint-GUID: CA0EaxVqhDXa0VhK6injMLzHzNxirnwR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfXwlGNBruTr5AC
 jsylkTYWKqMpNKJF2kJPz1m3fc0hql/8xvBkjwquD9RkJ9vKgqaDNsSCb9dYO+rfPhlo94N1b2A
 FL8JBUJyWEpIRW+zN9e1lm+wZ01RP3UR0hmS/zI/NASoH9L2zrchgyAJnnhvd3xpFvdmHuoxrJX
 0PpCPbOwCSj0Y4Q0Dst6RATU7eITHfRH+619r1O+1z54yfuzynP+kdOFQL6kG40XdPs9oHGoi1A
 mwSl6ZvfiOG+pByATv0WS7C6vEzWiqht5fXEWOt7jk1WHdXai8ahKx0LA4doLuWTtWNIFiV5uy6
 Ha5mn5Fik47SYv7NDb+okKCqFSdN5RurbrGIEG3XZQM9gm5tIgXCiPKKthg+lZXfjpB4+L/WKMk
 8Y9SdAL2UPi8rv+p6zk1zdNWyNZ3khj+Ndui6HPxoR08bAPxHhxR2yQetONMXFsklWq/xdwHQEa
 x7oOh0/j4PdjGAOFDBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX0JpRW+TUpbD8
 PiMZk3I3BrDcQfldZYiXuJQPZsOuOFKJOasaWiCekMH+FD8BpaKTJEsPfEOKoi14gkw6tePTSXu
 AtVKYuUTX2cxP04zwwvdIzGLaL7NTcM=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a34dbef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=EI8JAjJv2T8FAu73W3UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190051

Hi Amit.

Thanks for the patch and incorporating V3 review comments. Further
review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
>
> When running nested KVM guests, QEMU derives the host CPU type using
> mfpvr(), which reflects the physical processor version. This can result
> in a mismatch between the CPU model selected by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
>
> For example, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This occurs because QEMU selects a CPU model corresponding to the
> physical processor (via mfpvr()), while the host operates in a lower
> compatibility mode. As a result, KVM rejects the requested compatibility
> level during guest initialization.
>
> Add support for retrieving host CPU compatibility capabilities for
> nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> hcall, which reflects the processor modes negotiated between the Power
> hypervisor (L0) and the host partition (L1).
>
> On pseries systems, obtain the capability bitmap using
> plpar_guest_get_capabilities() and return it via struct
> kvm_ppc_compat_caps. The implementation defines KVM-specific capability
> constants (KVM_PPC_COMPAT_CAP_POWER9/10/11) and applies masking to ensure
> only supported processor modes are exposed to userspace. This information
> is then exposed through the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> invoked by the generic KVM ioctl handling code.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h | 11 ++++++++++-
>  arch/powerpc/kvm/book3s_hv.c        | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 8a38be6c3b03..730488681443 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -443,7 +443,16 @@ struct kvm_ppc_compat_caps {
>  	__u64	size;			/* Size of this structure */
>  	__u64	compat_capabilities;	/* Capabilities supported by the host */
>  };
> -
> +/*
> + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> + * These bits indicate which processor compatibility modes are supported.
> + */
> +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
> +#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
> +#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
> +#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
> +					 KVM_PPC_COMPAT_CAP_POWER10 | \
> +					 KVM_PPC_COMPAT_CAP_POWER11)
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index f9380ef65750..f674386df62c 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6523,6 +6523,22 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +
> +static int kvmppc_get_compat_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +	unsigned long capabilities = 0;
> +	long rc = -EINVAL;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2())
> +			rc = plpar_guest_get_capabilities(0,
> &capabilities);
I think instead of making the hcall you should use the
'nested_capabilities' extern symbol as it would already the same
value. This symbol is already accessible in 'book3s_hv.c'

> +		host_caps->compat_capabilities = capabilities &
> +							KVM_PPC_COMPAT_BITMASK;
> +	}
> +
> +	return rc;
> +}
> +
>  static struct kvmppc_ops kvm_ops_hv = {
>  	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
>  	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> @@ -6565,6 +6581,7 @@ static struct kvmppc_ops kvm_ops_hv = {
>  	.hash_v3_possible = kvmppc_hash_v3_possible,
>  	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
>  	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> +	.get_compat_caps = kvmppc_get_compat_caps,
>  };
>  
>  static int kvm_init_subcore_bitmap(void)
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav
