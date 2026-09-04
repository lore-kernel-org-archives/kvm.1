Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9A37F01C
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490254; cv=none; b=sbIJN6ARUFhLehcRkD9K/nZnbrNu02N75EQg2xnI3ujlCoFpguV3dy0b0OlDhxuHfB4CFqaVqBQ8CDQwPKyMRi0+9oYf0ephvKUBpWdJ5wWzbfB9FIxMdf3kw4MV+O+/FLuSxSMedm1IffV0aXj9dMhDOuTZrDFLhNAjAazlhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490254; c=relaxed/simple;
	bh=g9U5b4TrCFsI/6HHXaPMB95+OVyxpeOY0QmddqbBrG0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EC9V4X3WBT/nilwS7qyC9DxW+xbMoEMcNez5Z+0V6Hg1zwqjYduyqCcn+RKglQRCyltLONZSdBlqJWdCCTiHrkU4lud3IMF9Rb2Oc25jHO/Xt6qqia84zVJWOKy5fC5kKobkzKBwNodjupol/SyuGRBb0EHDwAlcKlAOUt6NLUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaT7cKyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaT7cKyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C8D1F000E9;
	Fri,  4 Sep 2026 02:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490252;
	bh=TjwoTvJs1pXfUO6XMeg3tPZ8JmMt70/LB5Aw8bA7ci8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oaT7cKyxfMbxuqpyON1IGwiDqvWxDO+KCF7AM0yVE1m2AfWUDgcpm0H7XPbsXdwzA
	 +NEdgsD/OdQ7xVjMhDb7DnCqfAHKy3TUfCPEQSFgYaWeDufC9hNe94ewGSxsDgCdwQ
	 KDObUrjIeLupWyZ3dANtQiRCmbW3gjlzLkVxvEhNJb1sYZLqbSxoy/I3dJm8gZQ7/I
	 TIr6KYsBqdZZntkadDdti03MUMh6fh+E1+LC/9mphl4sof3Ek7k51L9qbHTDkAkUKH
	 7lgoH0U2xHUXpcDK7GS7FE/uewgEBg17+24uvbHOizxNYb9A8im7SojJnKvX9Vss7H
	 AQDVTBy6705pg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 4/4] KVM: selftests: Test VM-entry failure handling for
 nested VM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Liu" <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260904023105.1167376-5-zhao1.liu@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
 <20260904023105.1167376-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 02:50:52 +0000
Message-Id: <20260904025052.A6C8D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The test configures an architecturally invalid VMCS12 host CET sta=
te, causing physical hardware to reject KVM's L1 VM-Entry.
- [High] L1 configures `MSR_IA32_S_CET` without enabling `CR4.CET` and `CR0=
.WP`, causing physical hardware to reject KVM's L1 VM-Entry.
--

commit 0167d3a43f196a36484ad8300e0c72caf7470746
Author: Zhao Liu <zhao1.liu@intel.com>

KVM: selftests: Test VM-entry failure handling for nested VM
   =20
This commit adds a test for the CET state L1 sees after a nested VM-entry
fails. It tests all four combinations of the two VM-entry/exit load CET
state controls with two different failure points. It then checks L1's
S_CET and INT_SSP_TAB MSRs to verify the expected behavior.

> diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_=
test.c b/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c
> new file mode 100644
> index 0000000000000..ed0cb045ed53a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c
[ ... ]
> +static const struct test_state states[NR_STATE_SRCS] =3D {
> +	[STATE_SRC_L1] =3D {
> +		.cet =3D {
> +			.s_cet		=3D CET_SHSTK_EN,
> +			/*
> +			 * SSP is not an MSR; the L1 SSP must be configured
> +			 * using the KVM_SET_ONE_REG ioctl. To simplify the
> +			 * test logic, checking the other MSRs is enough to
> +			 * identify the state source, so that there's no need
> +			 * to configure different SSPs.
> +			 */
> +			.ssp		=3D 0x0000111111111000UL,
> +			.ssp_tbl	=3D 0x0000123456789000UL,
> +		}
> +	},
> +	[STATE_SRC_VMCS12_GUEST] =3D {
> +		.cet =3D {
> +			.s_cet		=3D CET_SHSTK_EN | CET_WRSS_EN,
> +			.ssp		=3D 0x0000111111111000UL,
> +			.ssp_tbl	=3D 0x00000abcabcab000UL,
> +		}
> +	},
> +	[STATE_SRC_VMCS12_HOST] =3D {
> +		.cet =3D {
> +			.s_cet		=3D CET_WRSS_EN,

[Severity: High]
Does the states array configure an architecturally invalid VMCS12 host CET
state?

According to the Intel SDM (Vol 3C, Section 26.2.3), if SHSTK_EN is 0,
WRSS_EN must also be 0. Here, it sets CET_WRSS_EN (WRSS_EN=3D1) while SHSTK=
_EN
is 0.

Because KVM currently does not validate this specific rule, it accepts the
invalid host state and loads it into L1's state during the nested VM-exit.

When KVM then performs a physical vmresume to enter L1, the physical CPU
enforces the rule, rejects the VM-Entry with EXIT_REASON_INVALID_STATE (33),
and causes KVM to inject a KVM_EXIT_INTERNAL_ERROR, crashing the selftest.

> +			.ssp		=3D 0x0000111111111000UL,
> +			.ssp_tbl	=3D 0x00007edcba987000UL,
> +		}
> +	},
> +};
[ ... ]
> +static void l1_load_own_state(void)
> +{
> +	if (has_shstk) {
> +		const struct cet_state *cet =3D &states[STATE_SRC_L1].cet;
> +
> +		wrmsr(MSR_IA32_S_CET, cet->s_cet);
> +		wrmsr(MSR_IA32_INT_SSP_TAB, cet->ssp_tbl);

[Severity: High]
Will this write to MSR_IA32_S_CET cause physical hardware to reject KVM's L1
VM-Entry?

In l1_load_own_state(), L1 writes CET_SHSTK_EN to MSR_IA32_S_CET, but the
test never enables X86_CR4_CET or X86_CR0_WP in L1's control registers.

KVM statically enables VM_ENTRY_LOAD_CET_STATE for L1 guests when CET is
supported, which means the physical CPU enforces guest state checks on L1
during vmlaunch or vmresume.

According to the Intel SDM (Vol 3C, Section 26.3.1.1), if
VM_ENTRY_LOAD_CET_STATE is 1 and IA32_S_CET.SHSTK_EN is 1, then CR4.CET and
CR0.WP must both be 1.

Because L1's guest state in vmcs01 has SHSTK_EN=3D1 but CR4.CET=3D0 and CR0=
.WP=3D0,
the physical hardware will reject the VM-Entry into L1 with
EXIT_REASON_INVALID_STATE (33).

This results in KVM intercepting the failure, injecting
KVM_EXIT_INTERNAL_ERROR, and crashing the selftest.

Should the test explicitly set X86_CR4_CET and X86_CR0_WP before configuring
CET?

> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904023105.1167=
376-1-zhao1.liu@intel.com?part=3D4
