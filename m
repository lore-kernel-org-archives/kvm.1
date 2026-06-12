Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECE3803E8
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288497; cv=none; b=sPISSc7jdOWp7+XIp3BbfEjt+vDaK8R6CJEB3T+0/rlGLWqZzRpV4HsLSa9Uz1imzsmzSZGXpQNsX+sVnWSlEA5jqP1w2rxUlUkh9OEAKBixwnHLcoR7Y3EIeLCIwcaoChv70R7wRjhyxlhrrUT2RN1pSIdPOtiieBARWGwgUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288497; c=relaxed/simple;
	bh=GXDov58oeN3/+KOSLd5d2wQs5OFIS/2CmV/MKcaSW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmTNH9g7WBxzpfZ5uNAiHk3s1VVDWYqTMKkf6/5r9mC/tGMysJgb/lt/4P0jLXgCfq7jCO5Q6S4WpsKe2snAPe1jjjq8v4Sd8DNq8eogBMep72mnybqG63AkzoyLYT3sDJQwXxdtAO/d1fn2vjCTxd/I+oRDqg0488ns19Q18Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbEASQ2b; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbEASQ2b"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2911f93cso7545ad.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781288495; x=1781893295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+Upf3vkFcOgQTn7qEBZF1fjinQnmqMOEEdN6sxgH4g=;
        b=nbEASQ2bz0xs+J/lkvTKkvuEgXiCDZj1lyyVwCdoI1s9xFVDp6/sHl4csodIFjqeIx
         OBJNUqXCIj3W6nUHfF8HeexB8FOOMVSj89ACUUNOAI+dCltTg9Mze5WT16ZSmSy4qjx5
         kshPwVI7wvkswbq5++yOUJQ6zW7euHLcAF4gUk5q1+ctGWIwH7k9Hay7wXYEALn5wVkG
         2gXCbPvEB//2T1TPa/gi7HUEeNu+epFV5zSJXkqaIHqY17PJNIyhWLOJRIEzGW3Ff5QM
         Y1E6wgZ3xhFcOBYr9AqqzPhGtas8paxSSsINdsmatcPavAhYxvwsS4Hubw+DJuNU0EPH
         OzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288495; x=1781893295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+Upf3vkFcOgQTn7qEBZF1fjinQnmqMOEEdN6sxgH4g=;
        b=MEO03yMEf3pg060h0oWpwjdQk/gni3aAfZwOOqBygGgpefSr4+C+zlwzJ6LsivvVWh
         9PhgcE5D08lkSKUrcCSDua8J7LkmtxXL+tY8+xRC1pPvElZN5o1HXD5Hzv5AGdjNCXN6
         X/VLXrq5vXIMawpIcO/CeguybvcQdTTx6LRvsE+gPNR5w5CSiBy18iTQPGntywOvE29E
         nZxE6oNCMhVajC7B6FJRVbAvbWCvJ/q8qG3RByQSWLswKrUcRcnQiB0iKPviA2dN7RZZ
         wN33CLCs4KMy3HtZf5q7jRttVJp1MT4CeGQdMmKJziqgjjpmqemuRpyw8C4p0t2npoE5
         TXpg==
X-Forwarded-Encrypted: i=1; AFNElJ9vf3G5EcMyWPzOIkb9N3b4yUgjESszn33g+8wmCuNZdv1/JpPnpquINKZyC02dAcCrJPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZRdKUrRNRUTAK+g8sxZYrAEqIOS5iTEmZxGBhiIsG4xnxi9k
	VYy/5Bei2tWWZLhaEEpeVsgjAhT2cJqsfGEWNE2tT/VFimPnjKJvEuYsZEqynJqBIQ==
X-Gm-Gg: Acq92OHQoMz733L8L5CGhHXylzw4iFlQJnI8mbL7PrX4+UzaOfb+0NEA7Zq4hRC34B2
	H8yhzUYIqiz9vgtTGl+13IMMaZircV1jCrgil7PaV9yywqmUBuw/ObE/jo5HGaF8R/f/ScWg22o
	P5fnI+jfj0M+2EXHf52Tioj0bYqT2e6Pc4lR8Q++o6LYsWFd/DUjJvD6Yt6Zfk8mhdC3aM1thja
	sRncmujTKR3xiDnz1f/V7mmKnTCMlu6Aup78NhUXNZN7hMgTXqDVkQWZ59eRbT65t0aotjlP3/7
	dZYGyFI96ijQegmsK6+m19tMtVXVpHDKKTXKnxRkZcx+mw5c4fo3TZ2pp7YBYY+paP9o8D3zi3J
	FRs/AI2bZR2BRnjS11Dn0BpBNLnMiYj4zw3JAmlItU2YL0mC0p8tMmZmwjCUn66u6HIzPpDboPx
	aLeueEPHMRwJntryIfTgXZrwr1BQhi/UmtnwC1thESL4VboPLrXUssgQ7U6e8w
X-Received: by 2002:a17:902:e743:b0:2c1:ee6e:4e4d with SMTP id d9443c01a7336-2c665142269mr202305ad.30.1781288494306;
        Fri, 12 Jun 2026 11:21:34 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8663352fd4sm2677095a12.12.2026.06.12.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:21:33 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:21:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <aixOJs4_HHFLgGLA@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <aisa6H-a-176MXhC@google.com>
 <20260612113735.79518b15@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612113735.79518b15@shazbot.org>

On Fri, Jun 12, 2026 at 11:37:35AM -0600, Alex Williamson wrote:
> On Thu, 11 Jun 2026 20:30:32 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
> 
> > On Wed, Jun 10, 2026 at 04:43:16PM +0100, Matt Evans wrote:
> > > +	/*
> > > +	 * If we get here, the address fell outside of the span
> > > +	 * represented by the (concatenated) ranges.  Setup of a  
> > 
> > Nit: double space before "Setup" and "But" below.
> 
> Some of us old school'ers consider this proper writing style ;)

Ohh okay, I wasn't aware, I withdraw that nit then :)
and come on, I don't think you're old school! :)

Thanks,
Praan
