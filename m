Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D264263C9F
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151456; cv=none; b=VrzPegNwRUPfGeAqHOfgxVpUGrEonvLYeDtxM6D63N2Yd0MUHo00ED6SWaPpJ4Z0I9keSxmUojDEt0N2IcQJ4e3R7mWLKf+pUiY+5Xk90BsUVF3ebMS8C6f/YwkrQH0FBhRq1KNhOzrd3JnthbVM3M47u/vtnRqtjsr3ylzEInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151456; c=relaxed/simple;
	bh=Ewifb8VwQasaz0okwhge4bZJXgIyigSuJeyXErZk4aU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=j/n8xDA3hXS28lalZDffD1LC+SYpUM24W2nCWunvYCNhBUcXdH8Y5xAPsV0S55j4Da/9hB+sGR+Rck+HYpb/tscxIEJ8HnHqQxw+BVzhBkZ/mQEOQOZPp/ePa68D2wX9+4oak3A63BX7ZJyJnebU55hglHlRnWCOvSlkfCJPauM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTZWvuRF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTZWvuRF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso1489665b3a.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151453; x=1779756253; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DC6DVjI2095clscFBU2SfIMH51WSvFVw68FB2pL6Udk=;
        b=WTZWvuRF5I++iBkOQuqHyI7zk5av1fmmXsRa3KCG1P4FDmbDZ9Q4WA/9w+HlWpfarO
         rATsrTgsWLASP4XIozjXKxryp7DM30SwNs9yvcEgfaWMZnbU4pPE758vUlsgIQv4/z4Y
         2HVPyrf7TQSkPBhOJL0dJh6i+m8pMcp8zoEfNW0I+qcItUaRqdel5cAfjEts2Ia7HV+J
         bYb4+1slJdbVphBPlOynloiYkGaee3TuEBQ5+pICd0GVbnOygrtarfhOMiRFAM7a67DP
         dhGW38eB2yEafMQEtB3wJ7SiaBkxRnPmIpYABChdC+ovaz7PT7NfmYdo22YmCFyPoIv0
         DoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151453; x=1779756253;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC6DVjI2095clscFBU2SfIMH51WSvFVw68FB2pL6Udk=;
        b=H92rthAor/2pcxnp+0JoYx/vpOlX4wqRFWGQIQWKhf0Glr/HY+D3imaD6pfs+mGFPa
         pF2vKDAwM09S07zDB6GqdBP/5X9xcCn+KoySDlgmjhteB33BmNCYxMQrbGRwgnPjK2bd
         1oEzdTdIpmin8rP4XWsEdvfGmQFdCznocPO1tyjlC/o0r7ARlL0gnstBhDjnaev+YMUC
         GaBy2QLByN/hUDVycXtxHm7Oh3hTJiV3mLZjqPnYdML+pxUedSDCbI5qDTIUci4dqFsu
         46U4c5+itbBuxmvPWvKYnE+MMDdsN8fTspNOHKlIXzcnkugFrlZqpiLs7TT9zWfmpLlF
         +XiA==
X-Forwarded-Encrypted: i=1; AFNElJ+bD8/UnXaAPnAjGSeWk5NHwNrzrp2NAoIch9FkMr55hVnzNu9RoQ4kbLEXIxHiQUrGjdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCMQ8yuGC7LRRd1MDlE4Gd1nYTjda36XzTZgZwWAdlZYlKJoi
	57f6CXVnhgK9t9IwolS4x8cN+8rjaGo6PZ9DBai9WK1IOE14z5fIeqC0QEAd5bNirOePl1ovehM
	M3RdyQg==
X-Received: from pfbfd35.prod.google.com ([2002:a05:6a00:2ea3:b0:837:c7f5:5c27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:429b:b0:83e:b125:ff30
 with SMTP id d2e1a72fcca58-83f33ab698bmr17431805b3a.7.1779151452757; Mon, 18
 May 2026 17:44:12 -0700 (PDT)
Date: Mon, 18 May 2026 17:41:06 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915062620.2226127.1264745848157211491.b4-ty@google.com>
Subject: Re: [PATCH v8 0/8] KVM: x86: nSVM: Improve PAT virtualization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Apr 2026 12:03:23 -0700, Jim Mattson wrote:
> Currently, KVM's implementation of nested SVM treats the PAT MSR the same
> way whether or not nested NPT is enabled: L1 and L2 share a single
> PAT. However, the AMD APM specifies that when nested NPT is enabled, the host
> (L1) and the guest (L2) should have independent PATs: hPAT for L1 and gPAT
> for L2.
> 
> This patch series implements independent PATs for L1 and L2 when nested NPT
> is enabled, but only when a new quirk, KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT,
> is disabled. By default, the quirk is enabled, preserving KVM's legacy
> behavior. When the quirk is disabled, KVM correctly virtualizes a separate
> PAT register for L2, using the g_pat field in the VMCB.
> 
> [...]

Applied to kvm-x86 svm.  Yosry and/or Jim, please double check the result, the
goof with patch 5 was slightly more annoying than I was expecting.

Thanks!

[1/8] KVM: x86: Define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT
      https://github.com/kvm-x86/linux/commit/822790ab0149
[2/8] KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating hPAT from guest mode
      https://github.com/kvm-x86/linux/commit/0a8aeb15848e
[3/8] KVM: x86: nSVM: Cache and validate vmcb12 g_pat
      https://github.com/kvm-x86/linux/commit/4b83e4ba836e
[4/8] KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
      https://github.com/kvm-x86/linux/commit/02233c73f8ae
[6/8] KVM: x86: nSVM: Save gPAT to vmcb12.g_pat on VMEXIT
      https://github.com/kvm-x86/linux/commit/d65cf222b899
[7/8] KVM: Documentation: document KVM_{GET,SET}_NESTED_STATE for SVM
      https://github.com/kvm-x86/linux/commit/32ebdbce3b23
[8/8] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
      https://github.com/kvm-x86/linux/commit/4f256d5770fe

--
https://github.com/kvm-x86/linux/tree/next
