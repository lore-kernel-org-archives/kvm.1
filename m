Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0751D3CB8F4
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932841; cv=none; b=o6edGpiaK5IgE69Iml+agwXJevL4LqmuDcqwWN2/nB+lmeaRLvKG79E6uQI6b5023SdXeWcW8UknQGtc0wSE7oj7wx83plWMRWVuMy7rR6hqMiU0OPjh1EUZE8EO4vRZZRyquX2Au1iqWZsBZk3Q+t9uy/AFk7xCtzkc7XR6hPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932841; c=relaxed/simple;
	bh=/oINTM2ZbCAsfgE0CDtrTAe0STZjVao7z/rcmC1Ij6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tkCKTioBNsRva/JgYLiIrfFMQ02f3A4WFV8NjdVfxvJny/dBW6AfMSpCWO+Ey3aBVue2aScmMmIWNISeLZkWlF0Ty625Rz/8I2vjqVzYK9ZJCFg3grkSEdkJ6UwQ/pYe3UAhMKh3mgBqjmkMEQCk8DMQufpKtNxw01zF9Py78Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdJFFxog; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdJFFxog"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACED1F00893;
	Mon,  8 Jun 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932839;
	bh=C0AZoZ6m1/cfJ6RS1zlCPCy8YPRBrraHjb4l8zoZN14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hdJFFxoghO6VdzFeMiDrCA+y8aJJlFPRPzAban34CV1mjdzN21zO+Sz5jV7K23skT
	 TAMfJP2X1u/u9onsb4MUVy7Qogxgyh/s7/DkneXOWfWGY0agXEM8Co/j1PZaJisVh8
	 Kpy5/XNvea2887qcabflvAEZnfxyX4O0qx7S8mFTU5WWwry0KR2TIw0xbg4bBL/agc
	 dApK8L2mCrGJwKYNCB5IBHOYYXoPifVvgyhYOizV+I1dkLc64aa73259m0Wvspo25u
	 /ADwR9WhNBKESf9PWsRKmyUxT55+P6zLbs9Qw7r9xScNC6vuOkCyEir6UFV48bFiw3
	 nc5TiRrECZCmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/34] KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for
 accurate KVM clock migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-5-dwmw2@infradead.org>
References: <20260608145455.89187-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:33:58 +0000
Message-Id: <20260608153358.DACED1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unbounded bitwise shift in `hvclock_to_hz()` triggered by user-con=
trolled input can cause Undefined Behavior (shift out-of-bounds) and a kern=
el panic (DoS).
- [Low] The KVM_[GS]ET_CLOCK_GUEST ioctls cause compilation failures in use=
rspace due to an incomplete type in the generic UAPI header.

Pre-existing issues:
- [High] Race condition in `kvm_guest_time_update` reads `kvmclock_offset` =
unsynchronized, leading to corrupt guest `system_time`.
--

commit fdd3f3e2e20605997654a24ac2e941cc677cf87b
Author: Jack Allister <jalliste@amazon.com>

KVM: x86: Add KVM_[GS]ET_CLOCK_GUEST for accurate KVM clock migration

This commit adds per-vCPU ioctls (KVM_GET_CLOCK_GUEST and KVM_SET_CLOCK_GUE=
ST)
to allow userspace to precisely save and restore the arithmetic relationship
between the guest TSC and the KVM clock across live migrations.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d9ef165df6a14..b7e5f6e3dc6c1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> +static u64 hvclock_to_hz(u32 mul, s8 shift)
> +{
> +	u64 tm =3D NSEC_PER_SEC << 32;
> +
> +	/* Maximise precision. Shift right until the top bit is set */
> +	tm <<=3D 2;
> +	shift +=3D 2;
> +
> +	/* While 'mul' is even, increase the shift *after* the division */
> +	while (!(mul & 1)) {
> +		shift++;
> +		mul >>=3D 1;
> +	}
> +
> +	tm /=3D mul;
> +
> +	if (shift > 0)
> +		return tm >> shift;

[Severity: High]
Can this result in an undefined bitwise shift? If userspace provides a
tsc_shift of 32 and a tsc_to_system_mul with 31 trailing zeroes (like
0x80000000), the loop will increment the shift 31 times. This results in a
total shift amount of 65. Since tm is a 64-bit integer, shifting it by 65
bits triggers undefined behavior. Does the validation in
kvm_vcpu_ioctl_set_clock_guest() need to enforce a limit on the combined
shift amount?

> +	else
> +		return tm << -shift;
> +}

[ ... ]

> +static int kvm_vcpu_ioctl_set_clock_guest(struct kvm_vcpu *v, void __use=
r *argp)
> +{

[ ... ]

> +	/*
> +	 * Calculate the guest TSC at the new reference point, and the
> +	 * corresponding KVM clock value according to user_hv_clock.
> +	 * Adjust kvmclock_offset so both definitions agree.
> +	 */
> +	guest_tsc =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
> +	user_clk_ns =3D __pvclock_read_cycles(&user_hv_clock, guest_tsc);
> +	ka->kvmclock_offset =3D user_clk_ns - ka->master_kernel_ns;

[Severity: High]
This is a pre-existing issue, but is it possible for concurrent updates to
cause a torn read in kvm_guest_time_update() now that this ioctl modifies
kvmclock_offset?

In kvm_guest_time_update(), master_kernel_ns is read safely inside the
pvclock_sc seqcount loop, but kvmclock_offset is read outside of it:

kvm_guest_time_update() {
        do {
                seq =3D read_seqcount_begin(&ka->pvclock_sc);
                ...
                master_kernel_ns =3D ka->master_kernel_ns;
        } while (read_seqcount_retry(&ka->pvclock_sc, seq));
        ...
        hv_clock.system_time =3D kernel_ns + v->kvm->arch.kvmclock_offset;
}

If kvm_vcpu_ioctl_set_clock_guest() modifies both variables under the seqco=
unt
write lock after the reader finishes the loop but before reading
kvmclock_offset, couldn't the guest receive a stale kernel_ns combined with=
 a
new kvmclock_offset?

> +
> +out:
> +	kvm_end_pvclock_update(kvm);
> +	return rc;
> +}

[ ... ]

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf3..9b50191b859cd 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1669,4 +1669,7 @@ struct kvm_pre_fault_memory {
>  	__u64 padding[5];
>  };
> =20
> +#define KVM_SET_CLOCK_GUEST	_IOW(KVMIO, 0xd6, struct pvclock_vcpu_time_i=
nfo)
> +#define KVM_GET_CLOCK_GUEST	_IOR(KVMIO, 0xd7, struct pvclock_vcpu_time_i=
nfo)
> +

[Severity: Low]
Does this cause compilation failures for userspace applications? The ioctls
use struct pvclock_vcpu_time_info which is defined in asm/pvclock-abi.h, but
that header is not included by linux/kvm.h. Since UAPI headers should be
self-contained, could this result in an 'invalid application of sizeof to
incomplete type' error?

>  #endif /* __LINUX_KVM_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D4
