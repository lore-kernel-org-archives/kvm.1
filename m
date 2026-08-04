Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972273101B0
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873794; cv=none; b=hiTYt+PtFc0QWOlfbNauwWrrjDiI6Nr36JE7Lu+fcAlvdJ+nY5gVq0p3OPj8VkwOJNhNlPCvMG8HlS58PBPEd82ahH45GqJS3yXri3i5f/MekCIjT1W+i4PWMguB17mXU4Qe4qFmnxkNE5GAqtLKJLMBwin97y7omXdo2CxNFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873794; c=relaxed/simple;
	bh=UdD9fFmhQXL0ARFmuX6dv7VMhE50mDsrNG0Ru1N6iJA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HAnvFz2Fk0Gb9Xrqss+D9wK8vBpHvas+b8Vu75EOHl/UIM5HESIVZyJ4m4gxMFXbbVZwnjEYZsz8tidXI5Uko0NvHHT7P2wIL1r8bleeBcITL+e5tCzoIwgBJM+NVei9O19qrhlBV9VM5LOCpg9i7BYY1IArGOJ/jBYQNeFsPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 2C1EB583781;
	Tue, 04 Aug 2026 21:55:28 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 638yrKVN5oFT; Tue,  4 Aug 2026 21:55:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 11FA9583224; Tue, 04 Aug 2026 21:55:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 10021583223;
	Tue, 04 Aug 2026 21:55:26 +0200 (CEST)
Date: Tue, 4 Aug 2026 21:55:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
    Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
    Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
    Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
    qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
In-Reply-To: <20260804182914.83091-4-amachhiw@linux.ibm.com>
Message-ID: <bce28234-2d74-8a2d-d21f-ff1844147441@eik.bme.hu>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com> <20260804182914.83091-4-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Aug 2026, Amit Machhiwal wrote:
> On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> a Power11 processor operating in Power10 compatibility mode). When
> running nested KVM guests, QEMU currently derives the host CPU type
> using mfpvr(), which reflects the physical processor version. This can
> result in a mismatch between the CPU model used by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures
> such as "KVM-NESTEDv2: couldn't set guest wide elements".
>
> Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> use the compatibility PVR instead of the raw hardware PVR when selecting
> the CPU model. This ensures that QEMU selects a CPU model consistent
> with the host compatibility mode, allowing nested guests to boot
> correctly.
>
> The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
> ppc32 targets where the POWER9/10/11 PVR constants are not defined.
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> No changes in this version.
>
> target/ppc/kvm.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d4c5601a00c4..aa8269186a1a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2682,6 +2682,18 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>     uint32_t host_pvr = mfpvr();
>     PowerPCCPUClass *pvr_pcc;
>
> +#if defined(TARGET_PPC64)
> +#ifndef CONFIG_KVM
> +#error "CONFIG_KVM is not enabled"
> +#endif

In meson.build:

ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))

so I think this check and #error does not make sense.

Regards,
BALATON Zoltan

> +    uint32_t compat_host_pvr;
> +
> +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> +    if (compat_host_pvr) {
> +        host_pvr = compat_host_pvr;
> +    }
> +#endif /* TARGET_PPC64 */
> +
>     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
>     if (pvr_pcc == NULL) {
>         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
>
