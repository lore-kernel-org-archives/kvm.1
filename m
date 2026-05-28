Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391793EEAD7
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973743; cv=none; b=jp7KrzSxV2l4p+2X+9TaVTyttbjAiwwUU2HnX8iTjRYs6yEM99VS6n8hL5BITRcSRgHDiYidOQCjz1TadlgJwUXZfGs9+G6dHVeK/l4reJokBB3ctK3Hnf1Ay4iQ7MRnywjJoSTYy08Aj4g4hSt9qLYu+U2WlvsLzNk153m+rFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973743; c=relaxed/simple;
	bh=oBmK9WOIKlWbMEaKPBbTmm7YEGcIoyZ57guz/RjSxNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcPP4sqQ81HYIm02v8o9Yiz/gztHUMsYZCCAp/duHOkzkph97wDmv/HSFAK6e7EM++lfc2iiQM/EnscAlpyYUjCKPBf/XAnAPsrGE5aH67Bwff+rjYvg/83cCTLDY1597u9Q2k/FoOJSltSJgruObChuEU6lF9zYpuXGLBBLLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgRD/rwx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgRD/rwx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda2e60so7506752a12.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779973741; x=1780578541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBmK9WOIKlWbMEaKPBbTmm7YEGcIoyZ57guz/RjSxNU=;
        b=KgRD/rwx1figqoa3EHBtLBfq9cix6W5eBofIeaJ/3wr2KrrmdOoXNLFxghkOfmBvjf
         U7oW5zLmNkjj5vpwv3bXbQQlciJV/eW+5Zg9h0S+g2bq8vMDk5zsVg4rK7ZJGCRFdYda
         gjf9DNYAI8dafT1QMuLYPBmaeu6bN03/aaMfAAfJwwtQH32ZIr8a/F3dC2m3QglBilCv
         jZv3j8YGPAJv6VLnjmQBoCk0eFZMODTJULIqodaTj0/8T77Jxeuj0s7jJFIOze8lS5D/
         17f/qnOB1QqvEB17jiSxMniOZen8t+CZ2AqGznSdWj2Ci8uXf3JsyD2iqXRiFoxzdeJr
         v8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973741; x=1780578541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBmK9WOIKlWbMEaKPBbTmm7YEGcIoyZ57guz/RjSxNU=;
        b=LTTrvC229q8iMXH1ILv6aiuPqxgole0YxOm/89k3buXy2skTFKUufwr35QmabUwzuF
         U2b6qyPIPSGFlcXDo0nqYbemlQ8IMOchQC8SxS22XWHIrXWKLD0E09BVrE0EFVSNDVqa
         kMZZ3xTIBmzzeT721n3vcv6bu7n0gNO6sOUt3YjxvAAEm8q9qfqYHvHSU8avpmMFfLnG
         H8oZ6binyMUl/Uj4OJUkmK0XvoerK2fxEQl5d+jiD1DApxaIMDUyn78vwYkCDAk3OR/X
         qU5BMHduQiKYKIW3NLBbCQbkGLweWblqSWVEjX2XbFH5Z8EKqN4OnpSNvI2jDqNGZn1i
         n9Rw==
X-Forwarded-Encrypted: i=1; AFNElJ/OsC8MdaNsZ6GKJqMxS1R1Rr4jT3YONXPcRfSrOr6am/xqYiuzlhs4Ui/kmIEOSux3+uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1CVeg/rYsTpjPnCkIoRtUQtcXY6cC0+3NL2gCeh5XAv9HHPND
	dPHlPZOcCgfEwX/8XtHEbSLoAOJ4Ct6vEkjecHtm+MCHQI14mfiWCFCt+CUBMC9TwqGhWDluAFh
	9zx008g==
X-Received: from pgkn21.prod.google.com ([2002:a63:ee55:0:b0:c85:a9c:435f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6490:b0:39b:87f0:758e
 with SMTP id adf61e73a8af0-3b328c6ad42mr29658480637.8.1779973741256; Thu, 28
 May 2026 06:09:01 -0700 (PDT)
Date: Thu, 28 May 2026 06:09:00 -0700
In-Reply-To: <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528113605.267111-1-jgross@suse.com> <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com>
Message-ID: <ahg-bEiwyqYTdWOD@google.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Juergen Gross wrote:
> Please disregard this series, there is one complication sashiko made me
> aware of.

Sashiko beat me to the punch. :-)

See commit 2368048bf5c2 ("KVM: x86: Signal #GP, not -EPERM, on bad WRMSR(MCi_CTL/STATUS)")
for a real world example of how things can and will go wrong.
