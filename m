Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A663603EE;
	Mon, 10 Aug 2026 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377878; cv=none; b=MH1RHujFoQVaJOllPd4OB+e3WPmZ+g0MBY7L/qbZCUHzh4Cn68PfAIGzEIEr63pcV0kaZRnofOcd8kxES6wNgbkdhMCLXgpq4RloRMGjIgV7T/3qEVOOYLYaSfisOuKkuAr2lqaV4imSwqqMwaBdChDVE3d+hhfXvjTEjUteiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377878; c=relaxed/simple;
	bh=n+mLg/vAQEvjdoNqXMlghyaYB/q4ECpZogfuKyTiOyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXDDF1/rJA4WbvoO54VKxnZq/DWaUz9VayaiMjoOE91xO5N3jTR5HHBKrzandsJCGOWGTAxhwpfk+bEBfk5PZeAbX/+9JfgpYyG2tO9Uwe4IIv2J1VkPv5xlf9OGjGcDZ/ZQRhIxkI1ZOpOm8nDe7VGobmOkRsIQzT4iqwnQuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=mRnjUosI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1/jFk2L; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="mRnjUosI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1/jFk2L"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FDE67A0115;
	Mon, 10 Aug 2026 12:04:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 12:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786377874;
	 x=1786464274; bh=rx6p32rK5w/1UkIOrv7fFJIIUW+qAWUACBvkYcaCbNM=; b=
	mRnjUosIAY19rSzjW3fpfm/kIR2yFKrCvbGS91pjQymWURxTtm9NeP0mBf7rPsqr
	pnkwRA01RVx9qXapyjqqdJdm9BiDL0uZQrRm86BRtNkNzsdgeWC8F+CAImGJhOqz
	v+oNKG0xFhV6X4tHZNni2zLfSfckTijVh4kttQNDV1N6c+E0yh/JZC73IvhVO50F
	ehkHpoMPFbJXKQMeTsA55IvXRnEvUWAUmiby8tqlMnUoLU9AB4OOdfDp8OB06Jls
	SjC03/xbtxtDr+JLchYw/cTwnsZzF9uyHA4D+OhHTrkjLIv1nSe6QqIBRY21e9/L
	FsCjtXfFtVDsqzN8Cjtrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786377874; x=
	1786464274; bh=rx6p32rK5w/1UkIOrv7fFJIIUW+qAWUACBvkYcaCbNM=; b=R
	1/jFk2LF4Iepxls0p5pdXgYJp+6qlhOi3GPH98nDvTcekkVOr7PVB4mSqBVJk6+2
	iK/R6i9bykjn2PqGoW685JMiDt0VEmbvUCqCE+yAtAl5DbejT9YHdE2g45JZXGSH
	2srcwuB3zDGN5Yq9jmYa0l8ujO9KGA74B1L50hezMJoqEcF+4RBvWUg6YCJn7MmZ
	eKUbCHJKFFZr5jtBO5U3a0dKjql8ekMqx5TE4dTqZ/ODRQnO259x2NUh0UBm3n31
	GuxshTcHkGGk5POgBLeSrUaafQWcM8amERvJMlppYzZzhiTAEPyhkG8hHZ3S4XPa
	q7m/oUvd83l0b9tTOHYkA==
X-ME-Sender: <xms:kfZ5auzWnSl-FxjpcZRnnRYUZEe4pBTfwAzpiwGlAzO0Mzyj0vHE9A>
    <xme:kfZ5agwqSrafgubcmhs0bEJ6m1Zt5GGOX0EjRRJlXV8Zs8_pFnWC6ngPvcSE1q__G
    Dim-NkvoxbeXzMAgrMaH906SV7dycvpCh-PVzVm9Bq3e-GA_rnuWzc>
X-ME-Received: <xmr:kfZ5auW5VAO3B8zig-g7vzrtTeDwb3JtYJVy9jUWfFS36tB5IU04CuENaYR8fw>
X-ME-Proxy-Cause: dmFkZTG217UrlL3C7v6kggE3QFxb0+SyLtqHQoVzMtZvS4azD37bWFffW3eDurys8jfJOW
    Li0aDVvyOhSkfNnCN8Vwms1m2VjJC+vW3BjhbzStvMA5uawzg2mUdmDGJyX2TSKHUAR4p/
    ltjmypHxvsR0kBcmPol/kdVzVxy8Z4cLIS1qsUfB8uLCxSS8CYe6BSZT2UJZrvUobPNj89
    O6GPGBbllxaV6voRh9RCFoKEUu9b6bIe7rXirTOytc3ywBRnvcPhwZkwgYuwqO89TWVqzH
    K6gJEYzGTvxMRyRFeKGEHYyQtSChSJmiHhxJJ0SR0ZOGBUEKg58qh5Iujz66+f9YeX00D0
    EhzbVIYBmFYPQmIkkJM2BHG//ENSD5wtbEeQIq6YZzXWdiaah8M+X4lgJbGlowswqhvJ2f
    pX3Ieha/oh2bKCX2P/5uj5jSwnF6T2iHcDKBZd5BcqmfVOWaFwd0L9UGM3kKGvC16r5JIR
    3cUfQeddbXVkfGG6fUbzPJRCgA2zaIjKN/jAxmE9mDhbhZvti7AQxBT6c5rEPgAAyIUJed
    uhDUyKP826DJbCtQj/mq0qMFx0GWbHiGvCv29XsiyTxzAof0sMKghcBkBlMkL2zNBxyPiH
    Qchytzh65AJOkjr5APiA9CsD1NgmNhqIG5+ikLf0jQaKVli8rK15HvwSOM5g
X-ME-Proxy: <xmx:kfZ5anQw3YxRmvig4_yftyhAP0zpwItTNbq1cd0JMMRpaQvG8m_Tew>
    <xmx:kfZ5amS8k3Cc524BtPxihNR8NlbmGP3-CT7A6TDd0IT9akHl0_02AA>
    <xmx:kfZ5avcBH6zjqRh40cqrXGnRzn_c9PKRfHbHqyL5iHpPCIZLKxzWbQ>
    <xmx:kfZ5ascNI-44V1oLJZ4FbFL4dU8lMFFfoZ5-6KNwPhKYrqIT4s0uYQ>
    <xmx:kvZ5ajOfbFjBIBjxk0q_pgCWWcKrmjiRmuaMZtGIfEj72XtsT3LoFIVn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 12:04:32 -0400 (EDT)
Date: Mon, 10 Aug 2026 10:03:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, Jason Gunthorpe
 <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans
 <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Jacob Moroni <jmoroni@google.com>, David Hu
 <xuehaohu@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [RFC PATCH v1 0/1] vfio/pci: Revoke BARs and DMABUFs during
 sysfs-triggered PCI reset
Message-ID: <20260810100352.1e2004c8@shazbot.org>
In-Reply-To: <20260807201405.3717430-1-praan@google.com>
References: <20260807201405.3717430-1-praan@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 20:14:04 +0000
Pranjal Shrivastava <praan@google.com> wrote:

> Introduce PCI .reset_prepare and .reset_done handlers to safely revoke
> active userspace mappings and exported DMABUFs during sysfs-triggered
> device resets.
> 
> We are seeing a situation where system health and monitoring daemons 
> (at times erroneously) issue device resets via sysfs for devices bound
> to vfio-pci:
> 
>   echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset
> 
> However, because vfio-pci does not implement the .reset_prepare and
> .reset_done error handlers, this hardware reset occurs completely unnoticed
> by the VFIO driver.
> 
> Consequently, active traditional userspace BAR mappings and exported DMABUFs
> are never zapped or revoked. Importers of the DMABUFs (e.g., RDMA drivers)
> continue to issue DMAs (such as PCIe Memory Writes) toward the Endpoint. 
> These transactions are silently dropped by the root port or trigger CTOs 
> while higher-level actions (e.g., RDMA reg_mr) continue to succeed.
> 
> We'd like to fix this by implementing the PCI reset ops for vfio-pci
> that revoke the DMABUFs and zap the BARs while holding the memory lock
> allowing concurrent user accesses to sleep and fault back in once the reset
> completes.

That sounds like a nice, serene solution, but that's not actually what
happens.  Due to the write vs read memory_lock semaphore, CPU faults
are stalled.  On the other hand, DMA mappings via IOMMUFD/dmabuf are
lost.  They require the userspace driver to be involved to perform the
unmap/remap.

Potentially this is all better than letting the device generate a
machine check as it's still trying to run across the reset, but let's
not pretend this is just a hiccup for the device that will continue
running after the rogue reset.  Thanks,

Alex
 
> Note: I've tried to handle the locking as a first attempt here, there
> might've been some cases that were missed. Also, for the RFC, the
> drivers that implement their own pci_error_handlers (like nvgrace) are 
> not altered for now.
> 
> Quick Note about Matt's DMABUF mmap Series
> ==========================================
> While this patch is aimed for the current upstream code, I believe with
> Matt's refactor [1] these ops might change slightly. If we have consensus
> on this patch, I'd send another patch based to Matt based on their series
> for them to include it in their next version.
> 
> [1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org/
> 
> Thanks,
> Praan
> 
> Pranjal Shrivastava (1):
>   vfio/pci: Revoke BARs and DMABUFs during sysfs-triggered PCI reset
> 
>  drivers/vfio/pci/vfio_pci_core.c | 88 ++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 32 deletions(-)
> 

