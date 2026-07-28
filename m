Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E12EC0A2
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252239; cv=none; b=TY4FMm+HbKd6qbi4yx/fIL78exB4UT/BarlxkRNHaScoWF5QJmn50/ttaMnROJH/z8FTlgEc79dIqAnziFnkr6zNz+3axNReJp8moLRBk90mXgP/cp1DVZ+tls9O1nNrTo33oVlsStzQOrE0r3QUy3FKd3Ren/PtBoGoAYpnwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252239; c=relaxed/simple;
	bh=hdDMmNaJY1o/rOQHigfrvVV4v/m9kSGI5yptBGfPjd4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p1yZDVuFp3rtdqkBsmyK2dLRjAHVZV5VxH4kOIuJDSo8xesyALpUXFPihCFszoPY03iAl/E6LpFLSNXeuRPh+GAGdm3fqJBn2RNLnu+Q1qtTTmp3+VLGgvPt0qGlBmyWqLe1U+/qYl4kgcuy/ZK2EF4bzbc3jydI+Tho8ZQOb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8yD2gSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8yD2gSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2581F000E9;
	Tue, 28 Jul 2026 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252237;
	bh=/Sp3Lw26U3snM2om0pWzDP+7x3YSshr1GuHxkM0ERag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W8yD2gShnyI3kJn3ouo0Sdlzgo930LE+mI0eXG5pKbMvcn5EYTQKach1ffW+QD1OG
	 1cK+rU2cwAbl5hAKVeojW5Dbp4DTtvWysXsoAuzq8623G+JdcKMSxm67MPYUvnPOZD
	 fYxJ+qkBiBc2q+1fPSUVT5rcy8f05jDwkv7vGb5g32YGpiceZxbEHf9XDj/HvtoZqh
	 0aSOFF5zSWQNcYyQqZMLt+RPr2K4QdcrI9wswsWmfDlgivat/LVdtCex9qS8AWNvN4
	 MFdcROEjqCN2WT166ASbtNgV85FNpCIyd+i+lgwRUOS9nMgwUlCEFUFzp7aMXHb1Ih
	 QwaMV07VtdTeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 35/36] KVM: selftests: Add Xen/generic CPUID timing
 leaf test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-36-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-36-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:23:57 +0000
Message-Id: <20260728152357.9C2581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The TSC scale ratio verification test will spuriously fail if th=
e host TSC frequency is within KVM's 250 ppm tolerance of a target frequenc=
y.
- [Medium] Unsafe `realloc` pattern overwrites the original pointer, leadin=
g to a memory leak and immediate NULL pointer dereference on allocation fai=
lure.
- [Low] Commit message typo: duplicates 'KVM_VCPU_TSC_SCALE'.
--

--- Patch [35]: [PATCH v7 35/36] KVM: selftests: Add Xen/generic CPUID timi=
ng leaf test ---
commit f482c86f3dcfdbeb8ea33ae05535bd28d7cd5656
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add Xen/generic CPUID timing leaf test

This commit adds a test to verify that userspace can correctly populate Xen
and generic CPUID timing leaves. It validates this using native and scaled
TSC frequencies.

> Verify that userspace can correctly populate Xen and generic CPUID
> timing leaves using the KVM_VCPU_TSC_SCALE and
> KVM_VCPU_TSC_SCALE attributes.

[Severity: Low]
This isn't a bug, but there's a typo in the commit message where
"KVM_VCPU_TSC_SCALE" is duplicated instead of mentioning both
KVM_GET_TSC_KHZ and KVM_VCPU_TSC_SCALE.

> diff --git a/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c b/to=
ols/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
> new file mode 100644
> index 0000000000000..2098cb511ef02
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c

[ ... ]

> +static void add_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function,
> +			    uint32_t index, uint32_t eax, uint32_t ebx,
> +			    uint32_t ecx, uint32_t edx)
> +{
> +	struct kvm_cpuid2 *cpuid =3D vcpu->cpuid;
> +	struct kvm_cpuid_entry2 *entry;
> +	int n =3D cpuid->nent;
> +
> +	vcpu->cpuid =3D realloc(vcpu->cpuid,
> +			      sizeof(*cpuid) + (n + 1) * sizeof(*entry));
> +	cpuid =3D vcpu->cpuid;
> +	cpuid->nent =3D n + 1;

[Severity: Medium]
Will this cause a memory leak and immediate NULL pointer dereference if
realloc() fails?

If realloc() returns NULL due to memory exhaustion, the original pointer in
vcpu->cpuid is overwritten, leaking the memory. Then cpuid->nent =3D n + 1
will immediately dereference that NULL pointer.

[ ... ]

> +static void run_test(uint64_t tsc_khz)
> +{

[ ... ]

> +	effective_tsc_khz =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> +	bus_cycle_ns =3D vm_check_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS);
> +	effective_bus_khz =3D bus_cycle_ns > 0 ? 1000000 / bus_cycle_ns : 10000=
00;
> +
> +	/* If scaling wasn't applied, skip this frequency */
> +	if (tsc_khz && effective_tsc_khz =3D=3D host_khz) {

[Severity: Medium]
Could this check fail to skip properly if the requested frequency is within=
=20
KVM's 250 ppm tolerance of the host TSC?=20

If the target frequency is close to the host frequency (within tolerance),=
=20
KVM disables TSC scaling (setting the ratio to 1.0) but still returns the=20
requested frequency in effective_tsc_khz. Since effective_tsc_khz differs
from host_khz, this check evaluates to false even though scaling wasn't=20
actually applied.

> +		pr_info("  TSC scaling not available, skipping\n");
> +		kvm_vm_free(vm);
> +		return;
> +	}

[ ... ]

> +			if (tsc_khz) {
> +				uint64_t computed =3D ((__uint128_t)host_khz * scale.ratio) >> scale=
.frac_bits;
> +				int64_t diff =3D (int64_t)computed - (int64_t)effective_tsc_khz;
> +
> +				TEST_ASSERT(diff >=3D -1 && diff <=3D 1,
> +					    "TSC_SCALE ratio mismatch: computed %lu vs effective %u (diff %=
ld)",
> +					    computed, effective_tsc_khz, diff);

[Severity: Medium]
Does this cause a spurious test failure due to the unskipped ppm tolerance=
=20
case above?

If scaling wasn't applied but the test didn't skip (because the ratio is 1.=
0),=20
computed will equal host_khz. The assertion will then check if=20
host_khz is within 1 kHz of effective_tsc_khz. If the difference=20
between them was just large enough (e.g., 100 kHz) but still within KVM's=20
ppm tolerance, this assertion will fail.

> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D35
