Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188684;
	b=QgYjkwcgimp0s0F7W1KcDADHW2RkBwbCi6I0pRn5KWcJQqaban1DBJNGm85aAvOkGwwf
	 oj/yV8lxaI8JaepN6SR0TI96OyYNP4vptNeQ2AsCjIkVCyrFqRH/j9hmZm0jSuRg7DqlJ
	 TWc04LliiW5BcnXxfCrEFlnUHzohR+1Zmrlemi2Qk6sWSgi8AiKh9ISJBnGDK/P0VPojY
	 3+8HBvUF0rock8Qto2OkS7Ej9Er+sBfxTuXq7LPWjzJsMEFxaDzKGmS3kcJXVZS2Bmcju
	 lA1qDXWVdRtj/MRVOdzH6uhQz1q3zRv3uC7DwM0VmOO8SZlshXY2rbjS29NGAb+bBkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nxxKhvmkLdocCzFHBTXFCkXvxAktQGgp7hKF0pv2xE8=;
	b=mvPLP2w52tMK3On1t/qnuipk0P4SrU/RwC/52SXbwJO6YECnUTrbrX5KGqoVF1ev+9YH
	 XXNqBfSxOBUYGsrfWArpEP/GJhNZKI5V7IO4gRCb5dkz1i0KIo7a0jF2YKKHB97Z/eRFU
	 dyL73Z0TSp/4BUoN4hhoMQP4I5i9N+EK33zPvh1Q8twDyzG8GhBtQOWNqoB3ymP1tlumL
	 wnEBjB5ou1Z4jJBmckWsr+6VxlDUjus5x+KTiEPiRxw2yC4ZMs996DJdlx/YkyBYdyEuu
	 Z2fxy1HD0FAI3xeAzQaMUcuYtvEFljZlDWEZF62gYvnuuhRp5a5l+9XvnhNLOtyrqrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBvTPKHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A6606A332
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBvTPKHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8651F008A3;
	Mon,  9 Nov 2026 01:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188684;
	bh=nxxKhvmkLdocCzFHBTXFCkXvxAktQGgp7hKF0pv2xE8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dBvTPKHACjTn09UipKdIwwDAh19pgeX1Ho+IaCMgXl6V4y/2U9MQu74BRMo1f6+PU
	 IHPh3l3X7UvRcSEtrwXyUeI3fQjZaEggn8MNPW3X/S7R6KkqiSKd+4p/pBC4oS86aj
	 jwSi4X3mMNUhGpwFU9zHBNJIoBDXc8aMvWak4slGCT/gfD48zX6oiQh/PNzaMjQ9xg
	 sLQS0/+m9EC2Y1lO7o3Gb8dBr72csTQj+Ay3Yw5v79JA0LLuXnThzGusIoHRDYL9XJ
	 IYlhu+vctGOSsgT2446TLn/3NwliJa8KSHqledkU6TQ0bdvyxDhmBXaYQ9fI1HkVa/
	 EzRJrSx2pTtrw==
Message-ID: <sashiko-outbox-204316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 16/24] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-17-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:44:43 +0000
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
- [Low] KVM: x86: doc per-vCPU KVM_SET_TSC_KHZ order breaks
  KVM_SET_CLOCK_GUEST
- [Low] KVM: selftests: duplicated pvclock and TSC scaling helpers in
  test
--

commit 83ddc67114d3c0896cacdd30d2c4eb5ecc38fbfe
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration

This commit adds the KVM_VCPU_TSC_SCALE vCPU device attribute to expose the
guest TSC scaling ratio and fractional bits to userspace, updates the TSC
migration documentation, and adds a selftest for pvclock and TSC migration.

> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt=
/kvm/devices/vcpu.rst
> index deb5c51bc00c8..8dc6ad904429d 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
[ ... ]
> @@ -261,44 +265,117 @@ following describes a possible algorithm to use fo=
r this purpose.
[ ... ]
> +From the destination VMM process:
> +
> +4. Invoke the KVM_SET_TSC_KHZ ioctl to set the scaled frequency of the
> +   guest's TSC (freq[i]) =E2=80=94 either on the VM before creating the =
vCPUs, or
> +   on each vCPU after creating it (as the exemplar test does). When using
> +   the per-vCPU form, set the frequency before performing step 7 on that
> +   vCPU: KVM_VCPU_TSC_SCALE reports the ratio for the currently
> +   configured frequency.
> +
> +5. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_dst) =
and
> +   host CLOCK_REALTIME nanoseconds (time_dst) at a given moment (Tdst),
> +   again checking KVM_CLOCK_HOST_TSC in the returned flags.
> +
> +6. Calculate the number of nanoseconds elapsed between Tsrc and Tdst:
> +
> +   =CE=94T =3D time_dst - time_src
> +
> +7. As each vCPU[i] is created:

[Severity: Low]
When using the per-vCPU KVM_SET_TSC_KHZ ioctl, does creating and
configuring vCPUs one at a time disable the master clock?

Without the VM-scoped KVM_SET_TSC_KHZ ioctl, each KVM_CREATE_VCPU runs
kvm_arch_vcpu_postcreate() -> kvm_synchronize_tsc() at default_tsc_khz.
If a VMM sets freq[0] on vCPU[0] and then creates vCPU[1], vCPU[1]'s
creation bumps cur_tsc_freq_generation back to default_tsc_khz and resets
nr_vcpus_matched_freq, and setting freq[1] on vCPU[1] bumps
cur_tsc_freq_generation again, leaving vCPU[0] in an older generation:

arch/x86/kvm/x86.c:__kvm_synchronize_tsc() {
	...
	if (vcpu->arch.virtual_tsc_khz !=3D kvm->arch.cur_tsc_khz) {
		kvm->arch.cur_tsc_freq_generation++;
		kvm->arch.all_vcpus_matched_freq =3D false;
		kvm->arch.nr_vcpus_matched_freq =3D 0;
	}

	/* Count each vCPU once per freq generation */
	if (vcpu->arch.this_tsc_freq_generation !=3D kvm->arch.cur_tsc_freq_genera=
tion) {
		vcpu->arch.this_tsc_freq_generation =3D kvm->arch.cur_tsc_freq_generation;
		kvm->arch.nr_vcpus_matched_freq++;
	}
	...
}

Because all_vcpus_matched_freq stays false, KVM_GET_CLOCK in step 5 will
not set KVM_CLOCK_HOST_TSC (or KVM_SET_CLOCK_GUEST in step 8 will fail
with -ENODATA if vCPUs are created during step 7).  Should step 4 note
that when using the per-vCPU KVM_SET_TSC_KHZ ioctl, all vCPUs must be
created before setting the frequency on any of them (as create_vm() in
pvclock_migration_test.c does)?

> diff --git a/tools/testing/selftests/kvm/x86/pvclock_migration_test.c b/t=
ools/testing/selftests/kvm/x86/pvclock_migration_test.c
> new file mode 100644
> index 0000000000000..c18c9132308d6
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c
> @@ -0,0 +1,521 @@
[ ... ]
> +static u64 pvclock_read_cycles(struct pvclock_vcpu_time_info *src,
> +				    u64 tsc)
> +{
> +	u64 delta =3D tsc - src->tsc_timestamp;
> +	u64 ns;
> +
> +	if (src->tsc_shift >=3D 0)
> +		delta <<=3D src->tsc_shift;
> +	else
> +		delta >>=3D -(s32)src->tsc_shift;
> +
> +	ns =3D (unsigned __int128)delta * src->tsc_to_system_mul >> 32;
> +	return src->system_time + ns;
> +}
[ ... ]
> +	if (scale_dst.tsc_frac_bits)
> +		raw_dst =3D (unsigned __int128)host_tsc_dst * scale_dst.tsc_ratio
> +			  >> scale_dst.tsc_frac_bits;
> +	else
> +		raw_dst =3D host_tsc_dst;

[Severity: Low]
This isn't a bug, but pvclock_read_cycles() duplicates
__pvclock_read_cycles() from tools/arch/x86/include/asm/pvclock.h, and
raw_dst open-codes host_to_guest_tsc(&scale_dst, 0, host_tsc_dst) defined
earlier in this file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D16
