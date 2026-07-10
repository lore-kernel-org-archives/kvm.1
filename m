Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0793B3C10
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718052; cv=none; b=QldAW42ME/5yUrpS4CiGRGsIKKOs3g5GhYFvzF14uoRyN3ipdCyDRo4lZy2k6klF95SOFJqM0J9dJCLYIu6fRQkMej6oGAtGxJKaE6Bq9AmjGPOBMWSod9UxUtJ4JKvFRmFcRDFEFDsE+EGFvVObE2c6vKIaUPDv3q6jHW8x3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718052; c=relaxed/simple;
	bh=K/lBj6p3knKpn1KqMVCf0Kk2GjXtTJbSA446pc7gvzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0/R8pJI9/+dZA+XgDBf0zbZhASsNwUmwVKuLyadUuMdorA6515CStDpfflIWzksZVfPn7sSm/vQnCQmHWBpv6rTqz38axbrVD7F/hiRzMONa98vFEZIrmjGzJfpts3hXt8GuHgREJh2/PohNODEiGaiAxg1adDWkfTCes8mHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bfIW/6WN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bfIW/6WN"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e855da580so110739085a.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718049; x=1784322849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=bfIW/6WN4DfK4HmG3EwNlYAiEHTPSmfAPM2seUXbEKJRrAhqbtqQC+bGvJRGsgGDsJ
         KsJhZF5oBdEk1wa1MnmQY89PLgNUEI2m2vqVI1zw65BwOubiYdgnsNW9de6u7OHSnXoc
         uswcZK+JlO+QXFjPXzsXkppZYO/EZ49C3td5CWj2GNlm2AcI1ICvrsjMwZ7VGfc2fStj
         tJICWPLm0/zgbmVGO3mS2PK/W4yYCBnfYTb8wjwn8ySKcXc89ktEAiz1rk++mJ6ZIumu
         DjeCGHbb21rWZMPX9M68zrHbxy9uTfpNhK6zpyArnPu/aDVei9uwB8hdjuoKXDgufhxW
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718049; x=1784322849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpMGBsh9fToTErr7i3jlVPE4gbDMnqxhA+rLBjZ5wi0=;
        b=Gvd/40xm+tke4ODPn5XwDAtrEiblLxTQ/bqcm3cmUIh1ch8zgG0z3AZq0/9ZzMtwVp
         PjTRUNAH85SjZNQuWw40QjxiG4WZXLF6auSGzpLtWMbdcMS5xloKtAjlVZdgnUsayjzT
         px0dG6ivTynVqKwEtBx47c3WuV0bit4ucyyyNdHUI0jMyyyEwvs3ya5h0v2HmYzq65Si
         JaiXQlO4CIhWUq6AKvrm1rbYYSpp7xhpOojJ6xbOskbFjD2czZAq1ULsida2RgsYGdRW
         pfElrnpkhcFWozKAoq0Oslz1vi6G8Y5HhngZpRsQ/p776nd1m9EvibgXA0tl8gZOLy/v
         fPjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rog97ZckYgBHk+o6ld2uOqtRce5/fPauTY/5RPTEHqalXsNt00jVLvPCFtkNHaBlvm/pN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgIS/YWnstP6FsyGQBY3DFArp2dJSYM3eBRv+NKHlOXU4xWE6
	gR708ZL5bVa/PI5dY3zvkPJuK/g+eNHneje8exb8TEbBlCeJxIdOiAaTZgr916QqavI=
X-Gm-Gg: AfdE7ckyvmjMyIRCLZc3YUJBQHQpzoAsGzamrw6dyC/V/eVi++b00KoWGRoGvaCugmC
	3e2/txRzOnNs/FmKIhf1q/KRjOT+WirX3QPaJb/vs6HKmnSw1H6Bsgqq1cC/+n9H6paSYy6sqiC
	7tYi6mTE3j5U9J6pGPcQd2mOneHqGNAUJSN6vOrCoejDa7+fDBOqsbRWs3fM+i29OtC5a1ilqUE
	hp1eMDO++iSntujre+Y6H7fy0POXvB4rhhdpY5DD2+1xsujdNYB3ns4gTAHEH//2Woah9DL9rh9
	YfpsLyJuYMwF2YLN9RV6sxOTS0P4dSe9Ms7d25U6xDDWKKEq2EnXJULk9kSmQd7vYvowyLZGL7O
	XG7ze4FYVlNRavDCVoGU6enJUqf7T0u6thcNUX9nvCvyBWDuNIOWE3uh3re5RxMAKNSPTYG5rxq
	M07zQcpipF2oOFKHO2NnGnpQPruaoIlVNqfgzhpoa8AtA591eKdhRRRuO9BSd28PeHNpmp
X-Received: by 2002:a05:620a:458a:b0:92e:c117:9ea2 with SMTP id af79cd13be357-92ef2e264b0mr94774285a.80.1783718049159;
        Fri, 10 Jul 2026 14:14:09 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e3083sm50604746d6.6.2026.07.10.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:14:08 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:14:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 10/33] mm/rmap: rename anon_vma_interval_tree_*()
 params and use pgoff_t
Message-ID: <alFgm58E4G7hWIm_@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-10-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:51PM +0100, Lorenzo Stoakes wrote:
> Rename parameters used by anon_vma_interval_tree_*() functions: 'node' to
> 'avc', 'start/first' to 'pgoff_start', and 'last' to 'pgoff_last' to make
> clear what is being passed.
> 
> Also, express page offsets in terms of pgoff_t to be consistent.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

