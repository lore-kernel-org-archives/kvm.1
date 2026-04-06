Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D2A392C5D
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516906; cv=none; b=Pm4+SkiiOS7Y2i612nR1sHeKk1RHIDckqNPgzWEW7cXfxFl3A1rnKxtImRAKMDE5xxG2IB1x770dkcSDUsFLtJnvCtECaRceYQi2x8OT5F7+QmpHrMSQzC2InYeRI3Wp++/Nm+0YfR0YOWAyxFsGHhKTwHQJE26B5bjoXmu5CAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516906; c=relaxed/simple;
	bh=/a5Dkh8WNMLKekzLba+ss6TDeVCSPsEl9pPWQ8V9rkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncsX99VyTdMPbzrwaVpkcvC7TljQ6HB4LcNPGIeZTR7dACA1kNG8dDT6D1FX5NL7XLNImx7rw6E2gs9eJLaGjBsYz5pjQYOxCUJ+zihAsan+PdNLH+i/VunQUePorjizX8KGlsLNC9a5suTk8D5DGd/vUcBrvkuQpVQIIdI2Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PImEbw3d; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PImEbw3d"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adff872068so20180835ad.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516904; x=1776121704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ5dWOM3uIstb5rK1L33RqJcuXkE4TKVzPfj3K/JoaA=;
        b=PImEbw3dbdtaCxZ9WQFMVDStl6vrLfB3lZhdZb3v72q4TB1UjYraIBXWBCRji+O/sH
         RxQIHEJ7CL0BKPm4Gkpkl/IX/XmREssjyJDSpD8ZN1+GNZOnYY+FTi8Bs/Px2TtAYTVj
         s3vhj58KiOXQP08yj4bwrqsMgo5gVonI4e0s03Bn3FRo1f7tl86t6bWKV4wpj5/qJl2F
         29Ev66+DXlCAgA5GV6LvkhnVwP0afSZ6tSIrNgC1nT5iCwhu8pN0DeQ7FDGQRpQQKv2p
         4uXOC4Cy6toBhm3NJUL3w+fdNtSs+Nv8Dp+e5isGNs5NAiYWDNmn6UAXL5FYNWpLs5Lf
         PPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516904; x=1776121704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ5dWOM3uIstb5rK1L33RqJcuXkE4TKVzPfj3K/JoaA=;
        b=TX/bjm5g3FE/qoXCVTHg6PVBDKR+2NqOr4kqNIs+NeTWpkNgdCgIVt/HKjLntc0FVL
         4qCcDollDXE7VMrb4qKYmgTXsf8f1gCkOtb8uwuboq1h6vNoPdNXpnakKU7E567MIeTy
         YGJpX92W/5j9f4NptugIfCLcgq5OPQwqeVRJ8TUOAOd3a3iAKIQVZE1875cEj6q8GbMi
         6v0SLKQEJWT7NuSxS0+nlemRMYrKc20y4hF3S4UZzj3svKsSX6Lp0OIb5+BuH9Y/e+Ny
         9qOrqf/iyMLaboo8DmEayUMc1kSavGiltiIrfdCYSqQ5DquKIs7KWCkp7kmVeF0eiIX/
         u5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCLWqpnkWMmKa2/JDEQSCMXY4fQbfP3vMCrtKZx6CsPhQNIg17HbfGKFOnB+Grt235CHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJZLZK+r4y2NFAH+JVFuolBod7+/znWwCi3kNKfFJhvSYXRWX
	9/wpsAglA1pHWa/E8Z3WCCqKzY3af6lw1webX0AbxtGWYgSWScJGYi5gDcLyMJHzXQ==
X-Gm-Gg: AeBDieu8zhiCUKkVRwRwDrmwx9mP0WYyhOY71bOJq4qyLkLL/pNJfaRPGtWwlW8zkO1
	Nifl3SwjqzGVN6KeqYgykv5OacAjkK9YjI0xJhc0xmJD34USgvQ/eDebC3HGybEjPYEq7uVNDaS
	cJQrL+/p9JNo+A9tZBGOk5IbQEGPULKUXX8VDHXAI4ATjn4+a11BbjRBuagK/4ixC9O/Sp2KpDE
	+klQgf4NNZDHl8BeIPQm8sdgwEaXcOoEtyZvuipi1kYTLBZLo1TxaBrUKSo3UZS+J5vEqydK5uE
	HQ40R0EI/ExI51J5VzyhzxnAHjyi8pjOW6aJIfzo3FAio6tNo04UdpPAW+ePb3ZSPBi3jg7Aq5x
	ZBcNtW/UkM6UMpNiczqmQQdSdiKGBiyNJqSU4c7Jy3aoGxfEXAYETMo/IcMtDqkXIj/RrN/8bI9
	pMPGtUvpx7OFNP9XPL02dZL5wY9zGbpnsNxlvge/mDzJp2qdrcwygRDLIdcgE1OIgtjw4p8V5t
X-Received: by 2002:a17:902:ccc9:b0:2b2:4a31:235 with SMTP id d9443c01a7336-2b2818b006fmr141475565ad.26.1775516903557;
        Mon, 06 Apr 2026 16:08:23 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a348esm162239185ad.57.2026.04.06.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:08:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:08:18 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/4] selftests/vfio: Add memcpy chunking to
 vfio_pci_driver_memcpy()
Message-ID: <adQ84lY4fLs_MCsU@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
 <20260403234444.350867-2-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403234444.350867-2-rubind@nvidia.com>

On 2026-04-03 04:44 PM, Rubin Du wrote:
> Add a chunking loop to vfio_pci_driver_memcpy() so that it breaks up
> large memcpy requests into max_memcpy_size-sized chunks. This allows
> callers to request any size without worrying about per-driver limits.
> The memcpy_start()/memcpy_wait() semantics are unchanged.
> 
> Update the test to use 4x max_memcpy_size so it exercises the new
> chunking path (4 iterations) while keeping execution fast for drivers
> with small DMA transfer sizes.
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
