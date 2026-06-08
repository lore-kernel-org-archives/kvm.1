Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2E31AA92
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961641; cv=none; b=gsyEWm9J7mdIvihjhCtvWEEnwEq1XAk8bqqSJQ+rcad4GSqs2eJRBWed0J7sy/MTn57euUydabSBjyJ5IX2fXRAFCE4f+T29kXKNBbyrVTXi1Zl7To9doJKD50m2IUJxYSx7Xq0w20Sd+joP7CsKtBKM41jYmCra7VjEWzHgrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961641; c=relaxed/simple;
	bh=3YFaEfzwQ2eJH+dd9dSIGTJaaW1QtMpALn44mMEcSMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVCmj90kMa7iaObbKwyELB/2M6ftLbFMOJqhY1JVSBqwcdThI/3IQqSqDWABqtEvEGosLgrntdyHveSIVB+Z+bHT66JLnFJEx/BKJHOIkG/AQUFHdGQCiOkZN5k/RNaId0J21lesDtlSJEbjWAlEMbFISM2rwY05RBWw/0A2ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8oQfYx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8oQfYx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644B01F00893;
	Mon,  8 Jun 2026 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780961639;
	bh=UXl50x9fS9Lwn7n9QeKSNCAI59lrsSshqlpgLBb2YIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8oQfYx9Murgpr+lZ+4F7MFSb3uURfgv6y4cBWSgeieio5axGAwUnmcOmTbbo3lPh
	 OiGwbjPA19WThKdr3JKHxZEZBn9IKBfXWGXbROxwXyCs2tcVrrn496LbWh7Q1p76LJ
	 oWHI1tDroiV51rzeskacEKc2+7L0KPYCYR0KjYYaTmp9B1y+Dm4vGYV37Wf+3wFb0W
	 WXjyCXcfOGfC9L5dl7KGf2Zx/7DHmMw5leIrxvywtflRxvQldN0lferBzoCY03pv1O
	 BuPmynhhUgTcgw69IA1OBBufJoQJcxrfsY3OE1rb3hOqUpg47+AWr+6XBPLFN98R5i
	 vnNHUuHws8sUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 59/60] kvm: svm: Implement max_planes x86 operation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-60-joro@8bytes.org>
References: <20260608144252.351443-60-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 23:33:59 +0000
Message-Id: <20260608233359.644B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] `sev_snp_max_planes()` can return 0, breaking the invariant that K=
VM_CAP_PLANES is at least 1 and potentially invalidating VM capability chec=
ks.
- [High] Data race in `svm_max_planes` leads to dynamic capability mutation=
 and can trigger a host-userspace reachable `WARN_ON_ONCE`.
- [Low] Dead declaration of `sev_nr_vcpu_planes()`.
- [Low] Mismatched return types for `sev_snp_max_planes()` across declarati=
ons, definitions, and fallback stubs.

Pre-existing issues:
- [Critical] Dangling plane pointer in error path of `kvm_vm_ioctl_create_p=
lane()` leads to a Double Free during VM destruction.
--

commit c8552c7d8852aecb64608575360c9abf90b077c5
Author: Tom Lendacky <thomas.lendacky@amd.com>

kvm: svm: Implement max_planes x86 operation

Report the number of VMPL levels supported by SEV-SNP guests.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 70a06769a4100..4a6166d2a71df 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -5832,3 +5837,8 @@ bool sev_snp_blocked(enum inject_type type, struct =
kvm_vcpu *vcpu)
> =20
>  	return blocked;
>  }
> +
> +int sev_snp_max_planes(struct kvm *kvm)
> +{
> +	return vmpl_levels;
> +}

[Severity: High]
Can this return 0 and break the KVM_CAP_PLANES invariant?

If the CPU supports only VMPL0, the value extracted directly from CPUID
0x8000001F_EBX[15:12] will be 0. Returning 0 without adjusting it contradic=
ts
KVM's invariant that all VMs have at least 1 plane.

Could this invalidate capability discovery and prevent userspace from
creating any vCPUs if planes are required?

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 2ae82dc058c96..705063c7f0f0a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5321,6 +5321,16 @@ static void svm_free_plane(struct kvm_plane *plane)
>  	kfree(svm_plane);
>  }
> =20
> +static unsigned svm_max_planes(struct kvm *kvm)
> +{
> +#ifdef CONFIG_KVM_AMD_SEV
> +	if (____sev_snp_guest(kvm))
> +		return sev_snp_max_planes(kvm);
> +#endif

[Severity: High]
Can this lockless check observe torn state and trigger a WARN_ON_ONCE?

KVM_CAP_PLANES delegates to svm_max_planes(), which userspace can call
locklessly at any time via KVM_CHECK_EXTENSION. The call to
____sev_snp_guest() performs a lockless read of sev->vmsa_features and
sev->es_active.

If queried concurrently with KVM_SEV_INIT (which populates these fields
non-atomically under kvm->lock), this lockless check could observe
SVM_SEV_FEAT_SNP_ACTIVE as true while es_active evaluates to false. This
triggers the WARN_ON_ONCE(!____sev_es_guest(kvm)), allowing an unprivileged
host-userspace process to cause a host denial of service via kernel log
flooding or panic if panic_on_warn is set.

[Severity: Critical]
This is a pre-existing issue, but does exposing max_planes > 1 trigger a
double free during VM destruction?

In the error path of kvm_vm_ioctl_create_plane(), if anon_inode_getfile()
fails, kvm_destroy_one_plane() is called, but it leaves a dangling pointer
in kvm->planes[id]:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_plane() {
    ...
    kvm_create_plane(kvm, id);
    ...
    fd =3D anon_inode_getfile(...);
    if (IS_ERR(fd)) {
        ...
put_kvm:
        kvm_destroy_one_plane(plane);
    }
}

When the VM is later destroyed, kvm_destroy_planes() loops over kvm->planes
and calls kvm_destroy_one_plane() on the dangling pointer. Previously this
was unreachable because max_planes was hardcoded to 1 and kvm->planes[0]
is always initialized at VM creation, safely returning -EEXIST early. Now
that max_planes can be greater than 1, this double free becomes reachable.

> +
> +	return kvm_x86_default_max_planes(kvm);
> +}

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 61f9c4cb4f52a..0c9b81029e241 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -1005,6 +1005,8 @@ static inline bool sev_snp_is_rinj_active(struct kv=
m_vcpu *vcpu)
>  	return is_sev_snp_guest(vcpu) &&
>  		(sev->vmsa_features & SVM_SEV_FEAT_RESTRICTED_INJECTION);
>  };
> +int sev_nr_vcpu_planes(struct kvm *kvm);

[Severity: Low]
Is sev_nr_vcpu_planes() a dead declaration? This function doesn't appear
to be defined or used anywhere in the codebase.

> +int sev_snp_max_planes(struct kvm *kvm);
>  #else
>  static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
>  {

[ ... ]

> @@ -1048,6 +1050,7 @@ static inline bool sev_snp_inject(enum inject_type =
type, struct kvm_vcpu *vcpu)
>  static inline void sev_snp_cancel_injection(struct kvm_vcpu *vcpu) {}
>  static inline bool sev_snp_blocked(enum inject_type type, struct kvm_vcp=
u *vcpu) { return false; }
>  static inline bool sev_snp_is_rinj_active(struct kvm_vcpu *vcpu) { retur=
n false; }
> +static inline unsigned sev_snp_max_planes(struct kvm *kvm) { return 1; }
>  #endif

[Severity: Low]
Does sev_snp_max_planes() have mismatched return types?

It is declared and defined as returning an int, but this fallback stub
returns unsigned. It is also assigned to svm_max_planes() which returns
unsigned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D59
