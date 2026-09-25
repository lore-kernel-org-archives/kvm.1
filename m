Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48D44BCB5
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321867; cv=pass; b=E8gvoCjp5s5wmIXlFPS6LOijOR4IlAa+62WO2To+a/cUW/EYTbyS/232tR/6tzQRHRYaeFtycDvAORZQN0fEUkloModBw93TQtvV7v3ZU2Ecis+wU8mj6l/rtXK5u4UOje4FzGU0syy271Vl8ONaQKaAT69T3cNMz7HcQhFCPTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321867; c=relaxed/simple;
	bh=4HRCApcqOCblV/nRa/gIhH9hhLpyjFWAyS7KPdKAl2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q37sOeEGIq9Iis431vp/iJhKPmlTl1FnNuOteiuL4Ja3PO70ypogdviWchjU8dX+XodxkDuunrYwoJyM4VWSQiQ+bhKDlGPcmPckax/91pXDFcZNVyyQNIYFxbFDBWInpUVXJmbcfJNjgKAxQ+B9SGzRgw9SUs3y72QBXdXX/BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ9vFxFo; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ9vFxFo"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5562a12.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 00:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321862; cv=none;
        d=google.com; s=arc-20260327;
        b=T9f2UC+BuXMvsY/A6HRi/+yDjvVXDR2TGeCvX3ZyZ+EpSbweVZ32poHiuyQWrbtfC+
         dMWbnR4MA4L72eZBdSY/cUluffzvHpEyC1natBu8Q501W58Us///RoOPFfbJOdnKbkxl
         0drgcEkXl2AR8r1WtQDRq6nHmm8fxiCrys9TagawhvEouHhMT9n2k4yekxyG4PZa4D91
         hQ3OwuP3l0mpnDgT/v8Eplzq4CVL1LPPuzVp7tV/aPPOH5I/xGu68D03gqNjnkMtop34
         f7JCVf13pd3Q3QneBpVzpg+F5/PHG8fBaUEIqkrAWCkO3MFw0NvZrWO7aJJp06AgyynT
         rnBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        fh=YOoLeEc49OhJikpuiea+pG+NiZMCFZ4yy3Grq1BClIU=;
        b=mvIE+6SjUe1VeVxplXW8nCjWwxM/lQZdTMuBgcjIxXft04/yungORhPstuHWIzFzEe
         BRQNdqZa8HD9sVu9MMLOONi/GFFKbhbnJTAgRglSBPo1egHOO9JVchsrex09Q6QEV8ny
         g/eFm9wqkc3SXDl1yAeb3VWH+NTPkGvCDPoJocElksUcCoJYefpoOtrysA9YQbEuHSmY
         Xpj5WUQPYlZj4C7pmNkNpHBuwHsUXgl0HqnPxjKAtqwLZlxJSgup5ga1sfkG841HF6p7
         fLuCtdXnXasyn5GRTCjAyi6BwZGLXQovoNt81su2mObFumDLU67Kfdh20gzvdyxyUmdC
         TXzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790321862; x=1790926662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=mQ9vFxFoabYALJuAnnXHoi1jXZaav9RmInZt43IwRm/fzvwjOopZ3o7VIc+dy42EPi
         9HROBxO8UV5pJ3vyakmz2OrfmdMJ5l3k2QVu7h7aN2S0ymf58OD7LXQehwoCCooGWSlJ
         MvGdJLno+5jm9IW1BGyaIVzD6rp/VRh1mI6TzCU97v5KFsxHRp89wyD14t2ZDP1tEBeD
         A91+ZQG6N6rJ0BcW3pG13YSmw/G2ukmHBfEkN3uE08LggWf2y9iU8nW5r7knfUMWHZRm
         YPH0c7LQUfotrpUgKUi9Amtde8tnp230k0vXLvU1SeSceyFG1gck3ElBqcrZJ09QAjWJ
         kRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790321862; x=1790926662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
        b=pEo298PSSvoHU+3MBsqrpmfAGnmyK0BD3NPs/8ouScDL5gmsjQTQv5Cg2RN6LwYk7Z
         83weI4j+KkbKZzaewP0qCz+6qLTbQCeETynSoq6islPTAcj+VOVC1/a1Gksbv9GVaGWR
         E7iE0euAkReFV/WOGW3KZsOLR6ewkLjeqrvKErerOylWgzU9mrnmqK+QtTjZnKdYrMzo
         xBUBukHAHXhGTG4l33iWCXDoVDi2QI+Cx6ZSFBMM0uWN/61GaR5naUnfTNRkBq2NkJ6h
         HSV2BRswJK3Jdc1lyRhHaJin+IvfA+eATGiTnZgXPiwOLmgm1rJAkbkF86A8+XUDXjMf
         g0Ew==
X-Forwarded-Encrypted: i=1; AKwUvByMMnJT3weNkW7eJFf5QyggiHjyKgA4iv9jb3igUKOWE3t1eWCstdokJeP4q3BZ0/d2C5I=@vger.kernel.org
X-Gm-Message-State: AFuF++nNTHbhaQQ8d+nIsyB18w/fe3Xd/Xwj1rdGs21AdHXTlnuPbvB7
	Ahpbfk+J58GuMLHjtS2Xsx6dcrGKZ+QFLBp6Y423YYrVs8aHi04+rxM1K+beg1IPhcvbRtz3ed0
	nwrKNkOMw2o+2ARIDqznCBJlXtrapgRaKHP1nTfei
X-Gm-Gg: AYBFou1CYJW7eQV0vZnp8Ue6cqNANG6ke/7oJ2ogCoTD4964Pk3DWy5YDAwtzjhXTVx
	kzH6voh3I6pD4A84I0ldo89qduQKuUSIChMpOzMK4Hayp3jxY192QPRCOFYr83yv1tbZeuGhWA0
	xBdAfxGo9J7FacsDBtlIY2BqohhRtGKsSCzNhzRYWNQajF0Oo0Lf+M2uFrc6QnW3HayQFfvIgta
	7u43xXf3xp+8rGlH8lBGCEpCeP1CTJ0+DEC8sHNiMmoOF62J5KTmOVZ37d2I3iJg/05bPH3ePMo
	HKL/TfAlJZBAji3DaPR1gFKtOGTUJYFp0sO7yEkBzTOv+nd4eKZnBw==
X-Received: by 2002:a05:6402:2714:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aae4729638mr36915a12.4.1790321859803; Fri, 25 Sep 2026
 00:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org> <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
In-Reply-To: <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:37:26 -0700
X-Gm-Features: AclHuK_RUT9CXNFLpx8ZY_roLEZNzp5S3oNdpNL4cW25fJBFg9wRGnSWohuMdYA
Message-ID: <CAJuCfpH6AF-hOo4jU6OeNVpd+fgpqLpmcfAGs11J=nPCgAqG_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
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

On Thu, Sep 24, 2026 at 12:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied=
 by
> > MMAP.
> >
> > Also while we're here delete useless comments for mmap actions whose na=
mes
> > clearly indicate what they are for.
> >
> > Also update the userland VMA tests to reflect this change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 2 +-
> >  include/linux/mm_types.h        | 8 ++++----
> >  mm/util.c                       | 8 ++++----
> >  tools/testing/vma/include/dup.h | 8 ++++----
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
