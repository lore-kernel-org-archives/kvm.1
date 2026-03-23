Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4363988E8;
	Mon, 23 Mar 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268834; cv=none; b=ezPZqaZUVtM9AkSTrAx7snHx63Eo9QGs07SlDf1n/hhe5wRYjr/2xIO5YZloBeY6K4OYWHmJ47ebsEXm2ikJBi49RXqktXwFMnAdcuG4TIyeeTWOPjVuMacIW/k/tWQSeOLnotVWKqnYu+SH+U4mcB502MKZ68UCZ0+or4nJYz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268834; c=relaxed/simple;
	bh=GNMo4XSlRKxRmRJ94lfmXJU84d183THQCpxU+cHfSMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FftDqvnuEYqSsD02x2a83EDbwqJdqnUdcKdVaM7oqqK5A3fEmwWmcfFBxZ1iiq28BGQYBGAfIqU+wO4KfMuwOD7TdgQhi8mONjHSSPYejZWuayi2KIpxfq8XFh6dUhSa5fFYdBTeCMmcKKOTwsYO/XhyRiHhKensZaLw6Zex4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R2C7QInS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R2C7QInS"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6281A40E019D;
	Mon, 23 Mar 2026 12:27:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y2WVEAMlw4v9; Mon, 23 Mar 2026 12:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774268827; bh=f1La93N+lRfsdyxb7PUfI3wlStivEmBpO9HUtiXQp6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2C7QInSMWYhuFRYA3zrrNtpea6/q4VQzG5S76rGNvr47u6ZHKecv9eiEdYw+zOa4
	 ONLHHyypqRuIelOj3HJFjNSZgutIoW7zlZZvKPIk2Mio1E0jVj+JUs1ZlrwzzIgSLs
	 tGqXFdADgAQnIxd95/kp7aVLu6AZWDjs5JVrERXicdJ0fdUtqWLcQrCB0X+seDaaOX
	 wBgRCtMB+hjnG9XKXwd0j6Ngp2RcUKKXrVQzCq4030ycEF0rw0EUOsKx8ikLI0c4bg
	 b1RT2UBbs/dl0XYkSuebipr1EtJgfGcNR24ITVBrH+31oCZWmUtEjIVETr+Vj5+eZ4
	 i1Hpu0monblBfnY3f6qrYZnuLYEnRYDvQSo9Icd1TPWeZ58VIzxtLUYEH7FxBQ16xr
	 sDTmofbqk4u8PkDZeDhf+xXh0ObgHmpqda/oEvLLyrBxtTokeC+e14dzvJs9L+6u0o
	 xnu22GV9H1C8zGfclw6jqsZTnF8aScJZQi+T6u9mmBmdYYMjvOPhc1g3oIA5nIW01y
	 /WG1jvya5nKBuRv8qVIEf6c6bJeCUbgO/U7ZSYntv4YyEv8LoHLhkgEwJIHvsvxEW8
	 Bk/iFyGYPuvTxTIKFnSWk2GnAJQ6bpJuH29qUdgipIswV96MvSfClBRfwsN08AL+N2
	 ZLxmE6iFyyvt7cLBu1+00NHA=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A616740E0194;
	Mon, 23 Mar 2026 12:26:59 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:26:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260323122657.GDacExkTaRIoWcMx_-@fat_crate.local>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
 <20260321000931.1947084-19-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321000931.1947084-19-pbonzini@redhat.com>

On Sat, Mar 21, 2026 at 01:09:27AM +0100, Paolo Bonzini wrote:
> GMET (Guest Mode Execute Trap) is an AMD virtualization feature,
> essentially the nested paging version of SMEP.  Hyper-V uses it;
> add it in preparation for making it available to hypervisors
> running under KVM.
> 
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/include/asm/svm.h         | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 123c023fe42c..95469c7d357f 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -382,6 +382,7 @@
>  #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
>  #define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
>  #define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
> +#define X86_FEATURE_GMET		(15*32+17) /* "gmet" Guest Mode Execution Trap */

s!"gmet"!!

With that:

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

>  #define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
>  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index e2a29e1144a7..47353bef947c 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -239,6 +239,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
>  #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
>  #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
> +#define SVM_NESTED_CTL_GMET_ENABLE	BIT(3)
>  
>  
>  #define SVM_TSC_RATIO_RSVD	0xffffff0000000000ULL
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
