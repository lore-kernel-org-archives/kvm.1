Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795107694;
	b=z8iGV7CWaykOiAJj5DOhGRcOQ+SF3ukXUjjbo6o5jUI/7Ez7mHHSTwO325EQy4ALXLjn
	 294n75PrYZrTEBsLWYxVmzCbOn0F/cShjYWEiujaMYjdDXCpcgm/CjNyPdwKEhPrA575f
	 qltBbtMDxRFY12tHufuh5S63pYIkF/XNXWK/c1y9YP7yWCN9A0qiZIMSKXOYMUJwCq28e
	 +kF6wLxqipHUETMkq7S+qiG2Tj9ibWFAgZ26tpEdyhN+I3fekMqZTR26vZYzhIX10Zvmg
	 Bg2eGohVUlL5vy9xkfqtK1rQ6PDtvO0+QxkhmiTiUjswGkLfEh6zr5HpFvaXQmJjs9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107694;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
	b=fsSJ3ynb+tbnJuZCx9efKkFg7lVlS45EuHSXnU+0FMuKkrkwYvvhnKQCGftiDT9csIjJ
	 coRdJe77nNYp09Oh+RzcQlDFKMIvYxKjvA1lT94gF7GsVm0dXqGfkzpT0xWMjILFqjJWF
	 +hXlkjsVqRCYHyaae5Xj8W1/FcUsMatNR1gkG7P8osmcnt2xhVP0W0LfmnbLtswc5p7CQ
	 3uN0Viw1CmNOEomn8B5DIq5NqDHnNySArdciyZqdJZyLgG9GGGlfvEDlv3j0d+Y9sotI6
	 yJbpgyDyXiJKOHMsV/O7ju8dyiHGkGVWM1GN7nfaFJlL8XbW8v2il4PzAS46A2HUggg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EnwLxlcy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LnuptCKh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7E606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F7E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EnwLxlcy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LnuptCKh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795107692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
	b=EnwLxlcyMafNx2JDTDVFOUg6DA/urKG3Ke1Uj09NZ/FvtUxnRm7I1388zNAEtpEgH0OlOi
	1fgSpha9pxStGIg+AQGC6V9ogwA2/Dwjv89ERV7OYA5220KRzuKRRIoLzlTn9eXMaboOMm
	6Tdn+uU6MZ3HM5dLFpSNXoq/+HH7ylg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-lBGQTh4nPUyHoMsqNklF9Q-1; Thu, 19 Nov 2026 12:01:30 -0500
X-MC-Unique: lBGQTh4nPUyHoMsqNklF9Q-1
X-Mimecast-MFC-AGG-ID: lBGQTh4nPUyHoMsqNklF9Q_1795107689
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b167bc8e16so24513a91.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 09:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795107689; cv=none;
        d=google.com; s=arc-20260327;
        b=THEV462tooOa2zpzBmWjJ5A0KAsE4d075N4gdnv1QbRbmpQguRHL1aYgNgb0vz4jrw
         GOkWH241kSAFJwMHg6VWmk/k9GwQ0Qf7mkMhIbCfhJKlrm1qbk3Tp85xajVSFE6HjiFv
         W/PF8dl+PvmR9ftorDuiv1bdYWz7ZOxN9gNFZN/ytnYuywQASJTTB4gs8l3uWoLeJYo3
         3b01XBAUVEPAcvee1bBqnCvhmvBBbk5L/KBrz6MKis7IjQwEnm/i2brzxNPzNuhkiG0i
         gunAi8bI4h+rLEw6cYYCN/e+WV9lPn7llYCH3ST1eqLfEO2SGcuFupN4c9ab+DGjzqN5
         wmew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        fh=lUx5loLpNmK+yksydx6y27DalwmQNU1hOw5Mk7oFqm4=;
        b=IKV5nH396IC/sXOUy1dGRR1jbd0qq/qBfoYT5xzU2ooqRZRxIXKQ9dRKLfhGGVfZQF
         zAL1Vy5gpQ+9U974KOi+0QP1d4VSSTBJHluYnaIk5sRJayGEOCO7BWPV+4ZW/bmDdUXE
         Lu+lT4EpgaBjnvJ6Ea4X/ZpZ7cEKdxHH/410QTRkagsMbSh+KpgdMD0XOwphkRpmkNIt
         VD5SWcAmhEu+xV4vsxl+E1rc6c0d0KqDDzleQWYNZ5E9kOtZwjzdE92KDkW7K2drfpAu
         jg1jwyKBW+57mxqzRwafnjRgkx4iIlSMGcgPNkPfIrL4NETVjLqmQ7vokfdPN1kLP1pA
         jRhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795107689; x=1795712489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        b=LnuptCKhiewPtlzNYcj22AgqS0jkiivyHH/2i/kHd/TYuVuivbPameYJuMsDooGOKK
         A/FbMsp01am+vPY52tweefpmoMMGNmVbc1S3AU8EQKglIk3/FGQXnRUWsX2Gcw5+NBxd
         REZMqPNyrMY8Jpg0LZT/b6vw5Ql86rk1qPpuTaqpHx/wRGqbTsmVQb4vEgQ2Ghag4jlS
         wElT49hTTPPFxsWgAgUi82iTuwoUwlYiz+dewdFtmLOtj13gquwGBEF3Kjovs4beXGfE
         PeW7OEVvl3uCUP+Z2eBqaAKYzPFXEL1sDRjx2oVV/IEhdpbb0EvrtUn4JoTkolekZArG
         CgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107689; x=1795712489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwABRT/K3bySUSn1MLjdfbH6s8COt5WtqnptFackNs=;
        b=RBfuPARdQhWzIVSt7bCd+S2xKCkLVsbvm5mqxMdPmlH+XEUCzDRDxLRyYgsNAn+RT8
         IFUYqkZwBGXEQSRP0c0rJVd5DIDf1xzNWi4J2HugIAVTOdOTsGdWKOu6jv3WvC76U8wg
         ksKzmmAXnZtTcLm8nNHlXiHIxVtiZqPg2wJmRIEqQaRoGVTSJLqLyM1sp7tmWWk9UHiJ
         LuizL2z9xjR5eHvi2IjgP5y9vAHAIMvEyIKCX5jg+LiBqshSEoa3lietq5Y72+UKnGZw
         ELmALuoIKkYCn/jUcLOqPdzArzeMXUxQuBhNcUeNXGV6YGMG/oOUCs7u5RXYk1M/yIfD
         vUKA==
X-Gm-Message-State: APuU4Z8/Te41kG1JD/ER3DQsrcUp92/koo5Tnsr3r+WCQ4/nwoQrCm/0
	WR0E4V+5jC7W1hUf4SVnWtoGUpK1jMKX0ojfltUR5eYuos9LYrtIsf1UgHJIEp/InBuMl2Bs4a4
	hUKI+h9kTOv+YeqXcVURnBpYndSOSmSyq7Tpi5sFQwvNYmLx2GJf3FSLSXMVgAaPEF6ssnU8my7
	MD1hOzEeVybH3aTTc3jelfwFiDixzQ
X-Gm-Gg: AZFdTZdREFqW6d/P4rMJnaYVk96TIrPl95RFsxB5+GbFtOMmr1wYDp0aLzQt0P8tXL2
	xCW+Wn7uxzLM23BgELiLIvQbka9rH84gAGoehCQIdXtI1wB6+/7zNlFuZkmfiJ4C00ByNqU7mU3
	Sz9k6joDLxWt2ZSdIsxXj4Wb82cDJLv9gqFq//h/HyL7BJwfNlArkXT7R2fAKmLGqVnPcN9EBoA
	Q9nPWMsIL4fGQPVeVjE7fMbQaZqAmKM/gkxtDoep0X/pppB9+38OmxXc5cF
X-Received: by 2002:a17:90b:3b48:b0:3b3:b71e:b2f3 with SMTP id 98e67ed59e1d1-3b3d07d45e5mr6391823a91.45.1795107689349;
        Thu, 19 Nov 2026 09:01:29 -0800 (PST)
X-Received: by 2002:a17:90b:3b48:b0:3b3:b71e:b2f3 with SMTP id
 98e67ed59e1d1-3b3d07d45e5mr6391785a91.45.1795107688774; Thu, 19 Nov 2026
 09:01:28 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 19 Nov 2026 18:01:17 +0100
X-Gm-Features: AclHuK9gbMLbzJlV5OY-0UEhrBFcgOdr2MuiGO3o20p9P6uVz6SxjkcfZmnaOTc
Message-ID: <CABgObfZYZxd2RMaWxyMwEoi860hAmtkjGCLh+YB9G7tpUVwStg@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM: s390: Fixes for 7.4
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christoph Schlameuss <schlameuss@linux.ibm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>, 
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:50=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> first bunch of fixes. Some more are pending for the next round
> but I have not fully processed those. Those will come next week
> depending on how KVM forum works.

Pulled now, thanks.

Paolo

>
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7=
e4:
>
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.4-1
>
> for you to fetch changes up to 62aef2c04e0e69a9b88affa74ff699ce5c4e8652:
>
>   selftests: drivers/s390x: Select uvdevice tests using the target archit=
ecture (2026-11-05 16:40:22 +0100)
>
> ----------------------------------------------------------------
> KVM: s390: Fixes
>
> - Fixes for the arm layer
>         - sashiko: https://sashiko.dev/#/patchset/20261103-s390_arm64_kvm=
_fixups-v1-0-21c36fedd878%40linux.ibm.com
> - Fix ESSA instruction handling in migration mode
>         - sashiko: https://sashiko.dev/#/patchset/20261015104822.77062-1-=
ggala%40linux.ibm.com
> - Fix crypto instruction no-hook handling
>         - https://sashiko.dev/#/patchset/20261020082534.481867-1-ggala%40=
linux.ibm.com
> - Fix selftest for uvdevice
>
> ----------------------------------------------------------------
> Andreas Grapentin (2):
>       KVM: s390: arm64: Declare enum vcpu_sysreg
>       KVM: s390: arm64: Fix kvm_arm64 module naming consistency
>
> Gautam Gala (2):
>       KVM: s390: fix ESSA addressing exception injection in migration mod=
e
>       KVM: s390: pqap: fix AP status written to wrong half of GR1
>
> Sasha Levin (1):
>       selftests: drivers/s390x: Select uvdevice tests using the target ar=
chitecture
>
> Steffen Eiden (1):
>       KVM: s390: arm64: Turn vcpu->arch.pause into a counter
>
>  arch/s390/include/asm/kvm_host_arm64.h                |  8 ++++----
>  arch/s390/kvm/arm64/Makefile                          | 12 ++++++------
>  arch/s390/kvm/gmap/dat.c                              |  5 ++++-
>  arch/s390/kvm/s390/priv.c                             |  8 +++++---
>  .../testing/selftests/drivers/s390x/uvdevice/Makefile | 19 ++++++-------=
------
>  5 files changed, 25 insertions(+), 27 deletions(-)
>

