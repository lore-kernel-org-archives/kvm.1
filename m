Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792798332;
	b=ThZMahzQ3vwrHSYQ9J0M+8u7B0hHN0jLmU7HHRjpJ4E3d5h7WhiFmwNWAKRlo0exQyxc
	 8spwSkNw4uyw8m7LkqeHHm9Q9E8XOrz5vd1Xk7zB8aYBG+wSDNaqqL/HnXdmjtK4QAJ1i
	 BRr9E2depYs1cgznocjYoWgF0hBOHYilya+vzIgOvAeM9l77mR7mWGFbA212BnYs4t9Jn
	 KufIt12qrKPxPG+pDBrrpHI5N6rNI+JSoT1beMp5ulnKAGhC5hMStlidWSnXlSVkHivgd
	 u/qkReayGTPaJLzyRSOcF2c/mQ+Rrt/VgESQ7Tbl9zF2wk+X0VUt52Qt4e1DZ2lnLkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792798332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3UZrbC4N8JNfc6PZwSmyhvVctg9xGDP5yMSRIj5yhQw=;
	b=T/qWMdIlqNx7DTd4oVjqbiSfxHD1FirmoH6Yg9rmebxMFC0/hUYrIUDTapsAIhGv2Y8T
	 WE/QkDejF227c+toLqTJJDHt3EI/T9dtOzF4tuVH41Tbu2wM5m1H4DKRFIOHAqpf8kuvf
	 ic0SDB7mvpefQIcvtBC1ACadTJWgqP9lwp9EdL8WgZpmtARLGv5mEEnTOz+xT/HwNlodj
	 4Ob1enpj+O29T6OhLG1Coqm+aKoOh2s5yH0gWufm6Q5xTaqdKHP9lpxD1zOGeOC0lKtO7
	 zl8AjilmxdRpIqDLrjq65Gk+cNkv44M0dok9aYRe3js/COb+hyp4+LXDOhy6Ux2mKkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPyqDrZj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAA606A31A
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fPyqDrZj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD2E1F01829;
	Fri, 23 Oct 2026 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792798332;
	bh=3UZrbC4N8JNfc6PZwSmyhvVctg9xGDP5yMSRIj5yhQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fPyqDrZjw5JLD8l37DKGX8bIAPsBQ9025pPwxcHXKxilcY2qc0rlwb+T1uo7AWF6x
	 n+sM/o3O5fgsuK7PBaVSl2I4QtJz4kTyg/J5Kqcr43GSdmDgPCEvyCjoVombOMveqe
	 OGFZJexZBH5jswG+0fMPooq+/dfulmNeg9a7psVpF0zezm8fFWuh3JTTNscgOUki4r
	 Brdfu1rXpDW99cmpH4PnxAPvPE2KglA9pT+eCELv0cl332A/hU8PwLaulhyaV6/MXp
	 KbSXBULwn/cg9zXqKtMYU2p0GelPZp8ZnJR+C7Ql9eOCuJYZyXt9Tth1hI+0Vvkkz4
	 bByiUrMyiWMdg==
Message-ID: <sashiko-outbox-183394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 30/50] KVM: selftests: Add basic test for sample
 memory provider
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
In-Reply-To: <20261022-gmem-alternative-providers-v2-30-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261022-gmem-alternative-providers-v2-30-5dd1dc6c660a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:32:08 +0000
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
- [Medium] KVM: selftests: open_provider_dev() reimplements __open_path_or_=
exit()
--

commit adc070cca1ed801047bd293a0094a045579d124f
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add basic test for sample memory provider

This commit adds a selftest for /dev/mem_provider_sample to verify basic fi=
le
creation across multiple sizes, stats reporting via MPS_GET_STATS, and page
presence toggling via MPS_SET_PRESENT.

> diff --git a/tools/testing/selftests/kvm/mem_provider_sample_test.c b/too=
ls/testing/selftests/kvm/mem_provider_sample_test.c
> new file mode 100644
> index 0000000000000..932ea3f30f494
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tests for the sample memory provider (/dev/mem_provider_sample).
> + */
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "test_util.h"
> +#include "../../../../samples/kvm/mem_provider_sample.h"
> +
> +#define DEV_PATH "/dev/mem_provider_sample"
> +
> +static int open_provider_dev(void)
> +{
> +	int fd =3D open(DEV_PATH, O_RDWR);
> +
> +	if (fd < 0) {
> +		TEST_REQUIRE(errno !=3D ENOENT && errno !=3D ENODEV);
> +		TEST_FAIL("Failed to open %s: %d (%s)", DEV_PATH, errno,
> +			  strerror(errno));
> +	}
> +	return fd;
> +}

[Severity: Medium]
Could open_provider_dev() use __open_path_or_exit() from
tools/testing/selftests/kvm/lib/kvm_util.c instead of hand-rolling the
open() error handling?

tools/testing/selftests/kvm/lib/kvm_util.c:__open_path_or_exit() {
	fd =3D open(path, flags);
	if (fd < 0)
		goto error;

	return fd;

error:
	if (errno =3D=3D EACCES || errno =3D=3D ENOENT)
		ksft_exit_skip("- Cannot open '%s': %s.  %s\n",
			       path, strerror(errno),
			       errno =3D=3D EACCES ? "Root required?" : enoent_help);
	TEST_FAIL("Failed to open '%s'", path);
}

Because samples/kvm/mem_provider_sample.c registers /dev/mem_provider_sample
via misc_register() with default 0600 permissions, running the test as an
unprivileged user causes open() in main()->open_provider_dev() to fail with
EACCES. That bypasses TEST_REQUIRE(errno !=3D ENOENT && errno !=3D ENODEV) =
and
calls TEST_FAIL() -> test_assert() in
tools/testing/selftests/kvm/lib/assert.c:

tools/testing/selftests/kvm/lib/assert.c:test_assert() {
	if (!(exp)) {
		va_start(ap, fmt);

		fprintf(stderr, "\n=3D=3D=3D=3D Test Assertion Failure =3D=3D=3D=3D\n"
			"  %s:%u: %s\n"
			"  pid=3D%d tid=3D%d errno=3D%d - %s\n",
			file, line, exp_str, getpid(), kvm_gettid(),
			errno, strerror(errno));
		test_dump_stack();
		...
		if (errno =3D=3D EACCES) {
			print_skip("Access denied - Exiting");
			exit(KSFT_SKIP);
		}
		exit(254);
	}
}

In test_assert(), fprintf() and test_dump_stack() run before the
errno =3D=3D EACCES check, printing an assertion failure stack trace and
clobbering errno so the test exits with 254 instead of skipping cleanly. In
addition, when the sample module is not loaded,
TEST_REQUIRE(errno !=3D ENOENT && errno !=3D ENODEV) only prints the raw
expression without the missing device path or Kconfig hint.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-gmem-alter=
native-providers-v2-0-5dd1dc6c660a@google.com?part=3D30
