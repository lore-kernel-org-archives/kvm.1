Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB2380FD1
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000151; cv=none; b=oGqRQbSuO4Jxj51EJ+0PAduS5acod34DqDd7Hw2y8RI2n4wyKx49Obgc+7iSMYcSsG6YpBCIX5agyCwGK8XDZ4RbgpVxHSkeNrLWE8e/Tvcaw2J5iydj1or1HP/gvRqMi02who+qlwGM2UhJUCLI4FOmzVlf3eKxvUZuyb4nyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000151; c=relaxed/simple;
	bh=YUs8GeodtkvKH9eZFQ4U79XSCiKN8fOp2qzV7emkOlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhEKOHZYS4M6jCNeeBI/jZpYFzF1Z8oSTSG6MHJtSEECCR85ox7f/lBIC1QWQzzI5cHEs/iHpBSa+uDPj6AO09+IekS1warZpzCTz66k7V93j9h0qirWltIducoDOxl7N5oGS3jjEotbZWfOXS9OVsU4A9YG6WAFgMYCzlwlWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPXv/+0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPXv/+0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2261F00899
	for <kvm@vger.kernel.org>; Sat,  3 Oct 2026 04:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791000147;
	bh=SxjjB1oI/rftVicE2UERYlrSuyQKp63GZUlub2afxZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CPXv/+0UUZfDgDnpso5YSwhETIATY81mqUljuQ2X6kyg7atkfv796rBnCczjc0CsN
	 MS0UKqOPXj/Dp/q+YHqyrt16g5iXb5jNyDkqdW4mlWzLbkuwwi6zs5YxWJhn/D4h03
	 KQVlWMoSTGEWqXNGZpR2IrAEXr2GVqud3qlDur4SYRrWdn3pDZf67tOktRcS4n9rHt
	 mfrfSAnP9cWuS3QR/yD8wbrNlzwVnxg8vE4K9oziBN9p7tth0d2gKFVeFjXdQC0jBS
	 /Rjo8VuCGyWwc01V0iVnuMAxKIjmYhKdbN67CzMOpubYPNRELB+RN4Jr/byjYIk/pG
	 me8pNhDfPEd5w==
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6ad186afdf4so153312a12.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 21:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzFOWfsD2z2pcqnBkf2MeSv50AfliMrpBjd/d8O+QfiZbxIVHqg7pTfogtmvMRfo3c45SE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV8LBREqkqXmV5KCBRoxK+/oq04D6OZ+lpyusqlqf0RUZ6E0Vx
	z7MEDovRp+gvRZRkGVb8AwnPxX0ncPvnXUng0c8gWu2FFQ84XL+45xLKQbReZQqyvp7TrmQ/ZnF
	7QgL7jmnkfZeFubZwd6ViwU/ZY86WCXQ=
X-Received: by 2002:a05:6402:24ce:b0:6a9:cc6d:ea4b with SMTP id
 4fb4d7f45d1cf-6af9e2e1526mr2668635a12.21.1791000146055; Fri, 02 Oct 2026
 21:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022118.2339780-1-maobibo@loongson.cn>
In-Reply-To: <20260910022118.2339780-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 3 Oct 2026 12:02:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6_bi6XxWs_4=AnVHieJqw2VpvHiA4LC6j6rB8dd4C28Q@mail.gmail.com>
X-Gm-Features: AclHuK8qVII_zYlkC2DqDFR7f-Fk_zUwEYaTDPqsShxgM18zTyQnn-0v5Iei_co
Message-ID: <CAAhV-H6_bi6XxWs_4=AnVHieJqw2VpvHiA4LC6j6rB8dd4C28Q@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: KVM: Allow to set pv_feature until vCPU run
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, Tao Cui <cui.tao@linux.dev>, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Thu, Sep 10, 2026 at 10:28=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Now pv_feature can be set only once, there is problem with VM migration.
> Where it is set when vCPU is created and after migration, here it is
> allowed to set for many times, until vCPU starts to run.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Rename ran_atleast_once with has_run for simplity.
>   2. Rebase on the latest version where there is pv_setting_lock
>      protection when modify pv_features of VM.
> ---
>  arch/loongarch/include/asm/kvm_host.h |  3 ++-
>  arch/loongarch/kvm/vcpu.c             | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/inclu=
de/asm/kvm_host.h
> index 65d91c3ce313..4ee1a29a5ea0 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -164,7 +164,6 @@ enum emulation_result {
>  #define KVM_LARCH_SWCSR_LATEST (0x1 << 3)
>  #define KVM_LARCH_HWCSR_USABLE (0x1 << 4)
>
> -#define LOONGARCH_PV_FEAT_UPDATED      BIT_ULL(63)
>  #define LOONGARCH_PV_FEAT_MASK         (BIT(KVM_FEATURE_IPI) |         \
>                                          BIT(KVM_FEATURE_PREEMPT) |     \
>                                          BIT(KVM_FEATURE_STEAL_TIME) |  \
> @@ -250,6 +249,8 @@ struct kvm_vcpu_arch {
>         struct dmsintc_state dmsintc_state;
>         /* cpucfg */
>         u32 cpucfg[KVM_MAX_CPUCFG_REGS];
> +       /* VCPU ran at least once */
> +       bool has_run;
>
>         /* paravirt steal time */
>         struct {
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 8e028be3f0a9..dbf87ac5252b 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1166,12 +1166,17 @@ static int kvm_loongarch_cpucfg_set_attr(struct k=
vm_vcpu *vcpu,
>
>                 /* All vCPUs need set the same PV features */
>                 spin_lock(&kvm->arch.pv_setting_lock);
> -               if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -                               && ((kvm->arch.pv_features & valid) !=3D =
val)) {
> +               if ((kvm->arch.pv_features & valid) =3D=3D val) {
> +                       spin_unlock(&kvm->arch.pv_setting_lock);
> +                       return 0;
> +               }
> +
> +               if (vcpu->arch.has_run) {
>                         spin_unlock(&kvm->arch.pv_setting_lock);
>                         return -EINVAL;
>                 }
> -               kvm->arch.pv_features =3D val | LOONGARCH_PV_FEAT_UPDATED=
;
> +
> +               kvm->arch.pv_features =3D val;
>                 spin_unlock(&kvm->arch.pv_setting_lock);
>                 return 0;
>         default:
> @@ -1858,6 +1863,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>         int r =3D -EINTR;
>         struct kvm_run *run =3D vcpu->run;
>
> +       /* Mark this VCPU ran at least once */
> +       if (!vcpu->arch.has_run)
> +               vcpu->arch.has_run =3D true;
> +
>         if (vcpu->mmio_needed) {
>                 if (!vcpu->mmio_is_write)
>                         kvm_complete_mmio_read(vcpu, run);
>
> base-commit: df2908090cda368b01ff43709f51890076c56157
> --
> 2.39.3
>
