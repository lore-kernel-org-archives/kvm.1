Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842C259498
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379201; cv=none; b=RlAbaQM/zX5/9OWaTKk0zQL9N/ek2fsxruOCgntx6piTRG0h90JxRf9e7BL248+QhJLy2oic/VmPt9F3LomGML9TUPvjWzLGX3yS8RajD44daT6GdiUHxn3kKtGKoVsO9XpRFxxknQatQM/kKUCO3onE9DCEF4esRocO0UXvUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379201; c=relaxed/simple;
	bh=bt5F7iDOT0ZCKCdKcEWTEnt3YkCcX23aUuzYExYIg9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNI8GDo/GERMgk+IOaU63CjQDWAW4/t7sbVXw85egt4UMxxL9BVlmhvIlumQfBGAE2YSEsrDhM05jUFpgdbg/vXoFL57ba/JmpNWSTn/Ljni4lEuxLNW8SLV47affNConobASiUqfU3UGKXAuQc+MUUdXE9AeeKewFx1ZhhzlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtUNaGZ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtUNaGZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C771F000E9;
	Wed,  2 Sep 2026 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788379199;
	bh=a6aU8ya4hsLO9v0qgcWr7GRyTATA5ny/2tqwPiDgw8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtUNaGZ91lmrz0r8vhDo4mFBDtRBryqL2NmvnrpfHxJZoAc7gKNF0B3Mrct2WL5Pv
	 sfCK9FC0LAyqUJFCwQfE9DR8v6cQAdSdMs7C1jGPzwiXzR+zA7EevDtfVqhHXu/4x9
	 oGv8MfRiA0azduZBDGpD0fc9076ACChhdfWYxToLzRynFzdoFQP+KO/aGxHnNvdwUE
	 I/cqrgBK20I7xBMywjOvadvbfZkngZ8mpY9csb9gDygjuCKFVlVTRWiUOyRrnYaq75
	 NqvBDL2FnTJ2HOVSCRmgQd/8b1ihX7EpycqHqkfGXUqWyr6t4JxJSXlbPk9nshsshs
	 50HRqsMV2f1fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] selftests: KVM: guest_memfd: let the gmem_test()
 harness bind a node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902194657.79075-5-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
 <20260902194657.79075-5-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:59:59 +0000
Message-Id: <20260902195959.B5C771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure due to missing tools UAPI header sync for GUEST_MEMFD=
_FLAG_BIND_NODE.
--

commit 93b29e02dbc130205238f8312d9571e48df529a8
Author: Gregory Price <gourry@gourry.net>
Subject: selftests: KVM: guest_memfd: let the gmem_test() harness bind a no=
de

This commit extends create_guest_memfd() to accept a node argument in order
to test the GUEST_MEMFD_FLAG_BIND_NODE functionality. It ignores the node
argument if the BIND_NODE flag is not provided.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 2233d871a38f4..1818e0fea5690 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -25,6 +25,31 @@
> =20
>  static size_t page_size;
> =20
> +static int __create_guest_memfd_node(struct kvm_vm *vm, u64 size, u64 fl=
ags,
> +				     u32 node, u32 pad)
> +{
> +	struct kvm_create_guest_memfd guest_memfd =3D {
> +		.size =3D size,
> +		.flags =3D flags,
> +		.node =3D node,
> +		.pad =3D pad,
> +	};

[Severity: Low]
Does this cause a build failure when compiling the KVM selftests?

This patch updates the tests to use the new .node and .pad fields in
struct kvm_create_guest_memfd here, as well as the
GUEST_MEMFD_FLAG_BIND_NODE macro further down.

However, the tools/include/uapi/linux/kvm.h header doesn't seem to be
synchronized in this patch. Because the selftests Makefile prioritizes
the tools/include path over system headers, won't the compiler fail with
undeclared identifier errors when it processes these new fields and macros?

Should tools/include/uapi/linux/kvm.h be updated either in this patch or
in a prerequisite commit to prevent breaking the local build?

> +
> +	return __vm_ioctl(vm, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
> +}
> +
> +static int create_guest_memfd(struct kvm_vm *vm, u64 size, u64 flags, u3=
2 node)
> +{
> +	int fd;
> +
> +	if (!(flags & GUEST_MEMFD_FLAG_BIND_NODE))
> +		return vm_create_guest_memfd(vm, size, flags);
> +
> +	fd =3D __create_guest_memfd_node(vm, size, flags, node, 0);
> +	TEST_ASSERT(fd >=3D 0, KVM_IOCTL_ERROR(KVM_CREATE_GUEST_MEMFD, fd));
> +	return fd;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902194657.7907=
5-1-gourry@gourry.net?part=3D4
