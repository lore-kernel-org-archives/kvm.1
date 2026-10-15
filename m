Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA44A5EC1
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062269; cv=none; b=t5hhc9l3LxpmixSaQDT+5zymoEnVQzzdAwAxJeWNfg+BUkomsHThz6+VSPn5FvwQR7dicdqcPDnH3ti0fFSRQBWB6ZShPamcfGG8pS3DennXJf+8xZH/WaAlW3bGdJDppvge+AXHwL9L1qto+1uzCQK/10lfyHrhE7W/CpJ2Vfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062269; c=relaxed/simple;
	bh=gVSWy9R/BJ/8Rumu5FoLhMUGMQQjgQ+qvZcUhEGqUnM=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=MAbQR0brzvTGagbj1M3nEcDA13euJMqAI8aueT6/+MxyDRWeitMOccAOI3IXQvYsWWXwuV1SnrqlLrTmQM7YQekSl2vTH7K2QAyPrNvPtiIJACgrdLuMKipmt4Yg7ywe3zSGTVTw6zgb6DP0/MAWyXetdL70RhI5uB4VWxlFtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwiKypnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwiKypnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CFE1F000C4;
	Thu, 15 Oct 2026 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062268;
	bh=D5OjbiRzx9wVxWJ3LHwRZ9MBdwR22x6OMnNz0SP32Eg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BwiKypnbUI5QzofgdTa6PPG9GScxw0a6jafVAExcjw3xIUAOhjSEa5RMpEWzQ1s6J
	 kqffjdBDePSGBG+AL7Asyla1xs8IzFMwMGkc7hiwSJelbK8MOoQKstTFCNrN+wOsTS
	 V/c4Q4KYMIWRi5+MxM05ga7GauVySrApnV/2AKe6g3v4J5jsrT51fgEQ/gPf9qbpSd
	 8w2yocAhK8ZOdbcVQydm1/exHb81cdWfdPYuYfElZ3bdRAZrTvOncnBLI5Xk1iL+2P
	 dA3XkbeYfd3hr7LK/K3FERmj57jRZruKJc00I9qOmJFB0DR2XNistY84qxipjGi6MO
	 FtSKFzXR185kA==
Message-ID: <sashiko-outbox-172712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/5] KVM: selftests: nVMX: Add nested PML coverage
 to nested_dirty_log_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015103933.2088307-5-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-5-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:04:27 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: kvm: nVMX test asserts on invalid guest PML index
--

commit 88c8168ec493a327cfe182178b11f281733406e7
Author: Nikunj A Dadhania <nikunj@amd.com>

KVM: selftests: nVMX: Add nested PML coverage to nested_dirty_log_test

This patch adds coverage for nested PML to nested_dirty_log_test. It
verifies that L1 takes a PML_FULL exit when the buffer fills, can drain it,
and can resume L2 without losing entries.

> diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/to=
ols/testing/selftests/kvm/x86/nested_dirty_log_test.c
> index 7e5f9ae1cb00a..b1008724f46dc 100644
> --- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c

[ ... ]

> @@ -192,6 +192,149 @@ static void test_handle_ucall_sync(struct kvm_vm *v=
m, u64 arg,
>  	}
>  }
> =20
> +#define PML_LOG_NR_ENTRIES	512
> +#define PML_HEAD_INDEX		(PML_LOG_NR_ENTRIES - 1)
> +
> +#define PML_FULL_MAX_EXITS	64

[ ... ]

> +static void l1_pml_vmx_code(struct vmx_pages *vmx)
> +{
> +	int nr_pml_full =3D 0;
> +
> +	GUEST_ASSERT(vmx->vmcs_gpa);
> +	prepare_for_vmx_operation(vmx);
> +	load_vmcs(vmx);
> +
> +	/* PML requires EPT. */
> +	GUEST_ASSERT(vmx->eptp_gpa);
> +
> +	prepare_vmcs(vmx, l2_pml_guest_code);
> +
> +	vmwrite(PML_ADDRESS, vmx->pml_gpa);
> +	vmwrite(GUEST_PML_INDEX, PML_LOG_NR_ENTRIES);
> +	vmwrite(SECONDARY_VM_EXEC_CONTROL,
> +		vmread(SECONDARY_VM_EXEC_CONTROL) | SECONDARY_EXEC_ENABLE_PML);
> +
> +	vmlaunch();
> +
> +	for (;;) {
> +		u64 reason =3D vmread(VM_EXIT_REASON);
> +
> +		if (reason =3D=3D EXIT_REASON_VMCALL)
> +			break;
> +
> +		GUEST_ASSERT_EQ(reason, EXIT_REASON_PML_FULL);

[Severity: Medium]
Since the test intentionally sets GUEST_PML_INDEX to 512, shouldn't this
result in a VM-entry failure instead of a successful entry followed by a
PML_FULL exit?

According to the Intel SDM (Volume 3C, Section 26.3.1.5 "Checks on Guest
Non-Register State"), the guest PML index must be less than 512 when PML
is enabled.

Does this assertion rely on KVM improperly omitting the guest state check?
If KVM is updated in the future to correctly emulate the architecturally
mandated check and fail the VM-entry, will this assertion break the test
suite?

> +		GUEST_ASSERT(++nr_pml_full < PML_FULL_MAX_EXITS);
> +
> +		vmwrite(GUEST_PML_INDEX, PML_HEAD_INDEX);
> +		vmresume();
> +	}
> +
> +	GUEST_SYNC_ARGS(vmread(GUEST_PML_INDEX), nr_pml_full, 0, 0, 0);
> +	GUEST_DONE();
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015103933.2088=
307-1-nikunj@amd.com?part=3D4
