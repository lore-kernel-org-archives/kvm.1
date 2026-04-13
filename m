Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5460392C5A
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077457; cv=pass; b=C5xuvMZWOUZ1qUjerNKLfvrKj3PKo25c84W3OEfnynYaVOEETNgNyOP4CZllAkv7EkPA9dIbZu5Z/vEZ4f+a1p8F7PAERzO9YDuzIXt39im4en61xHGkGtEIRazednVM6sp8JaNe9ZRFCy16rbbGPLjmQ98cky/sexHFdJEdX+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077457; c=relaxed/simple;
	bh=b5OTb4N77D48lz+c1exSgZR82539J23sTEaEg0OO4vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeIxYeWVmS4Oy/yiEIDNyyw+EtBu+GXJzgx9td7XgrCespIeYfR3sJ/7jcW5c6/b5tHmWtG6KHeM/1j2yq0SOjMiGft5OA6TMX2qxqAKhLz4lI2Db0HKAnGGoQ4dM1RSHEs9LKNcMdUH3IyQAxL1N5ylMZKlSoRVw3wDcr+WXz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO1tGsgh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Jr5rYs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO1tGsgh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Jr5rYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776077454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZG9UmCO6ydBSKilwd4PtXzN9wb+aaHktX3dQ181pko=;
	b=DO1tGsgho1SRExl47lVhTJ2tJEIbhm950Px34rHQ958x+nrC8qCbKC8skGtWtwDquV8rmo
	e3h/TRCy7d6tpWKVfRQdYq9qyBARZanIytzt5Je735/w6JHgEhCJNxpV+o4T/ieLZirOtC
	f4cBzDtphiGSMpsDx0cWmTQsyo22iqU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-AdSuoOIwPTy-0rL8bAjXVA-1; Mon, 13 Apr 2026 06:50:53 -0400
X-MC-Unique: AdSuoOIwPTy-0rL8bAjXVA-1
X-Mimecast-MFC-AGG-ID: AdSuoOIwPTy-0rL8bAjXVA_1776077452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d780757eeso597435f8f.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 03:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776077452; cv=none;
        d=google.com; s=arc-20240605;
        b=X++hUMyXRjg8H3E1w+wQ5MWvED8MnJXa13aENxGDKmR5a2qcj9858oHL9ltvROgLUR
         HiRJCXVuEN5qIjjKtYLgemyLtMCydhR8XPfd+H27kSK1PsKa8kZZYO8s/dHSGBpjVlMI
         pjydlVieaZxctrfDOXGbhG4n2ZAOLAxBGhvZNqUO7QheIgoCTm9QSTh0wjq+wjRw/ZE0
         0M4FS01lr7oImrOP+olfd8aZ2iCtpC1xoU+vXzchAlxcxeTFgBxFhNE5I4WJghpIR5YO
         EjZEhyFtFuA9lDVv8SKSDINOAYvQ3RzDWzzNGLojB6EV/wExGLqq6su+p15c6blb3R/F
         VO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fZG9UmCO6ydBSKilwd4PtXzN9wb+aaHktX3dQ181pko=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=NvfYjjJGCtQLJ0yOTMk9YxzCdO0i7RmY2QQKXENDPkDIoLjS2jbcNFlxrm0XA2NK6I
         lK4A3zBwlUCSBmd0VFERMlJiU+qry72q4e0ldq0HisD3gR0zD9+25BHc/PXAX/eKHUkR
         tUp+OlQuvNN2Beoeg1VgDJ28hBa9eVxAXjKU32N+bTkl8Erp5sIMpvH1kRYfXD/SDrag
         wGCy5HwJNY8el4HTYme8a6qEkBNYfRKLzqrxmsY7VWOMjIeiW3dDc2+7LTFLm/7fU2yU
         gTDSQNOOBNYSeneclk8BFsIT3q2RkoHF0gpmBtDUJodEgLLe2pU7YSMfhMQMxZ36IFOo
         khsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776077452; x=1776682252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZG9UmCO6ydBSKilwd4PtXzN9wb+aaHktX3dQ181pko=;
        b=S1Jr5rYsUaz0L91hL1L+GC8GswoY9IEscbSta/anOViBcz0clalk6TIzXeVG/a9ZXq
         N/M7lNGP1uQttIv6RyYOopu5pZSIlDmV8VwHO96J1f76BIPKNykNt8EYltQ9bGHvIpVY
         5G/M16BzheC6FThZoBucHDTrMrna4Ix8befeKHjhbOj0z46ZG6XsDYBzHRjXneqwoUAa
         XO39eV0DuJJI9977ZOyD0Ppp8WZ7sqLQGVlax754kbbazZQKoaGSo1EjuCGzgSw9Sl7a
         AuNpFjHxixRSonePizrvayBgW05hvDxncZBcgAuUHuqHuoysZHywawa+PJ89AF16NqFo
         tGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776077452; x=1776682252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZG9UmCO6ydBSKilwd4PtXzN9wb+aaHktX3dQ181pko=;
        b=dVFjonXUglc1EFOxLcQ9G1hJpTzqr3Wbb/AB1pmOIi3fFu0P09Wx9LIOM8KrJaIvN3
         1mDkMdabsTOAjCgimgUlxsqK5+cwjuyeCldluejMdAeod3fX8T+o6AOSiNm7g5QVReXV
         akjuu9Z62SjCwggVbZgt7a4C+R1GCTafPjGkquQnpKrQP9o9vQe8mkoqsXFsmSc2JV99
         00Xs9yUjglYLYZJ8n6/8KNU5z17BpZDs6uo3nBW6n33x9FwnCXBKK95VtfuRB0gLV24m
         dJrB9WsqHc/MuRmJOrVCr8A4PvuDGgL+KHQOUIemyi9/rC+akRu8oClfo+Mp1Cg9Lz0+
         nntA==
X-Gm-Message-State: AOJu0YzFDK8nOP0/BBwdthf0Daypwpi01YdX3LdHcWE9bvpYDAgXW1GK
	dcSbt/ih+uYx6w91lHntv/opFje8jB6AgfELTusbjvWVAvGwtKCZH3PqqzrqNwRGSD91m5OZJb6
	FBRv1Wpo2FvHp5Lky91agnoMqO4HtAwlR0sCA4bMZN/LVeBvkLszZiB4NkpF4reYczr+gzpSeD0
	93CSGodZ70pjs7mDbYesEGDA2urjnB
X-Gm-Gg: AeBDietY2G6gFCtW104ltyeX4iLyz1pmM7y7M9NjuQx7I2jvJ+NBwP4U1vNDb8VBO1Q
	8tl2zNn/DX3r1u3XXv/aPgEmFUoMI5rrnnIA1qm8s5k7TxRUZVq1exhHWa52kCQkixj42GTtf/V
	3rERKHJ8p0YTZv6zEaeg/niMBVuD+g3jE0yRm4diJD+Lj3R/d0PpL06Xn6eLbgyxkSWQdlHnDRs
	WBLFQIk53YtmgQ0oNKVUsl2HYS8eOQ9aPQn/vWc2IjT4OLIyvTn1TF+CDrSPf8BOYm1W73711bs
	UfQt
X-Received: by 2002:a5d:53c6:0:b0:43d:7032:8f6e with SMTP id ffacd0b85a97d-43d70328ff4mr5493568f8f.1.1776077452268;
        Mon, 13 Apr 2026 03:50:52 -0700 (PDT)
X-Received: by 2002:a5d:53c6:0:b0:43d:7032:8f6e with SMTP id
 ffacd0b85a97d-43d70328ff4mr5493540f8f.1.1776077451731; Mon, 13 Apr 2026
 03:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com> <20260410235832.2312342-5-seanjc@google.com>
In-Reply-To: <20260410235832.2312342-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 12:50:39 +0200
X-Gm-Features: AQROBzBRqthpfKziPsR1g3VVW1zHyrSTRgsCGnvVX8oIeNxBxm_fj_3HOiGKbh4
Message-ID: <CABgObfaWsE4FpsyC+Ege+dLGM7mpMn0AOfzCPnknLzyAMyxdcg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Emulated MMIO changes for 7.1
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 1:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Emulated MMIO changes to fix a use-after-free (kernel stack) bug, and do =
a
> spring cleaning of the code (though it could certainly use even more clea=
ning).
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-mmio-7.1
>
> for you to fetch changes up to e2138c4a5be1e50d75281136bdc3e709cb07ec5e:
>
>   KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit (2026-=
03-02 16:06:49 -0800)
>
> ----------------------------------------------------------------
> KVM x86 emulated MMIO changes for 7.1
>
> Copy single-chunk MMIO write values into a persistent (per-fragment) fiel=
d to
> fix use-after-free stack bugs due to KVM dereferencing a stack pointer af=
ter an
> exit to userspace.
>
> Clean up and comment the emulated MMIO code to try to make it easier to
> maintain (not necessarily "easy", but "easier").

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Sean Christopherson (14):
>       KVM: x86: Use scratch field in MMIO fragment to hold small write va=
lues
>       KVM: x86: Open code handling of completed MMIO reads in emulator_re=
ad_write()
>       KVM: x86: Trace unsatisfied MMIO reads on a per-page basis
>       KVM: x86: Use local MMIO fragment variable to clean up emulator_rea=
d_write()
>       KVM: x86: Open code read vs. write userspace MMIO exits in emulator=
_read_write()
>       KVM: x86: Move MMIO write tracing into vcpu_mmio_write()
>       KVM: x86: Harden SEV-ES MMIO against on-stack use-after-free
>       KVM: x86: Dedup kvm_sev_es_mmio_{read,write}()
>       KVM: x86: Consolidate SEV-ES MMIO emulation into a single public AP=
I
>       KVM: x86: Bury emulator read/write ops in emulator_{read,write}_emu=
lated()
>       KVM: x86: Fold emulator_write_phys() into write_emulate()
>       KVM: x86: Rename .read_write_emulate() to .read_write_guest()
>       KVM: x86: Don't panic the kernel if completing userspace I/O / MMIO=
 goes sideways
>       KVM: x86: Add helpers to prepare kvm_run for userspace MMIO exit
>
>  arch/x86/include/asm/kvm_host.h |   3 -
>  arch/x86/kvm/emulate.c          |  13 ++
>  arch/x86/kvm/svm/sev.c          |  20 +--
>  arch/x86/kvm/vmx/tdx.c          |  14 +-
>  arch/x86/kvm/x86.c              | 287 ++++++++++++++++++----------------=
------
>  arch/x86/kvm/x86.h              |  32 ++++-
>  include/linux/kvm_host.h        |   3 +-
>  7 files changed, 180 insertions(+), 192 deletions(-)
>

