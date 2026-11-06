Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923340;
	b=WmQMi12POgJOzNsT+UisJjPzw5ktxp/GhFN+q7oIPe+Yf0j2slawjlltf5rp7byZwaKk
	 YQk3RuC84sFjqlRc2CCD99GNR+qJKkvAZwcvuRyxBQDLLyI2IJGR/WgdJ2k6Lxuowc8E2
	 i6AO/7Up7n9SMgK42TZe5eWJdLs/g3QbUC6rxoKj02xi+F+8U82s2Rqtq0vJkCPhjHprJ
	 FR2uYPB8oQaw96wV7JUhj+DJcawNTXkHn1jtk8VHgRks2e8rXGpa5MVdBqMmD5o/xEWvK
	 Fp0XQkm4/tILKLcvkA/Ssl3ChqrLvNg7H6zAcWCaYNe+VVE0Ehoo01RpzaeQIVK9Isg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tmFmr+ej0lqf8GQ11rxdhScluK7Ys/zDVNanSgLQtTI=;
	b=4DcOVY/UhodCpwBVbcD/ZrwZL6p6zA0JMaUOURuhsJav6LQugF3hZsAZpUufUkNj6/5k
	 jTbLNG7bhE2AmBUUaSKbsbcI2jl0gY3kVOSQmLGWgvdWkOBO9aZuR2Q+rgKAn6YnA2Wlx
	 hIyP8gTgBzB/+icgfow96OMPvl4EZ1hZSgnMwKn29pjt5hihy+ivUJAEzc6PeTD7uRzpX
	 O0giTYNt2tTTPNoKX2DE8/9oAIrT+2zSVsohyNFcdvX4KZ9AEVHauaF7zhu9q3jXZgB/y
	 6auKlw88pzDozlf+At8oDkYR3DlG65db3ZMNDwH940h5olvo4PF19YOhJ0TPOcAe9kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVGldMvj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB41606A329
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVGldMvj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8F11F008A2;
	Fri,  6 Nov 2026 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923339;
	bh=tmFmr+ej0lqf8GQ11rxdhScluK7Ys/zDVNanSgLQtTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVGldMvjwsY3Nd7YxXjXCS0CJZQbysQTeAiN/7Lim+9IuAf2Nk0lT9bfvIXMrRLHc
	 qE2t1GBsqEcOLFfLmGpJ5CXiXklVf9w3En7ot9LAyH+F9wLRInJIshOwPeVrBVJaFA
	 F65kPA8QBvnLXUPeQNJiezHdKX/PFfrOlqzjN2129Fsc4+QcfFxK8QC6V2egeiTP3v
	 R5sp8dypyt/N0gwkomZQygwpYVfOQEvmvcmz1UbWVg9Kuj7T6r4e6k/D2wUVQRe08z
	 fOirtHdocyY7fteADVRNsqv8f+94gtBQqyQ45jDHuf1VYg4jPQluEVrUv1I6eeEmiv
	 03o44jDzFHtwQ==
Message-ID: <sashiko-outbox-200422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 19/20] KVM: selftests: Add support for TDX ucalls,
 via TDVMCALL_REPORT_FATAL_ERROR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261105-tdx-selftests-v16-19-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-19-2024e8fa517a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:02:19 +0000
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
- [Medium] kvm: selftests: ucall_arch_init() permanently overwrites global =
ucall_x86_ops
--

commit e57af1ee0994af97f6ae447fc9a5abebc0287e67
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR

This patch adds TDX ucall support in KVM selftests by passing the ucall
payload address and a magic value via TDVMCALL_REPORT_FATAL_ERROR. When a
TDX VM is initialized in ucall_arch_init(), ucall_x86_ops is updated to
use the TDX ucall callbacks and synced to the guest.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index 3aec4dd46d1b2..2a1c61785e5fb 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c

[ ... ]

> @@ -37,6 +61,11 @@ static struct {
> =20
>  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
>  {
> +	if (is_tdx_vm(vm)) {
> +		ucall_x86_ops.do_ucall =3D ucall_tdx_do_ucall;
> +		ucall_x86_ops.get_ucall =3D ucall_tdx_get_ucall;
> +	}
> +
>  	sync_global_to_guest(vm, ucall_x86_ops);
>  }

[Severity: Medium]
As reported by Sashiko on v15 [1], since ucall_x86_ops is a process-wide
global structure in tools/testing/selftests/kvm/lib/x86/ucall.c:

static struct {
	void (*do_ucall)(gva_t uc);
	void *(*get_ucall)(struct kvm_vcpu *vcpu);
} ucall_x86_ops =3D {
	.do_ucall =3D ucall_x86_do_ucall,
	.get_ucall =3D ucall_x86_get_ucall,
};

does overwriting ucall_x86_ops in ucall_arch_init() when is_tdx_vm(vm) is
true without restoring the default handlers when !is_tdx_vm(vm) break tests
that create a non-TDX VM after a TDX VM (or run both concurrently) in the
same process?

If a non-TDX VM is initialized after a TDX VM via ucall_init() ->
ucall_arch_init(), sync_global_to_guest(vm, ucall_x86_ops) will copy
ucall_tdx_do_ucall into the non-TDX guest, causing the guest to execute
TDCALL and fault with #UD on its first ucall.

Similarly, on the host side, ucall_arch_get_ucall() dispatches through the
single global ucall_x86_ops.get_ucall pointer:

void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
{
	return ucall_x86_ops.get_ucall(vcpu);
}

so get_ucall() -> ucall_arch_get_ucall() will check for
KVM_SYSTEM_EVENT_TDX_FATAL instead of KVM_EXIT_IO for any non-TDX VM once a
TDX VM has been initialized. Should ucall_arch_init() restore the default x=
86
callbacks when !is_tdx_vm(vm) (or should ucall_arch_get_ucall() dispatch
based on is_tdx_vm(vcpu->vm))?

[1] https://lore.kernel.org/r/20261002091337.9BDF91F0089A@smtp.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tdx-selfte=
sts-v16-0-2024e8fa517a@google.com?part=3D19
