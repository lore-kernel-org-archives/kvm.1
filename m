Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AD3CFF4A
	for <kvm@vger.kernel.org>; Sun,  4 Oct 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139164; cv=pass; b=D3Puwtrbr/rxFtUU2JA0rTjLUU4xTCI2SH6HuWeNhsOTaE+xWgolzsxJ/mEm8DBBQiwA/DwCufuhKxSJtfDWb7vvC6+utyCWiD1FLdYan+AruMJfCeKYu/14BziTML0wN94PaRPqOWxPRwwbYQFMkm/EK6VrFD3m+H1/wjTJeXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139164; c=relaxed/simple;
	bh=Q5SKncuQynV4x7Bps+RIZqUEFmiH2TTHOAAQrnnR074=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlIUVY+yYVdM05z73rHAF+Vzx5HYKr4bp+6DcBC+nVVaOdBiyCBPS0r4Sr/uRLYfmnMBWPWYb+PfFCpA9ecgxf968JtFpqJl3jbSZgo0LfP0UA4gES5XgsaOgQghbPYbFYB8vsNAp4F5zIpp7u1tKf9yXm6Ske6q5QTqHHTvAIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0iHyxjb; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0iHyxjb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337c7b9937so265491cf.0
        for <kvm@vger.kernel.org>; Sun, 04 Oct 2026 11:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791139161; cv=none;
        d=google.com; s=arc-20260327;
        b=Itn09oqPqrrMAQMPFxQmNp6FYwwPfSs7oTrlmrfWVckOtNKZnfAe21WFQCiqGYX3bB
         SfWjTd7cXOJwSchBfdayUgYTwubkBqRCjzB+o1n19psOT54RFUwXEoE+0fGlsrWXSNR+
         NjQ0S4XljQ7DYytWyljlopLIor0v/+pB5Ty6XsnpvDDyhVL1Ncrf2J8w1lIZvceXtlE/
         we0Dz30+NAZjGmv4l9UehLJj2tH9GD4sTX5al6QLZRJYgsOKWUMeNhoc21TGm7lTIAEz
         AEOFOHX1gLTuW53UhssOQOODM4NLS6rPojDdREhKK6JwtBxbPdW9huBoeYR3tL5Dnw3b
         XYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        fh=JPoQTmo9D2aT0WZ2jOyoK5Iv2H0Yl952L0GZ6neqEdg=;
        b=iMVDJ1QCEweWqhtkjgoZXR68X1menAyOTJD+NL2TehIi/G8tptdV/Fsm3TMvf7tLzJ
         XXdZ9q7mlHWi3KTAJtnJxAtmvElgslWxMj4y2ONTPgHOjNJ6C+ebu5MVIKoc8+1muuYA
         +UL65nOkO5IflOBcvhVvqllcEDFlr11hgBz/rY5g2Xr+JZIwqH5dLgfcRsSet2Lty1Xn
         xtdFYbp7N25HrgidgbgIg3TW1vUFH7+kIeFDYmnbk6ndueC47CO8NFnpC4Bscd8OsXu3
         UEjGhFLOQLkGiMrmpg7Ww5dfi9AFXkj7Sl7Ea/NryMFzsYVHfB6QpDWr0OZqRtg8b9rr
         QkHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791139161; x=1791743961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=l0iHyxjbrFA0mj0qSWG3UEuOwCfeu39THooR7JdjvlpS5iPbcpbOGXWgFlwrHqiq17
         g6OREDzEJg1B4R9e3NlLt/FQGfnUhJDJq9ugUkIwHD8Ouc6I0KCAE+AjFJ5im2Q3teHM
         xpabytF01LqRy3edoNlhxz/KOOwY/glawDCIRDkU1ItyqnPxe60feD3VqcauD0MIeU4s
         Cvv/OfjgN/b+SrE6g8xki0vgbqOIO/2Zkxe+N05IzJfOVKCkkH4F7eFCLA6UNgq7uegJ
         Iz6k97ECHJF0Ws6uFXO0NrKMD645vu6jOd91RLmcYxQ0T3ig64z73JKnKEdXvgZ6oM2B
         rqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139161; x=1791743961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSC0w1neootLkbih9TUxoXkKPCkBI7t1n5ZaTzyKsnU=;
        b=O/ZRmN8hZGd9JtBrMj93zc/e+d0yFDq5j7sa/otguhZbNNl3jHHI3hKnNbD+9qZ4DV
         O0O0TQbUu+v+F6LgTKlyrDlMgAGPBOiKCBVk/k0UrNj8ahmMSetTVqdHKY2Q6gPtbo1V
         Ju3q21JSkEW+rV3zTek9XvyPTbpUrI1rsru3RV32LWeeMGsvzvPABQnY2PLmFNrWLNCK
         e+AksLTxJ618YRnKMudm+ZOfKEc9+kge+EjsOoX+xwP/BMs6lN5d4JnN/MqZj6GtH0JC
         skt1GyTtyuz7u2DFAV6ef8lkw6amhm14/o1r0uy0QbJREtH6WjoEv4b9t8bBCwwoytRk
         VT/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgKKI/G+atCCr1PkrM8BhLK/p2DcUZ6a9ThHqc0VfgIK3sD56ZbYw3Vt1Mb8BxbSkJ7yo=@vger.kernel.org
X-Gm-Message-State: AFuF++lH6qUur63QEy0fp20m0GCAbr5gDJCc2/RAfwXQt9NlNadw0bTW
	wsgMHVd47j8szBOW1DFl/3mpSI5NeuXw6rwlBGL5nCd6fw7a2Mbn+YVbNNE9qNsvtfkOyN81wwm
	KgLfdM0jkqxV/bfcqpmsU3mEdrRO+o/5M5KAImudE
X-Gm-Gg: AYBFou0UpPdXsa4cr1sasA0XDH/3vASfeRUvlNn4g49osp0AGX5MAN+QytbLBbjUUGH
	5tLwUDjDalPY4KpqhW4BEAF7AEuzhgi0dF08rmyYo9m4C/jDVC9sfeJQ0/L/rrLMoTXJcdYL8Cs
	qm0eltJX1Y5g/Us+XNasQyCdgopV7oWAvakleIUpk0MSxIOmbr1FUTEQXzTnY7cUQYsNc4Z3muR
	VO1z78uFnH75XB7VCsM32OAniZuLZIlYJ9IX8sgS152aYEhrcjhe0ZoH3hFj5yoL4O1WOCuAD5g
	KG5nrJmNFMlacLcOEfM5ZDKZIqLcKzg57VHmrA/bE2uVMVf2wKmF37D7
X-Received: by 2002:a05:622a:a16:b0:531:282:6560 with SMTP id
 d75a77b69052e-5351322e1b3mr19806961cf.15.1791139160071; Sun, 04 Oct 2026
 11:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-0-a1f052500fd7@kernel.org>
 <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
In-Reply-To: <20261003-b4-mmap-prepare-vma-flag-sanify-v4-21-a1f052500fd7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 20:39:04 +0200
X-Gm-Features: AclHuK-BFFMO7RL_23L1uoIyefqTPzoxo4liaojYggefG4PLZrnFo0OrrSwhSqQ
Message-ID: <CAJuCfpGtyaqwi__OXcB=iy2+LUVzFnLo-Q=Rdxz728_EHdTaWA@mail.gmail.com>
Subject: Re: [PATCH v4 21/38] uprobes: remove VM_IO, set VM_MIXEDMAP for
 mapped kernel pages
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

On Sat, Oct 3, 2026 at 6:40=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> These are not MMIO pages so VMA_IO_BIT is an inappropriate flag to set.
>
> Instead, set them VMA_MIXEDMAP_BIT as they are kernel mappings and this i=
s
> the appropriate flag to set for those.
>
> This provides the semantics required - no VMA merging is permitted, but
> does not prevent GUP.
>
> However this has no meaningful impact as these are refcounted and thus ca=
n
> be GUPed.
>
> A previous commit already prevented __mm_populate() from being invoked on
> XOL areas, which VMA_IO_BIT was previously relied upon to do, so that is =
no
> longer required.
>
> Both VMAs set a VMA name, so always_dump_vma() returns true before
> vma_dump_size() reaches its VMA_IO_BIT check, and thus there is no change
> in core dump behaviour.
>
> Change this for both the core xol_add_vma() function and the x86-specific
> get_uprobe_trampoline() function.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  kernel/events/uprobes.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd2..0f60c0d076b6 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -715,7 +715,7 @@ static struct vm_area_struct *get_uprobe_trampoline(s=
truct mm_struct *mm, unsign
>
>         *new_mapping =3D true;
>         return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
IO,
> +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_=
MIXEDMAP,
>                                 &tramp_mapping);
>  }
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7709ea882477..b89cc5cee002 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1726,8 +1726,8 @@ static int xol_add_vma(struct mm_struct *mm, struct=
 xol_area *area)
>         }
>
>         vma =3D _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
> -                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO|
> -                               VM_SEALED_SYSMAP,
> +                               VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|
> +                               VM_MIXEDMAP|VM_SEALED_SYSMAP,
>                                 &xol_mapping);
>         if (IS_ERR(vma)) {
>                 ret =3D PTR_ERR(vma);
>
> --
> 2.55.0
>
