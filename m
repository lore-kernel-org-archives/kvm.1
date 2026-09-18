Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689644EE86E
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743417; cv=none; b=fSbsQwx08EmfPmPh7N+hXTnbxv0wxeLPPiAqEoQRHFT/9Nkulv917z3QLpfnlafzz+aVN/4RIEfzbLqqYE8Lpy02oWlCzW6J+rX+3IPLM2n3Sk+lnS3WwGukYrkFItTLKvqslQih59kA9hOoG3upjT/92je9y9iwkrv14yrhXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743417; c=relaxed/simple;
	bh=9vBULcYEKsTxDqYnEWJxGmJvdu0qn93TJm0l9Mffv+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JNGPc8gaz8YuNIhmOEYaezfu+TINLi6Oo85Azcc/XvTluJ2IiYk4bWtP4ubXp4hrbK3YW3DcVpzcGmNtvSdn28xnwfOfOs+2hO8I6xVuza3CNaSEgPPD7qRAJ9F4vye2Yw49QFVYwTUXW6I9kJd7O8oWI7Xdoc4y5cbGyZySJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8ov419w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8ov419w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD35D1F000FF;
	Fri, 18 Sep 2026 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743414;
	bh=UEediM5y64jeP0DQ8AYMvWgM/HxHXbhxj8vJEZK2k14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8ov419wC/YYqgkkUaedaSh7fWTMOE4bGZAXUY9ZGCm7NGBloA2lQWJDdAOfFaMzF
	 3pfwv1iYRK23iTaJ4hAKA95WjmoLVZG13y3d0lA+6CxgiBVtIFbCRWQk73o2Sa8CHu
	 rG6fAovKrbwJEgSNW39TFdRJHFbLag48ZOEdyeqPfXjwYFWtG4MTLV2zEH1buUePGh
	 5tYjs3e3j7dTXrRL8FJI6vFPLlA6KvB1xsQRq3yRwmz/X8NR6N/X6zeEzQDgqa+Psz
	 822Geyrsbh54RfPw0T6PWJDbEe2oL31TU12GzrbJ7M5PHM9O3If2CKb/IHdkonAr3f
	 S6pW0W6jPJ70Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 31/31] KVM: x86: selftests: Introduce memory attributes
 side-channel tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-32-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-32-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:56:54 +0000
Message-Id: <20260918145654.BD35D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kselftests: race condition in pvclock test using usleep() for sy=
nchronization
--

commit 9a779483841fdb39484cbe06ffba510ee690c56e
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: selftests: Introduce memory attributes side-channel tests

This commit introduces memory attributes selftests to catch vulnerable
side-channels. It validates that KVM operations requiring memory access
properly account for memory attributes across various use cases.

> diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/=
testing/selftests/kvm/x86/memory_attributes.c
> --- a/tools/testing/selftests/kvm/x86/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/x86/memory_attributes.c
[ ... ]
> @@ -181,3 +192,224 @@ static void arch_test_memory_access_pte(struct kvm_=
vcpu *vcpu, gva_t vaddr)
[ ... ]
> +static void test_side_channel_pvclock(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vm *vm =3D vcpu->vm;
> +	gva_t vaddr =3D vm_alloc_page(vm);
> +	gpa_t paddr =3D addr_gva2gpa(vm, vaddr);
> +	struct pvclock_vcpu_time_info *pvclock =3D addr_gpa2hva(vm, paddr);
> +
> +	pvclock->version =3D 0;
> +
> +	test_data->op =3D TEST_OP_MONITOR_ADDRESS;
> +	test_data->vaddr =3D vaddr + offsetof(struct pvclock_vcpu_time_info, ve=
rsion);
> +	test_data->expected_val =3D pvclock->version;
> +
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
> +	usleep(msecs_to_usecs(1000));
> +	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), 0);

[Severity: Medium]
Does this test rely on a hardcoded 1-second timeout for synchronization?

On heavily loaded CI systems or nested virtualized environments, vCPU
scheduling and the pvclock update can easily exceed 1 second. This could
cause pthread_tryjoin_np() to fail unexpectedly and create a false positive
regression.

Similarly, when waiting to confirm the vCPU does not exit in the second part
of this test, a slow system might simply not have scheduled the thread yet,
leading to a false negative pass even if memory was erroneously updated.

> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
> +
> +	test_data->expected_val =3D pvclock->version;
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE=
_NW);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
> +	usleep(msecs_to_usecs(1000));
> +	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), EBUSY);
> +
> +	/* Force the 'monitor_address' guest operation to finish */
> +	test_data->op =3D TEST_OP_NOP;
> +	TEST_ASSERT_EQ(pthread_join(vcpu_thread, NULL), 0);

[Severity: Medium]
Is a WRITE_ONCE() missing when assigning test_data->op?

The test_data->op variable is polled concurrently by the guest vCPU thread
via READ_ONCE() in guest_code(), so using a plain assignment here violates
standard lockless concurrency patterns.

> +	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D31
