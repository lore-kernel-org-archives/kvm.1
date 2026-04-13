Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D83AEF57
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079453; cv=pass; b=JpJoeckoV8dkxxmb9IXIRmLUgsVtA/WUNkoy5mTZqwjOAi9nF1WaUCeOvGtcNTBV77Rd1o6mKB/UH3EEjNYDNfxO2I7gBwMEKaCXDgSm52E5YT5QsGlBusZ7YdStZfUuBwp+wcIrY0xknYUdQHNDv3IDPzCfuvEjYtoSKRv3eXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079453; c=relaxed/simple;
	bh=xsKsPS+/LRix2wVTrwLV1Lanow3eWVIGZcL8m0QQv74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvBHoG2+NQAkWnyFUNXKKd8wC3NqHgikce1UI0eNcM7i+db3ufiK4eFkA4GfwZKsOdPca51MMuA8xCGj0geJl0w0X8OiZuiIhbj3IjvcKFixxlIVxzpj5CUQnFtCWus1C3fxLk4ZyKYgK/1RPOd+BWNx8ubWyhsQ6KmdXqC3E1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNBZRziL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgpT/99O; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNBZRziL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgpT/99O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776079450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
	b=FNBZRziL9AEmMbiVCezu8v5xiCV2oATTts3EO7abxsWit/sTtugXF6icoyHK5utntWLhoh
	0eQbg4Zgz+KFpdOKic9jGQ65DgwWSqEY3T94U3lwevyYZhEUm+GoVDA08BKzflcGOe+B64
	z7/P18isxQG+v1L/Fo6ArAQFQ5cnbDc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-ndJdP5CTN0qC1ylrWlwb9g-1; Mon, 13 Apr 2026 07:24:09 -0400
X-MC-Unique: ndJdP5CTN0qC1ylrWlwb9g-1
X-Mimecast-MFC-AGG-ID: ndJdP5CTN0qC1ylrWlwb9g_1776079448
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d02fa5860so3668007f8f.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776079448; cv=none;
        d=google.com; s=arc-20240605;
        b=iR/bGi6kodTn2sFWQBx5uCXyE0l8WlEiyF3ngqkvoJ7uPWEClQFy9KywBhhI8lOX1b
         Ab2zwgvbvyza1kiRYh2U6h3nqkhPp9qNyBhxQ7g85elFI8e3zEonJcxamaA0A8lgdB3q
         5tK7r78pDpAQ+jZHEgqI16MTccsYbJ/vgB3TumW+9B2bcjvXvjOo8VxDLaxL69XuubDK
         3S92RjdKNLxh6xLSa/HYqR7/3zAygKF0gcUUs8VhnM6x07FAym5pf2rQQkYRpPuFo89s
         7jSphW4f3L8/Le6b6UZlQY77XYQm8DHE59JHMbPBCPlhJdsxW+PSJKOtaVgZ21m3DXTu
         AfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        fh=fRw7oUKEQy4WM+iRMiqX+ccJt74bEgfwwPn2TF7CuBU=;
        b=lOo1iZMtH2DkOHoC3Dxt4kDa5wrpTX8xqacZpL348Lkcw5U6rXYYoh00c3j0NmLGy0
         86LHHEt7P1ZYuDBZL4d5mkU8HR9acnlsJ9jBqcAl9Qz+DVtltjMPY69iYYjDkf1+i0TO
         PBQLGv2ap4g1bh80S0HDTaSpNXMrAIebDgYKwZFoUcLYvUKwYjTH+sm9z4Umdj+8xd5x
         tF1NbYlaGa5wlt4cTYWMucIIwYmT92APvvkSuPV9K+GkR9h0RzOdhNY1s+ZyrleXiJ6H
         XZ2mSZU+PMs2x+A6WsbNAXBeKYR+kqplmQcF6yL6f2rK5U2hdVRiwVNuHq+DohQg9ABD
         qhWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776079448; x=1776684248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        b=KgpT/99OYnHb9FKyFJaEWRG9ML99tCBN/FwIKDMe2Grmuo1EiN2nAFUiKnTw3wyPA3
         P1rcXrKryyFS4aqRRXZWHb8e6U8RXmJOTsm16I0k56pYT5SBno9LIi/JAP5wUf6H9gjB
         0DxWfipGaWc0ZWFPjJgGuc5Zzj1hCgcqEn1cyjsFuDm3rClVuevD2vGTN6mSW2N8nsS4
         A0sMkeZHeoXObqag8PfPT0Pch/9TdkZ8l5Q7GA0WdnP21ME/XYYfzdIZ5NKBT9IP/J24
         SJegUtQLcjmj7egZV//Gv6nD8nZHBu0HNgNrr6dF0lbbrxyjz3MPOVSan1mY203wizoq
         etMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079448; x=1776684248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUqUeA7oo4jBHFJWxogBW0d62Lmyv6k7nApGPlXPmhE=;
        b=iSsBLKhbVzuPpDSyglf6VCAMjBz/e2+I7V4uMq9x1QyN0XRLascQxxSMMjh0JR22dO
         uTBCXofi7bQENbZHO6dKVopnzQZM9fQbf12qM/neqAThN2UeBwQiAafpGy3Tx/hlDIfy
         /taNMFa39hrjGnBQ2gOF/sqeKb94SLHBcGSPJdRFgqOj3XzUi5Y4ywshMeTsiJa8W3T5
         6Sj0KaVza0L7kz8Nn14QovKAY8G8HzZSNlt8W/qa0LJOaEBpBOzSqV9vz0XJ/tHWZwOH
         6en9kzND+/SwtBmz1h208y4+b5qrMALjc0LTgfD0TKVe05JIgKBmX8yxnADUiTDZlicp
         0mIQ==
X-Gm-Message-State: AOJu0YxDdiwcDAaMLs3jPb8KKYSOj9gOfcTcbys6zQufHjp9z9Ox04tz
	EBdUY0Qx1z/8sCPEG5EpAkkrYehefMOPeHK9c3HoOpnqP0kv/F7mj9fa5ZVp0v8tNKuXyFA0DCS
	G0uGtsl5EAw2iQcXZPy9nFyVM59hBf8v2O9JjSmgArpjbOV+eTA2+lY/Mjp8nOv5xhIePO8B9rc
	AVD2wCaka+L1Rf0WiKdjTwZ/V5Zyjs
X-Gm-Gg: AeBDies/RgGO8LbkSgMsd7DNuPuy3a65Q1XgXdcJK74aBp87xsK+mMBSodfV/OOUNFx
	OMYnu7cEigSrGs/YuPZUp9mVNMQj4l+2Frv7RBqhX+9uhhCguo3vqlFBM8SNKR1D34WQmK/phtj
	Xfxyba0beJHjyX3UZtyuirJnfY+4/QGF8oM7b0r9YEpONCNO6bushdLY1nEhcgJ++XT7vXkHBvX
	CfUw8bd8i4Nwe2uiOncStTQeOQK2eIRWKinLREOV2HtEpW+7inskLIJ4M+lT5WT2CH60YeIMWjE
	k5WK
X-Received: by 2002:a5d:5f47:0:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-43d7d24b9a4mr1542521f8f.22.1776079448139;
        Mon, 13 Apr 2026 04:24:08 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-43d7d24b9a4mr1542452f8f.22.1776079447584; Mon, 13 Apr 2026
 04:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413104721.203024-1-frankja@linux.ibm.com>
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Apr 2026 13:23:55 +0200
X-Gm-Features: AQROBzBTwHEVPVTAbdEJ4LqTkV7Mhh6IPc-Con_U5Sj-hzHox8sbwNXmybi8D80
Message-ID: <CABgObfaWO3J89sFmu3ZBPTztXcKgXPZu3FyiRcasejS=0tgJYQ@mail.gmail.com>
Subject: Re: [GIT PULL 00/12] KVM: s390: Changes for 7.1
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, david@kernel.org, borntraeger@linux.ibm.com, 
	cohuck@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:47=E2=80=AFPM Janosch Frank <frankja@linux.ibm.c=
om> wrote:
>
> Hey Paolo,
>
> here are our changes for 7.1:
> - Claudio is finishing up gmap work by allowing 4k memslots
> - Eric and Hendrik added nesting ESA support
> - I've fixed up LPSW/E emulation, going through next as I don't expect
>   us to ever hit this
>
> There's been two conflicts because 7.0 received a number of gmap fixes.

This is just nearby lines being touched, I think? No real conflict.

Pulled, thanks.

Paolo

> Please pull
>
>
> The following changes since commit 11439c4635edd669ae435eec308f4ab8a08048=
08:
>
>   Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/=
kvm-s390-next-7.1-1
>
> for you to fetch changes up to 9b8e8aad5896d66005d29920cb1643076a20b172:
>
>   KVM: s390: ucontrol: Fix memslot handling (2026-04-07 17:20:42 +0200)
>
> ----------------------------------------------------------------
> - ESA nesting support
> - 4k memslots
> - LPSW/E fix
> ----------------------------------------------------------------
>
> Claudio Imbrenda (6):
>   KVM: s390: Add some useful mask macros
>   KVM: s390: Add alignment checks for hugepages
>   KVM: s390: Allow 4k granularity for memslots
>   KVM: selftests: Remove 1M alignment requirement for s390
>   KVM: s390: selftests: enable some common memory-related tests
>   KVM: s390: ucontrol: Fix memslot handling
>
> Eric Farman (4):
>   KVM: s390: only deliver service interrupt with payload
>   KVM: s390: vsie: Allow non-zarch guests
>   KVM: s390: vsie: Disable some bits when in ESA mode
>   KVM: s390: vsie: Accommodate ESA prefix pages
>
> Hendrik Brueckner (1):
>   KVM: s390: Add KVM capability for ESA mode guests
>
> Janosch Frank (1):
>   KVM: s390: Fix lpsw/e breaking event handling
>
>  Documentation/virt/kvm/api.rst                |  8 +++++
>  arch/s390/include/asm/kvm_host.h              |  1 +
>  arch/s390/include/asm/kvm_host_types.h        |  3 +-
>  arch/s390/kvm/dat.h                           |  5 +++
>  arch/s390/kvm/faultin.c                       |  2 +-
>  arch/s390/kvm/gaccess.c                       |  2 +-
>  arch/s390/kvm/gmap.c                          | 32 +++++++++++++++----
>  arch/s390/kvm/gmap.h                          |  3 +-
>  arch/s390/kvm/interrupt.c                     |  3 ++
>  arch/s390/kvm/kvm-s390.c                      | 28 ++++++++--------
>  arch/s390/kvm/kvm-s390.h                      |  5 ++-
>  arch/s390/kvm/priv.c                          |  8 +++--
>  arch/s390/kvm/vsie.c                          | 29 ++++++++++++++---
>  include/uapi/linux/kvm.h                      |  1 +
>  tools/testing/selftests/kvm/Makefile.kvm      |  9 ++----
>  tools/testing/selftests/kvm/dirty_log_test.c  |  3 --
>  .../testing/selftests/kvm/include/kvm_util.h  |  4 ---
>  .../selftests/kvm/kvm_page_table_test.c       |  3 --
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  9 +-----
>  tools/testing/selftests/kvm/lib/memstress.c   |  4 ---
>  .../selftests/kvm/pre_fault_memory_test.c     |  4 ---
>  .../selftests/kvm/set_memory_region_test.c    |  9 +-----
>  22 files changed, 102 insertions(+), 73 deletions(-)
>
> --
> 2.53.0
>

