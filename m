Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2D367290
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610331; cv=none; b=fbT7u6qoq1BzT6JpxKcfeR4lGh+esIrHA3cdnWvBbLoreYs5TfKYLN814YcXvld81HEtb2dzH2D4n1Hc+EXDxSm9mZxhW7Z9IbQcdYkQaRuheNhFD/OyM0Zk+wcG9BtC5LO/EjaNRtWU4TFD3ECeGIo7RBz4jU7NZ5OLUEKT/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610331; c=relaxed/simple;
	bh=EmhDmZEzfDqtz+/wM5OYtSnBNKhNR5z6WmgKAnKqYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6IRr/hWaJZww+koLV4wsba0EcYhIoGXliS7LHHfdt2Xql6/VHGqPxC2ZkQ6Xq3xQRIxNjCi0ngb1fCcMB08phLiXfTrJ/2Qt8f59T19jRSyjXvMbTkrzdBPxuZxKdj2gS8mbg/yO9Tvpm+ogZeOxyelSslOo1XO4YJDp+711Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XYuSc5IC; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XYuSc5IC"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c4436d02cso9165241cf.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610327; x=1784215127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=XYuSc5IC+EVJbDWikpVPC9cDKrnWwVwEAM4vxRerghx9T5cLKor0lZn/3xvEy8MYvH
         P4G8QPzYbfEZ/SuD19iQ/Y1IHWEN8FQYvrl4gGGNvM85yYx5CoTWRnrwozvd8buW/yZu
         rTLr0Kl5kFm/eeBRVjl2lZuNMDx5WC8PeGDIx78E6vBCLlaGrNT+PUtAJ/u8INBmJnMf
         RbCmKrzJydlT8MQRk1duN94/X88hvDTJtAhpiVN/Uddledvv9UkLMBn9POBFDX+NJflU
         wUwaXNQ4tD3o84h7GQtBbwvEsPtUxnWPlr1FHKAANE+13sbK/9le7ZhU64POCONVaFwl
         Syjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610327; x=1784215127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=jxnNjKgg51zNb4cDfXi65aa06Qc88ueQTdnlyq4iE2+uh49cdgU6MVl4r69uc1rynG
         QKdF1dWBJ78vi/30BjESRbq+ChStTD5dbEfNa1l2drZI8fpQpsfYHIm62H2haW+FPkU+
         qtg4379ekvNSK7pAWZCvYXbn1O5t366sk+f9fYgPlNrofq/eg5BMwXc1HOpEkivf2KLE
         D2NqU2Q2fpqJbzg64ADg8JYbhXjxoVl6QQrI8OuQoC8oxEkXPAruh010uyszK+rBdpdh
         OLKHgTDto/hIQW2QN4pHxdK4hrfWViOPtBgD94deS/btkjYElL1+3F8fBr1R6wlVCvhn
         SYaA==
X-Forwarded-Encrypted: i=1; AHgh+RoN/cqBE6UzbfNZIUw0eqr7MOMlkloOiXjVBNptu0so3wySugjDgmUoGyvwjcPvFiYIbnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6mcGMrM5xPKVC5M+GWy9SM1njjRnxu8NU4x7Z4txDb+hNY1R
	+8nkeuVMhvUblfL8q2BDk8sMgiUFZGPKrYmizORJ6qTtqdZ5OLv5kk+houU5urHIVQA=
X-Gm-Gg: AfdE7cnONwLMv4MBeLhpkiUPd2bFRyKF5U/Yi688Y3/mHMcD9qYY2ala79a3pNPL1aP
	da7YoeOjELIQQTji9FHVpLqlJ9U1bpNyoKjgjEFTpVwAK+JGRKOsKuuKhEuzXedO9AcUNJGy3n4
	AjKRaFxqAW62utHobuWcwjQ9dAIAgsxwB+Y0bqEP41PwCTssOB4SMtHJMk223QJdXAehguFIx1n
	56xhfDoBOThj4SiZn2Jkes18mJyOERhBgflxmcR4wBM/4ILGz/reIIwTckHWBT7V/RQWTjsUAE1
	iV+t2aEoApKDJaSoS8C5jV5uR54C+iUo22SeGC9hsXvMQjRDc4bqNKYuiyr8ALBzlOYF58D7r0E
	pMIHOAkG8/6RdEBdFxYTkg1WQjdLjCOj9J8V+yR1m/Ig37Vwoz1UJ4yz00Iw7B0OTV3ROoPv2BA
	q95A5ubet5R4Un6bUD5ihV2VFaBfk86UFVnT5ODN7eXH3ispPFWCI5iu0cRS2A93T9TGSL+MMDb
	MoHfak=
X-Received: by 2002:ac8:5cd4:0:b0:51c:1c2c:a8c9 with SMTP id d75a77b69052e-51c8b3e2e32mr79753441cf.43.1783610327278;
        Thu, 09 Jul 2026 08:18:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41db4fb5sm158006781cf.25.2026.07.09.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:18:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:18:40 -0400
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
Subject: Re: [PATCH 13/30] mm/vma: refactor vmg_adjust_set_range() for clarity
Message-ID: <ak-70CHGujkI5jJI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:24PM +0100, Lorenzo Stoakes wrote:
> Add comments with ASCII diagrams to describe what we're doing, avoid
> dubious use of PHYS_PFN(), and use vma_start_pgoff().
> 
> The most complicated scenario represented here is vmg->__adjust_next_start
> - when this is set, vmg->[start, end] actually indicate the range to be
> retained, so take special care to describe this accurately.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +		/*
> +		 * vmg->start    vmg->end
> +		 * |             |
> +		 * v    merge    v
> +		 * <------------->
> +		 *         delta
> +		 *        <------>
> +		 * |------|----------------|
> +		 * | prev |    middle      |
> +		 * |------|----------------|
> +		 *        ^
> +		 *        |
> +		 *        middle->vm_start
> +		 */

Even with these diagrams, it's a bit difficult to understand what the
actual intent/result of this chunk is (but that may be a limitation of
me not spending enough time reading the surrounding code, not a comment
of your work here).

~Gregory

> +		/*
> +		 *                Originally:
> +		 *
> +		 *            vmg->start   vmg->end
> +		 *            |            |
> +		 *            v    merge   v
> +		 *            <------------>
> +		 *            .            .
> +		 * merge_existing_range() updates to:
> +		 *            .            .
> +		 * vmg->start vmg->end     .
> +		 * |          |            .
> +		 * v  retain  v            .
> +		 * <---------->            .
> +		 *             delta       .
> +		 *            <----->      .
> +		 * |----------------|------|
> +		 * |    middle      | next |
> +		 * |----------------|------|
> +		 *                  ^
> +		 *                  |
> +		 *                  next->vm_start
> +		 */
