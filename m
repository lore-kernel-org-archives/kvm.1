Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301024DF4DC
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009688; cv=none; b=mJ2y7TLpm9yEjCfRuMG+CCBbgCp4en5lr7G0Qru7DOpvT8QTphG4xponahJbVolWp1J7lK5vtgScN0rsXd9XAb0v9Bzwd+AeCe5zcsJQUIAZGeS5SFqoBYiBluCKeGRR+Bb/IHBCc9Xk7a1C6S5o5HFWdEDwB8txC1nAXN0JapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009688; c=relaxed/simple;
	bh=DQx9hlQjp0Ti326TI6FuSf7aj8Z2x3TJE87fC88XGRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AS4FkO8poqpNdxntnaHyFc8MHSK4ZKin+9MMajDVw0oRWZnnAVmipUo9xoQj1T0RtTNurqaX8EsOaAOdMUXDHF1v4yknZL+l/3nwnZPfRwuHfYXZ+PHR1G5yLgOw/bNw9ViUwM9pH+ZhXLdKhOwa2qzR+PoiYWTRpU464aTRRqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oioiTj9y; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oioiTj9y"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8699b293a80so3359333b3a.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790009685; x=1790614485; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6jcco0yE/Dn2LosJJ4qYi7uiGnh5WOabYUvvtCROxo=;
        b=oioiTj9y9kKyAlo2MeGHXDby17Col0739T/IIezxRYx7aDnu9C4D+6dO8bNqmjp5me
         UxBeKmktNbOoiTsDhuLuHDZXl99Mvv/7rOnXtJRMTZlkbTjDEbMNfjjC26ljhrOxCwHI
         XE1Bh2xvG9yc6axqhTthsSZO7owcSWb3sGbmQFkA3ebWZyJQZaneM2FJfjMLpD7LP9+P
         e92UQC6dgdITIrCPT9fBQBuspw2FS3CuS7D86Ze2pZdaJYsSecu5FW1l7kSwpAvMSJER
         uw5kis67mRFlznrbhieVamQTqRhXdX0l7NNBO4WZ5c6MFmSkDfmPJWbQN1PMrG/jv848
         ciSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009685; x=1790614485;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C6jcco0yE/Dn2LosJJ4qYi7uiGnh5WOabYUvvtCROxo=;
        b=rfc6zZIaBCrs1F3d1Ab0GIJEqQtKxLtES84gw/N6ySrEERwGa8pqA/TKh6tLjGBA37
         MoCpoqVadik9p3bOUxIG1IY5uqrbiOM206WAa6OQEv/MjzeJxGMtXKdplgMH6hvxKHUQ
         v/XQbNTc+tDGjiN3g5gsGMczPq8v3gmwDdi/zNPVlpdaBazCBWL0g2e4fBzIeej+xi9c
         tUM8QEJRIgrCuaG5IpezS5WFLuZu+SoLs7/m5PO4dTdNTy49l6cpSB9D1bt7dzaZSjkI
         iSPn/qMmo5LbjJvC3jMIx5grtIdCldWdyD697BIGjt99LVJ8pHPSoi0Dha9kOeqCwJas
         RNAw==
X-Gm-Message-State: AFuF++ngKmtVJ7Ogmq9jOgKXV8u4PrRbIzsBTEm4UbyPhMUVtoeYBaXk
	tBV4km+1CPxRCdm5ugwYgacZtxlRnoSqtBpnSxyBfKg4DpPDncVC5yhW3QxPbAtZ9Ubz6u5M/8q
	Utc5Qfw==
X-Received: from pfbdl11.prod.google.com ([2002:a05:6a00:490b:b0:879:66b7:29a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:23c1:b0:878:34b8:231d
 with SMTP id d2e1a72fcca58-87834b824b0mr9140370b3a.37.1790009685111; Mon, 21
 Sep 2026 09:54:45 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:54:44 -0700
In-Reply-To: <178999918502.750661.11881169009752034088.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com> <178999918502.750661.11881169009752034088.b4-ty@google.com>
Message-ID: <arFhVLkkGFyGBGI4@google.com>
Subject: Re: [PATCH v3 0/8] KVM: VMX: Harden against interpreting TDX vCPU as vcpu_vmx
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, Sean Christopherson wrote:
> On Thu, 03 Sep 2026 18:03:45 -0700, Sean Christopherson wrote:
> > Move and rename "all" (read: everything I could find) common helpers out of
> > vmx.c and/or replace their vmx_ prefix with vt_, and then poison to_vmx() for
> > all common .c files to harden KVM against misinterpreting a TDX vCPU as a VMX
> > vCPU, i.e. consuming to_vmx() on a TDX vCPU.  Spotted when working through
> > the bus lock series.
> > 
> > v3:
> >  - Collect tags. [Kai, Xiaoyao, Binbin]
> >  - Move the poisoning to patch 1. [Xiaoyao]
> >  - s/Disallowing/Disallow. [Binbin, Kai]
> >  - s/vmx_needs_pi_wakeup/vt_needs_pi_wakeup. [Xiaoyao]
> > 
> > [...]
> 
> Applied to kvm-x86 vmx, thanks!
> 
> [1/8] KVM: VMX: Disallow using to_vmx() in common VT code
>       https://github.com/kvm-x86/linux/commit/05a0c1e2a525
> [2/8] KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
>       https://github.com/kvm-x86/linux/commit/903420c26086
> [3/8] KVM: VMX: Move the shared NMI handler/trampoline to common code
>       https://github.com/kvm-x86/linux/commit/81fbafddf6e5
> [4/8] KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
>       https://github.com/kvm-x86/linux/commit/09c6f74ecb86
> [5/8] KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
>       https://github.com/kvm-x86/linux/commit/96a113536fa0
> [6/8] KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
>       https://github.com/kvm-x86/linux/commit/881455777a02
> [7/8] KVM: VMX: Move common VT getters/converters to common.h
>       https://github.com/kvm-x86/linux/commit/d238df58b1e1
> [8/8] KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"
>       https://github.com/kvm-x86/linux/commit/decbd448b05e

FYI, I'm going to rebase these on top of the TDX bus-lock series[*], i.e. these
hashes are going to change.  I forgot that series needs to got to stable@.

[*] https://lore.kernel.org/all/20260819094903.3060020-1-xiaoyao.li@intel.com
