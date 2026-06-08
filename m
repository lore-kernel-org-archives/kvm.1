Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A33793DC
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942401; cv=none; b=Y85bB6tT+lBPo60UqUQ4mD0l5jAyWHv/LR3w11CsVL6weHkIzgzM6zBbzSzlc6RrZQq4gU5DcJzOPnAE+qMPBKUzKNDmF6nnn0bFceLxqU8pRECkaz4zAZxjo86s6qB2oFli16kCpmE+k83x9y690A1pZBG4BXJaXkcnuphY2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942401; c=relaxed/simple;
	bh=nX7w5ur2/LQalVO/pavpa/MvABAmjXT4z8B1tHWukqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCIdNUfeDBdOMY80dI8F1llvQPii/q+x0z7Btdbu9T3YKgPnEDEsIiDA0pBh3glfmSahEl5dEPQCcOYyjlfMJWtlWRI6DVsNDBKH413w99k1RfAJoBJH8CFdadIFOL2A3KJCZq/r9xuspREOqI3p8ZCETMftq+sSU6ftnIHZeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbTnyzzP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbTnyzzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C231F00893;
	Mon,  8 Jun 2026 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942399;
	bh=JOOq2TFtxDmbMvElaCa5d72t4AgMHSDiZBdXKAmeT3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XbTnyzzPbk2mkn2FeEKH9XEL4SrrHaDNoY187nAOge53x+8Gv04VEcieTM7zvZ4NZ
	 WpCDZD8rlOCc5CEzhVp1EjgcWrPxC4s5mhAVy5bGXe+pkK0DT9ixpCgvDgAWCcSiPA
	 zS18L52UXZgtkdbVep9kv/OTWNxIIPmG3nSwXIxPTUmsP+fmc5UFGscHFLLcsIitdG
	 1tTfBH1J1Sx6DFDUhb3jeKsZPhmuN4EYpASaxk7gDsegpuAoEioqawqMdYa2IH8kMp
	 yiB/192+3Xu5+fVV9/6R/p8qDjOnKrnoTIOMZAIvpI8wyXf3PN0e6W43uZqTEN1z1C
	 GaSDoeWor7RCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 33/60] KVM: Implement KVM_CREATE_VCPU ioctl for planes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-34-joro@8bytes.org>
References: <20260608144252.351443-34-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:13:19 +0000
Message-Id: <20260608181319.C7C231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Error cleanup paths for secondary plane vCPUs erroneously dest=
roy the shared `vcpu->common` struct, leading to a Use-After-Free.
- [High] Moving the vCPU ID uniqueness check outside kvm->lock introduces T=
OCTOU races allowing duplicate IDs and Use-After-Free during lockless itera=
tion.
- [High] The global `max_vcpus` check incorrectly blocks the creation of se=
condary plane vCPUs.
- [High] Invoking `kvm_vcpu_finish_common` for secondary plane vCPUs inflat=
es `online_vcpus`, corrupting `vcpu_idx` tracking.
- [High] `kvm_wait_for_vcpu_online` prematurely bypasses serialization for =
secondary plane vCPUs due to shared `vcpu_idx`.
- [High] Secondary plane vCPUs are permanently leaked upon VM destruction.
- [Medium] Compat (32-bit) userspace can bypass plane restrictions to execu=
te KVM_SET_SIGNAL_MASK on secondary plane vCPUs.
- [Low] Incorrect argument ordering in snprintf results in confusing debugf=
s directory names for secondary plane vCPUs.
--

commit 37dfbdb6cd414eb1fae3e8d12818fac2b59a5e31
Author: Joerg Roedel <joerg.roedel@amd.com>

Implement the KVM_CREATE_VCPU ioctl per plane.

This commit implements the KVM_CREATE_VCPU ioctl on a per-plane basis and
introduces an empty IOCTL path for plane-vcpus. It also introduces
architecture-specific callbacks to check if an ioctl is a vcpu plane ioctl.

[ ... ]
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 385e1ee8fd3a..b8c3f8f11cb4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1126,7 +1126,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct =
kvm *kvm, int i)
>  #define kvm_for_each_vcpu(idx, vcpup, kvm)					\
>  	plane_for_each_vcpu(idx, vcpup, kvm->planes[0])

[Severity: High]
Does this macro definition permanently leak secondary plane vCPUs upon VM
destruction?

Since kvm_destroy_vcpus() relies on kvm_for_each_vcpu() to iterate and free
all vCPUs, it seems it will now silently skip all vCPUs created on secondary
planes (where plane->level > 0), leaking their struct kvm_vcpu and
architectural state.

[ ... ]
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2d0d5f4fd356..8839f91fd15e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -4327,13 +4328,17 @@ DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_g=
et_pid, NULL, "%llu\n");
> =20
>  static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
>  {
> +	char dir_name[10 + (2 * ITOA_MAX_LEN) + 1];
>  	struct dentry *debugfs_dentry;
> -	char dir_name[ITOA_MAX_LEN * 2];
> =20
>  	if (!debugfs_initialized())
>  		return;
> =20
> -	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
> +	if (vcpu->plane_level =3D=3D 0)
> +		snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
> +	else
> +		snprintf(dir_name, sizeof(dir_name), "vcpu%d-plane%d", vcpu->plane_lev=
el, vcpu->vcpu_id);

[Severity: Low]
Are the arguments to snprintf() reversed here?

The format string is "vcpu%d-plane%d", but the arguments are
vcpu->plane_level followed by vcpu->vcpu_id. Will this result in confusing
directory names like "vcpu1-plane5" instead of "vcpu5-plane1"?

> +
>  	debugfs_dentry =3D debugfs_create_dir(dir_name,
>  					    vcpu->kvm->debugfs_dentry);
>  	debugfs_create_file("pid", 0444, debugfs_dentry, vcpu,
> @@ -4346,10 +4351,11 @@ static void kvm_create_vcpu_debugfs(struct kvm_vc=
pu *vcpu)
>  /*
>   * Creates some virtual cpus.  Good luck creating more than one.
>   */
> -static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> +static int kvm_plane_ioctl_create_vcpu(struct kvm_plane *plane, unsigned=
 long id)
>  {
> -	int r =3D -EINVAL;
> +	struct kvm *kvm =3D plane->kvm;
>  	struct kvm_vcpu *vcpu;
> +	int r;
> =20
>  	mutex_lock(&kvm->lock);
>  	if (kvm->created_vcpus >=3D kvm->max_vcpus) {

[Severity: High]
Does this global kvm->max_vcpus check incorrectly block the creation of
secondary plane vCPUs?

Since kvm->created_vcpus is only incremented inside kvm_vcpu_init_common()
(which is only called for plane 0), it reflects the number of plane 0 vCPUs.
If a VM fully populates plane 0, won't this check permanently reject the
creation of any secondary plane vCPUs by returning -EINVAL?

> @@ -4366,11 +4372,28 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *k=
vm, unsigned long id)
>  	if (!vcpu)
>  		return -ENOMEM;
> =20
> -	r =3D kvm_vcpu_init_common(vcpu, kvm, id);
> -	if (r)
> +	r =3D -EEXIST;
> +	if (plane_get_vcpu_by_id(plane, id))
>  		goto vcpu_free;

[Severity: High]
Does moving the vCPU ID uniqueness check outside kvm->lock introduce a TOCT=
OU
race?

If two threads concurrently create a vCPU with the same ID, both could see =
NULL
from plane_get_vcpu_by_id(), complete creation, and insert duplicate vCPUs =
into
plane->vcpu_array. Can this lead to Use-After-Free during lockless iteratio=
n of
the xarray?

> =20
> +	if (plane->level > 0) {
> +		struct kvm_vcpu *vcpu_plane0 =3D kvm_get_vcpu_by_id(kvm, id);
> +
> +		/* Plane0 VCPU must exist before creating non-plane0 VCPUs */
> +		r =3D -EINVAL;
> +		if (vcpu_plane0 =3D=3D NULL)
> +			goto vcpu_free;
> +
> +		vcpu->common =3D vcpu_plane0->common;
> +	} else {
> +		r =3D kvm_vcpu_init_common(vcpu, kvm, id);
> +		if (r)
> +			goto vcpu_free;
> +	}
> +

[Severity: Critical]
Could the error path in kvm_plane_ioctl_create_vcpu() cause a use-after-free
for the plane 0 vCPU?

For plane->level > 0, vcpu->common is an alias to vcpu_plane0->common. If an
initialization step fails and the code jumps to the vcpu_free_common label,
it will call kvm_vcpu_common_destroy(vcpu). Won't this free the run pages a=
nd
other state that is actively being used by the already-running plane 0 vCPU?

[Severity: High]
Does invoking kvm_vcpu_finish_common() for secondary plane vCPUs corrupt
vcpu_idx tracking?

kvm_vcpu_finish_common() unconditionally increments kvm->online_vcpus for a=
ll
created vCPUs. However, vcpu_idx is derived strictly from online_vcpus insi=
de
kvm_vcpu_init_common(), which is only executed for plane 0. Creating second=
ary
plane vCPUs will inflate online_vcpus, causing the next plane 0 vCPU to rec=
eive
an unexpectedly high, non-contiguous vcpu_idx. Will this sparse vcpu_idx ar=
ray
trigger out-of-bounds accesses or premature KVM_MAX_VCPUS limit hits?

[ ... ]
> @@ -4550,7 +4568,7 @@ static int kvm_wait_for_vcpu_online(struct kvm_vcpu=
 *vcpu)
> =20
>  	/*
>  	 * Acquire and release the vCPU's mutex to wait for vCPU creation to
> -	 * complete (kvm_vm_ioctl_create_vcpu() holds the mutex until the vCPU
> +	 * complete (kvm_plane_ioctl_create_vcpu() holds the mutex until the vC=
PU
>  	 * is fully online).
>  	 */
>  	if (mutex_lock_killable(kvm_vcpu_mutex(vcpu)))

[Severity: High]
Does this serialization check evaluate to true prematurely for secondary pl=
ane
vCPUs?

kvm_wait_for_vcpu_online() bypasses its lock if:
  vcpu->vcpu_idx < atomic_read(&kvm->online_vcpus)

For a secondary plane vCPU, vcpu->vcpu_idx is inherited from the already-on=
line
plane 0 vCPU, so kvm->online_vcpus is already greater than this vcpu_idx. W=
ill
concurrent threads bypass this lock and interact with partially initialized
vCPU state?

[ ... ]
> @@ -4858,6 +4895,21 @@ static long kvm_vcpu_compat_ioctl(struct file *fil=
p,
>  }
>  #endif
> =20
> +static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioct=
l, unsigned long arg)

[Severity: Medium]
Does the compat ioctl handler bypass the new plane restrictions?

The check for kvm_is_vcpu_plane_ioctl() was added to kvm_vcpu_ioctl(), but =
not
to kvm_vcpu_compat_ioctl(). Can a 32-bit task execute ioctls like
KVM_SET_SIGNAL_MASK on secondary plane vCPUs by bypassing this allowlist?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D33
