Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4A1B6D1A;
	Wed,  3 Jun 2026 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780460274; cv=none; b=h+4UDFbLosOdW5nUbBQUpPRpkNCUC/5b8MzqtrZgdi5bKvMh3//zGAg76ISZtwc6RUR6vPmdoCHXRkVv+AmAqXA1wEVb7sbRrf/vnw9H26D8qE63QozySd6JNQZ7FEbQ7QaVTzkf/XdF2z5dgs0oI8v6PZPL9vh3Rumloos+3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780460274; c=relaxed/simple;
	bh=mTlveGgYRzu0gXq0AxxXuAqkyFzxZwRxdtWAWJMq/BM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QYUhES38kJVOZ7tMlCczpCIlqElIHRT6oCvRHzxjQIFZw5cs1BF1NFT1Zbf5ZObr3Z7SoDSNwBjQBm+Hzqnf+P+LeQHNjRchjII0MPIqObrEKJ500bTKmUZW4p7swXymsrWYUR0Fmwmqi+v4Mc8LG5KLwKD/3GayNTZZDJ9so/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEultLRE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEultLRE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652J23gW2223981;
	Wed, 3 Jun 2026 04:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=F/F78NEv08EoKp0VIyvNTtQciFWlhY
	cXnKYix/etr3Y=; b=fEultLRENtP+ONvsixqkN0ImF/h3c0AC2A/CdZOR2Zl7o4
	dQhYWadkQ/nxbJ8OaJQ5N9PUD0PvG3Jk7o5iIhGO07NN7e2DRdzzHGJ24uWthy/o
	Iks0sDnOgGzMRRFPRaTTCwjbUMb51vNeTeK2FcAYn51yjB5OX6UHIfD0MEdJjWK4
	1e/XWHGTy7Fmztobct23PSW7BG8G3vuZ7sfoFBmSqYVMKRk6i/pGS1a2AcKX+PIY
	AW0TdBfJJQs/OhypnH5R38Gp7rIz/TwZxJq0M7Xq3criNfEzdp8XOmIG7OdiMxK6
	SrbFKdocrHmhGZ2FPNA0b8Y29nYME0oj+AgYNloQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd49682-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:17:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533sNRI016884;
	Wed, 3 Jun 2026 04:17:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwye6ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 04:17:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6534HbIc24642104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 04:17:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5B35803F;
	Wed,  3 Jun 2026 04:17:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B569D58054;
	Wed,  3 Jun 2026 04:17:30 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.22.158])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  3 Jun 2026 04:17:30 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 03 Jun 2026 09:47:29 +0530
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
Subject: Re: [PATCH v3 4/5] KVM: PPC: Book3S HV: Add support for compat CPU
 capabilities for KVM on PowerNV
In-Reply-To: <20260522152744.55251-5-amachhiw@linux.ibm.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-5-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 09:47:29 +0530
Message-ID: <87jysgz292.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzNSBTYWx0ZWRfX7SnlCCsdLysf
 FlrsYAb6KV1zqoL7srBtnWz8E5bAYjJZmED0IR1kUoqtSc3Vn8cPKukHV0tGXyPLs/waiUUlXPl
 3+fu8VUK0F39t11x1iK3LXwTICrxc/5KmZoHJemOoGZVVYCWoHy6SDA3OQ4cLlcdeuT1gsExqA5
 byIWDxEbjOcGNqX0RpD5QdshUL77Eomh+L0OlKlFiUUh9Hr+VlvPVnfNlill/MrxPZSN/wFywEJ
 OQ3PP/wBPE6WqG+qFPwpGM+TyA+HWNH4WxzWLJCNSgh1uipSHneQNnpZTrAJdqFWDNGDRZBmkCQ
 rcDLoETaJ8eVCFHE5InoyJHHbT/5kiaV7wqDC8ZnqeGqQh/PBEj+S0C6bPZPkk2ODxpuqnPFV5l
 6Y2WuNXyKAt1IV4vXU1qh5eMRDXAP+CtNKDhSBwx5K9+knfIHzhGz+67qjKKsW6Q9VCWLaiYimz
 YSmaUD/9CCoKCWJ1eIg==
X-Proofpoint-GUID: tI3qAk0fTHMqAvUgWZTqABnCBHl9GrBQ
X-Proofpoint-ORIG-GUID: wSnv7YfzqleDVtSTx-grc6_CHyqyAg5v
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1faae4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=o01m_0irJwqdz-O0wKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030035

Hi Amit,

Thanks for the patch. My review comments inline:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Currently, when booting a compatibility-mode KVM guest (L1) on a PowerNV
> hypervisor (L0), the guest runs with the expected processor
> compatibility level. However, when booting a nested KVM guest (L2)
> inside the L1, QEMU derives the CPU model from the raw host PVR and
> attempts to run the nested guest at that level, instead of honoring the
> compatibility mode of the L1.
>
> Extend host CPU compatibility capability reporting to support nested
> virtualization on PowerNV systems (PAPR nested API v1).
>
> For nested API v2 (PowerVM), compatibility capabilities are obtained
> from the hypervisor via the H_GUEST_GET_CAPABILITIES hcall. This
> information is not available on PowerNV systems.
>
> For nested API v1, derive the compatibility capabilities from the L1
> guest by reading the "cpu-version" property from the device tree, which
> reflects the effective (logical) processor compatibility level. Map this
> value to the corresponding compatibility capability bitmap.
>
> Introduce a helper to translate CPU version values into compatibility
> capability bits and integrate it into kvmppc_get_compat_cpu_caps().
>
> This allows userspace to query host CPU compatibility modes on both
> PowerVM and PowerNV platforms via the KVM_PPC_GET_COMPAT_CAPS ioctl.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 37 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 38de7040e2b7..18774c49af85 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6522,15 +6522,50 @@ static bool kvmppc_hash_v3_possible(void)
>  	return true;
>  }
>  
> +static int kvmppc_map_compat_capabilities(const __be32 cpu_version,
> +				      unsigned long *capabilities)
> +{
> +	switch (cpu_version) {
> +	case PVR_ARCH_31_P11:
> +		*capabilities |= H_GUEST_CAP_POWER11;
> +		break;
> +	case PVR_ARCH_31:
> +		*capabilities |= H_GUEST_CAP_POWER10;
> +		break;
> +	case PVR_ARCH_300:
> +		*capabilities |= H_GUEST_CAP_POWER9;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>  
>  static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
>  {
> +	struct device_node *np;
>  	unsigned long capabilities = 0;
> +	const __be32 *prop = NULL;
>  	long rc = -EINVAL;
> +	u32 cpu_version;
>  
>  	if (kvmhv_on_pseries()) {
> -		if (kvmhv_is_nestedv2())
> +		if (kvmhv_is_nestedv2()) {
>  			rc = plpar_guest_get_capabilities(0,
>  	&capabilities);
Need to mask capabilities as mentioned in the review comments for
previous patch. I would suggest creating a helper that performs the
hcall and applies the mask which can then be used at
plpar_guest_get_capabilities() call sites.

> +		} else {
> +			for_each_node_by_type(np, "cpu") {
> +				prop = of_get_property(np, "cpu-version", NULL);
> +				if (prop) {
> +					cpu_version = be32_to_cpup(prop);
> +					break;
> +				}
> +			}
> +			if (!prop)
> +				return -EINVAL;
> +			rc = kvmppc_map_compat_capabilities(cpu_version,
> +								&capabilities);
> +		}
>  		host_caps->compat_capabilities = capabilities;
>  	}
>  
> -- 
> 2.50.1 (Apple Git-155)
>

-- 
Cheers
~ Vaibhav
