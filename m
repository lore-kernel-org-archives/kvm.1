Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE94427F9E
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380151; cv=none; b=QHNNC5c5ORcuDH+tDsnzMGSebnE7XeF8O6piFuJmxAiIG12Ulv5YrBvs/IVRigA4dmeoWo5kwxzCzuLbo/9TEp/8Jv/6FplabeqbTJQ0j/wyqiZW6f7Bt6SrMOqyPXn0wXpIme1bL//WkyLRr2xm4kfVWdqNd1JVUNVHUsKoOOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380151; c=relaxed/simple;
	bh=18EoA/xa5wu6UGPt1xX3ZYgfinL8Hx9sPGkt/lCoJjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TbXZHt2pJrf15qnsnlCpi4dhIwCgQlv2h5IOMhxU6vlr2sTl7Qd58XCodtTQXE0BbpxifIkWQpEEyBP06VnEzCGYA6NqWwivczuBOVwQBrhLhrrMxFJC9uKstGB++rYdwc0wh5olOMRczXZAITQwiEe6v4pIntut0l7WZqx4XyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCZrv7lO; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCZrv7lO"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e04598adeso1783284b3a.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786380147; x=1786984947; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1aMkrKlnySSkZTh98FOauiGYQlFOQqftaK5JuEjFP4g=;
        b=OCZrv7lOaH5GGiWiSTGo9sOZLKOUWniv4U0nh2OOTOGk9ZnOFWrSzl5+z4LBFX6F1F
         WqqUUkEohic2BBlUestzm8czL4GjmlkM1b9QICFO6e6cqhoLVczSRA1s2HjSsaAFHjUX
         K7vviHue6tbdd9s1KhnSISjOubtAyjrvxKbtJK4YzIw7RHhPbd11DncjSRRfdKTYA0+O
         AIUakgZgFVTFlKf2s8QLoFqMVMosNVOMg6bVlZPO8Xf+0NH9xzwlfzQRSny4QT8p8YEt
         MJHghrGXDZUQuuAX2YKxjTxxezGuTyRusSLBPRjZnuNaJbrMWQykkRHrlsAgjwWj6MvS
         0V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380147; x=1786984947;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1aMkrKlnySSkZTh98FOauiGYQlFOQqftaK5JuEjFP4g=;
        b=sHpLvBHyRew5wfha6XeRtTb4q6zBwF8kJ6r7qQeJlqEw5M2f52kyPr4Lvlcm0/XLRL
         8B0aITSJhiHXu1n6iC2Da1u04UfyW29+axHDLpkv1fX8KjFaU7U9GkQqeimMKYZXqQ8x
         vV7jBeYrLgS19JxNTBykgzvIS95JI72EIRjpZO0AmhgtEg9OTgLQ+0a2QwND4YvlTOSX
         NxUp0DxYEBKgLPDTYZuTCi2lYY1MDmwaNugTi7rgGQOa24N+a80isuwrA2+YqRJdSKO7
         RSyJF5mEKAHAD+FdsGakHbrKx27SQCrIJaklYIEstSyPn6IZzygyFaxms+HHPLKOX1UR
         KaIw==
X-Forwarded-Encrypted: i=1; AHgh+RpjzPfNcg+vTbZGAtFSSERpEJ6Vzsmh5YMmETnXF7s1UuI/07acoy7dfIfhlnpYCh4FGE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEEhjRPDquk62G6+3S/nw9YpQ9bcAroPtJQ7tQg3DV3Se2ax3
	HclBCQ66Dr2bzgTW02MYlDP+SgJ7xOW5ipyX9Cxh/5v1RFtmuBn/BHIF8hFppDeS+SeJcMaLehd
	a+mf6lg==
X-Received: from pfbkr10.prod.google.com ([2002:a05:6a00:4b4a:b0:848:569f:3464])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc5:b0:847:8dec:1427
 with SMTP id d2e1a72fcca58-84f4fd9f647mr32987651b3a.8.1786380147208; Mon, 10
 Aug 2026 09:42:27 -0700 (PDT)
Date: Mon, 10 Aug 2026 09:42:21 -0700
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728144954.355376-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <178637989949.703398.16006467247639187150.b4-ty@google.com>
Subject: Re: [PATCH v7 00/36] Cleaning up the KVM clock mess
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="utf-8"

On Tue, 28 Jul 2026 15:39:40 +0100, David Woodhouse wrote:
> This is v7 of the series to clean up the KVM clock, rebased onto
> kvm-x86/next (patch 1 of v6 is already merged there as commit
> 710b3a30f407).
> 
> The KVM clock has historically suffered from three problems:
> 
>  1. Imprecision: get_kvmclock_ns() computed the clock from the *host*
>     TSC without applying guest TSC scaling, causing systemic drift from
>     the values the guest computes from its own TSC.
> 
> [...]

Applied two more Xen patches to kvm-x86 clocks.

Given that KVM was updating the wrong sub-leaf (which amused me greatly), I
didn't see any point in waiting for the new uAPI updates to yank out the CPUID
updates.  Holler if you feel strongly that that change in particular should be
bundled with the kernel that adds the TSC scaling uAPI, omitting these changes
from 7.3 and waiting for 7.4 is trivial.  I'm just trying to reduce the number
of in-flight patches we need to keep track of.

Thanks!

[20/36] KVM: x86/xen: Prevent runstate times from becoming negative
        https://github.com/kvm-x86/linux/commit/36a85200643e

...

[22/36] KVM: x86: Remove runtime Xen TSC frequency CPUID update
        https://github.com/kvm-x86/linux/commit/7d3bd21e457b

--
https://github.com/kvm-x86/linux/tree/next
