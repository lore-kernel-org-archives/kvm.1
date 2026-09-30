Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00231373BF6
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781351; cv=none; b=LXPr+mSt9+8IqcYR4cL2yM3fNzSGZgoSBY/WtVuFJ0uu+McYQzdgjZ5m85cL/ZOcBcaNKTSW414S7dP2yJmiFfnW0cQE0K27JheQ1EAw2xBmuPbNxUyPueJjVF7I6xFCKkDWFVlCkVOSQPPj3hlIByhDMYMG38Yfm9hei7HCb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781351; c=relaxed/simple;
	bh=uYkptGHOhkZ2njHmLCr5cNIbKXL2O554/Yv3adwer90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtY1DiZ3ijGlC1Oji45Itg9rMDsenhC2RbPMlL+uoS/3U1algr3oUJW205bWe3kJ3StGIAoW2pE9ixZi2H9ZUPm0fftVymZoZxKZS8a7cAJ/gynfB3mA+Pt50C574KoYW6iU1FqQvgX/24YPENmE6C1ijkL7K9/jutRL/VOF77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BmHbJrVr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BmHbJrVr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DFC497;
	Wed, 30 Sep 2026 08:15:34 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE043F86F;
	Wed, 30 Sep 2026 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790781337; bh=uYkptGHOhkZ2njHmLCr5cNIbKXL2O554/Yv3adwer90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmHbJrVrGvUQ6nSgYk2xP4TaPo8s7Zlp9mF0y2GhEW7dUf/kgSRTYX33BPp0bGAW4
	 LPD/nXm7UOIaCPOVdz9r4lglf93cm+gasqhhoNEdYJHls29atAYIvoREwyAGhiMBgW
	 2y/xgdgHE+nSMWp6qJk/X8IHVNSg8ntmL9JBpcVY=
Date: Wed, 30 Sep 2026 16:15:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v20 7/9] arm64: Block hibernate and kexec while RMM is
 active
Message-ID: <ar0nko4Gjj_PlwB5@arm.com>
References: <20260929221623.1342076-1-suzuki.poulose@arm.com>
 <20260929221623.1342076-8-suzuki.poulose@arm.com>
 <20260929222639.997731F000FF@smtp.kernel.org>
 <8e02fe1d-2011-47f0-97a6-c34d730dee6c@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e02fe1d-2011-47f0-97a6-c34d730dee6c@arm.com>

On Wed, Sep 30, 2026 at 10:12:36AM +0100, Suzuki K Poulose wrote:
> On 29/09/2026 23:26, sashiko-bot@kernel.org wrote:
> > > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > > index 424291c547f02..253f544a59731 100644
> > > --- a/arch/arm64/kernel/hibernate.c
> > > +++ b/arch/arm64/kernel/hibernate.c
> > 
> > [ ... ]
> > 
> > > @@ -341,6 +342,11 @@ int swsusp_arch_suspend(void)
> > >   		return -EBUSY;
> > >   	}
> > > +	if (is_rmm_active()) {
> > > +		pr_err("Can't hibernate: RMM is active.\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > 
> > [Severity: High]
> > While this successfully prevents saving a hibernation image, is there a missing
> > check in the resume path, specifically arch_hibernation_header_restore() in
> > arch/arm64/kernel/hibernate.c?
> > 
> > If a hibernation image is present on disk (e.g., from a prior boot with RMM
> > disabled, but with a matching uts_version), subsys_initcall(arm64_init_rmi)
> > activates RMM and delegates memory to the Realm PAS early in boot.
> > 
> > Later, late_initcall_sync(software_resume_initcall) restores the image.
> > Because arch_hibernation_header_restore() lacks an is_rmm_active() check,
> > the image is accepted. The low-level resume path swsusp_arch_resume() then
> > blindly overwrites physical memory with the saved image.
> > 
> > Without an upstream guard during resume, won't this overwrite newly delegated
> > Realm PAS memory, triggering a fatal Granule Protection Fault?
> 
> That is a valid point, I have added a check there to bail out if the rmm
> is active.

I wonder whether adding something to hibernation_available() would be
better, though it would have to be a __weak arch_hibernation_available()
or something similar.

I think it blocks both the suspend and resume paths and also hides
"disk" from /sys/power/state.

-- 
Catalin
