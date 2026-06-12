Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A56374198
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251836; cv=pass; b=O3QE9Z8zYdHObmnafM6nNs5xjpEbZhl+AVToaGEJDm//zV3jEF4TGElfJpSjZXi88dwAdMW9hyeWZlbaT2IKQUTjNJ8DgkSbzHzj6ruLPNxP0UTn+BR6A34r1xsyD9eIwCLoo49o1kL994kz0Ze1qfzo9a76NRLjlXVA5TfD2cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251836; c=relaxed/simple;
	bh=O1XwYGJ2CF0t3VR0kPsa/Rf6j1Of9jgR/HaEBhFtKY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3sYMXEy8MiIRdb9BUxBb7wX3sPuptPD4oIFa5CG/10C9zAiC61b/KD9agnrL+hoZlrdrWQbUmg/7VU0FJVJ83k6kWzGY3yqvJxZp3ozvPGW/CQYymrVf0AEIa4IY4k0Yn9PDbvSXviZ7EX2Dt6gTYf9/MKbYUM2P2d5mIywQPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVQvTaXO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aO0pvWvf; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVQvTaXO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO0pvWvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781251834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBb5ENKnZ/wOcpFRONY4larfIT5T3nGcrjJkOJdabqA=;
	b=WVQvTaXOlSUo0lWM4eOQBhdRTxQE7y7ng7RHeL9GTCuhZtIXjPW3U7QzpIo4UTV5VyPiHB
	xhwy2zDYCjklYKJ1XnBg/9aqW4GQPx5tadiVaCMtXaaRBYsEDNAiqtcRNeY3WvXAkhuaWn
	k1fSL3dVMxA9nWVXBVo43oKjPXrXj1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-ECl-ym3VM4yPzf5CcI41fg-1; Fri, 12 Jun 2026 04:10:33 -0400
X-MC-Unique: ECl-ym3VM4yPzf5CcI41fg-1
X-Mimecast-MFC-AGG-ID: ECl-ym3VM4yPzf5CcI41fg_1781251832
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eec2ba533so428726f8f.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251832; cv=none;
        d=google.com; s=arc-20240605;
        b=ADvzJeTFqwUenKBROIUUtb24X8REbKYOF3PDoL+TxGAvH7ML4nmbFTXs6Ake5fZZOa
         OWBQFmwnzg2s6NkxvekYZY/7ep43Kua9qa8qGOEa39qFoZ/Csi9OYY1AL57iUzbKyONR
         YBX1T2/HdwTyVuZTU+T5l1Fj07p6Q/CqiAPuc8KhHiFqcazsTRxdJzOodBQPgYqPXfcU
         lnYaumH7PQduGw2V3OTfJLcbC49Iy0bZd0w2VZPxjiJ/6ZhzUr6NTfmQez0t/TdwepMH
         8RDhqt11Iro9VeIcAayOsZ6U7kLIS9YPAqYckqKwrPt/eQQbM+jcKrq5VaLl0A8nUjA5
         YPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sBb5ENKnZ/wOcpFRONY4larfIT5T3nGcrjJkOJdabqA=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=I803QPM2rDKPMn6TCL33Jl870j60RZKbonLuecYNczJY6U2W2X6f/LFcDcftA2qalq
         /4TOc1Pj9w4eFEamR6t3TZ+AxdtFupSjt7r494lS+MgpIwBlcodO8DjotZuZyCxMY7NS
         rvxqSFYOoTVpWvkKnKuPUPuO/M0RAd5weoJobWA/QbEsjiliOGFh+f1oqs+9Hvg89WB8
         p4X/6GFWWjK06bVhSV9H9dH7E9Qm4+KjU903lQC2HoP62ko0Q9y8CvD0LRMqu9Vq2WBA
         UfLnZuGvWamHAVavZ9usljido1oFkX3Xs/D6AIJ9gUf3bXbPv/2G9nWY3Y/J7y2RC7Oh
         AjQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781251832; x=1781856632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBb5ENKnZ/wOcpFRONY4larfIT5T3nGcrjJkOJdabqA=;
        b=aO0pvWvfwPE5yg7QGaVP8rZLfaDjhNM+mZ9FOEwBvoL8mhzSyULwtY6wkpx36SroAR
         yP7bR9CMHoT8m525LQJfn9Ids0Zavh+ouznlfOz9KPixzEcKPCihC2UP4tSDM3KR5NFN
         9K9I6j5O/QcMWmhEGiikqMfaGhyWKg72GxQ0uywUtIeO8eXhjNdbNtaIR3PeEAveFXnV
         rpLWrzsM6qX8NK+1sPHtABbB0I8X/Dd0iMcmhULksLOTZfxCXVUIuF+u2j87NWLy0I+E
         b88l/rfqjuUdiTxHKOCp2X1t0RWvszYyf3x5Wv8QrKTo+qFKBs1L96rOhCbyb4mAXp2m
         uE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251832; x=1781856632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sBb5ENKnZ/wOcpFRONY4larfIT5T3nGcrjJkOJdabqA=;
        b=Ql9z+X2LhVOV2gn2/7C1CHtbIglhljXCjMxjH2Y+GHo4woWPXYbd58XE/y9NsOJI4z
         9FmBMEl2HD8HfnqEz/FefT8tUEPwwI7bwE1WJkcLzNBFmCZdrSGf20D0Mag32GoVfUK4
         g2mch5oLZzjUreRzW6deeuNxWqiWNJUa8jGG9bbXPung23j6lPXh2FOE6Kf2XBZsnQvv
         ECPpViZRovjaGE1rYVJ/9YCoOclqhwpNEotF2js2a8RAeBZgIc59ojea9R3C3lTW2JB1
         Gzwb7hwCT9Y13fuKFUyxADk9Pg5qlWBBrwyJi9UC8/vb27OqLiWXcEprY6DZ+VPEpx71
         kE/Q==
X-Gm-Message-State: AOJu0YxjIxav4Yq5MltRR7ZpkUm8V3pFXPhC3EkRmM7EA62BmQ9H+WvY
	hRLEe1gwY8b7LLxH+8YRDuX0n0hymNONuLTV8nUe/juKxgjQUS6+3ELlWhM8IAYj9H/ED6F7Imj
	4ZfGMUMTi1EXlziwd9Fduu+uHUQuUNiQNPvmN9nVlfvhYl84GKzhz7S4W5Fp2MCXNHtsYxP3EZK
	kUZeLeaBB3bt2uAWxmfJh954ox/5w/yd83FC82
X-Gm-Gg: Acq92OEMdOXxsI0x92eidOmJlkDot8x3JO5KQovJTRN854rCDBV75KK1oSn1mJ1tCSN
	U8Gyi33xDKBzbu0ek+VpQ19M5qGALuw5dHPaQtU0V5oZzwMsFDvP2Wj4NaoZbbWxSyIS4rGdtLm
	Zswe7BPs8aHdH56CuXD6yVat09yWrK9WGgbWEXw+W6f2ScozgfhnCnRTUs567RdIi+Z/znjbQKz
	LsIRQ8VUgDHjh5L9Ck3na2vhNDXwO+03pAlERhHnx0Xn26IRG8eKabixDw0auaLOaHtohe0jkuK
	FeMHBw==
X-Received: by 2002:a05:600c:c0d1:20b0:490:d2a4:1b59 with SMTP id 5b1f17b1804b1-490ec504916mr14078795e9.31.1781251831964;
        Fri, 12 Jun 2026 01:10:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d1:20b0:490:d2a4:1b59 with SMTP id
 5b1f17b1804b1-490ec504916mr14078535e9.31.1781251831534; Fri, 12 Jun 2026
 01:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-3-seanjc@google.com>
In-Reply-To: <20260612004755.349925-3-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:10:19 +0200
X-Gm-Features: AVVi8Cd_f9m01buH0-MG20dA1MYzUOwOHgxL4vjRMNB2j5rCVFKgD-oF69qEKFE
Message-ID: <CABgObfZWF7UM16P7F8yz_Sfe7ZvPbBqGZLcxjQWP8RstvyFgZg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: guest_memfd changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Fix a few bugs found by AI (mostly by Sashiko pointing out pre-existing b=
ugs).
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-gmem-7.2
>
> for you to fetch changes up to 48dbe473219832788c3940c84faa7f1df4375d5d:
>
>   KVM: guest_memfd: fix NUMA interleave index double-counting (2026-06-08=
 09:15:43 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM guest_memfd changes for 7.2
>
>  - Return -EEXIST instead of -EINVAL if userspace attempts to bind a gmem
>    range to multiple memslots, and fix the test that was supposed to ensu=
re
>    KVM returns -EEXIST.
>
>  - Treat memslot binding offsets and sizes as unsigned values to fix a bu=
g
>    where KVM interprets a large "offset + size" as a negative value and a=
llows
>    a nonsensical offset.
>
>  - Use the inode number instead of the page offset for the NUMA interleav=
ing
>    index to fix a bug where the effective index would jump by two for
>    consecutive pages (the caller also adds in the page offset).
>
> ----------------------------------------------------------------
> Michael S. Tsirkin (1):
>       KVM: guest_memfd: fix NUMA interleave index double-counting
>
> Sean Christopherson (4):
>       KVM: selftests: Remove unnecessary "%s" formatting of a constant st=
ring
>       KVM: guest_memfd: Treat memslot binding offset+size as unsigned val=
ues
>       KVM: selftests: Expand the guest_memfd test macros to allow passing=
 the VM
>       KVM: selftests: Add guest_memfd regression test signed offset+size =
bug
>
> Zongyao Chen (2):
>       KVM: guest_memfd: Return -EEXIST for overlapping bindings
>       KVM: selftests: Test guest_memfd binding overlap without GPA overla=
p
>
>  tools/testing/selftests/kvm/guest_memfd_test.c     | 24 +++++++++++++++-=
-
>  .../testing/selftests/kvm/set_memory_region_test.c | 31 ++++++++++++++++=
+++---
>  virt/kvm/guest_memfd.c                             | 16 ++++++-----
>  virt/kvm/kvm_mm.h                                  |  7 +++--
>  4 files changed, 63 insertions(+), 15 deletions(-)
>

