Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D3380FCD
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712329; cv=none; b=W3wafSsdM5Z7LzlTbYN2trTMrsY+WnEngOdFVgWD/z2JQcAWZjNko1jYnEVIO91reNGrDFasyr7fx4iBGfQcujhcRhDQj1yhprNn0AK/yjiRKjTa7L/VkMcuM2jZQ3ubH5IJyEgvwbr8FudmDP5gY/XeRLDL+r4yrlWJZTK7hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712329; c=relaxed/simple;
	bh=93/k6XquwkESRTY8Qvhh+3gNAdxoxyU3Cel9zV++PQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmjSUcV5PUCkMmGlDZI6fBkX1avCwbsD1lwAcOYkkJI/mSX7FWH88SC+mfVz7DhDjVftxsX/T2LATj2WJADS3+v8Vay+Gzsh3vE1CHAlUAOmSAPsTdbYEXXydBzD+XkypJYLhbp8Qj58b//U03XaXS69N2OUbP5oN0XWitbzgTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=al6+H7t/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="al6+H7t/"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8efcef23d21so10478196d6.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783712326; x=1784317126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
        b=al6+H7t/CFEDBMibUEjHT8p3L+i06ZY4PpzYTOaT3H9bmkq7jfHUo3l3PnBaKTidw/
         41fRtV6c73J9a6EkTdDqcnOfEQorPxnzGS6/9Y1+OFWPQmkfiiFWskhjbk63ZmZ3KBjU
         awR3OazwaD2FGph0VjOMptZBbgJmJ/NdJO8j3UEICVdx0ecAKcSbw8AKV8ez4kCwg/9I
         em2ziGKWGdmKma0Hj2zA1W3dulz6Dhh897KVlLWCe9NDLfqgWJVDgLDK2QLxPVk3N9dY
         UC+qzerd8Z7PEVFHnn9/eHTXU2Xf/U0yPJeaHZGLsSkEktOdZfibqKLagpFacohoUMx8
         LmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712326; x=1784317126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68XwZpqFqsaLFsxYJLdxs3+k1PzHke/kGWmUPy80R6g=;
        b=AzC5jRSX361Y+iEGL5WkOqlVFZ1JJbcqEWcEZzOu7Dk56xYeySmvz3/mq1QR8er7YJ
         XWjdX8M5KjrFvPFsS5y7J9iY3NVSGaHUhf3RuQe/EozyPROBouiSB7WZSVbtSvf8iNj2
         VSyjHY6j7XhAOF9g3t+FccUDaX51Hx028n8R3PwB/a7+eysW6jsC3tNhCDhx57TiAOD2
         9aq9uJQk8f2phyyueRaFaabaz9RXYSTWBJe7zvGWcMYZlU5VWAM1oJgFWlkv5XO1w2JD
         mKV4rrtwFeA2KpApSdMeicOSRM4SzBYr4Ik7USF9bozDAg2QSgeDUQSxQuBYnsaEpHfK
         7GVA==
X-Forwarded-Encrypted: i=1; AHgh+RrziONrFsdofqG5AVKMESzzjUIJdnbjUrWSU3y14z5HbPMhxBnKfsBvC9w1ybKtb1hKgf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/KVUETVV9lrgT6fAisQOEQ+YV1CNPcsPJm9h6Rv38ZHamzNA
	STJvFYV3DLVZI+6H3v9Ha+zUWtPJuZeSgsCXKGBzJ5ctKKpRcJi4oKiHkpK14NUusBs=
X-Gm-Gg: AfdE7clR+yUICzyvBWdpOGceqjuZg7uGmK22zHi6k3X+VXhvhM/RCnMSavhrkg71r0g
	0vaG5TyPmIU64tiqQQleoTLgNjhm2uW/29+5CU5wgs9GiYMH0vKNsqI64ZNlac0fRUGbJMFq1WT
	LkWFZbCnQkTo9PTb0ymOZKuNoYE2gASgWn/cIyoxDcnJ795LWenvOTWcPsMhBMu0utchYYZuTTq
	RB4V4/S/q3d0YluaetWLyxStYlQULkkqp+D1DXykommJbGLiX0WhJQi6J0PIxQ9alIQEDVSxhIR
	8rSWLgLetamregoUlWJgDe+2IMn/QEiLNiuV48VaVfnaJSqV5aN6W4k4Wpa2ABUgL9sziKLK41y
	lm0ASquZtPJyL3Lhg+x+wwC+dh6D2k4+S4pHtJvDwfAB4HM5tQEsL+XENIDdZvp63us156Jqvca
	AGukXPijJMiumEF5HNDQdB9jm+VGMq22kCzuBCngnVv9VQ5vWRXnE65hYLfbXa7oTB6Qau
X-Received: by 2002:a05:6214:4b08:b0:8dd:fde8:68c7 with SMTP id 6a1803df08f44-90402c685c0mr4983166d6.30.1783712326120;
        Fri, 10 Jul 2026 12:38:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm48486486d6.46.2026.07.10.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:38:45 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:38:40 -0400
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
Subject: Re: [PATCH 28/30] mm/vma: use guard clauses in
 can_vma_merge_[before, after]()
Message-ID: <alFKQOJrgiJl0p_t@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213918ef85ed427d29d0635db6b07b15280d3bb0.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:39PM +0100, Lorenzo Stoakes wrote:
> Rather than combining a bunch of conditionals in a single expression,
> simplify by inverting the mergeability requirements into guard clauses.
> 
> that is - instead of checking what must be true for the conditions to be
> met, instead check the inverse of the requirements and return false if any
> are true, defaulting to true.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

