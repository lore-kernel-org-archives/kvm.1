Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493825771;
	Thu, 25 Jun 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419083; cv=none; b=LS45Sim5WZ/2t27gcHPkXS+ygrP5af5x0Up3gpaZDpsvDdWC0Ehh2jSyoaXyfdsRFvoTHWwwHHv5bDwVlU01VOgJSBM/FNVAqbkW4h90iLeHF2o8kwfTs7DZB/VIx7pYr1lnXl5S9OVoXWgayX5XJI7hU34LPOf+8wP88dblynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419083; c=relaxed/simple;
	bh=bLLn+DFihc2oNFCD2nIOgL6ZnrG0XB0gcQzriK1t0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbydV8lav1CgvxLLLGcoqBK0hO9KhSULksMVAJmEzN+kjFmLjvM/xKBFRPuFxkXWZ/yG5yAXhtr4zrfc/5DlKaF9N0bn7DJ84EGEN3fe6B7T0b9tsvy3sujZHhSLSIrZmwed43DR9DLifNnj4cq1TDpJQyMrPF2xgbNouR31I00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IiAg7Ack; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IiAg7Ack"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WnGee8msxHM00XoJxi3zaJnDQZLRdtDBM5DNq/wUBwg=; b=IiAg7AckCvMK5+HPH1xHAXD7rM
	zbP+P1E5W79kpN4tcVqnzkhbByWMAKRuS5AF35FJRPxsAgiPRDA6BRIy9VxbU32bxMlmEBy+8MXnG
	2ZOSwTMQoAv4XShb4ySKDlLl/u785uY6V+fZnVjPFCBsZ5dTtUT4ZZVcHz15olTfq0VDflc7T9EAU
	c3WmdyrclADBj8OKqlt40YmMJe+/Jw36HuAH9RbodKbclKNHoDbvcxsJRzistmovJWzf12LvwdOp7
	7LR8ZksCCcJj7/5YMHh4hSvJpPybGOuHObN47/9gmSp9pvsJb9IX+6AjVONAZ9ujuLQoc6qy0octn
	xlWTWGnA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wcqcn-003SER-1W;
	Thu, 25 Jun 2026 20:24:37 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id EF6F9BE2EE7; Thu, 25 Jun 2026 22:24:36 +0200 (CEST)
Date: Thu, 25 Jun 2026 22:24:36 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sean Christopherson <seanjc@google.com>, 1135235-done@bugs.debian.org
Cc: Maximilian Senftleben <kernel@0in.de>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Bug#1135235: linux-image-6.19.13+deb14-amd64: Reoccuring host
 crash "Invalid SPTE change" with gaming win kvm/qemu guest and device
 passthrough
Message-ID: <aj2OhGJreZWxlBKU@eldamar.lan>
References: <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
 <177902420697.2035014.8796825668567298024@eldamar.lan>
 <agsXnbjjKdrq8e-T@google.com>
 <db210e1d-0d3b-4501-89c5-de7d7de66b03@0in.de>
 <aiNCq17MbKfs3hGy@google.com>
 <0c183f0f-f23d-45ce-af22-a1f936b9bf2c@0in.de>
 <177749023441.304242.8022456530166067549.reportbug@mspc2024debian.lan>
 <aj1NRsUIVQRGBqM1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj1NRsUIVQRGBqM1@google.com>
X-Debian-User: carnil

Source: linux
Source-Version: 7.0.10-1 

On Thu, Jun 25, 2026 at 03:46:14PM +0000, Sean Christopherson wrote:
> +lists to capture this for posterity
> 
> On Wed, Jun 24, 2026, Maximilian Senftleben wrote:
> > I tried a 7.0.10 with KASAN for several days, and now I am running
> > 7.0.12+deb14.1-amd64 since a couple of days, and at least so far I was not
> > able to reproduce my issue, i.e. I had no crash so far.
> 
> That, and the fact that 7.0.7 was fine, strongly suggests a broken fix got
> backported and landed in 7.0.8 or 7.0.9, and then a fix-for-the-fix landed in
> 7.10.  There aren't any KVM commits of interest anywhere in that range, which
> supports my theory that KVM is an innocent bystander that ran afoul of memory
> corruption due to a bug elsewhere in the kernel.
> 
> Unless you want to bisect to figure out exactly what commit broken things, and
> what commit fixed things, I think it makes sense to consider this resolved unless
> the problem occurs on a 7.0.10+ kernel.

Ack, I'm marking this as fixed with 7.0.10 based version in Debian then.

Regards,
Salvatore
