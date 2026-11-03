Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793712264;
	b=dbyg22CxYKJN3B9HaR5/8NbYenJLFVKqPS+V5Gt90py9/CjUm+8uzHFo5T9/H9lBmFjL
	 WG60P+y9C7nFgJFEhpjnNy0BfPrcyMvOOduPQAorvRJObfjmRZrpmaeesNwC62fjDtE7V
	 5FSXjvElKScydIebz2quoTQ8LVbKVNarQOzpayGKedZYupkBa5L2bsVz+pyst+LCUzvdV
	 yeTlB7dx0Sos6Bd6IotW8O5jmKa7ToCiH3nGPOt9i67gFGURptv6IKUfMORiYcwzzd7Qm
	 gMa2sQ4rF3hzd9dC/79dmtp/KOdfyMdO446XDKy6GxoSI0rYsY7QoBNWjzXpgnZT+Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712264;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=fGCGwjb+9HjVJgbKvPA+oIY0E0Y2IyX0PIx4wtVPsTs=;
	b=U2xocci/Lof19G5xw34PNpQpGbf1eLJH0QkGCi24jamyh2aOW9ElLxQved6e0rT/UjDX
	 g561tP2ng0xaJECXppML07+wdF6Agq/DpgWxkWW3si2fLGaxwDh7UlGkWP0y9bSwQy/iW
	 ufj1UlY6DMNZpOOcbUV5nrgosBzWjpVXQhMQWYJRpuBn3bZewZVaXSZXbMNoBaS8sMLaC
	 pBg3YSihejkKyniOLBOIuK/OR4feLQHLu3Mel2PrAdWhqp0mFgN+5+0jfw6xNapwyCaem
	 WBFyzO+Ya380ZJg0sXJHTWeEk6N8/dIYG4r0/cMacrJkwiYS8x9drQ8sR+ZgI2/PfCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUGUrNAp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sm+76CFA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F6606A32E
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 13:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69F6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WUGUrNAp;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sm+76CFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793712262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGCGwjb+9HjVJgbKvPA+oIY0E0Y2IyX0PIx4wtVPsTs=;
	b=WUGUrNApzTtriekK5qlZoc51pzczit2p1///qd4qFNUTqNenruytjWSPzYwlTmWU66O/+h
	Fgyc9kmoRKQ+uHCzORTjc70T006d9bmecO01COx7guuyCU++by/uDNRoG6r3DMHKKhwgUl
	NEwfTaoUqVt8tPDLxGvqV5r4evhywVk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-b2hL5OQUNBq67pjzC5EU9Q-1; Tue, 03 Nov 2026 08:24:21 -0500
X-MC-Unique: b2hL5OQUNBq67pjzC5EU9Q-1
X-Mimecast-MFC-AGG-ID: b2hL5OQUNBq67pjzC5EU9Q_1793712260
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so2180341f8f.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 05:24:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793712260; cv=none;
        d=google.com; s=arc-20260327;
        b=FvZyla9WdG48SkZp8WysMT105DdIUUG8uWZaagccg2ATvTmHQWIiP6wGCpAFFgkVw1
         ZwMUh1WgVs5yz7L07OClaL9cWQ6jfIu46ugyZspAb9u9IuW4Q8mE3auaSPhc71pRhVVK
         jwMouX5E0XL3uUhikpj2OSMEIDjqQrWs3ocwbvBq8BsSbF9s+MqObkdi0XWCk45fCsuh
         7WQySS1unbq9FFN65l7wsTDVxvGtSBSWWyC8AovGVzwa8eEIjxf1Gaz4O8jdR5UaGmZV
         QSCJiUR2CUE66zm2uNr5oEFFvwVq1kUBPNVY6TbgvrFH411MTBt/ZuclVlHw9DtQHm9z
         EBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fGCGwjb+9HjVJgbKvPA+oIY0E0Y2IyX0PIx4wtVPsTs=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=ovWWcDztVUZoF85TNbnYHjamXwKNIeWpwxrGuo80Z9gxBFooxxkbXOmKlJTsprfaUp
         nzSp7t7Ldj/gCz4EfqSaHME+uyUNlu3D/QabT+5M4iaGYWfaRKxgJEFgny7ErQEVQqrq
         irVJIJxrWI6W2XZnGu39vxGlzmFqBQsRKAQXEUUCgz1/oz/25kjwhQQR8bLhh0MGLCEE
         LMViHMhncD7gqo+IUX2l4rSzO5slDU2I0MDvSOBNG26r4J93ZJcszQM0nlsarCwzAK+R
         OOptxfkzxwzD7CXET8ft7gpMuWqD3Z7BfOYXtAiAYUdywqloeueUnPGFssT+tycyP8/n
         19gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793712260; x=1794317060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGCGwjb+9HjVJgbKvPA+oIY0E0Y2IyX0PIx4wtVPsTs=;
        b=Sm+76CFA9lLPLYlzC5kvktps37CvLd13rypYkvuHyVMYSFnf5Zq9PXtCSNzic7FQZG
         ZmGQnvOZQa1lQXu5i3Kzs1DeJTCxQ+Q4ZzYUFF2T9QHry3u9m2G5knlIUvTg3AOog8RN
         C0138/0EmLTyA6115N7Af9SMcVn9RtEHS6QDZzcd65lf+4RkbQxWPD2uB2/vWswUl+4r
         orPF3RXesB46zXwuYh5m4UEgOLmX31J3fBi+revrbL/F5+kSpS4XnCu3RFLs1FfK8bGn
         rWBWF/c6dJJKHDkLtHkfBDQMeuZf49yPYpg4oHZhBKAOwy1vkPPhhHH4GopVPIxX98QY
         mLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793712260; x=1794317060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGCGwjb+9HjVJgbKvPA+oIY0E0Y2IyX0PIx4wtVPsTs=;
        b=jb4CdVAoQs03IevVqnw7fg1bb3T0SamdRFYX+pMmC4Phuj8ZPs79iiyXUF0CtfLBa3
         0Jm7FBrOo+yKl4tZMC0PwZlyKVmPynUxo0GBu+Tn1MrR0kdAJpGHjQ9gYWmvKVxmQc8C
         BthjNtkyIoK82yZrYHS5CBxMyht2ypWeVPFK9yFGtXKizbx56qfHwRY63SLSz28RAnSU
         dqpC6uEL4TmKQbN2PyPUKK384xTErGhDeLTaQcdXhbvu9lBqVQZnseBYMZ/YroAYO7XU
         P+9ofZc1vmrYMyy9FUxWyfJ2bCqJAJUm1rF5KAPyYA+oU69gWzqcTlN0GOOvDYkTQdOi
         TuGA==
X-Gm-Message-State: APuU4Z/RMQ/yck2DqDoSBroTe4GE+tyDprLxgdx+WdfazgfG7mRF+Ak7
	zRO/N8esS5FOGoLTPhxH6W57EGvvfZqqzwBH9fQat8q6IYT67HfvliRsHT1c+NFHKAGxRmHyj6+
	sXVBSmKtc3t/XF+xskio8viJ5tcGqWGlVV9GYgz0RkPppDCnGflnca8wngMPKAcD9JozlYKo6MU
	e2IKE9IXKdtwchJMBVJEMtPlCkQ56z
X-Gm-Gg: AYBFou1PWO69d75M3JRQChB0iHrX5+EfIeMdEk31NA9QMagbN+C0bMIFZNeMdUfGZxV
	FWaL/tocY1eiV+8ELjYleRlAmXw4dQNLPEKwor43dGwcK91jRYV5MvVbrC0mM0oskqJML+7qHlt
	4bmlIVY3qOsdCu0ynJc4Q6ZgRMCoZQMCsPDIxew08BckhTSgD4mdlFXB3PwcdUsN3R+hWjYQLxN
	eWorSZMRXLgGbKQt7z4AIBkXk0T7nVsQjVi7LgY6jDecpX0juHg4M0MRgyU
X-Received: by 2002:a05:6000:468f:b0:48e:6710:ecd8 with SMTP id ffacd0b85a97d-48e6e2fcdb9mr18138795f8f.26.1793712260129;
        Tue, 03 Nov 2026 05:24:20 -0800 (PST)
X-Received: by 2002:a05:6000:468f:b0:48e:6710:ecd8 with SMTP id
 ffacd0b85a97d-48e6e2fcdb9mr18138767f8f.26.1793712259755; Tue, 03 Nov 2026
 05:24:19 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103124930.2278671-1-pbonzini@redhat.com> <20261103124930.2278671-2-pbonzini@redhat.com>
 <sashiko-outbox-195309@kernel.org>
In-Reply-To: <sashiko-outbox-195309@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2026 14:24:08 +0100
X-Gm-Features: AclHuK-7YhzMy4DVyFsS5_QDuT7fH1tC2gLQTOF_gW8Or8OMBgi9QzQJZPCSNes
Message-ID: <CABgObfa7m0Fma=u_aGc==8iYH-u3AKSRKZ=Zt0WQKR38VoScgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 2:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [Severity: High]
> Can splitting kvm_async_pf_queue_task() from kvm_async_pf_task_wait_sched=
ule()
> cause a race on vcpu->arch.apf.host_apf_node.wq if the vCPU task is preem=
pted
> and migrated between VM-exit and kvm_handle_page_fault()?
>
> CPU B (vcpu task)                      CPU A (page-ready IRQ)
> -----------------                      ----------------------
> kvm_handle_page_fault()
>   kvm_async_pf_task_wait_schedule()
>     prepare_to_swait_exclusive(&n->wq, &wait, ...)
>       /* adds wait to n->wq.task_list
>          and drops n->wq.lock */
>                                        kvm_async_pf_task_wake()
>                                          raw_spin_lock(&b->lock);
>                                          apf_task_wake_one(n)
>                                            hlist_del_init(&n->link);
>                                            if (swq_has_sleeper(&n->wq))
>     if (hlist_unhashed(&n->link))
>       break;
>     finish_swait(&n->wq, &wait);
>                                              swake_up_one(&n->wq);
>
> Because apf_task_wake_one() unhashes n->link before calling swake_up_one(=
),
> and kvm_async_pf_task_wait_schedule() does not synchronize with b->lock b=
efore
> returning, CPU B can observe hlist_unhashed(&n->link), remove wait via
> finish_swait(), and return from kvm_async_pf_task_wait_schedule() while C=
PU A
> is still about to execute swake_up_one(&n->wq).

True, but pre-existing.  kvm_async_pf_task_wait_schedule() must take
b->lock. Will send v2 once I get more reviews.

Paolo

