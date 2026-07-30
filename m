Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C009489873
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390129; cv=none; b=TdIbMCmdn9lP8lJIDA6xxHFf+Y7sG56LtpJWYM5zxBfYn6Caf6eQXgbV84pg2wGpxy3jnFIv/c3s1bOqGxBoDOribKhLVBWww797zLmlGbiNyzkqGDSbBxkA1gWBVVAnV6TbNP+BBEoGY0E/6Asg4qPfqDqVr4EAdn7TDVeyM20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390129; c=relaxed/simple;
	bh=gtNqmtlz11YTaHAOeuf6yPhikX581JactO7gbwX6u/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnvzGEeFfBPVM4cbeoMnbowIlNCOAdBCJQ4HVGP/3oIiJeieq8IMMzqTJ3YYDuwoXGV6SFv/iQyeJrMsnSPjq/1jWIGAHSRfZJN5lO18mvAAIdO425e23+kJzXxOFLCialMO2lZ+jzqOeFQrCXCLit1K0LkB9q1HooW4/jMKU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kD623uBp; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kD623uBp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1785390128; x=1816926128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gtNqmtlz11YTaHAOeuf6yPhikX581JactO7gbwX6u/Q=;
  b=kD623uBph1AfQ9jvjPjsoTM/IROZmcLk5AtZkRhU6EGB3huqxEXvMfGU
   nD8ttdlp++nAjRcntzG9SeGNb9IZJ1sE7iur5U2fYWK0ahMitQNPH1WWv
   Uf99ZjtJVNQqNcWyFuKo3Vo1+ZfYZbnFXMN+DLiIIlmQypbVKTyaJ7dL0
   t/4yzrsY+Jo1pG72QKtuY3zrzEh/Sr97eezwDSNLNv93dtNhH7KGJ+IUO
   d0Gbhcu5yQq6yn7eVGj1jUx3G422lwMql2/6Ctmol2nSYIV9+nHPGIG3s
   sILu1jSfUtv6GxQtrhpSVx0RdpCJFzjSYDcxmu/FnnkiXW1nZ+StdARRa
   A==;
X-CSE-ConnectionGUID: F02MBzFtTcC80rgn7DIqlQ==
X-CSE-MsgGUID: Yw5KY3sfSCGbFpzPT+wKyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="249086102"
X-IronPort-AV: E=Sophos;i="6.25,193,1779116400"; 
   d="scan'208";a="249086102"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:42:01 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 4D9DA8204C0
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:42:00 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 03E8A84F49E
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:42:00 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.194.125])
	by az2nlsmom3.fujitsu.com (Postfix) with SMTP id 7009E100151C;
	Thu, 30 Jul 2026 05:41:54 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:41:46 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Subject: Re: [RFC v2 01/24] linux-headers: Add RME related definitions
Message-ID: <amrhioS_O_0ztjb_@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <20260728192630.240375-2-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728192630.240375-2-mathieu.poirier@linaro.org>

On 07/28 13:26, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> This is a temporary patch intended for testing purposes only. It provides
> definitions related to supporting Realms by the QEMU-VMM.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  linux-headers/asm-arm64/kvm.h |  9 +++++++++
>  linux-headers/linux/kvm.h     | 10 +++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
> index 6aefe7973814..4c08631ec7d2 100644
> --- a/linux-headers/asm-arm64/kvm.h
> +++ b/linux-headers/asm-arm64/kvm.h
> @@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
>  	__u64 reserved;
>  };
>  
> +#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
> +struct kvm_arm_rmi_populate {
> +	__u64 base;
> +	__u64 size;
> +	__u64 source_uaddr;
> +	__u32 flags;
> +	__u32 reserved;
> +};
> +
>  #define KVM_ARM_TAGS_TO_GUEST		0
>  #define KVM_ARM_TAGS_FROM_GUEST		1
>  
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index dd52e2a65bfd..cdd5ad11f85a 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -689,14 +689,19 @@ struct kvm_enable_cap {
>   * address size for the VM. Bits[7-0] are reserved for the guest
>   * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>   * value 0 implies the default IPA size, 40bits.
> + *
> + * Bits[30-31] are reserved for the VM type
>   */
>  #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
>  #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
>  	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>  
> +#define KVM_VM_TYPE_ARM_NORMAL		0
> +#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
>  #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
>  #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
> -					 KVM_VM_TYPE_ARM_PROTECTED)
> +					 KVM_VM_TYPE_ARM_PROTECTED | \
> +					 KVM_VM_TYPE_ARM_REALM)
>  
>  /*
>   * ioctls for /dev/kvm fds:
> @@ -719,6 +724,8 @@ struct kvm_enable_cap {
>  #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
>  #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
>  
> +#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
> +
>  /*
>   * Extension capability list.
>   */
> @@ -986,6 +993,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_ARM_RMI 250

Not a big deal, but a note for anyone testing this series:

Use Linaro's Linux kernel tree, as mentioned in the cover letter:
https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads

Alternetively, if you're using Arm's tree or other trees with Steven
Price's v14 series as I am:

You'll need to adjust the definition of KVM_CAP_ARM_RMI, since it uses a
differenct capability number.

>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> -- 
> 2.43.0
> 
