Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D636680C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610458; cv=none; b=NzZB2S4rSMu/hCDK2G2Db4EYzVhHqLvcuBB6x8vxWRFceJIOaDFndsVpIXHkHKrL0oIOpfysaQ5RZJ5mkhKeGniTSLx1EvWXsIlJCEkIJqcPurqYcBGAIFp+8erwCIs6cqBJCOP0vWdh4YlzYB7oh3Kq4fMSnYmuDCWKC4y14q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610458; c=relaxed/simple;
	bh=bI1J+cBiMa2SCkpHmKrJG+azHdWZ7mPEOFo5aU/4c1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD+P7pz4MGkY2lTNUeH+TzyeiSAMAr0fIpq/dOn/Hy0pMc0OQAHrD5iQRepC6UmOwT4/c/NsTITUMvKNsoDPx8PdgiMgPWGOkddn6qbZzHCbcsS1SIakfOKrp683uKzTH4r7f7STfabvob1kpSGvZqM/I2jZzLhCdRa2RuuG7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DJ05EcXM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DJ05EcXM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e602d2c0fso64036985a.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610456; x=1784215256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=DJ05EcXMolyTSAVa+V4kq5SYypx6naDqSrLl6NMYOtWr8ygCDfSOr714dkKgFBLZKS
         psD/6ooU1FF2IwAfjIa0gupD+ATYl1sovtJrP4h4mo3JPMb9+dUGqfooF4/OVBTUrN9l
         WvsIpOTAAr+dzCuc50j51i0NF2tjP8CuF+4rtYUbpM1+8eJ2alHaLs/t1Wqtj7KuNg5J
         Imiuvx1EYh8ZFA5EANPYX7PO0qD9iU8OlM4CC7pCYJm3Hv6nGZxdHKvvNvWuGvuUT86i
         tIvvpTfSCeKeKWyP88voeqIift+g8rHnoK6YozW+Jv49sv3qWPN4eAOKrNpRhnDPP82c
         W+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610456; x=1784215256;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=IwVSixx1Nsp0HSh7GBd+LMm8/rHSPAgHxD6Rz9bKOnSiLkFW4/Pe6jOa6JMHBZwnFu
         MJLHz/b8kC4PH2SK+ta8E/HhQ6vkZN5fyzNtGCArD2yr023PbcmVxOSHKfndAkonS2oR
         ubcIVtlyE0JlKp277utRTwBr5aL+QXKeVZ8MnhU1JFgEWaAK9eEsblB495CUTxzXeCiY
         GDv/crbj93fAcssxYKBc4OKcuHof4FyqM6EadIOz9bt8VqIXZuzhhiuxk7NXiDXc1bx2
         ej0pyA/90S74Kab5QXekQgUwScKEkI9GRZTvS+fBWr2QgDe7lWKVnkx4o7VFNqU8bXJD
         C58g==
X-Forwarded-Encrypted: i=1; AHgh+RpyuA0SUuFb8/yc3azLOb7/QLy0LkFwy02o56r9HbpE9Y5s/IWqopFWaVn9/OA4JSaEu4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+3KPLYc27WzkR+a3j58zZdDC0kgyvvwKAMIopudVRxTPh0nw
	NY4b8gn4J6KwTn+dwFiAPnYdeF0TGmNFQRP0ewN0pVrYep16O7uLoejXGUkJ4dh5yUY=
X-Gm-Gg: AfdE7cn/Q+gr8yZUtaq2y37aMHPEtN5gWlLsEVB3JEjbmZuBz6SIEqWbjYmlcFeRmCC
	8j4NkUEU0BGk2i0gL1vQt5hxnW2CJyenrdg+Xdriqjuxlxz1z9kLk+BlB1Wu4MZyqT5KjOKnUGD
	AADta5kPk0/34C66Rie4UorhZ+OQdZARt0Mu23KJHkFalAsUN20tsQQSwaF+o3IHH5Je9u7ThkX
	ypLuur3QeP0x/Y97TDUk7fkgqIgGeCcPr6ihpQm8rFx/3ahIvuaI12+CAto1qFlbM+0Zb4mOj/w
	45TpQmZZ3Gjuj0RvO5H+unORNQmC+QuVJ6VXZR0/yOGFTKBOv7BSo59l0bvHxeMMet+iXeKTAQu
	XTWd44rkQl/hW9pYY2dxMTxW17qpPo10ZnpweAysbbzVxCuxv6riGnaCBJXDHrleKV1rrgl+5rq
	GDlmhMmIS6QjXBZFcFf1faeIA1e97hbb1RucfFINY8TT/X76Px3sFx6Tn8oAQieftaB6iR
X-Received: by 2002:a05:620a:179e:b0:92a:f74f:904 with SMTP id af79cd13be357-92edab23ef2mr337298385a.1.1783610451142;
        Thu, 09 Jul 2026 08:20:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca90a5sm1652288685a.32.2026.07.09.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:20:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:20:44 -0400
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
Subject: Re: [PATCH 14/30] mm/vma: minor cleanup of expand_[upwards,
 downwards]()
Message-ID: <ak-8TKDC1GBOeMOM@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:25PM +0100, Lorenzo Stoakes wrote:
> Adjust the stack expansion functions expand_upwards() and
> expand_downwards() such that they are expressed in terms of named constant
> values, and make use of vma_start_pgoff().
> 
> This clearly documents that we are referencing the page offset of the start
> of the VMA.
> 
> Additionally this cleans up the overflow check in expand_upwards().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

