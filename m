Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150F2566F7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904228; cv=none; b=JdlNVoD0lwIsSUqrmhYLkko0BIqrwnaqXB8r7c2bQkN3LTdpJApnnqwcGXCRQcIrBV3W2LPlpT2q7F3o0SVnDoJQDglxbXxgMzsmTFBLz1RnH6wqoRm3eBltQH0yGxcOUJMn5X0d3BpbtM/23iUVTryVshU9Y+SZAN3DRfAv0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904228; c=relaxed/simple;
	bh=7jc+WInf2WJ/9hdkYcPokBHf488/XhzrhQzWF12Lthg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BVro7DBl5Xj2smq1qHSXFVqJ9c8NBeQRkRatle05jtmig+zcBdjrYdWKGpOKooChr6GCdtwPsA1TVR1T7GJHOqYwlRxYHN5uX4j+5/evq/MB2It/IsrLJ2xq3USW70yVNs19wjpmo704/ymaxMeW8XMHwIye4/V06EhHIgvqzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcz2rkOV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcz2rkOV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2befe912949so1884085ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904227; x=1780509027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fe41+KU6wfLUBJRbXaL90FhapjR18iAIleiBVMLFzsc=;
        b=mcz2rkOVawvl2+pumtZ0F82zQR8DcmpChRNPFwswb3vRw6XXlEqyVdaQ4pjZIMSzX5
         udSLxwLKGkg69+bygPOKEWMP7sLivrA0dEVL+DbE9YWEf7czThA7errB+3d/CFm5fvYe
         l0xY1VBlSzCfVEQWnaWxagewuGstTawsp07RTSHfBQ3yW+9MRCuVDTX758Xd5uyUg5fC
         bl6KZSVFtTQIBXK93K0yn5orVZqwJGJFyMwbF7xOTgOAybx8kHQD3fwYy7tSmmylQt9F
         QHIB3AxUyf8I45KXbSVE++I1qR3qWuYrDDejrHZP62/3S0BrBETC2nYB84OJ12l1vNou
         fxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904227; x=1780509027;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe41+KU6wfLUBJRbXaL90FhapjR18iAIleiBVMLFzsc=;
        b=c9NvJOKJjDIonst5/dzPwyFn0DDF2nfF7mLehDKa1B+LYzMlw2lcNuINMmuUsb30XD
         14eLbO1XpVx4fQyxqDqTQ1mcs8NVVWiz4IsOVTLPlOjJLgfu1TIbtFVAo9Wp3bP/KqZd
         B0Gkh7AYp0EMF1G0nFE+xEa5nFVxzzXzbfTN50c4WCmmwKqw6xuFMO0RmUReY8sYDyRP
         i2ikdh7SGmoVUnqa4ez+cWhyRGRMSf7WOEEFnmGaU6QZCHxR8alSoqOupxI99WbhAL5i
         C4wM6V8/V1Crm2H3EI4gEfAnHDLi9b+MaTVFetb8IINP9wLTytCPRZTXz8R7HW+PFb2f
         ndig==
X-Gm-Message-State: AOJu0YxBacocpC4BNIdCK5kE1gm3xJv1tSbyXde+U0m8l0Pt7oLssjmY
	d4qInRWRnuiYUC8dCBzyl7acxpA1y3yuGbmXZ3+5bmwru9wrQpigWixxOhjQtazOZvASTkdtfoW
	YyjCpFQ==
X-Received: from plcr13.prod.google.com ([2002:a17:903:14d:b0:2bc:bdd2:af75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e8:b0:2bd:b6f4:4500
 with SMTP id d9443c01a7336-2beb038c123mr267280115ad.11.1779904226526; Wed, 27
 May 2026 10:50:26 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:20 -0700
In-Reply-To: <20260514204020.1614792-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514204020.1614792-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989665274.4071783.8178893262947297314.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/xsave: Extend VMOVDQA testing to also
 cover VMOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 13:40:20 -0700, Sean Christopherson wrote:
> Extend the XSAVE test's VMOVDQA coverage to also validate KVM's recently
> added (and initially broken) emulation of VMOVNTDQA instructions.  Despite
> the seemingly generic and all-too-similar names, VMOVNTDQ and VMOVNTDQA
> are unidirectional instructions with opposite semantics: VMOVNTDQ *always*
> stores to memory, whereas VMOVNTDQA *always* loads from memory.
> 
> Rework the checking to use a buffer that is never written as part of the
> testcase itself for the source of truth.  KVM's bug was that it mixed up
> the direction of VMOVNTDQA, i.e. KVM was loading from registers and storing
> to memory.  Comparing the src and dst buffers on a:
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/xsave: Extend VMOVDQA testing to also cover VMOVNTDQA
      https://github.com/kvm-x86/kvm-unit-tests/commit/01a2f542c4b8

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
