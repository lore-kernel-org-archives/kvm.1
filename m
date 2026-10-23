Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798340;
	b=lJ/RvNDKPWsnDIh79Ijh8DxZ5Z8DSSg0+768hXfduuAxrf/SbC+gWaBKDe1loNdXrPyG
	 JV1ZLqTJ77LQvOPg0G9QS8uh7hfZVZQoyan7pv8F6lvvhFNktwyipp75aox1LHU5R3LLE
	 Bj6Rrbuq1GjrcCitvrio2XbpY4R7ASv7QUEVkkH4vymeHSIbEmMczQWsopKBZVR7CR4Rb
	 oAuxj4jRQSc58ru6iDS76iHC13InCCAoaqAqhzDyoBE91HUXwL6qyYYTRm+eSTwJe6gSO
	 oo3Gx7rAYpBzoPlTKTyn4nLbf+pVJGPZA1had51j5Q1qAW1f3Z4ADaJ4EmgrZEgIQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cUpsYXA4p+AgcY2utW3SVs0gcNM9y9RphrhZOvqDytA=;
	b=YcSeID5+HRkUpWauxbrF1qGR3WRWmuiSB8PfyCbOJSXrjb9VOIKEs3AcMN6d7X/NZJ3e
	 jU6dqR6dg9j9FsqHxCOqsU6ipuZkgcVmrqXvLGdswbDPP7Carb4Zpca1t4ns7n/jXLXAY
	 rx8cdmWxnBad1Y+dJTxBZR4Cfy8DVNUSBTq+zeH1vCcgYJCh5chYhUp1uVYLsPiHTnj2/
	 //Citp/hjRS4vKInWM4Gf/RMV6c9gc16THxjFC/g0jjdJOu+kkQyczUsEjCMulljdsJYd
	 q+ZBnUq+Onrs1Ixk7TUn0Yn8+8QzTAaNDkjh5D0GMXPVJwNH6VDqINGLuArsvsBPo5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UKdfT/OZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365D606A31D
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKdfT/OZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC0E1F01825;
	Fri, 23 Oct 2026 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798340;
	bh=cUpsYXA4p+AgcY2utW3SVs0gcNM9y9RphrhZOvqDytA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UKdfT/OZXVsr5JNMxUJ4xUGR5FMzBjw2rLouHhtfv7TsAdWvn4MfBIXPwZiFuJpZm
	 LlpP3saAINecEFdJUKm1nQnQH/7RBoHPEkAQqUJVuODcZofE467/Uwi5TUgTcKeCUr
	 +uSzdFDPmmpXGm1K2DPcEcWXE3V6lFeWIJK5QaKXny2yBHmuTCRxqzYF+WaSE55+r2
	 svOHmVOGFENXAq3upyZATpdYrmNhys5CiEZRsVO4cVvCuvAS3521CF5lP9l2G0+UZ0
	 tTKj8lVqNE3iW21v3+zFjJQlRreIMS3FfAo4AnSws3PzY83j+8YzQfduZ9mogig340
	 ING54nvBLYZHQ==
Message-ID: <sashiko-outbox-183414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 50/50] KVM: selftests: Test guest_memfd
 conversions with sample memory provider backing
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
In-Reply-To: <20261022-gmem-alternative-providers-v2-50-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-50-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:32:16 +0000
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
- [Low] KVM: selftests: wrong relative path to mem_provider_sample.h
--

commit b071597d5a3f5abd9db2726fb150510172e23946
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Test guest_memfd conversions with sample memory provider ba=
cking

This patch adds a fixture variant to guest_memfd_conversions_test.c to test
guest_memfd conversions backed by the sample memory provider module, skippi=
ng
the variant if /dev/mem_provider_sample is unavailable and asserting that
page pinning fails on pfn-backed memory.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 023df9cb9d4a6..b99e4cdbab8e6 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> @@ -16,11 +16,13 @@
>  #include "kselftest_harness.h"
>  #include "test_util.h"
>  #include "ucall_common.h"
> +#include "../../../../samples/kvm/mem_provider_sample.h"

[Severity: Low]
Since tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c is five
directory levels below the kernel tree root, four ../ traversals resolve
relative to the source file as tools/samples/kvm/mem_provider_sample.h, and
relative to the tools/include search path as two levels above the kernel tr=
ee
root, before happening to match via the four-level-deep
tools/arch/<arch>/include search path.

Should this use five ../ traversals to match other five-level-deep files su=
ch
as tools/testing/selftests/kvm/lib/kvm_util.c:

#include "../../../../../samples/kvm/mem_provider_sample.h"

> =20
>  FIXTURE(gmem_conversions) {
>  	struct kvm_vcpu *vcpu;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D50
