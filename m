Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583F223708
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136945; cv=pass; b=Zw72ti3AS1/d5/3e/OC6ps4RhkydXnQKXJ00lMRo1dbZ0U6ABABSwWyAO3MePYEi226NNsaLYq9NeNx+e8l8WudwrlGnkVVUzX54hanLA4+jY5KqBLi4N9/iX801zJeoLgnJ7ROYgrD4Ez6wrjiPyW5l3L1LNAWl1Euxryh1ebM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136945; c=relaxed/simple;
	bh=xOBOM0qU79KZiyR638ux2NLueBV95WtehhE5D+Z2EOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuiNK9DT7gdeEUvGEhxJ+L/JeA1s18YnSbNNstiRECm2SZF5aHGs9Ds3EZfCOL2MHdyPhPb38Sf66cNQazlng3mDFj5+u1L6znulzgrQ9pc4CUkwm6KBKuuE1NFkm4ZDDcrdLukUfcgcssRDlTyAU44U+2IYZ7iDGZigH7HoAfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EzRNGhII; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzRNGhII"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5337fa12431so184081cf.1
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 11:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136935; cv=none;
        d=google.com; s=arc-20260327;
        b=q3kAs89bFpaN3V9xB2pUunkBUhDMX2zZkB0hswwJAdEzt9bfHpDWn6mkVH6t651JDn
         ysZp4Xqasxg7aHarVhEoMkkUGxndjuYgc8Wd4ilOh0brLT1WCDvEM8aHgmksiEzlO49A
         mtyFEdiL2Q6uJ4Ate7HCMIxQx7oxHz2ElDp5620PXjomsTB3e7AhioV7pP/jU57GfGcq
         67vJukCMocKdnAGUuekfaV9g/MRdVZQA9j+kZyh5Qe2Eic4Ux0nS+1NWI9qFDdMxeLpT
         NKtmPFG8XrclpXXTEbhRLgR3CKg3PJmpPB7Hb2n17dY51euizjVgjMMXKcpnwSjB+4b1
         //eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        fh=oaNf609jsIRIQDqP7jTQdUUFgYDPBSh74TgyfS/7l7I=;
        b=LgRUqKNDAUkIAzODA/8uYCHiXiKIqn1sgnvIpU5HNdvUkCWa9FK7GzD0g1AEjtnRL3
         sz86qO7Q2vBnq2sjrTQbsres+7jlqlybF+tOjFwTQAXU9pSn72FR+8euahcQtVT3w7KK
         nzs+BX+jossjGzVn/lYf5jiHf72a5sKewIqhGuTgZ16TgYjRsFL/KOMsbduOulNJ78Rq
         Om6UBgtXJvj5fOcHXhdbw9YWNg9Wt/2fpm+Xf9//BLXkkmk1Jt2/JTUpYLV45vH7WMJr
         zWFXl7hXnF7RFaqSrmD/LOS4l4Jf4wJAY+0CPvAbXkdkBzKYYhnqHn1qCT5fyFP8Aoxh
         Yt2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136935; x=1791741735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=EzRNGhII5r+95roQZlVBkmYNQdaiRDoLFBLNEVDHO+/MdO62rSW77h0jsY0RRI7TOE
         OGizXIl23WARyeveEsg9A4VKDlhQ107vzXvgKB0/kumOZE0OxLvvTNILxBDSV3YzzO8k
         qiO7RseqnigoM4JWPrCD0Bqwst28hHQj3ynkIBcst8yxNsMOZSo71JGcgRt/gQfuJBmy
         aRm3rm9+wZlzJp9JgpetPss9VyFcXkLcrG4rtH3CiCS5OBjpz8pjPDk2RzfpGkkOJU/6
         LOTv8VmGgUBpxyWljxRzHPYcvYUZO7aEnLg0bU+UMvBTc+Kud1K9PjZyHy1VScuLbj8s
         CCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136935; x=1791741735;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxl6gThguTjmryCDwAa1VxSTqh72eFueCyhgsTktke8=;
        b=LoQ0FstKXBcFHJK2uJycpmVKwcSyAmDv5Dz+IxzH6MyDsrTfh/N9jj2ciCxcwKNXQb
         EnecbsMBoMXHnRd3Eay9IP97nnOHk+/Di443Bm9JhUniGFAs52e4Mw534Mb7f+ih0CaK
         NdWMUz0JnzN5gbvzQO8UqW05kxCjiWCpb7G6ivBK4NRy2aZicAm7TQniDCVQ346JbmCD
         3zCYtUHItlByKHXlF+XtukZbP/tv1ol2OA07DBIloRjVUouE5XcC12u+ZWtD7jUo72HV
         Gmlv6wV8mGeDk5UGXJ5gVWSiy+DDXdzr7QA0TfPeq5pD6RaIrkjNhacBDnJBMyo7Gzgm
         iHRg==
X-Forwarded-Encrypted: i=1; AKwUvByUU3hKARNRtB6lBiSfqlwSK/Vf6xr0tnERk8qzYSOWRVElYUeKEYWdNl/qyK8IFZvO6xE=@vger.kernel.org
X-Gm-Message-State: AFuF++kMFy00CiIUeq+RJuw6Sp3cg9TwI4QmkQg2QKlhYr/EVQC3GGqi
	5d5cQoFL6EIH19kOuBBykPCDrUEfPKqN9XxeNokPe081v/6yUrSXLS2pczIIKqrPA7yLt9NlTUw
	axezCL90Q4o+TGeY7MX0vOUL/Ns0/xh08YuTIojNm
X-Gm-Gg: AYBFou1+tkMbbHH/3XweEkpaiEn7heB1hHnxvYggrRPbzmYtB3QgnKKK+fV0PKVGqGy
	CcegbOng1CdDSbqbhcts1Rmn1ug8OFUDvZeC+bHv0o+GE5swDvC2GhHkNnly0iVcFImVb8F9VfR
	yHX8roUfU47WtoAxbfmJR5wGd6Ec7fpIfLJ1SUyFVXPMjRdcNigpYU2IPnaD1ZkfQSAq95fjunu
	nVQ1ZmQi13BCDzQ95qIDis5Id4+UDzKgNXo4GbrFzKf9uKBtcVOcbd7GYv4jqV8IEFdo1HTXaFb
	ib8+kSlVyYOPzyfHgzJbRvI0cvz5rIPzjiMZhtZ3W2jEWEI6rqWBqj5I
X-Received: by 2002:a05:622a:1b20:b0:530:e335:4ef with SMTP id
 d75a77b69052e-535113c3cb6mr18023261cf.2.1791136934142; Sun, 04 Oct 2026
 11:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-18-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 11:02:02 -0700
X-Gm-Features: AclHuK_nOqMX3djeZOdNLjNPymjaWdesvnL51eoG4SJjNhtYox1cB5x1yziRAMs
Message-ID: <CAJuCfpHiaV6uDCfOMmHJ4tPosUBPRMUF9zjrB0fkCWZG1umG5w@mail.gmail.com>
Subject: Re: [PATCH v4 18/38] fbdev: defio: assert FBINFO_VIRTFB, drop VM_IO,
 add VM_MIXEDMAP
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
	Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 6:39=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Currently all drivers which use defio allocate system memory. All of them
> also set FBINFO_VIRTFB, other than ssd1307fb, however this driver allocat=
es
> system RAM, so simply failed to set this flag when it ought to.
>
> This patch sets FBINFO_VIRTFB on ssd1307fb probe, then drops setting VM_I=
O
> in fb_deferred_io_mmap() and instead requires FBINFO_VIRTFB to be set,
> erroring out with a kernel warning if not.
>
> The logic requires a page from the driver and since commit 1ecbc7dd2902
> ("fbdev/deferred-io: Always call get_page() for framebuffer pages") has
> always required it to be refcounted, so this was implicitly already the
> case.
>
> Finally this patch sets VM_MIXEDMAP, as the logic is mapping
> kernel-allocated memory so this is appropriate.
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

With the same disclaimer as in previous patch,

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  drivers/video/fbdev/core/fb_defio.c | 6 +++---
>  drivers/video/fbdev/ssd1307fb.c     | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/co=
re/fb_defio.c
> index fd00b86e1ae6..fb359ecc3966 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -366,13 +366,13 @@ int fb_deferred_io_mmap(struct fb_info *info, struc=
t vm_area_struct *vma)
>  {
>         vma->vm_page_prot =3D pgprot_decrypted(vma->vm_page_prot);
>
> +       if (WARN_ON_ONCE(!(info->flags & FBINFO_VIRTFB)))
> +               return -EINVAL;
>         if (!try_module_get(THIS_MODULE))
>                 return -EINVAL;
>
>         vma->vm_ops =3D &fb_deferred_io_vm_ops;
> -       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> -       if (!(info->flags & FBINFO_VIRTFB))
> -               vm_flags_set(vma, VM_IO);
> +       vm_flags_set(vma, VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP);
>         vma->vm_private_data =3D info->fbdefio_state;
>
>         fb_deferred_io_state_get(info->fbdefio_state); /* released in vma=
->vm_ops->close() */
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index c4fdecafd856..958514a35433 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -763,6 +763,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
>         info->fix.smem_start =3D __pa(vmem);
>         info->fix.smem_len =3D vmem_size;
>
> +       info->flags =3D FBINFO_VIRTFB;
> +
>         fb_deferred_io_init(info);
>
>         i2c_set_clientdata(client, info);
>
> --
> 2.55.0
>
