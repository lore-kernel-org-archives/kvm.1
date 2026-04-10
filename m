Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301283D47C4
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831682; cv=pass; b=KN9GTDvW6+sFjnfBHlVLfZQ49q8GIxnNic5TkTJCAfVqwiwlkHHrLFdtD5MrhpG9eimvHOrZbhRQWvjgEKG/t62PRKd1Uqzdxa8xd2tXwVdDTsYewtlh5iZMItnn1RRMFNQsZ77hvdOP5Bym7HqgtFrzW0Osn/99iLqDSD/r5TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831682; c=relaxed/simple;
	bh=s1L8bTEhXNRywPbG6SqAi65OLmvLVu36tlRV98F6KUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDMRMwkcc+TbfSWxCydPEkKSiAtZEyqW+k8bqPU1ZUq/8pRAGnpbret79TIuxXwb+IiEAQ6dnjwtPux9uK+5xMuhgSJ86v6J33/aL+t3KdxhiOQbNCEtPst0IaP0VLQG/j7+oAVzax3po0OIigDcseFqGM3GTSfcX4lA4KXhQ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fpx1hbhW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lBf6Xja6; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fpx1hbhW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lBf6Xja6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775831678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7PmzDbLlBDhOTcl+gva0ATDGWABPn01exzS6qP+Aek=;
	b=Fpx1hbhWVysAUdTE3SMiky9XDEXm4+lAAMrK2pZ3135hZ9d+MnkTRU7wkNxQHOpQPmYuMs
	dOUkQgpzFEOjUeUkjhCgr0B+7ysQri+Ar0mbPRuq1BaGyZB7RYstE1iiE6SwwkpBXsOJV5
	Alv6rOUisYX/BelEKMf2ChybkTedNwQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-sE5KX_AwPxGCLbJkjawFTg-1; Fri, 10 Apr 2026 10:34:36 -0400
X-MC-Unique: sE5KX_AwPxGCLbJkjawFTg-1
X-Mimecast-MFC-AGG-ID: sE5KX_AwPxGCLbJkjawFTg_1775831676
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4362197d1easo1502760f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 07:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831674; cv=none;
        d=google.com; s=arc-20240605;
        b=jk/ydJLutuLRXuVExXQR25vaUYzXyYnQUuek7iLjcK2skWAioCyJRRwX8FVGrrv1sz
         JLISZY7CE5LkATEHVwhrusCPwHOYqxyCA/12Q7jejxhwgBy/C/u8Moe9f1mTJX+DJleP
         o0n/R3sNEbVp1+jo8P69kc444mrS0hsbr8RMOO1ZPTCD5yXq0VJkKro99eJE0jBwfs9V
         br32DgM/ND/E9rK4kciT/xelxL/JE6dzP0omi4BFI5inYcFdEdqS+njb4j0xo1MyDWE5
         kt4z3Sb0wqy18MgqTLpKqKN94HI2mj9E3UvjcZXMZNgxAZkf8GaDD2oD9fVwTq27SB5u
         K+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7PmzDbLlBDhOTcl+gva0ATDGWABPn01exzS6qP+Aek=;
        fh=zpjKFs4IbTACCd2qTIH1XByq19lFtG5zVztBX8cg91A=;
        b=NK/Ut7y4XVwIDZ3ioN5V4jB3/cEYmpsslC19PbLMGPWMq7E+Bs2zeW5MVVrFHXpBGo
         9wOthE6QJX97ztqPFpCY5X/qJgM4ijCwF8JqOF31LLpBv1DNdSqmHP3nKySP9PZLN0qh
         G+5Wj+WTGLqiv3LapP7wWWBsJhZX96jffcQdd3mzQ3772W/jdJHpi2LVWEuzQYl/nK3P
         yL7NXT9+Rz13Sz3jNma2g0qqmDrGwXk3LRnn/CxQF1drx7/ElA59K+zR+zroIO6LlV7N
         QHuYp1TtyR4XFcVC7XK4CeF77X0kzDEpLR7NKUBOxaS51cFn3+6J5RTa5iaslBJzs+H2
         jAOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775831674; x=1776436474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7PmzDbLlBDhOTcl+gva0ATDGWABPn01exzS6qP+Aek=;
        b=lBf6Xja6nqd16QToLacvDVfWasQAk4VfnCTC5hgK0Ita/FIIdAqMAK0ajy9OI/NS7d
         v9JrE2yrFj5PhIYH1o3xPjf8UuhzudHew2uTG+7C/S8/SaKCth8Jh8tlr8AZwtXcI5rc
         aMlzYI3oXl9TMzAjVvWxm7QZjX2sPSBP4MWuuS9hTY33fOi2vtAuiyOQrnC+xZvWr4Yg
         ld6/MvIi0KCxbVooQ/7fg8UMXvYPVB2PMoS8IagI2zUGBNku4C5BQZiajX7A8zfXEVag
         kmpZmV1Xpfd1CilMxewA94rk4C/uSPNe7xreVrMB7KNv+kN7325PDVhMZC/vHAVwfhr4
         Evfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831674; x=1776436474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7PmzDbLlBDhOTcl+gva0ATDGWABPn01exzS6qP+Aek=;
        b=YO5toDnZ+KF+s3Ho4oikiPpq0tJF6G0N6BdZgT3rPWLuCOFuk2vf/bwE6u6ypFaBge
         yQd5l708AHbG8S3baEuck2xx6DB/iPKc/Grgz0yhsA1LLExqXpyjAT84e9OSlZHGxoAg
         BI7O9Lojyshz/BVSImXW2X5ziFDCzufZTkbxVWz/UT8nIzUrMX9nMbFW1byJ9Kg0Bj0Z
         oxEKNUmJWnrjVYTchK31JTagONtSPL/5tm43YQsMwebO0ko+PqP/T0owbkrKmf3yUSZe
         zmDyqJZ8lMtQ7B8bmZGEy+Eq75iTYo6Tvq/ThGGfnpVB3+GH/J+FfJLEi4xyhS9KVcpZ
         PjWA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0yn6pk6F2pDN4DMNI3qlsJHKISauAiE8LGIyz4lL3fuOOUHmS4xFZ568JST7nwwq2QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVdt2csQ0v1y2qmvknJxM3Z9B+NQbDOCrS0/FotDkkTl/3LqsE
	R1NwlARVOo9E1lS9seZ/cH8NZntdhpl2NyfHbPbERRWf0y36IwS0GrBD9msOpky4ZLntWwX6PPQ
	tIrZZ74s7Y1A+FQUOBjnrjtkc3DoZ6fgOuYSs++vZicjKnhDERLDMVx6JnRTe+FVsaOgB/VIjhQ
	L0nmjbHF1GRSLF4J2PNhkwdHOjKuIVYhkHNPV2QsQ=
X-Gm-Gg: AeBDieuPzyFKMI9pAIFdHceG0+xGlwewt+Bkf64FMNSxu4SwI1vZNRigUJ79voY0XXy
	5givDuvTnndubVTtkoWNk10RhuGey7T3KNpwb1bdBW3ltFXpFFUG4plmSYraj2lbnNwaho1rSYy
	vxJBygmBTbs5M43k8tAdjrnHKLM7Jdc9Y11ZDrd383ZAVvklvweRdaPmL0bNd+63FE57eW6g1fD
	0G9vO2Hy0AP6m69oJLoqE7fiiJbnN1pY/dUdvPN+frs5LSqmwVjBCur4bP2HBO9REZxCIakodWO
	bsmw
X-Received: by 2002:a05:6000:2dc7:b0:43d:4d2c:9ef6 with SMTP id ffacd0b85a97d-43d642a78e4mr4817949f8f.30.1775831674337;
        Fri, 10 Apr 2026 07:34:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc7:b0:43d:4d2c:9ef6 with SMTP id
 ffacd0b85a97d-43d642a78e4mr4817884f8f.30.1775831673652; Fri, 10 Apr 2026
 07:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407180107.1603697-1-pbonzini@redhat.com> <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com> <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com>
In-Reply-To: <adkFk3ZN4HJtpLA3@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Apr 2026 16:34:02 +0200
X-Gm-Features: AQROBzBwX2CNSw38VhqIGvZxiVps3TK1ILYuEU2p3GI8UlGoeflSLidM_jSmzdY
Message-ID: <CABgObfaE2g30D789zK1N8xMfcAzPG8gz8MPERQ+DYxd7Soi-Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Steffen Eiden <seiden@linux.ibm.com>, Alex Williamson <alex.williamson@nvidia.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 4:13=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +Dan
> > We could get rid of the reference count completely (get_file() as a
> > replacement for kvm_get_kvm(), get_file_active() as a replacement for
> > kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
> > struct kvm to struct file,
>
> I wasn't thinking of dropping kvm_get_kvm() entirely, rather just not exp=
orting
> it.  Forcing internal KVM usage to grab a reference to the file doesn't a=
dd a
> whole lot value.

It adds not doing things in two different ways. The kvm_file is not
always available (and if we need to add it, it should be added in
struct kvm not struct kvm_device).

> > therefore adding and removing a reference count would have some additio=
nal
> > pointer chasing. KVM has too many kinds of files to seriously consider
> > passing around struct file* in virt/kvm/ and arch/*/kvm/, and you'd als=
o have
> > pointer chasing to get filp->private_data so it wouldn't win much.
>
> Again, I'm not suggesting we do that.  The conversion looks pretty straig=
htforward;
> the compile-tested only, but it doesn't seem overly complex.

I don't like losing the type safety - though file_is_kvm() works as a
run-time check, we could keep a struct kvm_file wrapper and
kvm_file_get/kvm_file_get_kvm/kvm_file_put to manage the reference
count.

But yeah, it's better in other ways. The relatively new
get_file_active()/get_file() APIs make the change nicely transparent.

> drivers/s390/crypto/vfio_ap_ops.c would need similar treatment.  I didn't=
 try to
> handle it in my sketch because it's not clear to me how we want to deal w=
ith that
> thing, as it's accessing a pile of state/fields that really shouldn't be =
used by
> non-KVM code :-(

It accessing vcpu->run is not too bad, because vfio_ap_ops.c needs to
do what userspace usually does. Except it's not userspace and does not
have access to (say) QEMU's data structure for the memory map, which
is where the memslot hacks lie. We can provide a clean API for that
but I think it's unavoidable. :(

Paolo

> I added Dan because the PCI TSM stuff is picking up "struct kvm *kvm" ref=
erences,
> and I want to head that off too, i.e. have it use the file approach inste=
ad of
> whatever it plans on doing (can't tell from the code, because there are n=
o users).
>
> ---
>  arch/x86/include/asm/kvm_page_track.h |  8 +++---
>  arch/x86/kvm/mmu/page_track.c         | 16 +++++++----
>  drivers/vfio/group.c                  |  2 +-
>  drivers/vfio/vfio.h                   | 12 ++++----
>  drivers/vfio/vfio_main.c              | 41 ++++-----------------------
>  include/linux/kvm_host.h              |  2 ++
>  include/linux/vfio.h                  |  5 ++--
>  virt/kvm/kvm_main.c                   | 14 +++++++--
>  virt/kvm/vfio.c                       |  6 ++--
>  9 files changed, 46 insertions(+), 60 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm=
/kvm_page_track.h
> index 3d040741044b..046a25c8fe4f 100644
> --- a/arch/x86/include/asm/kvm_page_track.h
> +++ b/arch/x86/include/asm/kvm_page_track.h
> @@ -44,13 +44,13 @@ struct kvm_page_track_notifier_node {
>                                     struct kvm_page_track_notifier_node *=
node);
>  };
>
> -int kvm_page_track_register_notifier(struct kvm *kvm,
> +int kvm_page_track_register_notifier(struct file *file,
>                                      struct kvm_page_track_notifier_node =
*n);
> -void kvm_page_track_unregister_notifier(struct kvm *kvm,
> +void kvm_page_track_unregister_notifier(struct file *file,
>                                         struct kvm_page_track_notifier_no=
de *n);
>
> -int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn);
> -int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn);
> +int kvm_write_track_add_gfn(struct file *file, gfn_t gfn);
> +int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn);
>  #else
>  /*
>   * Allow defining a node in a structure even if page tracking is disable=
d, e.g.
> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.=
c
> index 1b17b12393a8..f070dacc4028 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -217,10 +217,11 @@ static int kvm_enable_external_write_tracking(struc=
t kvm *kvm)
>   * register the notifier so that event interception for the tracked gues=
t
>   * pages can be received.
>   */
> -int kvm_page_track_register_notifier(struct kvm *kvm,
> +int kvm_page_track_register_notifier(struct file *file,
>                                      struct kvm_page_track_notifier_node =
*n)
>  {
>         struct kvm_page_track_notifier_head *head;
> +       struct kvm *kvm =3D file_to_kvm(file);
>         int r;
>
>         if (!kvm || kvm->mm !=3D current->mm)
> @@ -232,7 +233,7 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
>                         return r;
>         }
>
> -       kvm_get_kvm(kvm);
> +       get_file(file);
>
>         head =3D &kvm->arch.track_notifier_head;
>
> @@ -247,10 +248,11 @@ EXPORT_SYMBOL_GPL(kvm_page_track_register_notifier)=
;
>   * stop receiving the event interception. It is the opposed operation of
>   * kvm_page_track_register_notifier().
>   */
> -void kvm_page_track_unregister_notifier(struct kvm *kvm,
> +void kvm_page_track_unregister_notifier(struct file *file,
>                                         struct kvm_page_track_notifier_no=
de *n)
>  {
>         struct kvm_page_track_notifier_head *head;
> +       struct kvm *kvm =3D file_to_kvm(file);
>
>         head =3D &kvm->arch.track_notifier_head;
>
> @@ -259,7 +261,7 @@ void kvm_page_track_unregister_notifier(struct kvm *k=
vm,
>         write_unlock(&kvm->mmu_lock);
>         synchronize_srcu(&head->track_srcu);
>
> -       kvm_put_kvm(kvm);
> +       fput(file);
>  }
>  EXPORT_SYMBOL_GPL(kvm_page_track_unregister_notifier);
>
> @@ -319,8 +321,9 @@ void kvm_page_track_delete_slot(struct kvm *kvm, stru=
ct kvm_memory_slot *slot)
>   * @kvm: the guest instance we are interested in.
>   * @gfn: the guest page.
>   */
> -int kvm_write_track_add_gfn(struct kvm *kvm, gfn_t gfn)
> +int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
>  {
> +       struct kvm *kvm =3D file_to_kvm(file);
>         struct kvm_memory_slot *slot;
>         int idx;
>
> @@ -349,8 +352,9 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
>   * @kvm: the guest instance we are interested in.
>   * @gfn: the guest page.
>   */
> -int kvm_write_track_remove_gfn(struct kvm *kvm, gfn_t gfn)
> +int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
>  {
> +       struct kvm *kvm =3D file_to_kvm(file);
>         struct kvm_memory_slot *slot;
>         int idx;
>
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 4f15016d2a5f..f4a81d1b63fa 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -858,7 +858,7 @@ bool vfio_group_enforced_coherent(struct vfio_group *=
group)
>         return ret;
>  }
>
> -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
>  {
>         spin_lock(&group->kvm_ref_lock);
>         group->kvm =3D kvm;
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..aa93c1ec6b10 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -23,7 +23,7 @@ struct vfio_device_file {
>         u8 access_granted;
>         u32 devid; /* only valid when iommufd is valid */
>         spinlock_t kvm_ref_lock; /* protect kvm field */
> -       struct kvm *kvm;
> +       struct file *kvm;
>         struct iommufd_ctx *iommufd; /* protected by struct vfio_device_s=
et::lock */
>  };
>
> @@ -88,7 +88,7 @@ struct vfio_group {
>  #endif
>         enum vfio_group_type            type;
>         struct mutex                    group_lock;
> -       struct kvm                      *kvm;
> +       struct file                     *kvm;
>         struct file                     *opened_file;
>         struct blocking_notifier_head   notifier;
>         struct iommufd_ctx              *iommufd;
> @@ -108,7 +108,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device=
 *device);
>  void vfio_df_group_close(struct vfio_device_file *df);
>  struct vfio_group *vfio_group_from_file(struct file *file);
>  bool vfio_group_enforced_coherent(struct vfio_group *group);
> -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
> +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
>  bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
> @@ -171,7 +171,7 @@ static inline bool vfio_group_enforced_coherent(struc=
t vfio_group *group)
>         return true;
>  }
>
> -static inline void vfio_group_set_kvm(struct vfio_group *group, struct k=
vm *kvm)
> +static inline void vfio_group_set_kvm(struct vfio_group *group, struct f=
ile *kvm)
>  {
>  }
>
> @@ -435,11 +435,11 @@ static inline void vfio_virqfd_exit(void)
>  #endif
>
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m);
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *k=
vm);
>  void vfio_device_put_kvm(struct vfio_device *device);
>  #else
>  static inline void vfio_device_get_kvm_safe(struct vfio_device *device,
> -                                           struct kvm *kvm)
> +                                           struct file *kvm)
>  {
>  }
>
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15..7af53d1288f8 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -433,35 +433,13 @@ void vfio_unregister_group_dev(struct vfio_device *=
device)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m)
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *k=
vm)
>  {
> -       void (*pfn)(struct kvm *kvm);
> -       bool (*fn)(struct kvm *kvm);
> -       bool ret;
> -
>         lockdep_assert_held(&device->dev_set->lock);
>
> -       if (!kvm)
> +       if (!get_file_active(&kvm))
>                 return;
>
> -       pfn =3D symbol_get(kvm_put_kvm);
> -       if (WARN_ON(!pfn))
> -               return;
> -
> -       fn =3D symbol_get(kvm_get_kvm_safe);
> -       if (WARN_ON(!fn)) {
> -               symbol_put(kvm_put_kvm);
> -               return;
> -       }
> -
> -       ret =3D fn(kvm);
> -       symbol_put(kvm_get_kvm_safe);
> -       if (!ret) {
> -               symbol_put(kvm_put_kvm);
> -               return;
> -       }
> -
> -       device->put_kvm =3D pfn;
>         device->kvm =3D kvm;
>  }
>
> @@ -472,14 +450,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
>         if (!device->kvm)
>                 return;
>
> -       if (WARN_ON(!device->put_kvm))
> -               goto clear;
> -
> -       device->put_kvm(device->kvm);
> -       device->put_kvm =3D NULL;
> -       symbol_put(kvm_put_kvm);
> -
> -clear:
> +       fput(device->kvm);
>         device->kvm =3D NULL;
>  }
>  #endif
> @@ -1483,7 +1454,7 @@ bool vfio_file_enforced_coherent(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
>
> -static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
> +static void vfio_device_file_set_kvm(struct file *file, struct file *kvm=
)
>  {
>         struct vfio_device_file *df =3D file->private_data;
>
> @@ -1500,12 +1471,12 @@ static void vfio_device_file_set_kvm(struct file =
*file, struct kvm *kvm)
>  /**
>   * vfio_file_set_kvm - Link a kvm with VFIO drivers
>   * @file: VFIO group file or VFIO device file
> - * @kvm: KVM to link
> + * @kvm: KVM file to link
>   *
>   * When a VFIO device is first opened the KVM will be available in
>   * device->kvm if one was associated with the file.
>   */
> -void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
> +void vfio_file_set_kvm(struct file *file, struct file *kvm)
>  {
>         struct vfio_group *group;
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6b76e7a6f4c2..7ea398d33e9f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1066,6 +1066,7 @@ void kvm_get_kvm(struct kvm *kvm);
>  bool kvm_get_kvm_safe(struct kvm *kvm);
>  void kvm_put_kvm(struct kvm *kvm);
>  bool file_is_kvm(struct file *file);
> +struct kvm *file_to_kvm(struct file *file);
>  void kvm_put_kvm_no_destroy(struct kvm *kvm);
>
>  static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int a=
s_id)
> @@ -2310,6 +2311,7 @@ extern unsigned int halt_poll_ns_shrink;
>
>  struct kvm_device {
>         const struct kvm_device_ops *ops;
> +       struct file *kvm_file;
>         struct kvm *kvm;
>         void *private;
>         struct list_head vm_node;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index e90859956514..6dd5dd2550a0 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -52,7 +52,7 @@ struct vfio_device {
>         struct vfio_device_set *dev_set;
>         struct list_head dev_set_list;
>         unsigned int migration_flags;
> -       struct kvm *kvm;
> +       struct file *kvm;
>
>         /* Members below here are private, not for driver use */
>         unsigned int index;
> @@ -64,7 +64,6 @@ struct vfio_device {
>         unsigned int open_count;
>         struct completion comp;
>         struct iommufd_access *iommufd_access;
> -       void (*put_kvm)(struct kvm *kvm);
>         struct inode *inode;
>  #if IS_ENABLED(CONFIG_IOMMUFD)
>         struct iommufd_device *iommufd_device;
> @@ -339,7 +338,7 @@ static inline bool vfio_file_has_dev(struct file *fil=
e, struct vfio_device *devi
>  #endif
>  bool vfio_file_is_valid(struct file *file);
>  bool vfio_file_enforced_coherent(struct file *file);
> -void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
> +void vfio_file_set_kvm(struct file *file, struct file *kvm);
>
>  #define VFIO_PIN_PAGES_MAX_ENTRIES     (PAGE_SIZE/sizeof(unsigned long))
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9093251beb39..b240a3cc5995 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4808,7 +4808,7 @@ void kvm_unregister_device_ops(u32 type)
>                 kvm_device_ops_table[type] =3D NULL;
>  }
>
> -static int kvm_ioctl_create_device(struct kvm *kvm,
> +static int kvm_ioctl_create_device(struct file *file, struct kvm *kvm,
>                                    struct kvm_create_device *cd)
>  {
>         const struct kvm_device_ops *ops;
> @@ -4834,6 +4834,7 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>
>         dev->ops =3D ops;
>         dev->kvm =3D kvm;
> +       dev->kvm_file =3D file;
>
>         mutex_lock(&kvm->lock);
>         ret =3D ops->create(dev, type);
> @@ -5351,7 +5352,7 @@ static long kvm_vm_ioctl(struct file *filp,
>                 if (copy_from_user(&cd, argp, sizeof(cd)))
>                         goto out;
>
> -               r =3D kvm_ioctl_create_device(kvm, &cd);
> +               r =3D kvm_ioctl_create_device(filp, kvm, &cd);
>                 if (r)
>                         goto out;
>
> @@ -5483,6 +5484,15 @@ bool file_is_kvm(struct file *file)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
>
> +struct kvm *file_to_kvm(struct file *file)
> +{
> +       if (!file_is_kvm(file))
> +               return NULL;
> +
> +       return file->private_data;
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_to_kvm);
> +
>  static int kvm_dev_ioctl_create_vm(unsigned long type)
>  {
>         char fdname[ITOA_MAX_LEN + 1];
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 9f9acb66cc1e..f6681dacf7b9 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -35,9 +35,9 @@ struct kvm_vfio {
>         bool noncoherent;
>  };
>
> -static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
> +static void kvm_vfio_file_set_kvm(struct file *file, struct file *kvm)
>  {
> -       void (*fn)(struct file *file, struct kvm *kvm);
> +       void (*fn)(struct file *file, struct file *kvm);
>
>         fn =3D symbol_get(vfio_file_set_kvm);
>         if (!fn)
> @@ -175,7 +175,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, =
unsigned int fd)
>         kvf->file =3D get_file(filp);
>         list_add_tail(&kvf->node, &kv->file_list);
>
> -       kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
> +       kvm_vfio_file_set_kvm(kvf->file, dev->kvm_file);
>         kvm_vfio_update_coherency(dev);
>
>  out_unlock:
>
> base-commit: df83746075778958954aa0460cca55f4b3fc9c02
> --
>

