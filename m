Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0A2E2DDD;
	Mon,  5 Oct 2026 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228119; cv=none; b=IzB0MHTIQG2YMdGMrGdzr3i8WFk3fNtiSbA7AGTVxhPqGL09REiz/tVB9GdnQim3QBNo6lSkSZdRCcOL7unuYarOz08/QRRFnBq80ZefwL0n6H3LbBysCjcz3f99IY93tS0+LkjicveCYgias2hmiPhrNZTPOI+Qwt5SFGOJq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228119; c=relaxed/simple;
	bh=PvaohMiv2JRtfJI8YqYyKAKUtIm+j80OacuuUzLpyog=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=W5jT2ESFdvPCdeCoBs7zcZm2Vf2REkng3+1ft7TeXwBIfvigSG8jgZCgbywrqhOqcXM6Mx7fK6luHu1i3uIVdv0kEG72jYDFVgN5XIkKqD52g8tg/lEjqsmdaqIa5wiFq4BkH1f5p6TP1ITha1KhYrXahp1twuEEH0bgCmffZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNhpIlRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNhpIlRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D571F000FF;
	Mon,  5 Oct 2026 19:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791228117;
	bh=PvaohMiv2JRtfJI8YqYyKAKUtIm+j80OacuuUzLpyog=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=MNhpIlRGYh4/MqkiQN/B/8uM83PduTqfMM7qUWlzOYgHz2AcZ0zOLgN1dmTHd8N1E
	 7jQXoiopk/EAHEQpULMi/bSfhCEbkOaXaDopUyVhZvjRe4yHQq5B+LZHasGWavbQc0
	 uASmQ/bkCWdqkVIRfmxqgCfjL+p6uYvjXUY51igukMjejwZrzB8JcGvBNTMGyjuX5L
	 Qlx+Ya1Ll0YsiVRhh+5+6MdAw5NSgwe4o8+FX+rpfBudRSl2WUdLwj4ek6Dlq+wCKa
	 iJvkGHvntPf68Nqjzewx+T5byJ3N5q/AiA8TJco8kQ0sblrYNCPGffJmYTc77bxevA
	 0c1brYvlVZjwQ==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Oct 2026 21:21:50 +0200
Message-Id: <DLX5DE4ZH11S.L9I8S1UYD567@kernel.org>
Subject: Re: [PATCH v3 1/1] vfio/pci: Remove the core dependency on driver
 data
Cc: <alex@shazbot.org>, <jgg@nvidia.com>, <acourbot@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>, "Alex
 Williamson" <alex.williamson@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261005184236.1946167-1-xinmengs@nvidia.com>
 <20261005184236.1946167-2-xinmengs@nvidia.com>
In-Reply-To: <20261005184236.1946167-2-xinmengs@nvidia.com>

On Mon Oct 5, 2026 at 8:42 PM CEST, Simon Song wrote:
> vfio-pci-core currently has runtime functions that interpret pci
> driver_data as a pointer to vfio_pci_core_device, and enforce vfio
> variant drivers must set vfio_pci_core_device to their pci driver_data.
> This constrains variant drivers' private-data layout, including the
> typed driver data used by the Rust PCI infrastructure.
>
> Add VFIO_PCI_CORE_DEFINE_CALLBACKS marcos to generate wrapper code for
> each vfio variant driver, update vfio variant drivers to store their
> private strctures in driver_data and use generated wrapper to pass the
> vfio core device to helpers.
>
> Select the vga decode callback during vfio_pci_vga_init based on if
> vfio_vga_disabled, the callback only use pci_dev and does not require
> driver_data
>
> Assisted-by: LLM
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Alex Williamson <alex.williamson@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/all/DLFD2ZDSK9YQ.3A4R66G8UJMD8@kernel.org/
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
