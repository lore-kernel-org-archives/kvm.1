Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10B442B10
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673333; cv=pass; b=JiNfeZFb7kgIQKukuB950W2VgU+D28U2nhW70wAE+3v9SP1cqU7oU7BElXKTTucSe+loHo0BKZr0R2CKvePS9FaLNRlWnCi23PjBD0LJTi8DmbvqaMGNjsGRkI8lyN8aZKkATrSJhfd+jEsqkBbSt8bl8jX86RfLi4nKmojQYtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673333; c=relaxed/simple;
	bh=lZYaNZxGUeZtEwcQ9OqEG/mF74IaJpelEmtq22X5r0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFTw0lCwHvXmBCaiIi7I8oOn9aaHk8wRW5C2qOQGWgXs4DhgIOw0MIwhraClClv48KD3C1hs5m5JmTgOnhRn4XCQtCJssJFESjyAls3gY95B21AcNeMAeZjf3HwDk0WxYz77GmJJd7UBKMYdiBTRsQsQiavp7uaEjRTlb8xh8Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzLE/a0e; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzLE/a0e"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso1622729a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 08:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787673330; cv=none;
        d=google.com; s=arc-20260327;
        b=RoCjUAiTAih6P1J0JpjgIpDavW8vMY+RLa7WgQZSfGoTSY3izA4bIYuEGMaGllaRw9
         /HsBxCFa7MwSSY0yfF8LZLBX+EYwAloa5xVRY1VTZ2t+3K0JOzkjIHny87hQ0dZV3v+7
         v+YTy/B0+QtOyCrO7y9YT3U7RMjUmCBcWtp1mFJJpyHOFWaJNS1qjW4xQbM7KVsVGuzz
         JNQ7eN4BPEIZcJREbWeMn9X5DLhCE1kP2zYYDYBlWT+G/4ArqZIeVlj79le48d7tbkVq
         SMSLaKO8npoCvuVXIK1a6Rr3gfiN8TLvjEKdPu9Spq2Uq9RRGj292OX5MEmigjRV8nEQ
         at/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WVg4RBOOkdPHq9qUxxfmmgqRr5tn34gYzk95c9wuG68=;
        fh=Fe2k8q5X5uD4PkqrB0dwn2RVnhebv8BVHY1NH5z37ZU=;
        b=DCuoS4j1UuqNDzzanrFg+Iw8jc1kgr9oqKMe/JzWOscob1x7vKxVrdVB+AUGXoxIlS
         LHP4alriVIawnGGQt7gcVsygoP6XHeeavmnA7Qte4JV50eStO4sIqebpOJzU7jMdpnDw
         UNEbfvMYTRYyj0YyIgm482F/AMtHFST9H1pQatODBN4Kn52MHqmvcqa04gYh/sS66ef7
         bd/5UThlUzADFnExXToyZ55gADuT3PR8lPkemTdmBzF5xrSXiaIfLlsGgheVuIowuIz0
         AFnU2oN3/cTMmqZBfEBx4n/O5Ykn2g1fVnRQD3pWyqE63djbq+qHmE9Vi2Meuub8ji/E
         hQAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787673330; x=1788278130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WVg4RBOOkdPHq9qUxxfmmgqRr5tn34gYzk95c9wuG68=;
        b=hzLE/a0ee5i/6y21wlWSUAAFc9/P8Q1T5P5pRBrP1VYfaIQwG8Vh7grVd5WzpQFjxl
         Q4SohkTA241eKiJVR1BGxjKYupLjYGrkLUh2pGCbkFC0YHoioj8zSuf1zw+dgsbuSEpH
         EsYKdsautPhptZYQPsC9TjgKPiPiUiX+SfPGsxEVbKWYZ+E6Ug6x5dKKinOHNW91sO7D
         dGqqGyT+bCitLcwgIUb9PFRBF94Z6NRbtTHpzNWwUjxqbhfz/BVgJHCb73Uvr+DVxfRt
         wQDedHF51CEV+Nuc+IFZGvUlNK9v6elAXeXcZh5LRr9juAmkT3wMSdyEmh1O6zln6ga8
         2plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673330; x=1788278130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WVg4RBOOkdPHq9qUxxfmmgqRr5tn34gYzk95c9wuG68=;
        b=g8ghBFIVok9T+zJUeSESLYClpygS7wcJVb09t+3Iq/lpNKtMVTg/Kcs7M5opd5YKE2
         5m/tSZkOrf4pU8hPaFO40rHzsqxSl1D/n37HmGG6/Hbbg5jnQZvE0jk4RxDr2c5VrWS1
         YMaxWn5ulHnWT5a1hPCfArco2LPgxFYxdM7LgfZn2o6gI2NgNManj9dExun2XLtQvFYD
         pLS9lHeNUq+Mvs2TOIz1RajClp+SrTCae23JEEGjxd3wyewMlgfemkOijsk7EeGzg2i7
         1F8EpeJicgOzcVlEZx/LfuM5U+HpyZD5vJo0rJhywGoNWw2hYtYnKX7Y8cVvX9PALaEc
         y1dg==
X-Forwarded-Encrypted: i=1; AHgh+RqTLD2ZgHIDHRL91RZGLGPsM+hmXUeVPF5/RJXgg0ez2CTWgBXzRV2M0U88PjXjtT/KR5k=@vger.kernel.org
X-Gm-Message-State: AFuF++mHOfqx/e/dnrn5z4bXm/Lsci47cdQ2CdXkno7F8XJYpi/f1W+E
	MBpCR/VoKXwVcln2fxmrzB5AuqX+au/Z/MszjK8uabdA7Cu6NT8xA+l0IF4chZneYvKenBsOSD9
	3U4G2voTcgcrtivHn9iWieWFNrLrkHu3f8xDKy540
X-Gm-Gg: AR+sD11Hkb3I6VwPgHWqDnzAwV+m2gJTokJR97MsLh7Qokrij4U95PSi6bPzPr0jK9g
	iy3EDnZl8ZNyKBfsoq0BZdYJFsUMXwEnaOofVUUSqo3wkGcIctXW9vi8amqnMgYwuWEvb/jBnGV
	9lSIQqLGcYg04wxdk7lxKnB0mYM6tYyZeZPBadXmd2GuTusuvnzooGgpYbZZaa/mwYEx1mvmxr1
	eN51hSWpEckqL/p4o06b/B8ajxqq95WPSYYCCHLk7fZ28piA7K/fRtxR6qnDu4dywtrKS5u3dzj
	/0QgmfwyiTw54KVGgMIpdy6O09CEn3xjc4pVPeCX34tJ5aLyMR5G75+GIj9TpkUL6M2ZG07X93t
	7VJVdoAG6MPHQ2gB8JALKQe2KD6+WSglOkHBXFJ99xj2xNDZeN8k9c3EHO8k5iqMeS6+FZJNz4q
	qG0mbodD8+wh1Y
X-Received: by 2002:a17:906:9f92:b0:c20:a243:9a52 with SMTP id
 a640c23a62f3a-c250a7c9f4cmr30664266b.0.1787673329133; Tue, 25 Aug 2026
 08:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com> <ao2uDa91H66vJizu@google.com>
In-Reply-To: <ao2uDa91H66vJizu@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 25 Aug 2026 08:54:52 -0700
X-Gm-Features: AcwNN1WofkpTv75R4dYNkH_7NnMFv_ScyRsu1IjpxLB_1Qn9qFOU3veM9Oi6GpI
Message-ID: <CADrL8HU2uoOVsOoxY9Sm2edV5-aXzP8QLL2LPShOF6bASpkfmg@mail.gmail.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
To: Sean Christopherson <seanjc@google.com>
Cc: Marco Marangoni <mamarang@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-patches@amazon.com, mancio@amazon.co.uk, zoumboul@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:00=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Aug 25, 2026, Marco Marangoni wrote:
> > It's worth mentioning that I also evaluated using the existing
> > KVM_PRE_FAULT_MEMORY ioctl, but this doesn't work well for our use-case=
, as
> > it requires the vCPU to be paused.
>
> What about if/when KVM Userfault[*] comes along?  I.e. pre-fault memory w=
hen the
> vCPU exits to userspace.

My understanding is that Firecracker performs its userfaultfd
operations in a separate process. KVM Userfault doesn't break this, it
just means Firecracker would need a way to signal the other process
when we get KVM_EXIT_USERFAULTs. Firecracker might be using async PF;
using KVM Userfault basically disables async PF.

> If KVM Userfault + KVM_PRE_FAULT_MEMORY is viable for Firecracker and pro=
vides
> the desired performance, I would strongly prefer that approach over KVM d=
oing its
> own prefetching.  That way other architectures don't need to implement pr=
efetching
> as well (arm64 already supports KVM_PRE_FAULT_MEMORY, and RISC-V has patc=
hes posted).

I also really like this approach if it is workable for Firecracker.

> I'm aiming to get back to that series "soon", this would simply be more m=
otivation
> to get KVM Userfault landed.

Yay!

> [*] https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google=
.com
>
