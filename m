Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DA2AD03
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555574; cv=pass; b=Uh8lE5s4zbcHI7UZ2qBa1i68vct9HO7AFU1kYDwQtfcec7XNnK81BFyzMxT8gRUyRTI0r+bWe07yw7+App7fsgxo4hUwDPI9sImi4ZqvmuU0RaZWY/1plFjLhTdAZOZ5oFYsRUTehWH2ZB63iWXwctYkaKI5Jy1O1a7liqn54hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555574; c=relaxed/simple;
	bh=4EuRdo8+QeN+yDW6A3X+o12IBSIMc42jYmwxuetdwEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMd2yOmStY8nFDasfbUN811LLnxgF1KaoH7huAelGw+MxkHKRIOQoi6xHl2nYaInOJsonI4A4EM7k2TW1/1I6EIfro8A3QxuJB4SVQahNjBQP/GYOHMi74zPstN6R5nBQgM3CHWoAEHLR6meYaHUqwKIq+7OAluDoIvUR0WBeA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tui2OcZi; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tui2OcZi"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384c94c9414so1146328a91.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 17:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555572; cv=none;
        d=google.com; s=arc-20260327;
        b=BIlCaVeRxeFN2xJexDeJ5IJmaChKXzgGIrAuh+JYALIK+a3bO2y8mTbrK4ku+l/39o
         zcyocXOEBbdZxfN4vjq7oKioQ+1K2bewxlIiA2IpXMDnZ9Mtg9TiCyvUdt6WGxBjDIR1
         mCL3E6zhoExnDMwCBul34wnQYCmVSYkhBrEWV1cw3G6phjEyKkc4C4I4fOCoqv6mmedp
         Qob9HqDvbNv0DoHNs2ss/uWHqmPI2u2P5a2r+SchBnzOY+EiIkbmnWrVoJ1AInxQY5te
         w1fgp0sSj5MoGxNirYdhQfr1regI9bF/TDxnPccUpkNVrTucWdQFbW0lQranpYDiCLkB
         HtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        fh=SF1qp6Jq156QZtCD8XZInK93W0dhwIItgBWettetZp0=;
        b=HynpmHiy/99qRuESco4GezBPKy9K8Rjw9ypOcwEyt9d6e2idQDt4Fj8lB6lTe1/aWf
         7nBYkZuoZ43H1pvqLOR4oKntSOBKWurIM97kd4mW/qaM9WU85ORr4KbrqfkCcbfqlUNl
         v1qVv674ox3wXwzjLO+092+ABvcriwluKYGjtz4WM0XHXXAxjjimd1Vo3yrYWqIg/jRR
         TeVAf+0kunOLp9fUXob8hJllijsmNMVnykHhIw5+Xvr62EVkPucPomL9e/zHgUxwlooG
         M0AItrbRTYR6b49sX0xSbXAAQP9QXPwtgD08VMLtNJE7AV79lnJxGOdDVQYqBLxsxCTj
         FlOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555572; x=1784160372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=Tui2OcZis/oIXOg64/k9In1vUq+guVmxXWVelpwI1011KYfw3Hl1jPM5DNAtnP6dud
         tNbegsDZz3ZfVCv3LGp5grJaOjpctg70Hd3LmUk7dQI8Vv2jYETpC0sGkT/KvKGM691w
         BT+XRpKkVjD2SrNiht7Qet9iH3M7c1BU5Bigcy4v8kA+8fmSzuSX066UPuR7CrLlRe5Q
         CeybiJeWPPdsESYlJxF9n44iu34oqvjy5d7QBDLGRppOZkrJs8UCxKIxMeLGvH74IBhr
         QssXYAiGebRkpz82B4ZjFbA4HpYTL9wbjKch97ta4LdApRDYqVK52ldJ7qx70kqeApqR
         Xu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555572; x=1784160372;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=r9eC9pE318hriMIKbl834sWT39K69InW/jYL///EGERQH3R9SrdFiBCNLaIUSU8dxi
         mw9CbXFJTB5DsJ0wiFcCqy6X/HSThiDX7pWGFbYkO4NPkANArvWSzCf57Sv0mrEg7l/R
         wHn1jtatH55QSXg8/51EMRF8f09LiM8kEoPMzEBHR75yDZUKTubbXlI9xjquf9IG3Q6Y
         vjIMu5wZKRk2khCCwhoGwDm8HUUB3JxQBTps0+JK1RfhUGUwG0Ecfw5k8okO4Xqp6jSk
         DQceGsGcnGeOMp5VAhiRBpZ68LMx7t/QX9IdS9uTkMEUQ/un/pgc0FBvw32u+ps0p7Y1
         /thg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf9zB4XwZ5oOAV4SN4MzYSvasLgKWdMsqEzyrohnZPrrr0fIh1hSju55OadHAhLYjM1Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtZoSbjAUwZseQkS4v7Idtmmj+q3WIL5Jmr6LuJzwmkEiYZZK
	YLHjzERM/QKPxmzfalRGIQPlZ1djhEpApfzeqVleRQ5uAsadTITLRfSob3eCu6BBFjRee4V3Y/B
	6h7We4oNczjx4pkA50Q/DU7ZAcPhpuODP8b3+H4PH
X-Gm-Gg: AfdE7clcJXFGlspzihjfsGG6nR2crCs3uKcY7Dbux1Gydwe/NJKhRdG1nPs/nmzydNz
	zhcxEhWB66/8FUPiuKOKGWKnxKbGSmwXAT/5VkWJCJeHvDRqzxMtSdMfIxC3a4ukOcgLDfhKMpw
	uxAFSojfdGu8zpoy8VrVIiqr4EVD4G/3VXThHVznTa+svT2E4frT5OowsQGX4v2AydbmZvlBT5k
	9Cdb/5NvFdvKyFUYx9Y8kH7hsRZSO5QYwYlJxySpBy2Vhn1cw3C+mnZj8g5X7wfYY8I40Gq+3w0
	GS8Sl5JaLFjuaSB7Pev4BzC2N9PAjKJIWy4c4hiRb/XIHwKQFHNAtTsB9O4=
X-Received: by 2002:a05:6a21:1f88:b0:3c0:9c19:b27b with SMTP id
 adf61e73a8af0-3c0bcce9940mr4979424637.73.1783555571036; Wed, 08 Jul 2026
 17:06:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:09 -0700
X-Gm-Features: AVVi8CdcseowPqFId5ObGoqB8gTqCLO4QEXGH1ZjH1-pjTCLGI84NpwTLe_LrAc
Message-ID: <CAEvNRgEV9VkWHULS4g5hVHu3T6=YZ89HJmkv6rS0+hK=5UFu6Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..f0e5da490866 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -440,7 +440,7 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>  					     unsigned long addr, pgoff_t *ilx)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	pgoff_t pgoff = linear_page_index(vma, addr);
>  	struct inode *inode = file_inode(vma->vm_file);
>
>  	*ilx = inode->i_ino;
> --
> 2.54.0

For the guest_memfd change:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thank you!
