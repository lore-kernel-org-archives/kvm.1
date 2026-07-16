Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86033D6F8
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228101; cv=none; b=eQZuXfqlOySSVZJaR6CGqO6bgTQg4XX+bWxz7QwMtmk0HvFTpykL0IJhlRiz5Va7MWWUTiiQ8AGDapOGAEaDOVa8XBsZervcBCj2CvRxEY3nCWlKuIEfn24f9HslbrMY+yJm39EX1lteOM/UzbKul3EW7aXNHtxL4Op2F5d9OXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228101; c=relaxed/simple;
	bh=sp/6DpII1XKCu8RCOdLqknqYu7IfAsXwYu1fZRGnkuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X98hc9ktxjg7yU7el6bL7MYzoQRKtGvdrGtpMKDFL3UZFDAZcUVjAhYeAjwYkYxY85PQXGlu95nHMqFX3boNxC5j4+S6aOtEUagdpSjYiH68SxibBMCM4NRIHlZtuFcZprsw1Bj/2CncFZbo4zqr+0zUBsOhRDUwCEJw41/JVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgH29TuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgH29TuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90A31F000E9;
	Thu, 16 Jul 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784228100;
	bh=CurTDQoK61XVqJ7KNWgdGmwUjEdFArQ9DOwxbr5fykc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GgH29TuQSMaC81B34Wtxv3LpRHH1rp+m2L+Qj41MYciSSi9nwEQ1svnYD3W5MWLF5
	 uYJnqy1wuiz4pHDguzj6p0IwSdKvZa8abk+7WzrRAwROnkppYPv7DTWaBVB1uzhdRp
	 oklKvIp/1CFrbPjsSgoLo5AGvWYYvZd/cWfG8/jNRLSoQ8DsppT+flqXqg5TI0Hzfm
	 ac6BaXltzTaUNle8QvqacVBguRYtoWeI6xGJaGj1CKCiuT01J3HYJ6uwIGEfWUNR+U
	 2WmJelDZQ7MpGkpIS70o1udQyUCGnT5lihaDq0FjmNlb7DIWo1SAqmxR1fm1kobGYt
	 k7DFJ8VBF47HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/24] KVM: x86: selftests: Introduce memory attributes
 side-channel tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716181456.402786-25-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
 <20260716181456.402786-25-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:54:59 +0000
Message-Id: <20260716185459.E90A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] `test_side_channel_pvclock` assumes KVM periodically updates `ts=
c_timestamp` in the background, which is false and causes the guest to hang=
 indefinitely.
- [Medium] `test_side_channel_hyperv_hypercall_inputs` fails to zero-initia=
lize the `struct hv_send_ipi_ex` object in reused guest memory, causing the=
 hypercall to fail.
- [Low] `test_side_channel_hyperv_hypercall_inputs` computes the physical a=
ddress using stale `test_data->vaddr` instead of the passed parameter.
- [Low] `vcpu_translate()` passes a partially uninitialized `struct kvm_tra=
nslation` to the KVM ioctl.
--

--- Patch [24]: [PATCH 24/24] KVM: x86: selftests: Introduce memory attribu=
tes side-channel tests ---
commit 4f5cb036a6a68d87d1e673199973b66af14cd6a4
Author: Nicolas Saenz Julienne <nsaenz@amazon.com>

KVM: x86: selftests: Introduce memory attributes side-channel tests
   =20
Introduce memory attributes selftests to catch any vulnerable
side-channels.

> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testi=
ng/selftests/kvm/include/kvm_util.h
> index 54d73ea46e11f..3160a25966a10 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -883,6 +883,16 @@ static inline int vcpu_get_stats_fd(struct kvm_vcpu =
*vcpu)
>  	return fd;
>  }
> =20
> +static inline struct kvm_translation vcpu_translate(struct kvm_vcpu *vcp=
u,
> +						    u64 gva)
> +{
> +	struct kvm_translation tr;
> +
> +	tr.linear_address =3D gva;
> +	vcpu_ioctl(vcpu, KVM_TRANSLATE, &tr);

[Severity: Low]
Does this pass uninitialized stack memory to the kernel?

Since only linear_address is initialized, the remainder of the struct conta=
ins
uninitialized stack memory. When the kernel reads the struct via
copy_from_user(), it will read this uninitialized memory, which can trigger
MemorySanitizer or Valgrind failures in CI environments.

Should this struct be zero-initialized first?

> +	return tr;
> +}
> +
>  int __kvm_has_device_attr(int dev_fd, u32 group, u64 attr);

[ ... ]

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> index c66d5d085a9c1..843fafcf4d96d 100644
> --- a/tools/testing/selftests/kvm/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/memory_attributes.c

[ ... ]

> @@ -88,6 +125,25 @@ static void guest_code(void *data)
>  				     :: "b" (vaddr): "memory");
>  			GUEST_SYNC(stage++);
>  			break;
> +		case TEST_OP_HYPERV_HYPERCALL_INPUT: {
> +			hyperv_hypercall(HVCALL_SEND_IPI_EX, paddr, 0);
> +			asm volatile ("sti; hlt; cli;");
> +			GUEST_ASSERT_EQ(ipis_rcvd, 1);
> +			GUEST_SYNC(stage++);
> +			break;
> +		}
> +		case TEST_OP_MONITOR_ADDRESS: {
> +			uint64_t *pval =3D (uint64_t *)vaddr;
> +			uint64_t val =3D READ_ONCE(*pval);
> +
> +			while (READ_ONCE(*pval) =3D=3D val &&
> +			       /* So host can force the op out of the loop */
> +			       READ_ONCE(test_data->op) =3D=3D TEST_OP_MONITOR_ADDRESS)
> +				asm volatile("nop");

[Severity: Medium]
Can this loop hang the guest indefinitely?

In test_side_channel_pvclock(), the guest is expected to exit this loop when
the pvclock tsc_timestamp changes. However, KVM only updates the pvclock
structure synchronously before entering the guest (e.g., when processing
KVM_REQ_CLOCK_UPDATE).

Since the guest is spinning here without causing a VM-exit, KVM never gets a
chance to process clock updates, tsc_timestamp will never change, and the h=
ost
thread will time out waiting in pthread_tryjoin_np().

> +
> +			GUEST_SYNC(stage++);
> +			break;
> +		}
>  #endif

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/=
testing/selftests/kvm/x86/memory_attributes.c
> index 3d2bcfe718848..5203d284d2d36 100644
> --- a/tools/testing/selftests/kvm/x86/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/x86/memory_attributes.c

[ ... ]

> +static void test_side_channel_hyperv_hypercall_inputs(struct kvm_vcpu *v=
cpu,
> +						      gva_t vaddr,
> +						      size_t size)
> +{
> +	struct kvm_vm *vm =3D vcpu->vm;
> +	struct hv_send_ipi_ex *ipi_ex =3D addr_gva2hva(vm, vaddr);
> +	gpa_t paddr =3D addr_gva2gpa(vm, test_data->vaddr);

[Severity: Low]
Does this use stale global state instead of the vaddr parameter?

Using test_data->vaddr here before it gets updated for this test phase reli=
es
on it holding a left-over value from the previous test run. Should this use=
 the
vaddr parameter passed into the function instead?

> +
> +	if (!kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI) ||
> +	    !kvm_has_cap(KVM_CAP_HYPERV_HCALL_FAULT_EXIT))
> +		return;
> +
> +	vm_enable_cap(vcpu->vm, KVM_CAP_HYPERV_HCALL_FAULT_EXIT, 1);
> +
> +	ipis_rcvd =3D 0;
> +	vm_install_exception_handler(vm, IPI_VECTOR, guest_ipi_handler_hv);
> +	vcpu_set_msr(vcpu, HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
> +
> +	ipi_ex->vector =3D IPI_VECTOR;
> +	ipi_ex->vp_set.format =3D HV_GENERIC_SET_ALL;

[Severity: Medium]
Will this hypercall fail due to an uninitialized reserved field?

The struct hv_send_ipi_ex object is mapped over previously used guest memory
(vaddr). Because the reserved field isn't initialized here, it will contain
garbage data left over from prior tests.

The KVM handler for HVCALL_SEND_IPI_EX explicitly checks that reserved =3D=
=3D 0 and
will return HV_STATUS_INVALID_PARAMETER otherwise, causing the test to fail.

Should the struct be cleared using memset() first?

> +	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE=
_NO_ACCESS);
> +	test_page_restricted(vcpu, TEST_OP_HYPERV_HYPERCALL_INPUT, vaddr, paddr,
> +			     KVM_MEMORY_EXIT_FLAG_READ);
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716181456.4027=
86-1-pbonzini@redhat.com?part=3D24
