Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795166824;
	b=0x2QJOXMgiLRsJjVx1TwADuA2EDOV/+wGqIrlqSgfW8mk1me4MNvIkXWaiIZdz8w0Le2
	 zKIVeBTxW9EcT4rjYlyl1aKEs4jeLkUMBtkDrcusDqGnV105jSwoWIPgztL8fwA0AdOk3
	 WDKJjSq8Vk8YhXXRC2Fne4xoHKGF/9jq7GOYlFnpJFeH1Llq0/hClvyX0krY0drvghIGJ
	 pgTvdgx2FlHC2DkB7GxXzNQu5KJ2c+1/gUh4TD5sP3UNJ67hngcUxvLl1LrnnsYMsvIL/
	 pMnWwS9+rKzNmHsliszOYb9FdsAzMLHuwztheME9Kt9o4QS9oA87ci+N/CHcEy2ZwCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166824;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=h8djd06ryjIB56cOT1YweoAp4sCU4+zNTVV/16X4KXY=;
	b=1YT2xm+EHa51Ja0UM93xmr+zt3+l8IsBGROmDsR/BD5Q+5pHtfYBhAC9NmqAteCNxlSI
	 z0hxOPDakwB+vq8Qq5j+kzNDZLwBH8KR8C39AY+MuoCrnhouCcYVcMgx2tqMjXE3Fcux1
	 YVJsp/HYCB4T/GYsySzlzDKVHN6sHKod247YVvDTQs7m+LsdHUIq/Co2RFHOE0vOgh3py
	 wDhHquKyGE3nExZSc89JDcl8xn5g5bjki3Xndf9PkamWr0z9GtZsnocs4Svx61CAgO8d/
	 fsbjyun2FBWIpEbHkZYzNo0JIU9abSavV8mf0UHmvzPScTpt6z6DlPfTsY8H0n9gKhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D72aomLM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U+2bhLBh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E8606A320
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 09:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D6E8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D72aomLM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U+2bhLBh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795166822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8djd06ryjIB56cOT1YweoAp4sCU4+zNTVV/16X4KXY=;
	b=D72aomLMsd/jG8+DIAphil/gMvd4WRoIcAO2NtPofIHi1VZMke57cxMYOPjvAeq3gR0khV
	uBydj5xcSuw8YdTvOoHA3sAY8RTCIHh9M0ciSRs7TaGI6/nWnkD7xbV4+XMqKzx/HhpmF/
	WC3RlqkoLjbgIWSoVS/+ZuB0FMmUlB8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-hoIN2Kt5Mr6bLsIlfnmn-A-1; Fri, 20 Nov 2026 09:26:59 +0000
X-MC-Unique: hoIN2Kt5Mr6bLsIlfnmn-A-1
X-Mimecast-MFC-AGG-ID: hoIN2Kt5Mr6bLsIlfnmn-A_1795166818
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b5e3b5daffso971099b3a.2
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 01:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795166818; cv=none;
        d=google.com; s=arc-20260327;
        b=hJjaBWjlfcAgbjYGTgreb4mj0NcgKOB7hh/RulQdT9tM3VrTiJP/d1NkxhAGSYiyIZ
         U9ExZMHHthfW9BQg94rOHlq47JgZax3zEg6bhOUmhRCvUKFECqQogWkvgOwVx/7krWB0
         9Ex4P8v3DiFg4qVHV3LkjVjXhqyrKNjrS1ICtnJm2T3oqk61ZB7LM6myBvpc4vYjtKRY
         kw6xZzxHjvD1zr8SXyBnc4iev+dbHmGFlwX/cM0zfTvkSF0uITW46dLuEescxeIJ541n
         eEp2b8T8h36NT7JzvDqyNGIFw3EdACX059q2WEG9u38zoxsSX7FsdP8BgXwWxT1J4GVn
         AORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h8djd06ryjIB56cOT1YweoAp4sCU4+zNTVV/16X4KXY=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=U82fMlmdaMYyGir9tlW3qQ7lDhDCINdGB7EPDqUOwDT8V+7RVy7B/5qsgsP6pc9q+2
         4dybB5Omgy2RiwIImCY8oZ6A1DjucEZ5Gk7qgvzxoQqa9RHa2Z4ttKR2gJWpHqvIARRH
         J0cbBq3U/HI+UihaAyMdGolgvGOGDtn7XT0UWbrucymIm6CHdjYwpW/sXtoZkDx3oIji
         rGPXtW0vRYKI8QoN9nRvAXEK0c18APxqDXiMVlxPWWXit2IXANtFoL91iU0WjxUAKLUS
         bFtor173bQMIh7crmIFK2I9/YGXw2GGAaJlRucNAFRFtmewa6xLdh5Fe6mNxlcqd84DF
         HTFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795166818; x=1795771618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h8djd06ryjIB56cOT1YweoAp4sCU4+zNTVV/16X4KXY=;
        b=U+2bhLBhzQM6qD5gTxIy9rDa9cQZrHvDPAWdgvfjySfONMUnWdFNWOYQzBahC6ztkR
         DumNTyOeX4/pdri0be+VF3J5ieWQM1YhDN9NmY/NxYkcpBYqDZuJ5WWmcYlzufRuqcqt
         UfqtdP8aVXk5QtWU+RgUd15QqdnqqGn+nhEpQWla0LixlpngvbRyMcZhgPFadVWONX04
         f4Y6D9cJimiUgzU22KF8RJOuzWjwsym55iTeMCY5FlgXhEFPhLbd92kmPvPLqoQOrbaq
         1X2NLW+Mi3UBOC4NixOT9kS7X0Hn6myI6yTGsqPJCZYocq3wHuZzxKVcwd/7yOlXhtjM
         b+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166818; x=1795771618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8djd06ryjIB56cOT1YweoAp4sCU4+zNTVV/16X4KXY=;
        b=mSrW0o7PuQpq9vkXluVoZV1Ug9LIQ/YxW2jfyDbOSEDXneRTXF6qdB2EthpufmVvMG
         CRx/qq9NzPhJSUcgjb7DmILZMJz4YgY4Gr6WWxUKujowqBWisqHSkjLj3Vge5o0j2Hzk
         uVkbj5YAIqsNbNgfM7uduNxpnDTn6lP6gluvm+LFSX9ZCKOIAqbJNU0G4pECZkwHEN5T
         pHJ8z4G0AVeQp89SHa84wZxZxjYLtTFZcxejPaUfT48iO2/ASgPaebjbOMKqf38h/KcJ
         vCoKM/O059KKObT0Uo9njfeRSqkdXAM6R/d6WUq2q5LH72y5WNLN9AdhAFUsbI8iNrjb
         Lwuw==
X-Gm-Message-State: APuU4Z9akZvW7T/9DyeipGvsUa3TvToGR7hHb0fbs8uV5cIg2hlMZi6u
	4gTPZTpd0L3tpsAJzmLZA0M8yJ1KY+12MUTCVSFelTlCCXEQzt8jlUuzwEIYlj9fYPy/sf8I6Dj
	MWKM73stDcrQxPVtnzYLCNPrQr1OBYftgJ00JZABA/ZzxkNDW+0wk+Dca45kZtaZeEvMUTO95VU
	RXVhcbc/3n2kAuc075oCS3rAup6x6M
X-Gm-Gg: AYBFou1xSMhF7KNd3PMuMGGDDpybsPruIHKORXQkAA7Ki4g12dwYwIjNq3jOwDMh0s9
	kBy97EQLmK2ZUz7U21fFGS8xzpXKPYiYvQa92nDEFFxn4x3nUfUakw3S8N+naG/huNaxdimHWMY
	bDmLterOxfInDoP2TIW4iA8qdrLvzBM6T9bWghDR/okvYBElI+1Bb1S9S4PbP11wpxJO4zrSyBd
	1dxm7VzSFnzLg8ziLemRMEYQGys+2zKHbsgMTIXeMR3vuVDToBOiAYRe71h
X-Received: by 2002:a05:6a21:32a6:b0:3fb:3a56:e41b with SMTP id adf61e73a8af0-4014db62821mr3386137637.48.1795166818240;
        Fri, 20 Nov 2026 01:26:58 -0800 (PST)
X-Received: by 2002:a05:6a21:32a6:b0:3fb:3a56:e41b with SMTP id
 adf61e73a8af0-4014db62821mr3386114637.48.1795166817791; Fri, 20 Nov 2026
 01:26:57 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119201813.15320-1-seanjc@google.com>
In-Reply-To: <20261119201813.15320-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Nov 2026 10:26:46 +0100
X-Gm-Features: AclHuK8G7DuVvIhaxwHzPN8dYRpQJQwUQlq8SQJhdYRX7vQWCoLICNcclQQ7y0Y
Message-ID: <CABgObfY_iw6-Yp+hJB3pbV4spTMJfLc2M0jMs8_tu9xumM2wHQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Fixes for 7.4-rcN
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Please pull a somewhat random smattering of fixes.  The biggest (but prob=
ably
> not scariest?) is to rework single-vCPU kicks to ensure waiting requests
> actually wait.  It's big only because PPC is weird and required refactori=
ng
> a bunch of code just to avoid throwing in more hacks.  Including this man=
y
> patches obviously isn't ideal, but failing to wait breaks the flow to for=
ce
> vCPUs to invalidate their SNP VMSA.  Prior to 7.4 the race condition was =
all
> but impossible to hit, but in-place conversion makes it a *lot* easier to=
 hit
> the window, which is why I included the fix here.
>
> Speaking of PPC, the scariest fix for me is the patch to actually impleme=
nt
> kvm_arch_flush_shadow_all().  Some PPC folks reviewed it, so it's probabl=
y
> good?  But I'm still flabbergasted that such a blatant bug has gone unnot=
iced
> for so long, which makes we worried I'm missing something.

Pulled, thanks. I'll give it another round of reviews...

Paolo

> The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63=
fb:
>
>   Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.4-rc4
>
> for you to fetch changes up to bcc359264f15095d3d167535cf5de0b7e4800279:
>
>   KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2 (2026-11-1=
0 14:42:26 -0800)
>
> ----------------------------------------------------------------
> KVM fixes for 7.4-rcN
>
>  - Mitigate a class of (x86) bugs where KVM can read/write guest (userspa=
ce)
>    memory using the wrong mm, i.e. using the wrong user page tables.
>
>  - Don't force a full nested VMX VM-Exit when destroying a vCPU, as proce=
ssing
>    the MSR load/store lists and writing back the shadow vmcs12 is wildly =
wrong
>    when VM is dying.
>
>  - Implement "flush shadow all" on KVM PPC to ensure KVM's mappings are t=
orn
>    down when the VM and/or owning process is dying.
>
>  - Provide empty installation rules for architectures that aren't support=
ed by
>    KVM selftests to fix build issues in CI environments.
>
>  - Fix KVM selftests' rules for generating arm64's sysreg headers so that=
 the
>    headers are properly (re)generated on incremental builds.
>
>  - Clear only the VMCB save area on an intercepted SHUTDOWN on SVM, partl=
y to
>    avoid unnecessary churn, but mostly to prevent KVM from clobbering the=
 PML
>    index.
>
>  - Update the tracked pCPU on task migration for both vmcb01 and vmcb02 t=
o fix
>    an edge case where KVM can use a stale ASID across pCPUs.
>
>  - Rework the single-vCPU kick logic to fix a bug where KVM would fail to=
 wait
>    for a target vCPU to respond if another in-flight, non-waiting kick ch=
anged
>    the vCPU's mode to EXITING_GUEST_MODE.
>
>  - Clear nVMX's smm.guest_most when freeing nested state, and if a RSM to=
 L2
>    ultimately fails (and queues a TRIPLE_FAULT to L1).
> ----------------------------------------------------------------
> Amirmohammad Eftekhar (1):
>       KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2
>
> Fuad Tabba (1):
>       KVM: selftests: Fix arm64 sysreg header dependencies
>
> Josef Bacik (1):
>       KVM: nVMX: Clear nested.smm.guest_mode when freeing nested state
>
> Sasha Levin (1):
>       KVM: selftests: Provide empty installation rules on unsupported ARC=
Hs
>
> Sean Christopherson (10):
>       KVM: Reject user accesses to guest memory if current->mm !=3D kvm->=
mm
>       KVM: nVMX: Don't force a full nested VM-Exit when destroying a vCPU
>       KVM: PPC: Flush/zap all memslots on kvm_arch_flush_shadow_all()
>       KVM: s390: Drop unused and unreachable kvm_arch_vcpu_should_kick()
>       KVM: Add a @force param to __kvm_vcpu_kick() for PPC backwards comp=
atibility
>       KVM: PPC: Explicitly force IPIs when directly kicking vCPUs
>       KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use standard imple=
mentation
>       KVM: Move kvm_arch_vcpu_should_kick() to common code as kvm_vcpu_sh=
ould_kick()
>       KVM: Plumb the full request into __kvm_vcpu_kick()
>       KVM: Drop kvm_vcpu_should_kick() and use kvm_request_needs_ipi()
>
> Shivansh Dhiman (1):
>       KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown i=
ntercept
>
> Yosry Ahmed (1):
>       KVM: SVM: Update tracked pCPU on pCPU switch
>
>  arch/arm64/kvm/arm.c                     |  5 ---
>  arch/loongarch/kvm/vcpu.c                |  5 ---
>  arch/mips/kvm/mips.c                     |  5 ---
>  arch/powerpc/include/asm/kvm_host.h      |  1 -
>  arch/powerpc/include/asm/kvm_ppc.h       | 13 +++++++-
>  arch/powerpc/kvm/book3s.c                |  4 +--
>  arch/powerpc/kvm/book3s_pr.c             |  2 +-
>  arch/powerpc/kvm/booke.c                 |  6 ++--
>  arch/powerpc/kvm/e500_emulate.c          |  2 +-
>  arch/powerpc/kvm/powerpc.c               | 18 +++++++----
>  arch/riscv/kvm/vcpu.c                    |  5 ---
>  arch/s390/kvm/s390/s390.c                |  7 -----
>  arch/x86/kvm/svm/svm.c                   | 43 ++++++++++++++++++--------
>  arch/x86/kvm/vmx/nested.c                | 10 +++++-
>  arch/x86/kvm/vmx/sgx.c                   |  2 +-
>  arch/x86/kvm/vmx/vmx.c                   | 15 ++++++---
>  arch/x86/kvm/x86.c                       |  5 ---
>  include/linux/kvm_host.h                 | 32 ++++++++++++++++----
>  tools/testing/selftests/kvm/Makefile     |  4 +--
>  tools/testing/selftests/kvm/Makefile.kvm | 16 +++++++---
>  virt/kvm/kvm_main.c                      | 52 +++++++++++++++++---------=
------
>  21 files changed, 149 insertions(+), 103 deletions(-)
>

