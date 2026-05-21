Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D0040584F;
	Thu, 21 May 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392308; cv=none; b=KThNt7E9FBPfwd3NTxxsDMOubStqfqPFddSuQAXvkU4BX4B4inJ0BUtvDvP0hxLgTDfin2eNDyTs285tLoLLX1ErMm+2L3q3SIXH5VpJs4hzWID4WNwPHwTOZ9ciDKjdmhSeaSygLevOHTUdSDGxx37G3US3tl24JIUY5msm4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392308; c=relaxed/simple;
	bh=jkVaSirY3zxz720Si45komOa2zS01MxlDGVDcJAnIZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANLw9yDKWIyQ8ulWkpsRjKjzsMEJcuIMzKgM02Uy2oVVAAXUwrus3heZ8Jnd5NdXQc0hG8GhpHNYCZhQNHWbKpTc8EcugE5NelJrEH4xG93TXp08nShHq+feyv1mOceu26OEtskOA8v1gkpRiO1KF35UgGQQt+zc+yInwGVltJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBpbC8iP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBpbC8iP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917561F000E9;
	Thu, 21 May 2026 19:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779392305;
	bh=2xcW2kY0GGl0grlBDzM1Fb05nBp+EuJgclwihYB7zhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iBpbC8iPmcQbE42F/3pyQt9S2GUwkH1fIuCuqjq6Kp7jMP6IrhGJ7s8CGF2OjXT3H
	 NlAz5C4i7Yp7gitdoP9x+ll7KABYJpZSf9Bbn4vJPM6msdhYwP1IcuzVovVBTCuj64
	 a2HIann4dBM+wPGd75aFCisgJ/y6evw9T/ijj+Rhsjz63PvEG/t20qyWD3tTi4PyxV
	 p50q98FSB1gP45Xblc92+LfxehromNhsW1s+P/VwH5QSvSdhRGAb+zu2oew3xFyNhq
	 61+yctziheeXrB/Dx+p+L1/fyYxkt1U63w0bbDpt3JV1GTr2oySAQEMUJBhUFOEs0b
	 QZaVlSkXFriXQ==
Date: Thu, 21 May 2026 19:38:24 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, 
	kvm <kvm@vger.kernel.org>, Jon Kohler <jon@nutanix.com>, 
	"Tosatti, Marcelo" <mtosatti@redhat.com>
Subject: Re: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of
 struct kvm_mmu
Message-ID: <ag9coP1aXYi7Xdfh@google.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
 <20260511150648.685374-18-pbonzini@redhat.com>
 <CAO9r8zMeg1ta0hL4panuB3D-10PmkwHL+9XKv_0NVjcpq0oJMg@mail.gmail.com>
 <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZ+TXrw7UpMt2DQUYb6Gwr-+vHy8E3iNbP8WB2z=+1ZTw@mail.gmail.com>

On Tue, May 19, 2026 at 12:25:29PM +0200, Paolo Bonzini wrote:
> Il mer 13 mag 2026, 23:36 Yosry Ahmed <yosry@kernel.org> ha scritto:
> >
> > However, I can't immediately tell what vcpu->arch.cpu_walk is doing
> > either (compared to vcpu->arch.tdp_walk), so maybe the names can be
> > improved? If these walks are tied to these MMUs, maybe name them as
> > such (e.g. root_pg_walk and guest_pg_walk)?
> 
> No, cpu_walk is always GVA->(n)GPA and tdp_walk is the optional
> nGPA->GPA stage. While there is a 1:1 mapping from a struct kvm_mmu to
> kvm_pagewalk when doing shadow paging, for *emulation* purposes
> cpu_walk is used for both L1 and L2 and It replaces the
> vcpu->arch.walk_mmu pointer from the old code (which led to either
> root_mmu or nested_mmu). In fact the main change in the series is the
> removal of walk_mmu, with cpu_walk always representing the CR0/CR3/CR4
> page tables.
> 
> I could call them gva_walk and ngpa_walk, but I think the current name
> are also self-explanatory (especially once you understand that
> walk_mmu is no more and cpu_walk can be used for both L1 and L2). The
> confusion comes more if you look at the walkers from the POV of struct
> kvm_mmu. Which leads to the other half...

I think the source of my confusion is that when TDP is enabled
'root_mmu' is used for tracking the TDP for L1 (GPA->HPA), as well as
walking L1's own page tables (GVA->GPA).

I guess the main point of the series (in the context of root_mmu) is to
stop doing that and separate the former (building GPA->HPA) from the
latter (GVA->GPA).

So after this series:
- root_mmu only tracks building TDP for L1, or shadowing L1's page
  tables without TDP.
- guest_mmu is only used to shadow L1's TDP for L2.
- cpu_walk is used to walk L1's or L2's CR3-based page tables (i.e.
  replaces part of old root_mmu and nested_mmu).
- tdp_walk is used to walk L1's TDPs for L2 (i.e. replaces part of
  old guest_mmu). I guess tdp_walk is always tied to guest_mmu?

Is my understanding correct? I feel like I missed something.

That being said, I still don't like cpu_walk tbh. Maybe cr3_walk as
suggested by Kishen, or more explicitly gva_walk or sth. The CPU walks
both CR3-based page tables as well as TDP page tables, so I am not sure
why use 'cpu' here?

> 
> > I also think root_mmu and guest_mmu could still use some improvement
> > but that's probably outside the scope of this series. These are
> > essentially L1 MMU and L2 MMU, right? Maybe just mmu and nested_mmu
> > could work? But I am not sure if we can reclaim the nested_mmu name,
> > it's gonna screw with anyone doing backports :/
> 
> And even more important vcpu->arch.mmu is the pointer to either
> root_mmu or guest_mmu. I wouldn't reclaim either mmu or nested_mmu.
> 
> guest_mmu is not L2 MMU if L1 does not use two-dimensional paging, so
> l1_mmu and l2_mmu does not cut it entirely. And root_mmu can be either
> GVA->HPA or GPA->HPA, therefore applying the idea above (e.g., gpa_mmu
> and ngpa_mmu) would not work well.
> 
> I suppose guest_mmu could be ngpa_mmu or shadow_tdp_mmu, but another

I was going to suggest shadow_tdp_mmu as I was reading this, I like that
name. Still can't think of a good name for root_mmu.

I thought about a union of two names, shadow_mmu and tdp_mmu, but I
suspect most code paths would apply equally to both?

> possibility/refactoring would be to adjust the code and call the two
> MMUs direct_mmu and shadow_mmu. I haven't looked into what this means
> for the code but it would definitely make for the clearest naming.

IIUC direct_mmu would only be used for L1 TDP, and shadow_mmu would for
either shadowing L1 page tables (with TDP=0) or shadowing L1's TDP for
L2?

The naming sounds nice, but as you say below, I don't know how that
would work code-wise.

> Having direct_mmu->w be NULL would be nice, so it seems promising but
> not something I was going to do soon (the *real* reason to submit this
> patch now is to get rid of is_executable_pte() half-assed support for
> MBEC/GMET, and that's where I stopped).
> 
> Even with the small complication that CR0.PG=0 is a direct mapping but
> would use shadow_mmu, it's still a GVA->HPA mapping and thus pretty
> understandable.
> 
> tl;dr: naming is hard so I tried to change as little as possible in
> this respect...

Makes sense. Thanks for bearing with me.
