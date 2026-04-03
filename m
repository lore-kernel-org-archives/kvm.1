Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B7371D15
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243127; cv=none; b=Me+Ww+g8MSo60ObNkcEqHztBzvG2Hhfxzu48ZmaacuSYl9Jd4bttBvwEsLJiwKqa0NivoMTKRlB59M2VEV7reesPzZTczJ4oS8AA+bHk+52tuu7TzoDiOgv24m/lPNC4Une7EOLM8S6aWd//GWCTEU6eKrbswHm5L1Y8zNeKbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243127; c=relaxed/simple;
	bh=sGqDEPXfXnm1lebxo2iz6rhXs+e7uK39tEIKz1prggE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MnCikcXNVOjqpEQSM7gCDemzSjko/eqZHoQem8nD84l0XQtvcJ6v+a5Y2YxADnXCfUXfkV5c96PCwPQ/jufFYR7nTq4l8QcPZ9hNTgo64MQMfPpbCum4LpYuTCLsPVAUiwSCz08st51zYisoO/QagBDVaVFiByNDu1MKo7P2ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7IZoHAP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7IZoHAP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24e45271cso19646925ad.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 12:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775243124; x=1775847924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/6eQRebCNsIclPGP3JJlhkPn3oLsiAJTh9+m279u/A=;
        b=s7IZoHAPcs6v7LZ2HqtP4ZazvOa9teogg9BbyojPhSVTblS/nT6HE9QZbwp5fnLcbf
         ckcwCm8ZRtXPxZViOfOOOSYsxAq+b+oNHDQBBgaY46aYngnnfQpHWXGvjcvxQz5MPGG0
         G6hsEIKg+yAXg05ZH7D5PfsG4PGT61dcshKgSTT50/vsXrEcYZ2s1dqrAdfMI6LsE7rN
         RrZs8YI/tDpy4YvqGKN+5ss1MpNkHACRZl5e8LODufXy2wcNekOVkoFU1ddbtPPMShwQ
         VGbcBT/oX+tP3BrTplcwukz43xYUhzSZc28Iqhsr3SZpJo/a8G3h/lYovtOuqDAx6exW
         njzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775243124; x=1775847924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/6eQRebCNsIclPGP3JJlhkPn3oLsiAJTh9+m279u/A=;
        b=btKb7xLj8nx7718WBpl9LGKlMMQZ8QGD7pXvT/vrpaGXIrtaT9gWt4TQ4dL5AAmVca
         /Wpl0McyeUfXJ58COa6uQYO23QLKJCkwT6aZnxL6pTSCaxZU+wIdKAVL78voqSF5LWAm
         aylrUrmF0we4l7nglfm7NYFHj837ywLTfwRVE81M4qyoL1OeWMyOspD+Wd/bOH+1jacw
         KLq4Sd1aYeGpbusyVX5v3qsYyxH8OvgO24C0a+lDX2Tzt5wy6tzVJN/2T5eBeoz6qXch
         GZmBDiuBviJUC6hrZ0npFHGSsXKFZiIYaHDHKSNqwGpHrZS0D6WM3sCyUaDdKhNtaTlJ
         bSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3eZhLCpPKfoPkkJfKrtmpOuoGPqD6HwBt6ThSRjzZ/zR2MVLI8v2HeMTAhpLAVjVXR2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4SXJVue5KaagCvsLGdAVdGd/XOOaKrCQDvrbjGFklN9NjZllw
	Y/zb1bDAxPRfKdmugtj2F3peWMdOeDNqj1cbOFZvSccJ3ZGPckx7jBVyEz1zheCGdDNXoKCaOc/
	VhMjCrw==
X-Received: from plbkf4.prod.google.com ([2002:a17:903:5c4:b0:2b2:7967:e6fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4c:b0:2b2:420a:b48a
 with SMTP id d9443c01a7336-2b28182c458mr41157365ad.32.1775243124400; Fri, 03
 Apr 2026 12:05:24 -0700 (PDT)
Date: Fri, 3 Apr 2026 12:05:22 -0700
In-Reply-To: <20260316202732.3164936-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org>
Message-ID: <adAPcmksaq8Oq7V-@google.com>
Subject: Re: [PATCH v4 0/9] KVM: SVM: Fixes for VMCB12 checks and mapping
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> Jim pointed out that VMRUN/VMLOAD/VMSAVE injecting a #GP when the vmcb12
> GPA is valid but not mappable is not architectural [1]. The series
> handles them as emulation failures and (mostly) exits to userspace
> instead. It also fixes the checks performed on the vmcb12 GPA (i.e. RAX)
> in a few places.
> 
> Note that there's a few other bugs that this series leaves alone, mostly
> to keep it focused on fixing the non-architectrual #GPs, this includes:
> - KVM synthesizing #VMEXIT(VMLOAD/VMSAVE) to L1 when intercepting #GP
>   from L2 on VMLOAD/VMSAVE, even if L1 does not intercept VMLOAD/VMSAVE
>   (e.g. VLS enabled).
> - KVM not respecting priority of #GP vs. #UD when EFER.SVME is disabled
>   by the guest.
> 
> However, the series documents these bugs with FIXMEs so that they can
> hopefully be fixed up later.
> 
> v3 -> v4:
> - Fix the RAX check in the emulator instead of dropping it [Paolo].
> - Add refactoring of SVM instructions on #GP intercept to facilitate
>   following fixes.
> - Use kvm_register_read() to handle 32-bit correctly and avoid false
>   negatives.
> - Do #UD and #GP checks before synthesizing #VMEXIT to L1 when KVM
>   intercepts #GP on SVM instruction in L2.
> - Update changelogs.
> 
> v3: https://lore.kernel.org/kvm/20260306210900.1933788-1-yosry@kernel.org/
> 
> [1]https://lore.kernel.org/kvm/CALMp9eSMtzDJn7tGtbj=zLYpcU7Tc7XjcWBRZH7Aa5YihSmN7g@mail.gmail.com/
> 
> Yosry Ahmed (9):
>   KVM: SVM: Properly check RAX in the emulator for SVM instructions
>   KVM: SVM: Refactor SVM instruction handling on #GP intercept
>   KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
>   KVM: SVM: Move RAX legality check to SVM insn interception handlers
>   KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
>   KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
>   KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12
>     fails
>   KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
>   KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's
>     name

Some nits and suggestsions, but I can clean them up when applying.  I'm leaning
strongly toward applying this for 7.1 even though it's super late in the cycle,
as there's very little risk (e.g. compared to the gPTA or host/guest PMU series),
and getting the VCPU_REGS_RAX landed would make my life easier for 7.2.
