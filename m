Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782F2F25F5
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027678; cv=none; b=PrWazi8s+9gUerlWLgpr7qK5MW8VnafH0CauHiRQW33fd2SCoDzUVshrAgQLTrc2ypfpKeKuhs5qF8PlLK37HMwVGeYJUa8ZQV8JiQoYxeybnKj315sJrVZrGpZkSa3fQHf2ckF0WCsFSAKkt711yWJXTBNUypqxgY5AO+Pqr8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027678; c=relaxed/simple;
	bh=xpynVdkJqiYJ+YS6WpuWIDad//fYe2omc9hLEd1O/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAxEk7fyMz7VzbPdP7s1AZUBPH789QMOCvfb4TpgzzqGCe2Q+b2Dpi0PR4Om3Ab7CbxMS4OxqRTC16TYbqbf9WSOqecXMI6MVD7k1KbsJJp8rE9gK2uyoW6gW6OiP14dmkLhgQ8Oppk8fk81P/wIPQSvJmgccvGxVlNm4D8iWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+9bI14C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+9bI14C"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so6205ad.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774027676; x=1774632476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yw+tOHpuRMnE49DkXSD+aFdEF1ZrcnPKNWU22AYNXGQ=;
        b=C+9bI14Cp7Qw6frVUJfcZjpynkR8jRuBB+NVq1tCpT7tk8LYcvvrVxHJ4RRWHAiIgi
         kDda5TmJKZ6m9HVRKkGk1d9QcqidWXZyKo5IsV5r+UHA7KgktzcRr2P/zx4VmUK/o+v+
         ZHm7lILPHt5aUsGVbIwSINtnpHMVlsq0AnT4RmFpjaTou1obwST2alZ6OpcXDaWTnzro
         H2aTA+icrBVvICHou7Z0DPr6Gj1VhYi1h8Gnp61rxwPuyBI1MRufQ32MxyCeTB7a8o7f
         SFj4N5BwugDkiqS8dFw7/LyJp+td/jUCf1ScAPy0UrExNsFjDzA20QF6+jEsfk0MqGrz
         eVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027676; x=1774632476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw+tOHpuRMnE49DkXSD+aFdEF1ZrcnPKNWU22AYNXGQ=;
        b=Yeo7p9yJEb7sxBrSGoLOFWpwSzwRFpdVxKI6+TJK7CbKYs5A/urMJHHPRRAJdh6sJV
         RLyuhh41g0BxtecHy/dX862VRAUhS5LIwRyjLJPKpZHSutdvUARVtzCrjvrFfLvvKbB6
         7kRs87wllzURPnCBRLzL/Ggv0qIYaTvPQd+yKBGVy3boDt0m2qbbq4UdevlvUTsuzJ1+
         99YUmEGhhZapsp8TuQ++LR9AgwHdz1NiLUFZkgm/WE2uwRTn2g/K004mkDZCN3+CjFwo
         dSjmy4Z1ziYx/gJXlpB3ruxV/9speNi0Rh2Ul8OY4c0o7yst8yYecmC9xnGdLCbxo3mM
         LmHA==
X-Forwarded-Encrypted: i=1; AJvYcCWzT7+VY/MBeMtaOgkz20WbmMTbodpXjMkmP8wsFtnB7JCgyStSTiWxjj+PT44cdCQ5iho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPBirrCFx0fo5q8H3mb2C/jZe18CjrhPUAuR9c4Dw5dKnG5B5
	cQPWxcBeJKkv2Oe75IH22d8t2zOYFe7JMw8JQRag1fB88EFwREhbL6I4aiwDte4AQw==
X-Gm-Gg: ATEYQzwwGmNBi0yE5jBULMnQq4ZxsHNtflA3BbWoV1MgfC1f8Oyt69Q/3enGjhoNY/i
	oyabZJb0s1bxHCf/3MTMr9WmFjPmkm5WsGGgug0dhhv4Fpf9pGL3xiEOX7jE8pAKHXmZepAmLys
	31sarM/srYuo4p+lfzSULDGFzHYyxVyaZPJ7G0c0RGn780l9sY625tshI04cDrZGSsBOoDa3EDE
	kcuVB6wgFfL8dMdJlS19NT1G3iTJlDS0QDPTTV6H26Rd5obheYznjavIgX276Ny6XzQy+DeOipV
	zLmYzOazq9KN2xRlMvMH/f+9+B8cLb0/8HbMr21RsRllQJmigrw/8X3ncBkLq4JQBwJ9374Wn7V
	yNQnGYY1W++LnmUlBb5gAuJn2pWPaMvrTm2rMp9X3oRpi5wlgZq1ZvZCAFL4p0UaWGQq03CoZRa
	Zom4TNOAchSDGk3XzhrcA6QcLCY0dpyv5p8nY33XglmwzogW4Ks1dNs07yXw==
X-Received: by 2002:a17:903:2c50:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2b08b4431b9mr68395ad.12.1774027674984;
        Fri, 20 Mar 2026 10:27:54 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bb76sm28635425ad.34.2026.03.20.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 10:27:54 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:27:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, David Woodhouse <dwmw2@infradead.org>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2Dkn605sRbpK5S@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>

On Tue, Mar 03, 2026 at 06:41:26PM +0000, Samiullah Khawaja wrote:
> On Tue, Mar 03, 2026 at 04:42:02PM +0000, Ankit Soni wrote:
> > On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> > > IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> > > the proper preservation and restoration of ioptdesc add helper
> > > functions.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
> > >  drivers/iommu/iommu-pages.h | 30 +++++++++++++++
> > >  2 files changed, 104 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
> > > index 3bab175d8557..588a8f19b196 100644
> > > --- a/drivers/iommu/iommu-pages.c
> > > +++ b/drivers/iommu/iommu-pages.c
> > > @@ -6,6 +6,7 @@
> > >  #include "iommu-pages.h"
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/gfp.h>
> > > +#include <linux/kexec_handover.h>
> > >  #include <linux/mm.h>
> > > 
> > >  #define IOPTDESC_MATCH(pg_elm, elm)                    \
> > > @@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
> > >  }
> > >  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
> > > 
> > > +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
> > > +void iommu_unpreserve_page(void *virt)
> > > +{
> > > +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
> > > +
> > > +int iommu_preserve_page(void *virt)
> > > +{
> > > +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_preserve_page);
> > > +
> > > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> > > +{
> > > +	struct ioptdesc *iopt;
> > > +
> > > +	if (!count)
> > > +		return;
> > > +
> > > +	/* If less than zero then unpreserve all pages. */
> > > +	if (count < 0)
> > > +		count = 0;
> > > +
> > > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> > > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> > > +		if (count > 0 && --count ==  0)
> > > +			break;
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> > > +
> > > +void iommu_restore_page(u64 phys)
> > > +{
> > > +	struct ioptdesc *iopt;
> > > +	struct folio *folio;
> > > +	unsigned long pgcnt;
> > > +	unsigned int order;
> > > +
> > > +	folio = kho_restore_folio(phys);
> > > +	BUG_ON(!folio);
> > > +
> > > +	iopt = folio_ioptdesc(folio);
> > 
> > iopt->incoherent = false; should be here?
> > 
> 
> Yes this should be set here. I will update this.

I'm wondering if we are silently losing state here. What if the 
preserved page was actually incoherent in the previous kernel?
I understand we likely need to initialize it to false here because we
don't have a dev pointer for DMA sync operations at this low level (though
x86 uses clflush).

But when is it set back to "incoherent" again? I don't see that 
happening during the driver re-attach phase?

Should we at least mention that this API intentionally overwrites the
preserved coherency state and that these pages must explicitly be marked
incoherent again later by the driver based on its preserved HW state OR
by the IOMMUFD re-attach?

> > > +
> > > +	order = folio_order(folio);
> > > +	pgcnt = 1UL << order;
> > > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> > > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_restore_page);

[------ snip >8 -------]

Thanks,
Praan
