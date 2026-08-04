Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F4468C3A;
	Tue,  4 Aug 2026 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851561; cv=none; b=hkVhbqL75nSqZZIAsgZPvGMZgwUHqhMGnM6GMbfkTW0vLCoF+hFANpJue0U623zZ4GePg70dhPak5rHapi6Phdo9NkSqRx58NQXMhvAVLTzUxnW3AjXbuGs8WweNYQt2JprxydnDiI/2rQEleUbeKgsxP32PdVq4ixRM8rfkBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851561; c=relaxed/simple;
	bh=WhUHmkc5J/HW9hplYts59m5dTBKS3K9vOiPWjeJO3Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRRh88MIuZWaMaoiiLIlyJvA9E425GezI0cFHL3CY7jEvjUlE3WDSz63i+Dwu0R3RKgWNjv1Tet3kcRUZroLHbFjHfqtVcOpUUGLzfb5nDfHRkzIW1qVB2AO2euixZ0P0OvWxnbn2QR8Ezx+afgevlQdAxc/15TwCXQoHNudDUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vgQvIYe3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vgQvIYe3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rBsBBxPlLeU2cDGjgyAGoHsbhtXXZRHRORcMTmjXjSA=; b=vgQvIYe3z6Ore65tumSqUuDxnz
	+U2H2hNH741oZbMvXYXrdJ6nFxBGS819Sba8ixGYZ86bHaYeBNqS4mIi2e5L91icAEHzArply0lSY
	1T5oHAy6EAKI1mILNM8gzTqrQipozzu0rmefbXRhGoJDOM2Nema5H0nlKoIl2iMK/2OItsRncvVxV
	lnCxuOu3MPBwaN2ygOvsedbuqS8hdzrFEEJWC3cdacqaLbyfIWDmeronLBKRY52QSscdA/f1T9vMt
	j4YgnerEAW7p5odqowDxwudELDdO4SFZbieE3qA0tsssf7hxotc3OB29J6MFhKLYB5KO4IrKTe47C
	9hAM9kGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrFZM-00000001yYA-1Tuc;
	Tue, 04 Aug 2026 13:52:36 +0000
Date: Tue, 4 Aug 2026 06:52:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michal Hocko <mhocko@suse.com>, Sergio Lopez <slp@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH RFT 1/3] mm: export variants of vmf_insert_pfn* for use
 with pfn_mkwrite()
Message-ID: <anHupGFkfWkE-cg_@infradead.org>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <20260731164341.1109827-2-pbonzini@redhat.com>
 <bf97ed0d-571f-4c61-b761-5b45d435c4c2@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf97ed0d-571f-4c61-b761-5b45d435c4c2@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 03, 2026 at 02:16:33PM +0200, David Hildenbrand (Arm) wrote:
> > +EXPORT_SYMBOL(__vmf_insert_pfn_prot);
> 
> If this becomes a dedicated symbol, why not GPL?

Yes, no way we'd not export low-level bits like this as non-GPL..

