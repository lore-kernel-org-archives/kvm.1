Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB211C07D9
	for <kvm@vger.kernel.org>; Thu, 13 Mar 2025 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847816; cv=none; b=oTNLGr8nhr+JbR8ZBlcVdAJl+Wiw4aC1+C/IG48uKzUZgzhmO2QTb02AjCAmPXQ0sZbeHpUCnjkbtjWB60fhD2kDlZPVnrG6HoaUjOF+d1vkjSEj1bPDWXW90y/uginuKUKoS6SdF7zguZT4PeosoKLXLsGChORHCrFD+kd264Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847816; c=relaxed/simple;
	bh=k9JhKjMkgVQElkxRxhb/hV4J8R3LNXAfdESv36gNoHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDjZ23a6Zlvh4oPBvrpx5KLoNkmGvJRbWUJ6SGZDmzizPWEAs0Qvsvn1KZculwgvHkmOcYjJ1miMQl9FMuMGk6T55YplXI/dSYRLXmOgRt3bgqS8se7aFvfQY27p3XDOYIzFftk4n531pVO0vtKKkG5LwRmsiXPambbeGIXDV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8287768D09; Thu, 13 Mar 2025 07:36:51 +0100 (CET)
Date: Thu, 13 Mar 2025 07:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 02/11] nvmet: Export nvmet_add_async_event and add
 definitions
Message-ID: <20250313063651.GB9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-3-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 13, 2025 at 12:18:03AM -0500, Mike Christie wrote:
> This exports nvmet_add_async_event and adds some AER definitions that
> will be used by the nvmet_mdev_pci driver.

Can you add a little explanation why mdev needs it by pci-epf not?

