Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26644C645
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057485; cv=none; b=Q6gpQX+/5JInmzLwsBEjBLsU+E9pIy++TMutLrSTqPbTBqVHWfLQgCj/Ws3jI5bj1OkUE0ZE6FQnPhcTUDoX/zH/9s/GagprYH0J49kWmLHRytddzLgYYRCh8iW0sPaqxS8gsFtehCfx9jscOIgsbjFBrJfBxzYFdoF0iI8aBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057485; c=relaxed/simple;
	bh=a1N4Gjf1Ub2JZ4peldmTfLzoa3g6sEym1vcgdOeecPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mu/9SZ0Nx+6SFAKY6avGXBv6eUBd3zqRHP/FEoTZboqQ/qm7ap+6n91VB8FRbVanIBmQ/QFhdzfSaQlpYRZtyQXi8d2NtEGeQP3+eWkkBYg+EOfZqAuI5gYlDadYfJ+bPC/FgV99Gtfoj/kf3nhRiMCclbPmtuUKpZp6ycN5P+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAUlA+Zw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAUlA+Zw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3811279d51aso2570494a91.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057483; x=1784662283; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dw0o/r9YzmigAnYEAZqwrVaBbDBZlqlxfMl+dk1QUUg=;
        b=qAUlA+Zwau1/tAAu6WelK0/Q0Qzod8cLaWII4q6sYyRLZ4vhnaAuk8mOGCL+FFSs0P
         nSz8Twl92l/EEjHAcwIWy+L2reGclaDs+esJGn7m0cxSRd5a41+Vu0TG8YS7nMIpp7+w
         eZcneN5UPpHIkFsvTwIeYwsfQk0zCeIouRJ1sjHtV2bFg1BrT9/JfcZgpEdmg9KvDH/L
         R+W0EznayVaiDbBkK7Ox+oJL+4EI04GHl/Z4VHZ93FVo6on82nPKn0M++aEUDkryjqwy
         9IVmJS7Q/Hw02LwfXIEIizqzwQsv4HTkZ5oGI5lnJXo+mu4tkQphl2JVBT2ab/J7/G8N
         LYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057483; x=1784662283;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dw0o/r9YzmigAnYEAZqwrVaBbDBZlqlxfMl+dk1QUUg=;
        b=Lft/jJCKxb4sEGLyaHLvsO832y2o6cxtLa9Fl8Z/PZ+RJQTKid3RVwcj8Uu9vjy2SQ
         Q1e3u1kNK0FtdA60ARMdRonRQd7p8WcrqGWfn9MwvcaOJdE5PrgjlL23RpZkgPlGeJrx
         /3un8ZXV8w9+UbVqscHjYAQZjuZQOqr9jzV1Ih5GlqyLJg+u0AhpVl+Kjhld3JPw6BSW
         feaA1wYUqebpKe/SePWFSw2LF9P8WVbPRSLEOGbvHsrtGqywt2VgMmTH/q17I+kOrkOT
         TJg3mK/oIjL9+fkix59FwMLaSIZNWKd7MIA6UW9wRiTpmHCiM/UI5Jhstf3jbqXzfF6d
         HwNQ==
X-Gm-Message-State: AOJu0YzrCKIyle50It3hj99htFCtmVg/Pf86AgCiewFL+/uGuCQYC6qU
	crf5T5dhCC8gIfkAH/7eN1P2Xt6n7PfLxX/qGRMJdZ5pEuTTqFCsb6xFHrVoy36XXppEbWxnqFu
	zFHGQmg==
X-Received: from plxq9.prod.google.com ([2002:a17:902:dac9:b0:2c8:7ed:acf4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5443:b0:37f:9ce1:cda6
 with SMTP id 98e67ed59e1d1-38dc7735b02mr14987153a91.28.1784057483196; Tue, 14
 Jul 2026 12:31:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:29 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405414124.3135765.2653623426973553639.b4-ty@google.com>
Subject: Re: [PATCH v3 0/8] KVM: x86: Fix emulated MOV DR{4,5} #GP bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="utf-8"

On Fri, 12 Jun 2026 16:01:05 -0700, Sean Christopherson wrote:
> Carlos' fix for a bug where KVM fails to signal #GP on emulated MOV DR to
> DR4 or DR5, plus a pile of follow-up fixes priority goofs (#UD versus #GP,
> #GP vs #DB, and #GP versus #VMEXIT on SVM).  The rest are opportunistic
> cleanups.
> 
> v3:
>  - Fix a #UD vs #GP due to CPL>0 bug.
>  - Prioritize DR7.GD=1 #DB over CPL>0 #GP on Intel.
> 
> [...]

Applied to kvm-x86 misc.  I still need to follow-up on Zhaoxinbehavior, but
I'm quite confident Zhaoxin follows Intel.  And if I'm wrong, on-top fixups
shouldn't be difficult.

[1/8] KVM: x86: Treat any non-zero return from set_dr() as a faulting condition
      https://github.com/kvm-x86/linux/commit/8f683a4dc546
[2/8] KVM: x86: Prioritize DR7.GD #DB over #GP due to illegal DR6/7 value
      https://github.com/kvm-x86/linux/commit/55ac576a9bf4
[3/8] KVM: x86: Manually check DR4/5 write values to fix SVM intercept priority
      https://github.com/kvm-x86/linux/commit/e27ca3dfbb73
[4/8] KVM: x86: Prioritize #UD on MOV DR over #GP due to non-zero CPL
      https://github.com/kvm-x86/linux/commit/32a7188a667f
[5/8] KVM: VMX: Prioritize DR7.GD=1 #DB over CPL>0 #GP on Intel
      https://github.com/kvm-x86/linux/commit/48512697c081
[6/8] KVM: x86: Use kvm_dr{6,7}_valid() to check DR{4,5,6,7} write values in emulator
      https://github.com/kvm-x86/linux/commit/1f077338d1cd
[7/8] KVM: x86: WARN if MOV DR emulation hits a "too late" #GP
      https://github.com/kvm-x86/linux/commit/b077cfed52b4
[8/8] KVM: x86: Read CR4.DE in emulator if and only if accessing DR4 or DR5
      https://github.com/kvm-x86/linux/commit/7a642d8dcfa8

--
https://github.com/kvm-x86/linux/tree/next
