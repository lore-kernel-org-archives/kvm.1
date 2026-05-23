Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176D24BBEB
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498910; cv=none; b=UKCn9/Ac2KQ/0oRu1lf4iBJmiwJXsFv8CQ0rArzXUBARRnX7x8gbrcC3LVwsYrnNj41/2Q29RihmTE0G82pU9DG4xgaIBFAFtpaCyd4YrnR8A6ESHooahg5bJbPDQCg0o1DOykKXBXV4sVjkUIDBWLdbv6d/9+k0nzCINPzpA/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498910; c=relaxed/simple;
	bh=s/r55vzZpQHrbAfW4TweUmVxhb85unKVGVjrVISszHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tbqXTTRbikdudhv/w9PV4SXMTzdTfW/b9VhD/FMA071joyV3LOjNAs5YLhonSZEye41C2K4jRXYdmKUKCh+lknYeX4msCvJa4rhIB6iYxp0LmYYGg1VpwOb7rX+BzgmvYDKZj06l/Z7gB46q9qbbS9jtHGMkgEsUszNvSeh0l6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEucli7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEucli7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37D51F000E9;
	Sat, 23 May 2026 01:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779498909;
	bh=57vROLk6OSYHuiEIKlEREQXYrc0XRp4Cv6x3hoKhrJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PEucli7jaZuG/TMzUQqr+/jFJRIMPOmnq6gizSlS48nQVk/JC7VlYkTXGujXSkQZS
	 MtzVpK7Fl7nB8c+bb0XLxT4d8pwQ1nraWVYH2lZFvQ5xGSq3tauc7Fj0hQs0bmsOcO
	 a6mHZ2RHGZHlRJwIB/VHVzz/MX9Abme7P1V2qz7UNMqMVSdVlAbXTGOarxogrv8s9A
	 eZQDcsZKhrFPUcUweDvjt0hCbNpCDaF16U+W8B4UrTuVabMU9gJaNSjWKpTpkA0hfL
	 Ok3Z1s3jzGY8bO4s3PMZexSVlQykL0VfD+8/mg9Z5bfnd3qmTi+RM8j4c3UKDrQAex
	 gAqm+ew7Goqhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 41/42] KVM: selftests: Add script to exercise
 private_mem_conversions_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-41-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-41-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:15:08 +0000
Message-Id: <20260523011508.E37D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The script uses a hardcoded parent directory (`../`) path to loc=
ate the `kvm_has_gmem_attributes` executable, which breaks when tests are r=
un from an installed kselftest environment.
- [Medium] The script uses strict arithmetic equality checks (`-eq`) on out=
puts that may be empty or contain non-numeric text, leading to bash syntax =
errors.
- [Medium] The script overestimates the number of required 2MB hugepages by=
 a factor of 512, causing it to incorrectly skip `anonymous_hugetlb_2mb` te=
sts on capable systems.
- [Low] The script misinterprets the KSFT_SKIP exit code (4) as a test fail=
ure, printing misleading error messages to stderr.
--

commit 51c5aeb07efad4df1869ea11f998198311b32d17
Author: Ackerley Tng <ackerleytng@google.com>

KVM: selftests: Add script to exercise private_mem_conversions_test

This commit adds a wrapper script to run the private_mem_conversions_test
across various memory backing source types and memslot configurations.
It also introduces a helper program to check for the
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES capability.

> diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test=
.sh b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
> new file mode 100755
> index 0000000000000..7179a4fcdd498
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
> @@ -0,0 +1,128 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only

[ ... ]

> +NUM_VCPUS_TO_TEST=3D4
> +NUM_MEMSLOTS_TO_TEST=3D$NUM_VCPUS_TO_TEST
> +
> +# Required pages are based on the test setup in the C code.
> +REQUIRED_NUM_2M_HUGEPAGES=3D$((1024 * NUM_VCPUS_TO_TEST))

[Severity: Medium]
Does this calculation overestimate the required 2MB hugepages by a factor of
512?=20

The backing C test program allocates guest memory based on PER_CPU_DATA_SIZE
(SZ_2M + PAGE_SIZE), which with 2MB alignment requires 4MB per vCPU (2
hugepages), not 1024 hugepages per vCPU.=20

This could cause the test to artificially skip anonymous_hugetlb_2mb tests =
on
systems that actually have enough hugepages.

> +REQUIRED_NUM_1G_HUGEPAGES=3D$((2 * NUM_VCPUS_TO_TEST))

[ ... ]

> +get_default_hugepage_size_in_kb() {
> +    local size=3D$(grep "Hugepagesize:" /proc/meminfo | awk '{print $2}')
> +    echo "$size"
> +}
> +
> +run_tests() {

[ ... ]

> +script_dir=3D$(dirname "$(realpath "$0")")
> +test_executable=3D"${script_dir}/private_mem_conversions_test"
> +kvm_has_gmem_attributes_tool=3D"${script_dir}/../kvm_has_gmem_attributes"

[Severity: Medium]
Does this hardcoded parent directory path break when tests are run from an
installed kselftest environment?=20

When installed via `make install`, kselftest flattens the directory structu=
re,
so both private_mem_conversions_test.sh and kvm_has_gmem_attributes are pla=
ced
in the same target directory. The `../` path points outside the install
directory, causing the script to fail unconditionally.

> +
> +if [ ! -f "$test_executable" ]; then
> +    echo "Error: Test executable not found at '$test_executable'" >&2
> +    exit 1
> +fi
> +
> +if [ ! -f "$kvm_has_gmem_attributes_tool" ]; then
> +    echo "Error: kvm_has_gmem_attributes utility not found at '$kvm_has_=
gmem_attributes_tool'" >&2
> +    exit 1
> +fi
> +
> +kvm_has_gmem_attributes=3D$("$kvm_has_gmem_attributes_tool" | tail -n1)
> +
> +if [ "$kvm_has_gmem_attributes" -eq 1 ]; then

[Severity: Medium]
Can this strict arithmetic equality check crash bash if the variable is emp=
ty
or contains non-numeric text?=20

If `/dev/kvm` is inaccessible (e.g., due to missing permissions),
`kvm_has_gmem_attributes` might exit and print a TAP skip message, leading =
to
an "integer expression expected" error.

> +    backing_src_types=3D("shmem")
> +else
> +    hugepage_2mb_count=3D$(get_hugepage_count 2048)
> +    hugepage_2mb_enabled=3D$((hugepage_2mb_count >=3D REQUIRED_NUM_2M_HU=
GEPAGES))
> +    hugepage_1gb_count=3D$(get_hugepage_count 1048576)
> +    hugepage_1gb_enabled=3D$((hugepage_1gb_count >=3D REQUIRED_NUM_1G_HU=
GEPAGES))
> +
> +    default_hugepage_size_kb=3D$(get_default_hugepage_size_in_kb)
> +    hugepage_default_enabled=3D0
> +    if [ "$default_hugepage_size_kb" -eq 2048 ]; then

[Severity: Medium]
Similarly, can this arithmetic check crash if the kernel lacks hugetlbfs
support and grep returns nothing, making `$default_hugepage_size_kb` empty?

> +        hugepage_default_enabled=3D$hugepage_2mb_enabled

[ ... ]

> +return_code=3D0
> +for i in "${!backing_src_types[@]}"; do
> +    src_type=3D${backing_src_types[$i]}
> +    if [ "$i" -gt 0 ]; then
> +        echo
> +    fi
> +
> +    if ! run_tests "$test_executable" "$src_type" 1 1; then

[Severity: Low]
Does this misinterpret a KSFT_SKIP exit code (4) as a test failure?

If the underlying test lacks capabilities like `KVM_X86_SW_PROTECTED_VM`, it
correctly exits with code 4. The wrapper script catches all non-zero exit c=
odes,
unconditionally prints an error message to stderr, and breaks the loop, whi=
ch
could cause confusion during automated test runs.

> +        return_code=3D$?
> +        echo "Test failed for source type '$src_type'. Arguments: -s $sr=
c_type -m 1 -n 1" >&2
> +        break
> +    fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D41
