Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782B2DECBA
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904206; cv=none; b=YQZ7I0ffTE0xGVuprmFT9Yi0FgMY+pUWoeLoaxPHX89cYjbYLsyv7ANPF4cxmiqQM0wM0zlY1NLupqJA2DR69xqHz38IoKd/cCD/MvNKLCeQKZYHx/ZA//ERT63Zp2ldCClHNkdswFm2ZX7OEMNdvtxIti3my8loWiXQma4/jiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904206; c=relaxed/simple;
	bh=tKRV1Z0ZVh+UgFhRxNMclrd8SwjOONZx4Iyy1UkGces=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TwwGrpXFciLa2ioNBL4EaEE+jvbTnQoVd5AHSpl67fZqYcyEdGp4YNcEsE4c6HTI35sex3zZnzm8eoS1X+fnExNVjXWpc+zob3l79lcgyOBtMgx2/0AA/Gt4Z+fTbkdfvFyGx+/N9BomzkETrR+3uJ8anh73+iDDC5b+kv4R6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5HUFbMT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5HUFbMT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82ac893940so5841199a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904204; x=1780509004; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTo02/1VjHtEWl6DSFps5XXHnaBlTwlL/IJV/C62XRY=;
        b=p5HUFbMTmJusHqEcddEVEv654XxghTlHSOdPtahN/CM8lOO3rkHLEPfcS+h/UCWuZb
         nkSCRGrbPWMoW67wyxYoasIH22cSq3IKGsZos5g6nvLGCljE2bTZr8BTIpThaWwdwLVH
         /juIYh55cgjHsWqE44QYWSaWj9qz5EDTxv5B9vsCGQ0MEUiWabts5SvTzOkXLtAp+BoT
         U73A/6Rr12anJTE+Xfo8x72u3xLN16SeXqCP8qGJ8XSY4gkIZ6cs9/4laB2lMq1nE60x
         /FnS9GnucShPDiZmhiUzeXFerQvRauTBdz4mrfuyqw8Nx0zkuRSQgPBXFRok33jCDGEX
         HjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904204; x=1780509004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTo02/1VjHtEWl6DSFps5XXHnaBlTwlL/IJV/C62XRY=;
        b=Bf0SOHc54V6vSEqC8BXAjONBDgg0rozVNmWBA0o9EUqSQ66CfvLBbfTGM2BYxP2uUQ
         euUBOAyLmAsY1VuidsE0LkhHgBpwMeHD3bXlbfbLHugivDFKkmspU3RshLRbXDnoSa4A
         tcHuVg8sqToxK9uOQwXt4jULUDGmIF3acYd7JNj2/VKFHtnD/ekt37L0MmfFD4tvYqU8
         42l4rAKkZop4svxRoOH6F2D2Ez+hNEjLwSEYLBdbJAhjvZBY2n9PRpJAGpquWZNAHovx
         r/fK6kknGO7rbCXZ4Ss1uX/G4422vzSfGDs/oqDMdr8WP1L197Qtv8vlMreZmIBe/RRc
         7FIg==
X-Gm-Message-State: AOJu0YzqFd5pImnxtJSG54d6N0iJvVY5VhqjIHywkga9f5ejJH3/CIBw
	KWULEw4kvqbbQO02L1HzPecYBOUM8A/7d68+6vigq0Jg+QZLVVeuotCjAP/nGBSWFU3N0SyxbSf
	UwPWJkg==
X-Received: from pfbfb19.prod.google.com ([2002:a05:6a00:2d93:b0:838:5125:b5e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ac9:b0:83d:632e:a8df
 with SMTP id d2e1a72fcca58-8415f6af7e7mr22846018b3a.40.1779904203601; Wed, 27
 May 2026 10:50:03 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:14 -0700
In-Reply-To: <20260514200536.1603737-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514200536.1603737-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989665727.4071847.1437992814822816532.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Thu, 14 May 2026 13:05:36 -0700, Sean Christopherson wrote:
> Run the vmx_pf_{vpid/no_vpid/invvpid}_test VMX tests with -pku, i.e. with
> Protection Keys disabled in the (v)CPU model, to reduce the number of
> testcases by an order of magnitude, which in turn reduces the runtime by
> roughly the same factor.  As is, even the 240 seconds timeout is
> insufficient, e.g. each test can take upwards of 300 seconds when run on
> Skylake-era hardware with a debug kernel.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
      https://github.com/kvm-x86/kvm-unit-tests/commit/7e7d2f89232b

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
