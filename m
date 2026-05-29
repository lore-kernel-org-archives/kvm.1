Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF06D3546F6
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780094912; cv=none; b=OdxU95JeZ8VrLm20UXFlQ7p5/447c8FVDiylwGCF7mi26nCe6btKwCqNgICPuRnsp4AEFtpTuiH1u4svzM7Jkvo2+6SEEE7mUfPudyYQiamc+VcCppznCoZvqTBRPAJX3lk2MabAFADGRbyjn5y2idybKtLJr/p7+Bmd2lCVmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780094912; c=relaxed/simple;
	bh=b6ffBYX5aMxbPxEUdFSM4uPKjjfI9TiFsBohWXhyGcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnPtVkeN4gwaRugHVE5psPtV6WMjT1WUhuKZMQJ62iAeYjd6n8aZxOsICBuMNafr6ix5rC8Y6/ohfJOYBbucrFzJT2BzrHYe7Cciyvma7P4wiuOOr92ok9g3gfEIvVSZgi5msndeMOZIkdUMTNGx/61qCMFtco90Zp1ZXMMAlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1IZ09ad; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1IZ09ad"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82ac893940so7307891a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780094911; x=1780699711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbUSpHboMkhyKDZCfxjpkJGmbfHwd+tsxMAUtlTmtms=;
        b=q1IZ09ad3YAa25/LGGpyXfEC05wMgxSMiqbUL+6h4JA5AsvxdciagWN3io8Sl3P/xu
         KJVaeEoP/iGxcNCleqabbHLL964pGb/yZikit56/z09hHcfK0KlI+zDGmTdQC/TFOQu8
         Kj1j5CoO32NJRsO/hTMqJiPQHw9tjotd9xY2wqJLilIfgdnVMn/qqNZ3EOLLrlcDgo+R
         b0wgtuLCUz09cpNKLc3Tx627Dooh+UGZPg1I+pbc6beAWok57ukMVQM0h76FDGFXm/SI
         4sKGybNHhjpb0sxCPBUIW3eetwfM8yk4B1q2bCFgbTv4xacOjcgS4jxcqgN7HXJBfU6e
         WS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780094911; x=1780699711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbUSpHboMkhyKDZCfxjpkJGmbfHwd+tsxMAUtlTmtms=;
        b=rUcmzD0RExPtQIV5ii/hicrX7P1eFUuWGpFaoofvuKI0ZT2tKWbbLaN/Lmhae62gzU
         bFjGxFCknt/IbxsvEANPQRNOb/huf5BXruYCaostvvyO0Re1BSXOnvDFerudF0Lr3mOT
         xkoWctxg3dg0THJnaSCU3pJQw2x7g0P1TX4buPsZorMhCBU27n8rv6kmfRjAx2CNWVQy
         5GBlIT8IwfjE15glGay7A1vWP4xtuwqer5mo1H94BXAmwbtZ3ZTBbOcoQy1O8l+SCJLH
         L2ULKokd8kf8tTRhv7RJW8LKNVNRX+gaT0qjkePfXEbeFktYQ8WHga2Wv1uIBBSm6K8R
         Euvg==
X-Gm-Message-State: AOJu0YyLjJCBL7qzJheIFkCPU17ugsyvp98uIoMVT9N/5jYim/780TrM
	OCeSdlrz3uYFB+ghWoZG0Twz6UOh3Zz62cpPHGYdAG0zREvfFM8+zRU5pcr8wR8HB7vJH4RecAD
	aW3pA1A==
X-Received: from pgkj5.prod.google.com ([2002:a63:e745:0:b0:c82:71fb:427b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:189:b0:3a2:c683:fa84
 with SMTP id adf61e73a8af0-3b427f6d141mr1260270637.27.1780094910736; Fri, 29
 May 2026 15:48:30 -0700 (PDT)
Date: Fri, 29 May 2026 15:47:54 -0700
In-Reply-To: <20260527022617.3973884-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527022617.3973884-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <178009472610.881059.2932861959029055304.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: VMX: Handle bad values on proxied writes to LBR MSRs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xuanqing Shi <1356292400@qq.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 26 May 2026 19:26:17 -0700, Sean Christopherson wrote:
> Use the "safe" WRMSR API when writing LBRs on behalf of the guest (or host
> userspace), and propagate any errors back to the instigator, as the value
> being written is untrusted.  E.g. if the guest (or host userspace) attempts
> to set reserved bits in LBR_SELECT, then KVM needs to return an error, and
> not WARN on the bad value.
> 
> Continue using the "unsafe" version of RDMSR, as it should be impossible to
> reach the helper with a completely bogus MSR, i.e. WARNing on RDMSR failure
> is very desirable, e.g. to make KVM bugs more visible.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Handle bad values on proxied writes to LBR MSRs
      https://github.com/kvm-x86/linux/commit/ca674df13b19

--
https://github.com/kvm-x86/linux/tree/next
