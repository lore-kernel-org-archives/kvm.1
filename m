Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AA3F9F56
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787533; cv=none; b=djAKJpfxTjtDWKxEeggavin3qGceleZ4AHqG3kd4stfN7GZnjnuV+GYGSRFPj25FhJ/tGvK81Ojl24VAglHVsOXSElpGBieJ4sTwl//iLhHr4l/j/L5Fdwo4G982bdZyQJbkm1SGcIPw4/irVL+DUkdUuHxp7TSlUrjEALN7K/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787533; c=relaxed/simple;
	bh=LI+IfTyFWVvZrlO2bKV78JCEaZK487unugf8ot3DXjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPK/26MU4/W6tboZOPf6CySxyrZ+Ca4yZBGFaGVRv39LVQ9U7DTFkkg9VUc7TkjpVhoGDkj2l/ApVPY0gDtDcj8iXUuUpANdt29Z1O9NwW+THeJG7SrRLNF0gOJB9cMVfh5i3Ia6r3KnejBgA6KHSDnxyrAVuXY+PQ26+n7bQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5PTXV5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5PTXV5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB61F00A3A;
	Thu, 18 Jun 2026 12:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787531;
	bh=tYYRPB/l8yNlQPzOUKmwb8hI3jOUlHEPCvKolxF3l44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B5PTXV5p6w7PJYZPZaE/33vS/mOHJgJzB0jVMyxKomyAsTW3UpT59AYl6vAzgF/D7
	 VHqa8EoWucnIQebqEx5fsxcFf2/C8rgec8y84+1dpRmitcpa22RA0WaHt1i6D6saCh
	 K9qnkjk1+5xmOxwgU3fNuBKN+Hi/cE14xH2Vd/1z9CAbqm8BmMHBGXpQGUdbXv14Uc
	 QVfrdMBQEyK4mnID5RDL+UPGOiyG0XPZT3i+zsNpB3QWnq8OaS2zAchK+QLwANk5WX
	 M9jjhgEQmM9hoWZGa5eewS98tzKKm47/ptNdS5BYQFCvCZoqX24mBF4TJmLhVZuCkH
	 hnrtBW9C6Bd4A==
Date: Thu, 18 Jun 2026 13:58:46 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 0/6] x86 compilation fixes and arm64 PMU
 improvements
Message-ID: <ajPrhvfDIRefmRMd@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <ajETL4tbLa_3WT6I@willie-the-truck>
 <ajPo4C3I-VBAkJ0O@raptor>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajPo4C3I-VBAkJ0O@raptor>

On Thu, Jun 18, 2026 at 01:47:28PM +0100, Alexandru Elisei wrote:
> Hi Will,
> 
> On Tue, Jun 16, 2026 at 10:11:11AM +0100, Will Deacon wrote:
> > Hey Alexandru,
> > 
> > On Mon, Mar 23, 2026 at 03:02:15PM +0000, Alexandru Elisei wrote:
> > > The first two patches fix the following compilation errors on x86 when
> > > using gcc 15.2.1:
> > > 
> > > disk/core.c: In function ‘disk_img_name_parser’:
> > > disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> > >    27 |                 sep = strstr(arg, ":");
> > >       |                     ^
> > > disk/core.c:39:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> > >    39 |                 sep = strstr(cur, ",");
> > >       |                     ^
> > > virtio/9p.c: In function ‘virtio_9p_rootdir_parser’:
> > > virtio/9p.c:1503:18: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> > >  1503 |         tag_name = strstr(arg, ",");
> > >       |                  ^
> > > 
> > > I couldn't reproduce the errors on arm64 using aarch64-linux-gnu-gcc 15.1.0
> > > and 14.2.0. I tried doing make with V=1 and it looked to me like kvmtool
> > > uses the same flags on x86 as on arm64, so I assumed it's because of the
> > > difference in compilers and I didn't dig further.
> > > 
> > > The remaining of the patches are there to improve PMU initialisation and
> > > error reporting.
> > 
> > Do you plan to post a v2 of these? I just ran into the 'const' issue
> > myself, so I'd love to see this stuff land after addressing the handful
> > of review comments I left on this version.
> 
> Yes, I was just about to put the finishing touches on v2 locally, I'll send
> it soon.

Thank you!

Will
