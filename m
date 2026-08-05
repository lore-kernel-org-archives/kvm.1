Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22E394499
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955923; cv=none; b=Yk7fd+aKvSp/s1X0Iw9hRUHIwDKGsilEcjuNqVfyLY1/nQKakTixrwAmhOvF2BtduUWViqQ97m+o6qhe0CDCMx/CigdiuI2XFLMM190p1Aq6Xu8uizS6QRqfgQcxj+VscCaO6ZnqyubOCJwMwxoAIqjFV2Q+dhQtUH+Tdfg70tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955923; c=relaxed/simple;
	bh=AJISq/mX2kSr5kvSQbLRpVzSC8SDiz9SMVxObBq6r4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyEBSQDdmoLb9nY03rtkldzHYctzOrjnALoxpJU9rR2IOiNkV/Xo3BRCHBPCEroHEmsLs1RPfEcx7b+aI8j/lCfahLgHvgLSOVYY4DrCgMHao1ajerSxpq8F/jtMg0+qfUgyIOHZQiFEdGW/+fuJxUkbSHlJIT1JDqM/Mzv5MXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ye+q1YYN; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ye+q1YYN"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso1567614a12.0
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785955922; x=1786560722; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ToGqmYCLIsCza1nv6x574MwhjIbpl6LQnMNJCZ7DMg=;
        b=Ye+q1YYNwI/hIRllhz0etQ8Go54c0pBf4iQTi97BDzxjJxpxsyZEi8/YLbqQDf0Vid
         8fADBQDM4Mi098drKKCNAUp9aYYlPuk3UMPBNxFJlEUg4OksTtsAugHy3GRKmHxqwl1o
         oD6Xxf+DqnxelVRErNHJE7NzGOhwNX5ubfj/JxZp15fFxqro69tBJk6NJB2pD3GZ7NdW
         5vQCtO+bOQj2KzC5z9q0yjU2AJE0sd+NLdpKGxYpZo258528SLYN9Pmr4ao64KbMOpc/
         P1EhW+dsi9LRNq+7CmXyIWIGZGbP6SS9L5sNxxYAyQLlK6Alb9x/nd3PZmbuxzaMsUwE
         i9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955922; x=1786560722;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ToGqmYCLIsCza1nv6x574MwhjIbpl6LQnMNJCZ7DMg=;
        b=IsH1lSIMwLVeTz8RQHvAkPK9etcmEt1ghTcIxi7ofE4ZC6noHycozD5EaP2QO83Cca
         zsEtWS0bWqohpP6UpMhjDWHduC7zG9On8XBpivpYu26NsA6Jp+eEZmYxtRG8RniEsPFh
         nUkyqZpV8ozNxp1WS4I2zwcglzGEK61zkA8ImmCSSl9NfH0AI4dlYXjlD5Xds9asnvXk
         dF84CfQZZ6gDJdFkfShZ2A1T8166xeQ1m1HU/UmGF6ZgdiSbk+n4902lNgRY0ddIEIMv
         kOp98gXGSPlZ6A4BU+hAnCMOTwZuwoet6pdyWAnoz1Y1qopw9UnARIT+SdfZ+iOXV0wb
         Et2A==
X-Gm-Message-State: AOJu0YyBKAzmvvwR/wv7U/iyXaORQ+6PfLuEvp9TNevofCxOXiQ5Ux4s
	Cg9znsbfbe3uIWFF06Al+lFfIoB0p6HODazhfQ/jRbL9YRZfgcS+nMHRr6HhyJSy5ZA3mzO03Z3
	DsnlBow==
X-Received: from pgjz15.prod.google.com ([2002:a63:e54f:0:b0:c85:9c9a:ab4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4288:b0:847:83bc:d2a4
 with SMTP id d2e1a72fcca58-84f2dfc8c42mr10676600b3a.2.1785955921695; Wed, 05
 Aug 2026 11:52:01 -0700 (PDT)
Date: Wed, 5 Aug 2026 11:52:01 -0700
In-Reply-To: <20260803180849.2323590-1-abdelkareem.abdelsaamad@citrix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <kvm-20260303003421.2185681-18-yosry@kernel.org> <20260803180849.2323590-1-abdelkareem.abdelsaamad@citrix.com>
Message-ID: <anOGUUe9mSowlmEQ@google.com>
Subject: Re: [PATCH v7 17/26] KVM: nSVM: Add missing consistency check for EVENTINJ
From: Sean Christopherson <seanjc@google.com>
To: Abdelkareem Abdelsaamad <abdelkareem.abdelsaamad@citrix.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, pbonzini@redhat.com, teddy.astie@vates.tech, 
	jbeulich@suse.com, andrew.cooper3@citrix.com, roger.pau@citrix.com, 
	jason.andryuk@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 03, 2026, Abdelkareem Abdelsaamad wrote:
> Hey,
> I am currently working on hardening the Xen hypervisor's nested SVM
> implementation to add the VMRUN consistency checks for injected events,
> see the Xen patch discussion thread in [1].
> 
> While reviewing KVM's logic in nested_svm_event_inj_valid_exept(), I
> can see that BR_VECTOR (5) and OF_VECTOR (4) are treated as
> unconditionally valid. The referenced AMD APM Vol 2, Section 15.20
> explicitly state otherwise:
> "If the VMM attempts to inject an event that is impossible for the
> guest mode (e.g., a #BR exception when the guest is in 64-bit mode),
> the event injection will fail... VMRUN will immediately exit with
> VMEXIT_INVALID."
> "Injecting an exception (TYPE = 3) with vectors 3 or 4 behaves like
> a trap raised by INT3 and INTO instructions, respectively"
> 
> Also, the APM volume 3 chapter 3 (INTO instruction), states that the
> #OF triggering instruction, INTO, is Invalid in 64-bit mode.

LOL, _that's_ what SVM decides is worthy of a consistency check?

> I attempted testing the injection with Xen-Testing-Framework (XTF)
> bare-minimum testing setup. I injected an exception (TYPE=3) with the
> named vectors (BR_VECTOR (5) and OF_VECTOR (4)) on Genoa host. They
> both caused VMEXIT_INVALID.
> 
> I think the check in nested_svm_event_inj_valid_exept() needs to be
> gated on a condition that only allows Type 3 exception injections for
> OF_VECTOR (4) and BR_VECTOR (5) when the guest is not in 64-bit mode.

It'd probably require a dedicated check in nested_svm_check_cached_vmcb12(),
because the consistency check involves both control state and save state.  Given
that event injection validaton on SVM is inherently flawed due to hardware behavior
being microarchitecture specific, addressing this is very low down on the priority
list.  If someone wants to tackle it, by all means, but realistically I doubt this
will get fixed anytime soon.

> Please, could you have a look and share your insights on the
> implemented logic?
> 
> [1] https://lists.xenproject.org/archives/html/xen-devel/2026-07/msg00808.html
> 
> --Abdelkareem
