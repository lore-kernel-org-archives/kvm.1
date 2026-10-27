Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109792;
	b=BKLgyb283hCT1eEc2jXiUUtjjwM3eVdTkYM4UBA7tmtf+tUKvgV3f7SogCQiuh+l56s5
	 XQ3iTnvZdHo8b4HU77kAz51Ap3KC8785uGPbc3DlRiJH4QvACCZXSJT29YVZB1vK1J3n6
	 SGVxFCqXAhDYT8MRbenT2lqSctkDdIaCZ8wt7u2hklHrU99oOvuoAY1x6kmj2J7YSwZ3x
	 qvI6w9rPNfVRWjugnR+F+M/QorU+TJBW8uukv6lQjRRqdyFkzLWJLVizhbmJgmgcoyk03
	 wX5yW0GSikomAYpELDgXObQNza78uOQehiTghb/Jf8QrI3CLBYdUg+XN7XWts7nSVpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DTTiS0pNazMw6mWdWB2LwKhmSIo7YOFDb57SqsIydHQ=;
	b=bB3hFWuSzvWImqTyr8cdez9dkJdwOey3BLUuFiYr/OQk98hVQToesQYGZeOnW3jpNlQG
	 9JDuy4u07llJVhP09Ml7r5pb6XhDFzmC8m1ZKcDv332tidr3KBAZk8GuP5j/58ybuQlqb
	 /opMO5ghmk+mifmds9PnP8UpCWlmF8XJkwOTTHJJ484WsaNqYvBd2/XeVpxONfc3MhJTF
	 /9H9Qn/4ubDcDiDr3Qpsldc2NL77NiGvfHixERwKQvgLLQUpPwd56wsFyy1mUeznIqEtN
	 2srCI/TZlG5lwCIY8S8hwkxATrfSNevMdYmgTIQsgIZk786zQJtDHCC8N6UUdqvcBfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMRZdCye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7851A606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dMRZdCye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2711F01828;
	Tue, 27 Oct 2026 14:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109792;
	bh=DTTiS0pNazMw6mWdWB2LwKhmSIo7YOFDb57SqsIydHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dMRZdCyeYUpTvidl5d2BNkKOX+lLOsRqViw8AjVC9i9tlXNDtQ9hpkNJkPM6rGGdT
	 nS3VVYLhydsrFjj0ynFcR+TssMB06t0TseNm66bqNTtNaYfD1Q5UdcW+idTNV5Wfw2
	 ncvhNe4UhtLhwFVszPZiZfLAqaIFPbT5B5lHk7PUFkcSPPL8h5PUC0qTW1GwhFAwTJ
	 AmLcgxo1YF4Sz+8MMWfE+RVeVi8o35zUD1CXUl3s6XlmQ1s6/e0JlYLYgHuWFILg+M
	 hVUtaZ9VX424yJDlGiLzCbDiD1cqQXYwV11c/aSZOnDaoSsrCaIA05TChA1cAhXNpV
	 j1DRq132vnsYg==
Message-ID: <sashiko-outbox-186684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] KVM: riscv: selftests: Add Vector owner
 regression tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "slack up" <yxcnew@outlook.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <OSQPR01MB6326D30F15C187093E41762AC2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
References: <OSQPR01MB63265385597FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
 <OSQPR01MB6326D30F15C187093E41762AC2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:03:11 +0000
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
- [Medium] KVM: riscv: selftests: prevent C calls from clobbering v0 in gue=
st code
- [Medium] KVM: riscv: selftests: split Vector owner tests reimplement kvm_=
util helpers
- [Medium] KVM: riscv: selftests: vector_owner_lifetime_test clears owner b=
efore new_vm
--

commit cd1b458fe31c51e7e8df73a0ffb2811bb58b58bb
Author: Xiaochun Yu <yxcnew@outlook.com>

KVM: riscv: selftests: Add Vector owner regression tests

This commit adds three RISC-V KVM selftests covering guest Vector owner
lifetime across vCPU destruction, KVM_GET_ONE_REG and KVM_SET_ONE_REG state
synchronization, and partial user copy faults during KVM_SET_ONE_REG.

> diff --git a/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c =
b/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
> new file mode 100644
> index 0000000000000..a25dd21db77f9
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/vector_owner_fault_test.c
> @@ -0,0 +1,147 @@

[ ... ]

> +static void guest_code(void)
> +{
> +	unsigned long i, vlenb;
> +
> +	csr_set(CSR_SSTATUS, SR_VS_INITIAL);
> +	vlenb =3D csr_read(CSR_VLENB);
> +	GUEST_ASSERT(vlenb && vlenb <=3D RISCV_MAX_VLENB);
> +	for (i =3D 0; i < vlenb; i++)
> +		source[i] =3D OLD_PATTERN;
> +
> +	asm volatile(".option push\n"
> +		".option arch, +v\n"
> +		"vsetvli zero, %1, e8, m1, ta, ma\n"
> +		"vle8.v v0, (%0)\n"
> +		".option pop\n"
> +		:
> +		: "r"(source), "r"(vlenb)
> +		: "memory");
> +	GUEST_SYNC(1);
> +
> +	asm volatile(".option push\n"
> +		".option arch, +v\n"
> +		"vsetvli zero, %1, e8, m1, ta, ma\n"
> +		"vse8.v v0, (%0)\n"
> +		".option pop\n"
> +		:
> +		: "r"(observed), "r"(vlenb)
> +		: "memory");
> +	GUEST_DONE();
> +}

[Severity: Medium]
Can C function calls and compiler auto-vectorization clobber v0 while
sstatus.VS is enabled in guest_code()?

When building the RISC-V KVM selftests with a toolchain targeting RVV (such
as a native GCC or Clang configured for rv64gcv/rva23, or with
EXTRA_CFLAGS=3D-march=3Drv64gcv), Makefile.kvm compiles guest code and
lib/string_override.c with -O2 -fno-builtin-memset and without
-fno-tree-vectorize or -fno-vectorize.

In guest_code() here, as well as guest_code() in
tools/testing/selftests/kvm/riscv/vector_owner_onereg_test.c and old_guest()
in tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c, the guest
sets SR_VS_INITIAL, loads a pattern into the caller-saved register v0 (in an
inline asm block without vector register clobbers), and then calls
GUEST_SYNC() or GUEST_DONE() while sstatus.VS is still active:

  GUEST_SYNC() / GUEST_DONE()
    -> ucall()
      -> ucall_alloc()
        -> memset(uc->args, 0, sizeof(uc->args))

If the compiler vectorizes memset() or the surrounding C loops/helpers, it =
is
free to use caller-saved v0 before the sbi_ecall traps to the host. That
overwrites v0 with zeros before KVM saves or inspects the register, causing
false test failures in vector_owner_fault_test and vector_owner_onereg_test,
and zeroing old_vcpu's v0 before exit in vector_owner_lifetime_test so a
leaked resident v0 would match the zero pattern expected by new_guest().

Should the guest helpers keep sstatus.VS disabled across C calls (or perform
the vector load/store and ECALL inside a single assembly block) so the
compiler cannot touch v0 while guest Vector state is live?

> +static void pin_to_one_cpu(void)
> +{
> +	cpu_set_t allowed, pinned;
> +	int cpu;
> +
> +	kvm_sched_getaffinity(0, sizeof(allowed), &allowed);
> +	for (cpu =3D 0; cpu < CPU_SETSIZE; cpu++) {
> +		if (CPU_ISSET(cpu, &allowed))
> +			break;
> +	}
> +	TEST_ASSERT(cpu < CPU_SETSIZE, "no CPU available");
> +	CPU_ZERO(&pinned);
> +	CPU_SET(cpu, &pinned);
> +	kvm_sched_setaffinity(0, sizeof(pinned), &pinned);
> +}

[ ... ]

> +int main(void)
> +{

[ ... ]

> +	pin_to_one_cpu();
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +	TEST_REQUIRE(__vcpu_has_isa_ext(vcpu, KVM_RISCV_ISA_EXT_V));
> +	vm_init_vector_tables(vm);
> +	vcpu_init_vector_tables(vcpu);
> +	vlenb_id =3D KVM_REG_RISCV | KVM_REG_RISCV_VECTOR |
> +		KVM_REG_SIZE_ULONG | KVM_REG_RISCV_VECTOR_CSR_REG(vlenb);
> +	ret =3D __vcpu_get_reg(vcpu, vlenb_id, &vlenb);
> +	TEST_ASSERT(!ret, "GET vlenb failed: %d", ret);
> +	TEST_ASSERT(vlenb && vlenb <=3D RISCV_MAX_VLENB &&
> +		    !(vlenb & (vlenb - 1)), "bad vlenb: %lu", vlenb);
> +	size =3D (u64)__builtin_ctzl(vlenb) << KVM_REG_SIZE_SHIFT;
> +	v0_id =3D KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | size |
> +		KVM_REG_RISCV_VECTOR_REG(0);
> +
> +	page_size =3D sysconf(_SC_PAGESIZE);
> +	TEST_ASSERT(page_size > 0 && vlenb <=3D 2 * page_size, "bad page size");
> +	mapping =3D mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE,
> +		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	TEST_ASSERT(mapping !=3D MAP_FAILED, "mmap failed: %d", errno);

[ ... ]

> +	kvm_vm_free(vm);
> +	ret =3D munmap(mapping, 2 * page_size);
> +	TEST_ASSERT(!ret, "munmap failed: %d", errno);
> +	return 0;
> +}

[Severity: Medium]
Could these three tests use existing kvm_util/kvm_syscalls helpers and be
consolidated into a single Vector owner test binary?

Specifically:
1. pin_to_one_cpu() in vector_owner_fault_test.c,
   vector_owner_lifetime_test.c, and vector_owner_onereg_test.c reimplements
   pin_self_to_any_cpu() (or pin_self_to_cpu()) from
   tools/testing/selftests/kvm/include/kvm_util.h.
2. main() in vector_owner_fault_test.c hand-rolls mmap() and munmap() with
   TEST_ASSERT() instead of using kvm_mmap() and kvm_munmap() from
   tools/testing/selftests/kvm/include/kvm_syscalls.h, and both
   vector_owner_fault_test.c and vector_owner_onereg_test.c call
   __vcpu_get_reg() with a manual TEST_ASSERT() for the ULONG-sized vlenb
   register instead of vcpu_get_reg().
3. Splitting the lifetime, ONE_REG, and fault sub-cases across three separa=
te
   binaries in tools/testing/selftests/kvm/Makefile.kvm duplicates the Vect=
or
   VM/vCPU initialization, vlenb and v0 register ID calculation, guest
   vle8.v/vse8.v wrappers, and ucall run helpers across all three files.

> diff --git a/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test=
.c b/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
> new file mode 100644
> index 0000000000000..c7b057b27cd0e
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c
> @@ -0,0 +1,127 @@

[ ... ]

> +int main(void)
> +{
> +	struct kvm_vm *old_vm, *new_vm;
> +	struct kvm_vcpu *old_vcpu, *new_vcpu;
> +
> +	pin_to_one_cpu();
> +	old_vm =3D create_vector_vm(&old_vcpu, old_guest);
> +	run_to_done(old_vcpu);
> +	kvm_vm_free(old_vm);
> +
> +	new_vm =3D create_vector_vm(&new_vcpu, new_guest);
> +	run_to_done(new_vcpu);
> +	kvm_vm_free(new_vm);

[Severity: Medium]
Does freeing old_vm while no other VM is open clear the per-CPU Vector owner
before new_vm is ever created?

In main() in tools/testing/selftests/kvm/riscv/vector_owner_lifetime_test.c,
kvm_vm_free(old_vm) closes the only open VM fd, which drops kvm_usage_count
to zero:

  kvm_destroy_vm()
    -> kvm_disable_virtualization()
      -> cpuhp_remove_state(CPUHP_AP_KVM_ONLINE)
        -> kvm_offline_cpu()
          -> kvm_arch_disable_virtualization_cpu()
            -> kvm_riscv_csr_cleanup()
              -> kvm_riscv_clear_former_vcpu()
                -> kvm_riscv_vcpu_vector_owner_invalidate()

Because kvm_riscv_vcpu_vector_owner_invalidate() zeroes the per-CPU
kvm_riscv_vector_owner structure when the last VM is destroyed, the resident
owner from old_vcpu is already cleared before new_vm is created. When
new_vcpu runs, kvm_riscv_vcpu_vector_owner_load() in
arch/riscv/kvm/vcpu_vector.c always hits the !owner->identity branch:

	} else if (!owner->identity) {
		reason =3D vcpu->arch.last_exit_cpu =3D=3D cpu ?
			 KVM_RISCV_VECTOR_OWNER_EMPTY :
			 KVM_RISCV_VECTOR_OWNER_MIGRATION;
	} else if (owner->identity !=3D (unsigned long)vcpu) {
		reason =3D KVM_RISCV_VECTOR_OWNER_OTHER_VCPU;
	} else if (owner->cookie !=3D vcpu->arch.vector_owner_cookie) {
		reason =3D KVM_RISCV_VECTOR_OWNER_COOKIE;
	} else if (owner->generation !=3D vcpu->arch.vector_state_generation) {
		reason =3D KVM_RISCV_VECTOR_OWNER_GENERATION;

So the test never exercises the stale-vCPU identity or cookie checks (and
even if a second VM is kept alive so kvm_usage_count does not drop to zero
and new_vcpu reuses old_vcpu's struct kvm_vcpu address, old_vcpu leaves
owner->generation =3D=3D 2 while new_vcpu starts its first KVM_RUN with
vector_state_generation =3D=3D 1).

Should the test keep a VM alive across old_vcpu destruction (or recreate the
vCPU in a way that preserves the per-CPU owner state and matches generation)
so that the stale-owner checks in kvm_riscv_vcpu_vector_owner_load() are
actually reached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/OSQPR01MB6326538559=
7FE472C4209353C2602@OSQPR01MB6326.apcprd01.prod.exchangelabs.com?part=3D3
