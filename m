Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3737CD4F;
	Mon, 18 May 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128241; cv=none; b=oRxg03ZNq/uP3Gk7N/VveMy4scrXyBGtYKYLHB4JI/HAztly8SbwAnOyYzM39BadvoG1/hA68Al7G5XACSu64PRQKNNCqbMe35JfJLFg1L86DxZpQgPlDtJzDROYV3JDDk5iFVtnOi3KJOOPR74whVbu+nQPUCyoH25JcSYb3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128241; c=relaxed/simple;
	bh=Y7nyc5qjLK37JbBRtFvJ4aIaVx6jF4+CoPuJ/59/VUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA+fjKLZMBbVYNPDlu347y8wma+GDBHQV8n8oT+QAyAT+FYFyehrAQZamce0DoDh8gJDYuHc2wxTsnTK/bwBluOLNSFnaeJdy60lJ24Yb07rE++xS9XIhLioPgghkhnzh1e/Uw8oAsWOZmzEtYltHddppMoGq/SX114/pIYc+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IASSXXH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IASSXXH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2166C2BCB7;
	Mon, 18 May 2026 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128240;
	bh=Y7nyc5qjLK37JbBRtFvJ4aIaVx6jF4+CoPuJ/59/VUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IASSXXH5i1KFyOPTeB6La2Uwlqynp1mdEiq7d4h6nmW3+ZiDfNs+hU7SJwtgEtnHF
	 NlyxMGNx3QlB87dyMC0cv0QYDg3tjmRZYaNN6VJUCYWPkdSo5uU648N/8+z0zUek0l
	 uAkJe1Lk06fX15fGd53AcGvBcQwliWVjJEVxyQLg07xcDh9J8kffRxv3stzNMF729M
	 SVhDWay9/G44bWoS6Y8iqc+jNxmHBtm+jYseWuWXrcJEJCIiqruM3WeWrOYFJOwjTZ
	 1//FNwnY7kudeb3x0OMm705JUvJqUTrEKZmcoRQQveX9zmBp32AQ+XHLLdjMXI/LFX
	 qLDXjXMCZOwrw==
Date: Mon, 18 May 2026 18:17:19 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH v3 04/10] KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when
 emulating MOV DR (in emulator)
Message-ID: <agtXfk6Ew-3ulavP@google.com>
References: <20260515222638.1949982-1-seanjc@google.com>
 <20260515222638.1949982-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515222638.1949982-5-seanjc@google.com>

On Fri, May 15, 2026 at 03:26:32PM -0700, Sean Christopherson wrote:
> From: Hou Wenlong <houwenlong.hwl@antgroup.com>
> 
> When emulating a MOV DR instruction, honor KVM_GUESTDBG_USE_HW_BP when
> checking DR7.GD, and if there is a general-detect #DB, route it to host
> userspace as appropriate.  Consulting only the guest's actual DR7 causes
> KVM to fail to report a DR access to userspace (assuming the guest itself
> doesn't have DR7.GD=1).
> 
> Fixes: ae675ef01cd8 ("KVM: x86: Wire-up hardware breakpoints for guest debugging")
> Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> [sean: only expose effective DR7 to emulator, massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/emulate.c     |  2 +-
>  arch/x86/kvm/kvm_emulate.h |  1 +
>  arch/x86/kvm/x86.c         | 41 ++++++++++++++++++++++++++++++--------
>  3 files changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 510244555a74..917a521c299f 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -3848,7 +3848,7 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
>  	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
>  		return emulate_ud(ctxt);
>  
> -	if (ctxt->ops->get_dr(ctxt, 7) & DR7_GD)
> +	if (ctxt->ops->get_eff_dr7(ctxt) & DR7_GD)
>  		return emulate_db(ctxt, DR6_BD);
>  
>  	return X86EMUL_CONTINUE;
> diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
> index bb2a2aee0e13..33bfc9aa948e 100644
> --- a/arch/x86/kvm/kvm_emulate.h
> +++ b/arch/x86/kvm/kvm_emulate.h
> @@ -215,6 +215,7 @@ struct x86_emulate_ops {
>  	ulong (*get_cr)(struct x86_emulate_ctxt *ctxt, int cr);
>  	int (*set_cr)(struct x86_emulate_ctxt *ctxt, int cr, ulong val);
>  	int (*cpl)(struct x86_emulate_ctxt *ctxt);
> +	ulong (*get_eff_dr7)(struct x86_emulate_ctxt *ctxt);

I would name this get_effective_dr7, and the callback
kvm_get_effective_dr7(). I don't think saving a few characters here
offsets the readability losses.
