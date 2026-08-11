Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A141DEE1
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483356; cv=none; b=FlABgKQQalW/b/xQ1bOgaPORoiO0ZrkQueinksGZmO8y3LrNGD70IvIyPy7h+lMIy3r8WW3jYGxlmwMbHKkB7+j0damyBd6ubZwHF6aZEpAGRDoM8oE5X1pWYAsXDnChIJKYi/ASuDYQ1BC16itzJx50OznPgK2jkzdWgMHQXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483356; c=relaxed/simple;
	bh=NdaLGblalh7y8lVJYv0NjjfAvsT9Ho42+c6mULsp9Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlQyk8ufZSvj3aA2kD9b4yBsqiIuNjKEH5nhTguSoVJLsEiiB8f003rSMg6WxYVaf/egBbA3nctSPj/1Wh3j3kQkYWNQxCP05/xPSkzYPD8KLhiPlLsysuFjOb5RDvRdG9T89/lTCVzj2VOhz6YFm9vzQP7NiuRM1vsydZ47uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5TP5iaf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5TP5iaf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso457515a91.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786483354; x=1787088154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hg+Yr9bSAREbkWFulA8TyFK9VZyeo5bqgSMI0IG+zlA=;
        b=r5TP5iafDRspKFczahdfGJLKRRvKfzl9hagc82bQ9hk7Vh6URuNL0fkVTJuWao00eY
         HKLHouLnXi7QNhg954xas/CqncJDw8vJWxVLGz8ZMzc4TSsyOgUTSDZYub+my/QLHagd
         lHinOg4NKlsJoOoWEuxUC66CMZBBMXUKJyikaluDHF1f3dc3hSSsQIL9xJuGmXgSvBhe
         4fm552xZ5ZqmhQ5908lu4oOUIJ7nhxkrjkAtwxG2X/925DRTrA+rUQFxxUnGm8zE3cCo
         pzWzgcK3ydzN40598Fi0FCOXwP2F6QPz57ZCPPs8zfuJ4lAhhXvMft076UjmDBjTRfw/
         06LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483354; x=1787088154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hg+Yr9bSAREbkWFulA8TyFK9VZyeo5bqgSMI0IG+zlA=;
        b=ZneLI5WTaykjdbFKbrEunettl/Cp4xDTCml5Fl0T3sJ2WrJsLkSDX4Yl6zV+PVHgKO
         I3LPytMjOo/gXMd9YOFwOR8Kc8r61uz+ucz7HCOglklmPBW4hgozye4d+rcmklRvNOM3
         UaI59ItoJKfqPRE/viDzqK0XP5IlKqmsV1yWrwIag1lwXFI9YdZKLVZ/KziiEPCBQ8Zf
         LWPF/jg/r0IVvyAtCmt0Lh1ej8m1Cie4T9bFiPwV2G9gp4+9uP8nkCmCHLuk1m7bdTPR
         AowfPjEIGVDGmm9EZaZMUSbJwg7lcRdOBiKRTl15vkhD9QAVHvpC/O/2uE5iI7q/VUy+
         ZMvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrr4HEmTfxcMi/AjI0IRr2f7I140XWNa3ZQIMyvyj6AsXSqR/XEHiTd22qRbVtmwcxNqfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQvwUOkRvYQLUkMbOttOfJUfyyDiJfaualxB2EEQpMr6gAA9E
	MzMjp3dK6ypmyWvRF4Yl6UDVAX16zyZpIyKDEbq6EnfHkcwmTB3D3sLkEd0luId8XQ==
X-Gm-Gg: AR+sD13bQpStpR+BWjzEvAGACQorNsoxTyWGFFNyK1QhvF54sdjqch63Ofur/+wQKIT
	EqmGqocl0c4/6Mz9kbt8oFOsV2eWMvYIlyHA280eHkZUqOypx2KwpZs4o1pyeQiJNmXLr/B5hq8
	UIu3tvsEgaokk620Cj8elWJ8ou1wFs4OYdERIhJTxqRexFrKtmdWqX9quj2RkgAFs+yiZNWvUft
	tPrVUsUh4frHGZqISDeBCr7LES36/4DW2VMHCTfNOwU3QB5Mshv4GzvAO95EVn+SA1YYtrfVC+e
	vBTkkW/hnU+ic8kCWNd8Dsk+oa7v/EVqoMnRyPELyTBb+5x8I80NM+WsEKOO3XrGxUhdXZnn2oJ
	XhB+B1QBDJFvMuQqvxiv/NaNjKgZ9r05njHg7M11g39ZfPfGUupto/do8MnKi4CYiO4R/MqwclI
	ePhhKp7lij1KbR9oeS2yMyG+CIcq3pHoS2a8G0W1qywMZQU8NzJgk8u/5r3oJ4dqphmAzRcYjSu
	hPVFjTC4druP73U0TeDAEWjDxaAvA==
X-Received: by 2002:a17:90b:4a82:b0:38e:101f:c867 with SMTP id 98e67ed59e1d1-392ec672d1emr6461856a91.18.1786483353815;
        Tue, 11 Aug 2026 14:22:33 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f85feb67sm1080532a91.0.2026.08.11.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:22:33 -0700 (PDT)
Date: Tue, 11 Aug 2026 21:22:30 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Justin Stitt <justinstitt@google.com>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>, Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 10/11] vfio: selftests: Add mlx5 driver - data path
 and memcpy ops
Message-ID: <anuSlnCd7NERCp4B@google.com>
References: <0-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
 <10-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v3-76f117ad04f1+28a90-mlx5st_jgg@nvidia.com>

On 2026-07-16 02:03 PM, Jason Gunthorpe wrote:
> Complete the mlx5 driver by adding CQ/QP creation, QP state
> transitions, WQE posting, CQ polling, and the
> memcpy_start/memcpy_wait callbacks. After this patch the driver is
> functional for DMA tests.
> 
> The data path implements RDMA Write self-loopback via an RC QP with
> force-loopback.  WQEs are posted to a 16-entry send queue with an
> NC doorbell, and completions are polled from a 16-entry CQ.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: David Matlack <dmatlack@google.com>
