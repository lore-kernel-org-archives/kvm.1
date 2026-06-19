Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DA287268;
	Fri, 19 Jun 2026 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849720; cv=none; b=ngvzQbVelEAs+W257b0SFouibzlrIyqWQhld3GkjQiMBtWKe+u2fPwALp5EXGVwJwT9vIzMyQ/mLnW8dN+T+QZCPBzdpkhdwdctYAhFI15MX8vCtsyK48DH/2/kKs/otL4J54h2dC3ldMe/r+MWXCdXYSPRWdfiW7c+a0NIXNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849720; c=relaxed/simple;
	bh=wr/Lp0o925ZXpBCt/3zfM+JnkECQrT/eXBAVertCmz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CD4ykNBhgw7Q1izvMwV7ivTJUUtQoPgAKtExe52ThK9UT7AejbK0CnjywteI855r1P9ii6tt0JEZDDFjZKpQqhRe/jiYIw18EOeet3BrqbBeYLDUMlWmRLTpka7ZM77pOM09K5OBBwZ5rLOztnecDtxsvW20roqdMaoscXdw9pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kGv/UaIo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kGv/UaIo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3IXFG1116579;
	Fri, 19 Jun 2026 06:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N9WGKVXq2UqaQ0+nIzsGUfe75rS6wG
	R6BEBoc+Wixcg=; b=kGv/UaIoRwQhGHR+yHUNihGAz5e2CoJ43ca11ML/4/b7iu
	0aijgDQfMp6D4Zrdqdw9mfKtAmJEOUEsCT0qviGzzodVxdunaUuCBEPhTpgAl54N
	Me5pB9iSlahynqUfx4Y9vHoH9RL9yevB1J5DxC/o7QB2wwIUTgXZi6zNE8INNHKd
	oL+Nohn4ZN68ExmdaL6lvRdQ4v/FkRdFop2YW9QA8ATswEhW0/Cg0p5Dxf87KsfE
	jWijjEH6+YaUbOZxXUcgQNTL3VwcsVMSQ6FzcdB1rLa2CY+oEgGx5Hmv1HQ/7hfU
	UO1SAiqg54dJ9a7lYPEeIZ0x16M5WncwTJH6QhhQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw422s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:15:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J64bev017803;
	Fri, 19 Jun 2026 06:15:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172feum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:15:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J6F2ND34013722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 06:15:03 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2EE758059;
	Fri, 19 Jun 2026 06:15:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2DB358043;
	Fri, 19 Jun 2026 06:14:56 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 06:14:56 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 11:44:55 +0530
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
Subject: Re: [PATCH v4 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
In-Reply-To: <20260616123314.82721-2-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-2-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:44:55 +0530
Message-ID: <871pe3cazk.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX30gfv+TcQrtF
 v2fu0TcJBKcjLz+hJXSPIphOJWI0imWzVZQDhwLTQkBKl+cWVSjjCAXU5Oj/WuIZfvEktrPi7lA
 ovaXBHkFeK2d7b/lv0mVzgNxLW64YEY=
X-Proofpoint-GUID: wqNhlxy33C7NbSHWPuNqGN1mC9rYRKUI
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a34de69 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=fta_d2NlTjNxvIL-FKcA:9
X-Proofpoint-ORIG-GUID: RgYr7eR6PuaLHU6C-Fo8QGxqzQR_q9Cn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX+36aUoqJnMLy
 PCZmtdzjL2OhAmJdoMH0oQ6C7RgYsPuvzc0jSprIIlg27DXcWhpGm6wvb9cTcj4vAXqEtw/hGGL
 hq2UajxR8CelU5o7XYyP0n4mqpQrRifZ2W14cWmeH1nTMfAYDlSHgAeUR4AnmaWGgVWsbDphjwC
 4EIObecj+CLOWRucHSWnMwCTtIn0LikX1vriWcihjl0gy1o36GkKA2nhR8OQ9UTYKfO5J8S5HEP
 L1ECfXfor1PzHa0qDgkxd+boQEq8qET3XeAGSdg9uHeDT+nSHg6q31yu5IjfgANmcUqcH766OST
 7VpGZQqu+DfZ04BHcOBLXUECHZBNgJrFep+i80ftYTAbi0zhNCCjX5YQw6p5jf2EGXY6xBMW+A0
 AVpG+TLyZhVX4C4FxxmXg1OlVrNroCH7lmxbBr0QgK6pwvA6aZsmIpi5K/6X/1dUf7PuAhKvNz4
 Vcpv3rMCR2snpGNSpGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190051

Hi Amit.

Thanks for the patch and incorporating V3 review comments. Further
review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
>
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
>
> Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> the compatibility modes supported by the host in respective bit numbers,
> allowing userspace (e.g., QEMU) to select an appropriate compatibility
> level when configuring nested KVM guests.
>
> The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> CPU compatibility capabilities via a PowerPC-specific backend
> implementation when available. The implementation validates the structure
> size from userspace to ensure forward compatibility and returns
> appropriate error codes (EINVAL for invalid size, EFAULT for copy
> failures, ENOTTY if backend is not implemented). The struct
> kvm_ppc_compat_caps includes a size field to support future ABI
> extensions.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  7 ++++++
>  arch/powerpc/kvm/powerpc.c          | 35 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  4 ++++
>  4 files changed, 47 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..169ea6a7fbad 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>  	bool (*hash_v3_possible)(void);
>  	int (*create_vm_debugfs)(struct kvm *kvm);
>  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>  };
>  
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..8a38be6c3b03 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,13 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	size;			/* Size of this structure */
Suggesting moving the 'size' as the first member of the struct. That way
copying the struct from userspace becomes bit easier.

> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 98de68379b18..9153b0034b45 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -701,6 +701,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r = 0;
> +		if (kvmhv_on_pseries())
> +			r = 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  	default:
>  		r = 0;
>  		break;
> @@ -2467,6 +2474,34 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps;
> +		u64 user_size;
> +
> +		r = -EFAULT;
> +		/* First, get the size field from userspace to validate */
> +		if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
> +		     __user *)argp)->size, sizeof(user_size))) {
move the struct size member to the first field. That way
from_from_user() call is simplified and you wont have to do some wired
pointer arithmetic.


> +			goto out;
> +		}
> +
> +		/* Validate size - must be at least the current structure size */
> +		r = -EINVAL;
> +		if (user_size < sizeof(host_caps))
> +			goto out;
Check should be strengthed to
 if (user_size != sizeof(host_caps))
So that in case used space sends a struct larger than what kernel knows
abt it will be rejected. This will prevent surprises in future in case
VMM sends a larger struct expecting kernel to know abt it but an older
kernel only knows abt older smaller sized struct. Also look at the
review comment below.

> +
> +		r = -ENOTTY;
> +		memset(&host_caps, 0, sizeof(host_caps));
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		/* Set the actual size of the structure we're returning */
> +		host_caps.size = sizeof(host_caps);
> +		if (!r && copy_to_user(argp, &host_caps, sizeof(host_caps)))
> +			r = -EFAULT;
You are allowing a future userspace VMM to potentially send a larger
'struct kvm_ppc_compat_caps' that what kernel knows about. This makes
error handling in userspace bit involved since there might be some
fields in the 'struct kvm_ppc_compat_caps' given from userspace may
remain un-initialized when userspace sees it. So please mention this
subtle behaviour should be mentioned in patch description and also
update it the doc in the later patch.

> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm = filp->private_data;
>  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..1788a0068662 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_PPC_COMPAT_CAPS 249
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>  
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
> +
>  /*
>   * ioctls for vcpu fds
>   */
> -- 
> 2.50.1 (Apple Git-155)
>
>

-- 
Cheers
~ Vaibhav
