Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FD31F9A3
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251982; cv=pass; b=OtKAv4d81AxqH1BE9MaX48CvedBWJoeXTdxz+9NJ06zCRaJaRfmJ8YnipIErdY2yUNufOjPBpdLsKnDCsssadtABBpoIsmnWjXAlOrT2nUcyI2UVbcGfL/d3PCx5ibcgXonilRLkhl4ev+4tCJnxIGFOmoTIajXNbarY46KP99s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251982; c=relaxed/simple;
	bh=JHFB6lyjCxqwmPNiNR/NWzCvyF6+g7VUX6lNRnTIGdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVJlxlF2IxLqySGdOFocTZIzsFCqMqvIRZyE9ikfmk9Yt5x+qUdqCGqZqsaC6QYN4+6uwkkOLHq8Prp1iWxxwjYGDgmD/67Jxm5BAiTtTCO9E5M6Q7cvLRDpAxruroDJyU7v/6gzE7lcJVtEUt+h/j5CyVY+rFjPvCZ7+MgQXMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2lCXIZj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8K3guUs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2lCXIZj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8K3guUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781251979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOdGcZiQpOWZSbnxOHYzFroZupIkRVQ+knWNnmdHLKI=;
	b=A2lCXIZjimSqHhVfNpawgWYtbDl7VnkASAC5Lu59ASdiEiNNBdCU2UTn86LCApIaI5Z915
	iXbxp2rEq+vEssYOVButyO370fQB5WU5bdHSJ5mmzvMdN6ESEvmOFVc4BMaA8Q4cpFjzbv
	N09GOD853pDNPrronKqGpOfnVkdoYXg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-ypanxrsePPu1rpQChJhtGg-1; Fri, 12 Jun 2026 04:12:58 -0400
X-MC-Unique: ypanxrsePPu1rpQChJhtGg-1
X-Mimecast-MFC-AGG-ID: ypanxrsePPu1rpQChJhtGg_1781251977
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-460198535bcso432222f8f.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251977; cv=none;
        d=google.com; s=arc-20240605;
        b=QtO3xjjpfGOT7eao1GE2GElqbRl6f2ikSUvAV5Q0It78kqimTuaoACy0Vdh1otyfPW
         rbr+9SNSt1YwuX2wIUigdOduX8ksjhxvCML5TA9zustD4L8q+SybxbgHUitDzlYk5XYn
         pJ/0bB3g2YYbtjm3GPDYw8Nw7O2hGmdg5He1AhX34BxU/PBb3Y5TTR5OsUyQWBcIYaU+
         IyJpph+kiXafMYAORb2tmRsQMykrqimzv7FgXXSY41AS0dc809DLkTCK9bA6wTRHSYSG
         gJWTI6Ti7+5yJSedb/pdOwqNGgXIe45js1JzcFIwconlIdz5Y/JZ2ds3tzCDKOPgA7yP
         AL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fOdGcZiQpOWZSbnxOHYzFroZupIkRVQ+knWNnmdHLKI=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=Ifn0OlmjMZNLgaTos72vH4rogr+SdzMPsWBSJkVcrRXjRzSgrWfnN0Sep4niQbKraz
         BBOrCoptC/hbxKbOYR8H7AiAWAnNUj59WCcOIVCbBLVG79a89P+tt+g3XjUhAjUj53ee
         wc+0shvYkD80Enwuz8jDBNhYoXQgxZtpeyMXrZsZPYPlTzBsR87rU5258ixlj/xXGfyG
         5cbqDZK4rZHbQSqRHoUoPMvK/AJZqI/X1edYh99BsZHloO5IXIyjI3M5UJNmUfYmfD9l
         +Srb0mkZ/i/YQKle2hhe8F7qFsOONRx5eUW+ajK88V2sjajQLhm2+907Tv9ixqjOK1yg
         O9qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781251977; x=1781856777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOdGcZiQpOWZSbnxOHYzFroZupIkRVQ+knWNnmdHLKI=;
        b=N8K3guUsCKrpOBghkcby6v2i6z+WjhRwkylMoaTBdMsS7qIgnQ4z+HDrUdOlEQg5ep
         QAs3sgV9PBcZDEyMZAR1HlsdVcJl2/LYPEBWHJUI4Qh0t/au1De6a7dimX0EJO8+1CvU
         LqU7hBLQLCPDBIHMwJcCPj0bwpkJcbnoGGXqJySspkot3g8mMDG+PJXq2F+Ck38L27Ob
         KXRqHUD/NkmBPKfnN5M5WWHL3Nlh4vSoxY7GVCZsLk0eBL+44+ytgdw2zXJJK0Xt18fQ
         zzfj3Xa1pwijMk5HC2dFnx5mjZr0kZYVARjaG4Rms5MDQPvJhAeQ90k8RG8sBqibA6ra
         HWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251977; x=1781856777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOdGcZiQpOWZSbnxOHYzFroZupIkRVQ+knWNnmdHLKI=;
        b=RMniqf2J9pOEdoiMhUQM8hN2DRiEOoXzsneCh+gGmOWQLjBF8SqBd+9ocABUJkQeUZ
         5cMw/8fkfhIgGvb23UbsSbkK7QuOM19MRMRCvMgXIfeDEPTbFc/3Rxv/zvlyt2+SYHh7
         D885k42hBcUU2KW4UJSDmyUtqra5gG9lhnEmFS1nS2fAcrSCc4LbatH/YgNn1ctGZXJZ
         G3tZYwy+WDQMou45/MH86G3QC8Xz6JtVYZAuk2eDUWZzGwvcwEOhVWTq9QjtZKspenQZ
         mEEGJIqFiuyoc1Pe4BqtyBYoXRvvDvIOya6qG468WZnHG6t15EZYstCEm/v1dDjfPKZM
         3+AQ==
X-Gm-Message-State: AOJu0Yzfj3gtk7uodowCgYnyrfy1FjCFH4bYrc87tREue850kr+xbcQP
	k8eRYcQ3iEtbhInJ+JrsPJDMpqcS0WGTbrpYkG7AzTFTLaV4E08TAIhAIaK5MQNlzaHunfOXSn3
	0EbxPWhB6CDKiL+j7Uld/qNxQQE3xPabSFA9oJpzln4phq+BzRL5/KIWRpY1ZOXtmPChneIqZak
	pgBggIWVjoj39b3qdniBeJiHhbwRtg9DzPKhg6
X-Gm-Gg: Acq92OH/lAe+AqqF1Y9LbudvHETw8VPjMadf1DKvkv49ES33w7eKJPHbasRDsWHO0IC
	CHI3d8iiyJarN4ejcM5Vle1UaW1G2PQVhQG3SDBiVL7fNw08ale6GK8OIQOj9ArNwFrjM/oenY0
	PFMKQuarJxS/HFPi6dZmmGZ2sO46+TFuGWMjugTcnB4NhCzYnBq1+QOKpPf5JdUcm5O9o7HSWBu
	DHZAyyx1op90SaKHbOOerPJQT/+Xg4JZ3Q3qQ9GqUiY6ilrdk8XqfmaUKCBhRVUJQs3fEaS0bHy
	Po7X6g==
X-Received: by 2002:a05:6000:4b0a:b0:44e:1984:5f3e with SMTP id ffacd0b85a97d-4606dbefd26mr2203667f8f.31.1781251976969;
        Fri, 12 Jun 2026 01:12:56 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0a:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-4606dbefd26mr2203647f8f.31.1781251976611; Fri, 12 Jun 2026
 01:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-6-seanjc@google.com>
In-Reply-To: <20260612004755.349925-6-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:12:44 +0200
X-Gm-Features: AVVi8CfsraqdpoO99IAZt7Ed5ZKUsu2-sKQ543yYx9LSu6xzPnbLmBxyXKRHf8M
Message-ID: <CABgObfYKWSLar1b3oGwGGffFGA+SJ8COsByzGfgTN1r=eEtX8g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Selftests changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pulled, thanks.

Paolo

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Pretty much everything here is a one-off fix/cleanup of some kind.
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-7.2
>
> for you to fetch changes up to 5bd0387e3b56f7e0a81386f6d0a5fa2c3a92ad5d:
>
>   KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESET (2=
026-05-26 12:30:50 -0700)
>
> ----------------------------------------------------------------
> KVM selftests changes for 7.2
>
>  - Randomize the dirty log test's delay when reaping the bitmap on the fi=
rst
>    pass, as always waiting only 1ms hid a KVM RISC-V bug as the test reap=
ed the
>    bitmap before KVM could build up enough state to hit the bug.
>
>  - A pile of one-off fixes and cleanups.
>
> ----------------------------------------------------------------
> Mayuresh Chitale (1):
>       KVM: selftests: memslot_perf_test: make host wait timeout configura=
ble
>
> Piotr Zarycki (4):
>       KVM: selftests: sync_regs_test: drop stale TODO comment
>       KVM: selftests: Fix typo in comment in hyperv_features.c
>       KVM: selftests: hyperv_tlb_flush: replace NOP loop with udelay()
>       KVM: selftests: hyperv_features: test write of 1 to HV_X64_MSR_RESE=
T
>
> Sean Christopherson (3):
>       KVM: selftests: Cast guest_memfd fd to a signed int when checking f=
or >=3D 0
>       KVM: selftests: Add and use kvm_free_fd() to harden against fd goof=
s
>       KVM: selftests: Randomize dirty_log_test's delay before reaping the=
 bitmap
>
> Zongyao Chen (1):
>       KVM: selftests: Fix vcpu_get_stats_fd() ioctl name
>
>  tools/testing/selftests/kvm/dirty_log_test.c       | 26 ++++++++++++++++=
+-----
>  tools/testing/selftests/kvm/include/kvm_syscalls.h |  6 +++++
>  tools/testing/selftests/kvm/include/kvm_util.h     |  2 +-
>  tools/testing/selftests/kvm/lib/kvm_util.c         | 25 ++++++++++------=
-----
>  tools/testing/selftests/kvm/memslot_perf_test.c    | 12 +++++++---
>  tools/testing/selftests/kvm/x86/hyperv_features.c  | 21 ++++++++++------=
-
>  tools/testing/selftests/kvm/x86/hyperv_tlb_flush.c | 15 ++-----------
>  tools/testing/selftests/kvm/x86/sync_regs_test.c   |  1 -
>  8 files changed, 63 insertions(+), 45 deletions(-)
>

