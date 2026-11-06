Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923341;
	b=pFXrVXbx9NQoJm5WmC04M2Q/cRM3Hr4lBXA1XEbpquGwfU/AOD1bkGWgjH2a8O34FAso
	 sRnmqCPLNTikk1JSCkmJ+vjD9yAv/EAnxRfWvSFnoJ0pW7XHmdp6cVKDOcPtmEpkqFGhO
	 A1Uf9ZmsZxc3FMkL1aAnRj5Q2/wkb4KAZKlasypabhcMBBiZZQxOVk/mp3QaVm+fildjn
	 uUw+Zah5/3fIsiY6BWBemXnYIuwjd+xvOtprRHrchz/3tumdqitjtcPN9O8kPg7V/O5Fv
	 TTjFnUbupVeWpYTB0NyXMeJ/SSwgMoFV3DKnEU3A4s84QFp3qD3GfwZcCsNmIK6D+yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923341;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+NrV6CTksTWywaU/midbwZSwrMVXpRkXrikI3Bvwx0=;
	b=X3qhqI1pCKD1MuXvkJeRvlIqqYdgp+56fqu16rHCDuEf9sd5EpuG6awGvau8VDRSY+Ho
	 vYe2Vgl0Mzxu11ldc3WpOUwLi80zqSV7V35p7jBAcnVRn3IllmSLVgXoO0dIMRxet6OpS
	 jygZwpSIa7DZqrA4YuKyb+uoAlewBQ/JedoYok0i7NkQJnXP4xZoRAv5e0qnfjwkVkTU9
	 +FeGqhXLnU8Ho7VcuU6G9KlbD5F7rAzq3cSNtjT6qoXErC5Tjni78yZEgOyy/YwTiJYOm
	 0lna+opNIx7Y9zqCc8Mqir9+bYV2Jen4W87EkudhdW6qfgIcRJYCRV4kYU8dPdmRBRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBa+ReuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF12A606A332
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBa+ReuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E2D1F008A1;
	Fri,  6 Nov 2026 00:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923340;
	bh=5+NrV6CTksTWywaU/midbwZSwrMVXpRkXrikI3Bvwx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBa+ReuA08lIEXD7cFd0dx3BqO3QlvN5+VZJODQai0hxoptPRhhsmVpoKtDSMTTVV
	 /jaD4u/mEJeJfZ6Rv2xIxTgR1h/+eJixFHdr4fZW6AoND2uGQoNut20EA9Utqua8hg
	 1IQcMmXPBAEc52rW+mMlR+wtsjr4yglpx6RmP6LmC9mpMaRWmzIVhtK6XSSTAE+K3F
	 JkKi8ZFCbPKzn7ujPfsEwr1WvBF7B9gsre2tENEAo62LbSskGw8jRP2CR++pS+SJx/
	 KutHPb56dF+0SyeVi0Dp/O3O1dUjiqWXwGa/jjbzJ6YUjsQnzNu4/OPtJsYqGcp0e/
	 tlLruCcYECRKw==
Message-ID: <sashiko-outbox-200423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 18/20] KVM: selftests: Add support for per-VM ucall
 ops on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:02:20 +0000
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
- [Medium] KVM: selftests: ucall_x86_ops is a host global instead of per-VM=
 state
--

commit 220d73be4cec0aafb094f8711c312a5a8ae361c9
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add support for per-VM ucall ops on x86

This commit introduces an ops structure for x86 ucall handling so that
different VM types, such as TDX VMs, can wire up their own do_ucall and
get_ucall callbacks.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index 38050c60a0670..3aec4dd46d1b2 100644
> --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
[ ... ]
> @@ -26,3 +26,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
>  	}
>  	return NULL;
>  }
> +
> +static struct {
> +	void (*do_ucall)(gva_t uc);
> +	void *(*get_ucall)(struct kvm_vcpu *vcpu);
> +} ucall_x86_ops =3D {
> +	.do_ucall =3D ucall_x86_do_ucall,
> +	.get_ucall =3D ucall_x86_get_ucall,
> +};
> +
> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> +{
> +	sync_global_to_guest(vm, ucall_x86_ops);
> +}
> +
> +void ucall_arch_do_ucall(gva_t uc)
> +{
> +	ucall_x86_ops.do_ucall(uc);
> +}
> +
> +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +	return ucall_x86_ops.get_ucall(vcpu);
> +}

[Severity: Medium]
As reported by Sashiko on v15 [1], ucall_x86_ops in
tools/testing/selftests/kvm/lib/x86/ucall.c is defined as a single
process-wide static variable on the host rather than per-VM state.

While ucall_arch_init() uses sync_global_to_guest(vm, ucall_x86_ops) to copy
the structure into each guest VM's private address space for guest-side
ucall_arch_do_ucall() execution, ucall_arch_get_ucall() executes on the host
and dispatches through the single host-side ucall_x86_ops.get_ucall pointer
instead of per-VM state associated with vcpu->vm.

In the following patch ("KVM: selftests: Add support for TDX ucalls, via
TDVMCALL_REPORT_FATAL_ERROR"), ucall_arch_init() mutates the host
ucall_x86_ops in place when is_tdx_vm(vm) is true without restoring the
default x86 callbacks when is_tdx_vm(vm) is false. If a selftest process
creates a TDX VM via __vm_create() -> ucall_init() -> ucall_arch_init() and
concurrently or subsequently creates and runs a non-TDX VM, won't the
non-TDX VM inherit the TDX ucall callbacks both in guest memory and on the
host in get_ucall() -> ucall_arch_get_ucall()?

[1] https://lore.kernel.org/r/20261001-tdx-selftests-v15-21-7c62a5d8a992@go=
ogle.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tdx-selfte=
sts-v16-0-2024e8fa517a@google.com?part=3D18
