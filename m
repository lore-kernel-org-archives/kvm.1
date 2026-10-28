Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202535;
	b=M2Cjkly1jNwodYlshkvS2dsz3bsRw9vC6MzHTK8rZBtTI4aFINODa7TOAFXQfX3pVysy
	 nvOhwMQprDig/exhjnAtqj2BAUvE7za10LLDtLiZUq3vbqUHbbCWiAVvyTkVsf9AxGoJR
	 vUdbwtuum6vVRIxAhvlr6KZwzuqRJawgSn0FJ3Lpuz2t2MTF3bgekLMYaytyF9VOjLIQd
	 sTjFqhpI0kMQl5Usm0jnM87D9X6lZ46mKCk58Lq7GnrGNlDJ3hduD2a3yljMyGictgQda
	 CDLxCbdWMmTHi9MOsnOoSfg3eraSDN9zrNfKbEhlDmbpEU8N1pboXHk0hOImSlp/Zqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K1JDBLPFOu6JXnIWw8Oy0ZhhClazUCLSQIjUwYJcSrM=;
	b=T0jmPBiEIjQZ8yIhAIGuKVbJkUcJJmj2DVVfGNLE9MtImmIqNYVjUPcUTgGRxfQLT400
	 9rmIdUip9ecunyJgepeMdStTDMWyqXDo7un4TCln9NrH/dabjHhxuLetzNUrujGASHNGd
	 qOSlrfkGb+wLGW5EwSvc7p5ABsN0pZ8k+b5p3BBoLPpF9qXCbCBFwicQBgepzFeOlGYZw
	 FhcIvkXVsA6o+jOVK6VYz+KlBl56h/rOwfTToSLRP83zcwGX0KfcOD1bkFb/LLCsXwioJ
	 cxdaFNH9bdNaV6bjslH3oD5azdgIIkQJ2LfODQAo3HaC5gXtNqmAGTTyYAKysMNy0NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogsZoNea;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA22606A331
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogsZoNea
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ADC1F01828;
	Wed, 28 Oct 2026 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202534;
	bh=K1JDBLPFOu6JXnIWw8Oy0ZhhClazUCLSQIjUwYJcSrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogsZoNeaTQNfOirbMVKSK6feq27pIMRM4V0VWtg4Db+xUyoFKNllWKv6Jr9cdTqFD
	 Xq4HPwuvGIxEi3dHAguImSCmj0CA+m7xfLj5LD0aE8ogB9pn83aVidkbxuXYCsOAUG
	 S2t9blyXTKBgSGx4zaJpDYVQ7ijBHlrlIvAFiDyb+JfJuS2qMGRUVgNp7AKO8MqtBX
	 oRZp9iPOwk8n/CRuY2YOe6knYA2scnjcyTDLi62ohDMemIcqhj146bkQfds9Pn6Zkc
	 kip5mr2qmpKADJLd1Bnavr210B8cSCKoc3BpG79rZl2OJf3UMo93vh5Bb8I6vpkdJr
	 pA5asqO6hJUAA==
Message-ID: <sashiko-outbox-188096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/14] KVM: selftests: Test guest_memfd mapped by
 iommufd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fred Griffoul" <griffoul@gmail.com>, "Ackerley Tng" <ackerleytng@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Sean Christopherson" <seanjc@google.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Kevin Tian" <kevin.tian@intel.com>
Cc: "Alex Williamson" <alex@shazbot.org>, "Alexander Graf" <graf@amazon.de>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Alexey Kardashevskiy" <aik@amd.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Ashish
 Kalra" <ashish.kalra@amd.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>, "Bill Wendling" <morbo@google.com>, "Borislav
 Petkov" <bp@alien8.de>, "Catalin Marinas" <catalin.marinas@arm.com>, "Christian
 Brauner" <brauner@kernel.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Connor
 Williamson" <connordw@amazon.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, "David Hildenbrand" <david@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "David Woodhouse" <dwmw2@infradead.org>, "Erdem
 Aktas" <erdemaktas@google.com>, "Frank van der Linden" <fvdl@google.com>, "Gregory
 Price" <gourry@gourry.net>, "H . Peter Anvin" <hpa@zytor.com>, "Hugh
 Dickins" <hughd@google.com>, "Ingo Molnar" <mingo@redhat.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "James
 Houghton" <jthoughton@google.com>, "Jan Kara" <jack@suse.cz>, "Jianxiong
 Gao" <jxgao@google.com>, "Joerg Roedel" <joro@8bytes.org>, "Joey Gouly" <joey.gouly@arm.com>, "John
 Starks" <John.Starks@microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "Justin
 Stitt" <justinstitt@google.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Michael Roth" <michael.roth@amd.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Nicolin Chen" <nicolinc@nvidia.com>, "Oliver
 Upton" <oupton@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Robin Murphy" <robin.murphy@arm.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <shuah@kernel.org>, "Steffen
 Eiden" <seiden@linux.ibm.com>, "Steven Price" <steven.price@arm.com>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, "Tarun Sahu" <tarunsahu@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, "Tom Lendacky" <thomas.lendacky@amd.com>, "Tycho
 Andersen" <tycho@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Will Deacon" <will@kernel.org>, "Xu Yilun" <yilun.xu@linux.intel.com>, "Yan
 Zhao" <yan.y.zhao@intel.com>, "Zenghui Yu" <yuzenghui@huawei.com>, x86@kernel.org, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Fuad Tabba" <fuad.tabba@linux.dev>, kvm@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261027154649.91571-15-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
 <20261027154649.91571-15-griffoul@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:48:51 +0000
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
- [Low] KVM: selftests: host_access() reimplements TEST_EXPECT_SIGBUS() poo=
rly
--

commit 039c70671ebb1232a61b8053400cfbcf04938b2b
Author: Fred Griffoul <fgriffo@amazon.co.uk>

KVM: selftests: Test guest_memfd mapped by iommufd

This commit adds gmem_conversion_iommufd_test to verify that iommufd mock
domain device mappings of a guest_memfd stay synchronized across conversion=
s,
allocations, hole punching, memory failure, and PFN provider operations.

> diff --git a/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test=
.c b/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c
> new file mode 100644
> index 0000000000000..5d17b0e2dd438
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/gmem_conversion_iommufd_test.c
> @@ -0,0 +1,956 @@

[ ... ]

> +/*
> + * Read @addr, or write @val to it, through a host mapping.  Return the
> + * signal that the access raised, or 0.
> + */
> +static int host_access(volatile uint64_t *addr, bool write, uint64_t val)
> +{
> +	struct sigaction sa =3D { .sa_handler =3D host_sig }, old_bus, old_segv;
> +	int sig;
> +
> +	sigaction(SIGBUS, &sa, &old_bus);
> +	sigaction(SIGSEGV, &sa, &old_segv);
> +	sig =3D sigsetjmp(host_jmp, 1);
> +	if (!sig) {
> +		if (write)
> +			*addr =3D val;
> +		else
> +			(void)*addr;
> +	}
> +	sigaction(SIGBUS, &old_bus, NULL);
> +	sigaction(SIGSEGV, &old_segv, NULL);
> +	return sig;
> +}

[ ... ]

> +#define host_read_faults(p)	(host_access(p, false, 0) =3D=3D SIGBUS)
> +#define host_write_faults(p, v)	(host_access(p, true, v) =3D=3D SIGBUS)

[ ... ]

> +static void scenario_readonly(void)
> +{
> +	struct vmm v =3D { .name =3D "pfn" };
> +	volatile uint64_t *page;
> +
> +	pr_info("   read-only frames on a PFN mode provider\n");
> +	vmm_setup(&v, BACKING_PFN);
> +	page =3D (volatile uint64_t *)(v.hva + RO_OFF);
> +
> +	*page =3D MAGIC;
> +	vmm_run(&v, 0, 0, RO_GPA);
> +	TEST_ASSERT(expect_sync_then_done(&v) =3D=3D MAGIC,
> +		    "guest does not read the host's write");
> +
> +	mps_set(v.child, MPS_SET_READONLY, RO_OFF, PAGE, true);
> +	TEST_ASSERT(vmm_iova_mapped(&v, IOVA + RO_OFF, PAGE, true),
> +		    "read-only page not mapped for the device");
> +	vmm_run(&v, 0, 0, RO_GPA);
> +	TEST_ASSERT(expect_sync_then_done(&v) =3D=3D MAGIC,
> +		    "guest cannot read a read-only page");
> +	vmm_run(&v, RO_GPA, ~MAGIC, 0);
> +	expect_memory_fault(&v, RO_GPA);
> +	TEST_ASSERT(host_write_faults(page, ~MAGIC),
> +		    "host write to a read-only page did not fault");
> +	TEST_ASSERT(*page =3D=3D MAGIC, "write to a read-only page landed");
> +
> +	/* Writable again: the guest retries the same write. */
> +	mps_set(v.child, MPS_SET_READONLY, RO_OFF, PAGE, false);
> +	vmm_resume(&v);
> +	expect_done(&v);
> +	TEST_ASSERT(*page =3D=3D ~MAGIC, "write after clearing read only lost");
> +	TEST_ASSERT(!host_write_faults(page, MAGIC),
> +		    "host write after clearing read only faulted");

[Severity: Low]
Could this test use TEST_EXPECT_SIGBUS() from test_util.h instead of
reimplementing signal-catching accesses in host_access()?

In host_access(), both SIGBUS and SIGSEGV are caught, while
host_write_faults() only checks whether the return value equals SIGBUS.  In
scenario_readonly(), if the write in !host_write_faults(page, MAGIC) raises
SIGSEGV instead of succeeding, host_access() catches it and returns SIGSEGV,
causing !host_write_faults() to evaluate to true without checking that
*page =3D=3D MAGIC afterward.

Also, in scenario_readonly(), mps_set(..., MPS_SET_READONLY, ..., true)
revokes the host mapping before host_write_faults(page, ~MAGIC) runs.
Because the write happens before *page =3D=3D MAGIC faults in a present rea=
d-only
PTE, it only exercises kvm_gmem_pfn_fault() on an unmapped PTE and leaves
kvm_gmem_pfn_mkwrite() on a present read-only PTE untested.  Should the host
read happen before the write attempt (or should another write attempt follow
the read), and should a direct store *page =3D MAGIC be used once the page =
is
writable again?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027154649.9157=
1-1-griffoul@gmail.com?part=3D14
