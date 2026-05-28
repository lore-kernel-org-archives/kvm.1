Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37613332612
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005761; cv=none; b=TgcsmqQaZ+B/ERm1G41VsgPFh0esmDN9hichJrs2Muov9PwgCXV6uUYTCHQw8It54jKcVyQ4DIywUoN1+ZxvJJf10g++PIM8acnKJwyR8jnibalWNGcGCNwI/eFNIbBWSOUY/ke2xuYbSJp2gZJ/YGUI8SyKO2/0NM7zZO0Z4nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005761; c=relaxed/simple;
	bh=LdY5w1w9JKQhpaZBSyVUr8rGqdk+R+saAIJWzDuNvjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8qgJZUGsUAX/YsMJ3DgPMU4owvFiGjhzRUHtgUcucLgy7j1AMQxNDyGs25/JZqergLoSeg1PIgjdUHoCgmOdQ2/dguvLUVXY8vgw72G8Xrki6cz7vq3XglS0p2sHHEGDlooWXqJrDF1PWCjuyQuzpIuLJ5cei9kDRYMbxU+2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZwU5P5p; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZwU5P5p"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8025f1c227so10071527a12.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780005759; x=1780610559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=jZwU5P5p3FTmdDG+AARv7m1FxkGzt/xkXiN6mu9dlBJJ+wYiJUBE4ZX4bILYM7+Rhj
         gGdZ0fezVJqD7hPQGNyiGQc3C+z7jjK0/LB1Lxw/1fHUR6V9W7gzk1zTmmSswrZcVFmn
         iFJDu5MAd61uo5ATATVm0eV2eojLn1fJ1RdQG9H5vFLvl/lcCcFlOz9XPAnIA0oAr0Op
         Z56mScARGdAwb5wZDzrSNHofRBGuYMQETy/8TlQbOX+MkyimBIDptf7i36rSKCy2v31r
         6A2xIrDD7GOt0/82jKQE/XCWEKMrqSMcdahg7erlbjTZO5UivapaP3wkzMDC2bsIoHAi
         W3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005759; x=1780610559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7lu1PeNcCkgTIxgc3W2FpjZdWenBKdIMuLJ/NcoWBc=;
        b=BzJeXnNrxcLP93GZhUSjNBZBgLgTMeM84ROYKhZc16HftnGBl74qzZtDgucB4/fDlc
         N4Bh+jKeJ+OZnSqy6vpREKAcJX3Ukzu11jxIW+TctupTC4A6hQBK1ia0u01OI31YE13y
         BPUtIRMz1RYYTiDvWJodF/c6zZFYrZrY7jBqPjtqoYP60IKLJmY/gRNPCf7GIu4F/8m3
         ZpOtpbcD+tkq4B9IjCENHzT/RroGUq4kXKuXcBp5yCV/r+t/SlrZWM3t7LG0umckdctf
         ZThziUlmoRk9gHJtZqQ63AeuNw7SXDhegKW/B3qi6r4cFaU1esz5obmDwA1GV6G1GU0m
         i4eQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gEX3vwrbX3myyXjsD5Tm2Qdopv/N/aR5Q5f0Vp8pQGJpZEOKWR63wgFCJo2sCTBv9Mb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zA4mTdTVQY/boLuHBig7qmCU9qm6xlxD3mVzuEyaDAOgak1y
	P6Yka16zVBWdhUmRjWppZ9WjMqTS8rvv1mmiHFbKX/07Z/UmUyJexaZ7dfNCny/efw==
X-Gm-Gg: Acq92OFJFoBVIEgHy5xLfXx9xt1GOUjbxn9/JjedwPvmI9/nFcKI/1nREkX3qr39nHy
	VwiaTEMFuBiJXhYCbHUrYHCwdxkfEvIpISAa2zFKNjUkZmjnObRRFYG73qFf0ThJmrwVaz2ALX+
	imOMKcbmr45gPMvyD8juMTOY0LttIy9230sP1gTaDylb7mM+HuUCnj/EPQo2iNEp/S/m5CcTxL5
	lf5MgYDXoYcmklo77v+U/yEf3VI7ZLqbyQsJ+aDQykQ6wBKdMoXi8WICRG5HnPBaXSFIcOq5sEO
	HLOz3wyN3/kZXA0DwBU//bHSJLKNP5Z/tEe3ajFAo8qb3LZYRHR2SdL72KeVCuWzRIa9siikLoT
	f1eh71Q11b/qeOjGdFPWZ/ysIZgmSocINuXCOBrpATb08QdUaTEhyqB3z4nU6bK+kid06aXUGZc
	5+Z2r5tGiWwxUlMnMTLTIOmSM0VXaKdcU974bNIjB1AIwXyJ363+85BetdfwcKeve7mQf5nBF/
X-Received: by 2002:a05:6a21:648f:b0:39b:9644:6e94 with SMTP id adf61e73a8af0-3b40e32b279mr628896637.9.1780005758951;
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85759af1f5sm31047a12.11.2026.05.28.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:02:38 -0700 (PDT)
Date: Thu, 28 May 2026 22:02:35 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 08/11] vfio: selftests: Add dev_dbg
Message-ID: <ahi7e1MEoHwk-rtF@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
