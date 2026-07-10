Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9273B52E2
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718276; cv=none; b=QdGm0r6FBooFd7RFBpdm7OPANcsfwdvdfGkZivXcHh2u9JK0OAlntFmoCXMDtnqwv2hNpt53ufs+508QpW0L6JfKlW3roQooilX1tUmzBewHAL/F+mwWvvNUCvtUtk23PNkK2ZWcOJl31b8w7ojzQrrp1Pa53Mn9EEdXpJPT358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718276; c=relaxed/simple;
	bh=SIhLOUaxsH6uNqg5w5fr4DNuZv6zf1h5UML6naETP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwt4qT2Ek8RHHgsfs+c2L+rEObT5W3Qhwzgt7DWLZJJwuj480SyRDlLmQshh9+azWDj0f/Crux7tENETh54OcxLewF97Q/orlZVyyruQGw8REAUF5JZPLLpK4NbgYlE2XMBsRfAl+1tnKe2GRWseGkQDfXgyaKLN0xt7z8lNXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CvN7OG/F; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CvN7OG/F"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e57a753f9so109510985a.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718273; x=1784323073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=CvN7OG/FV2U8owqDLkbFEu+JlFbw/jALBKLEqg00J9vBKiOJUwOO5Ox3CRbB6cjfje
         X4+aFu9El3LP9J3RZYm+1QSfPZ4g6pgmkAADgA3EDw8if/ltT86NG/j8JgMNPEapVWgy
         wSI0adUBkeZkA/pKwkllA+vz3PZ5UcvrJJ6VepRHvHpnXSrp9bRktgH4lVCItKHzV2CX
         WMjyrUyLBcuMQNcQN1gura1zBKey/qRJ5XunEXS+7ByArzrbUtMpXucxyLXWVHaWrnUw
         yvD530b4It7Z5igK2KJSTuxrpCne+mLWa6R5U7fjZP5kNWq8ptfMcMf20GocA1+26rFn
         IfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718273; x=1784323073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=cqoiQr0WX4WIM2SE/b/DYj9t/iDg5AQEr3+sVZVROOiBEXli5up2KaDq1kCoOaVAW5
         /E1T25sVBTiOleQ9bPCjfTxNWaVF2f8FNT5Zjv1qNGHHZLNs5EEvxFQsQWRWU1mRM//v
         FMvHNvQSzGgNb5jJb9NTnX1dJrDW4IS908wA8MCyOroJ8bkUYiNn4qtctjK2yEU6ypUH
         Gmx7ugHrBYCLTQbjiv4cYXXx+f9QO5C9lCfTKVbcNkSNs24oK4QuVAsU8WOsh2iMSFyV
         j0qGzGtAs9brphIICzw/QwwRAymv2zf4A00orpqg/QaEhiSVt8ccWgSEavchl4WZXY0x
         7mUw==
X-Forwarded-Encrypted: i=1; AHgh+RpvAowu56ArKpiomLD2cwZgTL+lg10L8H8YB2LZsVNQFSvkX8IvBMqzrhUij+6UATFILXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF0eH+mPmEdyN4LUoNt+Dro6YUP+mvJzG2jTLCrgc89ds/MaI
	hD+dwOB7uXpTmwmaRZ2cRHZd9lhgzxTdmIVOnKX7jv//Uml9MhBhweNHdyfAwWP6MIU=
X-Gm-Gg: AfdE7clFrgFFbySUc8L1zzh/47G2fYhKoW4v6EDC+pnzBobx6SZIKDlBLh5ulR68qAk
	57WZhKgGp4p7aehZdGYqcu/akWUCHQgHWbk4x0i410WOjjlArzo8MeslPKBoOYbVDiHvGzw8Ih6
	gPFWvAoEe/jovaOHXjD6r0WQxIt44hLvJtnvuRURj4YN4dit1C1r7064VGTRHO7Y+tT++Rf4+Ny
	2uoxtU/koODQBiuJ+n++6HA9GKU8FuZDZ7jwVOF6ul6jM4A22tkOcd9PgsG4Ce8EG9mmrETivyT
	k8SmVIZ7S5cWxx6sV1/NLTreh3YZS96ReYYviMXPCU/Go/dfWeh+wceC/ksVkrw2VvMw4zona+P
	fwwJHy6G08r3QCDSnGyJHW6R7MAcR6b/e2LWDvx85WtMzyQ1xev6EhIrol3mOjRJn78G3W99bGQ
	mB74AzurlJzbbx2LrV9CheWjGqjOwDoVc1SubjUMJfjtbmz1bUtR0gW/uBKeMRfswLEVTndxePQ
	kfJUe8=
X-Received: by 2002:a05:620a:40d3:b0:92e:7afc:93ed with SMTP id af79cd13be357-92ef2d03c09mr108964985a.71.1783718273295;
        Fri, 10 Jul 2026 14:17:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm292932185a.2.2026.07.10.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:17:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:17:45 -0400
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
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 23/33] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFheaAGWCIAjom-@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:04PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carrying over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
