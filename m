Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98520221DB3
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280048; cv=none; b=oYA8zq0AdqMFird1nuBWmFupcHXKX0GWylr0rV2uyU4sUzMbFS21UtLyb5I75AhwzwOjNlrtpKJ/7gutPRqsIhFEqcePj+9RTWnfJ2Wz7qn0Y+QnOX6UhHeQ8itP1RKoh3mdOihtbjqf0gESQEfLvHDV/jMxkh2ZrKT89VHLF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280048; c=relaxed/simple;
	bh=o97w9NRqbeWaBsrlLHwdDwKFD4SeQM8QZRNc0L/f87g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QugVkKWyzz5LKmCSzNbMD/MV8UO+djPrubF8lmltZJP2zebQXoB+MznE2W9dOOsDkH4RnqwSmUCPxhfUmG4PPw3VRPEhliedfhWok741NUzw8z3Mgr130d7/nI/5QQiyQrNu1iAEp0Q795gX/yJfFl5vwcuwPulnSIfjcylt8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmOlinVH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmOlinVH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so1357834b3a.3
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778280047; x=1778884847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6paMQ5rpkbqCdNlSzeAiGOCLeuMnOfoSXqIppqWME=;
        b=dmOlinVH1TLTq/e3UAWQyvFIHCmUf3Jqy/OZfm7+eypbdZ4MurAz/pMdsyl+9VSFMO
         1bf3aNXQAY5Jdq6aor6ZbnNqaFmyCwVJCxjI7SACdvSJb0HUVfeM7ze09lkAt40geDbf
         Y/DHRphoQuOEJaU3jI3HUPdt3fcYXzZzkyYVH4HfTPjRCNzzju92xIuxukIArrCEJjcb
         eMwrIoHLA8FmvO586hcw8pjMgMu9Z6YLUv5VZtzSXT+ok4gNfSRkENjN4UMdK61XXi5+
         i5LE6NzArsopsGk/vhV7hTvf/6Yg8xt6WBodF2Vf5IKF8nScTZyXahm/x740fYnYrJHi
         691g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778280047; x=1778884847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6paMQ5rpkbqCdNlSzeAiGOCLeuMnOfoSXqIppqWME=;
        b=eCIEpTp34cI7NG+liCBrATuYiYOYrU+hJY+oPFHiFEvE329JkaxiCCBgrLed178tx8
         WU2gAhY/PeVwvFCUKBgvNFaQC8dlsr1Iqw7ls2erVLowJl5wVXDNTFBsaUxSaQE/JvGs
         iXbd3Qad++FWe23oz4TQIeTvbHpDnMSawMuUy8PalcqeIuv44P13AjlA7Z+TyVbmUofB
         m6wa/Cq2N6aCUBNSzuBm6PwLJaGmsZLvTYeXcYQnqei7EHGyZYADn5ahOOrMWTFB/RZ7
         vBq3aBa4HF10/dN7UqgIHFHgc7+c1MtYBvGDBoxqDwJfimp+e1zi1gCE9vkkbMbiMN13
         96UQ==
X-Gm-Message-State: AOJu0YzaEvL7a5LqrrSfXEKKGYbx6IdhhZnlVK6gZGZeAPBArjoPvaf0
	Tb1emUmDSIZmTZ8T+vS5WARoBbyBlZAuwQ0R5bbD3cWneps3tUPxkMaEcfcxTfkh36kpHj65LAX
	/puKpnA==
X-Received: from pfbhr5-n2.prod.google.com ([2002:a05:6a00:6b85:20b0:83b:b70d:c021])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:908c:b0:82f:3828:a01d
 with SMTP id d2e1a72fcca58-83a5d2857b4mr14886058b3a.29.1778280046621; Fri, 08
 May 2026 15:40:46 -0700 (PDT)
Date: Fri, 8 May 2026 15:40:45 -0700
In-Reply-To: <20260505003044.78693-3-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505003044.78693-1-dongli.zhang@oracle.com> <20260505003044.78693-3-dongli.zhang@oracle.com>
Message-ID: <af5mbWXpG5ofRdJ2@google.com>
Subject: Re: [PATCH 2/5] KVM: x86: Reset vcpu->arch.st.last_steal when
 enabling steal time
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, vkuznets@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, jgross@suse.com, 
	dwmw2@infradead.org, joe.jin@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Mon, May 04, 2026, Dongli Zhang wrote:
> KVM does not support vCPU hotplug. When a vCPU is removed, its
> corresponding data structures are not freed by KVM. Instead, QEMU destroys
> only the userspace state and the vCPU thread, while the KVM vCPU fd remains
> open and parked in QEMU.
> 
> As a result, vcpu->arch.st.last_steal is not reset.
> 
> If the same vCPU is later re-created by QEMU, last_steal retains its old
> value, while current->sched_info.run_delay starts from zero since a new
> vCPU thread is created. This causes
> current->sched_info.run_delay - vcpu->arch.st.last_steal to produce a
> large, bogus value.
> 
> Fix this by resetting vcpu->arch.st.last_steal to
> current->sched_info.run_delay when KVM steal time is enabled.

This is quite arbitrary.  E.g. if userspace hands the vCPU off to a different
task without going through QEMU's hotplug dance, then current->sched_info.run_delay
will also change.

Shouldn't x86 hook kvm_arch_vcpu_run_pid_change() and reset last_steal in there?
