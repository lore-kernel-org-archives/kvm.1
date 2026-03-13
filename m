Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DC18E02A
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773363919; cv=none; b=gRwg+Rv/iuSEyK89+a/oCQRwJfL6veGnR909jmA/63UKab84/aboQ3MACTORtymVWrpVLAny4d67d1nfed9XDYylHuPzrh2g/6rGWZcFMA2p60HixBWxVF/cnZyTjxlNhv5UgKNCqv271Bt1Ydv+RmyRPXSHL3tv9tvKKdPDI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773363919; c=relaxed/simple;
	bh=wbuFVWAeiNckGIc/VTlN2vSDoLhJ4m/G7+o5JoybNew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lRGjtpLF0HMbX2tL3fMTohIQGtBB527TbizKBLvRUllWTIsGDf03/3KHkli/Xb1U7ORE6b88jCly7Q5nGU7Ioyhbgof8d0lMoj6DlOWyZ1Q0L/dwU/RcyU/vdrftYXN117tud4zhAcn8MSdCH4IE8zDcJp0Yowk0YMCC0uk1Mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgvAKMxz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgvAKMxz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354490889b6so6669816a91.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 18:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773363918; x=1773968718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yafu8em2C82TADedFvrLvlfMY3we19GznUPlgpBFLgQ=;
        b=lgvAKMxzY3C8o+OCEg+1t5yJAAaK2OxlZVpcF5VcRLoGgrIwhCgKOSZkI4minaWoIB
         QasL/7PiEvZ5NNUGbZ/2WBpC3xlif8uAMosQSz7CoqyNyflp6uRyAEe7PpvW/Wel9KKA
         pSx7QQ+RG1BtN9afHh4Dvx8mp6yaLSBJNF+uZ5RXUIRqEyrsZEeBpxF//wy7hPWncY+6
         SSgo0PSoCiSI1RUHRZ7OSkFe0gqd6cuoFUiSX5QUOmpioKCzy806Uqgh5M/7W9MgxmtJ
         nG+m+VvVw5c0uOMMKaboZ36y7ofrcERQUGU4s72VBzS/tLdpEmK4/br43tuB9tugLOfN
         2GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773363918; x=1773968718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yafu8em2C82TADedFvrLvlfMY3we19GznUPlgpBFLgQ=;
        b=SdjfdFHTwErtoUAeIpWcQyUcOSlB9qlQWIRe20wDB5HJIsW0KMWDa9OtZ6eRnTi2Ua
         MbvydyQt8Z3IoRtD/Y6yip61QnnecLP6f3GCxtmahsbGgMGkNLl6FElcEW+aBrwwCLIM
         NP7MJtMjVm3ngIhImeRHFeSTQYGwSreERh9QyMZZuDD5EOSEXzIdOo/D1YNZQC220HnX
         GiFIJSdsyWpPUnbcnbRy8jOluy6hgiJEr7MbdRHPkUoT0eWU2RZP7z7dtlKSz1sBOS2n
         ChvsPl5W7KWJ6oBYJvwnfOnw/PRi87OR3Enw230BOWDTtqTQmFSLvARpi7b6ZDbLWXSp
         fM/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8KcnadNTB558Pkg7S9AzeLltpnhu5JCLLSfwMApGKU3SeAtC5wO2sb6OIp1Hu4fOgB60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JwN88bjML6jsTnpAumfc7Kreq1rB3QM3YvSFu7CxuldX2Oac
	8/8ZsO66TIgPGTj/MZg0d2nc4NaGenCwkF2fm3SGXo6JbGxI6ZgZnoHTchRmFO48lTnXY1vf8kP
	yiQU1gg==
X-Received: from pjm12.prod.google.com ([2002:a17:90b:2fcc:b0:359:92b5:da6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b87:b0:359:9073:c368
 with SMTP id 98e67ed59e1d1-35a22081e73mr1218081a91.28.1773363918125; Thu, 12
 Mar 2026 18:05:18 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:05:16 -0700
In-Reply-To: <ac83eef2-e019-44d1-8ac1-078bbe7a4fd3@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112235408.168200-1-chang.seok.bae@intel.com>
 <20260112235408.168200-5-chang.seok.bae@intel.com> <aakEsXJgO-3m2xca@google.com>
 <ac83eef2-e019-44d1-8ac1-078bbe7a4fd3@intel.com>
Message-ID: <abNizJOuhduCTen2@google.com>
Subject: Re: [PATCH v2 04/16] KVM: VMX: Introduce unified instruction info structure
From: Sean Christopherson <seanjc@google.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 06, 2026, Chang S. Bae wrote:
> On 3/4/2026 8:21 PM, Sean Christopherson wrote:
> > static inline int vmx_get_insn_info_reg(u64 insn_info)
> > {
> > 	return vmx_insn_info_extended() ? (insn_info >> ??) & 0x1f :
> > 					  (insn_info >> 3) & 0xf;
> > }
> 
> There is
> 
> int get_vmx_mem_address(...)
> {
> 	...
> 
> 	/*
> 	 * According to Vol. 3B,...
> 	 */
> 	int  scaling = vmx_instruction_info & 3;
> 	int  addr_size = (vmx_instruction_info >> 7) & 7;
> 	bool is_reg = vmx_instruction_info & (1u << 10);
> 	int  seg_reg = (vmx_instruction_info >> 15) & 7;
> 	int  index_reg = (vmx_instruction_info >> 18) & 0xf;
> 	bool index_is_valid = !(vmx_instruction_info & (1u << 22));
> 	int  base_reg       = (vmx_instruction_info >> 23) & 0xf;
> 	bool base_is_valid  = !(vmx_instruction_info & (1u << 27));
> 
> I'd assume wrappers like above for each line there.

Ya.

> But to confirm your preference: would you rather keep this open-coded, or
> introduce another wrappers for each?

Assuming the alternative is to open code both the extended and regular versions,
yes, definitely add wrappers.
