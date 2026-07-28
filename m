Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959011DE2A5
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198914; cv=pass; b=K1APrfk3IeGHM50N1WnA+pnuEX1TnEjXuiiNHqeI0CATUDlAhUJ+xxZ6JunOibE+m/zn2zRN57WUfsMC/wh6yhtRPKqgEeoc9/o8ABSwfbb+QKm3J3kXFYxlKhZF47R6N3jK1BJhm90YiuVv3wOuWtVj235/S7VJ8TcVQvTtiw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198914; c=relaxed/simple;
	bh=c7elslAKfp51+QyvlqEzHSwTp3c3scsM3RZll4rhp/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sByzzH5OQwQNL2zgelFN0qcSkswR7cP03NUx7iBmqSkpvGMHnbbdJ+in53tBCYvf3OsumYb2dthT5ZQruwxP1/rwkCH+QDWpIgyLm2ShuKcbp4fp8I4M+ODflaM1fc6peYudpxToMdm38X6Oq9dpne4ejpVd0pOL26UIVn8WzbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OuGo6Fff; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OuGo6Fff"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so4919108a12.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785198912; cv=none;
        d=google.com; s=arc-20260327;
        b=ViCu8MWOQu8Daf9STzvwHgpbGDRzIOn61Ykrvi3ZD8Wjw4Lxf8VqfF1XnAAujTHFlE
         bIa0iRArSRNw4YtCP5yXDKrvRsV/Ho0RJXHeYKFr3n0pjqUaUg5FErFfuyrhXsiSEMKm
         bhAAliy5iapk+jhfy9Sj71FTLEGrfnfwi8GyhWtxy5jBXBCgfiKOkLPOmSbHBZpkys93
         S2+pt7AUCs0TSZKwl+X2xua4GI7/nX7MsxPPrT5mUt1ScMYbZ+WbuYW8aPorzq1uSb+4
         OekXWmHLIGV9OToK1xhHoB5t8Pfuk/Yc/GZFdIsWrXJ8xXfK7g3yFIO7W2LfX5cQtjFK
         G8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUBaP3gqsbL9Mq7Cq3u6Q4ragspqXmhpMiQu/u/OyTE=;
        fh=yIep5pdGeM6vlPNOZHEfURGrXN1UjgPnc2zZIWfAvx4=;
        b=HaR8C+Fj4fApeBcTegzNz5OoTF8ypNvYQYns8LerVCVb3adA28d6bBeFt8knQkg0zK
         0vGTg8cQVCWz9oQHxzWeWo40wJUo8eCaMYjirXSM7ia9u7urHJltPN3ZoHjuRAIvSpDQ
         xL7HWzXRjaFsi0MJQsne/mnyL+59KsJqnkv87XwYaOuGK23E4D71V+lhRGHg1mWtanlA
         czISO5lozV6Mq+98uI+FEEpQCoIQA+DhxrwifVZ8s9abAf/I06Ffx3ukq0TLVKcTfNne
         LUK+upXm8lqjEhi2y8M8eolpqRioL1hKRzh+35jZJ+NSRQM09QT2I4lp7Jpa8xyDOHUc
         UN3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785198912; x=1785803712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUBaP3gqsbL9Mq7Cq3u6Q4ragspqXmhpMiQu/u/OyTE=;
        b=OuGo6Fffxbdq5GIz+ZFhtLonQHyGWyCGnArL9HrHSnpDUW/zJi306LygQ1eeujRSM3
         s1TpJ5A7fL+2E14/OxspUoTOM8mx/bPm/5Rm+3FOdAHA4sspg1aQOLohA8NgfR564LjK
         gyUSbHSArFQJesmVaB+bu9OHXpyCpbHeb7HgYLufw/GKe9ZeEcyaupNGyicA9GUfvonG
         BFrWhCwqBneLd/bE7s6/D8H7SnWyYilaOB8sY3g7i7R4lbeb16kFR6+onVqJn4NuKEEc
         DyG8eqykxTHNqIHCam6D4ZleSirRAXHm43q/EQcoj+HkEh7LuCpNhfP+w4aWzgYbPcZj
         4l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785198912; x=1785803712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUBaP3gqsbL9Mq7Cq3u6Q4ragspqXmhpMiQu/u/OyTE=;
        b=hNilIdlNKs3GYGzvxooPCHRgZFZlqJMS9WU+uOBwUmjHIc4DfyWWlRzp0x1wgvrkK9
         0oSk7ZklMQ8AgzNHYjolegGstRfT8hleO9R5QYhqQt31g2wkvfF9tekzbd86TE09b0CV
         ZqYUNsOhhfAg1D/frPXZy4HC+9pWAUlRkzi+fbcRSrB2U/lEiECtzed1eonMhKUX3jOl
         CF0j9VQdoLNZxr+Jlc5H+7dlrB2Ajaw9vJCbVO9rzdnQObCFjbQeTD3WTuxFggy+/MdD
         nMwajlighCgH75VkqYG8asnu7rZQN3LSl/xz6DGNzgBYG5XBVeXI5ISPvpHQ7R1GN7OS
         DQyQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBLrPPqbBNsiSozD9pn1w1BbVLi5FYlEk+aTkck+lAbWw3Y4N3+tx6JKKzuyDQQkT5ecM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEiUl2Qgeph012J7dZjtaEckniQJunq3cjumLeLAGoZISXRs6
	kqM79PIjxhnga2K8Yp9JTFuGKbWT0EiegO4rbyJaNadV/dii81zk6gF+cXWQC0LIEAlzOm6EqY0
	WbuhHoEfNQfrffooxh1tpoeGY0SKOL98qPjcSTJG5
X-Gm-Gg: AR+sD13bSQBTmzKus7wxv7UbGeCw99qgIDfhjmN+Vl58z0N0H4TDkB+Hp1LJI6Wfv4V
	6EHPzvIr2dzdWLAJH612y93YtOhNS3ejYQvvVGxzNhgYAhhMSdVL6d0J0p2cx3V4q3YG05sZObc
	E44nAiMXhalFQ8qKZ7VDDHtDYQRevpLd4d1/9ahu+B0Sj67OxjUsdFb1uLlx6LVjbS1UsHJYlK4
	B2zDiFpHmsLJRx/h4E01GPEFs9CBT3agYZ0PcaiEMV27sNI1m1bDiqm/AN9NyDbZWwphmRbWXkQ
	nN3W25ppfd4MnMcKTqVbHzhLKporgXHfHM5L5+cGuJrsZFDA/bvYAeLsydc=
X-Received: by 2002:a17:907:d28:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c1f720c6126mr5018366b.21.1785198911384; Mon, 27 Jul 2026
 17:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728002236.869865-1-seanjc@google.com> <20260728002236.869865-3-seanjc@google.com>
In-Reply-To: <20260728002236.869865-3-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 27 Jul 2026 17:34:34 -0700
X-Gm-Features: AUfX_mzi-l_v-Rd9a_ewKge5wZz1oU_vWexjsibksmqh-2n5maA12JMD8OZ-R4o
Message-ID: <CADrL8HWRuzmABm+_W7Xm14CdhT3R-y-QZBhDqq1Wh6bcw421Rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Use CMPXCHG when clearing Accessed bit
 in the shadow MMU
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:23=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Use CMPXCHG instead of clear_bit(), which currently emits a LOCK BTR sinc=
e
> the to-be-cleared bit isn't a compiled-time constant, when aging SPTEs in
> the shadow MMU to align with the approach taken by the TDP MMU, and becau=
se
> using CMPXCHG is far more robust against bugs in KVM.  E.g. if the SPTE i=
s
> somehow no longer an SPTE due to a KVM bug, CMPXCHG will fail gracefully,
> whereas clear_bit() would potentially corrupt/clobber memory.
>
> Clearing the Accessed bit without atomically ensuring the SPTE is still t=
he
> old SPTE is "fine", as holding the rmap's lock ensures zapping the old SP=
TE
> can't fully complete, which in turn ensures a new, different SPTE can't b=
e
> installed.  But that chain of logic isn't exactly obvious, and there's ze=
ro
> reason to avoid CMPXCHG as its cost on modern hardware is within ~1-2 uop=
s
> of LOCK BTR (and may even be cheaper on some microarchitectures).  Doing =
a
> 64-bit CMPXCHG on 32-bit kernels does requires a more expensive CMPXCHG8B=
,
> but 32-bit KVM is all but dead at this point.
>
> Cc: James Houghton <jthoughton@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>
