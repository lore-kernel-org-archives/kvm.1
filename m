Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098653;
	b=Pco7oUrW6BE0UuaHISiRUergs6w64FHRluKFMqSo0Hqpx1y/0U3ER//0EMXsdL/u7+nA
	 jSzMsNldD94TTzwbtS42JrrHbBfwKIYllzx3I0GqooD3nVbh+WZGlx+vlZBVBJw/yLGtH
	 52nfRIn01oBBK4GSJVI6lE0Zqcf5qI93tsGROzTK9E+cpJwHd6rU9tlUQmEXAqY1eCy78
	 p6kNeHFl94VBqMGTxJZEnrizLxN4PZsKKUuPH8A9vF2Rl6At0NwtthXvVPqri2OM6KcnD
	 XixuU+IfP8Vhaj+Oi+inkr7syloVne3RrPIHt+3ISViTCByg74Ma6ZHWGx9Yvqxfu6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098653;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UGBKPRzEO0tszR5z3zc5sWYnix5oTgdEyRhav4QwANA=;
	b=rd8ZklTBIw3B3vg4AYE1NI/JLzk+ZnZXkVSNMtjdqzM38XWU5m8mu0v1414dagRJKHa9
	 sp6bru/rvk666nihRa7m3yAUUPYLsZbmq4zULwVHPBzIVRWFA8qQnPxGYd7CpnRcMmVMJ
	 B2fd5l/HWK2Hi/6mG15xVwhiMrj3+LoYTfmd27lWczhCQjIZWLNxLrpspa/uw/rM2kd/p
	 g8obqonsoREMbpLcJCvA4oizvNRS3xdNO8LZ8BSGWQi5Zw7R9S2+2225AhE1W0cmiXO2G
	 SzfAFdnt/4mWGSO0zp65Wf4PI7+ngB7zNmf9PCvBxBe3QqXiGGpdMu3AF6yDStFDGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miQzFWbC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB24606A334
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=miQzFWbC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417FD1F0089F;
	Sun,  8 Nov 2026 00:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098653;
	bh=UGBKPRzEO0tszR5z3zc5sWYnix5oTgdEyRhav4QwANA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=miQzFWbCpnHfvfdQ32bAxe+xMAtmIT0OgKdkBXv2CN6IIPy/P8g86o8G4bASKpFJd
	 YOAiYHfw66IWmD3ezco3eUWkC9CQF91siIROZjHr5m+KepJ6Dte136RqqG2A3/XIU4
	 U7WGR19JdHQ011rZv4veA5cEP1Ao+KeBVUhFWUvirUVWKp/ywg1FBhbCCB93W/xpQl
	 9l1WWEr5yDtG4nz0xnrhTOV1P2Qm8vHqy7oY0hBitJIPDLg9whGhxwlr5DntXdSV7s
	 eWxrlrVkNsLM1VnRqalToZ+tzP9Bde92IJP1922rzIefvXlNoBvv6wSuPIFyu+kvGf
	 Vy5M7uVfee2EA==
Message-ID: <sashiko-outbox-203460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 49/88] samples/kvm: Implement lookup_pfn_range
 provider operation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alexey Kardashevskiy" <aik@amd.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jianxiong
 Gao" <jxgao@google.com>, "John Starks" <John.Starks@microsoft.com>, "Michael
 Roth" <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Sean Christopherson" <seanjc@google.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Vishal
 Annapurve" <vannapurve@google.com>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Fuad
 Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261106-gmem-alternative-providers-v3-49-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-49-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:44:11 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] samples/kvm: unexpected -EINVAL from
  mp_gmem_lookup_pfn_range() past npages
--

commit 547b053613c36c4e6a545e75a670dd8b4151e0c0
Author: Ackerley Tng <ackerleytng@google.com>

samples/kvm: Implement lookup_pfn_range provider operation

This commit implements the .lookup_pfn_range callback in the sample
memory provider so that it can act as a PFN-mode provider for
guest_memfd.

> diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
> index 926f3cf68ed49..7fb7365b65940 100644
> --- a/samples/kvm/memory_provider.c
> +++ b/samples/kvm/memory_provider.c
> @@ -249,10 +249,34 @@ static int mp_gmem_get_pfn(void *provider, pgoff_t =
index, unsigned long *pfn,
>  	return 0;
>  }
> =20
> +static int mp_gmem_lookup_pfn_range(void *provider, pgoff_t index,
> +				     unsigned long *pfn, size_t *nr_pages)
> +{
> +	struct file *resource_file =3D provider;
> +	struct mp_info *info =3D resource_file->private_data;
> +
> +	if (index >=3D info->npages)
> +		return -EINVAL;

[Severity: Medium]
Does returning -EINVAL when index >=3D info->npages trigger a WARN_ONCE()
in kvm_gmem_pfn_reclaim() and kvm_gmem_make_shared()?

Neither kvm_gmem_attach_resource() nor mp_gmem_attach() rejects attaching
a guest_memfd whose inode size exceeds info->npages << PAGE_SHIFT.  When
closing such a guest_memfd, kvm_gmem_destroy_inode() ->
kvm_gmem_pfn_reclaim() walks up to i_size_read(inode) >> PAGE_SHIFT:

virt/kvm/guest_memfd.c:kvm_gmem_pfn_reclaim() {
	...
		r =3D gmem_provider_lookup_pfn_range(gi, index, &pfn, &nr_pages);
		if (!r || r =3D=3D -ENOENT) {
			step =3D min_t(size_t, nr_pages, end - index);
			if (!r)
				kvm_arch_gmem_reclaim(pfn, step);
		} else {
			WARN_ONCE(1, "unexpected lookup_pfn_range error %d at index 0x%lx\n",
				  r, index);
		}
	...
}

Once index reaches info->npages, returning -EINVAL hits the WARN_ONCE()
and falls back to step =3D 1, iterating one page at a time across the
remaining unbacked range in an unkillable loop.  Should this return
-ENOENT with *nr_pages set to cover the unbacked tail (or should
mp_gmem_attach() reject oversized guest_memfd inodes)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D49
