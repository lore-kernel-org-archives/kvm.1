Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B5428847
	for <kvm@vger.kernel.org>; Fri,  6 Feb 2026 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405292; cv=none; b=K7e185zGdznM3y3q4maopUbeM/Qig3BsZntJ7b8Aall4GJ+JjdSGj+AXa61VWo1Bo0Etw5u6XTbNVAPme/6gDYj0ut8WnY1QCK1kMrvV97zCzbu9qswUNxqUj8+bw6NT5yEkplCd1Cb6FKwnFV9fuWQlTkZQzCx41O1F67Wkovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405292; c=relaxed/simple;
	bh=XDqbaL/+ZwoNANIBsWT9QQUJxMyPsyI1W2EXJqKiKlQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MtqWRf225dU5xTHNpn5I+xs1uL74LGz3XRzBBiXBwrG6GAbNKga/LcLSxoyW8X51SLkH6ocdCK3p7zMUh27JfK9mEhgUWS2qHJe14dDNvUmJpc222fxNpYsb458TM2/NOsQcRQpJk9D0GS1KVbEHrGIiJIPKJlYXet5sW2I5hM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tMkCePIV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tMkCePIV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354490889b6so4027593a91.3
        for <kvm@vger.kernel.org>; Fri, 06 Feb 2026 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770405292; x=1771010092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSxSO9gGa5ljx02Wj2q4xRxhtqlPATJqyadJe+h3DJk=;
        b=tMkCePIVQUQTj38p5+kZI4K/uAvpp54JOVT0lZVG04A4QZ8lHnoTSnQrZPq/cqunQf
         mxgOGbrypPCM6k2Fgandd2vwBDuO0PetkIwdjVhCRuh/oRpWaDPD4cVjvmWtyxoki0aN
         kcblFRRqy7FwByT8rFFHIGYjRtCME3A9fBxETFnu5938st2RNiM52GASFrD87c9ES/k4
         09TsqsyeJQBtbWrgRq+0H/kPOhwsQnNBXcwyY5hclHj5PxruRVLkYVzBCLhkX8pDIKiU
         MGbatxNkz2YSLj1Ui4okgYBHnVQqdtl23VI8CcyFwEC5XbgrT4+OosbNiy+dxuirwHgl
         M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405292; x=1771010092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSxSO9gGa5ljx02Wj2q4xRxhtqlPATJqyadJe+h3DJk=;
        b=YY/WduYPELGhiFfQak6vICyguuavBV/WNpthZ27fmaA6oOOcKhgCF7LzZfyiAGPM8E
         e8KRenIXY/r9z7eZ8jCLMimWxFCDCMkA31z5WVXkV9JEgODnsByziAon0cRbKMockpQB
         VgtGEJee1oMB4kiqVxaGCETR9fCLL4iiULrECsB7P3iijdY66d4btPqRpIsHyx+fRrUJ
         Vqu/2YFZNv6cYfznU0NlTalwhAwGj+GPUVnQgZUEMzsLk1QBCxvCH4Ng0PRye5vW44Q1
         r6Thrdf2wW+KSQ7V3iMpMyMFlJx3JC+hS/hZzMSaA5rjiM5x2nI2/iBoThRFcUejAvAY
         lnyw==
X-Forwarded-Encrypted: i=1; AJvYcCUYtAikGbAOEyOeSy62TY9CG7itY01pKIrGeDEF1r1IBk1aLd9s9oNL/LF1ccGepmstIkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtXScG0epfL3al54Z0/dSkQyzmlZerC6TIihbzABTFnV6MBeD
	Y84IoeS6LSY9I6xa8QSgjQ0c8hx6MHYkwvH6+XA6hNC2evb2ZOQ2gjCV5kwdia06PBDpGcC0YCE
	fXW/rhA==
X-Received: from pjbkx12.prod.google.com ([2002:a17:90b:228c:b0:34e:b8c4:7cb5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5281:b0:354:9b26:cdf7
 with SMTP id 98e67ed59e1d1-354b3bce641mr2873691a91.14.1770405291868; Fri, 06
 Feb 2026 11:14:51 -0800 (PST)
Date: Fri, 6 Feb 2026 11:14:50 -0800
In-Reply-To: <0468715595718af34a8a3551663cffa79dd3ce2e@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205214326.1029278-1-jmattson@google.com> <20260205214326.1029278-4-jmattson@google.com>
 <aYYxh8EiLrBTiq0L@google.com> <0468715595718af34a8a3551663cffa79dd3ce2e@linux.dev>
Message-ID: <aYY9qhsOMv_M9Ray@google.com>
Subject: Re: [PATCH v3 3/8] KVM: x86: nSVM: Set vmcb02.g_pat correctly for
 nested NPT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> February 6, 2026 at 10:23 AM, "Sean Christopherson" <seanjc@google.com> wrote:
> > >  if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {
> > >  new_vmcb12 = true;
> > >  @@ -656,6 +653,19 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
> > >  svm->nested.force_msr_bitmap_recalc = true;
> > >  }
> > >  
> > >  + if (npt_enabled) {
> > >  + if (nested_npt_enabled(svm)) {
> > >  + if (unlikely(new_vmcb12 ||
> > >  + vmcb_is_dirty(vmcb12, VMCB_NPT))) {
> > >  + vmcb02->save.g_pat = svm->nested.gpat;
> > >  + vmcb_mark_dirty(vmcb02, VMCB_NPT);
> > >  + }
> > >  + } else {
> > >  + vmcb02->save.g_pat = vcpu->arch.pat;
> > >  + vmcb_mark_dirty(vmcb02, VMCB_NPT);
> > >  + }
> > >  + }
> > > 
> > To reduce indentation, how about this? There's a consistency check for
> > nested_npt_enabled() vs. npt_enabled, so it's guaranteed to do the right thing.
> 
> You mean the one that goes away after this patch: https://lore.kernel.org/kvm/20260115011312.3675857-16-yosry.ahmed@linux.dev/?

Heh, still fine.  All that matters is that nested_npt_enabled() can't be %true
if npt_enabled is %false.
