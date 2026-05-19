Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49924DCF9
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151340; cv=none; b=BrLgYcxaeF71mFJuZ7MqJz2arq1IWf0mxxnEXO4Nz7ZYAE6i9zKrBi2yFYMSEgev/1K+Qm9+9PDFb/m5WxWyt8bmzNX7zi0wf9OppG/rT3BZddPB24Q4UNgOWUvBwMOZ+lmxWDm/hgtJNkW9KKYdH38UE1dMyJxWPVyKtcKtrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151340; c=relaxed/simple;
	bh=go9jzMrocMcEPbaDoL2gNaf6261Jf9BB8OBRee5rK8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fc5WqKmb9pqqyd+ByHE9Q6q73GT2CeIG9lJgvFIOAH9I7eoo60or9YE7eWIndelztMTvpoqjZ+UFFkYmmgKBACnJOa7L2KZdBtXY8Hi1m3zx/tqer1GJAaruUZUX5CGMeLDF13sKGVnHf14weG39/v0dHEvcrJmrKcm8i2fngBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JM0pHtgq; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JM0pHtgq"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so3812688b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779151337; x=1779756137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAWTgC2n5XL5hrjpKs7d7iBSwBHUavq9roRCCFpKuYY=;
        b=JM0pHtgqeOv4XuHByNhIoOCa4LPZVPEeQWyzFLnEqJ0rUaKzijX9x08k2ZWsw8mwdY
         kX1RIaZnbUwe83Y19AMvSiKjqepumt/8hHsgwFtID9JSERXP7b1WslWXxp+Ji6SCZBay
         NbArIlvLAbQwnqdrRuEZSeEcXrtnSUxpQPUQc1TQLwKkLa/LHzcmRB8fGcf++wudF8+5
         0XA9MPzdfGtcyH17KWbKOeHZoFHcmbCW1vmd0h0DV1Si1dJnE9lxquDMDTNElmH2d3tR
         4oGP1X93OR8R5pj8lN1TPyDUV/sg7AFwbMgXuTNmYAH5Jv6JRF7I4GJq92Hfm8QGm7Tc
         B2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151337; x=1779756137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAWTgC2n5XL5hrjpKs7d7iBSwBHUavq9roRCCFpKuYY=;
        b=CBcwJ1T6vKo1S6GHMVt7nFY1pYQabVrZUa0YkQJFCBCbQxCKTLpjJiUM3aaPr+lkWB
         TO45lx1lFQPPB4goTo1QW8z5rnGZ7VQ/7epiu57EKfhIfIjOzwi6G5y/enschwav87uX
         XP1jmlxHDAn5DZMreeDvPMusr3cFBFxwT7j+TZbcUChLWrZEgzDac5/S9eCmqDnuNE/W
         dezw73yobUZJJ2bxYiaeyFcvcnnXof+kEXN5xN8H8WbS3NMCcbpLn0S+pO2dJwIs9km4
         1mXW+S6Vfq08jBeucWszesBPz4uO2D1qHQAAkJvHIE5hOdNCYg6lrnHLThn+VHRC5hFa
         vmWA==
X-Forwarded-Encrypted: i=1; AFNElJ8icQZl1oaklTbz1mEZ0k/Tx0cESeEsK3WPhAcrY0GB4zwJUjfAIf3zn4o2HI0IZFPkm4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5v56GauEpkjNlAA1xVS1YwrzvE8PSGKxHulSJiS6PRYlQor4
	lxDzMXS/oZCnhdDfyTTuExekF3znKbwgLyq3FAhZ/oGSjLc6ZfcVxa0q2HWuuwiM3vbRd98d0ou
	+H+M8+g==
X-Received: from pfde1.prod.google.com ([2002:aa7:8c41:0:b0:82f:7fb6:b50b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440f:b0:824:374a:1407
 with SMTP id d2e1a72fcca58-83f33c9e8dbmr17940362b3a.16.1779151336836; Mon, 18
 May 2026 17:42:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:40:38 -0700
In-Reply-To: <20260408001137.3290444-1-peter.fang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <177915089967.2228074.1398572969116564533.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: Fix and clean up kvm_vcpu_map[_readonly]() usages
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Fang <peter.fang@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Apr 2026 17:11:27 -0700, Peter Fang wrote:
> kvm_vcpu_map() and kvm_vcpu_map_readonly() are declared to take a gpa_t
> in kvm_host.h when they're supposed to take a gfn_t. First fix the
> function prototypes, and then refactor them to correctly take a gpa_t,
> reducing boilerplate gpa->gfn conversions at all call sites.
> 
> No actual harm has been done yet as all of the call sites are correctly
> passing in a gfn.
> 
> [...]

Applied patch 1 to kvm-x86 generic.  I'm moderately optimistic that the gpc
stuff will land soon enough that I won't regret skipping 2 and 3 :-)

Thanks much!

[1/3] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
      https://github.com/kvm-x86/linux/commit/ccd6c77223bb

--
https://github.com/kvm-x86/linux/tree/next
