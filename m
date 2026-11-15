Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733760;
	b=WUd3Za+0+LUB3cWlsD3TXJJTYa/xwBykh9+xF+85GyGlunAHhzl2qGERA0cSLT0ud6nf
	 EO8jGbhdegv4ZHfrDbrt5vlfZ8/NCCCs2UoIBWe12uYQnovttT3ctt0QvUCDMMDMTrSEH
	 k64wts6GfJ5QWoxOh5WZBCeVddNiI1iQGXG/FSnVMrhwyxpFxzHiJvnYpFQPWpBSabZqK
	 zhiFs88+QVZAHuUGRlgp1FqRA33k9cLyWZaZevOsyUijFBcl4OHDT+hBZ3pqWcu1CxG94
	 VWboXWCfZxsbY2y0cXUpLKlWPdQk8bfeYUDCXtR0AkBnSV9JTV6SxfC/ZM9EIOGo5eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733760;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=75o8UXnQDoYAT+2ZZWKA4ZvgXcF1sgmEBQDHx4kLN5s=;
	b=ZXGI3REFzlO7FAvJPhKU3U2KM+A+6nYn6wWmizMftbMHoWoQRhAr4kCW/kmUj008PaSN
	 qjsYiZvmV2tA2kqKEc3YrNMDRAB3RfN/A9T9mMIVVmDAO9MClxBM68oeWIqB6RtAnFCOo
	 qVKz8U3MXHk8EDKheSm/25GMcMPCecf+CBVwUjdHxUkh/5NENNVUHjNXvb2+6L5hAXyrd
	 TX12L4kT3bLO7uiPWgTgPFjqqy6Ns4znroastALJ8CtH6wXBzlyeVg5u95H1ZYRNKctiF
	 6/xbZtS0l/haStMe5Ld3PCBYwQOL6RU2VhERGY+5ezvUIPZocD6muR1qgZd4MQkbl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjuaXGyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0340606A31A
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjuaXGyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFA61F000C4;
	Sun, 15 Nov 2026 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794733760;
	bh=75o8UXnQDoYAT+2ZZWKA4ZvgXcF1sgmEBQDHx4kLN5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjuaXGyXFp8OHeHfan7zCXwfEtUYtJIsHa124Iwul+qxVdipVSE8RcvMMKdUAqzxY
	 gFUpZVigaJu0SMfuihtSZBDMxs2JX57V34YTYyaKogIjdeAP/m8v28D/rlCJFahTm8
	 HSGUMWEnpJw3bsH/1QfX6e/toMEoJMtiP24FgGy9rfS+uow6xWMWzM6CMAYi0Js2lZ
	 fTPCw3bSip+cslqLI3r8O61mt7Q1KbFxmSzfvXwSqxy0HnFJQ8lnQKhPnVhgPnWALR
	 PrliQVwrNXRrUGFoBmMseLEEOe8R9xIHoT0B8Jtd5/C1uQB3pJL0+uBzTFI8u7xpLq
	 AsbpXk3PpkU0Q==
Message-ID: <sashiko-outbox-215329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: selftests: riscv: Test the SBI STA shared memory
 lifecycle
Reply-To: sashiko-reviews@lists.linux.dev
To: Bingyu.Xian <shanbeeyoo@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261115085457.889873-1-shanbeeyoo@gmail.com>
References: <20261115085457.889873-1-shanbeeyoo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 09:09:19 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: selftests: riscv: malformed Signed-off-by trailer and
  author mismatch
- [Medium] KVM: selftests: riscv: uncleared dirty log in
  check_sta_lifecycle()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] KVM: selftests: infinite loop on schedstat parsing failure in
  get_run_delay() [1]
--

commit 711407189204983601d5cf730f872165c9f4324d
Author: Bingyu.Xian <shanbeeyoo@gmail.com>

> KVM: selftests: riscv: Test the SBI STA shared memory lifecycle
>
> The RISC-V steal-time test checks the UAPI alignment constraints and
> compares stolen time with the host run delay. It does not exercise
> changes to the shared page after accounting has been enabled.
>
> Extend the existing test to check that disabling STA stops shared-page
> updates and that reconfiguring it leaves the old shared page unchanged.
> Place the second STA structure at the end of another page and verify
> that updates mark the appropriate page dirty.
>
> Discard the second backing page with MADV_DONTNEED and check that a
> subsequent KVM_RUN resumes STA updates on the replacement page and
> marks it dirty. Read the replacement page before KVM_RUN so that a
> stale write into the old backing page cannot satisfy the assertions.
>
> Keep these checks in steal_time instead of adding another test binary.
> The test does not depend on a gfn-to-pfn cache implementation.
>
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: bingyu.xian <shanbeenyoo@gmail.com>

[Severity: High]
Both the Author header and the final Signed-off-by trailer format the name
as a dot-separated single token ("Bingyu.Xian" / "bingyu.xian") instead of a
space-separated full name ("Bingyu Xian"), and the email addresses do not
match (shanbeeyoo@gmail.com vs shanbeenyoo@gmail.com).

> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/sel=
ftests/kvm/steal_time.c
> index 82b94a82dd035..059f7fa60a207 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c

[ ... ]

> @@ -329,6 +330,111 @@ static void steal_time_dump(struct kvm_vm *vm, u32 =
vcpu_idx)
>  	pr_info("\n");
>  }
> =20
> +static gpa_t lifecycle_second_gpa;
> +
> +static void sta_lifecycle_guest(void)
> +{
> +	sta_set_shmem(ST_GPA_BASE, 0);
> +	GUEST_SYNC(0);
> +	/* The first update takes place on the next KVM_RUN. */
> +	GUEST_SYNC(1);
> +
> +	sta_set_shmem(INVALID_GPA, 0);
> +	GUEST_SYNC(2);
> +	GUEST_SYNC(3);
> +
> +	sta_set_shmem(lifecycle_second_gpa, 0);
> +	GUEST_SYNC(4);
> +	GUEST_SYNC(5);
> +
> +	/* Userspace discards the second backing page before resuming us. */
> +	GUEST_SYNC(6);
> +	sta_set_shmem(INVALID_GPA, 0);
> +	GUEST_DONE();
> +}

[ ... ]

> +static void check_sta_lifecycle(void)
> +{
> +	struct sta_struct snapshot, *first, *second;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	unsigned long dirty =3D 0;
> +	void *second_page;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, sta_lifecycle_guest);
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE,
> +				    1, 2, KVM_MEM_LOG_DIRTY_PAGES);
> +	/* Also exercise an STA structure ending exactly at a page boundary. */
> +	WRITE_AND_SYNC_TO_GUEST(vm, lifecycle_second_gpa,
> +				ST_GPA_BASE + 2 * vm->page_size - sizeof(struct sta_struct));
> +	first =3D addr_gpa2hva(vm, ST_GPA_BASE);
> +	second =3D addr_gpa2hva(vm, lifecycle_second_gpa);
> +	second_page =3D addr_gpa2hva(vm, ST_GPA_BASE + vm->page_size);
> +
> +	sta_lifecycle_run(vcpu, 0);
> +	sta_lifecycle_run(vcpu, 1);
> +	check_sta_page(first);
> +	kvm_vm_get_dirty_log(vm, 1, &dirty);
> +	TEST_ASSERT(dirty & BIT(0), "STA update did not dirty the first page");
> +	ksft_test_result_pass("STA shared page updates and is marked dirty\n");
> +
> +	sta_lifecycle_run(vcpu, 2);
> +	snapshot =3D *first;
> +	sta_lifecycle_run(vcpu, 3);
> +	TEST_ASSERT(!memcmp(first, &snapshot, sizeof(snapshot)),
> +		    "Disabled STA shared page was modified");
> +	ksft_test_result_pass("STA disable stops shared page updates\n");
> +
> +	sta_lifecycle_run(vcpu, 4);
> +	sta_lifecycle_run(vcpu, 5);
> +	check_sta_page(second);
> +	TEST_ASSERT(!memcmp(first, &snapshot, sizeof(snapshot)),
> +		    "Old STA shared page was modified after reconfiguration");
> +	dirty =3D 0;
> +	kvm_vm_get_dirty_log(vm, 1, &dirty);
> +	TEST_ASSERT(dirty & BIT(1), "STA update did not dirty the new page");

[Severity: Medium]
Can the dirty-log checks after stages 1 and 5 pass even if
kvm_riscv_vcpu_record_steal_time() fails to mark the STA page dirty?

During stages 0 and 4, sta_set_shmem() invokes
kvm_sbi_sta_steal_time_set_shmem(), which zeroes the structure via
kvm_vcpu_write_guest() -> __kvm_write_guest_page() ->
mark_page_dirty_in_slot().  Because the dirty log is not cleared after
stage 0 or stage 4, BIT(0) and BIT(1) are already set before the KVM_RUN
steal-time updates in stages 1 and 5 occur.  In addition, entering stage 2
updates and dirties page 0 before sta_set_shmem(INVALID_GPA, 0) runs, so
leaving the dirty bitmap uncleared after stage 2 also prevents stage 5 from
checking that BIT(0) stayed clear after reconfiguration.

[ ... ]

> @@ -535,9 +641,16 @@ int main(int ac, char **av)
> =20
>  	ksft_print_header();
>  	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
> +#ifdef __riscv
> +	ksft_set_plan(NR_VCPUS + 4);
> +#else
>  	ksft_set_plan(NR_VCPUS);
> +#endif
> =20
>  	check_steal_time_uapi();
> +#ifdef __riscv
> +	check_sta_lifecycle();
> +#endif
> =20
>  	/* Run test on each VCPU */
>  	for (i =3D 0; i < NR_VCPUS; ++i) {

[Severity: Medium]
This problem wasn't introduced by this patch, but can the per-VCPU loop in
main() spin forever [1] when /proc/<pid>/schedstat is unavailable or
unreadable (for example when CONFIG_SCHED_INFO is disabled)?

tools/testing/selftests/kvm/lib/test_util.c:get_run_delay() {
	...
	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) < 2)
		val[1] =3D MIN_RUN_DELAY_NS;
	...
	return val[1];
}

When fscanf() fails repeatedly, both the initial run_delay and every
subsequent get_run_delay() call in the polling loop return MIN_RUN_DELAY_NS,
so get_run_delay() - run_delay is always 0 and never reaches
MIN_RUN_DELAY_NS.

[1] https://sashiko.dev/#/bug/linux-a91f66d8-0fe1-40da-93b7-ac05da87bc12

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115085457.8898=
73-1-shanbeeyoo@gmail.com?part=3D1
