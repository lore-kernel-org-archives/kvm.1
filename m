Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CD2D8DCA
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773159656; cv=none; b=dMLtB+CiP4XwSoZgZMxLCxLYha+/tM36EwNZW3j5mWipIkGDEMmfXOV5rxT+WFCxae7nDeFU/88EB4LKcCwXMZ+aVidtaS7Jxborji8/KGa67ca9hj02EbAY+eqYxt8faeqacENOQIW3i8HlI2o0nJ6Kjmrr1ie/qPq7tveYxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773159656; c=relaxed/simple;
	bh=H2A8oYQSsLjkmNe0jsdMK/kwihlmo/89Ly73ngie1dM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYW7DPCWZX4aIccrYrOEZwUOu7N5fuT6UxVgECmy89WkMzQoZZwf5n11GQSicsU9uaYPNNIDDQnhXqGPeV4Op9F63tL9oEvAPLeHbuedoq/MrJT+8qfyxnfIRHqxCE9iAPLZbQVikMFnrbk+HtOpxvdYlbPhrVZ6xEAXVL7yi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlNku7Or; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlNku7Or"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7398e393a6so1762454a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773159655; x=1773764455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SSbH19unAfgNgs+mpGxRGvCupxcKVgFYCwfe4OyQi8=;
        b=UlNku7OrZo7vO7+aFawGnsvmPM5PZntPL+9W94tIK83UiOcHhYYazwOMHFwb3pNxfo
         GZS48bhPdow4wyr++CWMEemPmfZfaPJdCwbKNcDjiF33Y3vEB/TdfxJWmeaCn4w9QNm+
         QehGLoe/WOqC/X4Xb36hJleDnhEpj15yTfFf7x0b0zj26TokjNyrh7Hgex8P4GdHcnmZ
         h4FWnJdJx7yolFB0/Q9FeZVtinZYSN0f/VT2mZjZzcQ5tEy8Ei3rxdE/YxdbN3ZZYFVL
         8Oszkdfw90I9LTinh+57HOCQKAbdraaSFdGjnPO83Z0Ac0YPmzO+X6rRZDamJmuwqqoK
         eZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773159655; x=1773764455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SSbH19unAfgNgs+mpGxRGvCupxcKVgFYCwfe4OyQi8=;
        b=Z3XYph6eSa+YzSFzWd5pOhDSosz+NCSpHVXGKd1nus1kyS+pcvXLPQrw5XG/Tn2MHi
         CYqVoC46bkQp6TlpMsxKCZOKIwPXCvjUvARMefq8K6BXnLA1OqQS3M6PaYtE46QLlu9I
         Mjo/RNaLBFQ6ib4HpRLr7T9vVoHBBkiWj1cr5q4ZJWBKwoPo9CHTRXEwntlYARC1EjSF
         C/qlYt558C7r1U9DGuNN+4sIWfySe6TCooV3NJeOvlAP4QpRLYs+/R7nVa5z0hlZHIpH
         J8ivM+R5eldzwjkJXcF4QKtd+Ml0E9mB2PyldvnsUc94jisPiO6Hr2U4c8wZMW1oZfb0
         iNbg==
X-Forwarded-Encrypted: i=1; AJvYcCXnoha1PkafneUakVNxvZX+MFyWvl6t3Dn9Aj5IMq4r9Pb1OsLwxl70ASoJdI/4PSlGR6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDlqKgtaAhi/ctdHo/ugXsW7DfEH48tEY9t1f6AjphZTwQpse
	csFqnijTlWhFSCTz76fle/Vm8v56T0azb5c32xcjLACMGz4kfZUzVxPDT1ObKOyL6xeX63V+nuo
	62SOHXw==
X-Received: from pgbfy10.prod.google.com ([2002:a05:6a02:2a8a:b0:c73:9dbd:c981])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf88:b0:398:a76e:4ad4
 with SMTP id adf61e73a8af0-398a76ec12amr4493001637.21.1773159654647; Tue, 10
 Mar 2026 09:20:54 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:20:52 -0700
In-Reply-To: <948e099c-ae1c-4586-8aa8-ff4946f47e18@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-6-shivansh.dhiman@amd.com> <aauIc-wOXr__Qn1u@google.com>
 <948e099c-ae1c-4586-8aa8-ff4946f47e18@amd.com>
Message-ID: <abBE5GC0QhaoWDVb@google.com>
Subject: Re: [PATCH 5/7] KVM: SVM: Support FRED nested exception injection
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 10, 2026, Shivansh Dhiman wrote:
> 
> On 07-03-2026 07:37, Sean Christopherson wrote:
> > On Thu, Jan 29, 2026, Shivansh Dhiman wrote:
> >> @@ -363,6 +363,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
> >>  {
> >>  	struct kvm_queued_exception *ex = &vcpu->arch.exception;
> >>  	struct vcpu_svm *svm = to_svm(vcpu);
> >> +	bool nested = is_fred_enabled(vcpu) && ex->nested;
> > 
> > Reverse fir-tree please (swap this with the line above it).  Similar to my comment
> > on the VMX series, us is_nested to avoid shadowing the global nested.
> 
> Sure. Adding is_nested() helper should be a better choice. Will do that in v2.

Please don't add is_nested().  In KVM, "nested" means nested virtualization.
I don't see any reason to add a wrapper, it's a single boolean.
