Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845698;
	b=4NqIi+17VsA3wdXVvvSwLBYwrFWWpOE5R5WKk38nXIV98N+wTKlQU529uSlO6D6+lmWl
	 mTpeRcG9YLr3BqcAQWvVZPV13eD0mVl76FRsym1k7T7VYIqYd7GmqW9yoC7TN37CpfoaC
	 FWBPlWPHrh3PlAMh8H5j9vsf/OC3A4evIWFmZkJzYb9FALPPZBOTG2UR9yIBBKAjnOIre
	 LS0isKlTbI4a4U/EDBNIQK7zQjjXY1isX0usGNpddDl379rXC9a6hS/0TPtQaJVqYQvhq
	 zW14pZMoZAsVuSXVXEVLrZJyUGcH4OBKRDe9gud+Dhkd57jE8gUAmwQxjrBloxeE76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WAgLOtwFwdtiIlyIU6JoOcmyKs3LIDv5T6amKikVU+8=;
	b=3ffZghQeOp0/WyuHhkBct8P+b9bD/5gaRHlEErCApT9wCJe/XdGejS7MSlrUZvYiTLkS
	 +7XPDI0GsRiTf166zgH1AJ4jMuFhPWZTrinjbU3cwSikZVRKm7bRoTsegmkFFrlmW6gdI
	 zFyeBRfci+Ehnj6PNH4w/OXs/kZSudkG7uqwltVbVw8FRcKu5fyfwC3qDsaiiLGpW4qi/
	 IBX2auBArRSpgcvDP74HDKUCscmxisaaNKg9YOpV3HQEhzm3i6CBIBjMkOLRQAqF55QW0
	 /kC01JMm8ehfXnWQhGHhurNVUKd5lQDSbj06snWuJstRQez8/pF0u93NlwYrEbnFtsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsQ1uUDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C7606A326;
	Thu,  5 Nov 2026 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsQ1uUDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B651F000C1;
	Thu,  5 Nov 2026 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793845697;
	bh=WAgLOtwFwdtiIlyIU6JoOcmyKs3LIDv5T6amKikVU+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MsQ1uUDoHHC1cZaClUvIGdQESMSqCRlS61RmH5rtG4WW0qEe9hSg2LyPB4EZ9kjBx
	 kW9hPQM1OGeXjoQ+wpGvXjZY5LTpNQBaQHEpbTV/3F7IVEoVOmwoBGrD9MM3MwaKmo
	 FTLq+P/Vyp4CE7khA/XWHXVQOiQFyr88CzaFcaxiXpg+AosmguxlmPENN2xoogI8LU
	 r8SZjAit/aLjVwhp2dOj6UlCpfnh+omGFAeDDH7VZXiFzMJAuDrPEyzjbhPrdWV0AU
	 3oYzbZqi7CK9Ix+NvdI1xYFSrShmc2Db6oZHjkFQ6/MpsiV36+fNKOqByYEbYt4T3H
	 XRw/jzim5D0Yg==
Message-ID: <sashiko-outbox-198461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/20] KVM: selftests: Add Xen evtchn vs mmu_notifier
 race test for HVA caches
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261105020104.2507083-21-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
 <20261105020104.2507083-21-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:28:16 +0000
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
- [Low] KVM: selftests: commit message claims 20000 sends but TEST_ITERATIO=
NS is 5000
- [Low] KVM: selftests: xen_evtchn_hva_notify_race_test duplicates memslot =
race test
- [Low] KVM: selftests: unchecked madvise() and raw mmap() in HVA race test
--

commit cf7aec0532723ffed105931f7f5b74967ac26723
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add Xen evtchn vs mmu_notifier race test for HVA caches

This commit adds a KVM selftest racing a guest EVTCHNOP_send loop against a
host thread invoking MADV_DONTNEED on the userspace page backing the
HVA-based shared_info and vcpu_info caches.

>     KVM: selftests: Add Xen evtchn vs mmu_notifier race test for HVA cach=
es
>    =20
>     Race a guest EVTCHNOP_send loop against a host thread hammering
>     MADV_DONTNEED on the userspace page backing HVA-based shared_info and
>     vcpu_info caches. Every madvise zaps the PTE and invalidates both
>     gfn_to_pfn_caches; every delivery must refresh through the window
>     (hva_to_pfn_retry() retries until the invalidation has finished, then
>     faults the page back in) and must succeed. The caches are HVA-based,
>     so no memslot semantics excuse a drop: unlike
>     xen_evtchn_memslot_race_test, which only pins the no-deadlock claim,
>     this test asserts every one of the 20000 sends delivers, and any
>     hypercall bounce to userspace fails the test.
>    =20
>     This exercises the pfncache invalidation protocol itself =E2=80=94 the
>     invalidate_start walk, the reader draining for a cache mid-teardown,
>     and the handshake between a refresh publishing a new mapping and a
>     concurrent invalidation vetoing it =E2=80=94 which is where a lifetim=
e bug
>     in the cache would live; on a debug kernel one is expected to
>     surface as a splat rather than a dropped event.
>    =20
>     Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

[Severity: Low]
The commit message states that this test asserts every one of the 20000 sen=
ds
delivers, but in tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race=
_test.c
TEST_ITERATIONS is defined as 5000 and guest_code() runs TEST_ITERATIONS
hypercalls:

#define TEST_ITERATIONS		5000
...
	for (i =3D 0; i < TEST_ITERATIONS; i++) {
		rc =3D __xen_hypercall(__HYPERVISOR_event_channel_op,
				     EVTCHNOP_send, &s);

Should the commit message say 5000 sends to match TEST_ITERATIONS and the
runtime estimate comment in main()?

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index c17408f8d61f5..19dc0744f25f8 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -150,6 +150,7 @@ TEST_GEN_PROGS_x86 +=3D x86/debug_regs
>  TEST_GEN_PROGS_x86 +=3D x86/tsc_msrs_test
>  TEST_GEN_PROGS_x86 +=3D x86/vmx_pmu_caps_test
>  TEST_GEN_PROGS_x86 +=3D x86/xen_evtchn_memslot_race_test
> +TEST_GEN_PROGS_x86 +=3D x86/xen_evtchn_hva_notify_race_test

[Severity: Low]
This isn't a bug, but tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify=
_race_test.c
duplicates most of tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_=
test.c,
including the hypercall definitions, struct evtchn_send, VM and vCPU creati=
on,
KVM_XEN_HVM_CONFIG setup, KVM_XEN_ATTR_TYPE_LONG_MODE setup,
KVM_XEN_ATTR_TYPE_EVTCHN IPI loopback routing, worker thread lifecycle,
alarm() watchdog setup, and the vcpu_run() / get_ucall() loop in main().

Since only the backing memory setup (HVA vs GPA/memslot), the churn thread
body (madvise MADV_DONTNEED vs memslot update), and whether KVM_EXIT_XEN
hypercall bounces are tolerated differ between the two tests, could this HVA
mmu_notifier variant be folded into xen_evtchn_memslot_race_test.c as a test
mode or parameter rather than adding a separate standalone binary?

> diff --git a/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_t=
est.c b/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c
> new file mode 100644
> index 0000000000000..c105435f63577
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c

[ ... ]

> +static void *backing_churn(void *arg)
> +{
> +	void *backing =3D arg;
> +
> +	while (!atomic_load(&churn_stop))
> +		madvise(backing, PAGE_SIZE, MADV_DONTNEED);
> +
> +	return NULL;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	pthread_t thread;
> +	struct ucall uc;
> +	void *backing;
> +	int done =3D 0;
> +
> +	int xen_caps =3D kvm_check_cap(KVM_CAP_XEN_HVM);
> +
> +	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA);
> +	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, guest_code);
> +
> +	/*
> +	 * The shared_info page and the vcpu_info within it live in plain
> +	 * anonymous VMM memory, not in any memslot: nothing but the
> +	 * mmu_notifier churn below can perturb the caches.
> +	 */
> +	backing =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
> +		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	TEST_ASSERT(backing !=3D MAP_FAILED, "mmap of backing page failed");

[ ... ]

> +	atomic_store(&churn_stop, true);
> +	kvm_pthread_join(thread, NULL);
> +	alarm(0);
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

[Severity: Low]
In backing_churn(), madvise(backing, PAGE_SIZE, MADV_DONTNEED) does not che=
ck
for errors; if madvise() fails, the churn loop would spin without zapping P=
TEs
or triggering mmu_notifier invalidations, allowing the test to pass without
exercising the race.

In addition, main() open-codes mmap() + TEST_ASSERT() and exits after
kvm_vm_free(vm) without unmapping backing.

Should backing_churn() and main() use the kvm_madvise(), kvm_mmap(), and
kvm_munmap() helpers from kvm_syscalls.h instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020104.2507=
083-1-dwmw2@infradead.org?part=3D20
