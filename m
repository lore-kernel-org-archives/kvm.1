Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E2222565
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830727; cv=none; b=OQHzA0R2bYyT/cKmLTaa5X0A5d7rxmOFLpxJkTUfntDSE1e9f+5LtUCTVedsdptHiJPYRDtJWz24qgfvpPg6BGBbO4J8MFGPSas8sIT+Iim8Alkrl2rsakAkjZwfi2PAAe+XqFTs4bkslWirmKA0c4LE0g3fTJpKTKgBrV766eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830727; c=relaxed/simple;
	bh=V+URe17bQjz83RhHuMmS6dIXa4yJddYrWdUMqD+u+yk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqde3wsaGZxmXB7n2/Jb93m8LMbwX1lrIwGTYhGWFwevxnDzbXFo39LF3WJM6/7f+JUUI+46ZRI8AfP7cTgpwbHttnCbThwwMLxNUUIDtDeaqqIlU4ql8HOCV5EC4sW1B/4xMfnChfzfyPew2J8QMWUFSWfLZrxk8G1l/REdlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMoq3AHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMoq3AHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04431F000E9;
	Fri, 19 Jun 2026 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830724;
	bh=gtfFV+ftps62tL5JiIYvzWWmntsn1ltfvYXQndS3PvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMoq3AHtFnA6CobXkuUkkGlfQe6FZnQFahK4Li6BTw9hjUxyDtrZlAm4lu2MbbXM8
	 bTv2ILRzNdZzpiii35mizCCsIwsJAkLcnxZaB6NVDvDVEOhEy3cyV5zxo37gLWXUD6
	 Gg46zTt6JYiEtEExGtvVePmENC1MeSbTzkAHKhyTVgSeSF68X3DVSNFro3NO95+kfb
	 DGi8okZRrJDwIpZN0Es6Y3ZZtcbHErIyifXal9ql4nrYqVNmXU6A2kdr9Ph9HSIqI0
	 DbtT7YjqsAWYtXJhTH/jMvfFHKxvGg/AKmgvqA9nRXjltAXjxLv9OnAn+J5kPnZ+FQ
	 ExkAdrmXnyMcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:58:43 +0000
Message-Id: <20260619005843.F04431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In-place memory conversion for TDX uses the same physical page for=
 source and destination, which violates the `TDH.MEM.PAGE.ADD` operand cons=
traints.
--

commit 9c726fd29e9655323e0c5ac003966956b5c8273c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION

This commit updates tdx_gmem_post_populate() to allow a NULL source
page by defaulting to the page associated with the destination PFN.
This allows for in-place memory conversion where data is already present
in the target PFN.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c59..56d10333c61a7 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm,=
 gfn_t gfn, kvm_pfn_t pfn,
>  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>  		return -EIO;
> =20
> -	if (!src_page)
> -		return -EOPNOTSUPP;
> +	if (!src_page) {
> +		if (!gmem_in_place_conversion)
> +			return -EOPNOTSUPP;
> +
> +		src_page =3D pfn_to_page(pfn);

[Severity: High]
Will this assignment cause the TDH.MEM.PAGE.ADD SEAMCALL to be executed with
identical physical addresses for both the destination and the source?

The Intel TDX module ABI and MKTME architectural constraints prohibit
overlapping source and destination pages. Reading with the host KeyID and
writing with the TD private KeyID to the identical physical address
simultaneously causes cache aliasing and potential machine check exceptions.

Because of this, the TDX module rejects identical addresses with
TDX_OPERAND_INVALID.

Since KVM verifies the SEAMCALL result with TDX_BUG_ON_2, does this
deterministic hardware rejection introduce a regression where KVM will bug
and crash the VM during initialization when in-place conversion is utilized?

> +	}
> =20
>  	kvm_tdx->page_add_src =3D src_page;
>  	ret =3D kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D23
