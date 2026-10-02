Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30546D095
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932419; cv=none; b=rmz+egKIKURQ08//D7idBK7h+rVDw63g6wl0RgFuy4ii0rMXoEhY2i5Iz7clBcC8fnAMc55mKi/6fKCb1Ov4Sp8wGiKZ3ZiMsPJ7v7WrQZOWjl0f/2TsDEOTk/N+eYjtXqf7q8Ypq/f3o7YaQVHF7A41wsRTUOrj3KnKuocGRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932419; c=relaxed/simple;
	bh=OQczMGseM0o0br7iTW9amuw9p5TQIESXW9AV94hpZQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=puRN53OWOmRBl9j4ofL/EY1gRbE+z9rvgBMbVJmzn/2cafu0Dj4zqq/hwPrmwX6wB7pEht6cR7t13uJrmFljgdkEr6doSwsFZ0hiOwFIaR5+MVtBO6hyBahOZBA+G4MRVST+cNRsDq/jn1YoMyFzYMh9Y4DPlI5WUF5dJ/akL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoUF2umi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoUF2umi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDF91F0089A;
	Fri,  2 Oct 2026 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932417;
	bh=543DEgjLKoXBgS1i0+O2kITmxQbnhQIDW0cj1ESBHJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NoUF2umiTktNrcWu/Z/WMNBPD0Wubyk4sTk78OTkKavgO4Z1a6nhlHcuCQTZhs178
	 0RZQfPFuCNWWjywE45lEUfG2IV3ttFoxhXV9Zahb8uCGMerhJb8pEoPwJeIXtMkQ09
	 GklrpqZxqoEp4m/wxeV5agZ4SgyJs8L30PoiRBrhv+Nspl8Ebe3g0zWysKmbapCjK0
	 uFKg4hr44MU0U2HTwcm464ItGi73Mnt/WdYKecRSwxWDApD0Uc/CT/2JyUW6tIVNQh
	 +g9kTa+PHU8vgxoh5rbgF6uRN8a2P8iAqn34yf/P1nNkyzflbyiB+AN1dukn144eZm
	 hi/c5p5cqY1ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 22/23] KVM: selftests: Add support for TDX ucalls,
 via TDVMCALL_REPORT_FATAL_ERROR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-22-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-22-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:37 +0000
Message-Id: <20261002091337.9BDF91F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: ucall global state poisoning breaks mixed-VM tes=
ting
--

commit 742d058040571d70e8a67c18a52e7026f4abe945
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR

This commit adds support for performing ucalls on TDX by utilizing the
TDVMCALL_REPORT_FATAL_ERROR hypercall. It replaces the default ucall
operations with TDX-specific handlers when a TDX VM is initialized.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index c003df3c7b8a8..c1cd32d684646 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c

[ ... ]

> @@ -37,6 +57,11 @@ static struct {
> =20
>  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>  {
> +	if (is_tdx_vm(vm)) {
> +		ucall_x86_ops.do_ucall =3D ucall_tdx_do_ucall;
> +		ucall_x86_ops.get_ucall =3D ucall_tdx_get_ucall;
> +	}
> +

[Severity: Medium]
Since ucall_x86_ops is a process-wide global struct, does modifying it here
without an else branch to restore the default handlers break mixed-VM testi=
ng?

If a process creates a TDX VM and later creates a non-TDX VM, the non-TDX VM
will inherit these TDX handlers. When sync_global_to_guest() is called, this
modified state syncs into the non-TDX VM's memory, which might cause the
guest to incorrectly issue TDCALL for ucalls, leading to an Invalid Opcode
exception in the non-TDX guest.

Additionally, host-side dispatch via ucall_arch_get_ucall() relies on this
globally assigned pointer:

void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
{
	return ucall_x86_ops.get_ucall(vcpu);
}

Will this cause the host to dispatch based on the last initialized VM rather
than dynamically checking is_tdx_vm(vcpu->vm)?

>  	sync_global_to_guest(vm, ucall_x86_ops);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D22
