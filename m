Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185D3559D6
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103512; cv=none; b=s9kw5VqOVDVoMR+f4/q4yYItqUrNe1MnFNio8XblX7QcMt0L0nSZJbZY/no0p0OjBaHSCjPRuL1f9/NtokxkolG0cp3q7FeIO5XbfF9DbyXNJNkMAqnX4vv4t8uyL5ogfzji8s86t65ywraL14sZZ7+5S7ssFrRHg8D16sl4uIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103512; c=relaxed/simple;
	bh=n1kH2uWiJhVGNczU2jxYw7CBHv4kIWMvsjIHmcs/NSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a4we7VUqbmOy5RyfNlCooTphJEMdkQZXVuRgaj8a4SvR9/CPYu/WuACJXkSUdshUVH38YqTXu5No3+wXcoMqrMpq55zVoLxMXBdD8BS9Ug8fHkLf4aIW+012aaPinUybT2ox20d1/pRTh0edTp8kxvwLJA6I8JirnPPk9KBM/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aue4WPFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aue4WPFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7981F000FF;
	Fri, 11 Sep 2026 05:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789103510;
	bh=2zsGdJgrWT9f2U8vDYwknXos3Y19kG5lTNnVD8omHzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aue4WPFFqsC9BegryxcM0zAZ74NDH98meCGWLHFHHVyLidupF9iUJj4rFhBVBgN4J
	 qM2hIJNdbAOF/gIMfJmy/bOul/cgR7kAUOMhiLwcKlqVzptrkdmpY8WBEfAsr7bs7J
	 +1KTXL/YnE+aDQdXymrElTh+bdgmUMfwT1HKxx64OxY72T3GeRgdjcbv4tobUkWifo
	 s7imNI1Z1GkxTflpaIcQG1Fp0in4jcfHsQ7n3Gu1i42EnEL+dWxChkW3WRgVp12A8s
	 SinhhZJCq+8d3ZdCsubJUVgw6uGYdtQXNwiFmd9p99cWnRQFxKmrUb+0O9f6//SKKf
	 buPNQq7jL2cdQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 3/3] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR
 limit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Uml0ZXNoIEhhcmphbmkgKElCTSk=?= <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <e2c1ef05eaa19beb28a3db08fb697a80528cd43a.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
 <e2c1ef05eaa19beb28a3db08fb697a80528cd43a.1789099725.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 05:11:49 +0000
Message-Id: <20260911051150.6E7981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Build failure on non-HV configurations (e.g. BookE or PR-only build=
s) due to undeclared identifier KVM_MAX_VCPU_IDS_NESTEDv2.

Pre-existing issues:
- [High] The patch correctly caps the reported KVM capabilities for nestedv=
2 maximum vCPUs and vCPU IDs to 2048, but it fails to enforce this limit du=
ring actual vCPU creation. A malicious userspace can bypass the capability =
check and pass a vcpu_id >=3D 2048, causing the L0 hypervisor to reject it =
and triggering an unbounded pr_err() log spam in the host kernel.
--

commit 603e4503cd207cc17d84e5e865ff47b744a57762
Author: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit

This commit limits the maximum number of vCPUs and vCPU IDs reported by KVM
for nestedv2 guests to 2048, as dictated by the PAPR specification. It upda=
tes
KVM_CAP_NR_VCPUS, KVM_CAP_MAX_VCPUS, and KVM_CAP_MAX_VCPU_ID when
kvmhv_is_nestedv2() is true.

> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/a=
sm/kvm_host.h
> index 2d139c8075773..d48232557259c 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -37,6 +37,7 @@
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  #include <asm/kvm_book3s_asm.h>		/* for MAX_SMT_THREADS */
>  #define KVM_MAX_VCPU_IDS	(MAX_SMT_THREADS * KVM_MAX_VCORES)
> +#define KVM_MAX_VCPU_IDS_NESTEDv2	2048	/* PAPR H_GUEST_CREATE_VCPU vcpuI=
d */
> =20
>  /*
>   * Limit the nested partition table to 4096 entries (because that's what
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1ca..cf620b6534de6 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -663,12 +663,18 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  			r =3D min(num_present_cpus(), KVM_MAX_VCPUS);
>  		else
>  			r =3D min(num_online_cpus(), KVM_MAX_VCPUS);
> +		if (kvmhv_is_nestedv2())
> +			r =3D min(r, KVM_MAX_VCPU_IDS_NESTEDv2);

[Severity: Low]
Will this cause a build failure on non-HV configurations?

Since KVM_MAX_VCPU_IDS_NESTEDv2 is defined inside an
#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE block in asm/kvm_host.h, but the
KVM_CAP_NR_VCPUS case in kvm_vm_ioctl_check_extension() sits outside of that
#ifdef block, using it unconditionally here could result in an undeclared
identifier error for builds without HV support (like BookE or PR-only).

>  		break;
>  	case KVM_CAP_MAX_VCPUS:
>  		r =3D KVM_MAX_VCPUS;
> +		if (kvmhv_is_nestedv2())
> +			r =3D min(r, KVM_MAX_VCPU_IDS_NESTEDv2);
>  		break;
>  	case KVM_CAP_MAX_VCPU_ID:
>  		r =3D KVM_MAX_VCPU_IDS;
> +		if (kvmhv_is_nestedv2())
> +			r =3D min(r, KVM_MAX_VCPU_IDS_NESTEDv2);

[Severity: High]
This is a pre-existing issue, but does capping the reported capability prev=
ent
userspace from actually creating vCPUs with IDs >=3D 2048?

While this patch fixes the capability reporting, a malicious userspace proc=
ess
can still bypass the capability check and pass a vcpu_id >=3D 2048 to the
KVM_CREATE_VCPU ioctl.

If this happens, it appears kvm_arch_vcpu_precreate() in
arch/powerpc/kvm/powerpc.c will still allow it:

int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
{
	return 0;
}

This could cause the L0 hypervisor to reject it in
kvmhv_nestedv2_vcpu_create() in arch/powerpc/kvm/book3s_hv_nestedv2.c, which
contains an unratelimited pr_err() log:

	rc =3D plpar_guest_create_vcpu(0, vcpu->kvm->arch.lpid, vcpu->vcpu_id);

	if (rc !=3D H_SUCCESS) {
		pr_err("KVM: Create Guest vcpu hcall failed, rc=3D%ld\n", rc);

Could this be used by an unprivileged host user with /dev/kvm access to
trigger an unbounded log spam and cause a local Denial of Service (DoS)?
Should architecture-specific bounds checking be added to
kvm_arch_vcpu_precreate() to reject vcpu_ids >=3D KVM_MAX_VCPU_IDS_NESTEDv2
before proceeding with vCPU creation?

>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789099725.gi=
t.ritesh.list@gmail.com?part=3D3
