Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90B425CC1
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612170; cv=none; b=AmUCpqgCvDqYhbL/DYuSLf5Eyo4pxpNpGKXlW+5CAKOsMnUPS/TAlWfzSiQwienMSEvncqt/IMjdym/l1++xVMaARSYqV/YfC1/CpmU1Zi+8aRt2jxao4j+bRdEXFKvHx7RPryJhuvhAuspWpTj7SMsyCH9SPVwpCENoqUUFgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612170; c=relaxed/simple;
	bh=0qkqAHRaBHgpB2UR0C6dAMPOVUmsbtzeoEt8MNK67Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8O4X58qGY+DfByCyRaE5Rcxh4PRhJBHPGQxLpHJieXs77N97rak6vywoRxUfg0MCwhfdSAfN1rsSLj4TJuRlOAjgM5SdF6lXjZs6of1fJ8mvIJMRA0PqmLEjsaZMo4I0Eyr25OxTysGCdZ6emO9NjgTSWDSDqakk48V8yyeAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MkQCpSd2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MkQCpSd2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8efef6533aaso436116d6.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612166; x=1784216966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hryUWYzOZzjuIh9gJx+Hzg+n+E360+tJZh4R7BZGeLA=;
        b=MkQCpSd2m04untsXU1nx9KbvtduhWS0cCQoIcza8A3pVIhVf9PRW/CsEN/DZAtCuls
         p7RoVeKsjloxBKU2AfxnCCAN8lhXWQBNDMfPG7gVZRfQmXhyKackY8MGGcFAEPPVy0Fv
         SDU2e8AQxkDk3sY44SjU+DAZTvcrqgnaYjF6Y4p8tOSybH+22dFesBK1qZJowyT//dMI
         6ZToGGs97IuDvRPOGP/+9UTODYx8cfsPo8904OY1zAoe+0Q0w2DVPfcKw8nstjaGRKyi
         ELgcN2ve0gKuNONy45AfjzXvUlPyOrsp6pJgUy/3Xnn2gf7Puzf5UJmIyCvxOjIpgVPr
         CZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612166; x=1784216966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hryUWYzOZzjuIh9gJx+Hzg+n+E360+tJZh4R7BZGeLA=;
        b=L8piNOzMjDlfA7ksMkJLe2sxOO4QjC3KZBYwujNjHs+D24E81QyGsdlqLtgUHKkbo2
         WBujQ8zKUjkT9OTrQUw2/kPy4OQaTZr/MksXQegh6NC1ecd2NeGFEmXhObgLsYnJy7YK
         SghucjrzelumcS5Zs5972iSD/dKHbP/KAk0Tr5SJjvjg8eEFibweAN5lsOAH4QqPqCHh
         G2rQDZDuz00w9dwueagVwsJrCZxif9h5D07yn6U5ZU6eldhUfYwRBwGZ2yq5q4jUzLLj
         qc7kHKLleJ+gKDXQRKdUz/iNjoKmlpzE5NJ/b5Ws1DQGdqYZOrMsOrqHP0ibP+3i2NZ4
         zBBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6R5NUtqak31vtlxrj9suQ24IXuSz9MEjsTrpkYeXZYsR/4S7kfLuNIV1Z4YK4WIvzg+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdxw69QnUsxKWUFuBJKM/AxrHB1hkCnFqE01KYypK4Y5/e9/Yi
	UMDQfadrBb1C4RbeiqatafHnT4ranq0bHV932IyZ7/aGP44B6WWjY2BgQW4ogjPRdq0=
X-Gm-Gg: AfdE7ckj6qrYB1M2MK6cQRbirXloBzrXOVvdxEauhuLH7NpsuWC7UVohnedN86yKKAK
	XkHcw9bVgTwXUMpVfYfrq8MLkGO8V0/TW5E04pROgjV5FCOehCfkvqKmoSbtcUbsAy143e+loL4
	0os18Vjoz/YyzPxEj+UEGfGG9Cs7C88HIms2bBxizbUIeM9dgH95REq8yeWfGlEWeBW5TANHpwP
	1VYjMPkV+zy6fBash+Xw3FBp+VYCyQVmNe0FfBJD2ga/gXt8Yt6xx76ppYnaKA0Fk4A/pAsCiMd
	IFQbgkg+70ImgLhAjNmSG6Dj4xOvTOcvknBPz4chO/v4kviRES/RCsGFov9O8jbfB/zxbuC0wlH
	einjDxTzmaUK+LVjGS+wV+0+/AIpOvsnMkSbNhxq2kHKgZDYOENNUkoWuKv0tjeQEqPsHVSiih4
	OWbI/BEJBzWKmQJp/ybL6UYfB4eKetnr7OLeHwnPduZkcEhNHubxs0INU1L4yZzNWrrtrg
X-Received: by 2002:ad4:5c8a:0:b0:8cc:2a92:48e4 with SMTP id 6a1803df08f44-8fec217b8bfmr87997286d6.32.1783612165998;
        Thu, 09 Jul 2026 08:49:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d9f6sm20164456d6.23.2026.07.09.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:49:24 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:49:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan>
 <akZGqclqQ6gS12Vv@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZGqclqQ6gS12Vv@lucifer>

On Thu, Jul 02, 2026 at 12:30:59PM +0100, Lorenzo Stoakes wrote:
> 
...
> static inline unsigned long vma_offset(const struct vm_area_struct *vma,
> 				       const unsigned long address)
> {
> 	/* Retains page offset and tags. */
> 	return address - vma->vm_start;
> }
> 
...
> And I'm not sure it's really all that useful. Perhaps retaining vma_offset()
> would be though.
> 

Silly question:

   What's the purpose of retaining tags in a non-address value?

That sounds like there's fragility just waiting to be broken.

(I presume you are talking about things like ARM MTE and such, right?)

> This is one that I think makes more sense.
> 
> But in general, I'd rather hold off from yet more churn here.
> 
> I'm making these changes to establish a basis for virtual page offsets
> introduced in [0], rather than just cleaning up in general.
> 

I agree with this.  If the refactors here suddenly have to think about
corner cases on things like tags, that's better resolved separately.

~Gregory
