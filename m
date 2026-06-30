Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129D1531E8
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854433; cv=none; b=QPJTmckeHoxrmWO/gGPd1A99ychS59ZjrtveDbiTdEZ0XC1iyKwMJFV0QiP1hq50lillRaZRjIbrcPbeszCq/xEm272FaHCAl+IqL8BqiIj48PPJO7WOBzQ7IIEJHrS0u6VVAsvI6WoS5cjp6G8h6ZHt+kp05ysmBxoZ7Fwm9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854433; c=relaxed/simple;
	bh=/n+duGFnZj9vgLfVjFxc1+AFLhU6/tMFkRyk4mmlD4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rRGTVRfyNs+oYfHTcjInn/XFNohfl933j2Xa+e3VP8cNe0iVS4+oyuMStbyoq9th+mMcT+/TjYvir1dO2O8+ZQ3Box/hJv/xOnPXfZqplsgOK8BTB21audkS+PDgjpYmi8pjxZvULvzmAsf3lIDOXxt81BfYxa3FxXdrVhKx8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkraWR0g; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkraWR0g"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c79e5de32cso39474815ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782854431; x=1783459231; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzftopFDP8FiWfjOlsWLNJMxrI9W6RqxZpV3xiWeDtY=;
        b=gkraWR0gaXkEv5njRKmzPrWE7ZaShggwLyB8izWPmT1V1cP9QuZBun7wPswthqqoVK
         BS9XloYDzf0BIgjxKF+Ajlein6JGm9cTC/ZaY3FQlg6EY1tgbUSRiWFpLpiHa8+25wao
         zRaS12zBaCl+u+2vCZVxRKcijFfd8BbXksTQsiPw3EKkVeOvTtz2TjpblE+zG/UHpAAF
         RPcrAk1ysL+dRjGXOaFfvtgeeBnp3BRWfwDfLTGTY7PHPyptAdpLX6uly18Kiiw/P0V6
         EX0O0qWWGMsVMhaxG5tI87YaqxZVinKZttQP53ublhv7VSwx+z/HHaz+2xlpxaSNBZ6H
         TXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854431; x=1783459231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzftopFDP8FiWfjOlsWLNJMxrI9W6RqxZpV3xiWeDtY=;
        b=kobqXwJ32vHnN5ZDnloTf5HGZojjXeSS6vDs/uPRTsY+Q6/PAI/XfOYlBIr6OXsMd/
         XTXXXaOJ0wJpAF/RY4PbZqE3hpp3Rj/qEL6ecuVfIQg+KPTlMxxxCfaX79l2iiF/aJKd
         g+L8JFpoYlwESq2KYJUATny8/hqsVjIYjyZVBEnta37cNnkjQvT4GzUAhmufc3gy86T0
         VXJlImYeq1fjXs0Sm8lc/uDZaKnV18o7JeLnOyd0VDFPWfvNlUdbVn+AexrzxoGQ6uD+
         KJRPlSOGKS6GyEuVlRQuc2nFanTeW/g107PEKeY0R5QfHNyh9/mvLmf7eT6O+5Rw1wzz
         Zu4A==
X-Gm-Message-State: AOJu0YwoZ5/hnrvhSAKjVfUYTAnrzWiaii8kFDMxKyPdwltKH6zurRnT
	zhZ4lU1aAa2sdA0RMkVm/PgsOu+ZSvG/NuSdrZZyEgD0hhVVLmPORUGmssMaWIDM1EqsB+kfEhv
	sMCIddw==
X-Received: from pjbjx19.prod.google.com ([2002:a17:90b:46d3:b0:37f:6c08:3ef1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:37d:f7fe:4bbc
 with SMTP id 98e67ed59e1d1-3805272a49dmr4084697a91.21.1782854431153; Tue, 30
 Jun 2026 14:20:31 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:20:30 -0700
In-Reply-To: <20260630211845.8E8201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630210156.457151-1-seanjc@google.com> <20260630210156.457151-3-seanjc@google.com>
 <20260630211845.8E8201F000E9@smtp.kernel.org>
Message-ID: <akQzHkKVBCDcEfOm@google.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Do all per-VM AVIC initialization during
 vCPU precreation phase
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 30, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 4a0a2dbd1687f..d71a2fed1a08b 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> 
> [ ... ]
> 
> > @@ -308,47 +308,32 @@ static int avic_alloc_physical_id_table(struct kvm *kvm)
> 
> [ ... ]
> 
> > -int avic_vm_init(struct kvm *kvm)
> > +static void avic_add_vm_to_ga_log_list(struct kvm *kvm)
> >  {
> 
> [Severity: Low]
> Does the function prototype for avic_vm_init() in arch/x86/kvm/svm/svm.h also
> need to be removed? The declaration appears to still be present even though
> the implementation is removed here.

Doh.  Assuming no other issues, I'll fixup when applying.
