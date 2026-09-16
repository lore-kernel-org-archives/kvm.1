Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6141443A;
	Wed, 16 Sep 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588624; cv=none; b=as77IoluP7QLMDZmom/7CMCB/OQCWQyjEgTsxGS14kfbOh8JRjWSgm+j5YPV2BV616+bDpyFOp/EzFp2O7jbPAHENR3mTNUpVynHtgX2lt4tvun//BfpqR1ptHQXbIXt6jWUjw3jaSIyh8CyqWBRSEtYOndwcN0r+CTAHm5hAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588624; c=relaxed/simple;
	bh=3LkQOyA3rKvFBADZ1erqIvKNRree1FG3K45ih6dRt48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXHJ7cHiz1vTu89UgBxj+2bEYTKp90Cmq54vhzgF2mUR8c6mWKgNrLzEHs4rgXdsq7HXJBMVgeXwJ+7z770lfJMImUzQiPTgQO2k/KQaeKfH7exwVt1FFUHuY0kF9veu7dfjT01SciQhoxC/UG4zEr3pLkNvDtwqoXh60Tfc48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FQszHZ6w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FQszHZ6w"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6667340E022C;
	Wed, 16 Sep 2026 19:56:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FteFKh9tpND5; Wed, 16 Sep 2026 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789588591; bh=pdp5qLLt9jm0Ib77d408mQvz1Le5ZGAx5P6JGrr0iKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQszHZ6w3jG29XbjxXliiFDSvb1pt+vlxMrv2sJeV/3Yh/thDchxinrigffXsAqp5
	 Hb87Ih+VwuIOoza84u8WFOQq+3ri2G7/nbLF4F3y1jhRxgCMZoNEhpvCJmDu4xkp3J
	 gTJsUk+p2l9LLmCuUtTLb6BJ9Aslh4fz6413T3SU/DGCW9nYQZ8X2Q34fNaVe9cUy8
	 X/KE4n9p/06WqvMut/2KlZI/r/SQ5m00kZGh26/iErWCjw//xm7vQ5hL5yZBpCqecN
	 5dopHWvdX7cfIaR6+e1Ftoaiy7QGx4uMLbDJLLyEtb38njEX6j67MBoS/ck1QsP18z
	 cdKvYCRUuVdLCdtGcsfSzLjFUtXExEKZjtVfmVJkc6E9Y6q0OPKMUZ/uvOOcryGOA1
	 2aqsBKNGh4Sgp9HSOHMykp7qn+UudRHSm5EfDZoeU7BCZf7Mg9x+9oJnrJk9zFlaq+
	 MnuDL3VySPV15emZWryDSKB6BNQ8KfwSSSitu/KXPdQYZBmWZjCGmUqPPL855CePLV
	 XfDIJPj4Mxqwj2QtWC0MPztZC00ez2aD0r+RY/g54iGcHygZlLcr87bRNPU7k5V36E
	 Fvz3rEuQJeB40YLtmcoEoxBw+cYfZCNS2axwC2V50p6smJ5a8OKXrqHhYfXGCbFeWL
	 IDJl0WhgQ7NmFsZUz+XWWrlA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3026C40E015B;
	Wed, 16 Sep 2026 19:56:17 +0000 (UTC)
Date: Wed, 16 Sep 2026 12:56:13 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
	kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com,
	ashish.kalra@amd.com
Subject: Re: [PATCH 2/3] KVM: SVM: Add host support for Enhanced SMT
 Protection
Message-ID: <20260916195613.GDaqr0XWezJuGjxtgI@fat_crate.local>
References: <cover.1789399214.git.prsampat@amd.com>
 <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df22a9879871f5f926ff74b203e06b58ed505503.1789399214.git.prsampat@amd.com>

On Mon, Sep 14, 2026 at 04:55:55PM +0000, Pratik R. Sampat wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f70ee74b5f92..4cf477e95c58 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -529,6 +529,7 @@
>  						      * and purposes if CLEAR_CPU_BUF_VM is set).
>  						      */
>  #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for 4k vCPUs */
> +#define X86_FEATURE_AMD_ESMTP		(21*32+21) /* AMD Enhanced SMT Protection */

For the non-virt bits like this one and in scattered.c:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

And Sashiko has comments:

https://sashiko.dev/#/patchset/cover.1789399214.git.prsampat%40amd.com

Please address them: if valid, fix them, if not, explain why they don't need
to be fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
