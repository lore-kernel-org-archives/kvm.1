Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8E43DEBC;
	Fri, 11 Sep 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123040; cv=none; b=LkPr4AxK1b/KfhBVCaqas3zgR8Y+xtpGrqYrn5ZSCcEgZ5xehsN0OooyLyUQfh2riirU6tD4SSC3t56fZNJz+xBFRvY9ZHd9lyS3tFwKxgFLpXz+vged/hpIYUGr3OPwOY0TSeDTmLkpTZwxoBmbHM0LEGrZcxlU62tTXhVAmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123040; c=relaxed/simple;
	bh=Zj6VBx/ShSOg/ofBg8MaQUi1PFJSwwejRlQRLC6bEK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2prNsuthqNGP+xIhdFQL29AcB6PcStJ9jvRQ8Bz7358XrQtUWav6PYIqTQ7888oUF0bVBRN+OOouJ0nHWFsL4YC0IyO+stGiraqbb/3et6BjtFWWy0oCJfgbRr1CxasjsQaT1bBSkI5IsbT5nz4k/0Gj0upyHQ3yZJxjvSyjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKTk2e/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKTk2e/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C561F00898;
	Fri, 11 Sep 2026 10:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123032;
	bh=+2HrtVafR8OcAx49ufL9H8GmxuAw4u1l8/SSkfwNfsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DKTk2e/ycvYCdub4YkABnLZRfBGdjGKB2HcmUCT2c6T9PDaRB1SwnSDZErG30/ig2
	 0YB1iECX0mzpK4IOtuzHy4Fo+5J2hkQ2wXfmxVJ/l96+oLX1tSuvr/u6JB1lNgrNhG
	 Kx/IemPWbu2dr/YbNCTlLGgvqgdzsF0EnmFvXyZDXPP/UdcfzLO/BGrxH6gXlExfO4
	 JGYJzJFw5BpgOdtJESGcmAn3jpxppHmSHhp2I4sdvgxsE0Gwxa2gDgWUBU3Z3DRtWQ
	 NAvQXre87Bdw2aOvyxljT/qIQhZe3udB0YL8GTBR48CvJqLu/cB+vuVB/WlgwAZ5FQ
	 eJ3M1RoNPFjPw==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.ams.internal (Postfix) with ESMTP id 753961980052;
	Fri, 11 Sep 2026 06:37:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 11 Sep 2026 06:37:10 -0400
X-ME-Sender: <xms:1NmjasoEJqirEUNEwABFkjzturF0KpXyGBWj7Fwy2S9sB9vAuS7aZQ>
    <xme:1NmjarYh3vMF1wVKzggsRyhMmbqfLXn5SL1EzLxjOf4wjt3w0vA1ReUSabyrPuArn
    XIqKHaE0u2tGknHVN780HhqW5cYhri0GYoPHxLweItgT1swN36ssWQ>
X-ME-Received: <xmr:1Nmjav79RJpxbzxrijxlnwoO-dFsmfUa4nY3yt_Vbc0DNkodiiqZYejt8BM>
X-ME-Proxy-Cause: dmFkZTGyGEM0rlMbrekGelzPyrgxDtaD0RwJW120HE24VizydBvm/r6RoCj4O8FOhfnUe6
    9ExYL8FSafpFaUsrj/UjeSg6HgXfUr1JDlEWINQUh0ADGu21g6NYjgsfodzQfRWVk/aq3m
    zJxge4gvzziUSpDcbyzvVfks2TDakAvbxPnjyi9Q0mGN99/lfiscu///v8x3dfFUn6JiAw
    MN/m4hSLIU2TPE+zR2vhXQvj1udNT6515VDkx737OmbJZPg0jVmZs/uy0zp7H66TyKHELB
    VArTxaa1cWblXsxZa6D3GNEDlvKxs7zSvA1ficFZ6cnf3vC5CTTJDSjVFEhKa2240K3ALs
    6qllgaUuO35veKV776cX/BWXnBYv60Vk8a6xdrzJhTDPXYA7NW+87HKEaF3MAP3IAJZ9wy
    VC6Rze2XtXBH8nv2Y94q1j5L2ggxLKPQ3gQh2GOKzTghjPlY51+Upf//G9+fLxDgXLgS1t
    uL1SPTe2/E8arX9g46mYfQNnJLOO7ZlhfXlyAt+O4RMUkzt9HUT959SlQZkAgxMySfGIBT
    Ir9RER45UT/RLdNfCdb9/SeCN2Z57Of/w5ltSXzEkEbzzdnZwTstLOIeu+8QOYHVdC2G4l
    9EnZrCrRFb35hXscwM8x3YwjlJYgAsNsjYc2yNH5oRliwHqDgQbb/+h8Q7Ww
X-ME-Proxy: <xmx:1NmjamTw1HdJ6DfYF_MRnZrH9JOQxaf-0o58JIfRo9xU59exJmk1-A>
    <xmx:1NmjavvxikWedCMYkh_8ZsIVH_QX6VXH0EPtSHPhUIIr8pIp6Jx5sA>
    <xmx:1NmjaoZA6zLDKDx7Rdz1tkdmxY8zdNJjCHK-A-lihqyww-XTI0DeNQ>
    <xmx:1Nmjap_mUM_0j4nidK5MvjOXLoUHXvuA7bwSIibBiRo4qdlHuTbD4g>
    <xmx:1dmjakppHIY4-36P-tIO1jSFLyocap6FWqduBu5pY6E4_LxYfrkTvXsN>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 06:37:08 -0400 (EDT)
Date: Fri, 11 Sep 2026 11:37:07 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Message-ID: <aqPTIyi--7f2Fzxm@thinkstation>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>

On Thu, Sep 10, 2026 at 08:39:47PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2026-09-10 at 12:28 -0600, Vishal Verma wrote:
> > tdx_early_handle_ve() emulates port I/O for #VEs taken before
> > idt_setup_early_traps() installs the real #VE gate. Per commit
> > 32e72854fa5f ("x86/tdx: Port I/O: Add early boot support"), it exists to
> > support earlyprintk's serial driver.
> > 
> > "earlyprintk=" and "earlycon=" are both early_param() handlers, so no
> > console can be registered before parse_early_param(), which runs from
> > setup_arch(), after idt_setup_early_traps() has replaced the early IDT.
> > Nothing in the window between idt_setup_early_handler() and
> > idt_setup_early_traps() does port I/O, so this emulation doesn't ever
> > get called.
> > 
> > Remove the handler. Any #VE in the early window now falls through to
> > early_fixup_exception(), as it previously did for #VEs that were not I/O
> > instructions.
> > 
> > Found with the help of an LLM observing that the real IDT is installed
> > before parse_early_param(). LLMs were also used to verify this. On a TDX
> > guest booted with earlyprintk, a counter added to tdx_early_handle_ve()
> > for testing remained 0 after boot.
> 
> The logic and history makes sense to me. I'm surprised early printk is not
> useful this early.
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Rick, could you actually test it?

Are we sure there's no other port I/O in before idt_setup_early_traps()?

I don't see anything direct, but exception path is different story.

native_machine_emergency_restart() does port I/O for BOOT_KBD which
seems to be reachable and leads to #VE with the patch:

machine_emergency_restart()
  __machine_emergency_restart(1)
    machine_ops.emergency_restart()
      native_machine_emergency_restart()
        reboot_type == BOOT_ACPI (default)
	acpi_reboot()
	reboot_type = BOOT_KBD
  	  kb_wait()
            inb(0x64) --> #VE

Could you check if the patch changes panic() behaviour in the window
before idt_setup_early_traps()?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
