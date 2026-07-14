Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0543CEC3;
	Tue, 14 Jul 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019748; cv=none; b=uezkjHzfApR1HDABXThlvhDsKppwtxjkhrFGrlm5D8WRDULOreH9YZFqtiLGILO+Vfz4j4YorZ731eZLaILrgxYNzQmmTVz7mxw3ZxQIaOCpP4Is8ssouWj2T4tKEWEZmPN2aT8DAp57+LcO0yqkthWszWHk2FPb1gPIl+MIt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019748; c=relaxed/simple;
	bh=nhjmU46sk//8AhH9SceUm//in5Bfg4hnXsXzYSurQAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV6bi9uczzAxOC/VHbrv/i4K5xL9dHZxQ+/IR/tWqbIGp+k6hIbn6sm1yoPgvgWNwTihEmasqHsg+3R7SsHsmncVvhzKwaLFu4EOX0WwcOHdPB3i1M4jGgYz0Rsr7xJCQIIyMbP97He5LwhoapBFK/TinTstXW7SHkz6B8Joqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHtMbE8+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHtMbE8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E7B1F000E9;
	Tue, 14 Jul 2026 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784019747;
	bh=xImUQQOrkPaYiwuElqLTRTQ/M2sVRZmGraokQFEb46M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHtMbE8+a+p0p9sEjp2xguJ60cPRNdWnGpk3uGhyfiVWN4GnSNjPsfezdcWMbL/Sy
	 ylF4GPWL18QtKkooswX9hNtLt4EQFdw4fey5jUtBuaXUqSigXm2WEwwpO/Kv/+kU6g
	 J5svKIzYxvjofHPfo9L6k4u2EgTltavmn+Z4FK7q/Fa5GodypuAl3WfwNT3S2XxZHH
	 iwsjuGKa6tjnjZR+KoJ0+bCWYo5VplcBNFDdpUsAYTKIPX1PqBiQ91UZS0Curlyv/J
	 cpUa2ozcmby/KJgPtdR7z91tR/2wED7025iwFP4wngx8zyqPCoakyh07NmZUJo1jMF
	 tEoQXsbKQSVOg==
Date: Tue, 14 Jul 2026 14:27:21 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>, Tianyu Lan <tiala@microsoft.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv
 for Secure AVIC
Message-ID: <alX5Im6w2IkQi0Pe@blrnaveerao1>
References: <cover.1783490022.git.naveen@kernel.org>
 <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
 <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>
 <alEEqV6NshD-T2K9@blrnaveerao1>
 <531e7646-2051-4983-98e8-3e0d7c184f52@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531e7646-2051-4983-98e8-3e0d7c184f52@amd.com>

Hi Tom,

On Mon, Jul 13, 2026 at 12:38:13PM -0500, Tom Lendacky wrote:
> On 7/10/26 10:02, Naveen N Rao wrote:
> > On Thu, Jul 09, 2026 at 07:03:49PM -0700, Borislav Petkov wrote:
> >> On Wed, Jul 08, 2026 at 12:01:59PM +0530, Naveen N Rao (AMD) wrote:
> >>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >>>
> >>> Hypervisor needs to be aware of the VAPIC's APIC_SPIV state for
> >>> LVT masking/unmasking. So, propagate the guest's APIC_SPIV
> >>> writes to the hypervisor.
> >>>
> >>> Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")
> >>
> >> What is that patch actually fixing?
> > 
> > Guest doesn't boot without this change.
> 
> This sounds like something that should be submitted outside of this
> series, especially since this is an RFC series.

Yes, I posted these together so that it is easier to review with the KVM 
implementation alongside for reference. That, and to get some feedback 
about the guest changes (especially the AVIC_INCOMPLETE_IPI aspect).

I will post a separate series for the guest changes.


Thanks,
Naveen

