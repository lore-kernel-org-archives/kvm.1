Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14523231827
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094876; cv=none; b=ple7OwjWmMTFKLsBo/bTC0mrwpB7fdfyrM676ZGomMjJigad7sPa4MshAAuNn/gICcnBrZS0qL1DCL+an16TA+06K2SrI2EPEf4cdIb26foUwJCWFwhBpxCC6auI+rLvW5O8qNw7s3fOQA8jofpR/UAPpPotypYfevgVjzXsvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094876; c=relaxed/simple;
	bh=EhXkRw0+3FPNY3jkfcQ8Ugbl3bFu9YVeGT9yETM4UQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JU+F5M+s0MWsBzzFwx0v71Ztd6ywp1tLhTSF5FnN+g+hJZT5zmA2lFsjnWcAygEW3d5o6LOcn/Hv0iZhdipFQCE+LhBYTJRxMlFhnX7hpfBtL54rmeZtrhu4Hcmx+UC0LsgZSSnTDaxw6/CeUcFAfC49QlU3d6gSZpXJiJrvz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4zk/1hm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4zk/1hm"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82ba4715b6so15307585a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780094874; x=1780699674; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBoaHKw1uhDp/VWR8jKcQP5YxjdLIxlGKMU+QUhdwms=;
        b=M4zk/1hm5PyXjrNnQd3SMH+0YaUzqWqUJkYbC3zEt45FDiTmne9Kp6/88OKj3dk4uw
         Tjpi34spAUvSnkd0bMD2Ujv0S1Xk61gQU5jD7ixDfHe0H/izgIRgo5L/YdpglXu2rsnP
         +JmQNCr6stxIM0Tez9l0muPPXL2M1MxmPyc3/s6MdEzw5czRQSj3nWRumMOnW11z4Xqo
         mT1NRA9ATUH5jVWogfG6K4sBuE/aomh6/+Ozhg5APszHcpkWPZIdlObVmd+GLN4Sds+3
         osE2eJ9tNSz2seg457UrOuyVcP/om6FifHyPhdM9jTofHn27soqDHKtiCYSvQUrS+B8w
         nHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094874; x=1780699674;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBoaHKw1uhDp/VWR8jKcQP5YxjdLIxlGKMU+QUhdwms=;
        b=I1KpO/QsxttHV51a0r9vqvhmnMyH6aXF1ft/V5+GHPR6NT+wlAoxlpO4ryGmNd/0PH
         EHcSGfz67JBVhD0GfgPR8yKvZeqaqBSOWSWF6hWSpCiQGHnlK/+8Zpe77eitloZQIaKz
         A3U9fACQ41bRH7d/vcHB8ynDJT7D55z0EZxBwBMQT8Iy3hMwPlcVPB3w0TDVWCsn1r5l
         ruUy78zHJFexgQNQ71TRz0nTKTVQ/uoArcZ8CAjaErRDB2fWy+qhgZ8+42ZOt83NTnVt
         ukHF/b+uwGyFUI/C4+3EymTVAWpMNmGPja1QR60qzalJRSRrrh2sfcbDspZsORNDsP/a
         pHPg==
X-Forwarded-Encrypted: i=1; AFNElJ+E0S38DTE/6ifMVrOxSZzr8gVDtJv/yoyUY6weKF9CtPM1DeIsB5h1/JSySSoQPH06kpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ELHd6+RylQo41YEXyHaXAIfE5kxedOvLaqxCm3Hqd3JeUiRN
	Tyhn4Lc3IEzRqvJJRNqJvpV75xFVLeJecKMUrWvZvc0L4PoQqC9jv8OuYjzlFNYwCXg0h5PMYj/
	HptzcRg==
X-Received: from pgbcr12.prod.google.com ([2002:a05:6a02:410c:b0:c85:812d:cbfd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8ccb:b0:38b:eadd:449a
 with SMTP id adf61e73a8af0-3b428242975mr1406350637.38.1780094874162; Fri, 29
 May 2026 15:47:54 -0700 (PDT)
Date: Fri, 29 May 2026 15:47:46 -0700
In-Reply-To: <20260527174347.2356165-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <178009472318.880870.7878635650921105255.b4-ty@google.com>
Subject: Re: [PATCH v4 0/5] KVM: x86: Virtualize AMD's "disable CPUID in usermode"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	ctpence@google.com, David.Kaplan@amd.com, binbin.wu@linux.intel.com, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 10:43:42 -0700, Jim Mattson wrote:
> AMD's "disable CPUID in usermode" feature is analogous to Intel's "CPUID
> faulting" feature, but it is advertised and activated differently.  The AMD
> feature is advertised via CPUID.80000021H:EAX.CpuidUserDis[bit 17] and
> activated by setting HWCR.CpuidUserDis[bit 35].
> 
> Add virtualization support for the AMD feature.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: x86: Consolidate CPUID fault handling for emulator and interception logic
      https://github.com/kvm-x86/linux/commit/cf7d65d1d6f5
[2/5] KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
      https://github.com/kvm-x86/linux/commit/be7fd7c3e8bc
[3/5] KVM: x86: Remove supports_cpuid_fault() helper
      https://github.com/kvm-x86/linux/commit/d1bc99885a59
[4/5] KVM: x86: Virtualize AMD CPUID faulting
      https://github.com/kvm-x86/linux/commit/e93a93f11490
[5/5] KVM: selftests: Update hwcr_msr_test for CPUID faulting bit
      https://github.com/kvm-x86/linux/commit/b16c2aca369d

--
https://github.com/kvm-x86/linux/tree/next
