Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794098639;
	b=ODMWFkztwm2Rqxu79HCvAu63iWj8sVNy33hP5Jfe+fiTXw3vyETALbwzkOgw0OxDPJd+
	 nYByjJFKIgKL47MI7yp9PGV2fHaKZfSgf+tbHwdBQW5w8UTJAtNzHrdPTzXwk3TYxsYcS
	 cETIz1PJhtKDQyxmrue/j6B96HT+JCSqk4zpVRSgdG/zl6lMVwNRtc1cHHXxOcvZ0wIDx
	 gJQm4xKrlKZN8t+p9ob4cB4u49j/+cjpiyeMcagkwoR3Ec9BGZjBeeHWbEThfdjFVNp4s
	 kP1Z4oZGFlHRFPKYP1pludOcwOIAWF3wBH5PWc3/4VYjobYGCoQJqneVj1vXGxN/B1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794098639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qcxIV6/PGp7xF0EvDpj0CIJtAjCz1zzihqjKBLCzuh0=;
	b=CrYQM+G5o7Wn6d8qYjBU2nN8FR2GlAf0i21EorD2m83Yfs79NHP0Td0XGUe33ZOSie26
	 rhlYLNoOx8FdcksWgcKlBMlpLBI6+b+wuygmoxUL8WNpHJP+5OibJHd0Nacz2gLoinULY
	 jMhsHjexnCvK+k+f4W/YrE/g2kzW7wOR2sOyHgdzmD88D1PAtfkC5gL5gQWs7WNc09NfT
	 vP4DLKqosFIsngOumCBkUzZJDrMHp2cIyEWqv2W477kjO9Lgbb9rE57suojDEjNwkKWOS
	 qAxTH6sD4wixdV8RF1WxXeQRvIg/kK2PK4bA+GILW6N6kuSb+cgIdl5ogG1zvlnUIyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2ennRW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D4606D807
	for <kvm@vger.kernel.org>; Sun,  8 Nov 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2ennRW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045161F008A6;
	Sun,  8 Nov 2026 00:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794098639;
	bh=qcxIV6/PGp7xF0EvDpj0CIJtAjCz1zzihqjKBLCzuh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2ennRW710AwaoXCbRe+dVXLP9v2guMCAdBATJ2GQO3zw+0kGG7BeZ4AatOUUx3da
	 oryrJxWcs8PSsoT0xsNGbAFdgClIHtHGWboBseGNlbOyOZnKFDw2RZzRYaAI1efU4H
	 dfJAeFLjn4CRERFZ0M7kKl4V+b2dNpqx9NqTjVimgoaNJvh3ssVUtiqGk9TEH38+0/
	 1xd1kdUjWXtkP64x5SGGS2mSE3SHwes/3rhWRAZWTCgepihrvQ7SQbLo/W6b/1mShh
	 uLCCulnRLFSA8JSo8uGkFVSsgLoQj+c2T/qpjKbJw3V36cSR6c7x39tdKOQzoUV8Vr
	 yWAgnarnyvjkw==
Message-ID: <sashiko-outbox-203422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/88] KVM: selftests: Test rejection of hugepage
 tmpfs mounts
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
In-Reply-To: <20261106-gmem-alternative-providers-v3-11-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
 <20261106-gmem-alternative-providers-v3-11-8484dde66a7e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:43:57 +0000
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
- [Medium] KVM: selftests: missing THP check in
  test_resource_fd_tmpfs_huge()
--

commit c298eb47e39bc0e14d17d7c71365382bc9f5859c
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of hugepage tmpfs mounts

This commit adds a selftest verifying that guest_memfd creation fails with
-EINVAL when backed by a tmpfs resource pool mounted with huge=3Dalways.

> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testi=
ng/selftests/kvm/guest_memfd_test.c
> index 205f822e10c6c..541d8cdd0bbf7 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -547,6 +547,21 @@ static void test_resource_fd_tmpfs_swap(struct kvm_v=
m *vm)
>  	close(pool_fd);
>  }
> =20
> +static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
> +{
> +	int pool_fd, fd;
> +
> +	pool_fd =3D create_tmpfs_pool_fd("always", true, page_size);

[Severity: Medium]
Should test_resource_fd_tmpfs_huge() check thp_configured() before
configuring a tmpfs mount with huge=3Dalways?

In shmem_parse_one(), setting huge=3Dalways returns -EINVAL when
CONFIG_TRANSPARENT_HUGEPAGE is disabled or has_transparent_hugepage() is
false.  Because create_tmpfs_pool_fd() wraps FSCONFIG_SET_STRING for "huge"
in TEST_ASSERT(), running guest_memfd_test on a system without transparent
hugepages aborts the test suite during setup instead of skipping this
subtest.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-gmem-alter=
native-providers-v3-0-8484dde66a7e@google.com?part=3D11
