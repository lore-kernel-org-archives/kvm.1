Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A13290A6
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928166; cv=none; b=uEbRqVkpK+wA58cAD19PntQqhNTuiKAKpwtdug6YJOdfn3zGCUbEGNdXfei2YemRkg4fXLJTnuwV7fOmfs8zYL1lLZXwbUfqSyvtFj50u6DFpW+yHkM72EyoF6MO9ZLd9UaUH8hSYlsZhKXq4QVnsutGME15fxtko6rX6KadCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928166; c=relaxed/simple;
	bh=6b0uhsWOUueBJikO+3RxwH3ywe4vOaHqBvUoJ1iBG10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGTONmj8JHrF1GtfYeukw6WbwNQ1rGbssmF8DOeyrKfCs164oCBQKlDDwygDW3C4zC8Enysj65jWZe6EenkqVvFcP4LlQfTAJ4pFzd0hjwMek6uAy4rstYhKOAf8eQcFpVTWG+WiJnl6z/ldE/vnr5rWGycDP6fLcS9s8HWxdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8I0RQIW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8I0RQIW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a871daa98fso26571935ad.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928163; x=1778532963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAEnOAPj5fUgAFUXnOyePT2fFfy+RA0tHhuCu8Z9sp0=;
        b=e8I0RQIWCDwpXPl0zwFKbvPBkUL4uuvj/YzwuEeRwSD1/RzGp6Ds2YnVgBznjkvqXV
         NgS/RiwiwRaZmkSJhvDrZ9wpsz61E3uI8uu6TFxaC27O8HUEWFMldbI27OjpAyJufE61
         sHtQkwdVOz0ieMakt03HswwGvApprhDBUHTxMfhqkrpN14E5ya1ycHM4DvInNz+MaxDg
         PoB18jN7QCmgr4sDXizPHaLnc42NHLHwUJ955HcezumMxiFHnmwh+bAoaSovB9J9/PVl
         PzxgB//5/z4EwNoxQACSPFB2UWcw6K61C78Vx3ebh4F6o0IS9IJGnPFsZhrIQ7ap83RC
         SQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928163; x=1778532963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAEnOAPj5fUgAFUXnOyePT2fFfy+RA0tHhuCu8Z9sp0=;
        b=JmOrePoIu4UVLnK1w/R5U4OJqwrytw0Q1XI5kJOu6QzIpuT/Yxv0Yb7h+UNXmKBPaS
         mb7XVjcnlNCKnfUF+/b7ExL0ofMO31lCno1UOzjg6JAvc5WVxyAF6BU1ZdseA0u/1kQM
         WQt7mYucKv/H/i/6QnwC76ifNJEtPKvHT1J4A+BXx4uIYi1LSPBTOmXHTUukat0g5vlR
         Qz08J+CDbO7/E9Aen1+u2iMTjB3qu7hvgKhDKCiZsEzRp7qMdKlCViVyDjIn+RQ3P4As
         BfMDkAehnVS4WuGl73MHLEIx4PswiTiFOEbaNxN/Gh9Eyw/1MjI+KMJzaUJAET/YcSng
         PrLA==
X-Forwarded-Encrypted: i=1; AFNElJ/I3M3L7IPrXixlBZZGBKcpWC/oq8AGQff8r7skzBP0U+cxM5cZbQel3SL6Y+U65rSqQho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG+Iv/eH08GHxdikWPIp92rewmoB7frFkznBKiZ++lQwtXAa4v
	XI4c6L/O/gDjZmO7Kt/Dm9T1XquLGIR9MG7gg4EIYzYmmmv13J6+KEBBMhNx8+sfbg==
X-Gm-Gg: AeBDiet0x4M7x2FAdiHB4IMoZpn9/rDiAQHA0j50RixQCSWmcaOefS14qFq1XiZ3wBD
	BdG03j+SoQ/VoYzOT/sgdSwwr3Sjt7mdW1zzR5jNDOO6pSXC4xt++ItOCfrWld/wJcSo4plE3MZ
	ZtT6Cqs65+hfonMHpN6cxitEODfML7ToFhXH+Uhw08F6Tn0znI2ZMFzl0EOTzbgXjaXxopQD7Bx
	sR/q7opdOdHiR1PFxP8PWxB8CyQBCkjtWvEq1MVG9P/VrIua2zu9NYAvfhgfHZGi/I5xa2onYDC
	ICJS6oTsu7cEdc/RbFuUJFdF2RSTQLgqbJV3ixj/R2han/htluUYF48ehwOwkV/PhCH6Xq9YiKx
	ugLRJkSydGCOGA9bfFpyP+YNKx+Djtn7XmbzeJIWtwQABQGxojwXPxhXh0voKMJexKPOu0QCeYX
	HQ1rB1wGluF/kG9rkUI78txEae5Er4HFoB42Uddsv6tx+jky2dQ26gak6kqYHTGCuyGY97fIf0r
	YoXow==
X-Received: by 2002:a17:902:f64a:b0:2b4:5a2e:98d9 with SMTP id d9443c01a7336-2ba53896e5bmr1405745ad.37.1777928162684;
        Mon, 04 May 2026 13:56:02 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm116816715ad.12.2026.05.04.13.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:56:02 -0700 (PDT)
Date: Mon, 4 May 2026 20:55:58 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
Message-ID: <afkH3pMJKkIbElhI@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will
> need ~18MB for firmware pages. Existing drivers leave region_size as
> 0 and get the current default of SZ_2M.

I would like to get rid of the magic SZ_2M to make it easier for other
tests to use the driver framework. Can you make this commit update all
the drivers to set region_size? They can all use the same approach:

  struct vfio_pci_driver_ops foo_driver = {
          ...
          .region_size = roundup_pow_of_two(sizeof(struct foo)),
          ...
  };
