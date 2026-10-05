Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B39260580
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791223237; cv=none; b=bUDvzUCK+9EU0j/r35hKZsSwgAF/UyS1PJe1RbqhsmWlRc3NCxArYV3O6n5aWp1WsuC2V1gcFUmVQ3ADEODxWln2U73R7AOtlnbdDSMEt+i+tP3yhG+SbX30fJaLkC+yBiRfk/oscF6vwZ3HECLCXmT+hZApq5G08K8l73jnM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791223237; c=relaxed/simple;
	bh=b+VfyYvdUfDGldDuxYFdTCTf5PDT7rBqPU4536xDKeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udqOnH0Z0j+nFxX1d1JLjpmw//K9sgPAJWw003UeW5J4bl90vKyRtHryZoIZQ8DLZDtsqMUTX7Xfjnxv6c603QaPUOvv/Ata5A9+/Tcrb81NvzEB+TCWKL4y6BS/iLqpABzleqSYX3JeDFzBqsfkf2wS3E0cvcRb0uQhXo3CVFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etV4+LbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etV4+LbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BC61F000FF;
	Mon,  5 Oct 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791223231;
	bh=6cMJRRMXpz0oTH8YiCP2ifCAPC80pjMisGy5Xsn14KM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etV4+LbDRAHilIO0+GggohuCXDXBaX9/uWzT+2iG6heV61pFsCqCPBsS+HbtD4muz
	 U245zyL2hcbtKKP6nw82SzAUWJcla4rgJ9FecGhKr4Rzt/cywi4KIoh+QvyrA70IrH
	 UBSPcMQd4+0U9wxM7eAJOJbKcdw6ltjjNNWTGrQG5n5EPSkTfpInH61h4/Zt5exCDc
	 x3tdSc1W93gYKbkE0K++mexQsMRFOUMCCgEGKcObZMhactfq3PFUeGXGCv0WJHOMG/
	 iZQYh4hyhKX9ZoiR2LC4lREGhOqBeav1ub788ED5QvUvXOllaW+MQ0ysAfFAZJzoEp
	 0NW9OaikxWwaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xu Yilun" <yilun.xu@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
 <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 18:00:31 +0000
Message-Id: <20261005180031.98BC61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/tdx: missing cache flush for extension memory before TDH_EXT_M=
EM_ADD
--

commit 218ae840fc4855126ea1a0f203de6a4e414fa8d7
Author: Xu Yilun <yilun.xu@linux.intel.com>

x86/virt/tdx: Make TDX module initialize the extensions

TDX module extensions need memory for their execution environment
to serve SEAMCALL leafs. Several add-on features depend on the
extensions to execute their SEAMCALL leafs.

After providing all required memory to the TDX module, initialize TDX
module extensions via TDH.EXT.INIT, then those add-on features can use
their SEAMCALL leafs normally.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index c445359335516..d8df3b2b1d17d 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1348,12 +1348,35 @@ static __init int tdx_ext_mem_setup(void)
[ ... ]
>  static __init int init_tdx_module_extensions(void)
>  {
> +	int ret;
> +
>  	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
>  		return 0;
> =20
> -	return tdx_ext_mem_setup();
> +	ret =3D tdx_ext_mem_setup();

[Severity: High]
Does tdx_ext_mem_setup() need to explicitly flush the extension memory cache
lines?

During TDX module initialization, a global cache flush (wbinvd_on_all_cpus(=
))
is performed via config_global_keyid(). After this global flush,
init_tdx_module_extensions() is called, allocating memory via
alloc_contig_pages() in tdx_ext_mem_setup().

Because this memory is allocated after the wbinvd, it may contain dirty cac=
he
lines. The pages are then passed to tdx_ext_mem_add() without an explicit
cache flush (such as tdx_clflush_page()):

arch/x86/virt/vmx/tdx/tdx.c:tdx_ext_mem_setup() {
    ...
		for (i =3D 0; i < chunk_pages; i++)
			hpa_list->phys[i] =3D page_to_phys(chunk + i);

		ret =3D tdx_ext_mem_add(hpa_list, chunk_pages);
    ...
}

Could missing cache flushes when transferring memory from the host (KeyID 0)
to the TDX module (which uses the global private KeyID) cause MKTME KeyID
aliasing MCEs? If dirty cache lines associated with KeyID 0 remain in the C=
PU
caches and are later evicted, they could corrupt the TDX module's private
memory.

> +	if (ret)
> +		return ret;
> +
> +	return tdx_ext_init();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-tdx-module=
-ext-v3-0-db52cb05b918@linux.intel.com?part=3D4
