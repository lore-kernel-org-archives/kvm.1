Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37417421225
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720220; cv=none; b=iXVBTu2JcUi3cWXzJXErCWCdq/vnM+Taz0Tlgh94Ue0t8v/iLzlhYVEF09AXQsfaRkdymOXEN/rcgwGmEOT2kMlBtp7qdCkI8qqB8n+Gfft3v5axQ1A7rCO/Pw6b1fvRfQ8Dx7WPQd3lEZ/q+nhXxBvEHtxKXtVP6wA1qCGoQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720220; c=relaxed/simple;
	bh=bQkEpI2pubvPxSpYIk1qoH+WGtD+GVGT2wDhcdtJgMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XGuvkXpTTpH1vNVsuKIny6s6WEtS5TRhG31yDpP8bDhosZNyA2NAgwuqxuL/2/Si3UKNYUD+StqUkMgmGI+LbGS7PLw7+fIkrc9fIRR1KGGA6NssEx1nRAuWawGDcBW9Wk9qNpFoytcbh7wYszBlz7oi0BDAvzRNx46lonAJCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwfMmWLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwfMmWLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2001F0089B;
	Fri, 18 Sep 2026 08:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720218;
	bh=e8Ui1fgmXTxTFPsx5XJxlZx5CdVv+wOF6xUH9mDHDzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwfMmWLMklZvDA1wjhAHTxY7OHTcJ9DJurn1mrTeMf0e+5t2B94xyKd8YUNz9j5P1
	 xztxA78aMrinAevoSubAdHF04Orp6pqC3KmbniiBmxXHEvlYyltA4OA9WvVY52Lqll
	 FWZs0AdGCsALmlOWvKmOxZKLOI3xliYcWrdlhEIaAvVFda/GGtgxDTDplLqqPtiE7N
	 SD5iWG1ixFsz+jMMLRp9dojEMXfFBD65Hky1F/BOc15/vdzfwpiMvSPj63io29Tug0
	 jpjgn9SnNomK+GiFIxIWdgkRH8pr9zNNhbvqhdCAOVnW6DCN6a6BnzVFCYzttm4rkQ
	 PgkcV4c0Kf1TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/28] KVM: selftests: Test address translation for
 Hyper-V direct L2 hypercalls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-4-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:30:18 +0000
Message-Id: <20260918083018.8A2001F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/kvm: assertion failure in hyperv_evmcs test due to red=
undant vm_enable_ept()
--

commit 3101456ba54ccd614ac31b337348b4588da927e6
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: selftests: Test address translation for Hyper-V direct L2 hypercalls
   =20
Test that the TLB flush hypercalls, when executed by L2, translate their
input addresses through the guest's EPT or NPT.

> diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testi=
ng/selftests/kvm/x86/hyperv_evmcs.c
> index 63ea1533e4ead..fa80bc78aef70 100644
> --- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
> +++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c

[ ... ]

> @@ -212,6 +216,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm=
 *vm,
> =20
>  	/* Restore state in a new VM.  */
>  	vcpu =3D vm_recreate_with_one_vcpu(vm);
> +	vm_enable_ept(vm);

[Severity: Medium]
Does this redundant vm_enable_ept() call cause an assertion failure?

The hyperv_evmcs test periodically simulates live migration by calling
save_restore_vm(). This function calls vm_recreate_with_one_vcpu(), which
recreates the vCPU but preserves the existing kvm_vm object and its
initialized stage2_mmu configuration.

Calling vm_enable_ept(vm) here delegates to tdp_mmu_init(). Since
tdp_mmu_init() expects to run only once per VM, it checks:

    TEST_ASSERT(!vm->stage2_mmu.pgtable_levels, "TDP MMU already initialize=
d");

Because pgtable_levels was already set to 4 during the initial
vm_enable_ept(vm) call in main(), this assertion fails, crashing the test
unconditionally on the very first live migration cycle.

>  	vcpu_set_hv_cpuid(vcpu);
>  	vcpu_enable_evmcs(vcpu);
>  	vcpu_load_state(vcpu, state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D3
