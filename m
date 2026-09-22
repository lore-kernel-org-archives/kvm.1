Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B849E12F;
	Tue, 22 Sep 2026 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790104741; cv=none; b=ENrMQjkaCRWdiheMqrWDN3/9idKsFsmODxJaQFXLVrV9GQ9bIol+rJuV3R0el+H4F5OIIiTpUvbouF4WH40lgc9Pgn82dMwxwnZMnCADNPqWxCrx0esF29gzf7+Sl3alE6C+eYWPVaOFx3g51xIhhihSxo13x91YYJwdBbKNy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790104741; c=relaxed/simple;
	bh=0zgMNLOviZP7C9GOTO7uXthAk1faCaLnopFRpyN+6Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAeqX9IQKUt+l/lwyTggFygYpQB3tiRMuhlYlETgF+Aq8CNQKPDiQACLkk+gKXsSw9eQrDF0kZwviz76kNvVuAtVIblLTcmB1uZxDycSgsAsQCg3jZ9+IsKfoM8n9ZiUB+ZABTtRk7WzC5S2EiIdeRbCJLTIIegLiJB2qgZxlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVZNMwZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVZNMwZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB921F00893;
	Tue, 22 Sep 2026 19:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790104733;
	bh=rG9jdeE1GgpZ721Ylayiu0WJux0e9upMn4hAQNazN1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVZNMwZymUoYnWyP9PHedZApvviQf4Cvlsyp/06Z2xBBaXCbkfJh1lO8fG0QPlX5E
	 9CbIKE3oQ3X5YPwWe1ZvPlL9d+D8/0kHepKHOdR3CyJBFJGMaDljbvuVYus4pjWJKP
	 qGYOQBGbQDWJSkiTYQCy1L9lvKTdbg5G0OLyjJWqJA/VSlMLlMVLUapYFccALw2jP9
	 hXmVSigBJMTg0tgCDzSp/ymC8iFI0b80Wa764Lnt6nrXofGRVGZ8AnqYl3ShLMmvR2
	 vj2DahjSlvc6WSBMpR8dtdWGcJAc7tuOkrmINccYugToUbmJjd1TseNI0Woo4pazI2
	 GCbNy1MCv7Q/w==
Date: Wed, 23 Sep 2026 00:45:39 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, =?utf-8?B?UGF3ZcWC?= S <spawel523@gmail.com>
Subject: Re: [PATCH v2 0/7] KVM: Serialize vCPU creation and revert vcpu_ids
 tracking
Message-ID: <arLSZuDixbzXrevV@blrnaveerao1>
References: <20260921174445.911676-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921174445.911676-1-seanjc@google.com>

On Mon, Sep 21, 2026 at 10:44:38AM -0700, Sean Christopherson wrote:
> Serialize vCPU creation by holding kvm->lock for the entirety of
> kvm_vm_ioctl_create_vcpu(), and then revert the now-redundant tracking adding
> by commit 97d65b544f48 ("KVM: Check for duplicate vcpu_id as early as
> possible").  I botched the math when justifying the vcpu_ids tracking; it's not
> an extra 256 bytes, it's an extra 2048 bytes.  Roughly doubling the size of
> "struct kvm" tripped x86's KVM_SANITY_CHECK_VM_STRUCT_SIZE, and obviously isn't
> something we want to do in general.
> 
> The TL;DR of why it's a-ok to serialize vCPU creation is that no VMM actually
> does parallel vCPU creation.  As with so many things, KVM's current behavior is
> the result of decades-old cruft, not intentional, deliberate design.
> 
> Patches 1-3 are a tangentially related cleanups and bug fixes; I included them
> here because holding kvm->lock for all of vCPU creation allows WARNing if KVM
> attempts to lock all vCPUs if vCPU creation is in-progress (the caller must
> hold kvm->lock).
> 
> v2:
>  - Tweak patch 1's changelog to clarify that that only x86's manual checks are
>    dropped. [Sashiko]
>  - Add patches to convert additional arm64 and RISC-V usage to 
>    kvm_is_vcpu_creation_in_progress(). [Sashiko]
>  - Remove acquisition of kvm->lock from s390 and PPC vCPU creation flows.
>    [Christian, Sashiko]
>  - Add Jean-Christophe's Tested-by to the revert.
> 
> v1: https://lore.kernel.org/all/20260914181223.289061-1-seanjc@google.com
> 
> Sean Christopherson (7):
>   KVM: Reject attempts to lock all vCPUs if vCPU creation is in-progress
>   KVM: arm64: vgic: Rely on vCPU creation check in "trylock all vCPUs"
>   KVM: RISC-V: Use kvm_is_vcpu_creation_in_progress() instead of
>     open-coded equivalent
>   KVM: Protect all of kvm_vm_ioctl_create_vcpu() with kvm->lock
>   KVM: Move check for existing vCPU ID to the top of vCPU creation
>   Revert "KVM: Check for duplicate vcpu_id as early as possible"
>   KVM: WARN if vCPU creation is in-progress when locking all vCPUs

This addresses the Secure TSC splat I reported previously:
https://lore.kernel.org/all/apgj5l7DZGsScsNc@blrnaveerao1/

I booted a SNP guest with Secure TSC enabled and didn't see any lockdep 
reports. For what that's worth:
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

