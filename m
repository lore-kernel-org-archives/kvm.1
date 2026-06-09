Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169761E5B68
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966258; cv=none; b=EWRtrIQ98Rk4pVE6tgqLfAAAmv4rB70WPQ6Jxx1qcgJQjb2LU1UxdMSl91gH5WfX2Mzf0MBCSetFHp1WWPnLdKMvj40HR5GcAizWjEmAVLKW0xBpcJ3TtmYCVEa7O+VhsBtNihyz3UaVPmYWpsV4w4TXWRxvgeL6QHku7yl32Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966258; c=relaxed/simple;
	bh=jru9reh+iTu2zKOyRT+x2OVQaUx9d3YyNyWFdXeQ540=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQG0zMgjCGs3g8W35IRoWdS4c4+RLjFhRpb0FMESwTlfuOWI9Vsr1T15ptayHnz1ix8qDIkJ3GyGNAxI848757dB9ZQQztR3VDVzXmBi7d9yHudA5RvFwrXGB/ga6iCwSjCxiFrfKnyy0+e/tXtFmrNt3wM9hcDwYpbbbpka6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF34Qln8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF34Qln8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB51F00893;
	Tue,  9 Jun 2026 00:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966256;
	bh=gtwAkVK61/tWUvil/XZrVDAueFk2CW5QOCTG9sRud+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NF34Qln8Jrmt9sGECtgGhQ7rTiCfZ95LhHZRCm2JxRirwyEMODpzmKrzkrnTgyznt
	 qKay1s3EA0c2GG/MROfArL3PbmmU/WcgmotoxD4DQxse5YOXjm/7xoWfkX6BLxgs0t
	 N640v+jwbouJ7V2e3UnzdMP+OJAPL3yCnaXvM2gsEgc2Ykp4pDGYF3QSDcJ/70mdMs
	 IlGWdI9CBkeoUrjn4yPdB9DSCRpKgi+h0uhVLKoFI3jc4dHaskoavDoScqo5RwOWdT
	 jBfuhHzckBlPt81GC6BsZ/YkaEw5PnUIJ4eiI1dgesqFL4SM0lZtp754j0bkf162EN
	 LFfHIiZ7hH2Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 30/34] KVM: selftests: Add Xen runstate migration
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-31-dwmw2@infradead.org>
References: <20260608145455.89187-31-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 00:50:56 +0000
Message-Id: <20260609005056.8FBB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Memory leak of the VM metadata structures and userspace memory r=
egions.
- [Low] The new test file is missing from the KVM selftests Makefile, preve=
nting it from being compiled.
- [Low] The test uses undefined KVM UAPI ioctls, causing compilation failur=
es.
--

commit 0780d159e1213b2e5be1d76bb2647a1007af3fdf
Author: David Woodhouse <dwmw@amazon.co.uk>

Test that Xen runstate (steal time) is correctly accounted across a
simulated live migration using KVM_XEN_VCPU_ATTR and KVM_[GS]ET_CLOCK_GUEST.

This commit adds a new KVM selftest to verify Xen runstate tracking across
a simulated VM migration. It creates a VM with Xen HVM configuration,
accumulates runstate time, saves and restores the VM state, and verifies
that the elapsed time during migration is properly accounted as steal time.

>  .../selftests/kvm/x86/xen_migration_test.c    | 194 ++++++++++++++++++
>  1 file changed, 194 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/xen_migration_test.c

[Severity: Low]
Is the new xen_migration_test.c file missing from the KVM selftests Makefil=
e?
Without adding it to TEST_GEN_PROGS_x86 (or an equivalent target) in
tools/testing/selftests/kvm/Makefile, the test is ignored by the build syst=
em
and will never be compiled or executed.

> diff --git a/tools/testing/selftests/kvm/x86/xen_migration_test.c b/tools=
/testing/selftests/kvm/x86/xen_migration_test.c
> new file mode 100644
> index 000000000000..37e8ace00611
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/xen_migration_test.c
[ ... ]
> +int main(void)
> +{
> +	struct pvclock_vcpu_time_info pvti;
> +	struct kvm_xen_vcpu_attr runstate_save;
[ ... ]
> +	pr_info("  Guest sees: runnable=3D%" PRIu64 " running=3D%" PRIu64 "\n",
> +		uc.args[2], uc.args[3]);
> +
> +	/* Save clock state */
> +	ret =3D __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &pvti);

[Severity: Low]
Does this code fail to compile because KVM_GET_CLOCK_GUEST is an undeclared
identifier? It does not appear to exist in the standard KVM UAPI headers.

> +	TEST_ASSERT(!ret, "KVM_GET_CLOCK_GUEST failed");
> +
> +	/* Save TSC offset */
[ ... ]
> +	uint64_t saved_runnable =3D runstate_save.u.runstate.time_runnable;
> +
> +	kvm_vm_release(vm);

[Severity: Medium]
Does calling kvm_vm_release() here instead of kvm_vm_free() leak the=20
struct kvm_vm object and its mapped userspace memory regions?

kvm_vm_release() is an internal helper that releases vCPUs and file
descriptors, but it leaves the VM structure and memory maps allocated
right before the vm pointer is overwritten with a new VM.

> +
> +	/* =3D=3D=3D MIGRATION GAP =3D=3D=3D */
> +	pr_info("=3D=3D=3D Simulating migration (sleeping 10ms) =3D=3D=3D\n");
> +	usleep(10000);
> +
> +	/* =3D=3D=3D DESTINATION SIDE =3D=3D=3D */
> +	pr_info("=3D=3D=3D Destination: create new VM and restore =3D=3D=3D\n");
> +	vm =3D create_xen_vm(&vcpu);
> +
> +	/* Restore TSC offset */
> +	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, tsc_offset);
> +
> +	/* Restore clock =E2=80=94 kvmclock will now be ~10ms ahead of the snap=
shot */
> +	vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, &pvti);

[Severity: Low]
Similarly, does this fail to compile because KVM_SET_CLOCK_GUEST does not
exist in the standard KVM UAPI headers?

> +
> +	/* Restore runstate exactly as saved (state=3Drunnable) */
[ ... ]
> +	TEST_ASSERT(steal_increase >=3D 10000000ULL &&
> +		    steal_increase < 5000000000ULL,
> +		    "Steal time increase %" PRIu64 " ns not in expected range "
> +		    "[10ms, 5s]", steal_increase);
> +
> +	kvm_vm_release(vm);

[Severity: Medium]
Does this also permanently leak the second VM's metadata structures and
memory maps before the test exits?

> +	pr_info("PASS: Migration gap correctly accounted as steal time\n");
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D30
