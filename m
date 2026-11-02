Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644899;
	b=kQ+iQWFE45CSOGBMgpf6ESR+lUeZbmIIYq6LVvuog4GSQ6P7I9UJ5B4ld62e3rGOagGZ
	 ovy5+EGJrj2h8hR9nzJl2BH7GPVGjynw6adx+glwRCTmNwR7vZhJgraixBqD39uLzJXS9
	 XS1fVN/d0ebDCKOZmsfs12By8WmjHKgxLNFHS8DH/1HlKciAlF/WnJAJjO1XSAHQSLw92
	 Nw9Po5ehNxkFnoxPTsxUTgM7yNoadDuNr88biCdy1Li5R6FI2Wx0d1Lk0WGsDuRfDf04V
	 3IvKKnNN3xB8MWce0p5VIFvmuLF0uG3pRSqC8fCLRuophEWpAQDzBaO7nwvWplvbCfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IL7oKKFS+gUX2Uvq8w2VjAhIBvm6nDPbExnkTTWNFGs=;
	b=XA3k/UmUr6/R18IvdwEnDzD6QLvSFLwzwo1zwcn3tn1dQ5nvnmEwmYw5Qh84RI2bQJyl
	 RD9tuDCYXDa6WVXheso9FjFkbRzQhRS8Rgj9/6gbjCacgqPOmX0xUISm18CjVsGSiDuI7
	 1fS8xoPRY2A28CXQO6W98xCzXegNOx660LucwPu/IH73057nMxinqP4h/9Rq3+OHFsyk7
	 PaheWD+90/GNjcdjH5fjs9deoZqkuucpSMvUUjCVfHK2Tyx9OjI1HseZPkzdOBHJS9hT8
	 FdJuLAkQ4GTAzz/ZIJ/6j6KMhpELMsgwRIcevFulIhU8K8aioA32seINPFR2TueLP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMdzhMsq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814F606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMdzhMsq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D9A1F00A16;
	Mon,  2 Nov 2026 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644899;
	bh=IL7oKKFS+gUX2Uvq8w2VjAhIBvm6nDPbExnkTTWNFGs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gMdzhMsq6wk51MZDogDt3kKyM5e9v4gOEK7KbTzPZpHdc/ymx5S6RWdoreYJCJVvb
	 0urk/9NyufEYlgR5gYCVPPyAUlLBoQwZq7QZI4oc3otOs38D0one87z7VKcScXIF71
	 0uAHrs1w4cOWv3iVotfMP7jLIsMYoQL8BeeC19J6gVvRT3uN6SPq0W4GigWCBZQSs/
	 a/OIrX38ZNhEuK9v5X5pb/FyHF0e8KEKAHSj8hrOhJ3LfTX5b9K2RU7YVWmExeoOba
	 jWfjUX3zOS3mtMyJCxNfrm5ZJ66e8ZXGf7GOyTTUHNByWgHNV3OiSQ1zr66APeBpvX
	 emsURLYCdHuCA==
Message-ID: <sashiko-outbox-193958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 44/45] KVM: x86: selftests: Introduce memory attributes
 side-channel tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-28-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-28-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:41:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing vcpu_force_vapic_update() in vapic side-=
channel test
- [Medium] KVM: selftests: pvclock side-channel test bypasses active gpc in=
validation
- [Medium] KVM: selftests: unconditional vcpu_set_hv_cpuid() in main() brea=
ks !HYPERV
--

commit d4f11e28c38cae048fc4237383806de4018441e7
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: selftests: Introduce memory attributes side-channel tests

This commit introduces x86 selftests to verify that guest-initiated KVM
operations accessing guest memory via kvm_read/write_guest(),
gfn_to_hva_cache, gfn_to_pfn_cache, and the guest page walker respect memory
attribute restrictions.

Link: https://patch.msgid.link/20260918135030.171564-32-pbonzini@redhat.com

> diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/test=
ing/selftests/kvm/memory_attributes.c
> index c5305b4f3dbe7..2883f6c772bee 100644
> --- a/tools/testing/selftests/kvm/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/memory_attributes.c

[ ... ]

> @@ -362,11 +407,15 @@ int main(int argc, char *argv[])
>  	test_mem =3D vm_alloc_pages(vm, pages);
>  	virt_map(vcpu->vm, MMIO_GVA, MMIO_GPA, 1);
>  	test_data =3D init_test_data(vcpu);
> +#ifdef __x86_64__
> +	vcpu_set_hv_cpuid(vcpu);
> +#endif

[Severity: Medium]
What happens on an x86_64 kernel built with CONFIG_KVM_HYPERV=3Dn?

In test_side_channel_hyperv_hypercall_inputs(), the test checks
kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI) so it can skip the Hyper-V subtest when
Hyper-V support is unavailable.

However, main() unconditionally calls vcpu_set_hv_cpuid(vcpu) ->
kvm_get_supported_hv_cpuid(), which invokes
kvm_ioctl(kvm_fd, KVM_GET_SUPPORTED_HV_CPUID, cpuid) and asserts success.
Because KVM_GET_SUPPORTED_HV_CPUID returns -EINVAL when CONFIG_KVM_HYPERV is
disabled, will this abort the entire test binary in main() before any tests
can run unless vcpu_set_hv_cpuid(vcpu) is guarded by a capability check such
as kvm_has_cap(KVM_CAP_SYS_HYPERV_CPUID) or
kvm_has_cap(KVM_CAP_HYPERV_SEND_IPI)?

> diff --git a/tools/testing/selftests/kvm/x86/memory_attributes.c b/tools/=
testing/selftests/kvm/x86/memory_attributes.c
> index 12395feb6ac7a..36e788be0e05d 100644
> --- a/tools/testing/selftests/kvm/x86/memory_attributes.c
> +++ b/tools/testing/selftests/kvm/x86/memory_attributes.c

[ ... ]

> +/*
> + * Setup the vapic address on a GPA that is write-protected. Force an va=
pic
> + * update and validate its contents were not changes. Then, lift the wri=
te
> + * restriction and validate the page's contents are updated.
> + */
> +static void test_side_channel_vapic_addr(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vm *vm =3D vcpu->vm;
> +	gva_t vaddr =3D vm_alloc_page(vm);
> +	gpa_t paddr =3D addr_gva2gpa(vm, vaddr);
> +
> +	vm_set_vapic_addr(vcpu, paddr);
> +	test_data->op =3D TEST_OP_READ;
> +	test_data->vaddr =3D vaddr;
> +	test_data->confirm_read =3D 1;
> +	test_data->expected_val =3D ~0ULL >> 32;
> +	memset(addr_gva2hva(vm, vaddr), 0xff, sizeof(uint32_t));
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE=
_NW);
> +	vcpu_run_and_inc_stage(vcpu);
> +
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, 0);
> +	vcpu_force_vapic_update(vcpu);
> +	test_data->expected_val =3D 0ULL;
> +	vcpu_run_and_inc_stage(vcpu);

[Severity: Medium]
Should vcpu_force_vapic_update(vcpu) also be called before the first
vcpu_run_and_inc_stage(vcpu) while KVM_MEMORY_ATTRIBUTE_NW is set?

In arch/x86/kvm/x86.c, vcpu_enter_guest() only calls
kvm_lapic_sync_to_vapic(vcpu) when KVM_REQ_EVENT (or an interrupt window) is
pending:

	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
	    kvm_xen_has_interrupt(vcpu)) {
		++vcpu->stat.req_event;
		...
		if (kvm_lapic_enabled(vcpu)) {
			kvm_lapic_update_cr8_intercept(vcpu);
			kvm_lapic_sync_to_vapic(vcpu);
		}
	}

Neither vm_set_vapic_addr() (KVM_SET_VAPIC_ADDR) nor
vm_set_memory_attributes() (KVM_SET_MEMORY_ATTRIBUTES) sets KVM_REQ_EVENT on
the vCPU. Without calling vcpu_force_vapic_update(vcpu) before the first
vcpu_run_and_inc_stage(vcpu), won't kvm_lapic_sync_to_vapic() be skipped on
that entry, allowing the write-protected check to pass even if
kvm_write_guest_cached() did not honor memory attributes?

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
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
> +
> +	test_data->expected_val =3D pvclock->version;
> +	vm_set_memory_attributes(vm, paddr, vm->page_size, KVM_MEMORY_ATTRIBUTE=
_NW);
> +	vcpu_set_msr(vcpu, MSR_KVM_SYSTEM_TIME_NEW, paddr | 0x1);

[Severity: Medium]
Does deactivating MSR_KVM_SYSTEM_TIME_NEW before setting
KVM_MEMORY_ATTRIBUTE_NW prevent this test from exercising invalidation of an
already-active gfn_to_pfn_cache?

Writing 0 to MSR_KVM_SYSTEM_TIME_NEW calls
kvm_gpc_deactivate(&vcpu->arch.pv_time), which clears gpc->valid and
gpc->active before vm_set_memory_attributes() updates the attributes. When
paddr | 0x1 is subsequently written to MSR_KVM_SYSTEM_TIME_NEW,
kvm_gpc_activate() -> __kvm_gpc_refresh() runs synchronously during
KVM_SET_MSRS, sees KVM_MEMORY_ATTRIBUTE_NW already in place, updates
gpc->attrs_generation to the current generation, and marks gpc->valid =3D f=
alse.

As a result, when vcpu_worker enters the guest and kvm_setup_guest_pvclock()
calls kvm_gpc_check(), the cache is already invalid and its attrs_generation
already matches the VM's generation. Would keeping the cache active across
vm_set_memory_attributes() (or writing paddr | 0x1 to MSR_KVM_SYSTEM_TIME_N=
EW
to queue KVM_REQ_GLOBAL_CLOCK_UPDATE before calling
vm_set_memory_attributes() with KVM_MEMORY_ATTRIBUTE_NW) better test that
kvm_gpc_check() detects the generation mismatch on an active, valid cache?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D44
