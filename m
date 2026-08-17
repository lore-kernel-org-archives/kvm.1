Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BB3F6C21
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974556; cv=none; b=mzcu2YVpgIiGv3Vc7he0s7cBXOwHnYc4wYxtY5z/z71zgyjyK7PHQe5nAPEkUnmS7AYTjCkSl3NkTIoK+XS/lQfMCDSIAOZPqpjr1qMreBnmam4Rcev0A2u8+Xnnwmu89jukQSa8oPdyOBlY8GhpUNubQynDMRBlagMdSxNimME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974556; c=relaxed/simple;
	bh=RnzOzGFK1YB2l72myPyapEsUaP3t6NWRMrFrNJEQl10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZX95TrW2sKGY0lm4ihuyB92oNlAH3MZhzLOVSR5viKvM29cp3Ymk4g1vwo0DnF8XVjvr4HINIEcT5xGjveu9RKm8YwIS/ap0m6MbPqNwo4aSbpzyxz0unkYYuR1gwZ9IlVcXyMs7pgasGNClLKKq0XXimD8oSPmIg2Oka5jWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAL/nVvU; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAL/nVvU"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84842381150so3693443b3a.3
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974550; x=1787579350; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v60n69Fh2rc5rSD04kHKtxhuZ7ZKSWjk5+HKb8IHNFo=;
        b=HAL/nVvUMPBivZ43UUd+giWW/Udfmu42kJfzKWefTb/oL1V0RNE2QcOGINIJjDV045
         M01eWuJxvRyDWD3GGGsRqITOo/N42gcXbYOG3iaOcKZ/iFxj3jH5zzzfWZta0L8quFiF
         1fiHLxjmGoz3LsdYHmBlig1NXBKwBmLsCPss5+aBJhD8lYjUGueyLgtebqPGUkJTkzlk
         SPusBB5qIl2JviFWe7RbV/Jxrn65kOCYqCGg444C/Vk9grzVeAjJ2UwLiCDLQrJOqD9c
         n4w8TDhlYBo7e1aEPPmNxoVNTpTH5UB0psnVteZWbJXtcq8slHT6HWy07bOCaN3++K27
         rdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974550; x=1787579350;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v60n69Fh2rc5rSD04kHKtxhuZ7ZKSWjk5+HKb8IHNFo=;
        b=jPstClegnXjIVzlnLs6Ov3tcsfA6sbR9jMB8QoBXHhHzOMZcIdhu5FIS9qJ1iclmIX
         cZPOk+2VCjZP3rltxHZwMCI9nYwMKP1zxSa7nuNhYf5VKEoMMNO9n42QjuQYKy1LE5Ls
         PEjdlBt5+k/1eZP1HbI8PlZUh3TnjZ/C5mJa8LIHgap8rO38RX/noXbCsRwdh4PjEtnO
         7GJd4yt70eIqSSwGldDyLncIbQKAqIV5kY0QnJXDXC9aMMF8C2ThCO3Mx/mvRhp9xsVC
         sv+9RYQgKUJNm78VzBx6owusuMPAQSV99iw5nvcdgIjnHmtiFH1sPZpWBKzO5Eqg5f75
         4mTQ==
X-Forwarded-Encrypted: i=1; AHgh+RomntmMRjIz8Klr0Ng33XAujt9RsNKypc8XxrLOX/DsGvN7GJRVkREmLr4HIsj09ccLG7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzER1d97tzFdMRbi9HwUPT+G138OeOoXwB+ErOHxw8LEmXyTypd
	RubKsnFUZh50X6eMlVqCNWiB6/kTSb+CURx1oeaGiLSppRkYS8jPTcbOZBrWnGoGfcIqtxLfCk9
	Xo5FYqw==
X-Received: from pgbfe12.prod.google.com ([2002:a05:6a02:288c:b0:cbe:dff5:6872])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6194:b0:3cc:3d08:da3e
 with SMTP id adf61e73a8af0-3ccda405874mr474615637.2.1786974549957; Mon, 17
 Aug 2026 06:49:09 -0700 (PDT)
Date: Mon, 17 Aug 2026 06:49:09 -0700
In-Reply-To: <e7430468-be26-4f96-a185-a774783d04b6@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814161129.2177118-1-seanjc@google.com> <20260814161129.2177118-2-seanjc@google.com>
 <e7430468-be26-4f96-a185-a774783d04b6@linux.intel.com>
Message-ID: <aoMRVRYz4V_IRWDp@google.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Move the shared "IRQs off" exit handler(s)
 to common code
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 17, 2026, Binbin Wu wrote:
> On 8/15/2026 12:11 AM, Sean Christopherson wrote:
> > Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
> > capture that it's a common handler and to allow guarding against incorrectly
> > using to_vmx(), and to allow for
>                                    ^
> It appears to have been abruptly truncated here?

Ya, apparently I saw something shiny and forgot to get back to this.  In hindsight,
I probably should have spammed v2 right away given how egregious some of these
goofs were, it probably would have been a net positive.  Anyways, this is what I
ended up with for a full changelog:

  KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
  
  Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
  capture that it's a common handler and to allow guarding against incorrectly
  using to_vmx().
  
  Opportunistically use a "vt" prefix instead of "vmx" to communicate that
  it's a shared handler.
  
  No functional change intended.

> > Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> > Cc: Binbin Wu <binbin.wu@linux.intel.com>
> > Cc: Kai Huang <kai.huang@intel.com>
> > Cc: Yan Zhao <yan.y.zhao@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> [...]
> 
> > +
> > +static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
> 
> Since it's moved to the common code, is it better to rename it
> to vt_handle_exit_irqoff()?

Yeah, Sashiko pointed out that I was being dense as well.
