Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E53264F3
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677038; cv=none; b=iyi5J3VAt6GZQrnhQwzOOWRdDGwMATbUc1zEgHj7V6W1GOrD0dLXQyPcTJ6CJmV3rtMqCghtkWB0zDLBaaySm0BHxqXNzOVXJrLfRrXdDVWTS7vd1ZlNhG1fBZjm6ELibW05GA6lZWw2vU0qMXkAK2hWarXqDwUS2hkj/kZPXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677038; c=relaxed/simple;
	bh=VInkhQ5cN1UgrkyCqVsf7W0yAPyJU1+jBM2qlhzBzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD6tdL0fz965HMu6w/XRvfUD2KJ/m9VXCVXawqfpW2kO3ZfBQd8bTeOXhhQbzqrs4oyRncFkjxu0jslkQhrdwKDyLlPyYKYkui0rb9lnFF4KSYf3og7ykxB/0RyVQWTyqF/BZGMdnxOdVlvx6i6auG4jq8whcx/3Y8RTrIs9A2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/weheCp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/weheCp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aeab6ff148so160445ad.1
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773677036; x=1774281836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=Y/weheCpwOKFypb5JRCCbqkQbARpJ0gg5UKZ3L20u70gNb31B+A98JTQDJxRPNpyrT
         1BT47ZquWv8Q8WpBrU+rXXE2eS/BjJjMtpZxJTxogZi0tSuV9gf4pFsk6/VXaWt7FFI6
         Lzjfw2KIZCwYttcgCjqzPcSDy81mX7r6wCQzsW7gvkpjHmMtpl/BmBImlzN08xL8EXor
         LkF8ntWJ8kWAb5jMytzFmsghAXeIXxBD63U/4SSIB25iRWPsWuzkJuIfQ3eh5LQ3RvnV
         DU6U4xo06jf6Ycp2DblajTywRg5TEcSHnfG9Lu/PcfjfYw9VvATNDry+JRT6gOh7NXwp
         acMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677036; x=1774281836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=LnL0zvXAMi2tlz5pKWTVk7A3FDZyn4t5OuwI683Ej16mDn3Z2UZDcoSgBU9gIV269E
         qhk0QK0kb+E6gn312CcPeecwJxg9NICWVv18VL0YOT2xTrOg2/hOTQ5pvWWjHGWo08Oa
         ZMNsIyxZRCIQp/f7OdCcD2xk49FK0e17zy2dFYU1mbsVY4ZgbnyvMTZw1Uh+xJJiSIja
         EU2us80TYvxhwXI73b7iDWIuWxdbh1TMp2tLqM9iYqIxAr+pFveiiWAswCafQtZti+Sb
         CNl2GCbWHOWN0LhJTpxPZGbp4zAAJLMF71TtYKGP8gZuMxEkmI253BeRspDcHRwPyh38
         vKzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaeneOix4jqMrEWAUVvwxkvjnBBYFr1KQ9xAaZvMcjldUh4U5Z0ZOJzdmzv+4CWqE7IxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gtDKiUUGFAmX9TSq2CW/QvOwpC2J5489xOaDeRl7oAkntuko
	BpMUQcwXMJ3TIuWKM8i6LlptbvQ9yxnL59qrIGTf8oAKOh4BwRICdHRq2LzDNofrcw==
X-Gm-Gg: ATEYQzwwHQ5QKp4LmVqeBvSVZUEt5vPj87FX+GGzFzOeGgb0bNK1roMTRPOX9uJGWxb
	TVkQgKwAjckV8DxCza+Wb8/bEm+yJeRez1SY3nIqbHMXBkXpGShaMcmLJjdSxbH97l9GB5dyPBb
	wKGwWYjPbwUafMzMGeRG2uSSiOihpsz1z5csdzvDFFUk1l7Zh6EehZVbY3N8cvXclLo65ikK5Tf
	yHwoFt13/wu+F8OdkImgTsMAOi4DSU/G2jsBOSjpNbfY3X/fhZQZSHQ3Two4pLQKmxCATkQ0Ceu
	RPUfP9aexu7OEBtdpNf/wFFHNXohRo3WBp9zXUS24G0JsNsEHVQE3WMmurSN2SHS9wp7gx58inu
	/6cLmoVhG3Qwa+nHge+1KbJs/VEqMycNg8uw2rz34ruKOchwNuXaMV4tpgQxBKz8KWzJtQbG3FN
	1YDkJejM0+KzxdNEKtR32wtBhm4XW8vV93DjU3vopyzxU81GV7hRZIA6Fmgg==
X-Received: by 2002:a17:902:f54f:b0:2ae:d10c:6382 with SMTP id d9443c01a7336-2b042102968mr4463575ad.20.1773677035489;
        Mon, 16 Mar 2026 09:03:55 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966cesm9261411a12.10.2026.03.16.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:03:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:03:50 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <20260314061747.GD4177610.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);

May be we should rename pci_liveupdate_register_fh() to something like
pci_register_to_liveupdate_flb(). In the current way, it is confusing to
why same handler is getting registered at two places.

Above name will also make it similar to IOMMU series as well
  https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.com/
