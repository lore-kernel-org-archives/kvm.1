Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F54AE8B6
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154759; cv=none; b=SnQFnQtmouYIL1yAeMWD3n+ZeBjrMrMyaQJGUwbCYiXQ7oCyY7m8kCoopoVeTcJi7MW/bHNfIgz27iQ6p9nN1tlxjBCubh2I0FVbgdmUkQZ43hCkqi7nAd8uad1EINntkykaytyEI6rPC1mq5dbEujWH9zB4RDmsZ3krPxImlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154759; c=relaxed/simple;
	bh=Adryl4pH6KZ04DlLJoEbbpSzn1wDl5I0zLXPzW98eRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCYbjX3HlmzjD5PsK+IoLQZV1LPYxVCWiEC0SpKVt+VYSqAHcGBrzwqFfGg3xuGYtBGFOwQKZmPFgUBiGPfHuuoboxLXIOBP82AqpJdXjs26gQoD3D+OlCUIuvFCF24jsnX9nNDOrtUkedYpAWUHtOkQI/nLtLnSkxdkA4YnkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7iqsp2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7iqsp2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F77D1F00898;
	Fri, 11 Sep 2026 19:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154750;
	bh=VwmDxQwDQH7gYKj0HMvokmhcRDK630d7ThfINJT597k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7iqsp2ZdTiAQTVit6F9Ta8F6UzzOP9f8vx1MXuxjhGq/U5ZBI/Z3Puea4ihAbGEf
	 oHEBBdfRWed3k34Emcm//NDhakJ4yjZJPD2gTlV0p2Oen88jmjN/+m4F+3Tuxkjq4g
	 00eXGdGOWLNgqDco+lN0NNqo7ts0h4Q7xEZkFwo5a/L1Z8+xNRVwYne4Twmhp1MgVH
	 Bxxd/PJ4gGsM9Hr+z588WX+iH34/C8WsQauWynMU7/cEUmxq4cDFf0Sw7v2w/VY2so
	 ptMOswtSWgGZefVDO+1t437uA6YSOZw9ri88Xfqs7r4xrW/vI+Ct/8sczsuCh4FQZ1
	 ro9s6yRg0boBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: Add test for shadow VMCS flush during
 vCPU teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911191011.528460-1-jmattson@google.com>
References: <aqREBvLRKgD5cGgk@google.com>
 <20260911191011.528460-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:25:50 +0000
Message-Id: <20260911192550.6F77D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Virtual address collision causes `mmap` with `MAP_FIXED_NOREPLAC=
E` to fail, preventing the test from running.
- [Low] The test invokes an undefined function `vm_userspace_mem_region_add=
_caller_managed()`, causing a compilation error.
- [Low] The function `prepare_vmcs` is called with three arguments, but it =
is declared to take only two.

Pre-existing issues:
- [Critical] Cross-process memory corruption during nested VMM teardown due=
 to guest memory write from lazy TLB address space.
--

commit 7a55753773b4f88412b975373e87f2ed41cc10a0
Author: Jim Mattson <jmattson@google.com>

KVM: selftests: Add test for shadow VMCS flush during vCPU teardown

This commit adds a selftest to verify KVM's behavior when a vCPU is
destroyed while L2 is active and VMCS shadowing is enabled. It attempts
to trigger a race condition where the nested VMM terminates and flushes
the shadow VMCS12 into a victim process's address space.

> When a vCPU is destroyed while L2 is active and VMCS shadowing is
> enabled, KVM synthesizes a nested VM-Exit. This flushes the cached
> shadow VMCS12 back to guest memory. However, on process exit, do_exit()
> calls exit_mm() before closing file descriptors. KVM teardown runs
> with current->mm =3D=3D NULL on a borrowed lazy TLB active_mm.
> Consequently, nested_flush_cached_shadow_vmcs12() writes the shadow
> VMCS12 into whatever address space is active on that CPU.

[Severity: Critical]
This is a pre-existing issue, but this text describes a cross-process
memory corruption vulnerability during nested VMM teardown. When KVM
destroys a vCPU via kvm_arch_vcpu_destroy() calling vmx_leave_nested(),
it synthesizes a nested VM-exit. This flushes the shadow VMCS to guest
memory via kvm_write_guest_cached().=20

Because VMM teardown runs during do_exit() after exit_mm() sets
current->mm to NULL, kvm_write_guest_offset_cached() invokes
__copy_to_user() using the host virtual address on the borrowed active_mm
of whatever process previously ran on that CPU. If the HVA maps to valid
memory in the victim process, __copy_to_user() will silently overwrite it
with KVM's shadow VMCS data. Is there an upstream fix planned for this
underlying KVM vulnerability?

> diff --git a/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_tes=
t.c b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_shadow_vmcs_teardown_test.c
[ ... ]
> +static void l1_guest_code(struct vmx_pages *vmx_pages)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +
> +	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
> +	GUEST_ASSERT(load_vmcs(vmx_pages));
> +
> +	/* Prepare the VMCS for L2 execution. */
> +	prepare_vmcs(vmx_pages, l2_guest_code,
> +		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);

[Severity: Low]
Does this function call cause a build failure? The prepare_vmcs()
function is declared in the KVM selftests headers to take only two
arguments (struct vmx_pages *vmx, void *guest_rip), but it is being
called here with a third argument for the guest stack.

[ ... ]
> +static void run_vmm(int pcpu, void *target_hva, int c2_to_c1_fd)
> +{
> +	vm_vaddr_t vmx_pages_gva;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct vmx_pages *vmx;
> +	void *shadow_hva;
> +
> +	pin_self_to_cpu(pcpu);
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, l1_guest_code);
> +
> +	/* Allocate VMX pages and shared descriptors. */
> +	vcpu_alloc_vmx(vm, &vmx_pages_gva);
> +	vmx =3D addr_gva2hva(vm, vmx_pages_gva);
> +
> +	/*
> +	 * Map the shadow VMCS page at the exact target_hva allocated by the
> +	 * victim so it collides with the victim process's mapping.
> +	 */
> +	shadow_hva =3D mmap(target_hva, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +			  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE, -1, 0);
> +	TEST_ASSERT(shadow_hva =3D=3D target_hva, "mmap target_hva failed in VM=
M");

[Severity: Medium]
Will this mmap() call reliably fail with EEXIST and prevent the test from
running? Because the VMM and victim processes are forked from the same
parent and share identical ASLR bases, the victim's earlier mmap grabs
the highest available virtual address as target_hva.=20

When run_vmm() calls vm_create_with_one_vcpu() earlier in this function,
it makes its own large guest memory allocations using mmap(). Since mmap()
allocates top-down, the VMM's allocation is likely to overlap or envelop
target_hva before we reach this MAP_FIXED_NOREPLACE call.

> +	memset(shadow_hva, 0, PAGE_SIZE);
> +
> +	/* Add a caller-managed memslot for the shadow VMCS backing page. */
> +	vm_userspace_mem_region_add_caller_managed(vm, shadow_hva,
> +						   SHADOW_VMCS_GPA, 10, 1, 0);

[Severity: Low]
Does this result in a compilation error? The function
vm_userspace_mem_region_add_caller_managed() does not appear to be defined
anywhere in the KVM selftests codebase.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911191011.5284=
60-1-jmattson@google.com?part=3D1
