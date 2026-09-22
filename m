Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC753358B;
	Tue, 22 Sep 2026 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072384; cv=none; b=ib9Txe8kAFlbiirpNsDT38CTD9oLb9ll5rl4HF1M2ZbOZJh+WPc0DO26gGOV35mQ6OAxLpkavaEgW5XtbdDdj+YRJdDjUEnb/XFxYA6puf9JrWuD0lfx7t3+W3bGjvUHchGVwoffx17YtVEtQR2FNUM24nJR3PsfwRZRp6ut2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072384; c=relaxed/simple;
	bh=NpYj/w7JrVMxb72Egg41zbl3BexlzNDaGODghtpR9r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+BgzPHDQ2ESU8JyJjWr4ksgNMbTH3MAdy0aQpFuB8eTUoUJwvVO2r3764tIiUACBPLSzxys+HlQPdiLeMg3jKh6crakF4ZAKoY3+ZgmuYhL1l6HnO0cS9pNZL/9ySyiobajfBgZ7DUMLc7EK+cK7adyZDJUZa4n4/IlStLPRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSBP02VO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSBP02VO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DA1F000FF;
	Tue, 22 Sep 2026 10:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072383;
	bh=n7LFSDEMCwiBD8uC0TjgGv7LWrQWTiCqCH2xY+/MbLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSBP02VOwf91dCgmesuMT0TwaFqaTnnV4CxIqN9JfJyvPzO7KBCAPLNIu4AF63mIS
	 rZ4nwp/GRZjjzHuiYiogfKeeeAMaLdYVSWa/Hw9YhW5RgOf51bDd/m7G3aljA9Mpvk
	 otDqtpoEMjlbxucNNxcPXhJuGroxrrhMWUeXnJyKPr6f8MzfNwuMkuq0tbh1GY6ke8
	 EAhInVkYsSlhJ5JKDNqLfuCU1lPwBDZ/kmQWZrFUI0jE9d0ILYZioURkjdGjBt8BXj
	 0TkfdEEmoZYJN5AHjES2NM6awLzRPnIvknYKZNtx40khxBwyJWJsHKFG+EwLn1+WG4
	 gS0y/gBgQugTw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 155D31980058;
	Tue, 22 Sep 2026 06:19:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 22 Sep 2026 06:19:41 -0400
X-ME-Sender: <xms:O1ayahRIIIAx4yZPGHMV5uYJsP1mh8Beuf1PVxMgsUCtjqhsSuoAlA>
    <xme:O1ayajhEGfatURE8uTu56xgaw295aGwAQ6JqKMKQ7K_K8vtzGlJk0HsD2K5WC9Q85
    H8U-iBBsrU-SIFw1fIxqIeD_g0IH7Y9Ers56PS3LMXh7U1CjhtsVbw>
X-ME-Received: <xmr:O1ayalh7SzphRsP-NVv_Y0Qh7fBQdQP8y7en2dPRvI2Ln2UwojxdAlG8bc8>
X-ME-Proxy-Cause: dmFkZTFebrgmgfLsEhx3TIuYynyaetrC8bxDg2N3FUeEkPDsFDpbU8ZDJB/GjgqNZ2H2EV
    9LthqEPNCRaTAuUnWKvt5Y0OhobYIxx/51Ui7ASNOD5N4uHH35IQ9MRFdYHyJA8+zC9o8v
    LmGiIDUocZNjkidtFRUqreoW8QFoirsvzf/x53Cwu/xdIAK6BXPHglprpbRqYgGANjDij3
    CTJ/Ao10w9EbB/cYcJFJqkKbpz8AXsPODKLn6LT3MYIpQkHk9/uFAGq6f2ib5laTlgLPi3
    ARKx84DRLdH2hzwWYtlGtmADabldbt8ZTElrZC0H2VKPTLw1JckMZ6DG7N+lfxYPHJhCbZ
    5FouLCaatbs/4WIDyqLmO79XgpMvBfqydUDWGwYTxCGW2DY98/ZRkJFlUjLoCOI3EF5hEg
    N1/Tl8kd5onOpAtaLcsd/Y1DpnAf1galp6coVqua6GmSQPRAL161BPff/Nh6zT3BOjhUN1
    +Xo3YrRVZGHuyrNkPl5c13o4cJU6lKIDpNhfM0EL+wQEsVtNbXHuOlOvEdp17cnvTacqNd
    t0KvvqeqkCb48m+rNePmdsg+tN1ww6FwmA+6gEo0bBTMinAImqrVH8Mu2keWt94a4LKCDU
    S5s3zlhd3FK8AvQt6OIph8M2zHcxOvlzg+7bL0f6hxpdF97wVWeKy2nfN3DQ
X-ME-Proxy: <xmx:O1ayarYrLwotjQmtIOPoE-e7Wb5SvjNEz1_1QcGk6USazfxDwererw>
    <xmx:O1ayauXf2XKXKiaHAoAWjEyonKOKL_ZYrdjmmW20uC8YnHY7nRCg9g>
    <xmx:O1ayaijJ_qaJJqQm8UA1UT66tSA4Hvov4XUGfxobTpa0ZQZh44M7rA>
    <xmx:O1ayapmfuznqf1YFJlc820pLoOgosvxk9iZyaDts-42Qjt-wPuYqZA>
    <xmx:O1ayarzHNQqa-uoEXrH3iAUtQgjfruILZoR-I3msjn5iqUb--niazGUf>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 06:19:39 -0400 (EDT)
Date: Tue, 22 Sep 2026 11:19:37 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Message-ID: <arJVpaAi9TqEfV7E@thinkstation>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
 <aqPTIyi--7f2Fzxm@thinkstation>
 <4238bd74efaeea1a6158b79f9475a5f8d1aa7e0a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4238bd74efaeea1a6158b79f9475a5f8d1aa7e0a.camel@intel.com>

On Mon, Sep 21, 2026 at 09:20:18PM +0000, Verma, Vishal L wrote:
> On Fri, 2026-09-11 at 11:37 +0100, Kiryl Shutsemau wrote:
> > 
> > Rick, could you actually test it?
> > 
> > Are we sure there's no other port I/O in before idt_setup_early_traps()?
> > 
> > I don't see anything direct, but exception path is different story.
> > 
> > native_machine_emergency_restart() does port I/O for BOOT_KBD which
> > seems to be reachable and leads to #VE with the patch:
> > 
> > machine_emergency_restart()
> >   __machine_emergency_restart(1)
> >     machine_ops.emergency_restart()
> >       native_machine_emergency_restart()
> >         reboot_type == BOOT_ACPI (default)
> > 	acpi_reboot()
> > 	reboot_type = BOOT_KBD
> >   	  kb_wait()
> >             inb(0x64) --> #VE
> > 
> > Could you check if the patch changes panic() behaviour in the window
> > before idt_setup_early_traps()?
> 
> Hi Kiryl - not sure how I would test this - but looking at it a bit
> more - 
> 
> vpanic() only goes to the machine_emergency_restart() path if
> CONFIG_PANIC_TIMEOUT is something other than 0. Distros and Kconfig
> both default it to 0. This could be overridden by panic=N on the
> command line, but that is parsed after idt_setup_early_traps(), so that
> would behave normally.
> 
> So at least this path should, in practice, never cause a problem.

Could you just check what happens you panic early (like in
tdx_early_init()) with and without the patch?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
