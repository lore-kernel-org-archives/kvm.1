Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0B356749;
	Fri, 19 Jun 2026 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849679; cv=none; b=Egmi1c5DOT4L5dPbuqeYG9045JMg81+wa0BimRYIadmvnTw86os6fd39pAV4B4COsD6Agq5za7H9YTOXHaNOjJOjSA7MYuH7IQLZWnmVViK0iZ3HvkMOfTeTlMi1WhkOZAo0oA8ch3GbIUHoIg8pYdcKuv9AI24vONoXaAsz2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849679; c=relaxed/simple;
	bh=1hxGs26W8E6qHt1yvO1VP0TqMoS2/VzogNK0DWosUiM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYIMzir7EFYq+oTuQFDaSJxlBGLAN4OkPfrAnMqeuUsqo3NDQ9GtBSVfLxZgrAA6bV6AWFz+8/6EvP9WLytuHWGMrY2BZm4BYQLJo9AS+e9a+a62cViv3gvjPRTQIIWx5e6MlTzTU6GdLOIvLWWP0N6ztY69gG6nnOsnEsPrMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qiTg+4XY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qiTg+4XY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3IHNj1055914;
	Fri, 19 Jun 2026 06:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jrWfkYLZGLXyJmzQQERjCP1qFgpBre
	vURQaWqVdMkjY=; b=qiTg+4XYZtRNdYyqupyuzg31jQfD04g3PtPa06lcMJrOGK
	EWd9N5HHU91Alfc7ixt5VWSEV2b0KpBKC3Xcb387tiqfOqJ5vou9n4wazmHY8wiZ
	PdeXeIp1jt+Yr+9dUA8N+hx1C0Mc3UJR5ObXfHmEYcrFx5M8kJwODmEYfDKmWcgp
	KoFKFqRaAE3w5kRyrFJz8SYdeg5dOKCBdguarAwmAIs44tHzoelInninI6w8Gp/j
	UO7Yz2XeWmDziCzeh/gd/npgXmkdShpeOwLsWDhmljQ/4f8gvpVjceHQFlEtM5Lq
	4sxnlTUbU/hxgaEG6Io+r6ctkJUnS58MIj7O+alw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxktcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:14:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J64pa9017858;
	Fri, 19 Jun 2026 06:14:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fesj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 06:14:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J6EDTf55312722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 06:14:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 472635804B;
	Fri, 19 Jun 2026 06:14:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0054D58055;
	Fri, 19 Jun 2026 06:14:07 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.17.1])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Fri, 19 Jun 2026 06:14:06 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 19 Jun 2026 11:44:05 +0530
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
Subject: Re: [PATCH v4 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
In-Reply-To: <20260616123314.82721-5-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
 <20260616123314.82721-5-amachhiw@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:44:05 +0530
Message-ID: <8733yjcb0y.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a34de37 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=EG2VKv7dvh7jra7yapQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX9J7EqdFprCWA
 PH0CZAwVMNdOU4HemDkK6G7NAC97hIkpapFAfAOP1Usy9DW2zO5yjHiyxxJdV6Sfn0QJGcaV4TH
 cofMYSALmk1hni8HExUG60GpjrlMxIexANyY/O6SHdfHHT/QQ7Tb+UJRyCII/fujapYa2Vm05lA
 RJ2x+JPuIqavp0RUD34rWw+7SsQtPvnkwGkbGGa+KFJinY4iHQHDCpC0ecWF/S8YhGM5X3M9R9g
 jutDKBe131Al4BvrMKtyXKkd2jtoITsOZIzlOoCqxWRWX/9WVKWQFGZFJ6O3rrQBX+55sSoFf6v
 vMo1EorE4G2/GXuWceAviZygFMmZjmF3jKBB7NT3oOcyl+que1W/pcOAkqrpvJpfbjKqxnN18Xb
 z/USC9ILYC8W3ZZko+EUchoOjDeVSLsl5hKjyc31QheSxW+wqqpJqr05Q5NYXQcJwkEPoGkF5S7
 jiYIpY6anvwdVQXpd9g==
X-Proofpoint-GUID: XtZQzzW6xfAPo1iWZWmYtAz5iWd9VC3R
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA1MSBTYWx0ZWRfX3OrnysIXGGRl
 TYFrdzaivGTVEq0E4g38+YtSuqTZE34GkgoBIeyX/0ewIygHWFVs1CBoLAy2UdrOF+4yZ9ohdy0
 iiWwIuW1C+AbItRobB73xtUpJAuWgLA=
X-Proofpoint-ORIG-GUID: 6bFKtkTU5rpuzemZqjuCTGlT3mc3PgUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190051

Hi Amit,

Thanks for the patch and incorporating V3 review comments. Further
review comments inline below:

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation.
>
> The ioctl exposes host processor compatibility modes supported for
> nested KVM guests on PowerPC systems. The documentation includes
> comprehensive error code descriptions, structure field definitions
> including the size field for forward compatibility, and KVM-specific
> capability bit constants.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 47 ++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..ba6feba74d7d 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6553,6 +6553,53 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
>  
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)
> +:Returns: 0 on success, negative value on failure
> +
> +Errors include:
> +
> +  ======== ============================================================
> +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> +           written to userspace
> +  EINVAL   if the ``size`` field is smaller than the current structure
> +           size, or if the backend implementation fails to retrieve or
> +           map CPU compatibility capabilities
> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-pseries platforms or when the
> +           required KVM operations are not available)
> +  ======== ============================================================
> +
> +IBM POWER system server-based processors provide a compatibility mode feature
> +where an Nth generation processor can operate in modes consistent with earlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibility modes
> +supported by the current host processor for booting the nested KVM guests on
> +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> +

Please add a detail on how returned 'size' field can be less than what
the userspace has sent and how it should be handled.

> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	size;			/* Size of this structure */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +  };
> +
> +The ``compat_capabilities`` bit field describes the processor compatibility
> +modes supported by the host. For example, the following bits indicate support
> +for specific processor modes.
> +
> +::
> +
> +  KVM_PPC_COMPAT_CAP_POWER9  (bit 1): KVM guests can run in Power9 processor mode
> +  KVM_PPC_COMPAT_CAP_POWER10 (bit 2): KVM guests can run in Power10 processor mode
> +  KVM_PPC_COMPAT_CAP_POWER11 (bit 3): KVM guests can run in Power11 processor mode
> +
>  .. _kvm_run:
>  
>  5. The kvm_run structure
> -- 
> 2.50.1 (Apple Git-155)
>

-- 
Cheers
~ Vaibhav
