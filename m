Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798325;
	b=xmaTY9GLucxaB29XWqoM3xg9r2jIjvlbtgdlMXOL4K5Uc5S9/eaoTDnzRTNBvphRNXBd
	 WlO6b51l91fDrfD+p69kyNP8MeOXGOo4dZ6GL42SjumrARKOIRnd5mWS0jlirr74DJdAS
	 5nzauL5NY8UdD/WbHJzZqyFjWuPLngdzPpVu1cVcoXQZFkhcpn/rivVbr7+pHM4BkrRQa
	 mCg+R6moJpncJGzyzzQX/MCXz4dJSHM4dx1PhvlxqGpXNTki37NerL0GI/ymhK04nkMkr
	 orvHxWpmlKbw6UyBAbHqH2/AOAJ3eRyp38c+hkOOi4IoekDCxsRTigtEY0Acj22uJ1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798325;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aedCsf6wnp02GBZIVtfAAeggBxnkw6ruKqSrmMEp0wY=;
	b=0AZeKmY99w84lrU6QScllPPtuGJiN7A3fouy9In27KtBCukrTLsfa/TtPWgnRNUa5m2M
	 +WrX0A7p1Woj/HjxzLdSj4QJgYZf+QUIRGSacVxa/DhAPolnrZ5zI7GdnUXHiCWKoAs31
	 RUSufNpWHu6N7L5GKlUld27UPn4FFyl8mj3Vb2ftR6v6i0tlnX/JPcEflWlWg+qOMWqxP
	 cPYVO8izjO58SzdBnQ2u+LEAmnnT9QKQ8mB3cjCIjB8exbLMz9I/tmUjv6Xr31zBaxMhG
	 Ov1fs4cxuswOXwIbJhUqM8VoBAkbEvRuxW6A9ovGPjwIaslfv5ZeUmCVdEoEo2bI9hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3FCrpc5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C506606A31D
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3FCrpc5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD051F01828;
	Fri, 23 Oct 2026 23:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798325;
	bh=aedCsf6wnp02GBZIVtfAAeggBxnkw6ruKqSrmMEp0wY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3FCrpc5Y8QeR5C96bYaGO84eRUrmnfBU1jU8uBQxaFg/ba9bCr37UPur7kSPcF0u
	 opxOt5ydM9PGgupVt2ANQ922QJi8iGsHGo6upMVKAKEg9+CfE9vOBKa7uJsPZBdDRa
	 uMFWPSvbCnyh+Eb7U4dxekO51N21crgx8VBzZ0/CAeym3oErLjKfVTZz/eBut/tE0k
	 tER4Zdn4+HdvZJymqcTnpjuI98APxQWVCC5WrFbNV+gvuYXLPXRGDA9VMKHAxkGDFo
	 u1CQHq2SQsu+0H7gBMF1jhdjXvtM8lLPCFEUbHsKDszjFWbSIkZnR8BNN3gfipcVf5
	 Ogxz0mnhvWndg==
Message-ID: <sashiko-outbox-183375@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/50] KVM: selftests: Test rejection of hugepage
 tmpfs mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng" <ackerleytng@google.com>, "Alex Williamson" <alex@shazbot.org>, "Alexander
 Graf" <graf@amazon.de>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Alexey
 Kardashevskiy" <aik@amd.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, "Ashish Kalra" <ashish.kalra@amd.com>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Baolu Lu" <baolu.lu@linux.intel.com>, "Bill
 Wendling" <morbo@google.com>, "Borislav Petkov" <bp@alien8.de>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Christian Brauner" <brauner@kernel.org>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Fred
 Griffoul" <fgriffo@amazon.co.uk>, "Fred Griffoul" <griffoul@gmail.com>, "Gregory
 Price" <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, "Hugh Dickins" <hughd@google.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Jianxiong Gao" <jxgao@google.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John Starks" <John.Starks@microsoft.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Justin Stitt" <justinstitt@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Sean
 Christopherson" <seanjc@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261022-gmem-alternative-providers-v2-11-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-11-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:32:01 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing THP check in test_resource_fd_tmpfs_huge=
()
--

commit fa5c797829415f0417ade9cfcef613bbfe69de07
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test rejection of hugepage tmpfs mounts

This commit adds test_resource_fd_tmpfs_huge() to guest_memfd_test to verify
that creating a guest_memfd backed by a tmpfs mount with hugepages enabled
is rejected.

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
Will test_guest_memfd() -> test_resource_fd_tmpfs_huge() ->
create_tmpfs_pool_fd() fail the test on kernels built without transparent
hugepage support or on hardware where transparent hugepages are disabled?

In tools/testing/selftests/kvm/guest_memfd_test.c, create_tmpfs_pool_fd()
asserts that setting the huge mount option succeeds:

	if (huge)
		TEST_ASSERT(!syscall(__NR_fsconfig, fs_fd, FSCONFIG_SET_STRING,
				     "huge", huge, 0), "fsconfig huge failed");

However, in mm/shmem.c, shmem_parse_one() rejects huge=3Dalways when
transparent hugepages are not configured or supported:

	case Opt_huge:
		ctx->huge =3D result.uint_32;
		if (ctx->huge !=3D SHMEM_HUGE_NEVER &&
		    !(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
		      has_transparent_hugepage()))
			goto unsupported_parameter;

And the check under test in shmem_gmem_attach() in mm/shmem.c is also
compiled out in that configuration:

	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
		if (sbinfo->huge !=3D SHMEM_HUGE_NEVER)
			return ERR_PTR(-EINVAL);
	#endif

Should test_resource_fd_tmpfs_huge() check thp_configured() before calling
create_tmpfs_pool_fd("always", true, page_size) and return early if
transparent hugepages are not available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D11
