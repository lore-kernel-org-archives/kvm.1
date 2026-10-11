Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573D2F8E90
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791690601; cv=none; b=nn5S3uIaRVz0T1L9VRq2zEJ2k0yAsmPSYkFuVfDHp6JpQMvXXPZwt+qsMvkyH5x0OehDKlEviEsBltyuq7H4i6u7hfKhybBc88FOh2NraGZM4i8BAYYorOVL2oW+nJ0lvcOlZF+gUIfx6N42e9PriCHd/DQGyjEKEG371+zMHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791690601; c=relaxed/simple;
	bh=1DpN0+D5ufXyFyAfy3uJmze4fn5FpngK55D6QJU13m0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=oKMp+AQ2qEcVHiOnFtw5S6BocSx+LLl5gTtp08qg2GKN1kxCBrRH7ZyR87NCZ6AlYF714bzOPBRhfl/JxTYSV2Q98JNREvusKnJyd/4AlXKf+5/vg/SPsyEqD2BKmEKxpM0hHu4+v1qjgCK+J47s243F5BihRH9VcWX08O+iBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqCnOtDD; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqCnOtDD"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33fb4680717so3367680eec.1
        for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791690599; x=1792295399; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=jqCnOtDDd41ZdVtH5EgO4VmolRbB6ElsyY1gyO+uqnf2mj9hAwXglyb7C/nmFNqUQI
         NB6FYIHzZDzb+qyTzoZkB5G/qaF5abxbxRTaqbum/EOrrtdd1ayQsXKP6npWGbGD5g/M
         +BevaTG/SagDHO77Dct9vndImfm1ZW0/K1YkQPBQ5Uen2wOjojgXgSFLEdWXkfzRU6si
         EjEIMr7xlOE4gMybsEd4OFwS4XNrhu9rC4+44EJKmH/xHRgiRUAuvO5yEuYiriwYssqe
         FV1ZhVFF8msauHvJ4uCchSmLomF13ZFPGa2A7p0CtFcYRzwqXB1tHn8HhXJCAAmgQJBt
         1VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791690599; x=1792295399;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=AfcBwj61U5tyE1BX0KqOKLXf9uFHsqbIB/A3XM7+9UgrjOMDcN0rPoCGZqBn5Hu6Qd
         a3/irGmSqCHrRninTw8/lxMDA2uC1GfieAWeV6yMImb5KAFQhcjOcm3fn+lDAVzDdEyy
         T4gzPTUwod9YMl52ch25ZlbRolKs7lKyje+MyUHH0tSkejC4bu0ZfA/ka8EvMcEUw47n
         brHedNAoCduSE7dJayt6vfWSdP7pAF2TZFiIe4nnA+L1DKo6pBVtzzf7WQyf2+DHpTYK
         e4Svqm/1L7rmvcqP1zKAazimu6UOPvkc1EBKIHfXJuHdQWH2MUo+Of26mfDicW5feoC/
         VA8w==
X-Forwarded-Encrypted: i=1; AKwUvBz0tfFs3HIl7FRROLR/8ekIgMwQIvIPhuBvxGP9H8aQ7ZuOeaXUO/W2sV4DWiWQgsDw5ak=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKDcmoxWx9QstdlfjCjRGYtL6N4d2SFyJ8TB5bAKIQGAzvL8rt
	eTKE0P0Jtw0QRoBx96gsJEo8cGc8yRouCz3tb0KLCi8o3mR0Gzw4fBT4
X-Gm-Gg: AYBFou2MaDjuo2h3lk/iDGB23yEzMpDh03xENoIdKkWGNFaTn/mZfJcGN7GaKGGkS90
	GolEAzF348loeXazBELiwSF/AYkIQTkslRVx+x99idZbaLFJLa0Kt91OQY3Rfw1KNGavoHt3CnO
	1BbjFPOblnXfONr+92B2Sai7cJg7R1mZB/HxTov/6RhTEVwkuIeQIre1XeB3XT6YzBhGEDPCNaR
	bl26YudYRDvSPNNCNEpy/9YdBzDHPrBsK2uOf7CZFpuhliazSZGFOeFkmaPh6x3Kvw/rXSbMLK0
	s1u368SyTH2f+S4kBmGKa79HMxPoAGhxt7HOvfcFMCUAnOm9gaFjFvEC1y6FC1JvA2v4S1Qkn+j
	8P2AxPcvqBtAMAJ9zQtILpGwLu+9tTNavxcvD5qB/LrVF3oDRZyJi88l6mUi1EzTJX4VbAYQJtc
	ot1qIvMaaZWlr9VsL6Riy2xCoIM0qxH45F7VKVbLM7WdjkGgRue8Bt7cG7EV2EiUzWp4en
X-Received: by 2002:a05:7300:2442:b0:351:39db:42db with SMTP id 5a478bee46e88-3537dfe388fmr8395787eec.20.1791690598985;
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm7430579eec.31.2026.10.10.20.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, 
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
In-Reply-To: <20261009123035.157770-2-gautam@linux.ibm.com>
Date: Sun, 11 Oct 2026 08:47:35 +0530
Message-ID: <zewlq628.ritesh.list@gmail.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com> <20261009123035.157770-2-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
> According to the documentation [1], the caller should provide their own
> locking to prevent concurrent modifications to the idr to prevent bugs.
>
> Wrap the call to __prealloc_nested() in	a spinlock to prevent concurrent
> modifications to idr.
>

This looks to be the leftover of previous implementation. IMO, the
commit msg needs fixing.

How about this?

Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
According to the documentation [1], the caller should provide their own
locking to prevent concurrent modifications to the idr to prevent bugs.

Now __prealloc_nested() calls idr_alloc() with GFP_KERNEL which can
sleep and mmu_lock is a spinlock. So idr_alloc() cannot be moved under
mmu_lock. In such cases the idr Documentation says:
    If you need to take a lock while allocating a new ID from the IDR,
    you may need to pass a restrictive set of GFP flags, which can lead
    to the IDR being unable to allocate memory.  To work around this,
    you can call idr_preload() before taking the lock, and then
    idr_preload_end() after the allocation.

Hence preload the idr memory with idr_preload() before taking mmu_lock,
which allows us to use idr_alloc(..., GFP_NOWAIT) under the spinlock.

This also allows to kill __prealloc_nested() and __add_nested(), as they
are not needed anymore with idr_preload().

[1]: lib/idr.c
<...>

> [1]: lib/idr.c
>
> Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
> Cc: stable@vger.kernel.org # 5.19+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Otherwise LGTM. Thanks for taking it ahead and validating this.

-ritesh
