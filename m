Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253EC38BF67;
	Sat, 21 Mar 2026 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774094323; cv=none; b=SQ1OYhoL5VtAJ2YyOOAn5tPSHYqcq2LMEyONZg+atJ/HUJTYfP9FJ1UnMehM5yoI9qdhIfAT47lo7RdyaiQMc0vVD+ZF47nhnJFLeMgUtlPcNXDB6AknR6JIrkKMoMDgXsW2yB5kfxx/UTO7t7ejWubviqZienXc82R+e1TX05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774094323; c=relaxed/simple;
	bh=JVxM+IKaVZAdztb0Nlc9QZDYRFQRsNjYSJU61hWMsNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7xwemvxtKY93G3WrPzP0AuaD5hdMr7QA9zwc2TZjEs6GSV63zM/bzdm5V51L5SJNEfQtTtqeAHdLpUL6ZBPdDrdC6lKB/VGMmPq/TnwdPSFK5cywNlKNCQYBQaqnP0R2K9kXhyGYrCz4vL1DEwsB+IidgorwCuUZcw85fuTdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Lg3kw6wk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Lg3kw6wk"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4BCAF40E0294;
	Sat, 21 Mar 2026 11:58:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XFPUnb8RZtIv; Sat, 21 Mar 2026 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774094316; bh=ylHMdZ4PJoYZ2dlS6S/sJw7iL/sQoBP0zol67bstyp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lg3kw6wkcij3AsNWRGnZzCqugxmpgzdv4/aak/hZjqQATs0B2vm9FoOeGcgRrwHQj
	 X7NqbJ4E6tKlXd+yObCXtrlvOs26kPHR6PxnkGmg/gJMT1mcLBwQIW0cbgnvnLkqRR
	 2ZstlXiQvwIau/fAXgWliuaDekExyj9ot07yQHb7YAuiU6w4p/MWpxb9nUZr5BWchW
	 FILIUcQ3jTC/9BFMxcml77yPjs25CWmS56/cPpPQ0gg+Tow2UfV9XXQruycFgkeGfb
	 /Ind0lS3X11mq9e4r2M1VhutxVOlg9hS8vbIq53D4mbLBbXXb0RBefYl7k5gLx4rTa
	 bTcPFIsFOZaCNr4XoD9P+/PqCccvbhoGpM2qF7yMTLmIhdzFj1LEOsY08cUURISl68
	 Ighh/IS3HjEbjy1KD1JlZue6gpvXrGD36ZA3WIowgdI1Gd+5RZfz7n9Zm4qeIhXCPp
	 bzeP16mcSy4t8Q4VJ9AtAKoktyAMJ15yeigWe7B/WtxhiczbEtoZi9eKrBweLDesJe
	 S3rOMsvr4faoYLsYykL5xeMQx4WqtCo5kYVz+lVHym9tP2Czn8m7GWxIkWjazNTOhr
	 QnspFEWUxaAbCo+7Z7Tg2IWIO+C8SsgK6XaibBHhTZJCuI58wNSBr2o5kC+ayWABR8
	 QUFIqJObjesbuklCTHuz7604=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E819D40E0174;
	Sat, 21 Mar 2026 11:58:27 +0000 (UTC)
Date: Sat, 21 Mar 2026 12:58:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jon Kohler <jon@nutanix.com>, Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 18/22] KVM: SVM: add GMET bit definitions
Message-ID: <20260321115826.GCab6H4lNYIih_g0B0@fat_crate.local>
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
						      ^^^^^^

Why do you need to show it in /proc/cpuinfo?

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
