Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB35372B4B
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998920; cv=none; b=E9So4yBNYj15/sW7vsmYXAH8KiQpDLfAAPnAm4tA618+oJRfN2rDewvvsHUQlkNY89dQ8qMYKvl2l/Z9R1O8ELQxdsOulzP6PcoIDqoLHFA69TRGXnW4KqkT9PhohirlEN7zpBsp9bsvBRA7A/tlJ8Wf0vlWPetWfyqUJOmWORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998920; c=relaxed/simple;
	bh=DpDCTJXegbg2cBFxSiSI814EG9RKRIOvAWoZV93niFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBCpPOEV7fxLZZKJ8xAoSsqk7GqOTdeN8pAU/vK8awJWHyCHAFBhqg86RPSNH36OG/DQUR+Iqrl6dvLFxHw93DwkNXK1FL2KSkO6EiuiUed+GZq1WCS38tdLb07Hwwat21rOC0pSr5oD14LPWVKlhHzHabLXFCySPxBins1Bd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stKCl6rt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stKCl6rt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so73045ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773998918; x=1774603718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfFJWDO2bwhUd92Uo4pePPcCXizTvYm07yIGqhjNLlw=;
        b=stKCl6rtLlvskQXpExVM++DwkyN1PvWuVL+1kxBaAtGR5yJYxUTaAYUbYQJWgRRGVa
         IskKI+w7AP3bNzrTHp+k0sYX8Uou+/XoW/mB/tL+tjA4MPVJJ7ItexeeBWekFqvNWS8p
         QGv+t6OwWzLkkwPelu7RHnCGdrG1LCJpEHTr2kHHttOtwkbTm0GlFv9z1t/bBwNapp+Z
         yCveOvSFCHHJ83/+NtMtl9F2MgFJM81uKn8iREx7200iTFzXfYFxAw/VaLDwDtLE8l+k
         xg6c0Yx0U5Q4E9OFRcFZasrGkccowkJ949FCFVTA7AYB6TfOY9e/JZpjxrYZs4XEaOMM
         YWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998918; x=1774603718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfFJWDO2bwhUd92Uo4pePPcCXizTvYm07yIGqhjNLlw=;
        b=cTAvGsYQi+HibXZsVlWAXOe8oOiaDBFFz27AjErZKzbQ4/vlIMiNZIEcc/9nRNbbH8
         ri5vuw4TfUn+XMZzfQMLwCT/ZoDfUgyLARQJL8jhhke4uqVVo+sZ80zbhL3uPL7z70v3
         gO6zrVYjDtjd1ybmTSdza3zkNX9hk7TL4LjP8+3v0PGOr2cL3C44LvD4pLbNo09J3kTX
         +j/rHtt0KwLFeLcUDJ3R7m6QNCpKR8XUae4WbtWHc3fY8JeMQ6RIx0ibDUtCqtqwBlz5
         kyskOgSmIFo7UqSFh5D4AuB4uQLI8G5MiJaWuHrPfc26uXUyxO6ufoxl9TL2SOdVzHWo
         W+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+igOhLhkWZYjzOM0FF3m/qLTqOU4Tdv5SXYo3xJ0okvW1sCEf21obt3xju8HACg/9qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXUeoTgBrZy75Ijn0RH/gI6yJPktH1B0mcFhtKbSpEBeGoYtF
	dBJeW56UaaKrXiaVUOpbyVguzIK5NwHVnFYcxN9V8flGJAJvvbNOUtA1FXpbT+qhrg==
X-Gm-Gg: ATEYQzw8lLJs/XOVxBYzL0uQUOc6v7bk9jEc+euPvj8TWozfMIaZK82jdii7lXpog23
	MgPb33iYz6+XlM9G5Qoq+Wo3ntLblnc8T0WEaHSDmENWjPa2zRW3iny9MMB/GH1mKi2I7f97iMm
	umZDfGFqNb7gnjZOKYg0obxUMUWI/7QOZ5xld1qjzpY7XLzdbYyxkl+ifkNJXGiXpH9Xmc3UafV
	MBF0XApI0XfRC88oCeOgyjn/5ww8ed1fQwjeMiiPYojNPIjQLantiqx9NSKmIdQ+CsT4mv4etb0
	cW5CTCWMKaxGBs9CpVw0UPR/Zbfe7O7RQOYxA/Q88Erjhe1+ydsM6VmeIovM9Ca3I8pWh9CUKeb
	htLPXEXpOTPVIB8aKydSE8SnM0F1py+Fkwlisen/8kSpFcu89Be3NbnYvAJ4YLTpt3QESw5Uf6R
	+k8p3ETGQGBRa1d8+HX4l2fcKSxCpylD7Gtr/3pAJU95YWKajDvTYFFbzlng==
X-Received: by 2002:a17:902:e750:b0:2ae:44db:570c with SMTP id d9443c01a7336-2b0828a93e1mr2454385ad.12.1773998917324;
        Fri, 20 Mar 2026 02:28:37 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c0f1sm1652552b3a.38.2026.03.20.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:28:36 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:28:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab0TPFo2esHZ6RIb@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317202925.GA2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> > +
> > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> > +{
> > +	struct ioptdesc *iopt;
> > +
> > +	if (!count)
> > +		return;
> > +
> > +	/* If less than zero then unpreserve all pages. */
> > +	if (count < 0)
> > +		count = 0;
> > +
> > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> > +		if (count > 0 && --count ==  0)
> > +			break;
> > +	}
> > +}
> 
> I see you are trying to have common function for error handling in
> iommu_preserve_pages() down and unpreserving in the next patch with
> overloaded meaning of count. 
> 
>  < 0 means unpreserve all of the pages
>  = 0 means do nothing
>  > 0 unpreserve these many pages.
> 
> It seems non-intuitive to me and code also end up having multiple ifs. I
> will recommend to just have this function go through all of the pages
> without passing count argument. In iommu_preserve_pages() function down,
> handle the error case with a "goto err" statement. If this is the way
> things happen in iommu codebase feel free to ignore this suggestion.
> 

+1 to this. The current version of overloaded count is counter-intuitive
as it expects a back-handed API contract. Since we're using lists here,
I'd recommend using the list_for_each_entry_continue_reverse() helper:

+void iommu_unpreserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
+
+int iommu_preserve_pages(struct iommu_pages_list *list)
+{
+	struct ioptdesc *iopt;
+	int ret;
+
+	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
+		ret = kho_preserve_folio(ioptdesc_folio(iopt));
+		if (ret)
+			goto err_rollback;
+	}
+	return 0;
+
+err_rollback:
+	/* Rollback only the successfully preserved pages */
+	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
+		kho_unpreserve_folio(ioptdesc_folio(iopt));
+	return ret;
+}

[ ---- snip >8---- ]

Thanks,
Praan
