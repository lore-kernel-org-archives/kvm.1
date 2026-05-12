Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF37730C62E
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620528; cv=pass; b=mtpcmnQq0kBH6e37UjPOcU9fj8UWt05iaA/foMBS63epq1hAuGigqTvTUpg3zPAxrvgcBNUhm7o4aZEeG9L0vh6KpkVc8M7HgOi3ueS075iAiiqjNk3TTUSLeuFH/QXsgw1IHNHUYMeEh9T+eysZorqN2XukMUSzZeSNLBzSbOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620528; c=relaxed/simple;
	bh=+JKCMld8UNzRIbAQbh8pc2a5fr0ofGgHNla20BPsQjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERGChzGjZdubLjMROlCJPZdpfvzuDw3kNhLBROath9F+a5S+DWxuGi4+2j/VuDclLsy4c62EP5KdmrxOTAb5BjoNbyDIoVI8Y68Zuxl3rwwA4KGHogwHXJNxFzOBa0t2xVR33Lr3+9UwUQMEdEZB2I9qdPKdbI1tr0Keto6zIe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8wwO90K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ToRK85/J; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8wwO90K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToRK85/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCaf028xC5s+DMoM0w5jJSQ23tua+iloa6oIupqhPqU=;
	b=c8wwO90Klp+kfNojUel0TeCa5A4QeA3RfGTOITEfnEjeS8cmmb+HzYNugTl2GPC3Nqx9ib
	U63RyV5qaZkfNBHCpCQ1A9ubFGkTT9duOw4KD7PAEtF1dvSJZqgFCzECfRdqB+2tsuAKJx
	JpN2dPkkSA43PsLd6zoI4KmnzbVPpdI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hEgEfiPXMKGvOLcnsfkq-w-1; Tue, 12 May 2026 17:15:19 -0400
X-MC-Unique: hEgEfiPXMKGvOLcnsfkq-w-1
X-Mimecast-MFC-AGG-ID: hEgEfiPXMKGvOLcnsfkq-w_1778620517
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e60b55de2so53031575e9.3
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 14:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778620517; cv=none;
        d=google.com; s=arc-20240605;
        b=aNyG007C3M2W8nm+OKE5sjn6AkZ40rt5SIa09rIpUCwJTncgHi+S2PC81M50CJh8NG
         F0j8VbCZiJ4T5OyZn5atzTArJj8Z3XJtuLCvpb7t1t01U+xqtoJPo4l6Hd/WDcVUpMES
         DoYnqZ3SR+B3pm8x9n5tF33OvGf5KhRl3CYmv98iix4FrfdaG+maWp6SXOxDmJ7/eIl/
         0dEZ60sZAQeCbaLCYyN29O7DwHeGd8jrmqya5lbHeqzK5o/e5BROM9aC0o9HTrZiGliz
         XnZeLf50kImNbU1g3E+MnsgacY4cXy61kX5cjlwYGQcnaAbBLY2Vw1WcdT/cjwD0u3ZU
         4VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BCaf028xC5s+DMoM0w5jJSQ23tua+iloa6oIupqhPqU=;
        fh=Ru6qho+9O2eTpcKikZkQYb1LNzy6hG0NPOMifQ4yMKA=;
        b=berYfoNCpUQIQT5cJ8aotwqUi5brLUwZyYdossQ8GOilTRf06W/AHmlJ+rAxVuVWKK
         0Ig3kCl65mNBtNr6DH0pKLMdx0f+7vnG09dgoT3fQp3fVB+dF6ShzPILucbim1RLa7bR
         NYilrxU2LAPHcCKFw6Q3Ysta2Mx5QjLwxkXMgY+tJs1PReF2yMluh/xpEByIWaNimWt8
         e27WXmQtfcYCWnfibrKNxC1CBKIjPVMRxHuEBQp9emtBCdPecvrS/w8UQhwuZv2CzqHK
         OxXRzaXXVbukubVas7BJAvtdTVQ98rT5bP1rjSQn4b1HePwycFj830Jebv8sXUXHH53/
         pjuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778620517; x=1779225317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCaf028xC5s+DMoM0w5jJSQ23tua+iloa6oIupqhPqU=;
        b=ToRK85/JK/fYOmFKMM3j226a+s4FKJzcpgbcvOj+jCVI1j/wM90M719yy3KKRI9QQq
         kVfKmkfCjRuHzrUd/fdK/l9sySc+4wDpntJyIJHosVpKnODqNUIwXJhy7LcXhy8ngU9C
         J8j74Y/l96MZahnZgld9Cw88cN05Dct9J/cS3K0eJNn7ntXqx7UX2oKEIk/1ev3sLokj
         jHHjENxxMGcVmzFn9Lbh87X+Yt7ZTqDIlBaTs0Atu6pK5mpvhUYF+qv8JrNOGCja8hs3
         76p5dM8r/VTlKfeD14TUAHyxx6ksQ+Rj8ejC7ujalNGdljX+0GraVuGoG50vzwXq+vu+
         S85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620517; x=1779225317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCaf028xC5s+DMoM0w5jJSQ23tua+iloa6oIupqhPqU=;
        b=m1R6GKjk8HvGkClBu9slqj5XK54yEPalHk7mlltoc0wdeVvN13bKfO2ojl/Gz98IUh
         hbL0Hh3lQvBIjSiALyJvaaMQ0zLXZKcVkgIe1jGMlLUvnKkeyVht6mHXlXsG4uVdhwwV
         nYl8QWWrwsUIMdS+401CjfVqT+W94sBC/aCcpZB9ukp8s9Z47k8Q0qh8wkogt6lDqq5D
         am0iCpGNM5TWzVA9SV/fpNAhaPAxQfFyWtzb9yvvczWgsgslXZ+esZ5AaNhpyrSuahXm
         ztL22Pn3FKacva4mYJBwk3/HJrgcD3EQncEy17TXK1ZlqKUT3kG8WLswpfCnvim4Tk2c
         NsxA==
X-Forwarded-Encrypted: i=1; AFNElJ+0KIJYarcTMtdv/M/GUcciVeKTc9bzU1emmjyDAJtdzkAEoRWCdIABEmPELtSj/K7QJeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPUlig6AWlAbjAMgGno/wjyFe1dQSaWZlygb3g5kTcSqj2jtn
	Kh2sJYSkusG6r5GmU+vSxPcByooHWE5a4nWiVawSezn/2KokKJD18EvTFKZ2f1TJVcUJ9httZns
	ZLzQ2uh3D02ccnssJZOjmNhEQnTQ71t8UMEMHEbGtTtTAzzAkB6BcYB/6neR7uet9ZPlIr4hjAu
	S2h0J7xerkgejVeVv3DDBtoIOjP83n
X-Gm-Gg: Acq92OHHsyfoDoC1/zCLzAWvN87tcDFeBnlABxalXHUG6tmJ/lsBKCx8ZqALCwWvGps
	Hdl4gItiRXS4VLpcmrolTyGpKNNWE3pIS9B5kap5tS+LbUC3gANKx8j3jNAedSSVessoApWKEP4
	ywnk4YXaUlHvhB2+hRXePUEErtdCTkZKaQodlM3t69snApF5Lpu7OU38w18gNWKE7aejdth14k5
	YYPoFqExZkpusR1aSGEoAxpcmgxEXhQ/UruKVFnzsx9DFyF8T1THhb75zBZy6FG1ArpJ5741rHn
	chwaw85E
X-Received: by 2002:a05:600c:19c9:b0:489:1a63:509c with SMTP id 5b1f17b1804b1-48fc999e736mr7208105e9.0.1778620517219;
        Tue, 12 May 2026 14:15:17 -0700 (PDT)
X-Received: by 2002:a05:600c:19c9:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-48fc999e736mr7207685e9.0.1778620516761; Tue, 12 May 2026
 14:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507154221.2905554-1-maz@kernel.org>
In-Reply-To: <20260507154221.2905554-1-maz@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 May 2026 23:15:04 +0200
X-Gm-Features: AVHnY4KtwnsJxjKodfXT2l49vyk4PWU8NRQcHeq925qaoxrCk6J9wCnG0t9SADY
Message-ID: <CABgObfY+qCh3_j+ykf_5aU_FwWAKjnauby_AjXndkTAROKpFeQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 7.1, take #2
To: Marc Zyngier <maz@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Fuad Tabba <tabba@google.com>, James Morse <james.morse@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mostafa Saleh <smostafa@google.com>, Oliver Upton <oupton@kernel.org>, 
	Sebastian Ott <sebott@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>, 
	Yuan Yao <yaoyuan@linux.alibaba.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 5:42=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> Paolo,
>
> Here's the second set of KVM/arm64 fixes for 7.1. Nothing too horrible
> this time, aside from an ARM erratum workaround that has little impact
> on KVM, but relies on some firmware dealing with the problem. Bleh.
>
> The rest is a small collection of bug fixes, mostly affecting the MMU
> (permission fault handling with guest_memfd, 52bit VA with NV), and a
> small set of AI-enhanced fixes from Fuad. I guess I'll have to get
> used to that.
>
> And last but not least, Steffen joins the merry band of KVM/arm64
> reviewers in preparation of s390 and arm64 being joined at the hip...
>
> Please pull,

Done, thanks.

Paolo

>
>         M.
>
> The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f=
32:
>
>   Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvmarm-=
fixes-7.1-2
>
> for you to fetch changes up to effc0a39b8e0f30670fe24f51e44329d4324e566:
>
>   KVM: arm64: Pre-check vcpu memcache for host->guest donate (2026-05-07 =
14:12:42 +0100)
>
> ----------------------------------------------------------------
> KVM/arm64 fixes for 7.1, take #2
>
> - Add the pKVM side of the workaround for ARM's erratum 4193714, provided
>   that the EL3 firmware does its part of the job. KVM will refuse to
>   initialise otherwise.
>
> - Correctly handle 52bit VAs for guest EL2 stage-1 translations when
>   running under NV with E2H=3D=3D0.
>
> - Correctly deal with permission faults in guest_memfd memslots.
>
> - Fix the steal-time selftest after the infrastructure was reworked.
>
> - Make sure the host cannot pass a non-sensical clock update to the
>   EL2 tracing infrastructure.
>
> - Appoint Steffen Eiden as a reviewer in anticipation of the KVM/s390
>   ability to run arm64 guests, which will inevitably lead to arm64
>   code being directly used on s390.
>
> - Make sure that EL2 is configured with both exception entry and exit
>   being Context Synchronization Events.
>
> - Handle the current vcpu being NULL on EL2 panic.
>
> - Fix the selftest_vcpu memcache being empty at the point of donation or
>   sharing.
>
> - Check that the memcache has enough capacity before engaging on the
>   share/donate path.
>
> - Fix __deactivate_fgt() to use its parameter rather than a variable
>   in the macro context.
>
> ----------------------------------------------------------------
> Alexandru Elisei (1):
>       KVM: arm64: Handle permission faults with guest_memfd
>
> Fuad Tabba (6):
>       KVM: arm64: Make EL2 exception entry and exit context-synchronizati=
on events
>       KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
>       KVM: arm64: Fix __deactivate_fgt macro parameter typo
>       KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
>       KVM: arm64: Pre-check vcpu memcache for host->guest share
>       KVM: arm64: Pre-check vcpu memcache for host->guest donate
>
> James Morse (1):
>       KVM: arm64: Work around C1-Pro erratum 4193714 for protected guests
>
> Mostafa Saleh (1):
>       KVM: arm64: Remove potential UB on nvhe tracing clock update
>
> Sebastian Ott (1):
>       KVM: selftests: arm64: Fix steal_time test after UAPI refactoring
>
> Steffen Eiden (1):
>       MAINTAINERS: Add Steffen as reviewer for KVM/arm64
>
> Wei-Lin Chang (1):
>       KVM: arm64: nv: Consider the DS bit when translating TCR_EL2
>
>  MAINTAINERS                              |  1 +
>  arch/arm64/include/asm/kvm_nested.h      |  1 +
>  arch/arm64/include/asm/sysreg.h          |  2 +-
>  arch/arm64/kvm/arm.c                     | 21 ++++++++++++++
>  arch/arm64/kvm/hyp/include/hyp/switch.h  |  2 +-
>  arch/arm64/kvm/hyp/nvhe/clock.c          |  3 ++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 47 ++++++++++++++++++++++++++=
+++++-
>  arch/arm64/kvm/hyp/nvhe/pkvm.c           | 16 ++++++++++-
>  arch/arm64/kvm/hyp/vhe/switch.c          |  3 +-
>  arch/arm64/kvm/mmu.c                     | 29 ++++++++++++++------
>  include/linux/arm-smccc.h                |  6 ++++
>  tools/testing/selftests/kvm/steal_time.c |  2 ++
>  12 files changed, 120 insertions(+), 13 deletions(-)
>

