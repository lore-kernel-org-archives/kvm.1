Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014137CD4D
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300745; cv=none; b=GA1SSLn35zqO7YAydEHCTGw6dcd7jScvrTykmk17d2MMGojeweHlInzoIfcsd8RPpD1ypl+dzbNJbPP1r2enWNqK3ogGWnmtUgM+D+4oxuhlUzIEVdRgQ4UC4m0KcPwR4s4KF7LtxB+UMJLQLKpWP5E5D0CXXoEXpKNTQh1nwwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300745; c=relaxed/simple;
	bh=jMwzb9z7/mVdGpQ2lPkfQnGAecA2/7Ga2XFMan5JKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNTosoKoExIZMl5OAu6swBPpDXRVAkUf3uN8RXY18v4m6vKHf+RlKD5AHUNp1xAeDNm724Vb0Es+KsqSLi4vF0dOgNPJXFeVJrjhCeEal9N09N5hMD/qeDx51YKmTYYDHZ+/1hN/snVG0bjcPYUrirQwOvGy/mn3rBXXFoBpj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZvzxs0I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZvzxs0I"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aeab6ff148so10825ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774300743; x=1774905543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUGqI0aW7JYeGUdYKG2R2+j1GF5S/yFvaIQs/WVfzFI=;
        b=CZvzxs0IcB1ehTC87jd5EmbxAuUeKbH88aDnALrgsWL21tXD3sHKQ4r55aQt16KRmf
         5tucGvVJobb+8pMYf0sxbocMYr0cu2Q5D/XJz6Xk/K6s+kEQ4Evy0yJS2EBJ7V2ZkTlM
         ZkhykpiaitQGxCO1rL3QjCyHjiJa/VR9b6H2Q1iLeYAYOm4SpxW2FxW391l8/lwXLsdc
         6YmIS/aK96LfMLiRXEeh8NFtONypK/aRh7ncvLApL2RWGjb+XtJrJtdGsy3M8bMQS/p/
         rL8rta6Qxl7CnBs2Dh1fu61jQPZTUY0BfuLoxYKLlOrP/Np9ZSMMdhHp54Yu0m5UGTfc
         iGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774300743; x=1774905543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUGqI0aW7JYeGUdYKG2R2+j1GF5S/yFvaIQs/WVfzFI=;
        b=XTjGdvQ7Xs6t6NEKF8nywarVlQ/XHcQE2Jr3RiNvkNW/e3mrzPA1GC2LXUjLG4Drjg
         y2ITohvBBS/rVgSG3N9vOMivNffvEWltNoww2uR6Ib+Zvb+utcyiK70ESkGlDVdMK4er
         /JQT8rznNahKVyirf8d6zn5nQkK7FvhVF91HHA8TpVAqh+ibdNcCfYnuxN790Y7O3eJ8
         HhEo0p/wQIyg+ofSyFjwIve3mZL1EBwvPOHbkVFe6TC0Iym0iS7J8G36fLvbfvxOZhqT
         JbgK8+FYnM5khMZj1DUB0cfJcTpMLHyzLGxP1fT2iXqxNCEcdDL5ljRn0hlU09i4PDE6
         g88A==
X-Forwarded-Encrypted: i=1; AJvYcCVS/Tw4P64n7qCBXZW/CWf0qCq7rnXB3JiL0B9kRi4BIcew7r7NwEwIoFyFY0KlyeUdot4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYn4eYeaV+PC9H4Idmhy3P7XQ2vIQFIGAYazXbQc4HimK5iik
	GcVwZ5vBV+UPbFdbEBDlCGB2tcfHA6TLKpWZtLfgXwfDVcxXGrwO6IboF8dvjkLdSA==
X-Gm-Gg: ATEYQzyn/kc9nPu7JcdUnDZegWqPYrl467BfRQtqg1ThJhI0LuRA41KDYrIxYLtF/pS
	63BAdNYBoujy35GfMpw/ie41dtW81B2Z+qiancqbHDUfAl8n0a55lEAVb7hcPcjlC2beNEPyZXu
	6NIH5T9IMl8wduRp1cydYZh/vCCUGk2OKe/ULbmBtSz87LK+VQAl6lSFPa7naYt/v9An4oSxPxz
	becskPv7jJbIdiTvmkgngmfOuUVux2Trx30bf/alLY1BnXPUKTHVcIbbCMODgUSh3WGC/5pBfgS
	exLKmEQWGVs53/YieWl0/ZUhCcERCMY8geNMjJGe1TmnPBKg6QpVdWrLvvOp5aDwLSyV7V0tcEf
	zzHSHOT3HPmSiQ/hfbSSq3RDTeWqkLyH64QkjyVYMcqH7arrnjej1Gp2uhHOEcBEYIfrwKzeuvS
	O7W7ocNGDPEKfDyRk/Us02f/oKbd0xLxTTro29ptdMz3Hct43ZZu423w0S3WM=
X-Received: by 2002:a17:902:e5c8:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2b0a6735efemr308765ad.17.1774300742225;
        Mon, 23 Mar 2026 14:19:02 -0700 (PDT)
Received: from google.com (249.53.168.34.bc.googleusercontent.com. [34.168.53.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2ddsm7910891a12.24.2026.03.23.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:19:01 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:18:57 +0000
From: Lisa Wang <wyihan@google.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rientjes@google.com,
	seanjc@google.com, ackerleytng@google.com, vannapurve@google.com,
	michael.roth@amd.com, tabba@google.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v2 1/7] mm: memory_failure: Clarify the MF_DELAYED
 definition
Message-ID: <acGuQcWRuJMO0EJY@google.com>
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
 <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-1-92c596402a7a@google.com>
 <CACw3F50mVpnS7TQy_pD-KV=_Ekepjq00zZzdGxwLnF_vYT_M0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACw3F50mVpnS7TQy_pD-KV=_Ekepjq00zZzdGxwLnF_vYT_M0g@mail.gmail.com>

On Sun, Mar 22, 2026 at 02:34:59PM -0700, Jiaqi Yan wrote:
> >   [...snip...]
> >   * MF_DELAYED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> 
> nit: would it be worth correcting PG_hwpoisoned to PG_hwpoison'ed? as
> there is really no "PG_hwpoisoned" page flag.

I will change PG_hwpoisoned'ed to PG_hwpoison'ed in the next version.

> > - * The page is unmapped, and is removed from the LRU or file mapping.
> > - * An attempt to access the page again will trigger page fault and the
> > - * PF handler will kill the process.
> > + * It means the page was partially isolated (e.g. removed from file mapping
> 
> nit: what about "unmapped"?

Thanks to point this out.
I will change to "It means the page was unmapped and partially isolated
(e.g. ..." in the next version.

> > + * or the LRU) but full cleanup is deferred (e.g. the metadata for the
> > + * memory, as in struct page/folio, is still referenced). Any further
> > + * access to the page will result in the process being killed.
> >   *
> >   * MF_RECOVERED - The m-f() handler marks the page as PG_hwpoisoned'ed.
> >   * The page has been completely isolated, that is, unmapped, taken out of
> >
> > --
> > 2.53.0.959.g497ff81fa9-goog
> >
> 
> Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
