Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06F36074D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370001; cv=pass; b=u7gYEBu4ZK6OFOw2eU8kxeZxc425uYN5R4W/aNj5gb88Itkf3IhmoN4x0NCoblxXkDxgA77xDjuN6l26HCr4QkeXxXMuaKFoePQtbd//jVdPyAGuK2mDGuXvYkDhKvZex+KZD1+vnGbZWG+He12F42S0nXSm70aX3tgigIH5ihc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370001; c=relaxed/simple;
	bh=f8Ji74zBMWp6udWNbOhWV7NgkcEJmCbPsz3CzFk1gmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4uOgME6i6pKs4zN5pos784VQTf1oJgFEHqBzDxaxZJKzMV3qyx0AxdnopRdREQfpznfSSeZU20MenL1i1AnuiCswvkzZFxLsI6jO4CRZKeMXF4BxPl1f2zcmoK3+vmn8v6EcJpH+Bqrhl5BpumZcnrex68YK+52tC4KZqToTGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMsvRThJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFFW4Zpc; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMsvRThJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFFW4Zpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774369999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
	b=eMsvRThJ1tLIDooms9s10UsXrGoHh4DdDjaxfAxiRN51ZWQMyAqX+Xa8ciT2kYeQg0cJcC
	M/k/w6QMuwg8FtBmGgw57HaV9yNdQP/Ioa3H1o8E5UpulessfYw3GnCpQWzluVEaHUks/K
	nEAfpKvFcceOlgsSRoBd+k7RGLbILP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-_ZJ5qGDUOOKeY9rk-gEVQw-1; Tue, 24 Mar 2026 12:33:18 -0400
X-MC-Unique: _ZJ5qGDUOOKeY9rk-gEVQw-1
X-Mimecast-MFC-AGG-ID: _ZJ5qGDUOOKeY9rk-gEVQw_1774369997
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b7c8da871so2504554f8f.1
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 09:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369996; cv=none;
        d=google.com; s=arc-20240605;
        b=VH9g8hJ2Jch+O0xNEzhOrBHXhdqnWcZdZqBhgCzhLs3qjYrYZKcdtRwjOEM5zluzqH
         +q0FnAXvQVMNyKzdi+j9mxWBMl8Nu3dsQFTZZ7dEpz6TNfxB8IJShPgV2nAXfh0rKvrI
         zz+/zamoQFlaMIwBA0CHZyH1AUg7PcNzuY4t+7WptefRQsdp2OFWsaDM8ZYATUdtRWwo
         hUW1Xo7XBeelzIBYQZ/xbx1PLTpKHtaWqntVmpvEG3M0cV+iWypduOrL3PzcGNtUaMV2
         IrXaSyBJVBU+wjINqxN54b4mtfud7DL+mvJMPBtMzpwGNG/iWra6NxwZvxoT5r9O3c4U
         vnUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        fh=2qCyATjZKE/18K/yCZFyUW5UbaK+GeG73NVk/D1ytxI=;
        b=C8/wJ65EEu1t2pw5dhIHOZlA902J5OQ6pcUDm7jsI9X1JZf0Trvip6PiOfDShg7GBC
         w2fOK7ar4l7xD0KjH7Zox9MfCJ3ttwYlgI5H5dDUKDr/dQJdKrSK2L6/yN+55Gnujl2I
         UBpfry9qKnGLI2el4r4W180R7jnqVwUW86v6IHIatnbbfZLzPzuj9F2fjWdQY9EJiJXq
         u65RzClAAsw8Hl3DU5OA6ZcwtxIhefncNz1agQd0UHQo8mFWTr/Zb//8I/8705hFTMTg
         FU0C02rkjM0ZHrl0gyCVyunKuijkrhUY2MTlLcZLUrl/erCfwJfVJCnFXFB9cjaTf6mK
         r0lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774369996; x=1774974796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        b=HFFW4ZpcobTN0MP4SZpxTWBymR25dDdDCetkdKTiNHe3W+k5WGtR+gjiq2aZeL5ag+
         5yGDZGw/UsG8LGsLBl7PjQyE+5xiswrMeYjKdql1r47NA8buDVkyNv9wX6gWkYAosrCH
         vav3uFpMXLikaDYpCE77OU3ng4C/q44cLXzaU8eYRswMgZ7nR6hjDABNJM/tOxNaG/b3
         SdDcmEw44G2b+HC7WIX70hKIpCHupFLyUJeT9u6oKcRQg9mb2WEKVnXy/+Tb6s6Uz+x5
         QSgBQlP6p4lf2UtgfhQGqRxqPYyZ5t33CrIaa918gM7U8WWCtRyIP+NvTe91gY8GNi5S
         nNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369996; x=1774974796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRo193vq0QrHIhNGO7p66fmYNcTo6yzoOCUabofE5s0=;
        b=hsGqD/KDDIFVTIpPHJtmEpTEicLTld1HDEIQ6fdtorPdfSEfQDCG0uw9pbp2L0hCUI
         V2QZ8v8F3kz3rMt+4GXLQv9fndSqVDyTj1fXfvlo2dnxDCJF2ScJcW93pjSjH9rkO5l7
         pFXN2rd/C5Sjoca8VefZdROHXutp7gOsEAYEw4UNDSslQoZUco83pw2dSgEolw+HA/Vq
         MGr6moUyq50bkKQW6Ak/zbWBoPwxDIrRmNa/BEqzVvX/Ngk6X2+APmZBMYBf0MVjNiXT
         oXHkmwIlOLDWoHy8aykNdVDl4DLfJOhvDsy/7J5CEw5wvuqJczTaEhp6SEXDA8LiCX9T
         +KYA==
X-Gm-Message-State: AOJu0Yx+D4yiOQZ1qG3uuXMjGF7jkkmUIVkC2FbMoeU1nqvd74BcQOlv
	lhIJPWT/1241/yWNCKT+AmQfnKCFby7CIhpgeC3nrEfHWQwDGfi5VSWPNi+LKEJxqxa+6KCa/Uq
	8pBE3XJHLrJZ/7oiSeA93IMYuhqSubQrPXImXWbbImU/VuKN3x9OKO0xu8rINhMtz2KuhQek/t7
	2Oq5UqaEGD9Gwyq7S873lSN1wQY2Oa5uekxgc7
X-Gm-Gg: ATEYQzwsaDj6jQY3qiK4q7K7MxC8rXXjYC3pEjb9Zw3484wpQ29trCkGyphFaT+mXDb
	jG8+i1vL2dsb12bGJ9xq1wbdk4I00ebAwGRmoHU5ulMRHztSMxMsgmeKk+YaDTvFDPTKbB7S2mp
	b+P5l6CYojXqBDLQqH+KNdDo+n5qAhI0BwjhN15ROERFTl0/xFaJudyTBhG4y1+AbD5V7PM7j7l
	1JQaw9fZ/z3+s6czOjC43yZdtspjvfvDI5147R3YZGwU/ayNo1KYQ2xL35pr1Xrlnvu4Gr4K7eX
	51uK
X-Received: by 2002:a05:6000:2dc8:b0:43b:858e:6671 with SMTP id ffacd0b85a97d-43b889a8610mr204809f8f.14.1774369995764;
        Tue, 24 Mar 2026 09:33:15 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc8:b0:43b:858e:6671 with SMTP id
 ffacd0b85a97d-43b889a8610mr204749f8f.14.1774369995191; Tue, 24 Mar 2026
 09:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318080606.2450514-1-borntraeger@de.ibm.com>
In-Reply-To: <20260318080606.2450514-1-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Mar 2026 17:33:03 +0100
X-Gm-Features: AQROBzA1L__5aTEPd45Ki0-lV24sXxU80G6inVcjaebTlAu2Vx9NevHsgIwhzUQ
Message-ID: <CABgObfaNi7Ocd2CE94TpcDL1pT7udpaWXym2x0eeK7HAcNN6nw@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes for 7.0
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:06=E2=80=AFAM Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>
> Paolo,
>
> here are some fixes for kvm/master. Also with a first fix for the memory
> rework, but we know there will be some more before the 7.0 release. Stay
> tuned.
>
> The following changes since commit 5ee8dbf54602dc340d6235b1d6aa17c0f283f4=
8c:
>
>   Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsver=
ity/linux (2026-03-05 11:52:03 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.0-1
>
> for you to fetch changes up to ab5119735e984f6b724ef1b699c01479949ed1de:
>
>   KVM: s390: vsie: Avoid injecting machine check on signal (2026-03-16 16=
:56:39 +0100)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: Fixes for 7.0
>
> - fix deadlock in new memory management
> - handle kernel faults on donated memory properly
> - fix bounds checking for irq routing + selftest
> - fix invalid machine checks + logging
>
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>       KVM: s390: log machine checks more aggressively
>       KVM: s390: vsie: Avoid injecting machine check on signal
>
> Claudio Imbrenda (1):
>       KVM: s390: Fix a deadlock
>
> Janosch Frank (3):
>       s390/mm: Add missing secure storage access fixups for donated memor=
y
>       KVM: s390: Limit adapter indicator access to mapped page
>       KVM: s390: selftests: Add IRQ routing address offset tests
>
>  arch/s390/include/asm/kvm_host.h               |  3 ++
>  arch/s390/include/asm/stacktrace.h             |  2 +-
>  arch/s390/kernel/asm-offsets.c                 |  2 +-
>  arch/s390/kernel/entry.S                       |  4 +-
>  arch/s390/kernel/nmi.c                         |  4 +-
>  arch/s390/kvm/gaccess.c                        |  6 ++-
>  arch/s390/kvm/interrupt.c                      | 18 +++++++
>  arch/s390/kvm/kvm-s390.c                       | 16 +++---
>  arch/s390/kvm/vsie.c                           |  8 +--
>  arch/s390/mm/fault.c                           | 11 +++-
>  tools/testing/selftests/kvm/Makefile.kvm       |  1 +
>  tools/testing/selftests/kvm/s390/irq_routing.c | 75 ++++++++++++++++++++=
++++++
>  12 files changed, 129 insertions(+), 21 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c
>

