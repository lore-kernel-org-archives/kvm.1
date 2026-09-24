Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189C3F0A96
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272828; cv=none; b=CJosvV4elcVUzWMdz2yQ/5W82ZV+PK57EKtkQ1O+y/2+hQSrTtHazN98gUU/8u4lm+7sSyTL/T7saAN3J/0wyDwZU1H4swpGSnhnyHuxIrZoQYnxUtMmxsDkBwYYHnOV2KtdFpBVks0cIkitUy+cc0F6XrAF58iWxGOfFmKtWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272828; c=relaxed/simple;
	bh=dIEo2BWot8KMA7bFyxIXMBMINiO703u3CNAgbTnUo2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/+Pot+ozH1cbFTByxqzN+fo1AwjTlXeYvP4EyPATX74PvM7Pn2rKRXSgNd+Db1cfLJ8KD3VABRbjVZKNdPpg6lz3Mh/NBbJ082iqUyGaq97lyUavsBUFwmA0yygXV+EbZEkZRDlH4E/dLyZWm/AODzx4xTysNxl9GtYrbuntqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qNcW8nj0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qNcW8nj0"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52f9fc510e1so8275631cf.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790272822; x=1790877622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=qNcW8nj0/pDdjrHX+ELCleXyhNSH46+yVTvIwKXf0KEsO2lrNq/+t7BLtAJv/5kwUi
         2AQLV5DG6nqODb54KYJ2Hhy8HyGJBZMXduXpgQLzeebEeIcn11k5EsbWxNYcGPXBaT1+
         /qweihLG7noAHfK+Zx5EEGn0ruWcXq/Gj/S2WSYYG/9cAsBnCCVbDo0GQ6tr6T6jIO6M
         OeOdtj4ZPY+H89quivLjIZrF0JngYycSDR0/nPJVKUYp/eeTnJbocj21+VpbAezcSeJb
         3sQPtmZy9+wwtqCXvsR5dE5N64+9dWM26DJ4nK/0tsdNaizI0KONqxKZScMTirDGCpdM
         wpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272822; x=1790877622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=MdzAOg6GTgffdc8hbtnxPsoTBenzTcyaERrEKC5eaqyTx47dzRxkNdc5mgLQzwWeIt
         RnVRHItDwgUr9suT+RqLN49P0DqTU9kE4JF8pi4u55CPZmCVy10thwt2M5+Cx4wkyFKA
         +lsi3FRaxr+2FPHpkkEWyzo/Pbpw1ZqA1GumYuGFTC//LAIjbw8WQZE9GnBJiq3iByBS
         w/pIOqdkIoOJ+Gqp0LaEVMmqFB7u69CbuTSE1/fZx0HVDgz6M57fbToQNX8r6XYcOdeF
         idYuDbbl4FeNyjtsxwrFc4R/835z0PVnoXWG9C+ycvVrjGcO9Uf+to2Zomn3tGJVuDo5
         08bw==
X-Forwarded-Encrypted: i=1; AKwUvBx/sAF895O7AXmcvHwvJsQjZavSkeXtrUvCjDZnDNvT+tflnV3Omu7+7Rm7zK/QwZxPGbU=@vger.kernel.org
X-Gm-Message-State: AFuF++kM9sVmQJmwkdC0grXqfPvkN9eEN3kHQNQb3n0sBrX2YQb6vB0A
	sFh+zdHUAeu0orkxifbUHqHEZ7s90s8wioscalRvpBVn8AncJQdgEEaPOc6TgyUA/X8=
X-Gm-Gg: AYBFou1XxJzZ15Xy33D3ZkZ01QU/NbehMQi69ClxBEWof9cXJxtAO6aeF1BPpq94B3W
	MQV/JWYf+Ij5V8r69ODtc+earUV2ho+oeGXIJESRjDv0oeWUevnV+THbXX0mqEoRJHz0qPukSl5
	lOs4BYmXKtodrPsZQkV+DLkYFR0ValY9PoQvstpxTSzA/J43rrRI0/nvirJJvwZpbYNhXRC6zBI
	4RzFHJ8kpPzEZtftOAPVX4YNvLk2LmGxoGpF77/iivIFmpJG1BZXr2bft35ibBHY2arYdPeHvb9
	hQdTHj53EkRrjumrZI7g7CQBTMuTI7jY33gq0JtCYD5FzeVBgJ559fSxanMkUgj0L8MURv3D89U
	z8elosSVO8C18xMzWrQdL4XtpO13wXm43HT1xLWLLYBX+1S6kMn1J+3SysqRlfvb/s2PlCwQdZ2
	Pl/hSYDtR3/nIVV91p2cg0mVUjT02DnPsPVMcxhpqq0/mJYtN9FNmm0enJv+eCgiB5oyUwtK1LP
	+VyIlYwbwrm9TBaiBAgb76LR/+UtC4MC0efMsHb8Q4VUgrj1i2jtx0=
X-Received: by 2002:ac8:5a46:0:b0:530:e682:87c with SMTP id d75a77b69052e-5330b6df434mr78501cf.33.1790272821894;
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb38d347sm47450101cf.25.2026.09.24.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:00:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
Message-ID: <arVkwC_wNoTLjRYf@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
> 
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
> 
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
> 
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start, unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>  			  const struct vm_area_desc *desc)
>  {
> +	/*
> +	 * It is not valid to execute mmap actions for VMAs which can be merged,
> +	 * as any such merge would leave portions of the mapping incorrectly
> +	 * unmapped.
> +	 */
> +	if (vma_flags_can_merge(&desc->vma_flags) &&
> +	    WARN_ON_ONCE(desc->action.type != MMAP_NOTHING))
> +		return -EINVAL;
> +

If you wanted to make this unit-testable, you could pull it out into a
separate function:

static bool mmap_action_is_valid(const struct vm_area_desc *desc)
{
	return desc->action.type == MMAP_NOTHING ||
		!vma_flags_can_merge(&desc->vma_flags);
}

then write:

if (WARN_ON_ONCE(!mmap_action_is_valid(desc)))
	return -EINVAL;

And you can write a unit test directly against mmap_action_is_valid

otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
