Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432063DB636
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057315; cv=none; b=R0nHBVbdMf6OEQmBbQ8bliVs26gd2ESm5Q1c2jYuwl/EW8f/PnIzV+xgNXnMqETnvsszCUqDaGnH6gkKm5a5K2CPMuN05u6BaOCkNGnX5tsFI6weEcIHTwytYpiMBsMIqlHPd6cdrLzpTUj+nuWUAv3cIKsDzcbSZ2d+9OZSEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057315; c=relaxed/simple;
	bh=PhzvCnRWbCgxYlac0huFfl2v6t+HR3UbbGPrGOegn9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gRU94cLNkvlrHKz/RkVhE/dodHqjUpc6sxfyEsIV8YaUsilt4vZs6BUsiapnleBxTaXq94ppW/cJ95U9ObFkzZznM14R5rxpaI898mSoHFflhFcLlIJw199DXUaBFeLdSinrOK2qg95hQc8B95UexDd+jHi0ym7AEomrEwJJ8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eU+QrAvu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eU+QrAvu"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84859a64079so8389284b3a.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784057313; x=1784662113; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqdJXJeM556Mf9xSOIOEHagV9WIFU0/y7y2pnFLyVeo=;
        b=eU+QrAvu6NAiU3Cp9GaoPG8YZ9aOBjMS6I2QTo2FgQ7LTDdVVOU1bfb3sy87GupOL2
         BrO8AmxVzHaWwVEwXR4DMqJrqzFyMorKj8ra8hsTOfYP9gxnPWUdlppj3UHy3TTa7MBw
         U0WM07zHT1uHwVmStA+ISBTdeS4EpilYE4djVY5fF68yq2zOJcuP/gQ1PhIOsG4MJiLj
         hmMylHCt/vg8zMXWhNma3OMz8UJQeUVaJJO4vdjRmILWnz6LA1vgmrrJ6fYC5DLcRGse
         I4pP1Pg+rAc8hBrgsIEImXbaaAiT74RceX+19WX3ofrGZE40zsj5XJ+s2XE0/9+efVhB
         e3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057313; x=1784662113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NqdJXJeM556Mf9xSOIOEHagV9WIFU0/y7y2pnFLyVeo=;
        b=Em6Ehesf+LabK+CjFVUpWliCaJibFkxeWFpNXRZy5n+SdtQzRhs5CWM+0gHAEm9a21
         p/CvRteqQSMhmC23CxR1F5pUcumFnnQIQSjpIBfZ74gkPEIOjS0WyncZo9bZ1+TDDu4v
         Q/cQ7XjUFA/a14YdNiTaaWQwtPl8bcyJJEnUXR/Fiqf/q4PrPEUBUn7Qj0Tc29GR0BP3
         jdk7+iw+Q1BMcheahGlrWis5l11Lj1DjNFwDTUE8uINLkh0RXQipTRjBhz/4us/dRfi+
         1VsXhMCeYBiIlXcU4f3wDxKTCOYfZVeRPuQNTXA+vMfXVXqMHeGKVwAANp9Uq07pJQvo
         pD+w==
X-Forwarded-Encrypted: i=1; AHgh+RqEgJn7OnJumcuoqXZkVFEOKHUDWzNJy/sBo2ezMeezJfB5LJBVTR33aAJaVOJiHTZ1Fvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFNmRnXOy5/DBygSczOaayOQHZo7EddsesTPFXxqzlVltQRl9
	jKMLUX362xkBRfy0M85j5ToyPuigQmmhHBKANfPQW0hY/7WWhRrPBHhGpeHm1PLdaZkM7vOdwC4
	BdkOuog==
X-Received: from pfwp17.prod.google.com ([2002:a05:6a00:26d1:b0:842:3ec1:2810])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:99b:b0:848:2f84:737
 with SMTP id d2e1a72fcca58-84a559e4581mr3949508b3a.74.1784057313202; Tue, 14
 Jul 2026 12:28:33 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:15 -0700
In-Reply-To: <20260706095910.39798-1-leixiang@kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706095910.39798-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405356967.3121255.16313832351701071433.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Remove kvm_debugfs_dir on kvm_init() error paths
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, leixiang <leixiang@kylinos.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 06 Jul 2026 17:59:06 +0800, leixiang wrote:
> kvm_init_debug() runs before several steps that can fail
> (kvm_vfio_ops_init(), kvm_gmem_init(), kvm_init_virtualization() and
> misc_register()), but none of the corresponding error labels remove the
> "kvm" debugfs directory.  Any failure after kvm_init_debug() therefore
> leaks the directory and its stat files for the lifetime of the boot.
> 
> kvm_exit() already calls debugfs_remove_recursive(kvm_debugfs_dir); add
> the same at the err_vfio label, whose fall-through covers every path
> taken after kvm_init_debug().
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Remove kvm_debugfs_dir on kvm_init() error paths
      https://github.com/kvm-x86/linux/commit/db3a46e200df

--
https://github.com/kvm-x86/linux/tree/next
