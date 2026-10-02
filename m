Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16092471CF5
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932416; cv=none; b=qwjPYCT/f0mJQ0qoANiGqqLPYFOKnTv5Oa7yuUkHze12WGuLY5Tv+OUNpjYu0rBjBY5m3KNzaF5KhcZIUioe6FGkQg/b2zjJXRTnyxcKt0YlU9GBW7VEu73W82Z05bklevwkKazXTbI0eY5H0nXKw9itbxpNktK5onOtmGelxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932416; c=relaxed/simple;
	bh=Ayb10gn4I+8o4Oz/pX7jNNsLN0IiVdVxX8PsW2le/SI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUaYYyRdbD1toc3xMCoqAEUwdhufKcYWqLNmhUKuZdpkQedE9uBneIcVcAoCtmaqDS/k0hk8s/NRWhVQEnnwv9Iy44AhVSNe7W25mQor4rYEd8+Y1wWuepe26aCVwP6/umXdaOmZE8+8Tijj/MXa7erXYAxJ9oJlNWeuR0A/q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ2vwA4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ2vwA4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E821F00899;
	Fri,  2 Oct 2026 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932415;
	bh=F3jfgPEVfZhZeiyG6BH74yFfJTfXHZVhGUzjEjUFadQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQ2vwA4PV//uJhoJcsgpr3bczf2SIKIzw/W6Gvn63gNtn2E/5SZ+0k15s2e5GImaz
	 dcmf9XACHEcx3wqN+C5vM1QLxBIEK9F6N8iymXOcI72ds6ovuxQ9coapdSTBGAsZp9
	 cGlwzoNIZlchVlOpWkYfE3sWAOPXNdlacPto9jOhZMZAWCK6pFiJV2rKgZ+zeOLt4r
	 TxnrF4Q1Imi+m6LEVftCJjKIXhgqLfWl0fAOe+SaVEOL52vh8idojIlYCBl6Guig12
	 yITOjbsQJnXc8kKutPeKzE2zvgrdWt8366OmRb62RX/777YUyKiZFq3lWrxYyDa87p
	 vk4qas/YKaxqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 21/23] KVM: selftests: Add support for per-VM ucall
 ops on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-21-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-21-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:34 +0000
Message-Id: <20261002091334.D2E821F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: selftests: host-side ucall_x86_ops is a process-wide global=
, breaking multi-VM isolation
--

commit abf66b381d3f3c93b178cddc07865810aae03f24
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add support for per-VM ucall ops on x86

This commit introduces a layer of indirection for x86 ucall operations to
support TDX VMs. It replaces hardcoded ucall functions with an operations
structure that can be customized.

> diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/=
selftests/kvm/lib/x86/ucall.c
> index 38050c60a0670..c003df3c7b8a8 100644
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

[Severity: Medium]
The commit message mentions adding support for per-VM ucall ops, but
ucall_x86_ops is defined as a static global variable. Doesn't this mean it
will act as a process-wide shared variable on the host side, rather than
being isolated per-VM?

If a selftest process initializes a TDX VM (which presumably overrides
these operations) followed by a non-TDX VM, or runs multiple VMs
concurrently, will the non-TDX VMs incorrectly end up using the TDX ucall
callbacks?

> +
> +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> +{
> +	sync_global_to_guest(vm, ucall_x86_ops);
> +}
> +
> +void ucall_arch_do_ucall(gva_t uc)
> +{
> +	return ucall_x86_ops.do_ucall(uc);
> +}
> +
> +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> +{
> +	return ucall_x86_ops.get_ucall(vcpu);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D21
