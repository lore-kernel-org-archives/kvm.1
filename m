Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448907;
	b=YWgGHaW1YBw9j2pii/7R+yzIMN7XvJSP761zLRJnrdH9y5xl8H9SwL0rygI2n1Gum3BT
	 cHHYZobMiYgEihLv7tufG4HlWFbkjy2zqZboI715Gb4/tezRGJEl+qiX7/yuBMMSILCEj
	 5VbPO3yHYwN8bpdNGiwdKCyoXakWyQu03OxjeoatfxT+HRZYAMWeULOsjXvyyDp3Droyr
	 bRJAWaerlFViPVpB+3YMzoXwAH1RJkh1MsbZk8+98pCqLOid9Qn8GesNRiIkyrWgupZir
	 FpwkXz0QKvhLuFj9+Vve5lpho3NrCmxvF11UXS345JomaKeUE/HM+EfLYvF5mmfGdYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448907;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=FIWWHON/FotHWhC6ltvVSAD62l/fnqD9X4bouqugXsJkTADRexDdznRqDeJy6W3I/Ct4
	 lxuMlgrQJ0xmTwaXzWn5F2VEp4XKPRHZVKbw963PZio5zOgJiM6Z0gt2MNxjvSV59tGDd
	 V5niZM9jjirVAH7nduQgdgFtrV554NV6j4teWU7F0hU8+Q3ltCKBQDMS4j19xfE9d7eXH
	 6VR9qI9qCYlPruIyfm9MGKYo+H+K/gjM34YKXtOaqNmNY4c0EC8q2Mxy2iuYGhpiu/qq8
	 K2XdmrXinPzfbS2lKfghm2RZYOXCIp1yCJkWXdAGrqeoLCThDB8eHMmpR1lhHkoNFwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOmwkUVi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsfZhFmo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC47606A333
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AC47606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOmwkUVi;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dsfZhFmo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795448905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
	b=bOmwkUViTKaN2nBRN1bNE7MG7OZ2ywtKPRGQ0XcAYKxqB2Mbfz8zZcJZoMJ0I6pr1lbV1F
	0kCx7RLf5ZhCOVUTUxRcEzOVU8GHM/d1jPKkXcMHIhNugz/py2NM+oVHns1+xqptaVtBC1
	7Au8SDlTOekmEwOthhBFAWTMhl3v0Ng=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-M3GD84C-P_O6ez-94grJfA-1; Mon, 23 Nov 2026 15:48:23 +0000
X-MC-Unique: M3GD84C-P_O6ez-94grJfA-1
X-Mimecast-MFC-AGG-ID: M3GD84C-P_O6ez-94grJfA_1795448901
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-679f81d5d7bso5787339d50.2
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:48:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448901; cv=none;
        d=google.com; s=arc-20260327;
        b=TYnOxnwwqv6iqF8n6PEOOg0JUJUtIPN4L05/Wc28SsvjDaudK2VHhOH9q18Zf/Rykl
         sJr8x/jvXV0nucB7xj237KVxUPA0lhWvFNzn5ciwAu0EjWqJsVpw73a+9uSxQ37TutYe
         4ra9dmluXa3ZiMpzf7ZQ6XNYFwwxLc1XoiIfWRp0dObi5ISqs5yVYYlk2emp7CxX3b3k
         5EESXKBylCWSfHZxLgAp3PewaJ3lmsopx02fOPyzb154As87DB+sCaWvAM+EgfIEXXv7
         OG4QrUGW+R7u/bAje69Km8+bILxsCD7gi5qSqREHAsmF7l61lr4lep55V0LYl+J0MuoG
         uMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        fh=VC283A1fKY1vNMCyNNVy4wBkvRUC5u5uHxWZTbBh3F4=;
        b=k37jMLJsQNakX0AF9SJSm7z5GR+aku6eJwBYmu9aguK95nrJd5PEUkUUGdEIkRGr0m
         Z2yuY1gCGVfNeQIlxDmIt2l4xmd4MAzSUhvsCvUxXjiWhQ0CjBMy4JN6r5wKsCr4uLO+
         9JUWwVhszYMPWcOeKw94/lbkWxzpNf3PiR4UFXCrF7RrVX8WGvZwANxzfn4Lowu8IaHP
         1qZg6EkNGCThUMbYvseyV9onsKmGWjstwUz3dqgCVfArPcDz3VUGgmww4yDGqkCkqOzl
         VHU+9cw/lp6E8I6Gwle9CDu6AlTvLbACZnoDg4jc9GiZgJa21NbBWRd477o5pYvLPNR9
         0jXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795448901; x=1796053701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        b=dsfZhFmodnbE7qJ/+h28fM11IW95haQ/HwOArI6w5lnEBqB9E+BHecqtIO6sHZC/Q0
         y9Ww2fGlfQdux/XJuJtD+6UVvh3rSqq5MiGH2qPQb9natv0NBtuHG30u5UYnL7P3QwBJ
         YYZHaM66NXm5fOTn5bHUzfZzzmQ0fBRDRGd/o4MX0tgByBixuIFoP2ceSjw6EQ9I0Grq
         uEG4lO++mQh+Mi+zZ+j+8rcOnqWbWURPnClmXZuFEDjQNQMKzxvEtqOl9yJv/Zyfa6oD
         mzkkEmEF8qq7gQQNVGUB13ITJuGmcBZ1NJlIx2KOOggqGR4ZYf/AZu2CYK7x5kw12jp2
         RuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448901; x=1796053701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWmsxzAWhp8YogqWe/sWTbGuQ3w1HS7FA6g8w4z3/dM=;
        b=ziTOOWVBZGC2ycffeC8Of6e6zu1LK8HBxub4Ws33klDesHwZq1RAdce92Ezb9Bu4CM
         tO4ZKXrI6tFhn8/7x5Web02MUAE9XfZNmwQpLOnhfAg8NoPqUCdMpWA7BhM/zVCHW1wF
         jX7u2QLxqsqrT6sW7NanRPr8L239mbzZJ9KrItsTmqxWy4E/ebOJdLTNUIA1VLYrnjle
         4X4SiCAQ+4XdNfF7gT34PN2qfHOD/pRI+N0Xi4HRMgmY/bzY0+sGvZaKsUtv5q9J0xRp
         pnPrfYMDv3Bgp6YFf6Xstli8m/iLQPDkUM35FC9Ks3eWEBvxnsP3f1zbTkENxVkKqjam
         8XqA==
X-Forwarded-Encrypted: i=1; AL+hErGbOXUvOD4R4CxLriE6s98F54vI/G/9FIBmIK6ogO651VQdLxbIeJEO/m9sg0hOvmaMKAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yzxq3yslfFpfyzQzuEiQUsZaWhA7l0jQXh6BR9kPVg2xNgNY4
	EXi7kqclK9FcXf3r2LzUzB2qj0YDOPjI8m3/GEq2XSi6TFS+mLm4QglPLyClh+qjP+929owRvXz
	6V08L59EOb/nBsWp/Y/OW+8YrMFm/Nt5aAo5cEF7asaB/bHsZEPHAFsNN4FjD7N/LgRLnywVG95
	kcBCU39Q0jfErie2JfUPKCXDPhWE6/
X-Gm-Gg: AZFdTZeV0w020hZIXrdOJrjy3HtzWzW/3MMaqybqlpqCo/PqTsJJZIudnlcGDV4SYsk
	+YustPlA0licDwgL8UPpOOZ9lwSPNdrBMjnb0gEfh73RSVZtMyLvwUF89IZV3GI9VEy1OwMGpiA
	FIewMx1NeZUpJzTc/rekF8k7ym7TLJZXJ6DBL4eT9TM/Nrmcl0ZsUyAvuQJn40ZTLEMfkFxRhnZ
	I2BtRAlWKRvg0yAseIKGhD0X/TSTO2oOU633Q966Y5tac0LePt3HUvLaJE=
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id 956f58d0204a3-67df4497b11mr3158236d50.131.1795448901330;
        Mon, 23 Nov 2026 07:48:21 -0800 (PST)
X-Received: by 2002:a05:690e:150e:b0:677:b670:bc2 with SMTP id
 956f58d0204a3-67df4497b11mr3158224d50.131.1795448900838; Mon, 23 Nov 2026
 07:48:20 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-5-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 16:47:44 +0100
X-Gm-Features: Aa3M54o4ueCnunOOjRD8BYS6eetZBocpj0aR00-pSGaCcCscH__3XBFasy8mITE
Message-ID: <CAJaqyWeVfFBohQ+x1_MCmNCt0FgvepgKV+H_u4GqR+GLCqf6Mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vdpa/mlx5: Don't flush the workqueue under reslock
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 3:00=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The control VQ work (mlx5_cvq_kick_handler()) runs on mvdev->wq and
> takes reslock. Device reset and the error path of .set_status take
> reslock and then call unregister_link_notifier() which flushes the same
> workqueue. A deadlock occurs if a CVQ kick arrives just before the reset
> for the CVQ work.
>
> Lockdep caught this when QEMU quits (pkill qemu) and closes the
> vhost-vdpa device:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  ------------------------------------------------------
>  qemu-system-x86/5785 is trying to acquire lock:
>  ff110001cd292940 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}, at: touch_wq=
_lockdep_map+0x7a/0x180
>
>  but task is already holding lock:
>  ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat_rese=
t+0xed/0x760 [mlx5_vdpa]
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #2 (&ndev->reslock){+.+.}-{4:4}:
>         lock_acquire+0x126/0x330
>         down_write+0x87/0x1d0
>         mlx5_cvq_kick_handler+0xb1/0x1180 [mlx5_vdpa]
>         process_one_work+0x8df/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #1 ((work_completion)(&ndev->cvq_ent.work)){+.+.}-{0:0}:
>         lock_acquire+0x126/0x330
>         process_one_work+0x874/0x1660
>         worker_thread+0x62c/0x1030
>         kthread+0x377/0x490
>         ret_from_fork+0x4d7/0x720
>         ret_from_fork_asm+0x11/0x20
>
>  -> #0 ((wq_completion)mlx5_vdpa_wq){+.+.}-{0:0}:
>         check_prev_add+0xe8/0xdb0
>         __lock_acquire+0x1801/0x23e0
>         lock_acquire+0x126/0x330
>         touch_wq_lockdep_map+0x93/0x180
>         __flush_workqueue+0xed/0x1090
>         unregister_link_notifier+0x10c/0x170 [mlx5_vdpa]
>         mlx5_vdpa_compat_reset+0xfe/0x760 [mlx5_vdpa]
>         mlx5_vdpa_reset+0x15/0x30 [mlx5_vdpa]
>         _compat_vdpa_reset+0x29b/0x3b0 [vhost_vdpa]
>         vhost_vdpa_release+0x16f/0x380 [vhost_vdpa]
>         __fput+0x36a/0xaa0
>         task_work_run+0x111/0x1f0
>         do_exit+0x7ba/0x2590
>         do_group_exit+0xb8/0x250
>         get_signal+0x1f46/0x2020
>         arch_do_signal_or_restart+0x79/0x4a0
>         exit_to_user_mode_loop+0xbe/0x450
>         do_syscall_64+0x257/0x4f0
>         entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>  other info that might help us debug this:
>
>  Chain exists of:
>    (wq_completion)mlx5_vdpa_wq --> (work_completion)(&ndev->cvq_ent.work)=
 --> &ndev->reslock
>
>   Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(&ndev->reslock);
>                                 lock((work_completion)(&ndev->cvq_ent.wor=
k));
>                                 lock(&ndev->reslock);
>    lock((wq_completion)mlx5_vdpa_wq);
>
>   *** DEADLOCK ***
>
>  locks held by qemu-system-x86/5785: 3, last CPU#9:
>   #0: ff1100021d7c2068 (&dev->mutex#3){+.+.}-{4:4}, at: vhost_vdpa_releas=
e+0x4b/0x380 [vhost_vdpa]
>   #1: ff11000136eb44c8 (&vdev->cf_lock){++++}-{4:4}, at: _compat_vdpa_res=
et+0x16b/0x3b0 [vhost_vdpa]
>   #2: ff11000136eb4928 (&ndev->reslock){+.+.}-{4:4}, at: mlx5_vdpa_compat=
_reset+0xed/0x760 [mlx5_vdpa]
>
> vhost_vdpa_release() resets the device before stopping the kick
> handlers, so CVQ kicks can still be queued while the reset runs.
>
> The fix is to move unregister_link_notifier() calls outside of
> reslock. The function doesn't need the reslock.
>
> Fixes: c384c2401eed ("vdpa/mlx5: Avoid losing link state updates")
> Cc: stable@vger.kernel.org

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index f1c5f72032a3..a175f734517d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2908,6 +2908,8 @@ static void unregister_link_notifier(struct mlx5_vd=
pa_net *ndev)
>
>         ndev->nb_registered =3D false;
>         mlx5_notifier_unregister(ndev->mvdev.mdev, &ndev->nb);
> +       /* mlx5_cvq_kick_handler() work needs the reslock. */
> +       lockdep_assert_not_held(&ndev->reslock);
>         if (ndev->mvdev.wq)
>                 flush_workqueue(ndev->mvdev.wq);
>  }
> @@ -3215,6 +3217,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       bool unregister_nb =3D false;
>         int err;
>
>         print_status(mvdev, status, true);
> @@ -3257,12 +3260,14 @@ static void mlx5_vdpa_set_status(struct vdpa_devi=
ce *vdev, u8 status)
>         return;
>
>  err_driver:
> -       unregister_link_notifier(ndev);
> +       unregister_nb =3D true;
>  err_setup:
>         mlx5_vdpa_clean_mrs(&ndev->mvdev);
>         ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
>  err_clear:
>         up_write(&ndev->reslock);
> +       if (unregister_nb)
> +               unregister_link_notifier(ndev);
>  }
>
>  static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
> @@ -3301,9 +3306,9 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>
>         print_status(mvdev, 0, true);
>         mlx5_vdpa_info(mvdev, "performing device reset\n");
> +       unregister_link_notifier(ndev);
>
>         down_write(&ndev->reslock);
> -       unregister_link_notifier(ndev);
>         vq_reset =3D needs_vqs_reset(mvdev);
>         if (vq_reset) {
>                 teardown_vq_resources(ndev);
> --
> 2.54.0
>

