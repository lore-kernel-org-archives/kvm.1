Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227578F37
	for <kvm@vger.kernel.org>; Thu, 13 Mar 2025 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847778; cv=none; b=BYqVLTdFaFQf2z5NOD4ikJ8YHjPsDp9MJHgergjTGrkG4Z6cghmUn/jEWCIG7JBfDdjNXPWzFje0CQypW7cX0wHIgopAlfLAxt7QFYsNo0GKdUZLpPXNsupwlB757fuY614N+ZoIKcHip0BCyqByRpfhu+mqH++DuuWlgMzoX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847778; c=relaxed/simple;
	bh=Ngmbof2S9RZPBSBrnNDQb5ldQ1rp4J9dBDlRzgSfWo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga1q3GFn0CchDto8+aipAAtvxPegQk75VWwP+vL4VKg9SDItoZxgD2NrbE0RI2NeQ2CUHQmu6ydzZsRQWP5fRWasJKCymkeGXYF36d5ibUr5IiuVjBfEJWz3KNiDHMGSKOoM9VpVX5RAWbakM+LpJ2idIl2W6Faf68Px7KlifRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86F3968D07; Thu, 13 Mar 2025 07:36:12 +0100 (CET)
Date: Thu, 13 Mar 2025 07:36:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 01/11] nvmet: Remove duplicate uuid_copy
Message-ID: <20250313063612.GA9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-2-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 12:18:02AM -0500, Mike Christie wrote:
> We do uuid_copy twice in nvmet_alloc_ctrl so this patch deletes one
> of the calls.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you send this separately for inclusion?

