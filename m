Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF540372695
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252016; cv=pass; b=HZXNmNsdK9WxDo33UoTdvV9RVR5AkUQhi35cB4BFkjiRCcjMbambJA3fZHL90/1ohoJ96qyMf7XKpydjRTvYZoqgsUBgaV9p8DCgwobRNhaESmOlWwmTXUm1m03zqBrksH+60XvnqBrjivpK5pBtxO/AcYBM8+vjqjoyj99AzmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252016; c=relaxed/simple;
	bh=No9jSu33WZhsKKud3i6/1bAb2gFJXH6tTm4IjLCwuq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv2zB9VPyl25RmadyCUu3JryhE00Jy2p25DhVsMsAx92CVEINwWW8lBeT8+W9scdwf2pd18y6Z7hEU1oBZ9IqItdVpfIrgwiLyniK9+u5eTD0t3Cp/XZCD0RIPguN3NcVyRK7yEeeA3pacHED0e4sU6MnSHwsRz3XRi3Wm7HvmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5FABH90; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6A2RtPZ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5FABH90";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6A2RtPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781252013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtzWmRXNog0T0UJm5TeBSzTr2yVzbdq/fIfE7eDHDuw=;
	b=G5FABH90EFqKbEOvt4Fw7jF6vuzjUuivUONmjwL7b/P3uVwoTZoxN40DiFvv5A543f0rxZ
	UTR+1VmfgRdrOhq9+qDfOMFlZF4/WOWeScpiz2R9rLPuhmgVEwAxm4PI6P66XzMVTjroM7
	XGCxRr5Yc8zG7fsm/GTHhTm00g5U5uM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-aaug31EPPFe7-2H1TWDkdw-1; Fri, 12 Jun 2026 04:13:32 -0400
X-MC-Unique: aaug31EPPFe7-2H1TWDkdw-1
X-Mimecast-MFC-AGG-ID: aaug31EPPFe7-2H1TWDkdw_1781252011
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef0af9517so634745f8f.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252011; cv=none;
        d=google.com; s=arc-20240605;
        b=YZc7bOKeTuhH9mm/YCr5/ImsXbXZU0UOw/wWj14wxOp5kPbHYeo/gdovyFXbUxGXAA
         ltcqkIhWKeCurHMQJ0x9cHviXwCJBYGrUhZn2horvz480saLj7GJrVTQuugghIgoI165
         k4TkGL0l5wXExr4gesoK1jXQTc2pohVHIQyHSsN1pvOEVXCFHyvjeXZIKGXTTD8D12kZ
         hNNK1q9K12K8wc9xi/T3L4dnWIM52Xz797DcjYG41T1OkvH3Wb1GRtviXO61mKGxmOZO
         allW3PinJhZ619qwmXEa7/reL17X2kRwabVaoD/2ppE5vBuCNhRuSa1I4l6iDxXa9h/l
         Harg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RtzWmRXNog0T0UJm5TeBSzTr2yVzbdq/fIfE7eDHDuw=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=M03PTCkcaCRvgk8lwvIa/86ZyBA7w1GupOxmYZRRADnL9bc/muxBeR3dSDaDsTawUX
         DLILtx8BOtu0o1lX/rimANbABOLKQ5pV0ykA6jUwjjF4kdE+qQJMnj0Bf+6XEeG9963d
         Vv+ky6kyYytXh1YLduPZVf51co3zEokJfkSckHV2LqBp+Q0kLP3wnBz0eLmi7yug5j+H
         Z8JE5l4SWAzu19XRFyHeLLk/wFzkh95qz45bUGIJmDuU/SQR+9tlTqhnq+Izf5FPDxjc
         a6X7MO8K3o1zY1a7r5ZBmrYrVVsOuoH9On0ELcYgI80WRdprHVo0cp9CUIc1EiDE1n6D
         yOpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781252011; x=1781856811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtzWmRXNog0T0UJm5TeBSzTr2yVzbdq/fIfE7eDHDuw=;
        b=W6A2RtPZ+YDNWzxa3GY8qI9eRT2HhhjlYSKCbS3bWJdVkVcpH4PnzX17jQsyqujAGV
         zwVDV7I23JCaD2J/cc/cqvYFuIxZ95UWTXzu/2EylvKbPMZYwcG942/rCt7ShbQ3Epzh
         3IlTNtjRWF4yLFwvkNrNHIb5Qu3RaleJ7V8DL9xbB1iHw5XSUKpgxlY6/cxM2OxtgVXF
         Dg+GSiPVcm+pcnfx25KbGgMOKR64Yu/v3IErbMwZm+eXQG8S/yKN2rHxn0buIqlMqEab
         EVSQMsRwvhmvw95o2paR8/GUQ223sEzgZpVbv5jAEUjzq1y6jKPlLIS2QjlVq5LP1ubY
         f67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252011; x=1781856811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtzWmRXNog0T0UJm5TeBSzTr2yVzbdq/fIfE7eDHDuw=;
        b=PgnhPGOzTFash5c4OFel9acG0We7fD493UthwYU2oJbnbxFjlhayWijGjgi8GPI0Kw
         ydaUhFbcoV6yk7jfknMFi+p5jxq/F2iMos7dXNfj0QFmkhtC7mJNftQktGVwxFrkU3Xm
         osrN/g3n42pRiD/C9CvmccopHg5LdMANpSgAyMDnnRl8wL8dzTQLudtBMABH16TyNq72
         3yWX1bS76+TVYk3KWn09OBWNGMSqf7HSWPHLVALnxlHk01XhfeDHgWiuigI+SK4jlZKV
         fNyR6/c3cMvzGZS+oFlclnVXmXyk7GZAZlhaZCk2HCSq15LOjGvoml7xQMWvKnR/pF1r
         hdYg==
X-Gm-Message-State: AOJu0YyMUs+KHuukpUg0HNEn//ltmEsayDxgNkGUj6EsPttBXFfwfFuA
	7I0JbpcA+aWN5BGfC3SphRcNGTaRfbQv/0Mi7jTIv/zGsV01e5Mn5ZS2lql4aVYy6UCUWsHv3VB
	T2UJEI4rzsOkk/XUpsL8fKSVep4SwO0AhnOLU3kkwCEUOe446w5r3lYpcaC6vV1PvVFZxKOyVOq
	cmue8JpZtO6iKuKJaOcn2R3twQ37tM
X-Gm-Gg: Acq92OF/U5Po9bd7qpk/UsBXBZIrqZa2Z+w5XMAADlA5qqOusfac2cYmVtOTq9W0w3i
	qnA6wCp+rewXr4KrL/wWOr9EZVOavDyWmAiVyhmmnSW6vXekFiPQ5z7G+8NHuDWDuOf8h7kMak4
	/x2wVVjTEc+gk+3pd+RiTqxIJbr2spJpcFBazi10+yS2sxS3KlX/DXceLfn4SU6zcRI4cXhlID2
	B4TG9sfQE7mM015/edNS1QIfE3Y2cSCeQqqgBqELLtvVNKpj2VoV5E9DY5iukJiCpsmP/zp2jD+
	I5irXg==
X-Received: by 2002:a05:600c:4e08:b0:490:abef:dae6 with SMTP id 5b1f17b1804b1-490ec4e753bmr19015535e9.19.1781252011075;
        Fri, 12 Jun 2026 01:13:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:490:abef:dae6 with SMTP id
 5b1f17b1804b1-490ec4e753bmr19014945e9.19.1781252010462; Fri, 12 Jun 2026
 01:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-7-seanjc@google.com>
In-Reply-To: <20260612004755.349925-7-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:13:18 +0200
X-Gm-Features: AVVi8CdYkl_qgy-KICZCFqDmu0Im6DTXh1m04t9GhexApbIqOTPojtbJzipWT78
Message-ID: <CABgObfYzyjvggyRB5h4RJKKHcnOGN_H6YW2LW8J7B6vjHo_v5g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: SEV changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Teach KVM not to advertise VM types that the system can't actually suppor=
t,
> rewrite the {de,en}crypt memory code, and fix two pre-existing bugs found=
 by
> Sashiko.
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-sev-7.2
>
> for you to fetch changes up to 97cd21d57e9bd2da79845178d9250cfd19289cd4:
>
>   KVM: SEV: Mark source page dirty when writing back CPUID data on failur=
e (2026-05-26 09:56:36 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM SEV changes for 7.2
>
>  - Don't advertise support for unusuable VM types, and account for VM typ=
es
>    that are disabled by firmware, e.g. to mitigate security vulnerabiliti=
es.
>
>  - Rewrite the SEV {en,de}crypt debug ioctls as they were riddle with bug=
s and
>    unnecessarily complicated, and add comprehensive tests.
>
>  - Clean up and deduplicate the SEV page pinning code.
>
>  - Fix minor goofs related to writing back CPUID information after firmwa=
re
>    rejects a CPUID page for an SNP vCPU.
>
> ----------------------------------------------------------------
> Ackerley Tng (2):
>       KVM: SEV: Unmap local kmaps in LIFO order, per highmem requirements
>       KVM: SEV: Mark source page dirty when writing back CPUID data on fa=
ilure
>
> Ashutosh Desai (1):
>       KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path
>
> Sean Christopherson (9):
>       KVM: SEV: Set supported SEV+ VM types during sev_hardware_setup()
>       KVM: SEV: Consolidate logic for printing state of SEV{,-ES,-SNP} en=
abling
>       KVM: SEV: Don't advertise support for unusable VM types
>       KVM: selftests: Add a test to verify SEV {en,de}crypt debug ioctls
>       KVM: SEV: Explicitly validate the dst buffer for debug operations
>       KVM: SEV: Add helper function to pin/unpin a single page
>       KVM: SEV: Rewrite logic to {de,en}crypt memory for debug
>       KVM: SEV: Allocate only as many bytes as needed for temp crypt buff=
ers
>       KVM: SEV: Pin source page for write when adding CPUID data for SNP =
guest
>
> Tycho Andersen (4):
>       crypto/ccp: hoist kernel part of SNP_PLATFORM_STATUS
>       crypto/ccp: export firmware supported vm types
>       KVM: SEV: Don't advertise VM types that are disabled by firmware
>       KVM: selftests: Teach sev_*_test about revoking VM types
>
>  arch/x86/kvm/svm/sev.c                             | 469 ++++++++++-----=
------
>  arch/x86/kvm/vmx/tdx.c                             |   2 +-
>  drivers/crypto/ccp/sev-dev.c                       | 101 ++++-
>  include/linux/kvm_host.h                           |   3 +-
>  include/linux/psp-sev.h                            |  37 ++
>  tools/testing/selftests/kvm/Makefile.kvm           |   1 +
>  tools/testing/selftests/kvm/include/x86/sev.h      |  24 ++
>  tools/testing/selftests/kvm/x86/sev_dbg_test.c     | 118 ++++++
>  tools/testing/selftests/kvm/x86/sev_init2_tests.c  |  14 +-
>  .../testing/selftests/kvm/x86/sev_migrate_tests.c  |   2 +-
>  tools/testing/selftests/kvm/x86/sev_smoke_test.c   |   4 +-
>  virt/kvm/guest_memfd.c                             |   6 +-
>  12 files changed, 521 insertions(+), 260 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c
>

