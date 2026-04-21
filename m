Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58035B646;
	Tue, 21 Apr 2026 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813588; cv=none; b=Sm0F46iIlMc4q0W0Tengd45+Xn0B3obKxVcGrEe1zd1lTkjdPlvNjZpC8jtWEsce5XPxyjlAx2n9EHPf0JY+hrKbsVfXY96g6coxmwIIKeD0yVTbjIM0hJASWrMFJbi3WCVn3x3oOScjeczQ57ptbByB5fFLFYDA51/eI0JWe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813588; c=relaxed/simple;
	bh=5eJoc8XJ7JS0UwjXn88G4c9K9AhZfY4frLvxjthfUn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5BoHNRBjN0Tb/ZyT+Q2p6E2ea6D2zrehIu0xVceqvMSGc5lYXhsNZkB4Z1eARZhz7B+NrrZ9XOV/WCmD3iSpaXx45oBPtfQGKh6b9s21q1pfWQeqOAdjpWqWyy61ffeJHtyJjQw4q/UeBGJPXTjPw7Li9d/0XOQsd0DD8jNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryqWC0My; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryqWC0My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97753C2BCB0;
	Tue, 21 Apr 2026 23:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776813587;
	bh=5eJoc8XJ7JS0UwjXn88G4c9K9AhZfY4frLvxjthfUn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryqWC0MyQALPOGcVosk2jkyPBHlno2eI+yFdMp9tymjf0CdyINMZ7p4eNrwjhXxIE
	 nUGQnF7ojTpe9abYBGK2vPWWk11Xg8i/8NFZ5GXrCnrmNUd/etegjalJZQ07vgzCXi
	 maI23fpbA4917HfPMO/5JuS7bh0n4gKhrKJLv2uLmg1XimwHBd8DPLVMGBvb94UG6z
	 0hqIcEbcg7fbD+ojO5THAIIu3bd61g4D60BSThO1Bj1UbPmg/w2ydzK0guQK0F/nj/
	 5m0GXT4yHN8VNSpvO0y+2FKwLTQvCav5HYkHZNcO5xLr6xQb8L1sGR5MsByirGJ3dn
	 62UMuvvoR9f6A==
Date: Tue, 21 Apr 2026 23:19:46 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] KVM: nSVM: Use kvm_rax_read() now that it's
 mode-aware
Message-ID: <aegGCVewI9i8dBXW@google.com>
References: <20260409235622.2052730-1-seanjc@google.com>
 <20260409235622.2052730-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409235622.2052730-10-seanjc@google.com>

On Thu, Apr 09, 2026 at 04:56:20PM -0700, Sean Christopherson wrote:
> Now that kvm_rax_read() truncates the output value to 32 bits if the
> vCPU isn't in 64-bit mode, use it instead of the more verbose (and very
> technically slower) kvm_register_read().
> 
> Note!  VMLOAD, VMSAVE, and VMRUN emulation are still technically buggy,
> as they can use EAX (versus RAX) in 64-bit mode via an operand size
> prefix.  Don't bother trying to handle that case, as it would require
> decoding the code stream, which would open an entirely different can of
> worms, and in practice no sane guest would shove garbage into RAX[63:32]
> and then execute VMLOAD/VMSAVE/VMRUN with just EAX.
> 
> No functional change intended.
> 
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
