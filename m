Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DBD450909
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834147; cv=none; b=duM03RnC/ZEzoZDcKqvk02JU0+Rb8eXS6u+1ycPBu4IN12XfOehuII71k53SpWACOLu5MhCtYmdc1VlONzH/R146rgjrc+iUhG+Ms0ORC6Snw6bRBbIkltBDsh7J/DJdOiTgL3j4zkG3l9IRgov6GML84S2zOtVW1k8Tjsr80oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834147; c=relaxed/simple;
	bh=G7yBa9qRXwqvk5O66eyJS/F0IvVRBRnFUCu+8taoCIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt1SfAc2ZJ1AENM6V3/V9GPENrcXpRkOEWn3xErWyd+xD/UpjCKiYBkqiklZ8lsIXAkwd9uT6aUCS5FOSgVF/Vl5diPw0fIlULw1/5M8km6cO6D5gDWWpjfHZU0cBWfMBwKxmVCItn2h9QLE/pWsKh403aRimZDz1reJ6WNQ8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OdjAdTKP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OdjAdTKP"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92b21f65b60so75225485a.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782834144; x=1783438944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
        b=OdjAdTKP1VGO8zRZIYKW6T7YC7dp4kGd+TLOLZBrfsmVd50jWCMuSIKvP7n5Q3aytm
         7y2yKNcengqSId/fVcnWUhs+mgEBA+QOUb0OSHXmmarHNnEsbrpU4OURxH2VUa53JCkM
         POrRA+mpxapavmM5StO0HJvd2wH6vvbHdouA1wzC4B3542vH341QzuvAy02pjh/UL0V+
         MisLKxDdvdCl3YVgpFGit4upC4z+10tmJoELCaRYpHzDYuL2HyfH2mJ0diC2zJDIF8XW
         E+p9wtX3S3Axbso4ew8IgNmOl7eHU7jpcJ4DsFh/HdFdxEaBAEhnWmwfQwIcg1w2xssn
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834144; x=1783438944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QB3LlP562wM9vhAInyZtqjaYedctMNHlJgLHcqpXNiE=;
        b=EZasEpfBhmsyR0fxvfcG0iHx4st93NZWl9C0eYJg9qQ3F7+yb9Sf5UqyZJ1RAjoRtf
         wnXTKaHUzgEGyWnDUmlF41g1YB/vYcPaHXIgHRj/p33TBk/qOpyvKPSWj3WhxmI3DnRT
         km/WkQAeC/0LUtN3JgLRsIDgdcRCtLW+Qm4vFBXbuGrhqsLLOsTFKbObkj1vAxgi5O0k
         1tN/ZNBZ86fR6jFEHKrmGSS/6C26DYQCsgFEAan3hpr1cxV2hGji+OTCdz+vEttCFvhe
         9AGuEn/vY6M/28zPKTJVpvsR22oK85XbNPJ0+4vKrW8pnh1oN4ZHDXZkR19zukAf5nVm
         XaFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DPzirQW+2OjO14y4PxLSJOnqlNGm9A06v8cfCdgR4RgR85W1Ek48iBtkC29VVCMMkqqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq/ntm4F4/b0MkeVXqyMLJqpzQp/E/aXD2mMW255QSywXzV+3
	9qZ+fASsDudcgpSbhbJ/clRVkyxSvxn4xYFjtjmlaSLWs1L5JhXvdET/4Lla2CINdTg=
X-Gm-Gg: AfdE7cmcT7tc4p/OdQazcEGUSzNsZtVgGdjkNtNqiN/atRkQlEK5hFVy1XP+ssThXch
	IMP/E4yi4FqSvI7FBhNw7Y2hQ18uhvj3pjJ+A7wjHgW1W0hZvEiCMU8FE+kdtwOCvwFOIDHjtpl
	GJgWLCRAbwbd6+J4G1NFaTohOgL4fSSmaxdbifjor6+YamB1O1SLZIIXgrQHbOO/T1rdDcwR7Ae
	ax2OU0yoGTAKn4yZVWT2bb7NowSRuM+HDHNeVH+hxoazENPT7gXYq1K4infXL29Eit0fIAHEF4F
	vdPkvr7w5pURslxCey5bnvHoOZXcY+B2OrN5rnot20hJUyCacmeNoMhjRH7oYI4e841yshOQYCn
	K3cEBbMEGnXSZCL+REWLettjo8WwA9JXllqWhvXu8Z64NA8OeuU+hYrIQ2/gMJBNXiIxchuvUXc
	ek7eb/OTIw5QUIjXXT1uTkOAXtarlvsvQg65Bd8ie1v6R+QbYunsbo4wa4KQpLka1AMcF9
X-Received: by 2002:a05:620a:271d:b0:91e:712d:f79d with SMTP id af79cd13be357-92e6984d3d1mr270456885a.40.1782834143842;
        Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6234dc50sm263249085a.39.2026.06.30.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:42:23 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:42:18 -0400
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
Subject: Re: [PATCH 08/30] mm/rmap: rename vma_interval_tree_*() to
 mapping_interval_tree_*()
Message-ID: <akPj2snngOp5nOYq@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95462457025370efd047b9dfb039e76bbddf58b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:19PM +0100, Lorenzo Stoakes wrote:
> The family of vma_interval_tree_() functions manipulate the
> address_space (which, of course, is generally referred to as 'mapping')
> reverse mapping, but are named the 'VMA' interval tree.
> 
> VMAs may be mapped by an anon_vma, an address_space, or both. Therefore
> calling the mapping interval tree a 'VMA' interval tree is rather
> confusing.
> 
> This is also inconsistent with the anon_vma_interval_tree_*() functions
> which explicitly reference the rmap object to which they pertain.
> 
> Rename the vma_interval_tree_*() functions to mapping_interval_tree_*() to
> correct this.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

obligatory "naming is hard", this patch helps, thank you.

Reviewed-by: Gregory Price <gourry@gourry.net>
