Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C634B68C
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709964; cv=none; b=pRyJjZcwI+JQ9oA8iRTAIFh3oSOAlVACI80p/YvF+LZYlMGdeA+XyXxDlagbH6ot5Miu4E6z64uikCTp4rwd50E3+xvEE922lfst3RCBz5yKrvQG4EnEoYCzvZJlyqhBk7HIDI3Yq2dGdigwQ/uWvudCrHiD+ZfPTS9zyofGiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709964; c=relaxed/simple;
	bh=L1PtE+Fge/ce+F2DBwYJ3SZFAaV5kA0gEoEabNlaIYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLZsgt/zMAB+gU975MDbc/I/4U1EQPrLsThKplrzS+qvvHPVf1PiXxQ/JIry87KapD8AfaKBn1Oo/voK+XpxhRW3N8ILrqyoDDVLBOGJyNmQ1ckBgjztAVteXlpICYutJDImiCy8UEJOULttKb9SooGc/zHDk2aFzEeYGinC34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PB7oBmn8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PB7oBmn8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2a449c57so7442531cf.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783709962; x=1784314762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=74B4rm3uR5k1lRSPUh5wFwkcdLxEy4GniWsMlOdHPw0=;
        b=PB7oBmn8rFdXuF6beB/vgXJAJUCb5Wiflj2c0r3WO5cmiDQzPm/ethlo/sbnW7mgCr
         3o7ztziuDHX30UmZN++fI8CpkIsthHTQQ2bJAiL6sImi87C+qTC1GAn82Iq9uazMFTfO
         QfEwUcCldmMKjGyZy+6yP/N7aAyAldDa65gvulGMOoGz0V9ZSHnFIOqvjnsJ5ZU6RTdp
         1jm7WtF/6Tl2z0LlUvF9vI+tCPYhwOkph1I/MfdX11JPSe/Y/iUI9R07HVt50p5i77sB
         tO8wvSNPxWUl5eYxL6kmLj/79pyhsOdO8Nc162WbqFC/q/La2DldEC4WQ3/tPX0i/Bl3
         +ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709962; x=1784314762;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=74B4rm3uR5k1lRSPUh5wFwkcdLxEy4GniWsMlOdHPw0=;
        b=B9AZXLAy4/PFEHOsxirVMriIwPcufLL7nf3ptdPBri8ouzhcI2GA6oizEjSmTJixRW
         WnvwdLi6ne0lTpTNNEGrg1NWLUXPT47xpaglOvF7JiidsT2gU0O5tyKBELq0mTzRt9Gt
         cn0F2TyzG3UtxQQg5qAgPEVdrRRTLkUxDDPXqod0/tRDUvKWYfJeffGKTejqrtfKmDeu
         OCp9s517cXoehisdtozgQIpLrOMfD8FD1wxxzzLqhX/pA7r+4iQbt6pOGyPaRC2dRsde
         gDWUMBVbUQ87DbvBdzPGE5+EzzOiZRtCtrfck5N0cjSh9wyhSNrI1ximMs8iT79unj8O
         sw9w==
X-Forwarded-Encrypted: i=1; AHgh+Rp04wbtiGCIO8V5T3NMefn+xj3Dvs2vIzY2NEVucuAaPX9Sd/jal6wo8DhPHwVi/oe6QXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvi5DAtw0kddsrOohqYvVz643K/nuKoed/mw84SSt/swiLwLAD
	KN6uVmHF0HLignK0k5soQnJA+ahA9myEKKx1w2LbpqGGuIkGia9mQaXbKHvnRc/gh4M=
X-Gm-Gg: AfdE7cnfBhiKcN//QR/TZv7mKBJrFfq6eXmvSpVbVnTkr30PojrHHDYu+tpn10GzI2D
	McX3Y0mqOGCY4+4KKHLAIbzmV6poW6xxLVwy/s43Cnj9/U2MSdYoTHVKWS1yNfmTupzCl7txiCb
	p+z6FB0GP29w9ue97MK35KCGL1IHFJmpPLpZoOIMic5ohCJTdilFOvYnnuwUS8FuAQQ5aR07Z3S
	ZPaup8dG4y+gfv0xnkJkDSguO1W0GauBRAFlcuLod6NDq/38I/EI4Ak1s0EIKqaJ8eOUhTcTBgR
	9v3gSceAi7R44GgrDsGicOpWvuyczZJpGHt19fz/ZHn6Wj9+GG+5NkbvyIf1T48WteXb/ns/GMI
	4lN8FVOh5+rxUl9bHtlB7J9xUAkuUaWufZmPgq6YmPpL1xrJi14OhcTlaLc/nzrq4qZOV/qhifb
	oHutL0KH8i2Fm2bD7vU5lBgYZPOzDrYryUlzxt4nsGiNLr/3L52/Rppk7OStmK981090HK
X-Received: by 2002:a05:622a:1b17:b0:51c:2101:ef with SMTP id d75a77b69052e-51cbf156814mr1787851cf.19.1783709961653;
        Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51cb884e0cfsm12321961cf.29.2026.07.10.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:59:21 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:59:16 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 24/30] mm/vma: update vma_shrink() to not pass
 unnecessary pgoff parameter
Message-ID: <alFBBGN6a30A3bQ9@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <6dd744d57d778f94d2fef8fd623d7c4ed8010d93.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd744d57d778f94d2fef8fd623d7c4ed8010d93.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:35PM +0100, Lorenzo Stoakes wrote:
> vma_shrink() does not need to adjust vma->vm_pgoff, we were passing this
> parameter solely to satisfy vma_set_range()'s requirement for pgoff being
> specified.
> 
> Since vma_set_range() is now isolated to vma.c, we can simply introduce
> __vma_set_range() which sets only vma->vm_[start, end], and invoke this
> instead, removing pgoff from vma_shrink() altogether.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

