Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072A429022;
	Fri, 11 Sep 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123230; cv=none; b=dJFFmlxGZKs5GDcvn3rt+MglDR5KsMzE/1xxuCAdF2hFVK/lgvNmYRph+31WsEQo47M5M/PskGQ/LkwxultBFFXnFkN+fwUMdLEvqVGVAVYDC4KmJg9Eq0bVQvMZib04ARXZyvwa0XXmL8sqtB2TWlpfHEdPtTQ0M5Nh2WGoe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123230; c=relaxed/simple;
	bh=IiEQ0BKGFmjdBJsAyKSi8ODDvxrbZRR4OCV+oVSjHk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyD3i4SR7AnXhD4JwTR1uWfEO9wfgDQUO+YM+Q/Ix4/eeRI1gEAunX4Y1j8y6lmjl1/cLfhXOr0bqcmpPkxGXEpfe6pd/QICjLoHMR5AZ9eEhwbN/IJ7ozS9+WNyqg51je6UKYgyuAbLC0LT3ZMmkRptw1zRvj1JMSWWgF8J8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP52FZqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP52FZqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A691F00898;
	Fri, 11 Sep 2026 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123228;
	bh=lUSkqZbTE55uSpACypE/uCyL1WoB3V9bNkFmhvRfym0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UP52FZqCPPB+GNo0sZG6EkVJvqjJ5TR25pguMMmOAbKRAnzCdTxPCEtPbSAVgg1Y2
	 6J13HP7tqQabJbtSEfDvlc7apHZYwovm3E0uArTbygnGVMNXebLwTC4jps2cVgT6vb
	 AxuYLlUI63CR3svowEfwPEZaFacNMKdcwgrIHXogpVGladAGK44fasyoZq1r189jdC
	 vNs9RNEAkWSI18ZnuOl/lYSMyggwsUa6w9PVy+mwf0GhoX2+v/4Xeomxamv2EqsVYU
	 sH7bz4MOg/1VF/VadD/F2QuwdN1DCVlPIl4IWwBLJBGkvbEhSuokdFOyqhVq7tHkqb
	 DmCsRA7MbRiWw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9DA911980052;
	Fri, 11 Sep 2026 06:40:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 06:40:26 -0400
X-ME-Sender: <xms:mdqjascGLpyQNGTJuoeTwQFB4QvCzkJlEMAH4TZiYERMTdUfLZ-weA>
    <xme:mdqjalx8tQGp1H3mSDXPVilrLn8jzY0CtcThX830715JOyCWJnDfLEGFFB5iBOz7o
    l3Sk-YSYzNWFZ5r4szdplcsUG5Uilr_NLIkwK_Hxmgap8im65fbzSWO>
X-ME-Received: <xmr:mdqjatKle09rojiENpg5Wguhcy41MOWL4dPGUUgpUC6ic_owLdafCh6KiGc>
X-ME-Proxy-Cause: dmFkZTFKI6Zr9CjzLxLqyJzT3JRY5JwkA1lWfK3TvZqZ9sYlz5wHC7130aDfdqLwTH66Ex
    tPF/yEmDz2dA0FPJ1n2RuACC17hauHED7q3qO4y6giRHbDoP5gb6SZmDn9TJzu6oVzsEDH
    7khVCy1vH528X3OwBqLkkIslm5/QS8JnTC+u2xlepeJdAyn4Pc3CbyETy03cO0tD0ENYdw
    bOM4jmAzdG+/Kbef96dOcG0H6KWamgNHjxeRvijSaBIzeF55YyjBIP4FcB2uCtGbp0Unou
    1ah7uqHtWFFgeU5fbm3RQquARXXQz4ItKK4pK5pdpBMKXnA1LEsbzW19fk/DFQuX8tD/CH
    +QbxZBRoDDqoqpw1KwR6zfquXDc26+yUjl/4MK/rQFrf/zaFziEZQnwf0VIt29rKc+2tCV
    bU20K3hBI1IuXdr34wp3aTfbCjuPk0vKapTEb8PGOkYTckKK8U9ESDkTgtEW4wZasFmXoC
    wtINEiXnUdYmSdXZg24+uwgNslL2UJs4aOYyUYgXDVYkXFLHtdXI3429w5qSX0LdR+m854
    zaHQNA3HBgVJCEoSQ9bEurs3be3cHzdo4ecsWo08WzRnkqCcBcFKbeNC+AxlJaOKgL2N4t
    75P7pKefRhocuHS/yieeL+DCt7rBcLX/DJcUwMd+Y0OwLSsxKFuVJeUPYK4w
X-ME-Proxy: <xmx:mdqjauul65uDN0qvoKSFL-ipuCNlrl_-urRV4xL-RI7yQjvL6ekzJQ>
    <xmx:mdqjavROXO2MoJo2HceUwaTbXKkGBXlhcoC6mj3iQgGZOl_ix9uxTg>
    <xmx:mdqjavQTsz9tjmSG4vAj-sK_UGw4mqtSg67I4opMxKiiI6RyZPZXsQ>
    <xmx:mdqjarrSGHb4WPsQD5rA598sHBiLrVb2RDD4QkS7ts-q96s6Acrz4w>
    <xmx:mdqjavAgw_bWZwqlRQMyU3QGIlcj1p9jJ6LVmQQzxJGBar42sBKb4RZi>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 06:40:24 -0400 (EDT)
Date: Fri, 11 Sep 2026 11:40:23 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Move port I/O definitions to a shared header
Message-ID: <aqPabLf9yHwBjBHm@thinkstation>
References: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
 <20260910-b4-tdx_earlyprintk_tdcalls-v1-1-4b2b1bf9001b@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-b4-tdx_earlyprintk_tdcalls-v1-1-4b2b1bf9001b@intel.com>

On Thu, Sep 10, 2026 at 04:34:08PM -0600, Vishal Verma wrote:
> In preparation for switching early_printk to use direct TDVMCALLs for
> I/O, factor out the PORT_READ and PORT_WRITE definitions from
> arch/x86/coco/tdx/tdx.c into arch/x86/include/asm/shared/tdx.h, and
> namespace them with 'TDVMCALL_'.
> 
> The decompressor also used 0/1 literals in its tdx_io_{in,out} helpers -
> switch those to use the new definitions.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>

Nice cleanup!

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
