Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D438F928
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721029; cv=none; b=b3PaCpnD882xGhSWYQzsLyxeFa4z4uyXwF69b/k/zLhkrSGAayikpDAaQZD9oHQcnSbocZXfWKte7/sg853MIABWOAXpvQxRTPHjeV0Rwfjcn6Da9nNc86TDTFv2Kw+yyeO2GufDtx8A83OhE0Pl7iCBJ2izrqGpv3V1SNe5eO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721029; c=relaxed/simple;
	bh=Iin3bc5hSW2YYSXIh4sa6DgOCcCAOK/m0hFqJs/10W0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3ivUR+RKnAtVNNUC6yYZ+CJUuvX12XFyvHHKOMXgGz/i2go+2FbjX9+WWTxUnnroFFg2pzSbJH0IgpLK2EDZHn2KMuIDMgY6wOo4//gSm+JUiNFpzq1+Bch9scbwC1tXofC1o0nw+leiLM8jdHBgSGNl8Bg1TBhd0uFhOdnQFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj7bH1uW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj7bH1uW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4408C1F000FF;
	Fri, 18 Sep 2026 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721027;
	bh=kAmS41jRFgdFYTqRaPrbA/x/vvDzCqhkIlWsHhhmjCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hj7bH1uWJhi2eD6j3q6aZrxIHguV17od6P6FfwLqHCzMbWU2OoDp2aiSnjHLqSp5y
	 O8xG/zKKq6+y8q7jbWGtrRiw5vdg31oPwATYp7SLHyVRvgu1XotEo0hv3mLENG3wz4
	 2wuKwTr9mg06DeVS8YbYV3as9Mi9JS+0Gbz+Iu+vG+xKstUObYqmJY/iWuAJAdwasn
	 EgmMd7S5b+5BWdi5dMBu2XjQaZIGk4FLJDFAxpBjFepdVTbSMccCIM5oY8Fiq/JjXR
	 yYhdmH2BPfhq8W/yEpGW8aU1kbM1OiTe4a9ID8xLk57+FBSsWgs2cZBQHF3nqodmfe
	 HHHFAg2nXbYuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/28] KVM: x86: selftests: Introduce memory
 attributes side-channel tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-29-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-29-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:43:46 +0000
Message-Id: <20260918084347.4408C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kselftests/kvm: Race condition in pvclock test causes deadlock
--

commit 80c207820949c9e59181f5bf084d4354741225e7
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: selftests: Introduce memory attributes side-channel tests

This commit introduces memory attributes selftests to catch side-channel
vulnerabilities. It exercises various guest memory access patterns to verify
memory attribute access restrictions are upheld.

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> --- a/tools/testing/selftests/kvm/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/memory_attributes.c

[ ... ]

> @@ -86,6 +122,14 @@ static void guest_code(void *data)
>  			arch_controlled_exec(vaddr);
>  			GUEST_SYNC(stage++);
>  			break;
> +		case TEST_OP_MONITOR_ADDRESS: {
> +			if (arch_controlled_read(vaddr) !=3D expected_val)
> +				GUEST_SYNC(stage++);
> +			break;
> +		}

[Severity: Medium]
Is there a risk of the guest loop getting stuck indefinitely?

In guest_code() under TEST_OP_MONITOR_ADDRESS, the guest spins and does not
trigger a VM-exit unless the value changes. If the host thread is blocked
from updating the expected value, this could cause a deadlock.

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/=
testing/selftests/kvm/x86/memory_attributes.c
> --- a/tools/testing/selftests/kvm/x86/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/x86/memory_attributes.c

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
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);

[Severity: Medium]
Could this asynchronous sequence lead to a permanent deadlock?

The vcpu_worker thread executes KVM_RUN, which acquires the vcpu->mutex.
Concurrently, the main thread calls vcpu_set_msr(), which triggers
KVM_SET_MSRS and also attempts to acquire vcpu->mutex.

If the worker thread schedules and acquires vcpu->mutex before the main
thread executes vcpu_set_msr(), the main thread will block indefinitely.
Consequently, the MSR is never set, the guest memory is never updated,
and the guest spin loop under TEST_OP_MONITOR_ADDRESS never sees the
updated value. KVM_RUN will thus never return, hanging the test.

> +	usleep(msecs_to_usecs(1000));
> +	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), 0);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
> +
> +	test_data->expected_val =3D pvclock->version;
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE=
_NW);
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, test_data);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);

[Severity: Medium]
This appears to have the exact same race condition leading to deadlock
as the first thread handoff earlier in test_side_channel_pvclock().

If the vcpu_worker acquires vcpu->mutex before the main thread can execute
vcpu_set_msr(), the test will hang waiting for an MSR update that will never
arrive.

> +	usleep(msecs_to_usecs(1000));
> +	TEST_ASSERT_EQ(pthread_tryjoin_np(vcpu_thread, NULL), EBUSY);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D28
