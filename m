Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341995;
	b=E6PrSHxSWOt9mHZMs3L+KQda0h8I7rOY6m7t1g0MNuGH3soMCEVaIZv3NwdO3OTT0rwT
	 WApa7YVg/clLEVMaiOVIXfGKzK+CciXTpo2gHkd6ebgyQjQKIBg04VKS6DK6RtVLNSOXh
	 C3CofT5a2EQtPmCkW+SQ/ToojBzXiOgzRIYG19cNImDrpwJiZH8+LgrEymHVyT8RqJGlq
	 +FPuBUTSPpczunTuYhPy3uEQ1WHZZseryoBaj+cmdEMlyHRbBd/s0B7aWn8NYYJaDKSy1
	 E+82Z4Igc+PKuUXXt/FOhtlss7QycGFLmwJYGrczRy66fOk90+L9DTTM+gVRx0ubdxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
	b=O/t4ktwVFKJfqwvSwpL3EPZx+8J2goTUn1noDEo7DY7FjN2OlR3OuEMQ1mfpLxjh8ohc
	 thd4HxPl9Ts0G5iyif1WqX9Ct6c4mgevNjY6bHqnF79S+Qx5a8mxi5l3E05SltjSD8rhj
	 WKlAZlva3dZRaWxzDL5mzCZErJA7stSchVWYVyfATBhXM7EoCcDpCF8KHyNCKYxXPB+Dj
	 SXkam/0jV1Dq3XVu1QQWKDYeBWXALYxc0frMQglBtrmIm3MBNKh4W1NA0m0Am0925/brz
	 HMpGbz+Z76CP1Mts9/xUweJ3nYNFEF6WxrYlp+JQFBVgJxO8ddT36hvGK6M/o3k5hCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aP0X0iPt;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A0606A325
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 20:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E3A0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aP0X0iPt
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb90a6230cso1244243a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794341994; x=1794946794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=aP0X0iPtBrwNmhdMirAtRHYzTNScUoza0tcUi09jz2/7DAeJrq2GSp2y1EWXDpGpf6
         t+FoZ+jWY3xcdigvRR/oe2vxrnJcsD4GDSMCFvmqwGcoTb+b6x8Uoo4YcSTE5EbqIEy7
         nv2NJyNk6nyHPmxgiZ8MY0JHInxmm2+tw1OeAmv7GtSi2+neoYEKw5vzF4+z9DL+nZT4
         i0/2fS3s7Mz1VtKSFUpC/6CopEGZDoAtbP2KkTakh1JcZqkqFX5yRjhL7X74J2MxRE14
         zwXfLstdzwXLoaEI+e7hSKHqRsz4B2JSJWP+dLjpApkiNS/p5JPglF1s+krjd0gNRv8T
         2O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341994; x=1794946794;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=g0i0hBof5saoq3z/n2BQBmyEwOUg/dWA0iBMXr+lEedgJwsUmi4CEh3GR4RJPplhac
         mVhOTBIjjtGTySIKcm77o7U85J1K2hBD6XGi0RQCM1YZERhlwiGhT2y8Rmyka19BcNae
         BMWcOlhvH9tuDrG8XKv183g1V4ZfsZC6HzPadLxqdkl8GJ+U5xupIXh52pts1ZOhvPs6
         Pod2FF5xTVyjoF2Hs1xSESitl5eBhCpcq2ZCyCn9+zV37bYmy64vxNScMzwjK3x7eQGo
         a0B5cElKWA3x3qa6Q3GVu6MsGI3vRqCi1eACCABqfq7JGK1ZNWL5pxK3B6caJocOSLbG
         Id9Q==
X-Gm-Message-State: APuU4Z9GdbLgjKtAtqELlTbnKnsO4svY/moycz7QB0iRoS8k0wFKOTVH
	KP9EvNTay1uY5U3x4JLHsggeIC4rUM7qpY3oZtP51f5WsmvGImBQvAm8zXhc/Ir0gOFV0c31+fD
	A2LL2Kw==
X-Received: from pghf7.prod.google.com ([2002:a63:e307:0:b0:cd7:f985:396d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1446:b0:3e2:a849:64c5
 with SMTP id adf61e73a8af0-3f2fc99f9aamr241125637.19.1794341993521; Tue, 10
 Nov 2026 12:19:53 -0800 (PST)
Date: Tue, 10 Nov 2026 12:19:52 -0800
In-Reply-To: <20261105020104.2507083-7-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105020104.2507083-1-dwmw2@infradead.org> <20261105020104.2507083-7-dwmw2@infradead.org>
Message-ID: <avN8aJIHiX4xyTNO@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 06/20] KVM: x86: Request the guest TLB flush from record_steal_time()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Kunwu Chan <kunwu.chan@gmail.com>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> record_steal_time() performs a TLB flush on the guest's behalf when the
> guest sets KVM_VCPU_FLUSH_TLB. With shadow paging,
> kvm_vcpu_flush_tlb_guest() ends up in mmu_sync_children(), which can
> reschedule via cond_resched_rwlock_write(). That is why the flush
> currently sits between a user_access_end() and a fresh
> user_access_begin(): it cannot be done while the guest page is mapped
> for access.
>=20
> Raise KVM_REQ_TLB_FLUSH_GUEST instead of flushing inline, and move the
> processing of KVM_REQ_STEAL_UPDATE ahead of where the TLB flush requests
> are serviced in vcpu_enter_guest() so that the flush still happens before
> the vCPU enters the guest. There is no requirement for it to complete any
> earlier than that.
>=20
> kvm_make_request() on the vCPU which is running is nothing more than a
> barrier and a set_bit(), so unlike the flush itself it can be done from
> any context =E2=80=94 which lets the surrounding access be simplified lat=
er.
>=20
> Note that the xchg() must stay where it is: it atomically consumes any
> KVM_VCPU_FLUSH_TLB which the guest has set, as required by commit
> b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed")=
.
>=20
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260530061932.7849D1F00893@smtp.kern=
el.org
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6a1f0404f029..3c26c0eb9865 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2117,8 +2117,22 @@ static void record_steal_time(struct kvm_vcpu *vcp=
u)
> =20
>  		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
> +		/*
> +		 * Request the flush instead of performing it inline. With
> +		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule
> +		 * (via mmu_sync_children()), so it could not be called while
> +		 * the user access above was open. Requesting is just a bit
> +		 * set on the running vCPU, and the request is serviced
> +		 * before the vCPU enters the guest; nothing requires the
> +		 * flush to have completed any earlier than that.

Argh, I completely forgot about this.  It throws a big wrench in my plans t=
o fix
a mishandled TLB flush without using a deferred mechanism[1].  I really don=
't like
having to re-introduce deferred flags, but the diff is a lot smaller[2].  O=
n the
other hand, I still don't like the idea of delaying the MMU sync until the =
nested
VM-Exit.

I think I'll see how gross it is to do something like add a KVM_REQ_PV_TLB_=
FLUSH.

[1] https://lore.kernel.org/all/au0R41xbEJ_9W_9z@google.com
[2] https://lore.kernel.org/all/auDkX94UTjrLNmqp@google.com
