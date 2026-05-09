Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D41DB13A;
	Sat,  9 May 2026 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778303638; cv=none; b=dfAX55EMgER6yca+o8FWcsSZANECcrg6o8h3aRHwbICT/+SG4mrzvm8AH8cKTbAqOpdvb+D3AX3m2UtfJOeME79RimVcyBYyREX7rn3DSYiP4RBLjtRBDlkXhAqHGd8WzRn83O+dozjvzHi04jnFfs56k8eXJlKxLCx18baZDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778303638; c=relaxed/simple;
	bh=+KXfOzJQ7cB/95GYJYJJQvC5m7lwLM9ETHSRhcrc2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h93u0Y7Uqg1XyfM5iqTn+xEikw8+h3Fpe5nY0wPLAQEx3B1tiFrqdrLY37Z5+10111UMstZrzzKJL1CaGDWS9n6uCqecCrHuauryQXWoKc5dqI+8Fve5F4EetV1GqBdEk/GJt04SXQhkfB0qmY4sdT/GUD6IqX0U3xblr/ixAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAEu+gxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAEu+gxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB4C2BCB2;
	Sat,  9 May 2026 05:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778303638;
	bh=+KXfOzJQ7cB/95GYJYJJQvC5m7lwLM9ETHSRhcrc2dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAEu+gxAANydt4xwpwrwOMUZhljeSned+1CdUnBssTq0+44nC1jb0R2mvNPe949Z+
	 EQzSfhgIixg+j5x8hDBdoyBbut6vUHifPokh9vR42DIGbAX10s2MfYqnZ1U7M9pE+X
	 Tow8n/lKAVqHNhlvW3j6p6CDrPF1h3dFQtAYbj8nNXi+KO31YbFVFXz/wGbvzerq//
	 nB89v2NGfNEcovOR5USxGTn8YyGsKnuXNpfNzn/+2OMySfQU8ftYBpoBs96B2RGh5D
	 9M40X6rEmcWVtew/zLhosHMEDi/x6fEVMVTlKZ5qEyEGEsvlFWaALO74uij0E7ecOT
	 V1SwLSrvcEGLg==
Date: Sat, 9 May 2026 10:40:16 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] KVM: SVM: Fix x2AVIC MSR interception issues
Message-ID: <af7BcU1flAzpu5S3@blrnaveerao1>
References: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>

On Wed, May 06, 2026 at 11:47:41AM -0700, Sean Christopherson wrote:
> Fix a variety of bugs in SVM's handling of x2APIC MSR passthrough for x2AVIC,
> where KVM disables interception for MSR accesses that aren't accelerated by
> hardware (pointless and suboptimal), and also does NOT disable interception
> for practically any of the "range of vectors" MSRs, i.e. IRR, ISR, and TMR.
> 
> Found by inspection when reviewing a TDX patch to fix a bug where KVM botched
> the "range of vectors"[*] (I was curious how other KVM code handled the ranges;
> wasn't expecting this...).
> 
> Note, I tagged all of this for stable, but I could be convinced these fixes
> shouldn't be sent to LTS trees.  Patch 3 in particular doesn't truly fix
> anything, though I definitely don't like relying on poorly documented behavior.
> 
> Note #2, the diff stats are misleading due to the hacks, the "real" stats are:
> 
>   arch/x86/kvm/svm/avic.c | 51 ++++++++++++++++-----------------------------------
>   1 file changed, 16 insertions(+), 35 deletions(-)

For the series (except the selftests), with the minor changes we 
discussed:
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

