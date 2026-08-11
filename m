Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A229D268
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409038; cv=none; b=FxqOwJAIW13suhFUWJtK6ZrIjHW0tKZRqL+zzFG2ToU6IqxqxOn18dpYO8YnOHhOtdgUBpD64sVMHw7X6WOTMrHCxR+3Ih5ltR/fE4IgsT6K4Crr1Iun3fhEJ6Ho5GwIwCi3XQnu395JwO0Oq2e9Fp39fgtIQqIllfinuChc5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409038; c=relaxed/simple;
	bh=WQxPyjOmNtM5R8JyZSMh3RwDvaCfdXHPYKo1RlbE7Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLgDwibHsymhTDT8WZcP0yXCi4y7GXIkEpaw2p51W66T4sNVq6FtsOkSujInTU0MgC6kw4qv2j31KD1fUsjlz1h6J1fUXEQcXOc+7FYc8hf7PlzNdjBYmrPD1E100N5jXLzMYcUiE9dX86VNhbnFrzMLcxmxabzft0yFxk+n6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/hm2/7m; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/hm2/7m"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab041eced3so4144028a12.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786409036; x=1787013836; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TdtwI1Ee0mw3e+1rCkhKazccv8OvfhLfoElZh6LGLeY=;
        b=L/hm2/7mmJCwuA7m9vh86IIP8zUi6vvPgcnxNDnFRww/QTTl+NyHLH6G8tr7oGj1Eu
         R5jtp/Lm+uwTUAe17Wm/cxUV46QMNuFwbHXMb5w3zA7HweNTFP7Qkh0xpquwUxISJRY3
         UoPq1w+9fN1NsBmWJLFeHe/ZDGZKgMF/QZjNtqotJg6onFr3SFeAUY3CZsFECxnuQcJB
         uEIpdOqhA1n/ijNH0iubJUtyoke5BHrBrZ6ZdHfiFeYKdKKusyLXmPkBMcK511e6lD0B
         H9p6E9bex3wETg3Xz/ojWDO4IsB9T8mxtjc60lrmtGwzPUYYUoNMTyLaDTv8H4zE5PYd
         HIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786409036; x=1787013836;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdtwI1Ee0mw3e+1rCkhKazccv8OvfhLfoElZh6LGLeY=;
        b=VTDIF2v8/mfONIlNDYL2jP0vcCP2r1zKFhAgcBCI8nn24r6qtEWIoKtYcr5eAedkSs
         Q4ruWSzAm8N9a+utdrkH2QXx1eNAzaP9hc336Xh2Y5m7GvPfDRrGLaR5dL0kHFR5+9Lj
         lLQl4XWOXPmEvjcIfvODjSeUohur51zTfu8X+tS/72wW6/X1iYm8a/zNXA5wmtTqrVJv
         GJGqZ3j0ErSdHNZsS5roNFXHXV/j12uSTYLIPlkTZMK5FrEupHbMpb52wVVtwk5SARkS
         lvqegcHdFr075awGBf3LduWd+MwRGVMJkNQe5D+1tiG72YIDPy9kFrZX2PNJzpvsC/IU
         UNLg==
X-Forwarded-Encrypted: i=1; AHgh+RqhpIECUa5X+lkKHr/ThBFtJuGlX/y92MwxksqFZYf6w3JnAc9PVg9WH5rC+LPPdqdIiK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9rhHsdVgaN56pt+2W/CRhZI000McX6+HgLoJFAtX0DKaI/zM
	FNFZmjmgCZ9eOFQht6T9FEf0atw+PYkwJJ3W8Greg5dW2IKrsDVVyKO7yB/IK7rUX0mElrV/ozY
	2BX3vKQ==
X-Received: from pgnb22.prod.google.com ([2002:a63:7156:0:b0:c9e:63b8:11b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a89:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3cc1a0bcd18mr7553175637.2.1786409036317; Mon, 10
 Aug 2026 17:43:56 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:43:55 -0700
In-Reply-To: <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713105033.15405-1-sarunkod@amd.com> <20260713105033.15405-6-sarunkod@amd.com>
 <20260713111119.EC35E1F000E9@smtp.kernel.org> <b50b3535-eaa1-4944-914d-0eea8dac0e06@amd.com>
Message-ID: <anpwS3C2UIHFz_Uf@google.com>
Subject: Re: [RFC PATCH v3 5/6] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Sairaj Kodilkar wrote:
> On 7/13/2026 4:41 PM, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Can an unprivileged user-space process trigger this WARN_ON?
> > 
> > When a vCPU is created, svm->gappi_cpu is initialized to -1 in
> > avic_init_vcpu(). It is only set to a valid CPU ID later during
> > __avic_vcpu_load().
> > 
> > If host user-space configures device interrupt routing via the KVM_IRQFD ioctl
> > before the vCPU runs, avic_pi_update_irte() is invoked. This will pass the
> > uninitialized svm->gappi_cpu (-1) down to this function, hitting the WARN_ON.
> > If the host has panic_on_warn enabled, this allows host userspace to trigger
> > a kernel panic.
> 
> This is a valid concern.
> 
> If host userspace attaches a bypass IRQ targeting a vCPU that has never
> been loaded. Functionally, there is nothing to do in that window. A vCPU
> that has never been loaded cannot be blocking, so no GAPPI wakeup is
> required. The IOMMU still posts the interrupt into the vAPIC backing
> page, and the pending IRR is evaluated at the first VMRUN after
> avic_vcpu_load(), which is also where the IRTE gets a valid Destination
> and IsRun = 1.
> 
> This can be resolved by assigning a arbitrary gappi destination, without
> actually updating the gappi wakeup list of that CPU.

With the disclaimer that I haven't look super closely at this series, and haven't
thought too deeply about the feature itself either...

Why are we doing anything different than what VMX does?  vCPUs on the wakeup
list when they block, and come off the list when they wakeup.  It's literally
one flow that's guarantee to pair put()+load(), and the logic for manipulating
the list is quite simple as a result.

Going a step further, why is GAPPI not sharing code with VMX Posted Interupts?
At a glance, the only meaningful difference in the wakeup flow is the "should
this particular vCPU be awakened".
