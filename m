Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106B3911D2
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763624; cv=none; b=oKfwXCAe+i48zHf38WQfbEoFR4Ph4fu2tBWV1qkhcV1v4YjMGnIeImWwoMBtkdgmxBAlYJ/wD6OqP6UF4EKBOxy3s4UxDadQWNxYhZkiubSqx3/FgeL3ge4FMvZXh1eIRAQdO/1d9aBU7McMboBbUiJIX/DSk9QdM3+k5ex2gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763624; c=relaxed/simple;
	bh=BUfl23NUoLCiRrgJFcMb+Vv8WRc43hjeZ61hRKJf2Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ8//4olV4MQwktwFLbqQWXASD1cNX19qYqzess7IVFIC6vO4S5ZjstIBzHYFz6qWKKEp57sfs1+htWflTTyBG1AsagU+j7XXG8e0NzvrzqI1VfZd9IqJCAiPWmiMfcfmcIQoE2UTXIsfcaue8nJowDy6qUjJqu/4qcc6Rj8fuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNc/m5Ps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNc/m5Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BADC2BCB3;
	Thu, 14 May 2026 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763624;
	bh=BUfl23NUoLCiRrgJFcMb+Vv8WRc43hjeZ61hRKJf2Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNc/m5PswQ56x1L5IfNuNU1hI9zpJw94qKd9I+C9MsUoOoDBgVVoKM32DcqW7n+RY
	 LGS31KBNHUt7gV5cyU3rySBaXQ+XQpxhyrwc9wbV/kMzkXOjK0XVYDu2skEkA/LOdl
	 cE1VakBpUSFaN2tl8UlKOm7ZIeHdvjqcDqNxTCF9ta+PhU2sT4+gZZUwGwYNYL0y52
	 KO1yEG0/4DkFCHxRKYG8pprEL9KOcsPGM+4A35+wm73d0UPra0qeeDVSb7wz7Ny7tt
	 ubLUj5Q4ZP1si1T1BwEvooOy1yERHpeVgSFzTah7i1YYHB6LRTJFnj2rpYW8zMQbwO
	 szNG2M80oDQCQ==
Date: Thu, 14 May 2026 18:28:12 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 3/9] KVM: SVM: Set kvm_caps.has_extapic when CPU
 supports Extended APIC
Message-ID: <agXFIuqx5ujCzQT4@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-4-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:46AM +0000, Manali Shukla wrote:
> Set kvm_caps.has_extapic when the CPU has X86_FEATURE_EXTAPIC, allowing
> KVM to expose Extended APIC functionality to AMD guests.  This is a
> prerequisite for advertising AMD's extended APIC space to userspace and
> enabling extended LVT emulation.

Should we gate this on the host supporting EXTAPIC?  As far as I can 
see, there is nothing here that depends on the host supporting the 
extended APIC register space, and it should be possible to emulate it 
regardless.


- Naveen

