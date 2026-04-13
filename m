Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161133A0E80
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119602; cv=none; b=W1OYk6Oya2SQv11nzFBdPhHhGRE3c5ddke83aBKEZYaXx/r4gFHLZ3M4b2NsCdznZzl9txZM3BC8/IqhlH2VTp3leH6Wqh9vdqNVXJ8L5lx7kwbU/l7gl615Z//WG64sBAHoLMePvzdDeRIVZ7T0X4y2KElptxmOuA2Uk9l/GeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119602; c=relaxed/simple;
	bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgkNIfTmwJ66XRWGpiFYwQPWzvM1umXfBHHGtonZ95gm8MPVLA+zrZn6TlEG7+kSxJDfX4tEWfGUD4I4p0LDXNNtqo2rtngrcArzjmBkhHI7MyWvhD+Xy0xBo6pbPeszMUKWfEPvreQUiPnB/QqIYt2eHM1Rc4EAaG6xpsHhhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UhfLOUiP; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UhfLOUiP"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a3342d301aso50633176d6.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776119600; x=1776724400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
        b=UhfLOUiPlRQqY06loItczVdfGR2eN7c719ZP1dIr7H/8jBbyRNPuVFGfJlCpNzIpCk
         5XEAAS43++frG2nP6VS4l3S/iBS43a5puDK0gLoCvxVQVbJpl2cOq2a4Crx61Iq1jQFi
         SJHVIXrpJgSarHKwQUbNyPrM39YuLStKvOzmsKEmcGWIwyE1p8efZvxzc+FYGisjO7gs
         KLaqL8HY3gXA6GbFSIZKJwODbT29QV6m9+71SE6eUHY4EdwTKrg707WwCkP67nzIoz00
         FYc9TvhOEz+s43eaRsoXPWl4I9kKl/M/amS9ns7tEnzxMbuKXBlOwIobSTzXtTVwScef
         YHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119600; x=1776724400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwW/1XbIw/u2ktOpP85VLCvfvyEmOP4GLErArAy8gGw=;
        b=XySMY+K8xP2RAV5qYXL2DDmeyby87SIvojOOrUzmeqhlj9m/jO4th/MNkIJROON5Hr
         ku/uFpcVZJs7nwc6B9/QP8neTDX04PbLjI4V7DIhZaizWViJQwD5pYsUmxmzexMxgwRb
         wtYpCj7FM6hRFef8O3fK5fzhIF0NeN2UEqme5barP0obBQAAelwcUR7Ge53PJ2rWJiv3
         DqyxLLMb4Ikmxd8Ci4DRWtbU4tVkgw5JLBha3Ee2rhJfRa2eGRNX3jbM1lyV5BXkMl1f
         5zulPzC99V/9HLQLchfU+ch7eFyk19mpGmGKb5s12JkEPFjZ9lkbDfVgVord/lgAUcLY
         Yfiw==
X-Forwarded-Encrypted: i=1; AFNElJ9g8DQcYNL3EQ/qBOIXeKOsY3Ms3NA0iZyNAvNwjLrIoC3x3VCaXOsj0Z92VzGd+QtNQEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5qC0ATPoWKAs79CDGRKG3bLtBVSUa74rR8XqHxgIDErzRs6H
	yovOcPpL41rNvv12Tmi3neGCf7gEFYjc/GAC0adJxo6uJp/UPAWpPVRk1reNk40/OBI=
X-Gm-Gg: AeBDietMN5zivbfgL9ygtqnLQcm0OgEWAsEArWzHw4KVyGv4/Pct2PmUQuhDcwf79vO
	BnuU53wAS4wxqDGLrjgp+0oRgoMorHvLb8+a6ngw0diEiTdonT3dGOguhEC59wJoVKy/dC1M4S1
	Ys3+o+gjnxL0f0ckg8qOdZGRZh86v6vzbr0ztwEERqtZr/t46D8lgLuVHHNs9TIPMaIn7cVUAaW
	l1EWUS29Ug7BA4OQB1HC6rCtz4cChXPkiIv02AbGmFDgMRUPpGiX48M1FiR/M1Ejd5Hxf8EeTLH
	UrBmdnSUamJcinO1AE9UsQYvwGFCPthRzcvVHhMJKrBmy/WveUopeqSlqAvtw5T/hFziaFkirCe
	PomfRMbX0boajNhh2qxOmjNsW9f55rHUvHHDjeowlBU2How76HqRcurAFABTpfD/AQ74zoa8JV2
	G0/7Kn1aRbitsEUwMTRZk7q3iJzQRoq/t+WLAcYYazS/XoCzvrnDFoEnLb5pQomvM8nJKsaHFHa
	jeEhA==
X-Received: by 2002:a05:6214:e88:b0:8ac:8cbb:49bd with SMTP id 6a1803df08f44-8ac8cbb4d73mr219764146d6.38.1776119599895;
        Mon, 13 Apr 2026 15:33:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a45552sm105040816d6.20.2026.04.13.15.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:33:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCPqI-000000075qq-3S8b;
	Mon, 13 Apr 2026 19:33:18 -0300
Date: Mon, 13 Apr 2026 19:33:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260413223318.GR3694781@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
 <20260410141652.GV2551565@ziepe.ca>
 <adl2QX6gra99bkOV@google.com>
 <20260410231650.GD3694781@ziepe.ca>
 <ad0b-5aRU172-Od8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0b-5aRU172-Od8@google.com>

On Mon, Apr 13, 2026 at 07:31:22PM +0000, Samiullah Khawaja wrote:
> Yes, we use the collect walker during KHO restore of the preserved pages
> and also during free. But if I understand correctly, the collect walker
> behaviour changes based on some FEAT_ flags (like SIGN_EXTEND). So we
> have to be careful if the previous kernel was using different FEAT flags
> that affect the collect walker. To handle this, we can just preserve the
> u32 features from struct pt_common and deduce everything using that.

It is agressively not stable, and even new kernels might not support
the features old ones were using, so this is a bit dicy.

You probably need some, but I think I'd be very choosey about which
some I preserve and which come from the new driver.

> Thinking about it more, we do preserve the top_level, so that could
> potentially be used to walk over the page tables of these free-only
> domains if we just set up the pts->index and pts->end_index properly by
> initializing the range based on the top_level. Are you thinking of a
> similar approach to walk these free-only domains?

Hmm, even the free walker requires computing the end_index, and that
requires at least vasz. eg ARM will compute the number of items in the
top level based on vasz to support concatenated pages.

I don't think sign_extend is used in the free path though.

So if that is the only purpose then yes you can probably get away with
nothing, but you have to be very careful to contain the restored
domain to only execute free and nothing else by removing the
map/unmap/etc ops.

And add some dedicated self tests (zero pt features and test free) to
simulate it.

Jason
