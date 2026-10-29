Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234054;
	b=jJrAoGTXFzfdCTtWraPX6G5eEzAQi1sH99R2tdHeFuGd6GlUg6YFDvWeFGMisciCRjQh
	 zQGn++j3qirdpFjd5jp0o5/Tb1Uz4KY10s4PjAX+m5HEP1RvixN4WBf3DzvyZz8frDXYo
	 a2iSSdPb4XCfyXfFJamuL+KfsdEke5FdAt49l7uQg+FVQDQO8fNYIoNEfqXBQpOfaH+eM
	 prO+rhT4baNHFxumTHeecq1zx3BMt6oBECSvZUPPhVzbWgOE4Gwwlh44J+CUNXq0IO37B
	 PQC/roBItTjSIHW6DEvTTA9ItAEbH+5O8g8mzhOb26Qw1UFBlpMEchxf8woFwVgfidQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
	b=Kjt3i8c/eip0U6OmEL6gntprhXIGlgFCKlZPvVtWiXAokoQrOcxSSDDcuRAx6A5J671x
	 fRJskxF+qrZ0fRWNp05jYdwSkYn+lyeK16mudHbl4qU82oKC049u3IX6Sai/TcaPXqn7b
	 wlRC6iggKCYvQmBnut4yuOvszE8K9ric4UVQFGzzPwb7Mb9olO/4oE0xEvdjyadyO1I0b
	 Jxh5l6OCnz1knay3WXOK8xFdbdlLlGH9nVEkD0pScsuqfusPtnINu8DbQmCSdA9SRfUip
	 SmMPVRbRwEmtAYVsBxgANUd8ZokHWhfauz+8ux0n14xCIS3b/ykaqVkOvNteB9PDXtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="NobvrX/0";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F77606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 00:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NobvrX/0
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so19385ad.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793234052; x=1793838852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
        b=NobvrX/0l62njD9ijZdvX6wqPPZS7yF70aQ8vLemovxkQFOweOYjUX7egH5xlVpP2t
         +EObPII1qE1uKzowDDA+07VQjVblKy3gSRgTRX+ou+bHDwqlOoyv50PhuYM+Mw0XE9iP
         ExuvuGl40P0xuPMyTVjn7NmEHpDNH6jhzWBufcZpQbMXU3HJZXkEP5MGAa0t7knervJf
         /gi7wh7PU1heRKIh4gnVm+Oi3FfTDMCeEn1SHsYsh5Xoj9++73dOMt0yNKL1EI86G0Ng
         L+sZ+Otsk7uFhfRttynb4kqpmF2YYm9/jIXyORJJsM7xmrCD26ltHwO+v5b3iI5E9UzF
         FtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234052; x=1793838852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
        b=2j//ZaWjxTlyDmRvE9aghvpyHEdBLEj+AVjZd8nn6y+1RjXxYobsmF9IO+3ZMELe1l
         SKv8qBJxjtSpGwzCDUy8RBWGJV6gXQE9Cl84+bymiRUwO2R2dtgPDYd4Pdfqknwxslmx
         3XYl4Z7nsypP2ufhX+ryY39BSJqXT8NgySZAB9MPVpFAmdlsrsjC27GKVaIro9La6FSN
         IbjAQOe1VFdNo8LuHa83RC/u2n0ez7eque7aA2Ll/lTJSRpG7Nxxo8YE9j0Ru+9e44Iz
         JXz/Ai1T3M8XmNRwc0zSdXqEsFOSRoByRjYrk/p/MYS4Pb1BlXUDC5V2RHD9IzbrGjJ0
         2r8g==
X-Forwarded-Encrypted: i=1; AKwUvBxFoPU/OjZxmt3VtQem+tER7CxFWBsPdhUrzv2Md/xTB+kNaiaN6ptqDpYS+UQuN8+e8oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMt0MLBC/MdwEE9Th09PfYHYLyA5Q2G/4tFibMC7jnUfTw3voT
	ZrjfBncrfyWIzQod5Nsxf87Wp4rg+1DoBFuhRM9unfPK3irNiSBKdgz56TfyLswypA==
X-Gm-Gg: AYBFou1I+sWRKERBlzG4a9fHV2by2oXiCuXuhbpWIlfKOH1J/Q6hOOjF4z9r9OTiv17
	q+nOPvKzBLzcSLANNShrg6fQB2Hdl0EOsGj1vof1r5IzYJ9+6nbhU/NnB6S/QIPgNncncseEZbr
	ycIkC7il4Tq5lSwHxLERTf0dU+J3fdhkZOdZoIc4aCmiCIdVjI0XrFxykmWSsZk28waiJsGLLgZ
	Evo4BBmksfXQMtRJBfdq0SifTOHtViNturc1Rz8JjCadhMmPjPyNs8tmqcvWB/tNWKMP2Ks1a93
	zocw5HB3CFC8AvoeI0kKzHjlSnRBPud2r0XFXAXI94igxZeDfDfzTix7c/GZdb1aPG0aopkBnwt
	lZzI8eq1baNRjXcK8i+6oHYrFe3CLiPueLkPngMhQ9MOgIxs/+d8NRXhC4TuIfaLlS1EMXyT/k1
	nUH7649k8FJuC5iYHB2bsqlZ2AdHCW5+FcJ/1JN0T+Zsq+P+2luUQ5Bs4XswVge6av6nwlDExyb
	pQjsIfp2q909eAJD0qgA5rcqgU1+hsgpwgcz8qGM87i4Fgp1kup5a7Lumz1NmoHytp7/U/27gPR
	rYU4t0+sjSC5VFr0ripL7Zc3pJY9IDe8RwRjiNygXv58U6SvMPlY1/5DxWhIdNdWNmjv2d5hheG
	koWGGLs6u9LmVZFInX3AySPgxVOHdWYc5v3cdtKee1eg=
X-Received: by 2002:a17:903:388f:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2eb1b86ba8amr2826165ad.12.1793234052002;
        Wed, 28 Oct 2026 17:34:12 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad8f2c611sm2396233a12.10.2026.10.28.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:34:09 -0700 (PDT)
Date: Thu, 29 Oct 2026 00:34:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <auKUZTjuwFZc_oPp@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
 <3a31d343-68e2-4329-bd72-76a80b4edf81@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3a31d343-68e2-4329-bd72-76a80b4edf81@linux.intel.com>

On Wed, Oct 28, 2026 at 11:18:40AM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>This is required because during kexec reboot and shutdown the devices do
>>not go through the release flow, so there might be stale entries in the
>>root table and context tables. Also note that new unpreserved context
>>tables for unpreserved devices might have been added after preservation,
>>so the root table entries for unpreserved context tables also need to
>>removed.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>>  3 files changed, 152 insertions(+), 2 deletions(-)
>>

[snip]

>>+
>>  static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
>>  					    struct iommu_hw_ser *ser)
>>  {
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
