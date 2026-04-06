Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E04280CD2
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517016; cv=none; b=M8hop4Zcgz4NOp34KHTmBm6xL3tNypn0vkSAadbf8d3yAemuXfhElJhSPoTPZPpZ/DfFef3rdRzJhPJZXbaPQtda02TfU3pTvP7/620cEKZQdk8fG3CzZME8RPBMsXLZCTLY7eeinIPjNQM4ongL0MHlqCWcrALv1ODANZUZbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517016; c=relaxed/simple;
	bh=dYtpan+NvrAKEFDMvshQt8e4RqOzg6I2Ga9L5YfFh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agcw4+SYsgYCG/tPFJkQfSQHDcDASUba4j/JuESlpcqSw2uxyJOaJq1AiHj8e+D9t4/d5W9qu61o5FODftL9rThotEClIMaJL9a6FzdAfea3Fxkep25RK0UAZBpX8lWJv8wGmltcP0qWvgiSJaghiqOsrgE0HyoQKhHZiJOYhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKhjNPaR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKhjNPaR"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so2154413b3a.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775517015; x=1776121815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcLs8Uhgq4/4jyOLHzTqNDrLOx4pblWqu6j4JVjyvgc=;
        b=rKhjNPaRXhrr3iuxECcZbb+HAfI9RKWEYMPyEgMRHHdXX9zIOPVZDr0PbWGcaC1DkY
         kljrfEDHIGuX8yjzrZ3gb5NUzUJGWi1S/Q0CGqMpSYTvqeinq1p2EKqC9VPwxyhbO23B
         BNUMrA8sMZU0jntTzkOoKukMkoA69sKpjV90ztV6Xo/6XJcqF9w1Li7riFD9L3HfCGnK
         bIY0TvkTTCnuSEd36BrAhBuFLthJjQHsIcNlpSuE6OUsYucesAfrJIJEZiqFjnDv8lob
         sL/uc1NDumuO6IiesigqRAH9cSvHPOUIcX/q7wiwx9/r08iHpr9XCBL0Ho7RqQ7khUNw
         HktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517015; x=1776121815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcLs8Uhgq4/4jyOLHzTqNDrLOx4pblWqu6j4JVjyvgc=;
        b=nAaWipb0Ef1uoYCNdGgOueCxgPPbsFAzIX/z6jCnOaaj7bNoEksHkfo9VxSUAZBl8L
         zB/jlV5ul4k99pNSW7e6FyY36kyFqUrdO/jR+wMfjvFY/h8dzLv88Vc0hn0Ol/mpaLBF
         WVPKIyn1VnipxsViZfvkb9/8jA7cQpSXJ7H/liq+B5+yiGO6RwCd7cVL8JT5yUbRlWmV
         g5o9ONnKcd8a137s/mKsKtF0zySc00EVqic49fQOK7aY2MYM77D0qr21aUvXPAGEJpuL
         wUUzBIhsU9JCSv2uQwpHLPnXQjRTm5eBOirKdeiHeisAXdE1eXnTeV23qVBHnTRJLnzo
         8Ljg==
X-Forwarded-Encrypted: i=1; AJvYcCUDLTWpFV7E6T6Dfj28Ri40v4AwLTHTl5EZtIGLkQOLi+RkloDM1eHr6rJz0RCB6/Z6W7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5M226yX87IOGmJ6lryFze6oud4u1ya+U3hnlQAGipf4svYzk2
	EL2y2eWAG5CgB45c25EkzxgXuHpNZNEwpyrraOGus2f5ERmOoWJ3ZTW+L4h9Z0Uhvw==
X-Gm-Gg: AeBDievja/9t9ScmdumdLHmRoLx2wYap+wzjgpv/G4RepzNzZ36pKLFj9n+daK4rwUX
	blvjjO8kd8poNlQsaJkOiVu/IfG+diUzzZDn+mX2rGJ2rz31Mg+edFBAgiDrzpnYoY+CMclCe8Z
	4RSjwQG7NipfnpSIMH37HfkcBOKGqYDvzZdWVTY004/k75Te2Sai75ZDwbYRcUK+VuKLe4xI7Qg
	Qweg71CPyhY37LMXv4NX0AIxF5dPL+o0ATWKa59wdbYDHPcKZLdZZfgdMYrMbuQgd4mhPrqf6Fk
	zQC7T8Vy9R1MbV3BKisv4E7SUsK+YQr/SwrDTxk75dZPV1gVFYZkpFEbkNA7r2Bm9eTX0PUDqPZ
	spvVCDCsJWki8UQn4ahTBYCbZKCu06CEC5U36x0Qqu7WD6FJVH3KD07Drtvt6uI51JXGDSebX9D
	a9R5Q2B0c1v9dyaTVLB3WUJ+J81Vbln3LJhiH7fPY3U962vA93z9mM3D+upbi1iQ==
X-Received: by 2002:a05:6a00:14c3:b0:829:88e7:c88b with SMTP id d2e1a72fcca58-82d0da8edccmr14036237b3a.19.1775517014393;
        Mon, 06 Apr 2026 16:10:14 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbf6sm16276871b3a.52.2026.04.06.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:10:13 -0700 (PDT)
Date: Mon, 6 Apr 2026 23:10:09 +0000
From: David Matlack <dmatlack@google.com>
To: Rubin Du <rubind@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] selftests/vfio: Add generic PCI command register
 helpers
Message-ID: <adQ9UUOy9-VmGIY_@google.com>
References: <20260403234444.350867-1-rubind@nvidia.com>
 <20260403234444.350867-3-rubind@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403234444.350867-3-rubind@nvidia.com>

On 2026-04-03 04:44 PM, Rubin Du wrote:

nit: Please use "vfio: selftests: " to match the rest of the VFIO
selftests commits.

  git log --oneline tools/testing/selftests/vfio

> Add vfio_pci_cmd_set()/vfio_pci_cmd_clear() read-modify-write macros
> for PCI_COMMAND in vfio_pci_device.h.
> 
> Signed-off-by: Rubin Du <rubind@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>
