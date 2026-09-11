Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1E49F10B
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142834; cv=none; b=PQ4M9q6dkbNeQhK/jIsV8Vo8GSElagkuMMv8BlFJC6qvcdZTmPfykxBOsPn7UZtAkgIHZgHrpR1D3RukKfzj4aWqNoZ5/1PLrQ6K0uAHIuMso2cLzHco+M12z+aHsPBJ6Uw8KJ8xhTDXWJHiK6JGkbMBOKNNC8VbDbU7y5ibsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142834; c=relaxed/simple;
	bh=nuPrr44xoLc5kroY0NPcpA+oexmOZCCdbxfk5MsRnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILjXHThfYJ1qqRS/JAJVcythw5OIJjaYLVrWRegbDFuq1wegftu0cQG/hDDl4LZfRJErfbwZV3atKOcHlutQRGbaEk/v+ZtXdS7wMn1XWQ1D+63Yn+DQpMkruUCexXpE15ijVw2ToVyQXWRtKCDsCNGraDtPJOyVyN/a/e3JyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiGWeHLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiGWeHLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A81F00898;
	Fri, 11 Sep 2026 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789142833;
	bh=7yntamAm4HFt+Ol6oW5LWlb7ORis3DGYSxiR5vOlA6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PiGWeHLHijq0oj8loday66evISa5m/DyZA71+lGPHf+m15EJCKkIVpd/QaGLjEVmD
	 qmPV4uAHENRGCR9KNHzLimClSEBfxnp2aBdNZNA/gJoHzshIoHTry9xUEKs/uTQofm
	 WFS3WgU3NNV3/4+YsNZv+gI0SOKyCHMSxlBUFW0ISrf6nZn/lHi0nwLPR0KR7KmYKQ
	 dsfAYVUuLMooN8xtQBQF+fxL/ucmRjXBxFfyAQJGOm+1cqoknaPWw/VYm3zXV1Pzad
	 g/R25P+pW+6Dh+xlosDY/toMQhblGNHT2YSqcDeDUJQ2MvJcLtemhv3QyuF0KkWG1E
	 wZhFsf9cLkjWQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id E7BBD1980058;
	Fri, 11 Sep 2026 12:07:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 12:07:11 -0400
X-ME-Sender: <xms:LSekaqfOOgdUAUHe_Opc04lUpxM9CYQD3_5SMMzprsELWwjlVCcD6g>
    <xme:LSekas-i0NrLNxBRElPMwbVM3wSO-veTVfYOkoZdSO_llr8f0EZTTepuAs4Faudmq
    tO8UdVJPljEysJNGzvTF281-NYSjZUhVLSWWeG2nQls5IOkUrrqnzt6>
X-ME-Received: <xmr:LSekaqNrjoB7WzL3ERPr30A-IjMV-AsPRuKwQDYQhgnnaAqpCPDNNYy3ac4>
X-ME-Proxy-Cause: dmFkZTEPuk0FYyYX5UeRrgeA9QObt28HeMOiTkxCK5r8Pm5mtPalFZB2LAGwFWc2RIJttg
    GIcbMwkaDwxinkh4hr4VhDlnc6+H9gUFMNlvck0zocxFnTQz5FA88BLQeTtC0tYarXx7vr
    wNyJZoxXwbuzvbPWn4Qiwuf2zUU5hY6CrDN3KkYSvA0X0NqWnXeHVFRPGiVYaT9U/C7Tev
    jICeUzM5dF7TbpWScaOI0GjVbKlIHKF7FfaFBLH5pdHh1hGEf3vv+h216Ez6rHJNjYnYbg
    JPMqYvHkB13D5O52II8d6N9iaz1fWTuHrXsQ2TDjTdsePreSFlYF+kVfg99EdRC9HkCWiV
    jR42Ipdw8wUtH4pgw+3yhbUjaFw76Bk0d/vX1LPebwNCHcBz+o6zSGmgCSkl7q+2iLg3xm
    YzTdSyt98+K8pZaLNjPvL3SpMTZ8YiwB14zkDAEUF3g9Z4d2ntTQWzz0CW/6+THclx6g66
    4nz3xNO97fggwr3cOybpFpP1lmKxjQwdNbv640T+dslVM00pyNv/uQAoalwvYeuDtjEMvZ
    6SOISttLdcJg7rXq2vhoGkGWXt9PdT08LX0OivX+eSYl5pwRqgUFBMa0KRbSxqlgu5ZNL1
    t9K36ACvCXjSU/oDttzTy9mr5SXM8+kwLMN5NvbKmmCfQ6dj4c1rE/+2HTXQ
X-ME-Proxy: <xmx:LSekaqXdtqfWZr0DzYbXei2R6Kh-pnG78pYw_dvVZchKAtoY3mTH8A>
    <xmx:LSekaqhc0bnkamGSsjh7bPhlyWeQ819kuMQGP-DunJqF_bqbnLzNPA>
    <xmx:LSekai8aOlbB4KsglDjECC6TJH2GurieEY8lcnGS4n55ossZNwH9BQ>
    <xmx:LSekapRpPeUkLs_Mr43uRsFQlrOWX5gX4sygGyynwBEO6u2J-XtYNg>
    <xmx:LSekaptJVIl1nSekvmisoraIM91RUe-yf7AM-zVgR0lYWKjRMMAgUpiQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 12:07:08 -0400 (EDT)
Date: Fri, 11 Sep 2026 17:07:07 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/tdx: Remove the early #VE handler
Message-ID: <aqQmNeXQv05SK86g@thinkstation>
References: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
 <b41da075607d1eaa9d96eddbf3acc24502edd604.camel@intel.com>
 <aqPTIyi--7f2Fzxm@thinkstation>
 <93b41dce8d7a9b4f28bfed2a51f919eebec9b7f5.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93b41dce8d7a9b4f28bfed2a51f919eebec9b7f5.camel@intel.com>

On Fri, Sep 11, 2026 at 03:24:34PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-09-11 at 11:37 +0100, Kiryl Shutsemau wrote:
> > > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > 
> > Rick, could you actually test it?
> 
> I didn't test it myself, but discussed with Vishal his testing.
> 
> > 
> > Are we sure there's no other port I/O in before idt_setup_early_traps()?
> 
> It was a concern that some other feature besides early printk might use port io.
> But none were found. Andi's recollection was that he hit something that needed
> this, but this may have been with some older changed early printk behavior.
> 
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
> 
> Is BOOT_KBD something that you think could be hit from a TDX guest?

It is the first fallback from default BOOT_ACPI failure. But it is just
an example of port I/O I found.

> > Could you check if the patch changes panic() behaviour in the window
> > before idt_setup_early_traps()?
> 
> Can you describe more what you are imagining? panic() doing early printk or some
> other port io? Wondering if you have some more specific hunch.

I don't see panic() triggering early printk, but I see potential path to
other port I/O as pointed above.

I have vague recollection that I tried to remove it before, but
something stopped me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
