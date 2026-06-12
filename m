Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43538372ED7
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251697; cv=pass; b=g4sdDTozlgjI+hL5zqPca7pI1tzg6N7/XNLyJlNsG9ohze5tBVa6nf1EXyeQD3RjNYej1n7eJNnVgovkctsmzUziqSGxYfc1eU8UQSy77WAV+xZPvTJguOem9EzS7/R0z+WqEOmklksGeKxk3At0N3AsBM4IfX/gLMBUb8pp0AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251697; c=relaxed/simple;
	bh=QWhkb9AFGTFo4zSIJaEEZiDWWfSFYdicB+BasHm3Cmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBbCl0nbBT3xTXG386jh2xGL3Il8UYZrDutMoKRMxflaK0kp6hFN1RMLvQYGAORBqhWrP054A55qQmsBI7ycx/p9mMNLCzKG9dq8fFeOmTk9u1dmp70+/Nu8UXYTOWthaP5koJv+uMR4nICaKFrFnQF4T3KOUAH/TDwKbmua1ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWP3ZoaU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMxa6sUO; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWP3ZoaU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMxa6sUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781251694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkpiKud01N81yztLMpVmWop6gYJx/jCEEhpS5fHAHQY=;
	b=DWP3ZoaUjrsZOaBe3+s6Hj5AcgeoCNusVRsSV445PtL/bFgtGL8Tbw5hmvHdBXnh9DmzAE
	ArMPW2NfvvOW/lxymPxwnE7ZRgiV28/6tQdPtIL+qj09AparyP29YlytDinTk/+qf61ReT
	FCgq36PgGtyMtTqksI1tB1/gE0kbtv8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-iSqvXeSTP6uq1MmNYTxqGw-1; Fri, 12 Jun 2026 04:08:12 -0400
X-MC-Unique: iSqvXeSTP6uq1MmNYTxqGw-1
X-Mimecast-MFC-AGG-ID: iSqvXeSTP6uq1MmNYTxqGw_1781251692
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6ad76bfso491953f8f.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 01:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251692; cv=none;
        d=google.com; s=arc-20240605;
        b=GNadlBxW++zjq6qwKBow7klKlPfGG+jmgqWpzVq85rlF10bmXzvNWM0rRVbpXhd2sY
         zW6kGRxB0fSQpVL4H3Afx0uqoWVZqum7KLnSDZKfhg0MKfjic8ATO/URI352Hs6KrMFh
         c9dixPHXu4Nxpm0VdKV63u9fBzgAMVgcJL37zE8DTICpFmSkT8SKEOhsmvaTbMrPTEpD
         bT/LUs24ycM0Ra5FbzaTYTBBeXOO2M+LT2MIHDtH7nrlsdmiSOn6sKFjYex5YWXGmIdk
         b69MzaAILZhMXKzi+LrwXFfVWt8oaY4khSE09c3Mk+pp3zkMbpUflu8PYeuYbs/oe4aU
         f2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MkpiKud01N81yztLMpVmWop6gYJx/jCEEhpS5fHAHQY=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=BaywhwhNVATESdFSi9MD1Rf7Dm39JjOU9qxjjVHHKswL4vodpW5uhWCM1FLGQRLmme
         75aGCR4Aju21x8eIthchEZuYUx8j3XPTUQbfvvLdCFhhungd2yzeDjhX+7aODfKjG/F8
         t5jXOVwePKAsKKHKgqWhWKx7K9GSlEweyq7E2oaOpd0PT7RQtSg+oLJSfPm6nJpUBHa5
         VG33WvnpwKq7uzq2fAyg0hyYiA6wvifR7iwYHfouGrPkGbs/V3daf1KfVXMTgANuNHkZ
         HrCuqKlmqsSPgoKTdDUThXrtWrk3iAUqAjEar1V04oGBlHV8gB9O66hjL8fyPPEZEnM3
         Zyew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781251692; x=1781856492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkpiKud01N81yztLMpVmWop6gYJx/jCEEhpS5fHAHQY=;
        b=DMxa6sUO1h/Qo59sX1LiVpA728CXmQR4Wzh0U0kLRIlGn9/NMDn+Kz+IY6UpbkzvbW
         pe6XEhzSg5z7WaXZdm5uvr7P+Z9VQX1ZEMk6ryVDBgjb0PajD/en2ZopKJlAblCzSRve
         6GffTilLXuproUkvJ3thcd3XiY6cLLvb3XwGpuf73KrOtoFreueNU5mEhn7u4fl6OxYR
         IHwY2A4E3pYyxB68++ECyGME+rDep2MFVghDnglUEDpfc4v6/g/EXbaKs4b8Bp3BcLf5
         mreN2rvST7fZCcjmI4YHAD58ZU3LfwJGZz53hKKuhMh4pA23b7eHSeijLnd9EGIt0k8d
         QqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251692; x=1781856492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkpiKud01N81yztLMpVmWop6gYJx/jCEEhpS5fHAHQY=;
        b=X1+kJfKn9TD2kPdL4QgCup7BSgId0tdmz9jOpA5RGlUj7nPCtE+PCAdMoS9IL6VjAo
         m4FiQf8GazEdeiJEAI2xIAm7FP/FnFnJL0QZfDSKhcbPFNyaCjrsinHAH0p7RuparEyz
         KZb8lSSYDRcMLN/x/k9nKkjl5C4CxGT3uAoglLKdlJyzvE5H8Mi8/JtOur81RvNwV8Fm
         zmOHIRJgL+dsHHdVgy0ah01HkDjW6X+8vXB+Pmry/MFHdsnMuZ5DJdHzC2qGjWxJLAE1
         AcCyODVVDH3eHF+573i9PEGtzxj2oJfBwj0E1b56NMgmYqwtKn7R+fMxHA8LGk5BnroW
         U8rQ==
X-Gm-Message-State: AOJu0YxcATygaPRj/hpeFYQtyeK3GusEVlBfRwWUDzoEzF9Fa+fk4Pjx
	8chA1Vhto1/Y9PKr/vWKvJbEiwnxRE6nlQb04NrFD9iXzo3t3QNuQ7/2ruiMic9kQP92qu+WfPG
	7QdmIo9oFxPCemFpkCffWRkacUsVJthteFz7hnwF6BaDWA0l4ftvI8/lgNCI6kewbPPcE4QFAds
	oJl8G3Sr9YDPx7LZX4qiaoVW9LE4Fx
X-Gm-Gg: Acq92OEVkvjWNvscL02Em1MNf8Vb/Azfdih1D4RXFJjOyH3MNBkszcSVQ8GsbMBak5b
	aecrlMH0HyuNHywHpn19wELj3HS/YrrYLP4VmhFuKthY8mjrm4NUNyyodFEha8knj0SUzK3A+yX
	zy1ZeqDYwhGjftR/WrQbTVnsh/HuoR+Ns8R4tHaI/gRXuOBx+FE/QpuJ1fhjUR/ExUeD1HXPgWO
	R1FZe2+baSVYXRzOWQVFAoj5yCHNBBIFuvGw/df1Jyr+lJ4ZnIb4MvmoD5Er+Mh9cvBhe3wREEP
	c1VhPw==
X-Received: by 2002:adf:e00f:0:10b0:45e:d8dc:922e with SMTP id ffacd0b85a97d-4606db97662mr1595364f8f.20.1781251691603;
        Fri, 12 Jun 2026 01:08:11 -0700 (PDT)
X-Received: by 2002:adf:e00f:0:10b0:45e:d8dc:922e with SMTP id
 ffacd0b85a97d-4606db97662mr1595331f8f.20.1781251691247; Fri, 12 Jun 2026
 01:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com> <20260612004755.349925-2-seanjc@google.com>
In-Reply-To: <20260612004755.349925-2-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jun 2026 10:07:58 +0200
X-Gm-Features: AVVi8Cck0-jN8K2sRakoOdyEEWRdmnV_We9RQeK0C31MTdyb_2_nlLYt4NcoSPc
Message-ID: <CABgObfbqHvDd6FdHVdsm56N-di8VaHxhUAYr1yqfQoFuxiJFUQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Generic changes for 7.2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 2:48=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf18=
87:
>
>   Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-7.2
>
> for you to fetch changes up to 5804f58901af77ab507e199d31dfa263404e177c:
>
>   call_once:: Fix typo in comment for call_once() (2026-05-26 12:28:32 -0=
700)

Pulled, thanks.

Paolo

>
> ----------------------------------------------------------------
> KVM generic changes for 7.2
>
>  - Rename invalidate_begin() to invalidate_start() throughout KVM to foll=
ow
>    the kernel's nomenclature, e.g. for mmu_notifiers.
>
>  - Minor cleanups.
>
> ----------------------------------------------------------------
> Jiun Jeong (1):
>       call_once:: Fix typo in comment for call_once()
>
> Peter Fang (1):
>       KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
>
> Takahiro Itazuri (1):
>       KVM: Rename invalidate_begin to invalidate_start for consistency
>
>  arch/x86/kvm/mmu/mmu.c    |  2 +-
>  include/linux/call_once.h |  2 +-
>  include/linux/kvm_host.h  | 12 ++++++------
>  virt/kvm/guest_memfd.c    | 14 +++++++-------
>  virt/kvm/kvm_main.c       |  6 +++---
>  5 files changed, 18 insertions(+), 18 deletions(-)
>

