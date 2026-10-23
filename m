Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798337;
	b=UWLNLrq+ziZLISk9DdiG9hZKskyHPrWT+m17zXuNr3TYZBzM9ZIdaGLdGDo+1pysdboy
	 CmxhiqXjI/itLEoQPb93NTlJ6PmzY1TDdOINZHDQ/shWxkX0j8ZIG7h1tmUH1iwVoxQhi
	 z+He3mQawXBXc3Yye2XDzXVL/EmNJg3eluZX2Zglli4ZxDRIUDFa02h4LPF5k6Wb3vQvo
	 Hekrx3BMVWrmqyorZU++UXgSX6+YVBGozeqW0D9h1+e2zZUHZFE/18vUWac3Cb+pUOw/B
	 ncvaYXAuyLXZUeCTvPYZEY56FvgjbtdX8Q/1SLTzCoYIBM0pBV7SOvr5BSiuJkEmAsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798337;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+uRpCta2+s96dD69f8bWRQjYDk7aUtR7RRhgbFZAQD8=;
	b=Ac7jbVG+BBFi7gU4PNHkdEiUGN5Tcy13wRDIrGAMmeP+0KrcUdXFcQMPokkSphllYDtx
	 vLH/dh8DnXRvEJR/jk5QLQSIiESu8OM02Sr8bjs/9sI8hJgjEhlEevSzDOn4WTLNQrEWW
	 NjAM7i7+GrLN/l0vbh821A0SSGTvLodT861u93O8H+2HkAI0Psxx+OheceXkPfkpXkwZ3
	 al1ZEefZWQHfwO+zdddu7kJ2ieuDuiJiS7/F9HbTnf6fqv8K6Y0qXaU3C1QgyO6HU0LOL
	 yIhxBWICqfWsimEhFwAgt6FDi7McLXpw0Thh3YCXab/0bHcIvsPZmxUSMF0ovFj/Ogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9V6hJZx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E34606A31D
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9V6hJZx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7027B1F031E0;
	Fri, 23 Oct 2026 23:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798335;
	bh=+uRpCta2+s96dD69f8bWRQjYDk7aUtR7RRhgbFZAQD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9V6hJZxS239yXCckA/anEyzWHe1D+TUClFYUZ5SRLNgcY0APoWFx0NaVJRifd9m7
	 HVILKLOc/vtTX3wSiwrebwEbypEAD6D7x029EIJY3Gzl7p0z83ic0uCX3OwOTI+2Un
	 PdF9NXsU1VSzhLWvhbhpoUxZ2Il/IXtZiiztsm1Oafy0ufO/nUgxD68taCTVMsLiaO
	 xbWd4Vy9Wy61u5FKoW8QphbbYWIXZpW3BO9RFi/omR5PxPT+/zLS2nzNVsKTHNqqW9
	 wHcJBpQx+GULCGD3mV2dd3zAZP7mVFvmndKhyiH1HiGHoSUiCHkOUhv62mDJ+vCgMZ
	 RyeM0UfQNNnxA==
Message-ID: <sashiko-outbox-183409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 45/50] samples/kvm: Implement attach and release
 provider ops in sample provider
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
In-Reply-To: <20261022-gmem-alternative-providers-v2-45-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-45-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:32:12 +0000
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
- [Low] samples/kvm: build failure when CONFIG_KVM_GUEST_MEMFD is disabled
--

commit da89517936ff62d4ed67bf323c9cade71c875336
Author: Ackerley Tng <ackerleytng@google.com>

samples/kvm: Implement attach and release provider ops in sample provider

This commit implements the .attach and .release guest_memfd provider
operations in the sample memory provider module and wires them up to
mps_file_fops.gmem_provider_ops.

> diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider=
_sample.c
> index 397ebb3773f39..d9e57484c3933 100644
> --- a/samples/kvm/mem_provider_sample.c
> +++ b/samples/kvm/mem_provider_sample.c

[ ... ]

> @@ -118,11 +119,30 @@ static long mps_file_ioctl(struct file *file, unsig=
ned int cmd,
>  	}
>  }
> =20
> +static void *mps_gmem_attach(struct inode *gmem_inode,
> +			     struct file *resource_file)
> +{
> +	return get_file(resource_file);
> +}
> +
> +static void mps_gmem_release(void *provider)
> +{
> +	struct file *resource_file =3D provider;
> +
> +	fput(resource_file);
> +}
> +
> +static const struct guest_memfd_provider_operations mps_gmem_provider_op=
s =3D {
> +	.attach		=3D mps_gmem_attach,
> +	.release	=3D mps_gmem_release,
> +};
> +
>  static const struct file_operations mps_file_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.release	=3D mps_file_release,
>  	.unlocked_ioctl	=3D mps_file_ioctl,
>  	.compat_ioctl	=3D compat_ptr_ioctl,
> +	.gmem_provider_ops =3D &mps_gmem_provider_ops,
>  };

[Severity: Low]
Does initializing .gmem_provider_ops in mps_file_fops in
samples/kvm/mem_provider_sample.c cause a build regression when
CONFIG_SAMPLE_KVM_MEM_PROVIDER=3Dm is enabled while CONFIG_KVM_GUEST_MEMFD =
is
disabled?

In include/linux/fs.h, gmem_provider_ops in struct file_operations is guard=
ed
by CONFIG_KVM_GUEST_MEMFD:

    #ifdef CONFIG_KVM_GUEST_MEMFD
        const struct guest_memfd_provider_operations *gmem_provider_ops;
    #endif

However, at this point in the series, SAMPLE_KVM_MEM_PROVIDER in
samples/Kconfig only depends on CONTIG_ALLOC && X86_64 && m:

    config SAMPLE_KVM_MEM_PROVIDER
        tristate "Build sample memory provider -- loadable module only"
        depends on CONTIG_ALLOC && X86_64 && m

A later commit in this series, 279ad9d61dfc ("samples/kvm: Support dynamic
revocation via kvm_gmem_revoke"), adds && KVM_GUEST_MEMFD to
SAMPLE_KVM_MEM_PROVIDER in samples/Kconfig. Should that Kconfig dependency =
be
moved to this commit to avoid breaking bisection when CONFIG_KVM_GUEST_MEMFD
is not enabled?

> =20
>  static long mps_ctl_new_file(void __user *uarg)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D45
