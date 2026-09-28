Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822B38F62F;
	Mon, 28 Sep 2026 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636429; cv=none; b=SkWgIq+iZ5RgQZ3ERnRsT2Mr1uFLscKoVtqw2b2UfltkOIAzOc49HaqI2enj4wuvpjAlh1lFR3voHwuIzTJ8xpV1m3hW2yGzv6qRItedNuzQ1YVQKsByvTAfpmFKF3owkrAxOWe6PMbi9gWVqzvwZXS6wHe1kxxFjuvQlUjmKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636429; c=relaxed/simple;
	bh=ieJXH/aQUxE1o0Mk242g+7WkPTvPVm2dRBn9AGqy8cg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6eLb5GCyEYO27iN9wcUPdB6YraT3LYAD10aikqH/rGOYAzRlEww+Cx0DIz1Ijrtzmy3YOOvzmxKNqwDRGgTXvm3/FlGSgud5ADrhDlg/GUclyl95dTFSERUMAQVO//Q2/fmPC8ASQtr8g1Z1IRp6QLWhh+wG8xpeirkapKw52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=bQ4WhOe5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wdYORbGG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="bQ4WhOe5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdYORbGG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 591ED7A0168;
	Mon, 28 Sep 2026 19:00:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 19:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790636426;
	 x=1790722826; bh=Bua0qm6BkC4ecETMHMvgrmSlvwFGPueQjFWPjHwjLeY=; b=
	bQ4WhOe5zkw9AYjLOdw9tJGTG1fR0PMvIjy27PTzclUA0n+BFI2/JGIu4u+I2G0j
	cJELgGpQgnc5nf3Cau7t+nYYzPPcSB6yrxTV195v5yrnELZ8M7gzbcgcLPgziqyT
	tZQEWM844efSZOr/GneRYYSI90YlHRITfK5cTwhxfhdYcDRc8jkEqyloL/fmn2tY
	/cyTmOMt9MnsB5sLDNUaf2emRn47XVmZ2rfRTaO1tPnSWl6A83WhCN7ZXXSrEtcN
	1lFUxFFW3NP8zHsTor5W4Lner8KaXt1qnn+pRScjefyyzaYIfbnEiodrGdWZ6UNX
	U6+da9hujeJwRGl5zntYZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790636426; x=
	1790722826; bh=Bua0qm6BkC4ecETMHMvgrmSlvwFGPueQjFWPjHwjLeY=; b=w
	dYORbGGZfni+4FYanCENj4hE0QLoOi/NWM3xBU2Jgq9YAZi1OaGOj1MoINiiYAbr
	rNP27BuTNYuEHscuPTs7R5biHCrT9rtT4t7wd6gkKVnhdRvS52wcQjav/BVJU5V5
	uqzUHmBnl1f4SmGY4HWE+ISUvjtkdC8M9Meymh9+1mczcOK1xYp3vqaUUQF813HB
	aNDHbt+quBaF1sFbax3poahUqUKxS+dxISDCBvyIdKXwuS7v+bC/1y4mxPx2OBp1
	WbldSaE/6SP4rN6JlNJFzGhs65cVU96eubwr6CMCTRD/mAMRp05XigqOiLJfQB5N
	/c4u/cIxLOE9FssyyuIsA==
X-ME-Sender: <xms:ivG6atF8HsUa8_1I8ytWEWK1RdBT8Rsvxnjsd_y8NwbXRk4tX6Hl-A>
    <xme:ivG6albsP9E84UVO8Vs6SSZ3vYKL7kU4mog5DKFWTyCfVbiKWo1uWZTkocpn17rGy
    nJtTBetiHiFuNDAe_B4UeQ9Eo4HqWcKiYKfTh8DcVzMSdrtD2CV1Q>
X-ME-Received: <xmr:ivG6apy88lVoBFPgiyzlF-XWdzDol645tixtL5Ki926QGykH3a4c3OHUWzHYUg>
X-ME-Proxy-Cause: dmFkZTEJP1T1noyhysi4+U58kZNAVdBwQPnT3P5zKtJ8Bs0Njdld0XDcamngalJFjihENE
    NQiEZfMbwEjMmvZTLuAdeX3DYtSzLzjwBsxiG1VZz6Lys9KTr35eHwX5kq9BfHKB5fuUrC
    Suf6Ql2UjJKtlbCdH7Y/TxIEQjMwvzQDRevlYI0pYw50w6qFF1nObpzEfHgI1/aKvz7h/k
    PNa06Lx8DzIxTXcGh2H3Shfw7X3f29mTyUNwub7D/QMz/qlQ1+6gBdlFQiuU7REhloBftf
    N14CIqWiXg4qdbbHBMyyOp3nS5G9YcOmUtZHSYCVHicUYuefZVSXyWx5ERFnjP0rHfCKJI
    jrpCqikVdGhrxuJR7m15SbHzUM5Ha6/QVN1EmgqDPv06tyUXPccrXUk/w0CcplkeaBpnJy
    kwYlPNuUqZW3ff9hbCWzxlbInTbZV+f/4ffkku+tlBE5PvxszQfPzesMcPwQshQ2d02R/C
    6lrr06A+mHIqFtcp7hwg42PVbfbJs1lYC2yuaeksEPpigYzJ5sqNgT1aMfYcBw8+bJ5UK6
    o6PkyL3pZkt6I8ffxzIc4TPoDJu0XwJgBhwdNTjsDc8Yy96InrRrVR5Eno256EamRVwx7M
    7iuIfT1Dq0Zd63fsguLaQhPxX9ctZu4mVH/fC65zXCn/imiPRrWAzVsbdsPg
X-ME-Proxy: <xmx:ivG6avTtoK6tiIMq8Y72TrbVhr1-t7-Qb4rTcPgQrBbJ7RyJzU7BpA>
    <xmx:ivG6auLx_ngsvxop0UVlIH7WFKRsW3InUacqz7V5s8DmuYNWXagjAQ>
    <xmx:ivG6auUZqEwqpr6PwcmG5cenpGst3m1QR3DFvfU8gggBerWUAsBJGA>
    <xmx:ivG6aqSGbanDFddbuvyT4T4HfBlR8delcMQZlTsVOzKFWsrq2bvPDA>
    <xmx:ivG6amMhYz308ZiZXaz8yN0w_7eqxZJvs9Oq9heYARXvK4isk07NrCxn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 19:00:25 -0400 (EDT)
Date: Mon, 28 Sep 2026 17:00:19 -0600
From: Alex Williamson <alex@shazbot.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 eric.auger@redhat.com, smostafa@google.com, praan@google.com,
 ioana.ciornei@nxp.com, nipun.gupta@amd.com, nikhil.agarwal@amd.com,
 alex@shazbot.org
Subject: Re: [PATCH 4/7] vfio/platform: keep logical vm_pgoff in MMIO region
 mmap
Message-ID: <20260928170019.2b46ee5a@shazbot.org>
In-Reply-To: <20260921122334.2099-5-suruurism@gmail.com>
References: <20260921122334.2099-1-suruurism@gmail.com>
	<20260921122334.2099-5-suruurism@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 15:23:31 +0300
Abdifatah Suruur <suruurism@gmail.com> wrote:

> vfio_platform_mmap_mmio() overwrites vma->vm_pgoff with the physical
> frame number of the MMIO region and passes it to remap_pfn_range().
> The VMA is inserted into the device file's mapping->i_mmap interval
> tree keyed by vm_pgoff, which VFIO expects to be the logical file
> offset: the core links every device mmap to the device inode's
> i_mapping precisely so that unmap_mapping_range() can revoke all
> mappings associated with a device (see vfio_device_cdev_open()).
> 
> With a raw PFN in vm_pgoff the interval tree entry lands in the wrong
> coordinate space and unmap_mapping_range() cannot find the VMA,
> leaving stale MMIO mappings behind any revocation attempt.  Keep
> vm_pgoff in the logical VFIO offset space, as vfio-pci does, and pass
> the physical PFN to remap_pfn_range() explicitly.
> 
> This is defensive hygiene: none of vfio-platform, vfio/fsl-mc and
> vfio/cdx call unmap_mapping_range() today, so no reachable
> stale-mapping issue exists.  Keeping vm_pgoff logical preserves the
> VFIO core contract for any future revocation path.
> 
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> ---
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -561,6 +561,5 @@
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> -
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	return remap_pfn_range(vma, vma->vm_start,
> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>  			       req_len, vma->vm_page_prot);
>  }

Eric had provided a Reviewed-by in [1], I think the only difference is
the commit log, including dropping the Fixes: tag since it's not
currently reachable.  I'd keep the R-b for that, or he can re-add it on
the next spin.  Thanks,

Alex

[1]https://lore.kernel.org/all/21fda51a-6974-487d-874a-387dd73e2346@redhat.com/
