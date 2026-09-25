Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34E503BCC
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376336; cv=none; b=lf+0D6Ph2ijCseD6Y734/Gu6l+b7iX2hC/EeqVqAce8fp37TeyO7d3ZmHjBGpa1hcDUgZiKsB65YgEckZoKoRvO6v5bAOvstMc2fCjACLsYcS2qU1ALK1Wh49YoXQFji0SaVQGZ4lbQgWCb5ZzaA3zv3uFAqlT9O/+PpxUZnHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376336; c=relaxed/simple;
	bh=z1rVDmoeAEoisl0tsyRg3Uxy4LvmKBL7BADhM170khM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IbJu/AVpOeyptxBlFuA5qaXMO/QQb+Q0F96kVNwqF9vPfzGtqToGOIHQtS2mJOTISZTsEsacQGPWL/wfPe3QEPLnUnBUmNtJhlZs3m0lNcCU47w4tswd4hev5V9xltVAg/5vqVHUON+H27htKCVxURqXpFLqiXsQUeEz2Rn8lLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPYAZfo1; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPYAZfo1"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a59faf521so1158220b3a.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376334; x=1790981134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7TJ4aVC+0axratBuQICVCZVWZd3avX2KzEt7nT2hAI=;
        b=nPYAZfo1+1rCJBp7CyHm4edcvmJboIXNjR5CbDqDlJTHQul8KL4QGAkYaclu42koX/
         1jQhUudctCg7bI2l7X9ep6eYobYUZ7WYjDh4QWCtmRXGEcsnqJK60ILtBjmQKYKEPJfe
         xEVz68xpJ+xofLtLNULmTdl0p0jwNgU928Zl1ReG5vuAWABFsJtyrBz/NGjnMTTitRmQ
         hO4QXzD+Je7YfWsc3PhQnQKDjcpkmEqf5JqsReOjgAVVyceQo4m9YWPnka9o4bXq+3DP
         iCTzjjrsRejPZIO8ELWJlTK+LHLCpiX1YyijPT6OZhiJYIgzqgAIstVxQbmun5FvaeVz
         Mz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376334; x=1790981134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u7TJ4aVC+0axratBuQICVCZVWZd3avX2KzEt7nT2hAI=;
        b=HWCyO4DP4uirHZdlxt/BkqavD8hckNGcWMMno4PS1+UUqWEjKp3GsB4BUD8ZB2hZec
         HS10XmiLoF+wk9+JCyELNMSD5USOqaLnUXQQshfdf/QsqnvAjJYj0M/BdralnhNDcOXc
         jcwf3ccfJJ7V58DcR+ydGub3ZxxWM2dCh/fmMBg1xZaykyXtGSCtp9/8I6OTsoRwqSAy
         +EV3OVoBVsHhcsOlanpiwMewKydxSVL+Ii8QK0emx5vQetafT1kZbx5HwxQrlRgb5IcB
         tHwwNbLDp2sebkLfndAwDPVqyt58lbdv28MO0lQ+l41YqKtLIAO9LCeoslupQpRNqvw3
         F6Sg==
X-Gm-Message-State: AFuF++mAkjh3gqnDRRF0/+S1fl+MYEs7emC/rpdnd8VhRN1GcXkr4LSN
	uynJXmXYZ5pSOzuB8iXs0D8EsvHRJXkM7H0zKs2LNWLMP0NfXTrtORB2HRxixsqVf/7djHGHxvz
	m8uTKKA==
X-Received: from pgm14.prod.google.com ([2002:a05:6a02:608e:b0:cc7:8cdf:c48d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f88:b0:3cd:9bb1:c6f5
 with SMTP id adf61e73a8af0-3de0e6f1229mr6303054637.10.1790376333965; Fri, 25
 Sep 2026 15:45:33 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:59 -0700
In-Reply-To: <20260527151232.4058615-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527151232.4058615-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037621801.2352728.233718043154169321.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v3 0/2] nVMX: Improve DEBUGCTL test coverage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 08:12:30 -0700, Sean Christopherson wrote:
> Current nested debugctls test focuses on DR7 value and fakes the result of
> IA32_DEBUGCTLMSR in comment. Although the test can pass because DR7 is the
> only criterion to determine the result, there are some error messages
> appearing in dmesg due to accessing to BTF | LBR bits in IA32_DEBUGCTLMSR
> with report_ignored_msrs KVM parameter enabled.
> 
> Clean up the old test so that it focuses on DR7, then add a separate test for
> DEBUGCTLMSR bits that are actually supported and can be validated during VMX
> transitions.
> 
> [...]

Applied to kvm-x86 next, with a comment to explain starting at '1', and a fix
for the redudnant '0'.

[1/2] nVMX: Remove the IA32_DEBUGCTLMSR access in debugctls test
      https://github.com/kvm-x86/kvm-unit-tests/commit/071c710553e0
[2/2] x86/vmx: (Re)Add a nVMX test to validate load/save of DEBUGCTL
      https://github.com/kvm-x86/kvm-unit-tests/commit/067685479059

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
