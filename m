Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B63ED3A6
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786862; cv=none; b=rRhPblMwD420g0l4v73Q4h2AiY2DMatnJwWytdPUqDumVnn9S/9OI5UN1qxMveommMUNNtnDVUdlZr025mdzQbb95OrBbgtUMGhQnubpoHSRfXqAVGZH+9ZX0oGz/otkFh9VvOfZ43N1qdSzSUbertxiqf6+CLWosxuFBTUsKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786862; c=relaxed/simple;
	bh=IZe9eyeCtn7LR8WJjsYNInVrnbODF2uP9hQpvPk5D9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXtDH21zqwRoVEhK0Nh9LG/MNaOrwu653CQTakURsTUhZQtc/LVwRiVpzadXT8ov3XAsIV/cW5Bfl82KWgr9ybXidcE0SdeuACrWiiuJgLx9VXkWUAMoBRzHHU0EGtNC7lyL/YOW38JUvPXVnD+u8kicQpnbSYHkZIDGNT+IH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kr6dhKxM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kr6dhKxM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA042936;
	Thu, 18 Jun 2026 05:47:28 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91763F915;
	Thu, 18 Jun 2026 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781786853; bh=IZe9eyeCtn7LR8WJjsYNInVrnbODF2uP9hQpvPk5D9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kr6dhKxMLGwaQ2hGXbTc+TsUU7o95rL5JH9y/upnl0rRERSahVy5q3cuBSUl74idz
	 NkLtgJzM5m6UkioscGedSSdt8Lnjpb376NrveHS5IJelIx+1hMqHJePY0qyGWVeRBF
	 qZHQVqpLnDCWMAjGBPHuKiL1taM6bvX0yFKsKpGA=
Date: Thu, 18 Jun 2026 13:47:28 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 0/6] x86 compilation fixes and arm64 PMU
 improvements
Message-ID: <ajPo4C3I-VBAkJ0O@raptor>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <ajETL4tbLa_3WT6I@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajETL4tbLa_3WT6I@willie-the-truck>

Hi Will,

On Tue, Jun 16, 2026 at 10:11:11AM +0100, Will Deacon wrote:
> Hey Alexandru,
> 
> On Mon, Mar 23, 2026 at 03:02:15PM +0000, Alexandru Elisei wrote:
> > The first two patches fix the following compilation errors on x86 when
> > using gcc 15.2.1:
> > 
> > disk/core.c: In function ‘disk_img_name_parser’:
> > disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> >    27 |                 sep = strstr(arg, ":");
> >       |                     ^
> > disk/core.c:39:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> >    39 |                 sep = strstr(cur, ",");
> >       |                     ^
> > virtio/9p.c: In function ‘virtio_9p_rootdir_parser’:
> > virtio/9p.c:1503:18: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> >  1503 |         tag_name = strstr(arg, ",");
> >       |                  ^
> > 
> > I couldn't reproduce the errors on arm64 using aarch64-linux-gnu-gcc 15.1.0
> > and 14.2.0. I tried doing make with V=1 and it looked to me like kvmtool
> > uses the same flags on x86 as on arm64, so I assumed it's because of the
> > difference in compilers and I didn't dig further.
> > 
> > The remaining of the patches are there to improve PMU initialisation and
> > error reporting.
> 
> Do you plan to post a v2 of these? I just ran into the 'const' issue
> myself, so I'd love to see this stuff land after addressing the handful
> of review comments I left on this version.

Yes, I was just about to put the finishing touches on v2 locally, I'll send
it soon.

Thanks,
Alex
