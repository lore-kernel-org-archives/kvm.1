Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C033A6E0
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073708; cv=none; b=IB2FGCXzOUfZR/cUSEKm0AeKyvBpKZHw8zWX6wD4r6U77va1QpP7H+SdMXIGFB/Qb8kDIfhDjUCC1NpWGkCJLFMVA3jRgDgsAqu2du7tmR5KEvJHiEsddGqYcQQ+o4z7JJtDb4XbrbUCSe+yn1Ny4AefFVH4s5iE509mrkYxoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073708; c=relaxed/simple;
	bh=pZppoCGkMooXKPApnmHM8gfolIM30zRu7nca3HF0ugc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biVUEwJ8USPiRY+iCdhGoUomTKLqmiFSFufydBaIXxZtMO90V0WEEuAqfQzLVCFhnGzT1JXBY2ZToOLOoGL4lOg60aBLcClakkzpQgvQ5MikVhx89PALvyYBwGfO0zCA8AE9Sh5R4S4quftSbgdz85QDgbqAjLFvwOaKimPGEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egkOhsfC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egkOhsfC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so10230115e9.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073706; x=1778678506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7rCjUTJQsAQHnwXFtsx6ks2Ud7GiaEkWHxltyMvS7k=;
        b=egkOhsfC3JZun8iS46/xjV6yGeW7yhy1ZT2WdQZvACVg63sZWtMdmaiJVmSRQgpnE2
         f7XhsUprB2ujMKl9VtU3Be4UKrIP8UE9tlSj/9SMswMFQz20BscteQLl826U9vXrnkqn
         vIWAWUkwfoPPN+X2eUTcxVlWiK8TkL0JulVUBJ5VxRzzJhGS7g2PupwFxDfL89kIir2v
         /0iASIxoAmbV00OeafTA+r0iTrghMlrDY/2R0BslOHw9S5pnNne/vvQ9dF+Bm2+xJaJl
         jrtGpSMa3d6N1yQ6CXXv+gB9h3B0PRaqqBJOc1ywQBEr5rMohwqb1rCCSHd3/M7M36HI
         eJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073706; x=1778678506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7rCjUTJQsAQHnwXFtsx6ks2Ud7GiaEkWHxltyMvS7k=;
        b=j4bboSQR8938iDlVgekd3Y9+S63QPEMEWo4Wqovh7Cih5YMhOWdo5UsU9RUx1aW/5k
         q0+/Iw+HhAQ7oiGJ94pKPXajcIMr8nzPuwXik8ZAYAnAe21PCj8F9yFRda9/k/YpSVWD
         wKk8sIb5RogRCQ9LfmwdChk+2NyhozE0Jr0DNIhiD1MYBWWFZ1hVEcTRBWaYEVuWFgY4
         MWggxl6ve1yy+WSp13HYKbCoVmrVcqpuA3uHYNQBHQ2cntpWoD+yqMgvPaWMo5pp66Gp
         jD4a7HChr2W83hTf2ElATy9mkMzwHDt+N3FBMQ96auiurpnKwHwcjYwGqQNta7pBe+Kx
         mv1A==
X-Forwarded-Encrypted: i=1; AFNElJ9OvuLdxbDEV1jt9nCX+nurvSdomPh+oEHWRfjru9iD3YrXCj+4Gn1ll9p7U/Nqpj0dAok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8b04VFhsnywca7vVhB9WtTrSIcnTWTjNd2xRWdCfyC42HYq3A
	A+6Ox5e6ehFNS/9buqGqWlKYQgs8lCEcLDTt9WqzHzzc+17jEv7fDM0W
X-Gm-Gg: AeBDietdMcQ9cbQLqaZ5b6COwBX6pT9gqCRhpcfrEcNSByP+J06USobon87lgnNW+pZ
	upXDiJ/G1F5h/qx4Qw0wATB2RN1Pa/6KPxRzcdBxfinSkxhLvm8l4MyjULxtrg7CwKAAOjplHGt
	AgIGYPOtewAqljxWkDy7RL95MWQOatLghr40lG6MGvTfP3kxOqkxeVXARJ5wRGe9UeMXpjToycM
	hNZWAbf2Pd1KFHSxACR2BCwFRyfSVxdD5tyjV4UTW+ourmsPOw6SGS/3bBybEZXJuv48g+W/z/w
	3H99AFUfXUVaWib8IysVuE37pfgDMiwgD0fAwJMpYDIPjRclILqM19RvBvOeNNsO5JzwvOdRi9u
	8dl7w56lWwlLon9EjaJRxm8MtrRgGsSrrlyNOCSrSgQw9c2fcbCb8uldS3kqINPhWZdoCSY/hqD
	hrkjLLVNEcn6CCFUIbURsqpItLKMa3IVsBolttZiV2Q6417OxFGwTY4ZGVQN7rxiy/EItc
X-Received: by 2002:a05:600c:6612:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48e522b71f2mr50112055e9.10.1778073705537;
        Wed, 06 May 2026 06:21:45 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:89b3:e462:e9ca:df27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53895f0asm52221165e9.2.2026.05.06.06.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:21:45 -0700 (PDT)
Date: Wed, 6 May 2026 15:21:43 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: kvm: return SBI_ERR_FAILURE for PMU shmem OOM
Message-ID: <aftAZ6U93qCXLcSc@osama>
References: <20260415220930.287592-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415220930.287592-1-osama.abdelkader@gmail.com>

On Thu, Apr 16, 2026 at 12:09:30AM +0200, Osama Abdelkader wrote:
> kvm_riscv_vcpu_pmu_snapshot_set_shmem() and kvm_riscv_vcpu_pmu_event_info()
> returned -ENOMEM from the SBI extension handler, which caused 
> kvm_riscv_vcpu_sbi_ecall() to abort KVM_RUN and surface the error to 
> userspace instead of completing the ECALL with a negative SBI error in a0.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  arch/riscv/kvm/vcpu_pmu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index e873430e596b..f36b099f447c 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -435,8 +435,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
>  	}
>  
>  	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
> -	if (!kvpmu->sdata)
> -		return -ENOMEM;
> +	if (!kvpmu->sdata) {
> +		sbiret = SBI_ERR_FAILURE;
> +		goto out;
> +	}
>  
>  	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
>  	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
> @@ -480,8 +482,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
>  	}
>  
>  	einfo = kzalloc(shmem_size, GFP_KERNEL);
> -	if (!einfo)
> -		return -ENOMEM;
> +	if (!einfo) {
> +		ret = SBI_ERR_FAILURE;
> +		goto out;
> +	}
>  
>  	ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
>  	if (ret) {
> -- 
> 2.43.0
> 
ping.
