Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562F32B13E
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780129415; cv=none; b=nveoN+eMUIqivjN8WQYUvHf71X27+NFZJQpxm4sO7wlk4nlVkyTnq3xaMQTg9D5zrQGTjKDQ/sKiBkcDzYxqM4Q/1Djwjd6/3jSTKHHxyjvnpkZAN4b+W4SGwAVja9My/HO30rqUq+MNsOEskue+E8pIvMMvAGV9IjMHDZbksIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780129415; c=relaxed/simple;
	bh=zvCLNRQgPWN4L1yo0WqYU8JuB4A2NvOVY4429UDBb5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=spuESwkoFzrvUcrDUTi8eSqveNIBI5LhcT9Dk5RfiNXXFUnjL3xlRvXkuo1/40aKz2O1DzHFnOauJVk5QhaJGxWECT4EcXsyBNCKhvvD6sxr97OIuoEW8uHMRVclrL3e7+CiHEYcL3qLR2vCFn2SSwspn1Rp2VHRh13XbQL0zQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJr2vDdz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJr2vDdz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113461F00893;
	Sat, 30 May 2026 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780129414;
	bh=N2j4QiTA3xmJfu8xV4KNZIcgKU1kDkDwhYzJCxIlm7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJr2vDdzkO64kLmfb96umK49rYoAvxX/oC+bvu/ASbX/2Bz1hpt5weZx7/alEmbXE
	 lYVhksYerV78eEZeS2ACy+bKXfgTojHtQZBW+ExoE2InvDHIU0omDm0zSTM08QWW+B
	 JZE3USJG9oQGuicXeAj9KUaYaXJXu9BloCdZ/PMmOC11k7Go1DYHREs13US4ordw/R
	 YKoWmF0BuJQ434cjP8LympvWN94eLBxle3nrJR2ITRS2KSAycQJz/TFfU81YHldzKo
	 6e9tvCvT+usUEPa4fMK2fDXFNjy+1mIAesIEh8Kd/RfnqsuSKUMiXm/YsBLLGWBLuh
	 lwFsTiu6ffQ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/27] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-23-seiden@linux.ibm.com>
References: <20260529155050.2902245-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:23:33 +0000
Message-Id: <20260530082334.113461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Calling `kvm_init_with_dev()` from a secondary/independent KVM=
 architecture backend (`kvm-s390-arm64`) causes catastrophic double-initial=
ization of the KVM core subsystem, leading to global state corruption and k=
ernel panics.
- [High] Integer underflow in `kvm_max_guest_address()` causes KVM to repor=
t an invalid, massively incorrect maximum IPA size on host systems with lim=
ited memory.
--

commit cceba4a7a6d94b89a1513f32f00ede5f3c39fa4c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Add basic arm64 kvm module

Add basic code for the new arm64 on s390 KVM implementation.
Add kernel module boilerplate code and trivial functions.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 0000000000000..591e2e874891a
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> +static u64 kvm_max_guest_address(void)
> +{
> +	u64 max_addr;
> +
> +	if (sclp.hamax =3D=3D U64_MAX)
> +		max_addr =3D TASK_SIZE_MAX;
> +	else
> +		max_addr =3D min_t(u64, TASK_SIZE_MAX, sclp.hamax);
> +	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;

[Severity: High]
If the host system has less than 1GB of addressable memory (i.e.,
sclp.hamax < 1GB - 1), will ALIGN_DOWN() evaluate to 0 and cause the
subsequent subtraction of 1 to underflow to U64_MAX?

> +}
[ ... ]
> +u32 get_kvm_ipa_limit(void)
> +{
> +	return fls64(kvm_max_guest_address() + 1) - 1;

[Severity: High]
Following the underflow in kvm_max_guest_address(), would this result in
fls64(U64_MAX + 1) - 1?

Since U64_MAX + 1 is 0 and fls64(0) returns 0, this calculates to -1, which
would be cast to 0xFFFFFFFF. Does this inadvertently return an invalid 32-b=
it
limit of 0xFFFFFFFF to userspace capability checks?

> +}
[ ... ]
> +static int __init kvm_s390_arm64_init(void)
> +{
> +	if (!sclp.has_aef)
> +		return -ENXIO;
> +
> +	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
> +				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);

[Severity: Critical]
Since kvm_init_with_dev() is a core KVM function that manipulates global
state, does calling it from a secondary KVM architecture backend cause a
double-initialization if the primary s390 KVM module is already active?

Loading this module while kvm.ko is active appears to invoke
INIT_LIST_HEAD() on a miscdevice already in the list, potentially corrupting
the doubly linked list and causing a panic on traversal.

Could it also allocate a duplicate kvm_vcpu_cache, overwriting the global
pointer and leaking the original cache?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D22
