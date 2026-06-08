Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E5346FA1
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936408; cv=none; b=n2CrflANmZRRwe3ZkCrOPyo6i2OJ+bu9krfERjt8XmKAeSHAGOfZM8m7hRq0wiMeFBceXUirJ4AMAbIzBaT/ffm11ucueTvYbC/dGEEu8kQf6BRK9oBK2aLlpG6ybc+x9jNrfgudFG5sL6qW9H2nwIkAraVtnG0TbMWmZ408BF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936408; c=relaxed/simple;
	bh=ThSD456LWuO90BIMuraMnwwb3Nde8gxSQJ/IAG9hmLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FdO1sfH3UCsNxedevITmMYX4IQihKY/mv1tAGHGQlL3AVdnIMRyW4kwujoXn6Z9R9x51DXCggwoW5p40KSZD6LSiop4LP1cdp72DPHaQpZ8N2GQtcRz3LgK2AvoFkebfkrSU9/+EnLrdVixEel1ANLgjpW/EZrVT97c59xt05wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqcPmYdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqcPmYdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B801F00893;
	Mon,  8 Jun 2026 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936407;
	bh=2QI6u7R4Jnin1/WsYXdJrM5hfyIyzoVl00qJ2VySUuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqcPmYdSXjQVjjQ57KsaCDFdIIDRZ7Qk1GEWX5PNNuUDKdT41xXFPBN2f5iProoeM
	 cfxrzyL+6t95E69PfT0VS5vcgDJRCECOlWfFf+4lBlYDiT42+gNwbmwkRcRw3y9h8G
	 VnSCWEqz09Mu4DTaTQBtJ0wF0ZybD4WBuMoKUQ4bPlAyx/GWUCOhmg5hp0It53H6XD
	 glbA4etke01SKaltZmjQgdQFRX9jWQaX4QSyPh3KFISdU5bjgtSUDNQZ630McTJ/Wo
	 i4RQ8ROPDvPP5+XJisjvOf9MuD9lHIENRt7fsBek10YaFqiHR9PNoAHBsLigF0a3ur
	 bN4MQxz887OdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/60] kvm: Introduce per-plane VCPU requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-22-joro@8bytes.org>
References: <20260608144252.351443-22-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:33:26 +0000
Message-Id: <20260608163326.E5B801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] TOCTOU race condition bypassing the `max_vcpus` limit due to b=
roken `created_vcpus` accounting, leading to a host stack buffer overflow.
--

commit 621fb80759c0391b7de8533a2106e6298a930411
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Introduce per-plane VCPU requests

This commit introduces per-plane VCPU requests by adding a new bitfield
flag to indicate request scope. It adds plane_requests to struct kvm_vcpu
and modifies the request macros to route calls to the appropriate bitmap.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7704820986da5..3c72a462ccfa3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h

[ ... ]

> @@ -371,6 +373,10 @@ struct kvm_vcpu {
>  	int sigset_active;
>  	sigset_t sigset;
>  	unsigned int halt_poll_ns;
> +
> +	u64 plane_requests;
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing the VCPU
changes, I noticed a pre-existing TOCTOU race that can bypass the max_vcpus
limit and lead to a host stack buffer overflow.

In virt/kvm/kvm_main.c:kvm_plane_ioctl_create_vcpu(), the limit check
happens under kvm->lock, but the lock is dropped before the vCPU is actually
accounted for:

mutex_lock(&kvm->lock);
if (kvm->created_vcpus >=3D kvm->max_vcpus) {
        mutex_unlock(&kvm->lock);
        return -EINVAL;
}
r =3D kvm_arch_vcpu_precreate(kvm, id);
mutex_unlock(&kvm->lock);

The kvm->created_vcpus counter is only incremented much later in
virt/kvm/kvm_main.c:kvm_vcpu_init_common() after re-acquiring the lock:

mutex_lock(&kvm->lock);
kvm->created_vcpus++;
mutex_unlock(&kvm->lock);

Could this allow concurrent KVM_CREATE_VCPU ioctls to bypass the limit and
create up to KVM_MAX_VCPU_IDS vCPUs, resulting in an online_vcpus count
that exceeds KVM_MAX_VCPUS?

If so, multiple code paths allocate fixed-size bitmaps on the host kernel
stack and iterate over all online vCPUs. For example, in
arch/x86/kvm/ioapic.c:ioapic_write_indirect():

DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
...
kvm_bitmap_or_dest_vcpus(ioapic->kvm->planes[0], &irq, vcpu_bitmap);

And then in arch/x86/kvm/lapic.c:kvm_bitmap_or_dest_vcpus():

plane_for_each_vcpu(i, vcpu, plane) {
        ...
        __set_bit(i, vcpu_bitmap);
}

Does this sequence result in an out-of-bounds write on the stack if a
malicious guest triggers the race and subsequently writes to the IOAPIC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D21
