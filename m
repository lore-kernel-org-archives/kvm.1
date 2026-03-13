Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2821B191
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362327; cv=none; b=KnFkm4SB7pMcYPZUY8PRGKHgHqtQHG+Kb2epYf8erDMcrLzPIE/unc7JLUp/QR3SLmsaaTo0Wxqt5Be2ZwF5jLFza/wGGw0vogWkrj19QGKQ+7LPXvt8K6JHdhZ/I/d0mAHgd8/F1tJEe9rcAjzS42KHeltQIC92wRIqp9cWWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362327; c=relaxed/simple;
	bh=zCHDmUwlHgNjSHNh0xcE8X4h9oqkDg/q3tMYn+q9vXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lNtqSla8Sx2lV5+3X+t+r0wHrCw8AfmHFLE48S+9PmByOx+Hx6RzD3t4qSKVLwph2MiyG/wOr754y16AMynYE1BOQHOWUviWzLDxWLpSOepk3zrv13eliZW6LtdCM8poSYZ2CeTkIOIKTMxhYhd7g8BgyKt4x7sADgpswjQ0SEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBWdt8go; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBWdt8go"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so933070a12.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773362326; x=1773967126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrA9+DazdYkJgNz+zHsE+a3JealnAO/XZn/zqlAAy5I=;
        b=vBWdt8goVQRPFNCtcF0+WLDiTDfCBsNkpTS+E1scf0eGU9dVdzuZ+QrN4rl6zcXKL7
         wiyCsIbk6ohBkdhijRcplggoUhZIsQ+pS3TqLU21hMFJfwVdIVU51y2mFVRJlBfrr0tY
         /UWGLtDHv/amDGWBBbWcvRQhnz75wxbI6RR2Kt6m1cROP5ZFBuFVIGkJgLc7/qYajtDL
         i9YObveaeoldPZSEOwTEw+wyCjvaNnZOhJr7tkN70fUivaZgKKs/p55kDwt9TN+9a1MS
         BNEatxyyRktVuZYOuNpgJWiwIf2T8K0znxerD/ZLBvIsIXHdeAw4ojYO5T25O5gnV80h
         8/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362326; x=1773967126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrA9+DazdYkJgNz+zHsE+a3JealnAO/XZn/zqlAAy5I=;
        b=h13BY/FwAptuui7V/1s5vcfqOmrECQ1b8jTw21mUBEJUx0dTdKmVCKOkw1j/DTeYs0
         Vo8Rx6cRNXj2UHlAt83LZ24xvls7t1oHhgnONKlLl4btQxGYobeorY+ZgRwMzaf3HbUQ
         uaSFGa5u3xwn1F3cMKcdxXLWPeikDarHjNg5SmB4EbdWvTLAox6/uiNdJMC0rNm5ki60
         dmAjqn0Dp4bHFTeUDEroNJqsbahCFtwF8zeRInusZubeNw2MX6OgAW0qOXmZjiopq0bi
         9lQVQQm926j8dQE/YKRPsT6wWbCA9RttvjyyyEc6kfrpd6lcim0nuNLZM+7tSwGX2ZE4
         GMGA==
X-Forwarded-Encrypted: i=1; AJvYcCXajMbM4/4w++dQKxteEGDaYldb/O1jdhEM9yFkub0XfDMW+Y6VCMvm/X3Llssmb3ebStA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3NfV/Enlhh2aDYPDaFy01sm2XJTQemiTC26KXG1WYFH3QUFb
	p8o4bmyMfSIKGtSt9i8GYBXcJI+sAgbomp/POoPLj0FW+lIbkWIkj0Oy2zraIJE+mW1bniZOcIO
	S7mYICQ==
X-Received: from pgww18.prod.google.com ([2002:a05:6a02:2c92:b0:c73:7789:143c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:134b:b0:398:7853:dd8b
 with SMTP id adf61e73a8af0-398eca32beemr950504637.9.1773362325740; Thu, 12
 Mar 2026 17:38:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:38:44 -0700
In-Reply-To: <c117141f-61da-4572-98ea-7a8a79eb5bab@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <20260311003346.2626238-5-seanjc@google.com>
 <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com>
 <abFulxXuRziXj039@google.com> <c117141f-61da-4572-98ea-7a8a79eb5bab@redhat.com>
Message-ID: <abNclCT09InLIP-M@google.com>
Subject: Re: [PATCH 4/7] KVM: x86: Add wrapper APIs to reset dirty/available
 register masks
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 11, 2026, Paolo Bonzini wrote:
> On 3/11/26 14:31, Sean Christopherson wrote:
> > > Not closely following this series and don't know this code well, but
> > > this API is very confusing for me tbh. Especially in comparison with
> > > kvm_reset_dirty_registers().
> > > 
> > > Maybe rename this to kvm_clear_available_registers(), and pass in a
> > > "clear_mask", then reverse the polarity:
> > > 
> > > vcpu->arch.regs_avail &= ~clear_mask;
> > Oh, yeah, I can do something like that.  I originally misread the TDX code and
> > thought it was explicitly setting regs_avail, and so came up with a roundabout
> > name.  I didn't revisit the naming or the polarity of the param once I realized
> > all callers could use the same scheme.
> > 
> > No small part of me is tempted to turn it into a straigh "set" though, unless I'm
> > missing something, the whole &= business is an implementation quirk.
> 
> I like kvm_clear_available_registers() for this + removing the second
> argument completely for kvm_reset_dirty_registers().

Ya, me too.  I almost dropped the param for kvm_reset_dirty_registers(), but
wanted symmetry since the names were the same.  But I like this a lot more.
