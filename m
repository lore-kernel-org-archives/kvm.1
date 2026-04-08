Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18107B67E
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607291; cv=none; b=kav7yr98u6oRtEib9WZpCVM7/NTaoteTjBQXRvohW61ksDd/b0A3HiJHCzc1efmOs095IWDeZNUH//b+dP7hi9a3Gl3Tan+xbBUXuCRye1VGqgKok7p5GVs7ay/BuHlBLra6zrhYjZacTAxz9gn4KWEy58rpSNHm8N5vk/CtaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607291; c=relaxed/simple;
	bh=5KxGGM+4+4sQsw/wZ1SfrWjwNPm6IlgjcJlez989a+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KeR/+UYSMGdXgvF2+0Bm3BBHe9pdG4X/+xjiTo26oqnDITRh/uZrkKb0cP4ar4fKyEyQA9RvphmSOEyyjiQZlY2jqWmrNlKKLqQhjskdrWKJhX2ZmaPm0m2Mc9X8jzgdjAqGx/xeMdQCEefvpSH5bT6tZ520ZJJJfYN7Pvq0mCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9OngwPn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9OngwPn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b15a3ccfso2929100a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 17:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607289; x=1776212089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6c/3aNAgdBfmE3uCVOikIv8jDS0Gj3+AoFK1vTn9w4=;
        b=v9OngwPnE7v7Ljkors5hICLxHEtXeAsKGKfUZOaQ2BQE/Be0wTcti+d9c1tPIVpWji
         i/4UjQhUEI+R7lUaXTVCuQz9D1xQbI5ttDrt/RloCzoGjpTQCovFBM+5ZjQh1mzg3kLq
         jMD7x6c8q27NJsJV9/F84/ZUIUm4zEFvnq41CuNwWX0BspEmsv8glIwxiYy/0CHDd8/K
         M7qE6Q7z5xfwEhK3VuzYnC7kmmu1o5qIg3/YcfCAyd7tGzdg/kmY9mmBpKonuClLowI4
         6gDjFr1Q3lGUArF8HMDLlIi/Et/XKPYu5p2PZNRVSBSpELHvqEndRfoSBpVL1kEhWTfH
         MI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607289; x=1776212089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6c/3aNAgdBfmE3uCVOikIv8jDS0Gj3+AoFK1vTn9w4=;
        b=Ilg/qmfoBaY9wiO8qs64S0MtMzbpsgA+AArVr0sH3wfagUXAQCriDBIBSfjhKpP+iV
         HnAWxJav4ZrQuToM8749jjnd398pxZ6jQEXn71qiT7e4DLykNR528SGl9CIZLOpf15h4
         9udYJRbK2zDN4Bwn9xmnw56k5Pzr9q07XiHniXQRY/vjLxlOfwtdRwKb7jrgfWvJ95CX
         DdoscZ7je2P02Wp6Hjr02CzmlNMjOPa8HMvy2IF8tgHItwCMeCOQ/Kcs9b9po8QZBHZF
         j2pDoMDLYFntfLwibRsIuj833WVI9WMmucRWozS4BtaG7Gt8bacHoFpqgBLg3c+Ek+xJ
         tgYw==
X-Forwarded-Encrypted: i=1; AJvYcCXHo+Y39IwB/orkOJoOYjbBMZa0C92z/bjS5+NdD5ZoYUy6UZQ3Aa0YZgx257T7ujYBxok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamIYSP1ADtgkNUuoyAGrYQ1ZD26th25JodTJpT7/WzqFjkncv
	VM/6t3AeH4c/whsXmM874ihjltdfpHWr3HuPpVG9kvsfFifXvVoc64/0p0NhkWOzppdcgdA2h0j
	fn5qtBQ==
X-Received: from pghu8.prod.google.com ([2002:a63:ef08:0:b0:c76:6b03:96ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918a:b0:398:80a4:d6ba
 with SMTP id adf61e73a8af0-39f2f01ec8dmr18831199637.38.1775607289290; Tue, 07
 Apr 2026 17:14:49 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:14:38 -0700
In-Reply-To: <20260316202732.3164936-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177560710241.1572937.2964119730170259262.b4-ty@google.com>
Subject: Re: [PATCH v4 0/9] KVM: SVM: Fixes for VMCB12 checks and mapping
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 16 Mar 2026 20:27:23 +0000, Yosry Ahmed wrote:
> Jim pointed out that VMRUN/VMLOAD/VMSAVE injecting a #GP when the vmcb12
> GPA is valid but not mappable is not architectural [1]. The series
> handles them as emulation failures and (mostly) exits to userspace
> instead. It also fixes the checks performed on the vmcb12 GPA (i.e. RAX)
> in a few places.
> 
> Note that there's a few other bugs that this series leaves alone, mostly
> to keep it focused on fixing the non-architectrual #GPs, this includes:
> - KVM synthesizing #VMEXIT(VMLOAD/VMSAVE) to L1 when intercepting #GP
>   from L2 on VMLOAD/VMSAVE, even if L1 does not intercept VMLOAD/VMSAVE
>   (e.g. VLS enabled).
> - KVM not respecting priority of #GP vs. #UD when EFER.SVME is disabled
>   by the guest.
> 
> [...]

Applied to kvm-x86 nested, thanks!

[1/9] KVM: SVM: Properly check RAX in the emulator for SVM instructions
      https://github.com/kvm-x86/linux/commit/c85aaff26d55
[2/9] KVM: SVM: Refactor SVM instruction handling on #GP intercept
      https://github.com/kvm-x86/linux/commit/27f70eaa8661
[3/9] KVM: SVM: Properly check RAX on #GP intercept of SVM instructions
      https://github.com/kvm-x86/linux/commit/435741a4e766
[4/9] KVM: SVM: Move RAX legality check to SVM insn interception handlers
      https://github.com/kvm-x86/linux/commit/d2fbeb61e145
[5/9] KVM: SVM: Check EFER.SVME and CPL on #GP intercept of SVM instructions
      https://github.com/kvm-x86/linux/commit/783cf7d01fb8
[6/9] KVM: SVM: Treat mapping failures equally in VMLOAD/VMSAVE emulation
      https://github.com/kvm-x86/linux/commit/878b8efa2adb
[7/9] KVM: nSVM: Fail emulation of VMRUN/VMLOAD/VMSAVE if mapping vmcb12 fails
      https://github.com/kvm-x86/linux/commit/2daf71bfd77d
[8/9] KVM: selftests: Rework svm_nested_invalid_vmcb12_gpa
      https://github.com/kvm-x86/linux/commit/428543fbf06c
[9/9] KVM: selftests: Drop 'invalid' from svm_nested_invalid_vmcb12_gpa's name
      https://github.com/kvm-x86/linux/commit/052ca584bd7c

--
https://github.com/kvm-x86/linux/tree/next
