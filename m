Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2B3F074E
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250309; cv=none; b=B1AjH2jz+LAEJfO2EwgL+J28m0ThJWwxYfijMyHEbrkmHj6mjpRpz68/rovEByIRQZ0Q+RUZD8zn+jw2XliA+KfDzejgXV5ZwBhYP0tRicg004K7AY/QblZ26CheyoH0dC0wxG61PJOFfOABXrGUVe9cMOxk65bRsgPjAEEZWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250309; c=relaxed/simple;
	bh=aAVkz69vD33yhtOgiJeMkQeov5eMMi7o2uoGq2OqIsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rk3JJHO3n/mwuFQd/9I7w1RdYNSh11lmH1A5kAfefFGJFBCwTy9FD2wATN2i0iPwhzma4kcpbrFRYmpfd0u7hU62y5tnr6AoH9WqZ5g7TJ+f+wbOxwzP14jxWyL2KzsOVldm9WdRTw7yOGcRZ4OTR/Zoo7JYQcdKnT3oCuGOKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uxo9Imsk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxo9Imsk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4654f9bb6so23348095ad.2
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 07:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778250307; x=1778855107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WH26AvtCBPGbA9WUcHtqgl/A+uk1Xhz5GMhmaOiRbZA=;
        b=uxo9Imsk7mdYPtbS32DX/TR2B6mfy0fOtuQA1LkrsT+vn4w3Gq8u56Ios52bO9h133
         8gO6Xg5eDfsyC6Nl8njvPcITvdBgnjTEqXrCik8eIpkKEbDfnhCekn916iJkbpl/ooSB
         aZb2kCSwlD6ZePQamV9ZYBORHNIoJ23F8EmEMp5qzCGI+ZQ9ePNOIvkf0T0K8U4DpwoV
         ++x+4peS910uSH/dpCvhVNOhSUIbqemjSp+/ItWHTEfFiWKBvVtyL+XZNbXpiNJ7mT8u
         AwOxtUeUxtrBzbvLTZ5tsOJDcKOp9K1CIr5Nl01V307X38cHGLKTzC+u8j/71SJG0IdG
         ggIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778250307; x=1778855107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH26AvtCBPGbA9WUcHtqgl/A+uk1Xhz5GMhmaOiRbZA=;
        b=AAnn3qZV5hUlSrThL+KF6Dac907B0AyM38ORf5eSnW+Hyz11pG05a3pc4s4bpanv0F
         NZCaXMsVVpf+V6KwrOzTsTRThz9KKzm8WO8D1JASuL9P303RXxPhr0eigS59fO/ssr/t
         yY0Gmgb41P16d+PT12t9wZX/AlGg4U4aBMO75qy9GmpkEE+IOxaV9OIjBeHof++BvnjE
         jHTFHRA8pQkqXrjWAF+DLbTBUwK6LCbTnlQ1/WXekmujEEp9sa/dKCgu4WoeKVOLJDq4
         2oVDOVyA2ElSXKXi1XF4Ttd3Gw97BgN1lNSp3wL4zllOS4bFnxn4uCeWjFmQZNrgwkq6
         CcwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JIvNWXqmS532K8ACtEzF5gde2tik7jMudDYM8NPUyL7SLZcFa7MnXcZ6/D/ipwWMmlOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXiGMdmT71dBZUwWuuY/ZT2us1fbjy1G13nm8MZQ7uabRyN/J
	9oOXMlBey39odVSxN40xzHIBNqo1aKr4Iuu3We41ipZRKO1xXJVNs9oBWvQEACIGEkR7JDfkj/r
	sv6QYEA==
X-Received: from plox6.prod.google.com ([2002:a17:902:8ec6:b0:2b0:b12e:1b07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2b:b0:2b4:689a:e411
 with SMTP id d9443c01a7336-2ba794b80ddmr138393945ad.22.1778250307161; Fri, 08
 May 2026 07:25:07 -0700 (PDT)
Date: Fri, 8 May 2026 07:25:06 -0700
In-Reply-To: <41da263a-ca8e-4041-8214-b6b9f80edebb@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67a2f20537354628bcb835586a7c6255@huawei.com> <aYuC87rMLlBYIZRc@google.com>
 <aZYneb7Dvuu-HQsP@google.com> <41da263a-ca8e-4041-8214-b6b9f80edebb@huawei.com>
Message-ID: <af3yQrxgyC8YxAPt@google.com>
Subject: Re: [BUG REPORT] USE_AFTER_FREE in complete_emulated_mmio found by
 KASAN/Syzkaller fuzz test (v5.10.0)
From: Sean Christopherson <seanjc@google.com>
To: Xinyu Zheng <zhengxinyu6@huawei.com>
Cc: Zhangjiaji <zhangjiaji1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wangqinxiao (Tom)" <wangqinxiao@huawei.com>, 
	zhangyashu <zhangyashu2@h-partners.com>, "wangyanan (Y)" <wangyanan55@huawei.com>, 
	zouyipeng <zouyipeng@huawei.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, Xinyu Zheng wrote:
> On 2/19/2026 4:56 AM, Sean Christopherson wrote:
> > On Tue, Feb 10, 2026, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 2c7d76262898..0bb2a34fb93d 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -320,7 +320,8 @@ static inline bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
> >   struct kvm_mmio_fragment {
> >   	gpa_t gpa;
> >   	void *data;
> > -	unsigned len;
> > +	u64 val;
> 
> Hi, Jiayi and Sean,
> 
> Since I met a KABI consistence break problem from this change, I am finding
> a way to avoid add including kvm_mmio_fragment.val.

I assume you're looking for a solution for a private/proprietary kernel?  I.e.
not trying to figure out a solution for an upstream LTS kernel?

> Can I try to directly malloc a 8 size buffer for kvm_mmio_fragment.data
> instead of using kvm_mmio_fragment.val, and free this buffer in
> complete_emulated_mmio when all fragments is been copied?

I highly doubt that will work, because you'd still need to stash the pointer
somewhere.  And it pretty much would have to be somewhere in kvm_vcpu, which
would likely mean a change in KABI.  FWIW, freeing the allocation in
complete_emulated_mmio() wouldn't suffice; you'd also need to free the memory
on vCPU destruction, because there's no guarantee userspace would complete
KVM_RUN.

You should be able to use the padding in the "kvm_run.s".  Thanks to s390's
massive regs size, there's a huge amount of unused space in the union on x86.
Note, because there can be two fragments in-flight, you'd need to index the
array using the correct fragment number.

Userspace can scribble the value, but that's completely irrelevant from a host
safety perspective.

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..29c7123d5467 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -515,7 +515,10 @@ struct kvm_run {
        __u64 kvm_valid_regs;
        __u64 kvm_dirty_regs;
        union {
-               struct kvm_sync_regs regs;
+               struct {
+                       struct kvm_sync_regs regs;
+                       u64 x86_mmio_val[2];
+               };
                char padding[SYNC_REGS_SIZE_BYTES];
        } s;
 };
