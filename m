Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D59387598;
	Mon, 18 May 2026 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127993; cv=none; b=m2ErYOm+aNqcLKnEk+OI2Z69IILw3opJmGD2OH3X/qsNoKRmJMLpvPSa2GDR3xvIMXSYIyDB64+roN7flaU0VXeBU9YrxacgxMk2muuH61DOdSZrk+bftD8w9w+D9amHkpxTbUpxTX60A6rCtWLyZ9Kph5DyNylTRx2HC0wpfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127993; c=relaxed/simple;
	bh=ta/F9bcNscSmpeNNaSbYLtI+TyWmQvsQ4zikOIIkQUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8RLQvaEvzJBQHQBZjnjU3naB6njqqzVQiSaGERGydbHRDq9OipxJ0jTz8yXlFvLzuzLA/Ux7HGFFJsHNa7vINx22ors937puafIYmBpQyU8T3WwDEZSAyA+JGAHi7i7tdO7/FKWrA3zdhwnMF+no5DytS6Jk9R4RyntHwFct0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd+l2jfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd+l2jfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D532FC2BCB7;
	Mon, 18 May 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779127993;
	bh=ta/F9bcNscSmpeNNaSbYLtI+TyWmQvsQ4zikOIIkQUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cd+l2jfMOxpDZLrcQucmQ435t3mgstpZInPAg3yMWn5TYoYrc6TuKtES4QFwGZQl8
	 5Od3jQ3fnUaAJubbzJq7PJ2qvzHq1OpTZSc2n8BjaIo3JOLuOhTYkQS1VIGQGJ10nA
	 Cx0ISoCa/o8nldp57ZndF6R8cMxnahejQaJqKtiAmIGcQMFkoA0N6vjprO13otyfp7
	 a1aAKzulpGG6pdjmGC2OKsD8GNTCSnj5wMYbO7DXHacEh4NElYCXIsQ2eCfI+UtCIN
	 0On93PG2747NrbuWfn+e7LxfTxK/EVk042W0VE0k0g3E0SyW0169+W4ntmZORA8KNG
	 nwiAALrLQVXVg==
Date: Mon, 18 May 2026 18:13:11 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 03/10] KVM: x86: Set guest DR6 by
 kvm_queue_exception_p() in instruction emulation
Message-ID: <agtWA--5LC_ekX7O@google.com>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-4-seanjc@google.com>

On Fri, May 15, 2026 at 03:26:31PM -0700, Sean Christopherson wrote:
> From: Hou Wenlong <houwenlong.hwl@antgroup.com>
> 
> Record DR6 in emulate_db() and use kvm_queue_exception_p() to set DR6
> instead of directly using kvm_set_dr6() in emulation, which keeps the
> handling of DR6 during #DB injection consistent with other code paths.
> 
> No functional change intended.
> 
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> [sean: fix e vs. p goof, add kvm_inject_emulated_db() right away]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c     | 14 ++++----------
>  arch/x86/kvm/kvm_emulate.h |  6 +++++-
>  arch/x86/kvm/x86.c         | 10 +++++++++-
>  3 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8c6cc0406d6..510244555a74 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -540,8 +540,9 @@ static int emulate_exception(struct x86_emulate_ctxt *ctxt, int vec,
>  	return X86EMUL_PROPAGATE_FAULT;
>  }
>  
> -static int emulate_db(struct x86_emulate_ctxt *ctxt)
> +static int emulate_db(struct x86_emulate_ctxt *ctxt, unsigned long dr6)
>  {
> +	ctxt->exception.dr6 = dr6;
>  	return emulate_exception(ctxt, DB_VECTOR, 0, false);
>  }
>  
> @@ -3847,15 +3848,8 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
>  	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
>  		return emulate_ud(ctxt);
>  
> -	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD) {
> -		ulong dr6;
> -
> -		dr6 = ctxt->ops->get_dr(ctxt, 6);
> -		dr6 &= ~DR_TRAP_BITS;
> -		dr6 |= DR6_BD | DR6_ACTIVE_LOW;
> -		ctxt->ops->set_dr(ctxt, 6, dr6);
> -		return emulate_db(ctxt);
> -	}
> +	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD)
> +		return emulate_db(ctxt, DR6_BD);

For other readers of this patch, the manipulations done to DR6 here are
no longer needed because kvm_deliver_exception_payload() will apply them
when delivering the exception.

Not including that in the changelog and leaving it as an exercise to the
reader to chase it down is just mean :P

Anyway, it looks correct:
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
