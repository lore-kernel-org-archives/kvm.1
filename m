Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FC446F494
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697565; cv=none; b=kbJLpqQPEPbY4boVpQ601HDR4TBNusNsuUlDxzvclAvfhU6znZm2zLqAxkc/5brmeLaer6ttFNrRsF9g+FdUGyG61bk5VDAnLlUjndPq5aLNmPZwBGuWNv6S2SmNCMCfVHHQt6iPLnuxI4yB+ncUSrjJ6QA7g8MTmGBcfSbnlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697565; c=relaxed/simple;
	bh=bwnWYK80nFfKr3iwUcfFe3FiEOIbobSQBQGXAMlfsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRnHqVEQoh8zFipxVO1FvhSEcdn+eq/TqCA5dJhzJ8ZBOcmhtsKJMy7xMJhwYg7R7XykoirhuH8a1zOcAcGFX4u8/bkvr3YK55htaSUHndYEDdsH56YN1cWbfBpgFjQReVGmJ4RhoHKthyNCtRAx+pa70erCX9nYUOG9egR2UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nYBYdIxr; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nYBYdIxr"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so2567961f8f.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790697560; x=1791302360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=nYBYdIxrDawbXfSaFe7w3OFYOIJlQrI7qz59yDzNoP/mpoddTQw11jDpz8fIdtFR8U
         Znr8Mf9igyXtWKyhX9oMfdAJDqgBGoGjvHJ6igkkprc58F97zd5CcoCsAlzLvRI3ylim
         m1hLqtLjxW1ZBq19GMmUHaYSFSOffW8bLP3K3qMkDov5FsMy3S3x/irgsjS1eOVIRxq+
         mTxoNRrvS3DP/l/GGQcl6eQRSamNLt1PpjT8Td4ULW0LxMOaLDCJ+NvWfW4h18DY5Ss0
         azhkGRaDxXPuY2FEehlaV3VB2aS/wbvlM5l1jOZ2enaChDZdM1x+J0h36wzrNkROlZrg
         6rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697560; x=1791302360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j1GsvDFG4oGBkWvUsNYUZ4jWPGCGdM9fhJMq32ExyQ=;
        b=RY/DJCwtQv05IFF8w9mIYU/JR5tEe7Xq0UNOlHnoG9tD2eBxCuEiiHTtTVSdSG9l1a
         b97RSurlxUomYXN9+12pztM/LcLjw4ZGZ21RqzkcyebFDtyqcroFH3F8mF9UJ5buKFg4
         +L7/JXb4hX1irbUmAdKbivjThqo2KJUjtIjXrFTPTIAUh7Ube4Uc+2r0ScDtpnPkvaON
         3COYN2zHcIfe4B26QNgBi1XWljPgD6Uf2MI8rezaw1enbmOmv/woErd5rUcWOXZEmnAG
         /G2udU+GPOAbw+6AsajwqaP5p0R4t/HyLcPXPTgUpXOSV7Hg3s+02t6fwPZL1f4uyIWt
         7Psg==
X-Forwarded-Encrypted: i=1; AKwUvBxJ8Miw7oAKn+tNdsOfV4NFAPL7TEydxW9FExg6dXir1GdLEa+fpAi2+yX3+35Ru5C4oug=@vger.kernel.org
X-Gm-Message-State: AFuF++mjmQ47pfO7dT6kpb2h0c8/bbVqfYpzUKolQ/b5SaQbD0K6WKv+
	ROam3UlQ9MAfW5q6v90rIRSudnHBDnOxH5pDgErSxPvZGGhmpMjU5HlMTPz2ZnG5V5c=
X-Gm-Gg: AYBFou2xGQtpcW106r+9SamjEzJby16QrPT9q9BxU/ReRdYdYangB9onh/wXyyUFcnu
	xIL6eYV5XHvzaQpAPXr6XRX8so5fX/Ig3Y2xu0QHUUkyPTL+6nIEpdLDGgECUnK8mYSDN8s/DUW
	F+HvFaew3VAIl5qQip1Uol8GqoyBctcAxZqFKzF6YQWUcrFe13vN95SZtFlRayS1kPGMu0WYE1N
	cSymRcFAarGnGVRO+Pxx0ITiCbyZfBm+qnStH1US0uRpnd5VBqJ2uoADqgnLyQMsbAcWXW129kI
	ycI3CrhVE5zxd+KkAOxOetKs/TMUSTPwl5mdVvx4KMJtkMYruzUugREHTX2h0XbybWuBLjolKoK
	HgvPjynSKS7ezuVDKHX/9RxKAHBwzvG++vYiwUiX/G9IFJ65q6KyPxVlHOEuLtbyy5RPB7T5zW4
	s+7ppz+Pj3aHbRovIBKfr9tSl/LTzPgjvayyqMga/63OiFQP3C5DTYQucb2peP5cRG1w==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id 5b1f17b1804b1-49ff06f839dmr227620145e9.33.1790697559827;
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:5c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a013c6f295sm7062155e9.0.2026.09.29.08.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 08:59:19 -0700 (PDT)
Date: Tue, 29 Sep 2026 11:59:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
Message-ID: <arvgNTUgcO0nPh-V@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:16PM +0100, Lorenzo Stoakes (ARM) wrote:
> MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied by
> MMAP.
> 
> Also while we're here delete useless comments for mmap actions whose names
> clearly indicate what they are for.
> 
> Also update the userland VMA tests to reflect this change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
