Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074785;
	b=Qb8T0ZSow42EfMAyz+26OofnWmNUdhB8LFSnq7uaqXgZiJ+em/oRk8MsWd8MQ5xKzMjL
	 msjCmZnZblVuhTFYMO17dljjzYYJwFeaIKjpeevorZL2+GNnzKglFe9G6dMuYFK91HRiy
	 sHKa6tGWVLavhzqC6Szpoc5ahsEwByyjFBqVWJXDcpNhIa6ZFOfbP/nNdMsgNpo0nsCXF
	 TSDkDm9VlGEYGrC89Y+IryT5Yijr6Cvn6+zKqYUvwG8pyfCxznvuvk00kVKxkfBsvVLjQ
	 w9I5YPIT6TkgdHYSlMnIKkN9z1pUR30a9iEVVq74GpyNIbMiGiFWb1O4iwoQ8eoMUTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A9UGbt2TXPpHTdfR0/hhjl3jx1xcHhm0yENjZJwLmpg=;
	b=hFatd9cG9MIxs4NCwGLPnIQ7wcF2q6xHaMU/OWu1G1qD47MGOQBHINrwHni9O0izdfZS
	 h3/QFXn5C3p/cn8fUeCFrmmIwt+4xpJRCj3gbPgwCzZxEjBC/MH5JmQLZYXeMnvtQSbew
	 ritxUG5GnlDIpEySPiQBXTtlxZcm7HjZ83NIBWJcsemwDNph5fxW+vWeFWi5KpBQmqIV2
	 87DuVOMh/P4k8tlua+eusdIXiksP3gJ26rUCBdFFtslprs84+nctH1z17TuT/ctwUBFo4
	 kikDHBPW6KQnfqz4WznzvbpofahePvJ+MIVzvBpYDzGxCMsJBGW/5XfExHaOFm8m7DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7CO6Csp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45962606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l7CO6Csp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1221F000C4;
	Thu, 19 Nov 2026 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795074784;
	bh=A9UGbt2TXPpHTdfR0/hhjl3jx1xcHhm0yENjZJwLmpg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=l7CO6Csp8a/wiintqiGTHXzBOijHBo3Zqh2h+wj5+bO0itF6rAcbjGiBhD9+yp8In
	 3wU4GMpUj7zwLUNZjvS/PlMQaDbszsrr33nHatCfW54vT0oTuhVxC5rKsVCFeM5uwl
	 4S7AMXoc0ca6WCq4XuSFfcA5brtQ7Iq/zHVbL9jKXT32Oce+Ev+XnatG517IXoOmNu
	 PsF36xPhvkcXfK1yE29R1MUizWkCoEX1HorDSWXU4lFQqaZ1gg62iJGdiytaHM7W/y
	 luwbdx2fqsGTIZtdvuLArPTsFTxbWrWP6hI/jKZCfBCyVzGnXjEGiTcKtsge0efRyp
	 4QP0g5EDxzV/Q==
Message-ID: <sashiko-outbox-222624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] x86/virt/seamldr: Support multiple sigstruct
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chao Gao" <chao.gao@intel.com>, kvm@vger.kernel.org
In-Reply-To: <20261119074925.3933804-3-chao.gao@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
 <20261119074925.3933804-3-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 07:53:04 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] x86/tdx: unaligned physical memory access in
  seamldr_install_module() [1]
--

commit 5316f95a1fa1ecb4d66f112e0d257161d81dbb1c
Author: Chao Gao <chao.gao@intel.com>

x86/virt/seamldr: Support multiple sigstruct pages

This commit expands sigstruct_pages_pa_list[] in struct seamldr_params to
four entries and sets the seamldr_params version to 1 when the sigstruct
spans more than one page.

> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seam=
ldr.c
> index 6b9657a28129b..7c09c84df1aa3 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -38,7 +38,7 @@
>   */
>  #define SEAMLDR_NR_MODULE_PA_ENTRIES	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SI=
ZE - 128) / sizeof(u64))
>  #define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAM=
LDR_PARAMS_NR_PAGES)
> -#define SEAMLDR_MAX_NR_SIG_PAGES	1
> +#define SEAMLDR_MAX_NR_SIG_PAGES	4
> =20
>  /*
>   * The seamldr_params "scenario" field specifies the operation mode:
> @@ -59,7 +59,7 @@ struct seamldr_params {
>  	u32	version;
>  	u32	scenario;
>  	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
> -	u8	reserved[104];
> +	u8	reserved[80];
>  	u64	module_nr_pages;
>  	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
>  } __packed;

[Severity: Critical]
This problem wasn't introduced by this patch, but can allocating struct
seamldr_params with kzalloc_obj() in seamldr_install_module() violate the
hardware page-alignment requirement when CONFIG_SLUB_DEBUG is enabled
[1]?

arch/x86/virt/vmx/tdx/seamldr.c:seamldr_install_module() {
	...
	params =3D kzalloc_obj(*params);
	if (!params)
		return -ENOMEM;
	...
}

When SLUB redzoning is active, the returned object is shifted within the
slab page rather than page-aligned.  Passing __pa(params) to P_SEAMLDR_INST=
ALL
in seamldr_install() (and similarly __pa(tdmr_pa_array) from kzalloc() to
TDH_SYS_CONFIG in config_tdx_module()) then hands an unaligned physical
address to the hardware, which truncates the address to the alignment
boundary and reads SLUB metadata and redzone bytes instead of the parameter=
s,
causing initialization failure or memory corruption.

[1] https://sashiko.dev/#/bug/linux-d025ea4c-abd9-44fc-9005-5b2dc7291000

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119074925.3933=
804-1-chao.gao@intel.com?part=3D2
