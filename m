Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DA246783;
	Wed, 30 Sep 2026 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744679; cv=none; b=oTSuLKSZW4Gjv1wtp1Vokxkdv4Xg2W1APYJogLFGDjBZ7RPmXVF/Tt0VljjHI3QZX5E4ocB8sKJZJMJ3IUXzMzNsdjKzdMkK7/X7R8XELTa0b4Da4Mb0NGCbl9llGDsy9wX7uaruEgXFYs02YPv/I7vsqsx5+Idop7uzZlN1vAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744679; c=relaxed/simple;
	bh=SIvOi4CmqCt39oc7l4v4V8MtZVsnvl0Lf3KpaY2dXZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0O6RX8YqOzYarypS0Psi7ylXod2kpgWMiZzgrjxKHeP4y5l7p87NiQjV/1V6DlZ8Sx4EgecE5br4pGc+0Zdpfcxv5PZxurZaAUPrMqmVup8IWFqa10NheZWCEuw+5sa+3Hq2QL6hrxbvCXw8wS4paBHeqMrrRWP1n3GdmlPYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E9xxlNrW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E9xxlNrW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E83D940E01F9;
	Wed, 30 Sep 2026 05:04:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3PS63uR3uPnK; Wed, 30 Sep 2026 05:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790744665; bh=sngfBGXrDmp27Rz20KJdhQCRui381Q9eIqXo0Htz5/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E9xxlNrW+WVuO+r64N2E/di74SdtE/dexl+DtnUE1F3LOM91B80oigMZVY17IV3q7
	 H7d6JcUiS7QDkqxIH/VhNjazeYcaoS2TkmJp85T17I7PQ8E/v7PrwbMIQCPSfKazWC
	 7BpJKyymHDhG3atV2id/HkFxH34UGncNln89BSCZj/RS1aKb+rfqxJ6IzbJ5fU70OH
	 2+7S/U6QI7nCx8jw3QjHzN0cGBNSAIoUd0W2opqE+wAieE5rU21ewIv7q2Idl0x3Ry
	 0q4xNtf0k+CSeYoVMEOTm8pd/lWSwDjTvSQ0TS4ak4Ccj5BvucM0JSIYTinwzSxOD/
	 n91xk3k27auMrphXalnsfhqKwKnLg9HCSR0Ybc19jPi06k2uHszDFXdLGgFadSlGfv
	 0SvoTpiEnT6Ry/jmaNbv2jo7BF5yJLOmwyfrQU6DBG8WfEljuhKHZovhyNBc4RuTKX
	 6sqoB1SbHeTFaylgJuv60ToaZS6Nk6gGSkNP0W8+KkJ7i8RV0pkKbNOvDR3n6rrhsI
	 ADS5+0mK45TUYtqdFL8Qz0dj+hv9GOawDHI0yBhAzLT2jt78XNo0lpvvPsHDmm1tWb
	 lJJcfoeSFkczsA1yJSHvEGtwnv+NqdPTPQO7wwVE1XKmqlIKNRiA/uWsAfhmmwcg0H
	 1/Vb2wzgDmtiipZPxUauBXK4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07CD040E01ED;
	Wed, 30 Sep 2026 05:04:08 +0000 (UTC)
Date: Tue, 29 Sep 2026 22:04:06 -0700
From: Borislav Petkov <bp@alien8.de>
To: shrutiss@google.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>,
	Tianyu Lan <tiala@microsoft.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, jxgao@google.com,
	Melody Wang <huibo.wang@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH] x86/apic/savic: Forward APIC_SPIV writes to the
 hypervisor
Message-ID: <20260930050406.GGaryYRlonuAoQ6G3o@fat_crate.local>
References: <20260929055255.1380202-1-shrutiss@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929055255.1380202-1-shrutiss@google.com>

+ some more AMD people and drop stable@

On Tue, Sep 29, 2026 at 05:52:55AM +0000, shrutiss@google.com wrote:
> From: Shruti <shrutiss@google.com>

You should use your legal name when you sign off on patches.

Leaving in the rest for the newly CCed.

> For Secure AVIC (SAVIC) guests, the hypervisor (KVM) emulates the LAPIC
> timer and LVT registers, while the guest's APIC backing page is kept in
> encrypted guest-private memory that the hypervisor cannot read.
> 
> Currently, savic_write() updates APIC_SPIV (Spurious Interrupt Vector
> Register) only in the guest's private APIC backing page without
> notifying the hypervisor. Because the hypervisor never sees the guest
> set the APIC Software Enable bit (APIC_SPIV_APIC_ENABLED) in APIC_SPIV,
> it continues to treat the vCPU's Local APIC as software-disabled.
> 
> When the hypervisor sees a vCPU's APIC as software-disabled, it forcibly
> masks all LVT writes (including APIC_LVTT for the local timer) and drops
> timer and fixed interrupts for that vCPU. On SMP guests, where secondary
> CPUs (APs) start with their emulated APIC reset to software-disabled,
> this prevents APs from receiving local timer interrupts and leaves them
> hung in idle (HLT) during boot.
> 
> Forward APIC_SPIV writes to the hypervisor via savic_ghcb_msr_write() in
> addition to updating the guest's APIC backing page so the hypervisor's
> APIC state stays in sync with the guest.
> 
> Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shruti <shrutiss@google.com>
> ---
>  arch/x86/kernel/apic/x2apic_savic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2apic_savic.c
> index dbc5678bc3b6..1ef4c5b6c494 100644
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
> @@ -214,7 +214,6 @@ static void savic_write(u32 reg, u32 data)
>  		break;
>  	case APIC_TASKPRI:
>  	case APIC_EOI:
> -	case APIC_SPIV:
>  	case SAVIC_NMI_REQ:
>  	case APIC_ESR:
>  	case APIC_ECTRL:
> @@ -223,6 +222,10 @@ static void savic_write(u32 reg, u32 data)
>  	case APIC_EILVTn(0) ... APIC_EILVTn(3):
>  		apic_set_reg(ap, reg, data);
>  		break;
> +	case APIC_SPIV:
> +		savic_ghcb_msr_write(reg, data);
> +		apic_set_reg(ap, reg, data);
> +		break;
>  	case APIC_ICR:
>  		savic_icr_write(data, 0);
>  		break;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
