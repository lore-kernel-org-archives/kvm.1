Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804F41A911
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054607; cv=none; b=evbn5JJlOVxfELEIV4WXA+gGAprVxvUGh7hXAonOG6t6hw5634gpGwo7peDw25AOXeM2MNiDjKiRH3Q3DUQ2WlZpSe9EDgZP8dcov7V0vsrgg/tcHWWdCtm1iN6hSE0s7kh6AMEEMEJs5gs8XKfUrD5JVIKchDJMVK76PeR/33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054607; c=relaxed/simple;
	bh=dgzRb/XsbC9d25X8Xc2hjxOupkFfKyvTCYsQ/eMOgmo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eykO4epSzSAz4aHoRp09nlLDfLJMP9Q3gboBxQP33r1zAfkcd6iXeVMyFAX37A/+l0mOjS9rn/CttO5wYIBslKBIyd0wNGq9VIGfVrwY0GFN8OUXBCVOb8bJ9MJFiLWsvAkQ/7reMUPsry84z/bIpWYarK9qEZvmO/VKw2ricEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKtNCRj/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKtNCRj/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cce14a21faso24011045ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054595; x=1784659395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Wdiurl2cveXIjUq1jMXLo7X86IJowePXG6hYm4wV0A=;
        b=cKtNCRj/C79nYbn4brS4jFEizuIejXft9IMVRQGF1DV+L11Q1Gfx1DQ0vglTL/93L8
         M9F1Y0ju7G7tBr6B7gGEW4fT3xel54SLJ1r1GROP8QuRLR6WZiXQ8yfz978BLrclgevE
         ICMpPFTn2xL3H3aUaam/XyzPEirVZ16koBku4fukUiIGE0cN5YDlHHXSSNT5CawLVA7b
         hGU7cT/Qr2lmLaXyjLgxbWcgT1yc08KPy/wC94c1ZDv94kcLmS3GlnueXtWZ3lMTCRLA
         ZkW0q1OLqbu/OyM+MyJouMp5hzO5PIBpkEbS696nrqxy2aSvcnYuSrbM5/LAcp116bss
         bv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054595; x=1784659395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Wdiurl2cveXIjUq1jMXLo7X86IJowePXG6hYm4wV0A=;
        b=ms54ybYpydJ8tsBJDbnQFYJEw8MZXM9/Q5ubVe/VQsi9akn9uBZUZMFmhYQTMXqX5a
         KkIdsEfKuFJlWJbsqOdXUKwyWOZ7eM2bcdx5Qk6xweE8dlFo/O8SpQXnX2rx4ANAdGuR
         Cuti20ywGP7Yza6bzrFDce6Z+mVzE2FnIbbyUM5etOBTCjlXuUxJGBwk4CYf3BB5M06Q
         fx6A96Zz9W3F5WILTwarGiHwZC2lsbzam/oFVstdaq4OeAmGY3dhZXNzdX2rfnpC081x
         pFUHkngHrv+jLPjfNFJmy/3OG3HAiVusqbhqxizYM41Eo7Nrh0qWCiA2oSjghNr6Yk85
         y+fQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHLwjoai6yVdocBhB70TeV6smHRnZTo4Uu26OuCGJWVxs9aUfMu2FsSYv7aHjG7u6oHio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBZ/AfMjmGA84sIvyCfkSiAgtoco9KR7ywg4tSwIBnvcxQcUJ
	ltyuL8sk2O8hlauuo/itq83MsaWCwM8Dw9O+qrWyo/pPXSOd7NZlaUu98mPt6ejfeK6It4PEXe2
	ceXq0xw==
X-Received: from plbbd8.prod.google.com ([2002:a17:902:8308:b0:2ce:8fc6:56b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d98b:b0:2c9:d8c5:d55d
 with SMTP id d9443c01a7336-2cea18211a9mr130149865ad.16.1784054594713; Tue, 14
 Jul 2026 11:43:14 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:07 -0700
In-Reply-To: <20260710134055.16432-1-danielpaziyski@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710134055.16432-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405241734.3109284.13844633834101663911.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Daniel Paziyski <danielpaziyski@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Jul 2026 15:40:54 +0200, Daniel Paziyski wrote:
> The trace_kvm_inj_exception tracepoint takes as arguments the exception
> vector, whether the exception has an error code (and subsequently, the
> error code), and whether it is being reinjected. The error code is
> formatted to the trace log as a string using __print_symbolic,
> which takes an integer value and an array of structs containing a mask
> value and a string. An empty struct is being passed, which makes the
> kernel derefence a NULL pointer when the error code is 0. Remove this
> stray struct in the invocation of __print_symbolic.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Fix null pointer dereference in trace_kvm_inj_exception
      https://github.com/kvm-x86/linux/commit/9c66085e6dcf

--
https://github.com/kvm-x86/linux/tree/next
