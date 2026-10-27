Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109199;
	b=vsk8TxyW1H0HUs3xuG6PeCE8ZvHFLE7d5+g9No0FlNl1LCtQjPDGo+LPXtx8oDfYVh8g
	 QZi8LqQPRBcUnsneix4fS7pQlYR9M+cfofj3m1ScETEr327AuHEHcoPj9RcLpxlWt4M4N
	 z9KIbtTeQ06afaCl+w6k4KdVWrNKyoPof7xP7ncdT6enaeh1zZkpPDPClGqULh2Rd+VdN
	 FmZhxgqn20kpgAciZJKN6ouhBx8iWDg368aWNit0i4vOcPoGn/lY55FqZ7FEQl7/WvrE/
	 9oCCu1ZDhY+eWe1+D2jBKYBuRMlcJsxrgupkuOUg8NllvrDfTU+hkjHIlBzNm03R6lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109199;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wGwT1JNbkqmcP8fUAnZimf+aufAiCIdNGNB+5b8MPdA=;
	b=XgdOOaGH/SIdWrjNMRJMt7eF/rX0u6hnDvR456TGh9DHIMLHVRHAd8zWraQQttcJjI2f
	 BwTXR2xKj5g9uCmm5lw4KAMud7BoQS3mbEkH8zzYtBMY1XbLJ2fPL32MkNod289k+IKaA
	 JXAP5g63VigOWWSKmwzvVK3VlqyJhJGfbGjDh2aTHMEEst6hZg8FkO6TZ+3NQpHpSIG1o
	 ZsVBd15ABpVSg4Pm52ZG3uQ1pFjJWca85oG1Pr5xZHk1gUVZPdEVYoYZ+VGx852F2vgpp
	 bwEQKCJ+tc8AMEF3UWFL2ZYFsFsByoiatX30D9FUF3fQG5Fv953t0/4oRtqXRSNaE6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k48ijW9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFA606A324
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k48ijW9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131131F031E1;
	Tue, 27 Oct 2026 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109199;
	bh=wGwT1JNbkqmcP8fUAnZimf+aufAiCIdNGNB+5b8MPdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k48ijW9RVicq2q2FursGgvWjpH6sIVKScmpHGgvHyK9MPT9Oz7ye0qHgpm5pLzc6U
	 3iTvUygezJH68Hzr3JgtaYEYnJlg8RiMWsJPFGToeN6lfFpk4V4f4U94iDf1nFo1Wb
	 6JgsGYPAYwIZgfrP7iStQxk6v77xu6ImDiFeyJ8LCgsRsZONrdgUxqtjhVxV8xObWz
	 Oj98LVB9PG78itudjQK+N2F4DeMLumcd2p1aEQlEmoUHduC5dziRjfD6nCoVrVU3MG
	 v3ZWMz6ypCNycZZb1x8sGVKPEj921sL/CKHmVowmFIquzSVITN3U4MNuufH+kLoszO
	 r79QNsVex59Lg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 85CC7198004A;
	Tue, 27 Oct 2026 09:53:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 09:53:15 -0400
X-ME-Sender: <xms:xqzgal-vr3ZeqbXQYJBliutUwh-BPoCNU76xbXs7mx_Ps-IdSmK23A>
    <xme:xqzgaoksYXGkYGnJF43sYID0Tus98V08BBjG64swDvpdheaZW5VbBJyVOc7DQ6Frl
    aoZ3R23YOrTA4h2thSa7n_eENBiVLh_oK4jdwW4aOnapsUIANjaAKZd>
X-ME-Received: <xmr:xqzgajaYJVYfdqtgodH29574WA_vexf-pM5sNeV3dSMQBjrPqxVqpVsiMiw>
X-ME-Proxy-Cause: dmFkZTEZ/rZ8QL4tKdVH13M4isFoJoqE6mmyk1+ybcvlxgqSp6W0ayLRKd0L7SfTmxuGb5
    U6+Pfm114T++Wp3SC2FV78EqIZ6zQGqKV5XyNS0Q8g8zeea3kGWywXyvNgIRW79CajYQHr
    2jF/D3zyUpa8mENlQ2k9kDlrLHG9vuqIwsGPeExjecTgPLyR3BG4mU+4iFcKzGjlB8O7dl
    rHahXQtAt7H4ct4Hi0ph4caUm45qDhARWvo+NXS6RvFk5in2esxS1VkNF3/wtGoX2gxkDU
    HYhd+ifyLHB/lQg4TvDcO1vty+4TgdFGCdUfD6xIrm+RnS//HTrIeeMZCfQmeBD5mTfrrt
    28F2SJuazbG4sdilPjnUK5Xk2C/b77Urnpd+yJpFkxf0srCyBWlhL6vR0USCQldwnnbiLW
    9q+grn+3rpVTZTV5aFHrdKvOYqBL1I68cy6Ts9EvEo2mG6eqSnlWVGArQuLZTDmYpXGIvS
    wXLvRFTOpi4viZ4HzYk4qCerKNTdy3232MaWMRw4+fGiHl1k0822eLObmoSxbGhZG/SB+U
    RY6eT6x1Fr7R33DiHsTIEPGR6+Uf+O9CEjZE+sUhhEJff/MTsubZ9LmOVI85mrAWUqqbJx
    XWv9aGmJ+yJbAfbRPaNRNIocYryGvdsYvD8pPJi4F3KUYMPNesYsAvQV4dWg
X-ME-Proxy: <xmx:xqzgaudbz8X2mj1TmcVhbSB5pj192_SKV8vP7t-J3qUs-AsDGR5erQ>
    <xmx:x6zgar5lbie9c9vsEIGyR4WR5HHpSCBz3DCSwhV-Wl76bl2cm_9stA>
    <xmx:x6zgaqkT5H7khckA_fD9bSj4bobce4cCO515thNp8GAx2LHLg5LD3g>
    <xmx:x6zgapYUC1r3US7DHJV2QXJyRoI41UHODbj8ZuE46i0U3Qjz7C1IHw>
    <xmx:x6zgagOltv2MpGmQj-wyDgIG_3JLhCWmQzbtOVj1MoCubVlHQLT8Bbj6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 09:53:10 -0400 (EDT)
Date: Tue, 27 Oct 2026 13:53:09 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	kvm@vger.kernel.org, =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <auCsphluu2gwzEPo@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>

On Wed, Oct 21, 2026 at 10:36:00PM +0200, Konstantin Khorenko wrote:
> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
> PTE mappings to the folio instead of one PMD mapping. Each unmap of the
> PMD removes one PMD mapping:
> 
> - the folio's mapcount never returns to zero, and removing the folio
>   from the page cache reports "Bad page cache", or hits a VM_BUG_ON
>   with CONFIG_DEBUG_VM;
> - the first unmap already counts as the last one and drops the
>   PMD-mapped statistics while the other mm still maps the folio;
> - the second one drives the entire mapcount below zero and drops them
>   again.
> 
> The helper has no caller yet, the next patch adds the first one. Pass
> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
> 
> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
