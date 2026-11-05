Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909199;
	b=f5SW5wzs+zD6bM5Fk+fFzJe4iA/Ylt/ON4mUB0SNwmnia9xorBgiLW6tY+G7mAyqy5Qe
	 Z1lyVWvKHVNB2ev38rWuzk14f8MyYNVKAyuXAYvDTQt85w/ghvTvR2GJY2mYr0dSnqD7G
	 xwSmXjHkwpUXZjX4lznZEALYOPRjm34s1ikEPB5oM7Kl09MKRiu3IJ3WOUmVbLXRDvqAi
	 w0n1lYMGNIrswmLjryLZDiYda+h3q4+7gis0BClvsEOCMQKUETJqv/5CPoNNJUtijj/SJ
	 RgcqKs7aykWg32xGDKWh/NbaSauNklsOwzj7UWZHv6wc0CYReBHyPcsGJ69hrHiZodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kl4XAQ3JP5nWD6L49y2S40rmApUYoz+CGbjVNaZwAsA=;
	b=qTf3LkksItdWnhpUxmjtz5hgscpVqQRfc+XA+cR86ET7sXqlG2+Y/99e/5ABE8OpMQ9D
	 9KQmmKrYdzUaOTXeHhq1o0AZT58NqDbyrTRrSaYOgVApH7uo12NvOeMK/pTu4ZPjPeYzI
	 61sU5Y8QvQjPXQgMAkkNK5eoAj94KUnGVhnU76aXGM/jmNsRKEOJKZOx5qQTt+/HtaHCU
	 ptPgP6yOqrTkulpbgCGBuF0eYL+B4byebDkCAEAtl2s/fDMu//u/4w0CV+LGTeYLSuglD
	 t85lZLZqGStjKP9FsNXX+1mGq9thUrUIicKAtbMueCUBehiBRRr4I+c13KmIEV3K4bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aisN2xSA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC69606EEBF
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aisN2xSA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528271F0089F;
	Thu,  5 Nov 2026 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909198;
	bh=kl4XAQ3JP5nWD6L49y2S40rmApUYoz+CGbjVNaZwAsA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aisN2xSAVjejNgl3CDcXPf+qZsaZy9cZskYaIop9S//9RF5f3wo41pXy+2hqJFaU4
	 /smV8hQr0PS4lr80XsV9UJoutRor6370QD40OUD8SIm8P1UL6/fFeS8oJVxcwKXJ8K
	 IvaLUAEN6GM8+3e9etrcQJY4aufxPqlKjqTw5zhckDitfbSC0gq+s1taEvb3f1ydAw
	 J8NtE9MyK1zYNXdzq1oWL3GMgRm2sbpt815rtmyzVyxwphKJ5b7iGgn4E3v21nBY45
	 SP3wg7twEhtI8itYDAiOAv56T7dbvvle9r/keLV3XZouH7DIo0oNDFrQTcc3JFvd+T
	 cm4nqs5NhOFUg==
Message-ID: <sashiko-outbox-200074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/23] KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the
 documentation on TSC migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-17-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:06:37 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing TEST_REQUIRE() checks in pvclock_migrati=
on_test
- [Low] KVM: x86: doc per-vCPU KVM_SET_TSC_KHZ order breaks KVM_SET_CLOCK_G=
UEST
- [Low] KVM: x86: vcpu.rst drops source KVM_GET_TSC_KHZ step still used on =
dest
- [Low] KVM: selftests: VM memory leak in main() from using kvm_vm_release()
- [Low] KVM: selftests: duplicated pvclock and TSC scaling helpers in test
--

commit 17f0fed5469017ce773a7df8f640aab41b731a06
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Add KVM_VCPU_TSC_SCALE and fix the documentation on TSC migration

This commit adds the KVM_VCPU_TSC_SCALE device attribute to expose a vCPU's
TSC scaling ratio and fraction bits to userspace when hardware TSC scaling =
is
supported. It also updates the vCPU TSC migration documentation and adds a
selftest to verify kvmclock precision across simulated live migration.

> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/virt=
/kvm/devices/vcpu.rst
> index deb5c51bc00c8..3daa77c5d2150 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -239,6 +239,7 @@ including the layout of the stolen time structure.
>  :Architectures: x86
> =20
>  4.1 ATTRIBUTE: KVM_VCPU_TSC_OFFSET
> +----------------------------------

[ ... ]

> @@ -261,44 +265,110 @@ following describes a possible algorithm to use fo=
r this purpose.
> =20
>  From the source VMM process:
> =20
> -1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (tsc_src),
> +1. Invoke the KVM_GET_CLOCK ioctl to record the host TSC (host_tsc_src),
>     kvmclock nanoseconds (guest_src), and host CLOCK_REALTIME nanoseconds
> -   (host_src).
> +   (time_src) at a given moment (Tsrc). The host_tsc field is only valid
> +   when the returned flags include KVM_CLOCK_HOST_TSC.
> +
> +2. For each vCPU[i]:
> +
> +   a. Read the KVM_VCPU_TSC_OFFSET attribute to record the guest TSC off=
set
> +      (ofs_src[i]).
> +
> +   b. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scal=
ing
> +      ratio (ratio_src[i], frac_bits_src[i]). If the attribute is not
> +      supported (-ENXIO), there is no hardware TSC scaling and identity
> +      scaling applies: use ratio 1, frac_bits 0.
> =20
> -2. Read the KVM_VCPU_TSC_OFFSET attribute for every vCPU to record the
> -   guest TSC offset (ofs_src[i]).
> +   c. Use host_tsc_src and the scaling/offset factors to calculate this
> +      vCPU's TSC at time Tsrc:
> =20
> -3. Invoke the KVM_GET_TSC_KHZ ioctl to record the frequency of the
> -   guest's TSC (freq).
> +      tsc_src[i] =3D ((host_tsc_src * ratio_src[i]) >> frac_bits_src[i])=
 + ofs_src[i]
> +
> +      Note that frac_bits may be as high as 48, so this multiplication
> +      needs a 128-bit intermediate to avoid overflow.
> +
> +3. Invoke the KVM_GET_CLOCK_GUEST ioctl on the boot vCPU to return the K=
VM
> +   clock as a function of the guest TSC (pvti_src). (This ioctl may not
> +   succeed if the host and guest TSCs are not consistent and well-behave=
d.)

[Severity: Low]
Previously, step 3 on the source side instructed the VMM to invoke
KVM_GET_TSC_KHZ to record the guest TSC frequency (freq), which was replaced
here by KVM_GET_CLOCK_GUEST.

However, destination step 4 and step 7b below still reference freq and
freq[i]:

    tsc_dst[i] =3D tsc_src[i] + (=CE=94T * freq[i] / 10^6)

Should step 2 on the source side also include invoking KVM_GET_TSC_KHZ to
record freq[i] (or freq) for each vCPU?

>  From the destination VMM process:
> =20
> -4. Invoke the KVM_SET_CLOCK ioctl, providing the source nanoseconds from
> -   kvmclock (guest_src) and CLOCK_REALTIME (host_src) in their respective
> -   fields.  Ensure that the KVM_CLOCK_REALTIME flag is set in the provid=
ed
> -   structure.
> +4. Invoke the KVM_SET_TSC_KHZ ioctl to set the scaled frequency of the
> +   guest's TSC (freq) =E2=80=94 either on the VM before creating the vCP=
Us, or
> +   on each vCPU after creating it (as the exemplar test does).
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
> +
> +   a. Read the KVM_VCPU_TSC_SCALE attribute to record the guest TSC scal=
ing
> +      ratio (ratio_dst[i], frac_bits_dst[i]).
> +
> +   b. Calculate the intended guest TSC value at time Tdst, taking care
> +      with the units (=CE=94T is in nanoseconds; freq, as set by
> +      KVM_SET_TSC_KHZ, is in kHz):
> +
> +      tsc_dst[i] =3D tsc_src[i] + (=CE=94T * freq[i] / 10^6)
> =20
> -   KVM will advance the VM's kvmclock to account for elapsed time since
> -   recording the clock values.  Note that this will cause problems in
> -   the guest (e.g., timeouts) unless CLOCK_REALTIME is synchronized
> -   between the source and destination, and a reasonably short time passes
> -   between the source pausing the VMs and the destination executing
> -   steps 4-7.
> +   c. Use host_tsc_dst and the scaling factors to calculate this vCPU's
> +      raw scaled TSC at time Tdst without offsetting:
> +
> +      raw_dst[i] =3D ((host_tsc_dst * ratio_dst[i]) >> frac_bits_dst[i])
> +
> +   d. Calculate ofs_dst[i] =3D tsc_dst[i] - raw_dst[i] and set the resul=
ting
> +      offset using the KVM_VCPU_TSC_OFFSET attribute.
> +
> +8. If pvti_src was provided, invoke the KVM_SET_CLOCK_GUEST ioctl on the=
 boot
> +   vCPU to restore the KVM clock as a precise function of the guest TSC.

[Severity: Low]
Can following steps 4, 7, and 8 as written cause KVM_SET_CLOCK_GUEST in ste=
p 8
to fail with -ENODATA when a VMM uses per-vCPU KVM_SET_TSC_KHZ?

Step 4 allows calling KVM_SET_TSC_KHZ on each vCPU after creating it, while
step 7 is described as happening "As each vCPU[i] is created". If a VMM
reads KVM_VCPU_TSC_SCALE in step 7a as each vCPU is created before calling
per-vCPU KVM_SET_TSC_KHZ, KVM_VCPU_TSC_SCALE will return the unscaled defau=
lt
ratio (1 << tsc_frac_bits) rather than the scaled ratio for freq.

Furthermore, if a VMM creates and configures one vCPU at a time (creating
vCPU[0], calling per-vCPU KVM_SET_TSC_KHZ(vCPU[0], freq), and running step =
7,
then creating vCPU[1]), creating vCPU[1] invokes:

  kvm_arch_vcpu_create()
    -> kvm_set_tsc_khz(vcpu, kvm->arch.default_tsc_khz)
      -> __kvm_synchronize_tsc()

Because per-vCPU KVM_SET_TSC_KHZ does not update kvm->arch.default_tsc_khz,
vCPU[1] is initialized with the unscaled default_tsc_khz. In
arch/x86/kvm/x86.c:__kvm_synchronize_tsc():

	if (vcpu->arch.virtual_tsc_khz !=3D kvm->arch.cur_tsc_khz) {
		kvm->arch.cur_tsc_freq_generation++;
		kvm->arch.all_vcpus_matched_freq =3D false;
		kvm->arch.nr_vcpus_matched_freq =3D 0;
	}

This bumps cur_tsc_freq_generation to default_tsc_khz, and the subsequent
KVM_SET_TSC_KHZ(vCPU[1], freq) bumps cur_tsc_freq_generation again back to
freq, leaving vCPU[0] in an older generation with all_vcpus_matched_freq set
to false. When step 8 then invokes KVM_SET_CLOCK_GUEST,
pvclock_update_vm_gtod_copy() disables use_master_clock and
KVM_SET_CLOCK_GUEST fails with -ENODATA.

Should the documentation clarify that if per-vCPU KVM_SET_TSC_KHZ is used
instead of VM-scoped KVM_SET_TSC_KHZ, all vCPUs must be created and have
KVM_SET_TSC_KHZ applied before reading KVM_VCPU_TSC_SCALE and setting
KVM_VCPU_TSC_OFFSET in step 7?

[ ... ]

> diff --git a/tools/testing/selftests/kvm/x86/pvclock_migration_test.c b/t=
ools/testing/selftests/kvm/x86/pvclock_migration_test.c
> new file mode 100644
> index 0000000000000..c4a64b6a2e429
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/pvclock_migration_test.c

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

[Severity: Low]
This isn't a bug, but pvclock_read_cycles() duplicates __pvclock_read_cycle=
s()
from tools/arch/x86/include/asm/pvclock.h (already used by
tools/testing/selftests/kvm/x86/kvm_clock_test.c). In addition, main() later
open-codes the 128-bit TSC scaling calculation for raw_dst:

	if (scale_dst.tsc_frac_bits)
		raw_dst =3D (unsigned __int128)host_tsc_dst * scale_dst.tsc_ratio
			  >> scale_dst.tsc_frac_bits;
	else
		raw_dst =3D host_tsc_dst;

Could this test reuse __pvclock_read_cycles() and call
host_to_guest_tsc(&scale_dst, 0, host_tsc_dst) for raw_dst?

[ ... ]

> +int main(void)
> +{
> +	struct pvclock_vcpu_time_info pvti_src[NR_VCPUS];
> +	struct pvclock_vcpu_time_info pvti_dst_ioctl[NR_VCPUS];
> +	struct kvm_clock_data clock_src, clock_dst;
> +	struct kvm_vcpu_tsc_scale scale_src[NR_VCPUS], scale_dst;
> +	struct kvm_vcpu *vcpus[NR_VCPUS];
> +	struct kvm_vm *vm;
> +	u64 mono_before, kvm_before, kvm_after;
> +	s64 delta_before;
> +	u64 ofs_src[NR_VCPUS], tsc_src[NR_VCPUS], tsc_dst, raw_dst;
> +	u64 ofs_dst[NR_VCPUS];
> +	u64 host_tsc_src, host_tsc_dst;
> +	u64 time_src, time_dst;
> +	s64 delta_t;
> +	u32 freq_khz =3D 1500000; /* 1.5 GHz =E2=80=94 forces TSC scaling */
> +	int i, pass;
> +
> +	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));

[Severity: Medium]
What happens if this selftest is run on a kernel that supports
KVM_CAP_TSC_CONTROL, but does not support KVM_CAP_CLOCK_GUEST (or
KVM_VCPU_TSC_SCALE)?

In main(), the subsequent calls to vcpu_get_clock_guest(),
vcpu_set_clock_guest(), and vcpu_device_attr_get(..., KVM_VCPU_TSC_CTRL,
KVM_VCPU_TSC_SCALE, ...) unconditionally assert ioctl success, so the test
will fail with an assertion abort instead of skipping.

Should main() also check TEST_REQUIRE(kvm_has_cap(KVM_CAP_CLOCK_GUEST)) (li=
ke
pvclock_test.c, masterclock_offset_test.c, and xen_migration_test.c) and
verify that the vCPU has KVM_VCPU_TSC_SCALE via __vcpu_has_device_attr()?

[ ... ]

> +	/* Step 3: KVM_GET_CLOCK_GUEST (already fetched above as pvti_src[]) */
> +
> +	kvm_vm_release(vm);
> +
> +	/* =3D=3D=3D PAUSE (simulate migration) =3D=3D=3D */
> +	pr_info("=3D=3D=3D Pausing 1 second =3D=3D=3D\n");
> +	sleep(1);
> +
> +	/* =3D=3D=3D DESTINATION SIDE =3D=3D=3D */
> +	pr_info("=3D=3D=3D Destination VM =3D=3D=3D\n");
> +	/* Step 4: create + KVM_SET_TSC_KHZ (in create_vm) */
> +	vm =3D create_vm(vcpus, freq_khz);

[Severity: Low]
Does calling kvm_vm_release(vm) instead of kvm_vm_free(vm) here (and at the
end of main()) leak the VM's userspace_mem_regions mappings, sparsebit arra=
ys,
and struct kvm_vm when vm is overwritten by create_vm()?

In tools/testing/selftests/kvm/lib/kvm_util.c, kvm_vm_release() only frees =
the
vCPUs and closes the KVM file descriptors, whereas kvm_vm_free() unmaps the
memory regions, frees vpages_valid and vpages_mapped, calls kvm_vm_release(=
),
and frees struct kvm_vm.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D16
