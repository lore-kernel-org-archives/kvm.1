Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542063911D3
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035931; cv=none; b=lAyqTp1psS3dB1P2pFqAzeOM/sRgnAK9S03Oy9wbeMqVLHpsROynOnRsOQcMqAz8M66TxwYUqcD3uwDcC4zMFMnTCW2+5iE/FAIYCpDPuHqdtUO6axTjMdVFn7rnp668pMkXxn/MWy3SP1JIT/GHxJt+4PCDJKzJoOd1rAQaY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035931; c=relaxed/simple;
	bh=9tNs4dqxRFyP90eQFauIOedcWXZRofnOvwz8agHbVaU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=BWLZiuZ/PIB2CbvORDsfkDX39xnGsOOu1PjG1HmzWJQZ7J453g8FgBHziwX6Ngioj6PkL7oA+F+RuhkwS/J4bcaHmlqOwQJbfxCSW3CycTDDgmPzGTlSGmzPSA3v2Z2azfWcPIlMxk7e9bJdEwv4Ppg5oZTNq2edD0C8E4i4W+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPLD3TsP; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPLD3TsP"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so3980583c88.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792035929; x=1792640729; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=hPLD3TsPSGMnptvsYH4IuzPpO6zxpFiXTGuNM538iTOXrk6/earv2op6r2zGPbu4Z0
         6HQXzaMnxQte1gGlLwGJsRP2UzyUMYcS19bd8qrDyexfQDHZz+aEriGRhV2UvOlJ90Z8
         P6L8u7CPTKO20IPTXLviOxK6l2IVW0c/tlMZ4mD+jGyfz1dWe8MyWbYZ4qQ20LyC0+6s
         5/7NyqFwCLlezfSgHwWJyzN3ysnSyQABQ84Muf5/Zm6slKw7/iaQrt7ba+3qzN5utG6u
         MRuOtlJh6W8ydLW8jO6W4hMeXpUn7TX9rx1QbJ/hcOQeZprv+PMEn8PZU/ebh0n6YFK5
         K1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792035929; x=1792640729;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekxAbaTw9lcA/repE4rySfHgfzkYuU+ooIR190sGV+c=;
        b=EXZuwadhN5AbmfrM1mQNhex1hmQHkpimlOyAEM53z3o1BA58tu7cZjVRp00+E+jOF1
         Z17hmXkJHjnTwjOrtpx2BsNzAmzvwVrLcGMC7zGO5y5aQgisM6m7gGhinDHuNtDexbFp
         tosTfXe+zzzV2+Sa8qg1ZxUrW4FTYoV26z8liKlYFHAGuqKFs0R1KbNLGPrlK94DyfzB
         4MCHsn2aZsytcolknliIDAJIv6eCLr5TeFzn31eau7kUFyVC+T7XShsu5WBx+eI6wBjU
         BQKuoREG1GkXL/VZUnIKUFQyl48/RNkOOYhXf4J6Q2v2wjfjms07zIBW3B+tszpCr+9z
         4A+A==
X-Forwarded-Encrypted: i=1; AKwUvBxyEKKersRDRHyng5xvw3Urcmv5Uq2UwemdHfk27H0BvDzgMvnLwEwh6epSDqGK1fX6kU0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFKNJOViRdK82Gyjv0T6ySgVZzj3s6tF9Ue+T6dHF3n7R0c7FS
	Zazy3+xr8wjOSfMnyBCjRdbsM/BRHKJtxPqbBG/16GEpxfi9AjXfQ9Hx
X-Gm-Gg: AYBFou3tFYWr3YfNJ+hScnt9RI7trhLMxFdmuk3eDj5LfV0nAKAxhukuxuE5kyHrGvH
	/s7hzjWJhwTKHS2HFQNoV+Ypuc9/f0kTWk//P5Nbuj41/scRD4EMS8mp4Dgeco6+ljDCxeC3yr+
	XpE0dU4E1QM4FOATOXpCcG2fubMxgSRorVpAAwNIau744htvU9gsS8JSF9407bb2klfLrl7v49g
	37XYmiih9IqBx1f+djW2KhZjLN+TbSsj13H9lik9SqtC5xvMIumzgXwTsZhYfKl/akwLIAytaJh
	ecXj4OaUz9Hm05EYkA1m1HjzaR0kc6LHbsGBg1EygOmM69ZGKIKT1U9R0Ws9ixAzEsCH9ObshKK
	hxQ0c+40ywQsNZ51POodpL6MBaJhgQupkN/XZbvL2PCzMUP6UlvN5IXLYsaQgYjqSruiEHiANw7
	4B5kAsvDJdhZv6ICNMgWOnaLtybflAEt5PLjDjLhfBThvnsU9fyUt8w2NtrO69pYf+pnq+
X-Received: by 2002:a05:7022:7e08:b0:144:fa58:95d8 with SMTP id a92af1059eb24-16a61a6ebb0mr33060504c88.27.1792035929111;
        Wed, 14 Oct 2026 20:45:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm50853605c88.22.2026.10.14.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 20:45:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
In-Reply-To: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Date: Thu, 15 Oct 2026 09:14:32 +0530
Message-ID: <v773r5jz.ritesh.list@gmail.com>
References: <20261014185215.71832-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> A previous change ("KVM: PPC: Book3S HV: Add preempt_disable() around
> virtual-mode HPTE bit-lock users") at [1] added preempt_disable() around
> guest vCPU HPT hcalls and page fault handlers executed in virtual mode.
> This ensures vCPU threads cannot be preempted while holding
> HPTE_V_HVLOCK or the reverse-map lock.
>
> However, several host-side virtual-mode paths in book3s_64_mmu_hv.c also
> acquire HPTE_V_HVLOCK and lock_rmap() in process context with preemption
> enabled.  Specifically, kvm_unmap_rmapp() and kvm_age_rmapp() take both
> locks during MMU notifier callbacks and memslot flushes, while
> resize_hpt_rehash_hpte() acquires HPTE_V_HVLOCK during HPT resizing.  If
> a host thread is preempted while holding either bit-lock, any guest vCPU
> thread scheduled on the same CPU spinning for the same lock with
> preemption disabled will never yield, resulting in a permanent CPU hang.
>
> Fix this by disabling preemption across these host-side critical
> sections.
>
> For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable()
> before lock_rmap() so that both the rmap chain lock and the subsequent
> HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
> To preserve the ABBA lock ordering between the two locks, re-enable
> preemption after dropping the rmap lock on any retry or early-exit path
> before spinning on cpu_relax(), allowing the lock holder to be
> scheduled.
>
> For kvm_htab_write(), the HPT migration restore path, replace the direct
> calls to kvmppc_do_h_remove() with kvmppc_virtmode_do_h_remove(), a thin
> wrapper that brackets kvmppc_do_h_remove() with preempt_disable() and
> preempt_enable(), mirroring the existing kvmppc_virtmode_do_h_enter()
> helper.
>
> For resize_hpt_rehash_hpte(), place preempt_disable() before the
> try_lock_hpte() spin loop and preempt_enable() after unlock_hpte() at
> the function exit.
>
> [1] https://git.kernel.org/powerpc/c/abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907
>
> Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
> Cc: stable@vger.kernel.org # v5.14+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
> - Separated host-side fixes in book3s_64_mmu_hv.c into a standalone patch
>   (guest-side paths were merged from v1 resend).
> - Previous discussion: https://lore.kernel.org/all/20261007182116.12479-3-amachhiw@linux.ibm.com/
>

Thanks. Looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
