Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082EE426EDB
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612250; cv=none; b=BkcGlMfRODrsAwOXpzRy32ykToXImjaS9uptcM8PpdgJMGUFHzC9PmyrqWLgaL31s7q9AJb0GQ5djxUzTTeHKTzzEiAQXmy0D4vHYei8vlyP2t1yWRzhmj7VhZXaz9YCmSFGSMIvcU/4+XKYxB24YyEMRpXdsC9aRjQZRkpLnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612250; c=relaxed/simple;
	bh=ooFqL0kdzm3Mqvprf/ktKH8mQbzOh+NePJH/rGI4MOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCdTxCQrqE06XlgfUqTCtxYshT8eK6wVLBthG7ePiz0sStG3AyxCxwyDRMyFFyM/cNGjwZZVURKombZOznCx9ItxcezP42VHoQWrbcW7eVBii7Ir8z4Z0H+D//TGYTFiHZ+vnibgAwqZdzjOX826OC4f5B5yF+Qa7U+3RtifZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ICpnBr24; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ICpnBr24"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2a449c57so12541691cf.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612247; x=1784217047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=ICpnBr246mLQLo6J/c6CeHFuXpKGWS+yv4AMt5rkdjgStwdTQfBJeXld2RX9OS3KxS
         T1XZ0CZwHP2uMMpYQIu2MKkeDygOdG4vvodfYMESBetFa3AfxSeYFwNvlLie36mOY3Pe
         R0zqfTMG7doZsH7uhykqwy8Nm9me5EkINJlDDHbizdvgrmWeujiQ50g8XcevN63m9l//
         5mkwF44uINVA+qtg/OwITJbeeF57OE3ZcrBkL7593XeWfd2UC2z64c+0gHv4j6EjbdwG
         /lRYBkU5BmTRVIw6iDSpw0UC5XgIySiXza1IeRpgrqXZdoRKJ7ISY10E+5yfZZzerBSO
         5HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612247; x=1784217047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H58DRU6wxIzBQ0PfS3OOFxFy6X9tDniNwjExlFI+ak=;
        b=FAcDsn19XeoFuKfWYrASAtRbExNpPV4hvSY0XoL8ks+KxN+uZdCnmxx30NVzZO1Mls
         89dXBbKoZ/hkDCtsxbTDAOtPkDgvSys/xWLhEelz0h+CZxetWRmiTshdDC/HCb132Ttd
         000BMubujfQlutHx3q22UiiALAOP0QX88lIpycHpeHDKJ6pjxLsSkAenMf2cvyQZWOIj
         P9/nfH3zBGdro1SQ6UzYEJgA2VpuOob/Y6DX9jSFkO2vPswq4lY3rCxJO2Xa35o/669/
         xKqjJnHLeRUpTtqEzk+ww/SxI2YNx2LLfEUO+GH6jVpT9NtxkLtOcfVqi9mtr+btKnOr
         7Jbw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6D6m4my6BmyCGOS5w7r+9gJr2E+sZoOIjSXJaDXR8IT5e/oXjxZaGJTIfWrT/ZpoAsYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KtzYWR/yVGi7j0iX7K6r5R1WNFYvoUj+QmxMIvXJDDQOydI7
	s9v2PJPTHLzjEAfpjWn+cy6u7yngxARQAv8tlerFa6atQkD6JnsibIdFwMzAz77tYU8=
X-Gm-Gg: AfdE7clybG0qCEel1NHE1td1iumXWEYvIZWBJM5aXG1bwF5TkWSbqRKUyTswhG6OJIu
	z1K/yLuV3qMzdriJc3iKlughkthsEHyzodbdLhuh0673sAv8ktD61u7AxmatGIDNGUM6mZZKQ3/
	daa9qA3cvdMKxUo3ZVxN0ppAFr5eFzlo2UXylVQzrdMYhwXem4hKIF7MFyffhIgPINXGSb6Rdd5
	X0G2VSLT3ORB7s+jBTCdwhsm0M8YRcEbqviWo8AEHfcAq6/acaXkTlzmnsuL77r2zAanVDEzFlG
	iyt+ar/bA2gvJe6WnPjslCcER0+ocQCs/tmovXDlQkg5LRs/EF1TaydUwWMhHJ4pRZwBMrYor6Z
	oF85eKYBeTea/9BUIp/U54+kWNtGPBN6jZNoulLqmTiZXfAn7jJSXV5G39pw5SUiWV8ktNNzIMY
	cWCUyPfAgezPQO/llsrWXg8tcMmWm02SqhII7cxdPHsLI1tisKH7Gcpq3zfaqCMMr3C/7Y
X-Received: by 2002:ac8:5f0a:0:b0:51a:8c9c:7f52 with SMTP id d75a77b69052e-51c8b40a675mr79940341cf.69.1783612246884;
        Thu, 09 Jul 2026 08:50:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm161049781cf.30.2026.07.09.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:50:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:50:40 -0400
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
Subject: Re: [PATCH 18/30] mm/vma: remove duplicative vma_pgoff_offset()
 helper
Message-ID: <ak_DUDt-1tb-V3b2@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10671c2fc5d0dd4e3bf497181923e63e46053df1.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:29PM +0100, Lorenzo Stoakes wrote:
> This is doing what linear_page_index() does, so eliminate it and replace it
> with linear_page_index().
> 
> Update the VMA userland tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

