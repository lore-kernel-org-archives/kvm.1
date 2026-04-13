Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC435AC0A
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077494; cv=pass; b=Mb6C3fasCZHZ09NkGXgUYBF6E0L4GCwK2mRlro2uEdLN0ynZsIn8q5VFnucZOMkzjMV6EMjMsAjCrivUEGvv3ziTDxMIKTtPGOFdNV6ltsuk5DvQg3ug++YjDiICl4ixfTJdHsdwEtHg/5ffPGaj2STIdPb/uiFPupcU4zIwmPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077494; c=relaxed/simple;
	bh=JCceif22lhBxyxk9JKEcfw4O7hHIs3wPDxbqncb64vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUjRk4euk/9yaqlkZ/qm+RG8qZUK4DwA4j3bIsRHag2cLlwS7GaLWqHRCin59pGsVjg/1cqZdMbSPkxQ7xE0mcuoNa8RmUF7CozbLc8kyAobaCgZFaHkyEnqqu1m7cBSXcm8Vv3Lkf2+7J+BTcbNK9e1oVbo6wUT5UfPs+YT7jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChLoaCs3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mfAfwKO0; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChLoaCs3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mfAfwKO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MU3KuzDYdkVGLVnkMGPaBneyj1YHXQh9jjzxzmMXNSU=;
	b=ChLoaCs3VDstxExlcZwHCAqgzYQxfmNSrOS1qPTdMPqumhHCG62DVi7wUfL7zW+6JACygO
	JyogXgKJ1Qi9M2FhubgAAp4f6tR+ogsARDSzYGwtqJCxNCllVFJYs6GmWKiV8hBCh+oXPQ
	zM1QaCHUeeOOfyV/6G3gtd4BwfyVqok=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-gw8TKW_JPm6c4iR03S_WWw-1; Mon, 13 Apr 2026 06:51:30 -0400
X-MC-Unique: gw8TKW_JPm6c4iR03S_WWw-1
X-Mimecast-MFC-AGG-ID: gw8TKW_JPm6c4iR03S_WWw_1776077489
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d14a4bcd0so4620792f8f.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077489; cv=none;
        d=google.com; s=arc-20240605;
        b=UikkRHoud1vES5RUGP5v01SUJJk5uDS6wGkmOJPEBMankQaJckwy06eEJa4/4aSQ0G
         3CFj/WzZUKkrqOMdP9CTzDUt7WlxRRWebAPjSQARuiejFJ0fYgKe1/qm78M7VDMHLYzZ
         FkklGH/PvheFRVsOFga4bzcEplbiqCiEUVgj70oXeNFwJ59KDVpvGuTy7kQdNNKrqKSp
         Jhn2n3t3qlywOnusY56hm366n6VdkuJtxnuxuX5+AXELBNEetHtwN7Y32UuhzmmTbGtD
         lh/sLs5lXvQxDnADxxsUCUQh2Mr469hsnFH0RpwZKQlPR8F4HTt8Ea8Dgts6jOyAf/ZM
         dKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MU3KuzDYdkVGLVnkMGPaBneyj1YHXQh9jjzxzmMXNSU=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=MFxDaJt0AOKLou4BThxZlkX5m+kR3dRUhnvlFOBoWpOOpQMYkvMZhW68TcyqgfJlhC
         GNf7pLIMiYNdJLsTQQXW51vYsUTDiVA6Eu+S9BZlbx3AaxaTQ3uIuv2nPBDdTBbtYTeo
         rM+63TKRuCuueFNAECYX2RCN9KUO1LMjZM9yHD987Cyoq83WMXotm6XBtcy3QUa1jTxG
         lcdYLypObYP9yicKJ8OQX3DRM2sS1VNYCffxSAEgkGsQOZBxX7qZQHA3THDTeXIN/M3r
         boAl0EPIeV0OU+DfRYd9kIiZgjOWk1DJJLucLiq9aPwSpddxMjhriSdvwDqTINdaaUWY
         Sf5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077489; x=1776682289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU3KuzDYdkVGLVnkMGPaBneyj1YHXQh9jjzxzmMXNSU=;
        b=mfAfwKO02y8/bwy+F//MLwAkSLXIJl2kBMXgxZwzLzgcnpJWGL1qNmsdige0PI+Vps
         jF+C0eo6aH3aQweTw+cYEe+3dS+0FhKxyEpK3yhkYNj8om5HqnHdRW5YCLq+U0Z7iZPM
         4NjJa/2sRQta6aSXWSY1P/LhG6JVY8C4cWIukKdfGfYu1XXVwtRphgRpCZ78xgOegvlm
         7WakClPu5AuuC4Xgc7zDtuVn9Ecyz9GV/M7GzsG6qTbiti4Ff2MMuODauX8d99P3Nfcu
         rFy762arSc0/X06n/fbE/fRDQYVgXG+omzVQ5nmdmleum84E393lTJFJbsRlYGnJeyF5
         Fn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077489; x=1776682289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MU3KuzDYdkVGLVnkMGPaBneyj1YHXQh9jjzxzmMXNSU=;
        b=I9F1eUy3FTGFG+u2VKVLd/f+ryRoUD/+C52BxxvAR4j9Q7H3sP8w6/sF7Eh4hhMDOz
         aVSm5H07nRY1neqBGYPHthgdgJyh12VS7AUI3KMYrU7TT+YPTjBcxe3ApsNkpu34x8Ke
         2q102HC1BtaJvxXqrqo+z/XZyo+s1bo9dcW7X1EIXi63G+MJ9jzY94dAk2YdE9BrAz4D
         bKh66Rlh8isZ7OgYRjkQpd2RR230jRdkFyix3hBhajU9gQWwm+mSdS1VqG20h2TDrm5t
         Ev6srZqckG296jqlUOWBy6vE4cMMrgmEr9SP3uQee4mYpOZ6CRusx7/8TzM2eplSgHRH
         lyfg==
X-Gm-Message-State: AOJu0YzhWrwKyLaTmXD7hhUrrJU/tayUoE3Ly0towqQl3v/Lu05joRBd
	bjWPZyJxAkfJ8eTo6ov8EGYnqG8GbYjkJ0+3JGKw1iZH9cj99YkbGiLv/7nvhUYVeQd3pbnQA4W
	pNFjtuZogU6jzQa3ucLqf41kLkMj9Vp+zI0ltyFoMcv6CZd4E+590JABEu1EVGxTYecqgJ088QF
	xL5sigtN2xidHN4eFaQUO6mF+kUIBu
X-Gm-Gg: AeBDieuENISL9BIoPl/Ic+Tib4haNo0PtY1hEVnHc/3R7nO4mP+EkYzAcLmBOcTtoiz
	QBUDv1XObjYCDX9nQ4WyYEnOAg1DqsAoM8PiVBrDBQPFhkZ/GwdMqFAhKZ8E+V0l1hKU+6JLwTF
	KgrJEhtcD0TArZF6NcVGmgzCAkw036Gy3xbpTk4gNGWIdzL/MwNOt5xYuPNYvgoKf7ptkuPU+kv
	Bj2pNo3bNPsV5Y5v59guVqvrwhmuuKpM2wKJHONso35yJ0JOxIA7mYrtfdl/iuvkRjW382FKQNJ
	YzY2
X-Received: by 2002:a05:6000:4010:b0:43b:5095:d101 with SMTP id ffacd0b85a97d-43d642b8e12mr20195874f8f.27.1776077489208;
        Mon, 13 Apr 2026 03:51:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4010:b0:43b:5095:d101 with SMTP id
 ffacd0b85a97d-43d642b8e12mr20195827f8f.27.1776077488759; Mon, 13 Apr 2026
 03:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-4-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 12:51:16 +0200
X-Gm-Features: AQROBzDIfMN9Am6SEeGBF5Ww7al5IVfmkEe6-kqeSNHvdMjDLFy700XzbxY_lU8
Message-ID: <CABgObfa7hg_zuT5nobNj2UFwObA5pdAQSdnD2S8LwAGO68hYXw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Misc changes for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A truly misc bundle of changes.  A few minor fixes, some cleanups, some
> hardening, and one new feature (AVX512 BMM on AMD).
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.1
>
> for you to fetch changes up to de0bfdc7137d5132b71dd1fe7aa3ca3df4d68241:
>
>   KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace (2026=
-03-12 10:56:36 -0700)
>
> ----------------------------------------------------------------
> KVM x86 misc changes for 7.1
>
>  - Advertise support for AVX512 Bit Matrix Multiply (BMM) when it's prese=
nt in
>    hardware (no additional emulation/virtualization required).
>
>  - Immediately fail the build if a required #define is missing in one of =
KVM's
>    headers that is included multiple times.
>
>  - Reject SET_GUEST_DEBUG with -EBUSY if there's an already injected exce=
ption,
>    mostly to prevent syzkaller from abusing the uAPI to trigger WARNs, bu=
t also
>    because it can help prevent userspace from unintentionally crashing th=
e VM.
>
>  - Exempt SMM from CPUID faulting on Intel, as per the spec.
>
>  - Misc hardening and cleanup changes.

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Anel Orazgaliyeva (1):
>       KVM: X86: Fix array_index_nospec protection in __pv_send_ipi
>
> Carlos L=C3=B3pez (1):
>       KVM: x86/pmu: annotate struct kvm_x86_pmu_event_filter with __count=
ed_by()
>
> Jim Mattson (1):
>       KVM: x86: Ignore cpuid faulting in SMM
>
> Li RongQing (2):
>       KVM: Mark halt poll and other module parameters with appropriate me=
mory attributes
>       KVM: SVM: Mark module parameters as __ro_after_init for security an=
d performance
>
> Nikunj A Dadhania (1):
>       KVM: x86: Advertise AVX512 Bit Matrix Multiply (BMM) to userspace
>
> Sean Christopherson (1):
>       KVM: x86: Immediately fail the build when possible if required #def=
ine is missing
>
> Uros Bizjak (1):
>       KVM: x86: Zero-initialize temporary fxregs_state buffers in FXSAVE =
emulation
>
> Yosry Ahmed (4):
>       KVM: x86: Check for injected exceptions before queuing a debug exce=
ption
>       KVM: x86: Drop redundant call to kvm_deliver_exception_payload()
>       KVM: x86: Move some EFER bits enablement to common code
>       KVM: x86: Use kvm_cpu_cap_has() for EFER bits enablement checks
>
> xuanqingshi (1):
>       KVM: x86: Add LAPIC guard in kvm_apic_write_nodecode()
>
>  arch/x86/include/asm/cpufeatures.h     |  1 +
>  arch/x86/include/asm/kvm-x86-ops.h     | 10 +++++----
>  arch/x86/include/asm/kvm-x86-pmu-ops.h |  8 ++++---
>  arch/x86/include/asm/kvm_host.h        |  2 +-
>  arch/x86/kvm/cpuid.c                   |  6 ++++--
>  arch/x86/kvm/emulate.c                 | 10 ++++-----
>  arch/x86/kvm/lapic.c                   | 13 +++++++-----
>  arch/x86/kvm/pmu.c                     |  2 +-
>  arch/x86/kvm/svm/avic.c                |  4 ++--
>  arch/x86/kvm/svm/sev.c                 |  8 +++----
>  arch/x86/kvm/svm/svm.c                 | 39 ++++++++++++++--------------=
------
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h  |  5 +++--
>  arch/x86/kvm/vmx/vmx.c                 |  4 ----
>  arch/x86/kvm/x86.c                     | 26 +++++++++++++++++------
>  virt/kvm/kvm_main.c                    | 12 +++++------
>  15 files changed, 81 insertions(+), 69 deletions(-)
>

