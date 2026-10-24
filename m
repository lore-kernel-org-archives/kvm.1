Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807410;
	b=BGzykWJEc8yDmq1jittjIStH5zH1umstNVzgyrEHwX5id5IevhRx4+IsZmfgnPNa/iCb
	 AIkyDcNrU6ucC4yCG4fbK6WnllfITo48da43gAXumN2QaKR4KlMhBBdO8ppIBlJyCpeQq
	 IeF5EeIkiTV53dVzdROaijiwdASmCIE/lHlhWQIv/OcAnoHup8Ah7yQQT7bzRKx0V6wCJ
	 SYY6YcJcv47YEXYbm1Q5q1zuXSLYGYeEoAE4fKY58vb8+rD71wN2gjUwDgNFkMiK13izR
	 JugY3fuQFkRlmzUaOoFLKU7hMRt6CeEkNaxfcZu+xNcdyFRfPio39OHF6x1v157fRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jNxeypu/UiKv86Z24ODkNybt5lTKhyqeVQWmn/P5E/Y=;
	b=lW7E/sFpn8FHu8R+ywGiDIPZLFsxM+ORyAADS2KSZ8vXEhvyLzJtkINjFv2Gu/z1LBJU
	 a6szjViQa87/8z3Y2WOKmQavLG4zY+KIMwuxQ36HKfbdngMyhMjFkpbD09o05Zqoj+Yug
	 sTmif06ORzSmQXQCYv3HSiB3ElmrPSijb/yWow4NgEwsX+X+SQneWEfOyUoh4dUPKpJNv
	 IWVhF5/SNs8kWc6YlfBMNMHeCqwGKSR8F17JFOKDL7satsRUJqenDvfsEH87BRFuvl8Cj
	 rAvHwRv/b3OODXikeQ1SrXUhNMpg+mZTzfuYrvN7aoq3V3EiMhrTZ8wRNUtHtg5IRHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="JTnK/Twk";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6B606A31A
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 02:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JTnK/Twk
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3adf71ee6a5so94864a91.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792807409; x=1793412209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNxeypu/UiKv86Z24ODkNybt5lTKhyqeVQWmn/P5E/Y=;
        b=JTnK/TwkMcpKjowTRm8Bj3UffAyiFW5NWIMJchCcd3KE9O1wn1UF5MUBQN5NVgFam2
         IjEy8EDkgVmSG8hcXAACea8b9ysnom5zg89hvfeAhXJ5SPyEeqvvlyAs4pCG38XunYy2
         rJZbdpxw5R64duX7wDGXQI7auzJFXD/5JkNWtpTM2cdN0zYCFkb9T7g7zZMBb5vJTVA1
         VnToql/FQW5kI+SpyAOcNVR4srRpmSsu2Bh9RrZaLvcxrMYufhJT+xnz36SgSM7n9QsM
         nrzxYyZvW+5nF29MLihQ8Mxv++E5vvYtkD2fQ/8mLVLWca1L7l6uZCS+bKaHY5ya0lDw
         XVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792807409; x=1793412209;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNxeypu/UiKv86Z24ODkNybt5lTKhyqeVQWmn/P5E/Y=;
        b=fxThczZIOJP9MqFQnfoyDsobU4Amx9+VM6ZIcj0OYiChANy9DrWwSYHqAFGH+KA/KG
         jzuWLGGUehB+q2rKPzXQTiS14oht1J+mISeBV8d/9neO26N/257O/TI8jfk+IepSHhT5
         qT6t77rJv+nHck9l48Q/hznR7Pdna8PvKi/+1xfi9dyjH8S8IUo6joC05nOyw6ZbbcSV
         k5gFPbiIQXbL67gpjoDQ6Qm1UOPlsmBoi6kA9MJR976lekBjSHVvbh23Qa9nzc6X2wCa
         hwxXeWHaZTkvRx3x2neJYd0kcq8O0FKTqdaCjdG8iBAlOW4Vp5AELFw3rTgTlYMwjbNt
         MEBg==
X-Forwarded-Encrypted: i=1; AKwUvByevxz0JUQ2bt+iIwmFBolR4Bl4Vp3taDLHihARoW2kysKIPsgD2AXvM3TqkIiGkUvWjpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGD3sxXuD3bBgk3/+vWNd5J3jMVbx+4tV2IgrBIfO1l6p/w1Kh
	8W78Ay9w9A3t7NXkE9Kfrf9bTVBMWYFWeCwSc8ZLtj2b6YXGXvTMVbNuUPPQ8oCmF1XOjLufwhj
	/0jp/sQ==
X-Received: from pgmr20.prod.google.com ([2002:a63:2054:0:b0:cd8:bb5c:4aef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3846:b0:3ac:945c:7f69
 with SMTP id 98e67ed59e1d1-3adeb162362mr786457a91.66.1792807408684; Fri, 23
 Oct 2026 19:03:28 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:03:27 -0700
In-Reply-To: <4e1d5d94-9956-4cc1-af5f-1311461ab233@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022210134.612848-1-seanjc@google.com> <20261022210134.612848-3-seanjc@google.com>
 <4e1d5d94-9956-4cc1-af5f-1311461ab233@linux.intel.com>
Message-ID: <atwR78qCo3qeUXLH@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate
 when filling CPUID entries
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Changyuan Lyu <changyuanl@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 23, 2026, Binbin Wu wrote:
> On 10/23/2026 5:01 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index 271c2f94b8dd..37d088f6f7a8 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/cleanup.h>
> >  #include <linux/cpu.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/cpuid/api.h>
> >  #include <asm/fpu/xcr.h>
> >  #include <linux/misc_cgroup.h>
> >  #include <linux/mmu_context.h>
> > @@ -163,12 +164,23 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
> >  
> >  	entry->function = (u32)td_conf->cpuid_config_leaves[idx];
> >  	entry->index = td_conf->cpuid_config_leaves[idx] >> 32;
> > +	entry->flags = 0;
> >  	entry->eax = (u32)td_conf->cpuid_config_values[idx][0];
> >  	entry->ebx = td_conf->cpuid_config_values[idx][0] >> 32;
> >  	entry->ecx = (u32)td_conf->cpuid_config_values[idx][1];
> >  	entry->edx = td_conf->cpuid_config_values[idx][1] >> 32;
> >  
> > -	if (entry->index == KVM_TDX_CPUID_NO_SUBLEAF)
> > +	WARN_ON_ONCE(cpuid_function_is_indexed(entry->function) !=
> > +		     (entry->index != KVM_TDX_CPUID_NO_SUBLEAF));
> > +
> > +	/*
> > +	 * Explicitly zero the index when it's not significant, even though it
> > +	 * _should_ be meaningless.  Userspace relies on the index being zero
> > +	 * (the ABI was inherited from KVM_GET_SUPPORTED_CPUID).
> > +	 */
> > +	if (cpuid_function_is_indexed(entry->function))
> 
> If the information about whether the entry is indexed mismatched, i.e. the
> warning above fired, should we use the information from the TDX module as the
> standard?

IMO, no.  All of this information is available at module load.  If we want to
harden KVM (and we probably should), then we should apply these sanity checks
(or equivalents) during tdx_hardware_setup() and disable TDX if any of them fail.

Anything else is a hope and a prayer.
