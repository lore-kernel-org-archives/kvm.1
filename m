Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B6B50EBFE
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685809; cv=none; b=cDTHOiiEhxOlRgalZrljZCD19sXs0GinEV48YONI4Zz55p24CiJjNeM5rMo0E/3UmV0zj0A3VBDK6urA/+83SbSrsRDOKKcLrIj68wR3OyU4PI6Xpc231wf10+nCVE0UTpSOe5KI4YUPUoGbK+8DFEnO/5yVgbWPcB2O6uHrdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685809; c=relaxed/simple;
	bh=dsmtcH1KUa8/Fv5TCQXae98WQoKQjz4Gj8d6RLEUcmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fijxb16hOU7h9co+IqRcBjxcnKaAZgUsGKeL7VEumUXMRbwnC1Zoe+neB6V/5hG3d/wgXP8TGfwTVmkVc59I1YfN3MwfXPJ+WKQfCxUr9hP4I0hoTMVYjNwR9JtHfhoNHRtrtUaZR/TQV8ZJbi8v469x8Kn/osWPI1mVYg3ALE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUyb3eI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUyb3eI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7268A1F00893
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685807;
	bh=01YLInGl/50+krWWqQhGHR/yvk2It1cDSicZVJPaDHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aUyb3eI6ziwjWdZZTNIsAfRshpUXxY/uvx/feq9CcbjMe6cAos40JfNtz5kiqOTeF
	 0+rXSjwTDt2+xNsp5NMAPbthqLYYwKY+Th+wNez2nnUpxFq8x3+VqEVI6s5CDy/RW7
	 GOQRSkfZTi6QHGmsfXwyNARrYZGRvQioMFUwCF2GAUOFHEd5G7oTsL3NvySGLu4lTW
	 7S5U7Dr9eZn5g/9LphWOWlLwJhVg9bFEMIW9CAIclwrkjfJyhqkpwNneo6ueNkNw5+
	 gzg7IRR1oka/7/C86y8KFPwMcvreXcU/G/ks469MxIqT5ws0NSPzWUWmyJW9UgKGkW
	 PwpaAFd4eZt6w==
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so5571553a12.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 05:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBywY2q5OZRZpoVorBlJQxg/7cXEPp+X6yqyfITPDG/gPobNLabkSQLkvVYF+cTU1Em/ADQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQQDEMl35FyvwjMfquwb9Wp7u9wAWkCeec0UWwyFvkxF1x3uil
	41XXcwB752hEfsI8GRASRVwIgn0up+fn6CNBEnG0fis7mS0TMISFvFRDKzhJDyD3naAvAY4+wSi
	6Evh9hc3zoNCY3lbfNKHWHlMg6kV/cxo=
X-Received: by 2002:a05:6402:454c:b0:6aa:734b:1a28 with SMTP id
 4fb4d7f45d1cf-6aac8f828cdmr9987825a12.34.1790685806078; Tue, 29 Sep 2026
 05:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929102821.36112-1-cui.tao@linux.dev> <20260929102821.36112-5-cui.tao@linux.dev>
In-Reply-To: <20260929102821.36112-5-cui.tao@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 29 Sep 2026 20:43:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
X-Gm-Features: AclHuK8JCKLgJD0QHBNnHihyqU8NcdH-N30jZAFiC48CChMGSvffDsMY5HNhzHo
Message-ID: <CAAhV-H5GNKZSjB_MN2Vi7uhbf1q9nqqvsfwqF+THpkwk3dEhGQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
To: Tao Cui <cui.tao@linux.dev>
Cc: maobibo@loongson.cn, gaosong@loongson.cn, zhaotianrui@loongson.cn, 
	loongarch@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@xen0n.name, nagachaithanya9911@gmail.com, Tao Cui <cuitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tao,

On Tue, Sep 29, 2026 at 6:29=E2=80=AFPM Tao Cui <cui.tao@linux.dev> wrote:
>
> From: Tao Cui <cuitao@kylinos.cn>
>
> KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
> invocation: every call overwrites pch_pic_base and registers the same
> kvm_io_device on the MMIO bus at the new address, while
> kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
> init, MMIO to the stale ranges computes its register offset against the
> new base and silently reads 0 / drops writes, and the leftover bus
> entries persist until the VM is destroyed.
>
> Reject repeated initialization with -EEXIST, tracking the state with
> a has_init flag so the check and the MMIO base update are atomic
> under slots_lock.  The base is only committed after a successful bus
> registration, and the real registration error is propagated instead
> of being replaced with -EFAULT.
>
> Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write=
 functions")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/kvm_pch_pic.h |  1 +
>  arch/loongarch/kvm/intc/pch_pic.c        | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kvm_pch_pic.h b/arch/loongarch/in=
clude/asm/kvm_pch_pic.h
> index 887b0431fd20..679132d840e6 100644
> --- a/arch/loongarch/include/asm/kvm_pch_pic.h
> +++ b/arch/loongarch/include/asm/kvm_pch_pic.h
> @@ -53,6 +53,7 @@ struct loongarch_pch_pic {
>         spinlock_t lock;
>         struct kvm *kvm;
>         struct kvm_io_device device;
> +       bool has_init;
>         union pch_pic_id id;
>         uint64_t mask; /* 1:disable irq, 0:enable irq */
>         uint64_t htmsi_en; /* 1:msi */
> diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/=
pch_pic.c
> index 7a704f18880d..a884a043feef 100644
> --- a/arch/loongarch/kvm/intc/pch_pic.c
> +++ b/arch/loongarch/kvm/intc/pch_pic.c
> @@ -282,16 +282,24 @@ static int kvm_pch_pic_init(struct kvm_device *dev,=
 u64 addr)
>         struct kvm_io_device *device;
>         struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;
Why so complicated? The below is enough, no?

diff --git a/arch/loongarch/kvm/intc/pch_pic.c
b/arch/loongarch/kvm/intc/pch_pic.c
index 2b63b0c2c7ce..7855d78304b7 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -281,6 +281,9 @@ static int kvm_pch_pic_init(struct kvm_device
*dev, u64 addr)
        struct kvm_io_device *device;
        struct loongarch_pch_pic *s =3D dev->kvm->arch.pch_pic;

+       if (s->device->ops)
+               return -EEXIST;
+
        s->pch_pic_base =3D addr;
        device =3D &s->device;
        /* init device by pch pic writing and reading ops */

>
> -       s->pch_pic_base =3D addr;
>         device =3D &s->device;
>         /* init device by pch pic writing and reading ops */
>         kvm_iodevice_init(device, &kvm_pch_pic_ops);
>         mutex_lock(&kvm->slots_lock);
> +       if (s->has_init) {
> +               ret =3D -EEXIST;
> +               goto out;
> +       }
>         /* register pch pic device */
>         ret =3D kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_=
SIZE, device);
> +       if (!ret) {
> +               s->pch_pic_base =3D addr;
> +               s->has_init =3D true;
> +       }
> +out:
>         mutex_unlock(&kvm->slots_lock);
>
> -       return (ret < 0) ? -EFAULT : 0;
> +       return ret;
>  }
>
>  /* used by user space to get or set pch pic registers */
> --
> 2.43.0
>
