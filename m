Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCE36C5B2
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620948; cv=none; b=EWAZxvqgaPD1vfXOJClJDil0o3dkQHUcvhgDWSOBhoTAxENwnPuUsY/wCcxtf4Cak6rAudJK25b43vQv1057EiHFq9sKxscZrZ0q0MCmj/VUj0fwcBJCbVgznhL/vyzoNNTHUJ9cfAA7j3M1SATUvfwxZGjn5Jwk66uUQ5nJwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620948; c=relaxed/simple;
	bh=YM0ACQYf4Uc569a6YEdVY1akpC7Ocd6dIp30Kywl9D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAdkzOLWuY5kxQ2b1cA5bcO23PxkjHJzsJUsLQIUjrsSROKPEjwaLNxI9oC6RxuHATW0uEfwcM6WmFlcmRrfhHvp2aN2RcXyxdN4Gdjbx9s0Qjtf4j6LEd4BaS7V4O1cJyAZm5mbyj/ycDEzq8YjItcT55WEHjDnWM1p2+yeuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YuPSKEtG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YuPSKEtG"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5175cb5946dso36602411cf.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781620946; x=1782225746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6erokdFXhtewZdSXNIBIfXL9rXfMqxj/dhqBref1OI=;
        b=YuPSKEtGWwAX2dr7GhjKBukR8iIzGNgD+mBzUWYD1gh0/bkKJaeLCEjSKoYBjNFzD8
         8XuMcmimW+pyktaxepXdUM4Lf5TZPdQMl+LPsvjhIDg1WAKhfm9KHCCiN57wXNEMbNyr
         5KagG6TStQhsNp202JIscHibg0Ej9k/epxkedGJviwA5lSEuGAtjQdRs3LDT2qe/D8dJ
         6Yt/MstptTF9GBYJwf+gFj6edEEI9NwXg26jlbYgjKh2Oj1IazhLldKblbaxSIy7XaJN
         fR4UsyOFKrLH8AKYDlBgXTgDQea+CrdsnPOAuwq3HkO2QzUQbu1ps22PSedTiEmNPVWP
         cfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620946; x=1782225746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6erokdFXhtewZdSXNIBIfXL9rXfMqxj/dhqBref1OI=;
        b=ZVThjZNVJac+oZc2uN4xOpAwT+X2shbOEydajnRa+Seq6ryGFwyp0cAhAwuZSEUJVv
         tN5zF+EuUh+MrGj/PtwR2WhHM3zUBEHf+GANPbRCMkYGlg6Xj53KAamgtm9wpWtmCJje
         nyoL73Cqe/HE00VR3l9aeBY9jjeN/Wq/0Vs47cOl7VIe8kKdPusqRuJvF6uli37q74P6
         HrxmuzKNWYwLfqpb4KvxWGVPGjDbIB8TLW84Knjam8ePcrYZfvpo9zUq+Y5KF1SF4d+D
         7jDIc4czyWgQ0eL0E4LsVGU4yfO7fd/rPemgsMnCAij916KF1tQQL0mWCtVzW5AdwjPg
         NG4A==
X-Forwarded-Encrypted: i=1; AFNElJ+mh6sQOFCd+ylPUe8ZCTBtndRS8Yjppxj/tmQc4S7ni9J4fg1u9kybj2ckEzBVisT5zIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcfz6BJmkIw9ZISKTNRNVFHwQVXjag5aItZfOSbwPwChc+8PNh
	XQy+RB86rJBelPy0/aD5y1B2MaflqcBu5CDdIeG4eaJdye5ewO+7ja3FR97074M3sTpx9efdvmm
	/5Pb9
X-Gm-Gg: Acq92OGAzokX7WgRe+dY6NNQ15pnZtLPlwNcxXTqDByIZ42peKaihPs/hdmnIHrGynR
	NQBuNPiuial63nukSrI4LyFf0Obe6BiZBc1NCS/hM+GEK4gYkJKxOseNiWzsWkstF6s3dI/uCCJ
	X3+TByhNtF1HqnoJevobRtINkHhADXQJ77to1AHqXKVW4h5gZO0GZ77uVhHw8RJkQQL+HI0q4O6
	WmtLfHGXguX3R0cc7qC5saZ1IoSzbL2hX6GclaKDaKeBtbnJhz8wb9vkBzRj4KgaZpQslNQAvCQ
	MrAXVenff09DGKn3xzmoGPjVycBFYXBosw52J3g9InyXe6QwiBJ7sOW4TPhZdQEmphPu13xOnuG
	g4R3sXViFgJtZzqjzmZ8O95ejuw2YgkxPAop8IS6qSkMWxMCqMgYYjYgDkpVy3YXSlrIgCU5WEE
	qt8gi7cPBvUqwkpzCbyPv98KI71Sk9XAJlwiiu6PeFmq/Lho5QxNItxyhOtYvYmAkg+shVHgDnd
	R+Orw==
X-Received: by 2002:a05:622a:407:b0:516:e031:932e with SMTP id d75a77b69052e-519916c7ad8mr52017471cf.4.1781620945940;
        Tue, 16 Jun 2026 07:42:25 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb6442d8sm140759751cf.11.2026.06.16.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:42:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZUzg-0000000GHIq-3LTv;
	Tue, 16 Jun 2026 11:42:24 -0300
Date: Tue, 16 Jun 2026 11:42:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: alex@shazbot.org, helgaas@kernel.org, wathsala.vithanage@arm.com,
	wei.huang2@amd.com, zhipingz@meta.com, wangzhou1@hisilicon.com,
	wangyushan12@huawei.com, liuyonglong@huawei.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260616144224.GB3577091@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616104621.41915-9-fengchengwen@huawei.com>

On Tue, Jun 16, 2026 at 06:46:17PM +0800, Chengwen Feng wrote:
> Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
> to steering-tag data to userspace, resolving the concern that VFIO should
> not host CPU-to-ST translation interfaces.
> 
> Follow PCI standard binattr framework: dynamic visible group, fixed-size
> 8-byte packed uapi entry, aligned offset read, root-only 0400 permission.
> Refactor duplicate ACPI DSM logic into shared tph_get_cpu_st_info helper.
> 
> ABI: /sys/bus/pci/devices/<BDF>/tph_cpu_st

I'm sorry, I really dislike this :(

Structured binary sysfs attributes are pretty much against the rules,
I think using sysfs at all for this interface is a bad idea.

IMHO the VFIO version was much better.

Jason
