Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B22BEFEF
	for <kvm@vger.kernel.org>; Sat,  1 Aug 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573370; cv=pass; b=rRS837F9ICjhBS2eTuyHo+cx01BvMi7uKKf1LtPmKBIZwRtKodHHbNcC9/tCDSixNM6QgwXMZU66AHZfGqFyLEEWGeoeCGiSTVxaV//DzTvMc4LVxRW0ey2xqNJL2/u3AjaLR3XsX34JxgPVtBlJGxV00gzPBmNJFNlOyrfNudw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573370; c=relaxed/simple;
	bh=D4HT5rkk4Ok2q40FOmCgxgsTTux7Eb6NzU9OGses0Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZ4rYzFbdtWA//ANLwv5eukJ6Zs5WMLbgnpCxPkRRqNdJsBQiI6C63rhuxNjGdtrq6rdJt8IK9DFIah8nscdPZoHzy/dFMJwwyC18FZu+TP0q+iMY+bXMZXyYwAuCgI+11UHBxqns/ubQ2Uxr9kKbYvS+m4g9g24n/wzxhLjWWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=IfOpVXzA; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="IfOpVXzA"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b29599b81cso2435754e87.1
        for <kvm@vger.kernel.org>; Sat, 01 Aug 2026 01:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785573367; cv=none;
        d=google.com; s=arc-20260327;
        b=h9PqYZW4LmFfrn/SZH5ajvmbb32vP1f1Qd8sRloOCd4hF+jiEKtK+CB9pY+fEmYRxx
         WH+hMKAc930WciY0regtmA8NY9zg43tAEq0/O+nalRVLttn4BhCBbzMJrIRf1fNXWhSW
         jG9LFAjJUJ55U1vH0GB+ELV8CFr+jrPK2HvJpMB14UJPs9hKLmVpqbVfFOkjNNqc9K/9
         D/qY67TrteH0OoEmwWL7v684tuxdpCvShIkfVUpLBBZXVWnAapU7ifc+Mpq89hzZ9EkL
         m+Vho7XulaxE2kPAK5T69i2Iifdi50ii0oB1NyfMLsiA5L5PcV4XPo1wYBPFudncI/Ha
         VtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oN+sLPJRs7U6ubaCblfaryc964dsGbRviBowu4xGE9o=;
        fh=TqkDo7HJm6C2bTHYqbzn7b/i6oYTm+CMOZGiIKAd8p4=;
        b=mIPEQKLwDaIJZLpxGcvJ7TJPCm9Smjbp0XXJT81+QfzFbAu6RrTrEOwlZSe6Ut7bz/
         XjikIkebuhjh9U8xhiYlOLJDboDN5eqKkH6ZacZbGSkCzZJ7/tvXgQuiQD7v/ZIxVtgT
         22jMaKnzIKs/Mcf31qCBWP7t+1eC8oxYKNqHYTDY3hXjme1Em7EpGq1npu1IeKCAHITA
         lC4iR2S3kM1m/yuLxr4uPb39mxftTKofMcGUsB9zHIDm8fGiRcWmSL1VdVwRrqJ7vqpE
         aWBzvnKeUmZDlJYzx56D57RR5+zi13VnbBUfUoh0GpgOL22pHEsvC6ieDasSUeBKUnV4
         D89w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785573367; x=1786178167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oN+sLPJRs7U6ubaCblfaryc964dsGbRviBowu4xGE9o=;
        b=IfOpVXzAY0NpwLDXPqQ6WFfg47KsL2cnbcXUqOHj76kmpPOAtgY3Rg1Xbc3tkq8Qz1
         sA4bgXsqEeDpPVTnIJN26/fXqOlKLXakpCUZjxbkvMNJClTqpwRWOaSi3gFwP/Qk2z9E
         WN67mujYRZr8m+x6mhLFs+dZl9qLYz8LgzYcht3AfLPqQEYJEj/jBsQ5DUq8Fmme+jcG
         3DY/OOKgvsUt40eAlbilRxAoTFVf4GAPkUGidvl75c7wDSGEaaitvolsBAGeqrgLXzfb
         Gx5L7Ztr/dIdvyX3t+ilDvSE3jYnYPp8Q5QAAv67D2B/hdbIjI54A2RgbmKA7cy1aTCv
         f1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785573367; x=1786178167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oN+sLPJRs7U6ubaCblfaryc964dsGbRviBowu4xGE9o=;
        b=S6qfx26pXNISj/jiqJ0ecENU7WpDx2o1iJ4gGq49VLAxjFgEaJhE34dEu+qwOD+RUv
         YBTzUHnBDcmnYqTlHH1pubNRvVF067eexd9FNnZwm+sFXRCBvoT2mRPObLClmDhTfN9+
         dWWcFaL+Kf7TBJ2KtjIhSKjpI78lQ6r66y6VDYoRdwMnFjr6U1LAV32wuvM4ZWZ7DPhf
         a6NOm1lsrUa+RVWfRCXiQ7HuaNym/0GQJdVz9PrhtRtsrFCrv3kAhaRNvmYT/tvC8S7H
         2pJ3i5PKXQ9HOaeeTLQn/Oes0EXRubPUIC+yPr67d9xBLNZKIuaC70Hwlb5dwqAU3Lk3
         o/KQ==
X-Gm-Message-State: AOJu0YzDoh/gikfnGDfNZTMAqhQDJZRsQMjQXR4BIIWupmrbisMU65iB
	YforiBJX5yJpMSeS0Y1SB64LphaDtjyNOOW8YRT1IyZypUNiMBrZcD/RbBaE+SIjmKK1/Xjg+hc
	Mc7WJoBH5MYKqFtKmnr04IUP8usLUJpie3H2Zpz2Kyg==
X-Gm-Gg: AR+sD13tSZrCaqUZouhQPIds2SJ1I9N8wQ6mOyiN0VBNGVhe8WZ3z3E/Zs7QaICit2X
	qpjqxtgTjErmJW891UaU8IyiI0uLzwqz3VTX51SjB459YLqwxLSf2Yl7Jag3Ef5goZKvDBcD+hF
	NktgNg/G1jsx0c2dICBEKZ3i5r4X4E8wjVXNB/QfbpotkmpLxSrUsdpuRA94OcO9aqHApBpbJN1
	8Zav6Bg1rSWVqh3w3BGTbcd/J2xCjG5tvKA7FfaTeWQ0O8L8fjjJC3ZVqDAeUiK0NNjmdHaWNMW
	h+J/xbQZPX/xLW6eykfkqzq6ouBTD/LDoMhOwkCYA+BWkjWbmjdSDhqwHHCw0q/hBP2jjfq8Acs
	UlwVq0j7wNczcQNoAzPashSIIUb8PdFWkorE3K8+39AqbbaisRLlFseq+S0fO+3ND
X-Received: by 2002:a05:6512:6889:20b0:5ae:b764:3ba5 with SMTP id
 2adb3069b0e04-5b2e4f9c50amr288278e87.64.1785573366525; Sat, 01 Aug 2026
 01:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731093833.1551341-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20260731093833.1551341-1-wang.yechao255@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Sat, 1 Aug 2026 14:05:52 +0530
X-Gm-Features: AUfX_mxBMP70jLpvU1dCTqR-waeQ9HTBiOZcnjCyTgyRTSVEjpFRKArAdatF0Gk
Message-ID: <CAAhSdy17xH1D7RpGnqJubqax_hTQaKpRu5g0tSDd2U6Rx71V9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] RISC-V: KVM: Optimize hfence request handling for
 SMP guests
To: Wang Yechao <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:11=E2=80=AFPM Wang Yechao <wang.yechao255@zte.com=
.cn> wrote:
>
> This series improves the hfence request handling in RISC-V KVM,
> targeting scenarios where multiple VCPUs are running an SMP guest.
>
> The first patch Introduce make_xfence_request_nodata for FENCE.I
> requests and moves the hfence data/type validation out of the
> VCPU loop to avoid redundant checks on every iteration.
>
> The second patch fixes a more subtle performance issue: when one
> VCPU's hfence queue becomes full and triggers a fallback, the
> current code applies the fallback to all VCPUs indiscriminately.
> This unnecessarily degrades healthy VCPUs and can cause their
> queues to fill up prematurely due to lack of processing it.
>
> With these changes, fallback is applied only to the VCPUs that
> actually need it, preserving the efficiency of the normal path
> for others.
>
> Changes in v3:
>  - Re-order the PATCH1 and PATCH2, let the fix PATCH as first patch.
>  - Link to v2:
>  https://lore.kernel.org/kvm-riscv/20260707125034.416521-1-wang.yechao255=
@zte.com.cn/
>
> Changes in v2:
>  - Fix the patch01 broken the KVM_REQ_FENCE_I request(Sashiko AI review).
>
>  - Link to v1:
>  https://lore.kernel.org/linux-riscv/20260707113715.413265-1-wang.yechao2=
55@zte.com.cn/
>
> Wang Yechao (2):
>   RISC-V: KVM: Separate req and fallback_req masks in
>     make_xfence_request
>   RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
>
>  arch/riscv/kvm/tlb.c | 46 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> --
> 2.39.3
>

Queued this series for Linux-7.3

Thanks,
Anup
