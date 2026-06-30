Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FD3A4510
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833463; cv=none; b=WsIII36MdFLMhFLlwqA8s4F56BLsI4rTr4OrMuQdfjQZFELLIzAEIz9iJ6qQ3CQ9VDDHvtq5l4/RHQz94+A+7ebSURdAPdKjluO93GpEhLAkniidCmMZch4Ohu9rswq5j+WALA6XBYJNEGRALkA+ynDqFDMN9Na7zXpALiGe150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833463; c=relaxed/simple;
	bh=dsxaVzZxmHO2gtIU2TvsbwgiexrCHtWtBKWF+qAkz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7D2xgMjasnbOZEV3PmliH3XKheJGXpUez1uh+YBtktqDlA0AydF1a1E7jOW8H7N+c/QtaF8GF8Bw5TJIBg/ATAUhua9QZOPPanb7v78CL4wabmHaR7LVn6vIjyk3rH4Djq/Cvn7bqUbV+YyDomuTvJFwPCTgXcBMoOjTfgMwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cukaVGMX; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cukaVGMX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664b2c00e12so3932325d50.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782833460; x=1783438260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=cukaVGMX7mBuccoBz6GSmp85lsZYZI0h/Lhjywx3ox40ZYV/6RAo0oHqTlK0ScWRQI
         iRua8ON3MpvWirCOvcvRavW6eYJKrTMuMUuuTtm/KNFSwPYlolq7xaAbfwPkeHT6ysDh
         9rHQE52G7RqtRlr9vm9GVcaENG8Urk7Eavnhn4akh1ulxmwJUgarDJr/Td8E2Cqxx99N
         9Vm9fpdCMfDOPW3IkR0aOSSLJtch2aNnXZOza9aj/vPnhh+AVRovebJPw12MvhFZYooH
         EOVuTi1jZEL7JXIJqIBXPFE7qbyK8qUoXOC1ROgCJGs0sOms/9ufN/ZoDMKcc9ZFj8Ml
         Q8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833460; x=1783438260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=acRsNsZeJbQRU+Nm4RX788UPmFE7d2axORuKZ5Zjh44KFodItGihi3WFi9CDa92+wV
         0qdbaZ/2vMquPijTxQO0zfpzsZ9JsRELdDMSgpUCDsMWRu6vd+/CkCEbPsFMYFYFEZEr
         chUbwCBY71BvU13L1rNownB3ha/ucFrDyTYcdOY0/9E0pC2Riaw7QgyWpIVvT5VpJfqk
         tNqJyCQ37d4JeUbIMVatYaoQpXrFIQKyhtWXGlvmzFqilHyooAVjCPKYhiqsj00gRfEc
         WQ6UVHhR9BHRDoSyxLVcBwTfK+kiSNl9aSMrX2KzQ+QIu6ETq7XSA97724AWmXnLMdQG
         ezQg==
X-Forwarded-Encrypted: i=1; AHgh+RoBGyd0bZDCPp4yeSCRrf77YaCM1zk9Lm/PtdJo3qAQXLE/+n7GarGJoTly0euVOHWRMKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTLPi+VsW/oxWMR/BTupsHjYCquPk3bxTgNUt4mHEs3gsJvZn
	whZkSAGj1Iw4HHtJ/XZmwi9Fm0x5eV83fl+ziOveLQVymQ4FsPIt/UgLkxNbEqsUFXk=
X-Gm-Gg: AfdE7ckLeO/YpfzVLyQUPi6hkrSLDXQg+9HxKm9Nggp7enBVt9ofu82A/Fw6SznU442
	I7GS/Zb+M0ffxEe2BOqxXVIqn9pfFbkUFQn1TRUuO2bDJc6d9lTtIFhS+EICcVNOdfrqXNWoN3K
	qDcmf9UCJIw7Gu9eCX1b2Bs0xgHa49jEAHNZvSxJDFhQI/inWCY+12DtpkNNr5wUoY2nslW2PhK
	hsXMWCrb4j+Wg+0k+niDjtfJdvxZWjT8jO3GmIPESlYS5ShsYhM070hsXkHmGLuNVKOG9PoxGNC
	MnLJtQXF0mv8Vs1kM2MrwK5scbOgPC5I0e2zWwQTTM5mlGBPvoAvGd6tPm4uBJKuOy4JzZXJDrp
	8g7io++ecLZWOz3YcajkMSDwN0MJ8wXOi+h1YCHPLsQI2eV+OyuIAjmqJLzoPXUIy+x0F1cMTom
	i/6WoCLqqEac4/l1DHtMnLE1HgeMR+z38ZJbgGKljOOs/acUFrGD3pSc115Oxk/F0sJc36
X-Received: by 2002:a05:690c:6112:b0:80e:bd63:1780 with SMTP id 00721157ae682-810d7eb0bd6mr46000317b3.2.1782833460437;
        Tue, 30 Jun 2026 08:31:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a783d9d7sm25574106d6.41.2026.06.30.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:30:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:30:54 -0400
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
Subject: Re: [PATCH 07/30] mm/rmap: elide unnecessary static inline's in
 interval_tree.c
Message-ID: <akPhLlv66ZqQ-jrw@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:18PM +0100, Lorenzo Stoakes wrote:
> It's not necessary to declare these functions static inline as they are
> contained within a single compilation unit.
> 
> This makes the anonymous interval tree code consistent with the newly
> updated file-backed interval tree code.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

