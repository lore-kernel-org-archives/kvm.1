Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B714D0CC4
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005027; cv=pass; b=AYDkOmsd7Cm7x/+1djBDnqJVQTvwbfsZyOXDaEIOR1udZKE99l5vwJ1K7m9dKI8uziBgeX+EvqT6x5ConSaQIYwGYntNPhv8EEL5u191DiW4GncdEoDS49yCV2JbeQnab7Cj8i9dnUdG3ud3Zyek2m6tIzQJH9djsi/5VVChWGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005027; c=relaxed/simple;
	bh=605+kgvDQ9CC7Dqfh31X+6P5aO3gnNTo5Q1U93YCcDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxVHKL9L5V7EK66rwO4f30g6geOPYEl13ymdeSs60MmgAYkOE22efizqhd7wud/L/4Fyaais9j6cOs6ev7pWNuDL9MgtAHAQ300v2yHGn4Mnboj7ZTpGyMUVyAXzscW52fzGH0rlzaCyp3qTbS+G+itho0Gz2Xq4bek/TpdEeEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foGPqbI2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/mjoLv3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foGPqbI2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/mjoLv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790005024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twdk4Tne1/4O9YpjiNMs8jU+vPfWAzKxomteFVmFtns=;
	b=foGPqbI2YKkrgTxlMyIKMSRj5zubUOOfpg9QYiyXE+aespXZjdPVgZC58urN98LsKpGBIZ
	Kvf4jQg7CkK2sVZ/YWjBto5MTTIbvZ39l2q2HecKCMcYLnTXaKXScNn5QWlgGIpgFegcDB
	N7s/e89fCX+Ccm5XuBsWWyYQ1CSKn2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-5XzncNtVOcidYxpU3z0jDg-1; Mon, 21 Sep 2026 11:37:03 -0400
X-MC-Unique: 5XzncNtVOcidYxpU3z0jDg-1
X-Mimecast-MFC-AGG-ID: 5XzncNtVOcidYxpU3z0jDg_1790005022
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48589603501so1582442f8f.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 08:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790005022; cv=none;
        d=google.com; s=arc-20260327;
        b=UZSid5yepp/gJG+RAU+pFz1HgrBo/ByFk5kAAGAljBlb/KqAxAdV/9RyMhWbYKOIIp
         ypvRR8nDisch90BArpt69GGnwD/ByLZ7YYvO1NjI8zBpCl5p8v6ry8ZPbWhRo+hJ+LtB
         wiV8E5VSBlG0TKGCmz0c3Yk4GUIET7XY7ti24YOwhbBE5KesChp/6JukscNBDxmk1h6N
         4/fKSE3nTVfr9N9CiS1YBiRTTQkcDDsnacGaMaMYKf/owfgTHWwAgk9/vjf/AABGbinm
         X3WbRmqg++L9A9PNptZ3RPyXTiOZxSsx3c3pAcAdf6JIGhGNfk/FKf9ZPuqBLbmtw6YH
         /e8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twdk4Tne1/4O9YpjiNMs8jU+vPfWAzKxomteFVmFtns=;
        fh=gODEUqo+Bo7nW2ykYD9q3BWEYIAA5MlRH41QywN/U18=;
        b=LmEX5oZTdwVBmx3CvCLTqa6W1legCFdL3iVd0kSyvDb5nLlhpzr3Kz2RXCH/M5zvFc
         pavi76ZSLZ7LCP/gbASY6zqTLQ8kbXTQeSqzNQ1fgSnLfkW74vXztsDqIz7BpeZodf/g
         si7zex/M/YtmkFymfzR9FD9/B8IJALEIL6pXE3uqh5V61T+7K+OQHUi7Jl7gbGEVmLt7
         3vzbuS+D7umQZXkihzWz36yxA+WwvqK15s7ihpo40vO/k/Mq4l8IRplnjLK0bpov0pbc
         8LIb09M6BuNijiCf2SCddFwfe0c66s1tJU9ZY/7xMc+ozV3xg5xZSuLV+qpDiiDZNc0d
         vstw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790005022; x=1790609822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=twdk4Tne1/4O9YpjiNMs8jU+vPfWAzKxomteFVmFtns=;
        b=J/mjoLv3lq/5l1vx0AmtPWjy1dLhe5zJuMeC1Rkv6JxHOQWCGF47FKG9OU1QMf8u0r
         C4J01gAjX7HtLAdVN1eJmVoI7OPZv3EZ7fKVoJDVNlrw5J67pVIqTK6gnwZAEEOXyTVT
         8f+wckoGoZ125uIfR+RpO9Ymhmui0veB4yScleOPk5ZbYcInrS7L1frtR14RadzSM18G
         73yePQrUqt5RaBDQsJuYVwjQwoWkqyPm0bjLofFdQ1z1JmCXRhTEwJgxuMQK07GTB1dF
         kPgfEEv/YeuYiVF1aXp7Y2jnu+x14d5xgAx+rz4EBrDWgRjqRdfMWzxu99bBJFPjT2bX
         rUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005022; x=1790609822;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twdk4Tne1/4O9YpjiNMs8jU+vPfWAzKxomteFVmFtns=;
        b=ItpbBfzWm2JJl9chfqnjOxkg28NOGYEUtDTxyYIcnMj0bq1pKxl0GI0vo4TMxnIjfY
         fFg206HumIHAUL0Cu6JTH3A5qa7FIDwFOE3wzdgoT4YnDXVf5o5F6c23HmQcJMrYvw+V
         WrhInBlWPspo2JpFXU7IvRU0DcK2ScEtpFa7nyVTZKT3evdmVf/UAnQa+w+OunG4FzI8
         kby7KRnkkFRPphPWEFRk6Rh3ba5i+fmXQXia2z2AJFMH0uCRdCb/Xu1eSB/owHE+vZiD
         XRQxvxxVcLIt4DKx9sE1DkzPOK37GhBjfLFGQTMG6xB+04eS0lNGxVG0PKnC4jpXzPmC
         vpoQ==
X-Gm-Message-State: AFuF++l03kRa8yqcGqr+aJvKs+KvZeQStvKUtTv/bR2rO6zENkFi/s2j
	/BSjPQSiBs72Yvl7n2ntEFB7x0Dmt9fEAO9NFaMWKHQ0tt3KsZg7/kiaWa9svn8yXxSbY2Haf3V
	g6ZQY+IqFNREY/lxZWmp6wABH4ObKtlRGNleTicm4HxC0mOYXrrexoAcwcmvOV7nMXXiU2WYmU6
	pySEeui4+U+ARc+v45y7vi7nxyX1DR
X-Gm-Gg: AYBFou2ilm3Li5thmhrDNzJBmeJMWeBrQTvDBLYJOjf+k3X1SxCiVRDonEdZFDjEBig
	4P1yS3z4fMLFtcoEmModS+96I+U4PLvgBtkrKrF1Sk75/Nn/d0k6yyK62ZtuDC8Xw/GWOlXjTZy
	E8JkXVsCpp1YdokXxHOWuBOO1plBZIYjJb89ZhMOOCWXGHEp1NnJQpcraahGF30YksyAa/TrV+o
	RGtzJMUKL80Vuq0cP3CDbzmeXpqxZyyx7MVBLxs7y1pBi0eI4Ho1rglmX7Awg==
X-Received: by 2002:a05:6000:2405:b0:487:bef:31a8 with SMTP id ffacd0b85a97d-4871dfac13emr17456024f8f.0.1790005021940;
        Mon, 21 Sep 2026 08:37:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2405:b0:487:bef:31a8 with SMTP id
 ffacd0b85a97d-4871dfac13emr17455982f8f.0.1790005021596; Mon, 21 Sep 2026
 08:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826164214.756512-1-seanjc@google.com> <178999899502.746042.13434207152687268434.b4-ty@google.com>
In-Reply-To: <178999899502.746042.13434207152687268434.b4-ty@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 17:36:48 +0200
X-Gm-Features: AcwNN1Vc5Dd1Z6bz0UOG_dq6CPv_obdD40QYNgy4I8WlOv2VzLbhnywhiqHrT_0
Message-ID: <CABgObfbtL48EP7+_VJirWxFj+NWnn=kmF6CF+qdctyHv_a4FAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: Fix pre-fault and map private loops
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:07=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, 26 Aug 2026 09:42:10 -0700, Sean Christopherson wrote:
> > Fix a bug in the pre-fault path where KVM fails to reload an invalidate=
d
> > MMU root, which puts the KVM_PRE_FAULT_MEMORY task into an infinite loo=
p
> > (although it's breakable, so not fatal to the host).  My best guess is =
that
> > the test started failing once PREEMPT_LAZY was enabled by default.  Not=
e,
> > the bug is *really* easy to repro with a to-be-proposed patch to have K=
VM
> > do auto-pre-faulting[*], i.e. prefetch surrounding pages on fault.
> >
> > [...]
>
> Applied to kvm-x86 mmu, thanks!
>
> [1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteratio=
n
>       https://github.com/kvm-x86/linux/commit/355323a4dc94
> [2/4] KVM: x86/mmu: Harden "map private PFN" against unexpected root inva=
lidation
>       https://github.com/kvm-x86/linux/commit/698b8c88e159
> [3/4] KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"
>       https://github.com/kvm-x86/linux/commit/6415d9c4ee19
> [4/4] KVM: x86/mmu: Add sanity check to detect stale page faults in "map =
private PFN"
>       https://github.com/kvm-x86/linux/commit/f7a3be227619

Should I apply this to kvm/master?

Paolo

