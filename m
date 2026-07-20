Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD26477995
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569596; cv=none; b=MJo4zF3EXGWf1VxWb3nxF3/1kPk8BG364GPnBfvL5MvoVeT8wnN99/BTdYHBoQurrPtVr+pyTQFB3LCa/8blSErzdc5R9bWBMaQvHy39cLtTvsOlyJYha/hQ81R3+gq14Xj0jCOUb1fMNef7OM4DfOH+8SWT7GomPvXlWlqGR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569596; c=relaxed/simple;
	bh=gOLamp6WhhZpTe5dHXwQKJ94j6OmlPwvAw33r+2AFLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEsCRfHtby64dERu/24lSjHnGQUPfAiaP/KLNCqUAllGYw6sHFqeB+GSmCTW0kPcplezCCEyyEu1TCD3WnRW+LZSgvsYz2cfM6MBwGR+VItlUAtflJGa30FLtZxcuoJruO0OMGV4NmFs4wtEFPNXJ29/UP/U9cItwkfpV6gzfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKNvAwu8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKNvAwu8"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cede6375caso351025ad.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784569585; x=1785174385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WSe3gsPdGWsi9VQkqamZmsXN0JAunSEo2DS5NUyoYNE=;
        b=eKNvAwu8VYSfZuuC/Vk3kE52DGxf2MNU88kDbgdWEDyWR2TTEQbIMuHyc6RXJtC1B3
         BamjktHk+bpYZC9CT6s2ZyXaeumtU9Hp8OorYtJm5hGegmY+vIU8w/UBYQWvaZg7lLAl
         C1F0G1NV2S4EW776ex9Xd94nifX5HDROHJ3Q+OcW3a9o2FmnhYt0SUwRo6+9YgzU17qe
         2U6cIcpjm/OcnS/2k+iKHr3+dy2VpUap4SYL2j1tPYEcB+GrlHGPboio/LIZBHzYy7tk
         SRfKkdONbEt4ghOzpb0afuFtxFCcE7mSAPdeDRGNCayvH1OKBWKao2Mwflq9pZ4/pmJm
         BdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569585; x=1785174385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WSe3gsPdGWsi9VQkqamZmsXN0JAunSEo2DS5NUyoYNE=;
        b=FPU3Es0ZhPGYhqo7/vLNiKC7L/vG5ctOruwByUHmffnjKhYkf/9CkmG9aIBKJbD5/W
         /2kwr4vtFimXu14o8Gkgju/Iaz5RbMaDdvFwF+ljLZ+6HklZlvT2vyQg8z5JHtt7XrtG
         ZDS0Pvc/ifvPqFKrnxBTDsz/bg6AwGt9E1M7xBvg3NZvvz9dc5Hjwoq3dnLZ3dTpm0v2
         uX8TiR85lXqWrgvk1Rc6Kgan+/otIlPD2wTJLBJvgZ/pMivdjXvZ6Vv2h6rstXWcG4aE
         1qFkps9IQjNf0Oa96BcwgSdwHUNKm6ofJxLtDEHNJ5YkOR/SxRqOu5nVIBiLub+pVOuT
         3TeQ==
X-Gm-Message-State: AOJu0YykpkqwEHuc+fmuoSOZfYLbIgXzTpkR2zY5gnNBbQu1R5NM0XWg
	Del5dV+nwaw/ZiEcFawaA5ajCaIHsC7/woJehEdYh3N0rKqhwkv/STB3tGRJFy6lHR5BXoGnlm/
	DIqbNDXRP
X-Gm-Gg: AR+sD10MRRdYAPhuNlWDV6FULS3XLxl8p9o9p6AxM5+WAt9FbEIr6gCuE+xRQ+fA+QF
	6ADCG1aCpvyQef+cTkQPn3ln1t99iF5xCv9ZAkBai6+Jjtf9Xk9HQJTJ+75dZglObT0VX7KsJq2
	SQkz7Phb08w8yTkbQQ/tcKsNSoGYg6YQhx3zbckQEJrkh/t+MGLacyuFJYtIhk+0VKSUTdtb8vM
	vOqFoYHvzWdRXYxSqavZDgQQvCTPTAvmzZpkrM8MXrEek1yHG/nXiRLQ4zIEza1Bjg4F/FJPlUM
	pv3lKmcUd7Rn2emKz60XdgUpWcqjiLx5RCQgD2dQhN7YdIYY+dc5tjlkg3eXqIQVb4seJW4OTh9
	GFoDmq0fG97ZvXN4Vh8bDOkN+OegoUOjrGNXePoCZC95LiP+9f+N4dIAryDeJxLrMynYPnRGskC
	eMwfasrQcghMFIh/tUDZefX5SO2AkbnByRbHSUxbI=
X-Received: by 2002:a17:903:1984:b0:2ce:b436:272a with SMTP id d9443c01a7336-2cf7b500832mr1906865ad.3.1784569577823;
        Mon, 20 Jul 2026 10:46:17 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e022d6e38sm103524b3a.11.2026.07.20.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:46:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:46:13 -0700
From: Vipin Sharma <vipinsh@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v5 05/20] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <20260720173305.GA1381701.vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-6-vipinsh@google.com>
 <20260714152856.F239E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714152856.F239E1F000E9@smtp.kernel.org>

On Tue, Jul 14, 2026 at 03:28:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The Kconfig option VFIO_PCI_LIVEUPDATE depends on a non-existent configuration symbol PCI_LIVEUPDATE.
> - [High] Calls to undeclared and undefined functions pci_liveupdate_register_flb() and pci_liveupdate_unregister_flb().
> - [High] Masking -EOPNOTSUPP on FLB registration failure leads to a double unregistration of the file handler and potential kernel panic.
> --
> 
> --- Patch [5]: [PATCH v5 05/20] vfio/pci: Register a file handler with Live Update Orchestrator ---
> commit a3c1a8c69f4b2c27d2e063cca84eb003906e3bbf
> Author: Vipin Sharma <vipinsh@google.com>
> 
> vfio/pci: Register a file handler with Live Update Orchestrator
> 
> This commit adds a live update file handler for vfio-pci device files
> with stub implementations. It registers the handler with the live update
> framework and PCI subsystem, gated behind a new VFIO_PCI_LIVEUPDATE option.
> 
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 296bf01e185ec..c12d614fc6c4a 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> [ ... ]
> > @@ -42,6 +42,18 @@ config VFIO_PCI_IGD
> >  	  and LPC bridge config space.
> >  
> >  	  To enable Intel IGD assignment through vfio-pci, say Y.
> > +
> > +config VFIO_PCI_LIVEUPDATE
> > +	bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +	depends on PCI_LIVEUPDATE
> 
> [Severity: High]
> Does the PCI_LIVEUPDATE configuration symbol exist anywhere in the kernel
> tree? It appears this dependency cannot be met, preventing the new
> VFIO_PCI_LIVEUPDATE option from being selected.

This series is built on top of an in-progress series as explained in
the cover letter.
https://lore.kernel.org/linux-pci/20260710212616.1351130-1-dmatlack@google.com/

> 
> > +	help
> > +	  Support for preserving devices bound to vfio-pci across a Live
> [ ... ]
> > diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> > new file mode 100644
> > index 0000000000000..803528c9f1b27
> > --- /dev/null
> > +++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
> [ ... ]
> > +int __init vfio_pci_liveupdate_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > +	if (ret)
> > +		goto err_return;
> > +
> > +	ret = pci_liveupdate_register_flb(&vfio_pci_liveupdate_fh);
> 
> [Severity: High]
> Are pci_liveupdate_register_flb() and pci_liveupdate_unregister_flb()
> declared in any header or defined in any source file? Building with
> this configuration enabled might result in implicit declaration compiler
> errors and fatal linker errors.
> 

Available in the dependent series.

> > +	if (ret)
> > +		goto err_unregister;
> > +
> > +	return 0;
> > +
> > +err_unregister:
> > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > +err_return:
> > +	return (ret == -EOPNOTSUPP) ? 0 : ret;
> 
> [Severity: High]
> If pci_liveupdate_register_flb() returns -EOPNOTSUPP, this error path
> unregisters the file handler but returns 0. Could this lead to a double
> unregistration when the module is unloaded and vfio_pci_liveupdate_cleanup()
> is called?
> 
> Calling liveupdate_unregister_file_handler() a second time on the already
> removed list node might cause list corruption and a kernel panic.
> 

Yes, this is an issue. I will add the fix in next version. Separately, I
will send a patch to make liveupdate_unregister_file_handler()
idempotent.

> > +}
> > +
> > +void vfio_pci_liveupdate_cleanup(void)
> > +{
> > +	pci_liveupdate_unregister_flb(&vfio_pci_liveupdate_fh);
> > +	liveupdate_unregister_file_handler(&vfio_pci_liveupdate_fh);
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714151505.3466855-1-vipinsh@google.com?part=5
