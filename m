Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622662;
	b=3zJRquv2zHht3psSSNplCiYHTyvW8a7Rd3Sah9QQTAhHKTuXt2g8Vr2060CNaavMTyxv
	 hoWfzBIiyRnpz6TsjvindvHiAQv6wB7M9UNw9oudt4R7xKEHCFjLKMB9K9GdU5tKdA3h+
	 z/Sqa0T2oRiifJPLXcyDZ5QRdFqoDKRM8pUj1vS0UThXoeqV8IoX3x6KtsIBd/8PFSvKe
	 wsNWI+ZrxmeQ8fofsR5tlcwVfwMQu7Wi9I3CCoOLn3bS+LAdJZuqD3ZCWiK5OsAHHX022
	 UCjbyYCik8Bo8VxCNM2PsenZeW9NlViducSU2Hj5Xz5AXy16e1D2Pjf4wQmIzbFKeQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622662;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
	b=C+ZUjvkfitl0l8KE9GI6Tr7eJfPlx5oIyfkZUoa6M4YaEpMKrQUjIJOGm/DFmjwg61TX
	 oWPDfH5TK9dmAXX4pQxwFiFCAI9J6xUbZ/g0JDDb/mw+jOnvgd/AJNC3m/z7BV115rBz/
	 sGNyGPuDmLkPNSyiZo195pDbwaH+wn8vaSvAPH1WO83MGECvBQZ/MANWy9+/YsWKcoVU7
	 4gdd10ucYKB5D8Lx8hFB8sS1YX9jSq4fleslJqa4NJE5544wqtsh3Nj1tFScsmSHOakQN
	 TO7fLw754wVwMboeA1sCbwvkcYvWG2WrNCzLXyacYCrd8SBxmbRJGGViwHBhQb4sDMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="C1/bICTA";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tHkkBVgk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B40606A32D
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6B40606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C1/bICTA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tHkkBVgk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793622660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
	b=C1/bICTAYpte2qvtWrJIsZou86NsUUJTzVjvLX/W2MWXllXtuVGKTZT32JwLmiYoT41BGj
	EUsuNpufXTLC4W0+yMp4BFJiKgW2ab7JnjZkggAWtwWGl3XiiGWPlFfUOo8mFb5HWXPNO6
	cUBidB5EREvYw2u1+wM45PiCa2OuJJo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-XwHC3HrdNomNzfar1ep5wg-1; Mon, 02 Nov 2026 07:30:59 -0500
X-MC-Unique: XwHC3HrdNomNzfar1ep5wg-1
X-Mimecast-MFC-AGG-ID: XwHC3HrdNomNzfar1ep5wg_1793622658
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b3f840cb9cso3396786a12.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 04:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793622658; x=1794227458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
        b=tHkkBVgk1kPNtiXn6WtX4rqK92JR8Am41RtJwPI73VtvC7mnnuRVxLfwCQUf3OZpay
         x15CdqrBs2D3qSsh1vGvVrSyV/6yRlwjQFvcamZkEDq9wASOIu51WaKedwTQBYSk/2+e
         29fAX8QYV1sazvSiS6z0VdKDIX87i4BbpBmiS0pY33BLjo8vFltmNdXJcFowZy1ArBHS
         gVhq156qpSsPR+dY43sfzqKxkXoMeTSy1qQ56sS3qRHSkKTm/eJC5Ux5fvDOrgzVyObR
         RsbQvxaLVgVJP/iOqC4Kzlc7G8sYbxZAP2ByldzDKcodYt9xJWbRVTl9HM7HiEsbQZ7e
         cjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622658; x=1794227458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=atoeJGeqv0Z1R919+9aEtspWeeQpp92iU9wLTusAw7c=;
        b=x/k9JhGIHBmEtwdFqpYQ/l6Kgd4l2fZ9XkFRMHEOpGOkEqEUT2LbLL/vOdGyTZ5qx/
         evWvHyubqU1nhWi3ERtoHNndQGulmnHTxgwDmK6UYxwq6PzwSXX1kvvfCE/+lYkSCFZg
         wo0elgmCNDFJyrjY0GZKcENu1pYdXBzskE326ud1AQEizcktCIm2gUML5+A4leQOw5y6
         rwJq74BQFwrnbtGZxGHkr7LTZFLTtyHDuhvznYmjVKpUpe3Qo9ChMrASPgDV1X584nve
         tIVHgFw4eMYy6+c+Eh2zkM7S1jTIi0YJ3QMLcWwg5DVkfNdZvZr3lxvjF8T7inJxrGh3
         QIWg==
X-Forwarded-Encrypted: i=1; AKwUvBwNR2JBV6WkpvUJjzgfc2J8jhA0zRvHn740hIwxmLrm2ScONihwiK4YXN81vC+3riUQ7vM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/K2+mVOzb+LZF2nZoA5X95/OgT6dH6744mEGt2DBr0bp9J4zTJ
	Q03JtfnayJWh/7btno86Evkc0nTNdtdezad86nzzJA3/RL69qexiuWyQMklub0eN7xNqtS6u4zY
	AOj+Nc011ChYIPtXPANVHzilt7gyXNPIwvSdZcnERzxu9qkv39jH/UQ==
X-Gm-Gg: AYBFou0cqMlXqBBVUyEsClbHI4RZguYagzVS3RCxmsqgj4Jz9/NrzkzGXebk1q0g+As
	NVirEkHxRHH0rZ3SEf54B59Ub/+UVob0B3DBG7t1uR+96Pi0n1ONpQboOC+UPycrvF1Gb1Akp5y
	DjnKLmTFSjS7MY0vB11N9OgeHEI6Gt7HyhsfHJpGojNp+tSA63DUZbaKPr0vDA3NTytsRmd6DTP
	ZWg6VWHe7ieMJdk4IDzcuNiFBkYmUpdHSkA+CcYgj/NGIb3dIh9vhiiD3TJEhM9eghddX84PViV
	rDO9fpF2xnUg1ZGf2I7+xrB4XzUcFp6pHDTf1v0ZxvGJ6bLIkG8eAs8abE0ALUxUSYofaNFOTo/
	BpH7nvTQTBHX37g8G/mgRoCNWEg7Eghei8jZ+Q2t38Q==
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id 4fb4d7f45d1cf-6b4d438bdb7mr5044952a12.9.1793622658338;
        Mon, 02 Nov 2026 04:30:58 -0800 (PST)
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id 4fb4d7f45d1cf-6b4d438bdb7mr5044928a12.9.1793622657746;
        Mon, 02 Nov 2026 04:30:57 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b51adb58e0sm1095546a12.12.2026.11.02.04.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:30:57 -0800 (PST)
Date: Mon, 2 Nov 2026 07:30:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karthikeyan KS <karthiproffesional@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH RESEND] vhost-scsi: use FOLL_PIN for DMA page pinning
Message-ID: <20261102073033-mutt-send-email-mst@kernel.org>
References: <20261020182640.2048506-1-karthiproffesional@gmail.com>
 <sashiko-outbox-180555@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-180555@kernel.org>

On Wed, Oct 21, 2026 at 06:27:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] vhost-scsi: page pin leak in vhost_scsi_map_to_sgl() error path


Karthikeyan were you going to address this review?

> --
> 
> commit 1042924e4de0195bca9a4409c2fafbb0c7c58e45
> Author: Karthikeyan KS <karthiproffesional@gmail.com>
> 
> vhost-scsi: use FOLL_PIN for DMA page pinning
> 
> This commit switches vhost-scsi from iov_iter_get_pages2() (FOLL_GET) to
> iov_iter_extract_pages() (FOLL_PIN) when mapping guest I/O buffers into
> scatterlists, and updates the teardown and error paths to unpin the pages
> with unpin_user_page().
> 
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 885fac5ed042e..8162d83bdfcc9 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> 
> [ ... ]
> 
> > @@ -842,9 +851,9 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  	size_t offset;
> >  	unsigned int n, npages = 0;
> >  
> > -	bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
> > -				VHOST_SCSI_PREALLOC_UPAGES, &offset);
> > -	/* No pages were pinned */
> > +	bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
> > +				VHOST_SCSI_PREALLOC_UPAGES, 0, &offset);
> > +	/* No pages were extracted */
> >  	if (bytes <= 0)
> >  		return bytes < 0 ? bytes : -EFAULT;
> >  
> > @@ -867,7 +876,7 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
> >  			WARN_ONCE(true,
> >  				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
> > -			goto revert_iter_get_pages;
> > +			goto revert_iter_extract_pages;
> >  		}
> >  
> >  		sg_set_page(sg, pages[npages++], n, offset);
> > @@ -879,14 +888,17 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
> >  	*sgl = sg;
> >  	return npages;
> >  
> > -revert_iter_get_pages:
> > -	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
> > +revert_iter_extract_pages:
> > +	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg,
> > +			is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin);
> >  
> >  	iov_iter_revert(iter, bytes);
> >  	while (bytes) {
> >  		n = min_t(unsigned int, PAGE_SIZE, bytes);
> >  
> > -		put_page(pages[npages++]);
> > +		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
> > +			unpin_user_page(pages[npages]);
> > +		npages++;
> >  		bytes -= n;
> >  	}
> >  
> 
> [Severity: High]
> Can the cleanup loop at revert_iter_extract_pages in vhost_scsi_map_to_sgl()
> leak a FOLL_PIN page pin on the last page in pages[] when the misaligned-IO
> check triggers on the first iteration with a non-zero offset?
> 
> In vhost_scsi_map_to_sgl(), iov_iter_extract_pages() extracts and pins
> DIV_ROUND_UP(offset + bytes, PAGE_SIZE) pages into pages[], where pages[0]
> only covers min_t(unsigned int, PAGE_SIZE - offset, bytes) bytes starting at
> offset:
> 
> 	while (bytes) {
> 		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
> 		...
> 		if (!is_prot &&
> 		    (offset & (SECTOR_SIZE - 1) || n & (SECTOR_SIZE - 1)) &&
> 		    cmd->tvc_sgl_count > BIO_MAX_VECS) {
> 			WARN_ONCE(true,
> 				  "vhost-scsi detected misaligned IO. Performance may be degraded.");
> 			goto revert_iter_extract_pages;
> 		}
> 
> 		sg_set_page(sg, pages[npages++], n, offset);
> 		sg = sg_next(sg);
> 		bytes -= n;
> 		offset = 0;
> 	}
> 
> If this check fails on the first page (npages == 0) when offset > 0, it jumps
> to revert_iter_extract_pages before bytes is reduced by PAGE_SIZE - offset
> and before offset is reset to 0.
> 
> At revert_iter_extract_pages, the loop steps by PAGE_SIZE instead of
> PAGE_SIZE - offset:
> 
> 	while (bytes) {
> 		n = min_t(unsigned int, PAGE_SIZE, bytes);
> 
> 		if (is_prot ? cmd->tvc_prot_need_unpin : cmd->tvc_need_unpin)
> 			unpin_user_page(pages[npages]);
> 		npages++;
> 		bytes -= n;
> 	}
> 
> When offset + bytes crosses an extra page boundary (for example, offset = 3840
> and bytes = 512, which pins 2 pages across the boundary while bytes <=
> PAGE_SIZE), the loop only runs DIV_ROUND_UP(bytes, PAGE_SIZE) iterations
> instead of DIV_ROUND_UP(offset + bytes, PAGE_SIZE) iterations, leaving the
> last page in pages[] pinned.
> 
> Should the cleanup loop account for offset on the first iteration (using
> min_t(unsigned int, PAGE_SIZE - offset, bytes) and then setting offset = 0),
> matching the main loop?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261020182640.2048506-1-karthiproffesional@gmail.com?part=1

