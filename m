Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281B31B837
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069814; cv=none; b=d6AtMW7ov8Z+cFbEDZLlYiqAMkUyOc8PIY+6a1e0dLo8Kyv7lCEIDX85UNSpYp3s4qdIAnHM620eesxMSVhSrX22L5a6Q1UULuvJgOcGBB9yoWfJszGlG9skkGHjJC1YmPY6VScBTluLzH0LrPLMPYLmgnD93CrmyGT24wu8P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069814; c=relaxed/simple;
	bh=eL5PFbCsfKV8bsqpSaJH5QLJQHcATd2jC+a8M9FhqI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiNR8j9UYbW63bCOlnhf0qAhykKIYxdUvs7pIf2jL7ZHW9C2A2unh18Y8FcNAScEiqYFlMROoJ9NNYQMMwz1QDni0SgxU44UkYsxvi4txwfCAuhPY7O9eTEZTRTQhDhsgnjgrLFLEePn6s15tVwG7UExROJWN0FPc7zJGYUi6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jx+MA+Lz; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jx+MA+Lz"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a154cc6a48so91939946d6.0
        for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777069812; x=1777674612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcU2RSfhC3nYqQJBYqc7fU7L29k4M7iAEBMdP6aAbW8=;
        b=Jx+MA+Lzrifxk+t1xLmc2hjDPfafCy7GNwLrGTIXmDEq3Sobw7xPdxwn+80QPYtnQc
         GVl1vGmtn/p/hhlrgDioAbHUrdZc9OoHNCrLtcGH68AGLgvfKhghIQvSDw/LYWC3Ff6a
         BEZc06z2VIESfBh1+5JVdde6qzWoFxnloMw4W0j39hsde0INN48Kpvv0HFLVqq8/v5s3
         aU27oXcQr6cfwTEKA+L7mHN2Z1QPBlA+l2I+oHCG2slOPQX5V5yMl8OdXw6C8aUM7Vmv
         2KIvQ+njUcUZsVM7Y2madKMtA2thJqQKXPWGtXbjuKot2mO5CxrjFqeaFZ2YRbYnMc0q
         Krcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069812; x=1777674612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcU2RSfhC3nYqQJBYqc7fU7L29k4M7iAEBMdP6aAbW8=;
        b=Ul1hrjgTtIHrrn8MpclD9YJlu4ehzbjEpsR6laQ/Pu8/8AFJQbGwLHiTAVLNjYV5yB
         SAVqX+k8WfBKHOVnEu2FoTU8eJ6zNhw+KA8CukdL9WdVLeq/b4JdGsxUye7GX/4Ygh5Y
         Y4lMVDsCEJUaJPJCUpyYXB++r4zQ0VbiZXOIB94blU/NLvDGvFyNYZjOz5sMWHdDan5o
         7NmTy9M7okO2gVBzsloWE/4+GLndkq+0Kb/FmGCfUkFkJZqCtt2FGrELQspIo4xuVGWy
         dwRMhuGmwEjBgUbr1ftULrFDsdhcCtKGQW9e6yQXvXjEDvSO92TP7cF+GsekP6HMhUak
         qonQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Pz0stVTYBPNVzHh45dyLiD+k6PEV4jskTEfC02th/4f0PK7t2m9k3EYiPNWcjdFOKp6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIb3Nf2JM+ENTCcEtU4BoY16qz5GubVWJoKIAMKv5zZMTmMYIF
	3hiCn7k+0p+xJ1xbStvKdz5gR0mnlTkv4ye8+v0++MvkSonC+GWJykgjWlUnD0iaau4=
X-Gm-Gg: AeBDiesVdYnZNnuH/B6Y8eurNCMmH6w/wcKsj9noFLkhcMQ+o4AZofQwFMno5Oky2By
	ylQtpskGVzwio2Z/20vbeqwGeQeW1UtvR9uHTKayaS+y+YWhYNZ/1EQE2lYDX0byVUNx3WccgeA
	+Mi3Uk6sJ5tcsHFN5SPdNSnZ6snKto8V4pvJjznTYRYPH0kW1EvLJTNtiXbzrqQOvvHk6jVEc0x
	dwP+EgSUDBce2eEW6WzhpPnLOQDeemwX6il41YQxlzuZMLr+DaMFZLtDPy17cbUdnr0LiLqSuF0
	VC4af3ibi/vZjz1/fQHs08c2xo77IEPLl1KiW6mKg4qgWybTC3FG87ftoC4BK6pLKL4K1VPCz+H
	Q32jn2fcqZMvUd7pWwTg25BvflujABcSWD9dOb0Z7wBz70cpDGNJ8fX+/AGk9DHbgTSpsSYOPfB
	/niQEkf7rX0tbwdfjxQsMif7dq1jVBdmD+sbTRGmKKIUFg/NSTzfxRJA05Ayhy22ioCZzbH31jR
	0XTT4XfZ0qEfPJU
X-Received: by 2002:a05:6214:5294:b0:8b0:2b9e:9636 with SMTP id 6a1803df08f44-8b02b9e9cd4mr493356496d6.18.1777069811988;
        Fri, 24 Apr 2026 15:30:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm196779946d6.49.2026.04.24.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:30:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGP2I-00000004pmY-1uT3;
	Fri, 24 Apr 2026 19:30:10 -0300
Date: Fri, 24 Apr 2026 19:30:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, alex@shazbot.org,
	wathsala.vithanage@arm.com, helgaas@kernel.org,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
Message-ID: <20260424223010.GB804026@ziepe.ca>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
 <20260423145915.GG172828@unreal>
 <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>

On Fri, Apr 24, 2026 at 09:25:54AM +0800, fengchengwen wrote:
> 1. Why userspace needs the capability to control steering tags:
>    When PCIe devices are fully taken over by userspace workloads like DPDK
>    and SPDK, only userspace understands core binding policies and traffic
>    distribution. Without this series, userspace cannot enable TPH or
>    configure steering tags, leaving built-in PCIe performance optimizations
>    unused for high-throughput polling I/O scenarios.

So far we have generally had the position that vfio should not enable
device specific steering tags because it is impossible to provide the
expected level of isolation.

I think it is OK to have a unsafe module option to allow use of
device-specific steering tags, and it is reasonable to have an ioctl
to query what the tags are for various CPU scenarios.

It is not OK to allow direct userspace control over the safe TPH in
MSI-X mode. The kernel should continue to exclusively control these
and the userspace should request to load differnt things into them,
presenting some kind of security context to prove it can use the
things it requests. It should not require an unsafe parameter.

Jason
