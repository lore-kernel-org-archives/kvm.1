Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DF2BEC52
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586297; cv=none; b=o5MNA9RkGlY9bj4UBJM7C5VbXRPlh7AcsFTTRvmUHKiqD/XuWrfNHZPoIM0N2InncFBdshNssgJ1QCSKxgyW6vJFqQGHEhMJ+dX11Xgc2ULRln0XtIRBKlYzx2HX2vuGVECQRrKwNE7ib7L/YP4Jq3DSfKOYSSbQVAC3U8W0iQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586297; c=relaxed/simple;
	bh=6jWHdK0JJv9CZ3WplVt4WMmL//s6UwC3zY0FfPtwfW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iexDDPNyHm9f3Mrk75wr7/VLwZlIXeLVayNWo3ZQ4NMGyTHEoPN3nwd5QTo0zvOnZI2+ZRshE51uOdSQiLzztZUKPHqPHJRUIzePpgBdK+UsP9b/aotk9GxPCQwPTg7emFHFMLtFv+9CgoqmQv9Mw4xsbOLLwsZGP4I36LO+JiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CboXb7+3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CboXb7+3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso6768099a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775586296; x=1776191096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkOPCLuhmlWfrJAVmOfiFO05s6lMLqMZSUiAaeBdreM=;
        b=CboXb7+3tosJAbYVCNU5jeBWZ8A+izAldsWUq7X0jZ1KZe/VZBjz5wlkxCAjNMgRk9
         bJeVnQWj8mPdBaBMMH6JfgeiMFZ2e5+uSsQ/N5rwyqHseexeMhpMV/8ho5MMrYX1iaY+
         QXWt9bqZnymlVkEOZP7GqhZv4M2kEyB0ANFcxLLFAM+phIJtfCvkIllx04rdwWevegMy
         gJPN3bFLEmUgzIz5uiFxQbGtkryBY2hc63nvFvSrgBMF+NTvxiQjVUYJuX2JZdpSIzZL
         x1DlsEp40gtVv3o+8kWKKu0TpJRXLkyB88cA8kWc8wk1UQ23tLQPUDdJC9EY5geG0tGh
         EQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586296; x=1776191096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkOPCLuhmlWfrJAVmOfiFO05s6lMLqMZSUiAaeBdreM=;
        b=YdZUwXb6PpbvXG35a2dcYUElzqvc65aA2LcHxOHratMMoD3D4YmXwGsaF9sIb+ABns
         BRsfXzAk/j+UbvjS55nNuatGdn+das1bzpoedbI59LbM4yw5n5tsDy3dggnk9IwEvtPV
         TPJ3Tc/LczCUgyYRigcuF/QXD/J3IeydXHZR7EK4EZAOPeTCV/I1Kuu6p37LFMvmRYM2
         HizD0svAll1q7bWMR+LhAFv83bwzLfUCrrXNZwLkqhvMwoRsYgJWkb7UZBnLyI7qiTNC
         rl5DocUCC1FDKOnqJxEjTImCYtTPkE9WajdngoH+1ZvthRqOBNQtR8NK1VcjUxLq+/pw
         KK8g==
X-Gm-Message-State: AOJu0Yw7VC48BeXyojlXXILAb/yNTmuyGXjUWyQokVFBt4kPzyMK+Ux4
	/upLDTyXUcEZdKennLq3hP3xeSJ3fJ5MJ8AN42b1X9jF+h4tBiUQatFnh0rabxWH/AVwRQ0LsGA
	FjkcOwA==
X-Received: from pjpy24.prod.google.com ([2002:a17:90a:a418:b0:35c:1ca2:43f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c1:b0:35d:a542:2dc5
 with SMTP id 98e67ed59e1d1-35de67d6247mr15242849a91.2.1775586296066; Tue, 07
 Apr 2026 11:24:56 -0700 (PDT)
Date: Tue, 7 Apr 2026 11:24:54 -0700
In-Reply-To: <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
Message-ID: <adVL9nqJhJwvu1QO@google.com>
Subject: Re: Bug with nested PAUSE intercept on SVM
From: Sean Christopherson <seanjc@google.com>
To: David Kaplan <David.Kaplan@amd.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, David Kaplan wrote:
> Hi,
> 
> On AMD SVM when the L1 guest is trying to intercept every PAUSE instruction
> in an L2 guest, the PAUSE intercept sometimes fails to fire.  I have a theory
> on the source of the bug and also included a short reproducer below.
> 
> In this scenario, L1 has created a guest with the pause count and threshold
> set to 0, and the PAUSE intercept bit set.  I *think* the bug is that if the
> vCPU gets scheduled out on L0 while we're in the L2 guest, then upon resuming
> the vCPU KVM calls shrink_ple_window() which doesn't appear to take into
> account the fact that svm->vmcb might be for the L2 guest and not the L1.  As
> a result, it looks like it sets the pause count to the default (3000) causing
> many PAUSE instructions in L2 to not be intercepted.

It's probably even simpler than that: KVM is completely broken.

https://lore.kernel.org/all/20250131010601.469904-1-seanjc@google.com

Paolo, can I finally apply that patch?  I brought it up in PUCK a while back,
and IIRC you were resistant to dropping "support" for cpu_pm=on setups.
