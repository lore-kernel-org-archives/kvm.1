Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B82D3220
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355850; cv=none; b=a5V5bBnwcai4xh1vBETw768L29zRcGWW8oRQjBYKe2mSVeiqpTMkJ4aY+CrMZEziN5RiPPM/N6NYZL5rq+kdF5aqC5q/j/p3TqnTCOXMKyKfnBb7T9D1tLEqQtDz/9jdi68z68OnYabVzUmeTot3XaNcVTSbK3xguqHW95x+Rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355850; c=relaxed/simple;
	bh=TvYnR/ltIaelTos+dHVHzOAK7CmdrcVXLgcXGjS3ZSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g/p7U4lQqyP91WT8ev4aXAXlGY8NCq8SazbC7XJlg43v7CnftLEUgg5HBgpQeSs9bcAN40SMlryNXIKo9wy389WcFJY4pphZzu+l9KwDAFenE5xgpzVuw6Tl86YE0U7FsUegYEy3ALhRcKTePCP/sK0ZmGX/w3I9+t2MQGcXhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBbkB4gR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBbkB4gR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67C51F00893;
	Mon,  1 Jun 2026 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780355848;
	bh=120DccCjAEzGDYAqyppF5z7jxYCVYungHSksl/za1Ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PBbkB4gRCpnhxf90mIJOuejKtNMfDTbrQ/7CWZgSpqBZcRYeKfAvQewk0/du8DYa9
	 NoGzsQLxEL/w4uxK9bL9VpywpeJZ/Dqen3U9LE/Ja/+ITdPbW2gyJgSXmgF/CUjPqV
	 WhDuO5kqY5WICAdWuKsyecl0yM5CQ/2xgWS8y0ugPIeBAzMOCGJ/Zy+P++yyfgcbL9
	 skCS2yJt0c18inQ/Sm4NvYlad18baewhLm/kaJ/7KUiKawNlQM8BFvvqAuGXmiT6vd
	 kCWat6gzmJ9q9GeUQ1ScOw4h+3CToyVJHz4vbOLA4hUnwcMxK7hwokeYTHhwyodYIQ
	 61SbZNNhZr3NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: SEV: Do not allow intra-host
 migration/mirroring of SNP VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
References: <20260601-sev_snp_fixes-v2-1-611891b28a86@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 23:17:28 +0000
Message-Id: <20260601231728.C67C51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kvm->arch.vm_type` validation in `sev_vm_copy_enc_context=
_from` allows creating structurally inconsistent mirror VMs.
- [High] Missing `vmsa_features` copy in `sev_vm_copy_enc_context_from` bre=
aks SEV-ES mirror VMs that use features like `DEBUG_SWAP`.
- [High] Concurrent list modification of `owner_sev_info->mirror_vms` witho=
ut holding the owner VM's lock during mirror VM migration.
--

commit 5adb8a893221b0569310f07fd9fc7abca8088651
Author: Atish Patra <atishp@meta.com>

KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs

This commit rejects SNP source VMs in migration/mirroring until proper SNP
state transfer is implemented.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2142,7 +2142,8 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, u=
nsigned int source_fd)
>  		return ret;
> =20
>  	if (kvm->arch.vm_type !=3D source_kvm->arch.vm_type ||
> -	    sev_guest(kvm) || !sev_guest(source_kvm)) {
> +	    sev_guest(kvm) || !sev_guest(source_kvm) ||
> +	    sev_snp_guest(source_kvm)) {

[Severity: High]
This is a pre-existing issue, but I noticed a potential locking race when
an existing mirror VM is migrated via sev_vm_move_enc_context_from().

Locks are only acquired for the source mirror (source_kvm) and destination
VM (kvm):

arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
    ...
    ret =3D sev_lock_two_vms(kvm, source_kvm);
    if (ret)
        return ret;
    ...
}

Later, in sev_migrate_from(), it updates its owner's list of mirrors:

arch/x86/kvm/svm/sev.c:sev_migrate_from() {
    ...
    if (is_mirroring_enc_context(dst_kvm)) {
        struct kvm_sev_info *owner_sev_info =3D
            to_kvm_sev_info(dst->enc_context_owner);

        list_del(&src->mirror_entry);
        list_add_tail(&dst->mirror_entry, &owner_sev_info->mirror_vms);
    }
    ...
}

Since the required lock for enc_context_owner is omitted entirely, could
this concurrently modify the owner_sev_info->mirror_vms linked list if
userspace creates a new mirror via sev_vm_copy_enc_context_from(), which
locks the owner VM? Would this result in kernel list corruption?

>  		ret =3D -EINVAL;
>  		goto out_unlock;
>  	}
> @@ -2865,6 +2866,7 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, u=
nsigned int source_fd)
>  	 * created after SEV/SEV-ES initialization, e.g. to init intercepts.
>  	 */
>  	if (sev_guest(kvm) || !sev_guest(source_kvm) ||
> +	    sev_snp_guest(source_kvm) ||
>  	    is_mirroring_enc_context(source_kvm) || kvm->created_vcpus) {

[Severity: High]
This isn't a bug introduced by this patch, but this block seems to be
missing the kvm->arch.vm_type !=3D source_kvm->arch.vm_type check that
exists in sev_vm_move_enc_context_from().

Does this omission allow creating structurally inconsistent mirror VMs?
Userspace could potentially create a destination VM as KVM_X86_SNP_VM and
mirror a source VM of type KVM_X86_SEV_VM into it. Since KVM's core MMU
would treat the new VM as an SNP VM (due to arch.vm_type), but the SEV
code treats it as a legacy SEV VM (because ____sev_snp_guest evaluates
to false), could this produce an inconsistent internal state and allow
attaching guest_memfd to standard SEV VMs?

>  		ret =3D -EINVAL;
>  		goto e_unlock;

[Severity: High]
This is a pre-existing issue, but I noticed another detail in
sev_vm_copy_enc_context_from() just below this diff.

The initialization block for the mirror VM omits copying vmsa_features:

arch/x86/kvm/svm/sev.c:sev_vm_copy_enc_context_from() {
    ...
    mirror_sev->enc_context_owner =3D source_kvm;
    mirror_sev->active =3D true;
    mirror_sev->asid =3D source_sev->asid;
    mirror_sev->fd =3D source_sev->fd;
    mirror_sev->es_active =3D source_sev->es_active;
    mirror_sev->need_init =3D false;
    mirror_sev->handle =3D source_sev->handle;
    ...
}

This omits mirror_sev->vmsa_features =3D source_sev->vmsa_features.

Since SEV-ES VMs use vmsa_features to track capabilities like
SVM_SEV_FEAT_DEBUG_SWAP, would a mirrored SEV-ES VM incorrectly
initialize its vmsa_features to 0? When vCPUs are instantiated,
sev_es_init_vmcb() checks sev_vcpu_has_debug_swap(), which would evaluate
to false, resulting in misconfigured VMCB intercepts. Could this silently
drop important execution features for SEV-ES mirrors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-sev_snp_fi=
xes-v2-0-611891b28a86@meta.com?part=3D1
