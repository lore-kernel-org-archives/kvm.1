Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5D17B505
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490334; cv=none; b=cVOahbDgVjvqmw3+6qEdPPFB9sAEzvv7dNQ5LOGaIWguNNKIXnrCC5GRbukZ/U32wKM5VphM9Wgad85ciWY+xspPCHmbGeHWWRtLiIn0eXIZH6KUtoBNI03nim112WfErTq+dCZGK+aI4ahyKw1Dbrfq+3dZwT9IcFWcJ/ZeoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490334; c=relaxed/simple;
	bh=ezJdFuJ8copZhkxzsPJ68rmNpNs5rGCRNn9fgwICdlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBx3X3qGP9yu34dyYfWBFpF05lqsav1Fk3LB0Y42gCbQRsC2e5CngibUZmje+ws0no8aw4tl/dAjVsHRjfOZlUPsFNjeFbaj0KSGkf2csw0ndnnenwZ420OR67NzqO8fBlUW46LNAb45LRz88oPQ2GT/rdk0FGKnXq2IEMpCUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuxETuLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuxETuLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DF81F000E9;
	Fri, 31 Jul 2026 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490332;
	bh=1Cty7j/x/go5Ti7CTWjlkOX1OQHNv8gp9uFK0uehBU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SuxETuLSfMZCtlmx2d20pkho1Yj8V+ypkNMdFU4QRL5GjgV79VcKR29UeFwhHL/aC
	 XAC4eakI8SZG2gGLYGgdOGgcUv5JN0KbSMallXRUltOaqRmfp9kwFoJ1zKf39cNU75
	 5IuQ/oxUr0Apu9XJ5YFJpv0nwy4aghDX8sJB1erV29YGpzqwYKCGqkzcypjSk9U+pH
	 BJTbW8q+UnpTPZaxDJmKesu+CNabCbYU6nm2p7bHEnU65v65xgn3Eqikv6d2ghvrr5
	 NAqZGfBe5nZxLZL92vERk1itzvyRB/OtahLQWe9X+4LCiTqsuYAAXlGz2eegYP3jNV
	 Dy9WaelXbH2+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kvm: add EVER_MAPPED ioctl and capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Schmidt" <flosch@nutanix.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731091708.2963414-1-flosch@nutanix.com>
References: <20260731091708.2963414-1-flosch@nutanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:32:12 +0000
Message-Id: <20260731093212.A2DF81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The `ever_mapped_bitmap` is dynamically allocated during VM capabi=
lity enablement but never freed during VM teardown.
- [High] Buffer overflow and KASAN out-of-bounds access due to a byte-align=
ed allocation size being manipulated by unsigned long bit operations.
- [High] Missing `cond_resched()` in the fallback iteration loop allows a s=
ingle ioctl to monopolize the CPU, causing soft lockups.
- [High] `KVM_CAP_EVER_MAPPED` enablement succeeds based on the global `tdp=
_enabled` hardware flag, but silently fails to track memory if the legacy s=
hadow MMU is actively handling the VM.
- [Medium] Unvalidated `reserved` fields in `struct kvm_ever_mapped_log` br=
eak future ABI compatibility.
- [Medium] Lockless reading of `kvm->arch.ever_mapped_max_gpa` and `ever_ma=
pped_bitmap` can cause TOCTOU races and spurious errors.
--

--- Patch [1]: [PATCH] kvm: add EVER_MAPPED ioctl and capability ---
commit bb0c368d3b83d1838e5cca827b1430b4b426ca4d
Author: Florian Schmidt <flosch@nutanix.com>
Subject: kvm: add EVER_MAPPED ioctl and capability

This commit introduces a new capability, KVM_CAP_EVER_MAPPED, which allows a
VMM to track which guest pages have ever been mapped using a bitmap. It also
adds an ioctl, KVM_GET_EVER_MAPPED_LOG, to retrieve this tracking informati=
on.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0626e835e9eb7..89cbcf8399f49 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -2391,6 +2392,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  	case KVM_CAP_READONLY_MEM:
>  		r =3D kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
>  		break;
> +	case KVM_CAP_EVER_MAPPED:
> +		r =3D (tdp_enabled && IS_ENABLED(CONFIG_X86_64));
> +		break;

[Severity: High]
Does this successfully track memory when the VM is running under the legacy
shadow MMU?

If a VM uses the legacy shadow MMU (for example, with nested L2 guests or t=
he
kvm.tdp_mmu=3D0 module parameter), the page mappings are handled in mmu.c, =
which
bypasses the kvm_ever_mapped_set_range() hook added to tdp_mmu.c. Since this
check only verifies the global tdp_enabled hardware flag, could this silent=
ly
fail to track memory and cause userspace to observe a clean log when the pa=
ges
were actually modified?

[ ... ]

> @@ -4190,6 +4194,36 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		mutex_unlock(&kvm->lock);
>  		break;
>  	}
> +	case KVM_CAP_EVER_MAPPED: {
> +		unsigned long *mapped_bitmap;
> +		unsigned long num_granules;
> +
> +		r =3D 0;
> +		mutex_lock(&kvm->lock);
> +		if (!tdp_enabled) {
> +			r =3D -EOPNOTSUPP;
> +		} else if (kvm->arch.ever_mapped_bitmap) {
> +			r =3D -EEXIST;
> +		} else if (cap->args[0] =3D=3D 0 ||
> +			   cap->args[0] > (1ULL << kvm_host.maxphyaddr)) {
> +			r =3D -EINVAL;
> +		} else {
> +			num_granules =3D DIV_ROUND_UP(cap->args[0], 1ULL << KVM_EVER_MAPPED_S=
HIFT);
> +			mapped_bitmap =3D
> +				kvcalloc(BITS_TO_LONGS(num_granules),
> +					 sizeof(long), GFP_KERNEL_ACCOUNT);

[Severity: High]
Is this allocated memory ever freed?

When a VM is destroyed via the kvm_arch_destroy_vm() path, does it clean up
the ever_mapped_bitmap? An unprivileged process could repeatedly create VMs,
enable this capability, and destroy the VMs, potentially exhausting host
memory if the bitmap isn't explicitly freed.

> +			if (!mapped_bitmap)
> +				r =3D -ENOMEM;
> +			else {
> +				write_lock(&kvm->mmu_lock);
> +				kvm->arch.ever_mapped_bitmap =3D mapped_bitmap;
> +				kvm->arch.ever_mapped_max_gpa =3D num_granules << KVM_EVER_MAPPED_SH=
IFT;
> +				write_unlock(&kvm->mmu_lock);
> +			}
> +		}
> +		mutex_unlock(&kvm->lock);
> +		break;
> +	}

[ ... ]

> @@ -4197,6 +4231,73 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  	return r;
>  }
> =20
> +static int kvm_vm_ioctl_get_ever_mapped_log(struct kvm *kvm,
> +					    struct kvm_ever_mapped_log *log)
> +{
> +	u64 max_granules;
> +	unsigned int coarseness;
> +	unsigned long *bitmap;
> +	int r;
> +
> +	if (!kvm->arch.ever_mapped_bitmap)
> +		return -ENOENT;
> +
> +	if (log->flags)
> +		return -EINVAL;

[Severity: Medium]
Should we also validate that the reserved fields in the log structure are
strictly zero here?

If userspace leaves log->reserved uninitialized, stack garbage could be pas=
sed
in. Does this prevent safely repurposing these fields in the future without
breaking ABI compatibility with older binaries?

> +
> +	if (log->granule_shift < KVM_EVER_MAPPED_SHIFT || log->granule_shift >=
=3D 64)
> +		return -EINVAL;
> +
> +	max_granules =3D kvm->arch.ever_mapped_max_gpa >> log->granule_shift;

[Severity: Medium]
Could this lockless read of ever_mapped_max_gpa cause a TOCTOU race?

If this is called concurrently with KVM_CAP_EVER_MAPPED enablement, could t=
he
reader observe a non-NULL ever_mapped_bitmap but a stale max_gpa of 0 due to
compiler reordering or missing memory barriers?

If so, max_granules would evaluate to 0 and the ioctl might erroneously fail
with -EINVAL.

> +	if (log->num_granules > max_granules ||
> +	    log->first_granule > max_granules - log->num_granules)
> +		return -EINVAL;
> +
> +	/*
> +	 * For the case where the request uses the same granularity as our inte=
rnal
> +	 * tracking, and we are byte-aligned (the expected common case), we can
> +	 * just copy_to_user. Otherwise, we have to create a new bitmap to pass.
> +	 *
> +	 * We do not lock against concurrent vCPUs mapping new memory on any of
> +	 * these operations. Bits are set atomically and never cleared, so any =
race
> +	 * here is indistinguishable from a write happening after this handler
> +	 * finishes but before the caller reads the results.
> +	 */
> +	coarseness =3D log->granule_shift - KVM_EVER_MAPPED_SHIFT;
> +	if (coarseness =3D=3D 0 && !(log->first_granule & 7) && !(log->num_gran=
ules & 7)) {
> +		if (copy_to_user(log->bitmap,
> +				 (u8 *)kvm->arch.ever_mapped_bitmap + log->first_granule / 8,
> +				 log->num_granules / 8))
> +			return -EFAULT;
> +		return 0;
> +	}
> +
> +	bitmap =3D kvzalloc(DIV_ROUND_UP(log->num_granules, 8), GFP_KERNEL_ACCO=
UNT);

[Severity: High]
Does this allocation size safely accommodate the unsigned long bit operatio=
ns
that follow?

The buffer is allocated with exact byte granularity here using
kvzalloc(DIV_ROUND_UP(log->num_granules, 8), ...), but it is later populated
using __set_bit() which operates on 8-byte (unsigned long) boundaries.

If the requested size is not a multiple of 8 bytes (for example, 9 bytes for
65 granules), could __set_bit() access memory past the requested allocation
boundary and trigger a KASAN out-of-bounds splat?

> +	if (!bitmap)
> +		return -ENOMEM;
> +
> +	for (u64 gran =3D log->first_granule;
> +	     gran < log->first_granule + log->num_granules;
> +	     gran++) {

[Severity: High]
Can this loop monopolize the CPU and trigger a soft lockup?

If userspace calls this ioctl with unaligned parameters that bypass the
copy_to_user fast path, log->num_granules can be very large (up to 2^31 for=
 a
52-bit physical address space and a 2MB granule).

Does iterating over a potentially massive user-controlled scale without a
cond_resched() in this loop risk keeping the CPU occupied long enough to
trigger the soft lockup watchdog?

> +		unsigned long start =3D gran << coarseness;
> +		unsigned long end =3D start + (1UL << coarseness);
> +
> +		if (find_next_bit(kvm->arch.ever_mapped_bitmap, end, start) < end)
> +			__set_bit(gran - log->first_granule, bitmap);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731091708.2963=
414-1-flosch@nutanix.com?part=3D1
