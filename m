Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D363644C1
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472186; cv=pass; b=hA0Q1QsUP1wmO2YiKbL+eyq245CTxKAupz/881Eztb1cAK2/dgiDiLlzZacLxVlvfg3wyS+NKglpU/rsQJFvUxgo/Q6A4VHGUU0f7gjMaeZwJyU8ed7PO3zJsBXFsQlL75zl4oSCrqmpD+/gky3f5K0uvpuZ+JpdaOA5KOD5ZuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472186; c=relaxed/simple;
	bh=9GcYQllOiOXdCXYyDijNgD+Nq8QRy6N8WRrmbHFTS6g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay3FBs/vGWAk+e2/Ehv1FaMQ9iHn+wxvZ4e4sKqE/U8kKNcQQrp4gYCeGaTzppW4se9knkbjFBR8nZFJ+lRHqq9Z/U342prd/FaGkyYq3n5vQioIcW/Z+ykuq7j+SZvXczo/uY7wX2nA4bZcCwnnz8ml0v0j3CxBp3QB4JIFT0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EDwb0hbz; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EDwb0hbz"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso2566078241.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779472182; cv=none;
        d=google.com; s=arc-20240605;
        b=X66hxlQ2OL1JYKy20UPA6L81ksRN6GFIOJCAbt6FsWqd5+XX31ZQVe1VrHV9nkiULw
         lRMZRrE5vXbwtb3g9qG6MmCXX10O6j5LznYpRMShvDg4l0sxdnWSrTy0r2wiVEiMNH2C
         S1hhox7YQO9FGEeK6TBV0qMPgywPLemzlobzpgWQhkGQydXgzAhTK2dQu9ckN7vW29RU
         izd8c7IPkj+K/+6XDuLzvWbYaCo+F1G1SpbI3vos/k/xHTAoOxwHr/UDFW+M8OJKAml9
         fMD23OTBVf3XAvEtmKRSC7C2rZiYmUss0UseGr1PfjVWiZo30Ert2FzCz4XZn3F7AlhM
         zTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FVdH+GINBIrgjBx6PgyXtUorNJPxdnp5KA8JCKORs1o=;
        fh=mVakCq5KCWjzjBALrwiILUxswrLR3rjQnAUkl3LFTs0=;
        b=CI278nKU9LGIxH2rNcYIhlFsIF0j5Ot93cKkoFwhWY7N9jxaJeA4WXCzKNFZ3gi/2e
         MTDvHwXb5O7e2zQ+YV7aZrt1HOrc95EOqpleY4ZyXYWqsxJH1UIO5QtAAILQA6+mRRzp
         44+IsXKnJP2yyo+4ThJ0OnNurJhTz7bexmGqx8M9O6W0z6snytvxWcTkTmzY4E88VWG7
         h9tLihajnUvu6fgmq7Jg/+6x7NUzm7zSo2R9p91dKKgrqv5XCP/an9EENQHikv1wYJBD
         DNLckAqRw+vkhQ7eSwc/zwME/HujWBrR0KAVLRqWCMsuhZO0XZFNU20+TPj5e2c/8et2
         zbzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779472182; x=1780076982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVdH+GINBIrgjBx6PgyXtUorNJPxdnp5KA8JCKORs1o=;
        b=EDwb0hbz5ojN9+wvr3Kw1OIzXGyguQqEg6KQaHde5S1fmnPS9iO1SBwotxPgSD5ZQ+
         rXfJ5QVddocKEf+1zObHdJZ+VBgcr6ZhTVyGn+nnKBV7sB3AAxRi0BfY3npY5r1nTiEi
         2wwPP2UjDcppVIDcxqraRg481En1C++vm2KCOf7Z3LedeImOUyjRhCtSP8DsjtkgySzH
         DXF4HGJkwtgUfUbfVbjWiCX2iJbbdTdf6uYAJelYhTcB2dvsAivJk7n3WjE9lB29WCb5
         8GwV3/fPKphvbXQgbv9vv22Z9NBJJUFPKPoTjLWc0E1uIB9g5k+m8gEVmNv6ZkUam38g
         rnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779472182; x=1780076982;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVdH+GINBIrgjBx6PgyXtUorNJPxdnp5KA8JCKORs1o=;
        b=QcR2NZvgBSahdiOLQnYhyZbKo3nEkbEWiMgRTWckecf2HZt1XBGdtN1+unm1WFkwEv
         skM3Rj8CGuTmvgZczmqFi2HdBKQt962+FxF6MjQUhaJQ6TtsPa58r77BLSAHaaxL+vs6
         3+SPe17nC78iUwW6oDf8nlv8wG4HQulXXWYtFnJKlHijFam+FZxEpSLX1q09Jsr2Kjcz
         7TRQw88MlyokpnwYLvnp14mLwhkbDnfFDoGa3Ih6yB0DgemS4XkWcGIg775MQrhNxaHx
         BzLkdx2Pc+BGq+ykomKS/+tfxB3B9oKjYca8opPYzVhuj8WlF5T5D3byyhbHy1fDr7jX
         KwCg==
X-Gm-Message-State: AOJu0YzMVwA9/5M+xK25ZhTqY0d06miUP7p9de7zrIOvdOpz/WCgsoEH
	qwTgKzDhgXYrzL2xCykKLA4xIoZsQEhQxKQmbvWTVHeP97aeJscCHudTA/ZcAzhUy20cVZUeIOT
	yO/BxkeJx648EFdUvGzEnVmLOKQUgux/N/HmqDh29
X-Gm-Gg: Acq92OG3IxMgRLLCLIIPStTxGHlFqTmCqL2lJeqJjVNOnaC8rR7Y9NRE5CpiY8ZzjTW
	fnJ+0AOx/BlmEjlekoeiTkUy43GT/QaenQTwfvfeLYyqwPRdcIN3H7cwPSIv30xU7ZPv7wzFcIe
	5mHPJR4In4L4dwebWR6jtp5X9j0eVKVs4ZbEwSL8D7YUjKKGZgj7PoSZHMK2P4q/xaQH6NjDDTg
	ucWinYvKUfHkfo0opQNVdD30Wi1N9QqoorYeXV3dh5EgQilJP/wwUCdAMefCZvEFnpJWpZdm/Ik
	5G6KgKD/TN1oQrdJx5uQ5qpFV5/Qo2tu3dOjR83R09kISfBy16r9hVG/ipzRDo4cpNlWYDNb4Uc
	tvJOt+2pBh4wmmEI=
X-Received: by 2002:a05:6102:304d:b0:639:4bb7:c922 with SMTP id
 ada2fe7eead31-67c8a075a9bmr2660069137.15.1779472181171; Fri, 22 May 2026
 10:49:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:49:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 10:49:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260522171535.3525890-2-seanjc@google.com>
References: <20260522171535.3525890-1-seanjc@google.com> <20260522171535.3525890-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 10:49:40 -0700
X-Gm-Features: AVHnY4LuZYRAS0FDuOxAwzv68OZS0CdPGN-j3m1-yuSIDvGSzm6OlLlXqCbSqho
Message-ID: <CAEvNRgH6Hud+T0OWO3EfDXSjE2H8j=KiJ9sUCHtbzf3fW7jtkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Cast guest_memfd fd to a signed int
 when checking for >= 0
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> When conditionally closing a memory region's guest_memfd file descriptor,
> cast the field to a signed it so that negative values are correctly
> detected.  Because selftests reuse "struct kvm_userspace_memory_region2"
> instead of providing custom storage, they pick up the kernel uAPI's __u32
> definition of the file descriptor, not the more common "int" definition,
> e.g. that's used for userspace_mem_region.fd.
>

I wonder if the better way to handle this would be to have a clearer
userspace_mem_region vs memslot separation, where only the final
function actually making the SET_MEMORY_ATTRIBUTES ioctl builds the
struct and passes it to the ioctl. userspace_mem_region should store
userspace-facing or userspace-specific parameters.

Anyway this is the faster fix :)

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> Fixes: bb2968ad6c33 ("KVM: selftests: Add support for creating private memslots")
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Closes: https://lore.kernel.org/all/20260508015013.4108345-1-maobibo@loongson.cn
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e08967ef7b7b..4ad015c6c44f 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>  		kvm_munmap(region->mmap_alias, region->mmap_size);
>  		close(region->fd);
>  	}
> -	if (region->region.guest_memfd >= 0)
> +	if ((int)region->region.guest_memfd >= 0)
>  		close(region->region.guest_memfd);
>
>  	free(region);
> --
> 2.54.0.794.g4f17f83d09-goog
