Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B56264617
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070775; cv=none; b=n3Sx6a6QnG22FAcg2cCiLYMcB8KmpwVAwB7SmAc5g3SO0RnRi2vY0YVzyGJeLB9VOjOcSkuVQ0qMgLclCgZw3U34L5ar0Vw+5Ta4lLAsY+4XYNZGJfMxhqjfx7RQtkjvxsBoD1gfinF6dns+cITZJIMKFi75RUc44rOKACT8aPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070775; c=relaxed/simple;
	bh=f2FGYzER/1NSdCgQbZhD8ESSlUAXZ2pKt8ApCgQs+WM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NxW4YjOCe24KWKdoKTZoxjTGRHjZ18YA3uYHiEh8UhDrFVwv7oT97tDMPMjn6M3G0sFeBgRZjENRrLfb3gQeYqjfzurcmgSEjnCYprvHz1zFZtb9D8agQIVngCwtyKG5J9wGVHFw+z2yp4yZjaHDcP2WWGX8dEdjEsA+UTJ9ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH7tK+h/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH7tK+h/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so1827825a91.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070773; x=1774675573; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=JH7tK+h/GCvkqOclAJkfhMrLNnUCbGlurtpgwVAkbGKK1NNBHm/oQF8C9109HRu/Ia
         3BTmoFxQJbFkT+enKgHAOzANjHQiFAZviYmTO0k2QqiYuqFM67QIlEM08gSLWXHpVwiy
         GP9l1KjNgOIxnxJnDjDskejG3KU4jeMD5e9nfnpjUkITnG19hhmo2W3tMba61Ri4aPu+
         Da3f3TrARpDb1fYTV8OQdBnpCOgZOgWi7gcUqVd8XQZy/DpbZJV4jaucgDsajmYM48cE
         euMZjG2x+AmEgpquGjThFs6H9mo0BeJ7a9o0fkchP635trdPdJvjzEt+7o8vWw+5iAVl
         Qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070773; x=1774675573;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=s9ElIk5j0guZdAsdfwUcR7pom9XMQrZ2HNyeXbre9fytpmebxShH8ixt7YZdPOnBo4
         Q+95gw3ciKt0zAL/JjOsoEO+raE5U8yzITkYjGTfOSYm5bghgXHqwnrGyLN0MgtlewN5
         jshKrxVkCagQRD9SNVyzJ+qpOW09DHXqGPlpJw3/P7bwqyTEjRucqHHiAEHoDIDFVwOb
         cSLBIgruvTvsf1+TUtkP0QmX2WnO/FMqBlrwtdLae+wYPwUNZVMm/wKX9q7+6bRaPBfc
         +46zNeA4nAC/aCMBPDuGwQStJd3/XFEEtIuW/fi+2c55tosozoINRHn/KrXbe0GKDGyj
         eH+w==
X-Forwarded-Encrypted: i=1; AJvYcCWl7pga8X0YdEpibrNKrsEXih7/zgfOBI/ToHcjM5uNaQJiQ9FqXAhv6J4e9yTZcYfEaxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfqvlu2Caf6w09P5jGyzZuwcGfM5Fss35HKBeErRgMdFirm3v
	IEeVZdzkvTqKFyMG6jarJwrA95i7xkvbPT6x5d3jyynVSxfUjdEvu90l
X-Gm-Gg: ATEYQzyFhD85ixGnt/+elj9mlCWRt7rCFEqPb9fT6dpOEMwi5PDIVWFbVq4j1uuyfGk
	LpLOHKEkfupdOyu35wq95la+VQi2ijHyIpYWdASiam8q9dFJhAxMgmB/YJfNuzbz06+w0DiaPj9
	i0FB4x2Dt+84TO2LWW08QWCo78tEfO4J74rqVnx9OcByljLPzC3XtJM5ctQX4lRyuzQ9REagfEf
	oMBs0llzQ76LlaVRW6UbqKh9qiH6ulePvFDXNS57ngS98BfzCGy0NuX7o/tVRn6mHhrSc1llGay
	D7kcbEIGZmNOJASVkttmLLL/eWxcju8cm8XXzwCEgfJ+6goTNfVtZVAS7RjzxwEASjPPvyXp+Z4
	ywgdAfD1GYo8+fQZEs5BtZ/8Kf+8cSy/KNwtXMndNMZ0ohEriWOC8fFCqthhz4NuYdb1EefbzvS
	yqfqYM82PSFwNDKgnmFI7++g==
X-Received: by 2002:a17:90b:510a:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bd2bd5ceamr4620697a91.1.1774070772650;
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd41347f0sm3299371a91.17.2026.03.20.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: change to return bool for pmdp_test_and_clear_young()
In-Reply-To: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 10:54:05 +0530
Message-ID: <ecldycui.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use pmdp_test_and_clear_young() to clear the young flag and check
> whether it was set for this PMD entry. Change the return type to bool to
> make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  2 +-
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  include/linux/pgtable.h                      | 19 +++++++++----------
>  8 files changed, 27 insertions(+), 28 deletions(-)
>

LGTM. Please feel free to add:
(assuming you will anyway kill the unwanted externs)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
