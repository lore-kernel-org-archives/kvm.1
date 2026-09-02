Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0613D34AC
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365750; cv=none; b=nTsnQ7wcdG4m9gzX0rtkS5VB5MF1kwPwAdstGL+4TEfn3BbCGxVnZc2q3dhKmCVRilrWupwvdK9XiJjWFjutbXEIKcknCb7QiIWj/fT1rrzh/bl/PJ7ooFRpx5BaSS2zpL4l4n8XTXl8pov5qU/iwYHR05wd8gGKwOV8HySY+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365750; c=relaxed/simple;
	bh=VC3BIA4z8tTod7eOwAwIVJQf+WxwGfjN+GG1wwfYEyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3NI596DN3n12UrMU91ntxAb5L9Wl+96TDGdWGHtm+0XFvHJi7eqfZ39SlVXuA9cJqV/mHXJ7mYLjDPf0JAUJXtltFLvBFulJTnGVqizyMfB+7fA4D2MO8Iw5tavPzWDrktU+TWxniQxNfZd3H2Ct0QR58fUrBP2vnQmTb0GFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HK1hwIfi; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HK1hwIfi"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1828682a91.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788365748; x=1788970548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=by2TPfLEm14WX+cS0Rt795GzdWqOy1JzuLSmI1QeMp8=;
        b=HK1hwIfiJ3VoIWo/HAWCGnmG+LhAmTlCtPWDEi7qUvTWadSEQcvZGcE7LT5ERX98UK
         gwPq5qRk6NebOkddi5K7Zt055Psz+G7EqTWzHUeqitfw8WzU40CrG96Q/4s+sSv2tpfU
         U/OCcVN6KcXtzL3SWbWmrfYz/WaPhdxl6Xdc3a5Wyd/lTdcNYlOxi1fFMc6GE/R0dool
         R74EBK3isTsQOSxOWjR21b8LbX557ZBRkfhDAwVkd2AOkA7jAvx1PjOoooPIQaZ6kbVc
         nshPbh1R34N3iTSxnBPTkGPmyc9CeZGhfBVJWu7uCLIXTL7NZCRyICb5lEohNutbGM9v
         Hc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365748; x=1788970548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=by2TPfLEm14WX+cS0Rt795GzdWqOy1JzuLSmI1QeMp8=;
        b=KDr4/QF2YxPsdAZzLvjMwm5kC+iWqEF9XH3VFPmfKKEbbC/IoCXUG9tjElQpRdx26X
         1jxWCchqJKtxtsmebIuUQAtpgK9S77KWfNEwR2JC+GUyxkPGgVneIrao2UWZeD3u1RHo
         ahEN3GbTAajHM1NLBjsiBe4nZcbS6TEbelCSMChIn2g4E1a8TjrCieAreiz3p6o4wzYq
         eDmrsyl12rd6mA1tO2gYLgNI340YTj3TelGyruyPn3i/3+1jL7JnV8BAzPdHmJueB6vL
         RO8rdo76RvrNMRLiSYIjFgQRxtjk1BKlmgNUTSvHee4Vv4PBhMJujhG3VmPa8pAr01J5
         EnOA==
X-Forwarded-Encrypted: i=1; AKwUvBz33u7fC4Ml1v07AdY0IefznVlcaHuCeY8aKq+xsUQHgHOgJRqmw02S7AR2/95NAkXwu7s=@vger.kernel.org
X-Gm-Message-State: AFuF++mazuszopJrbXXyvS2RHPY7MvKfe7rRLiWbPgWjYBxVao0VBUo/
	pdzeudC5rYEYtUDvRSeds+JVurNCvb8+qs98goGdO6HLf9vy7camEm8TgB5ZyXU9LLMpYxTj8QU
	k0e+vow==
X-Received: from pjva21.prod.google.com ([2002:a17:90a:d815:b0:381:1b76:a387])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d0e:b0:398:9bd1:3216
 with SMTP id 98e67ed59e1d1-39aee1763a5mr9164572a91.23.1788365748120; Wed, 02
 Sep 2026 09:15:48 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:15:47 -0700
In-Reply-To: <apgj5l7DZGsScsNc@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
 <apIf7eoMxdfV_7kE@google.com> <apYh4GDHD3Tdb8t4@google.com> <apgj5l7DZGsScsNc@blrnaveerao1>
Message-ID: <aphLs9F70ojtzh-3@google.com>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Jean-Christophe Guillain <jean-christophe@guillain.net>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Naveen N Rao wrote:
> On Mon, Aug 31, 2026 at 05:52:48PM -0700, Sean Christopherson wrote:
> > On Fri, Aug 28, 2026, Sean Christopherson wrote:
> > > On Thu, Aug 27, 2026, Jean-Christophe Guillain wrote:
> > 
> > So, rather than trying to come up with a scheme that is performant without being
> > too complex, I'm planning on fixing this by simply holding kvm->lock for the entire
> > duration of vCPU creation, so that KVM doesn't need to do extra tracking and can
> > instead rely purely on the array of online vCPUs.  Then we can revert 97d65b544f48
> > and do more cleanups on top.
> 
> I was going to report the below lockdep splat I am seeing when trying to 
> enable Secure TSC due to commit ba903f738249 ("KVM: SEV: Assert that 
> kvm->lock is held when querying SEV+ support"). I believe this will also 
> be addressed if we continue to hold kvm->lock during vCPU creation:
> 
>   WARNING: arch/x86/kvm/svm/sev.c:136 at sev_snp_guest+0xb2/0xc0 [kvm_amd], CPU#170: CPU 0/KVM/5532
>   ...
>   Call Trace:
>    <TASK>
>    snp_is_secure_tsc_enabled+0x1a/0x40 [kvm_amd]
>    sev_vcpu_create+0x77/0xc0 [kvm_amd]
>    svm_vcpu_create+0x5f/0x160 [kvm_amd]
>    kvm_arch_vcpu_create+0x234/0x2f0 [kvm]
>    kvm_vm_ioctl+0x232/0x1c10 [kvm]
>    ? __lock_acquire+0x465/0x1b10
>    ? lock_acquire+0xbf/0x2f0
>    ? __fget_files+0x2b/0x190
>    ? find_held_lock+0x2b/0x80
>    __x64_sys_ioctl+0x97/0xe0
>    do_syscall_64+0xf3/0x880
>    ? exc_page_fault+0x128/0x270
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Oh, right!  I forget about the wrinkles with kvm->lock not being held during
vCPU creation.  This is largely fudged around by the kvm_get_running_vcpu() check
since VMCB initialization is done with the vCPU loaded (i.e. "running").
