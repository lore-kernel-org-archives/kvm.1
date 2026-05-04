Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A31361DA9
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931329; cv=none; b=sDaI9gFOeQkpbglDHqBz6Ne6+A9JYoaNfEraNEQAFFA35Ou9cmbs/YriKyBHscj2xnhGzo2MrPCfxrLeJw3G/aMER4L9L7J6GGNFsBRRM1jGDmbC4cFHTqBHPIZbUvHqsLGyw7Vv70L0oUsiAUD4+jC811IIJJIyvP8njv7XSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931329; c=relaxed/simple;
	bh=LEfOvRpQYcrDqT5+S4ih49Shh2djX8a2POcizZgtyEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPcS2S8Swk1kQHtBN5AD2/4Ftj2timGVRTvoq9nlD2Fi78kDmozafx9V/yvf0HnrZ3PXcvKmiVX3HY2XbPfYiB/qOycxMEwlgyjdWNoml+Vai2ycul4qXFWr2JbrKnavLQKs8g7kCdYp/AjzOJdP7aLTcrncS+44rV3a40YnL6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adKnOEFo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adKnOEFo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so18105925ad.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777931328; x=1778536128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=adKnOEFoXz8qKyDlRnCzuv19P42xuHX1j5IMWit1iPOaACz58vLrro7+KtChAqMHi4
         NN0kxyh6ALYhlQPMtHP5elg8BDhKa/STk1m40G4b1+uyyDWrFybAu4s0AKgUWN+Iu+gv
         7drE30Tz3QjQmQj85S9V3p9GxoQd1iJUfjXgMZAmOYsI+0Sb76almUULwwTvJk+ZOfo+
         vJynjbc3R+DgLb6ACaqfjvG62vFHcwsZ6Uv+NEVai6jqefs3VdFCDonF83jqLhSAabkN
         BiK3rPc2fD6Gva8X7ep67gmyVKygxwyPymokKyKyPqKDCQmPUQ1yxsQ5oZHhEakGEH/q
         8ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931328; x=1778536128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vleGyxmKxeO4GNIP1qujBMrg4IEFuG1bs35WPUgfDlk=;
        b=pR7pZNKyf0s9xbh3PgTX6CLoJz87goKgxFlO/xYrDK7Q651MpsoO59Zl0Tmz8OGVMq
         54XIlEHYjJWuP8QXWxvKLuw2tFTnhbbqFKKrCqaZ/Sl0LjhqMUC2d3D3gFa6FFSYomDm
         DESvkHMhUZTzXKcG4HLOMPOT4wENBDpARAMNzK969xu0iliyuY6cmcLaW0sDkdYMNlky
         hmigmNVWGF2QwdOfusDcMHD8zCwwXJR3zVgfbIoPmk6DFYP2gdgLFBxb7ScggKD9EGiu
         J6RUyNraszzti75O4s7F5VZMW6Q4tPD8lP8oA1AWz0m2qDQ2LPQPTqqLR9T+yt14ppGJ
         Qvvg==
X-Forwarded-Encrypted: i=1; AFNElJ8CkXLYhQeacfogxq9RhHzqe01RBqDsW80knklZfJs4J/K6vm/08Q0RJexhdr7WolOYDn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ76WK4CFQbmjzdsekxiimDA8PH7Lj6VSHPxsXNCGgI+cx7EEp
	QP8ucbwE3RpGqxbE+ZzUGrwZCf3bHYQiGfKqmAdWV76zn97V0bQSby0R2OA7Gsl9ww==
X-Gm-Gg: AeBDiev6F+8sJDrQTULw0h98L+0VWlP2bPW0IUQgH2ykJwWSaVz6R/O9VHFmwMQbkUj
	lzlJez3pv5HATR2sqA7c6fiYpGreu4JB6OKHO03EnFOfyLjlxPCnofOUlpZoZcwio4djYHUFmhF
	rhcdcav0h80I8da3FDX/oFxDf9vsG56BqSaIyE8/R7dqaab97J/uC4w6v9eknkk2GqsiiIICo9f
	OHuSW26aUsaoRBP7W7+Fdbc1lf6Tnhr3pSgUF3AYdmFiUGMka0aVBOZg1RyaRVCCHGHrgI6dHqD
	QdK0kco7ZS8Ub0m8KmswGnYbgqI6+PQPvZfIp5cXj+LPFy7rBuhsPNazfUTKeMgsob7cTrZqjto
	wj7IuegGzONIOO/T7G3md4htSs+V+LL9SW9MyrH2iUpJ101c0UKW0X51cExzdejou69UP1/NLRI
	BJoLOJxMNHiucFGjQCmuGDmLffu4sRHaOzEir8/ZUbi7oPcKZuyN3Eh19UMVnnSqfLUlJMzL7Cf
	uGf0A==
X-Received: by 2002:a17:903:40d1:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2b9f260b4a7mr121673915ad.30.1777931327578;
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ebc6sm115903505ad.5.2026.05.04.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:48:47 -0700 (PDT)
Date: Mon, 4 May 2026 21:48:43 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <afkUO56H6KPy5afA@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> These are needed by the VFIO mlx5 selftest in the following patches,
> which includes some headers from mlx5 and also needs a few more
> MMIO-related features.
> 
> - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
>   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)

Is this needed? I don't see it used anywhere.

  $ git grep DECLARE_FLEX_ARRAY tools/testing/selftests/vfio
