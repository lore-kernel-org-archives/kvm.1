Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE6735F5FB
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325299; cv=pass; b=rTVREnr8pLjgp7jlAX4netrgmrdKmQceKrkKQ/15U7NVi+vtI8irtyBRMP7DNNyeFQbOC9fijZbWdjsuQ9Fuo3E8T0gGNbSdOTKVeGbdRosUfLSl0xCmJ3cJyGC9z5B7a02nK2Y9QXt65RUpFrxAvVHj+2ENgAKW6O//4BkpaEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325299; c=relaxed/simple;
	bh=0MmwDt0N+cjGTBkLO+1REp2Kd6NP3k+zduo/AMzi+Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfLH0XkjRaPCiqGFnEg9kb0OwaqBepu7mlg22nBFejvfxF2Xyu4Ia5fVxpRdddDFRzO4N/on0D5Xt1KW7CSuoRYLYEKpLPk3Iz+msW2ttOR0b2w1XAupZaf7UKm32nUjdlf624+HXDIOAoVmxI3bsNtWAiOrkBm4b1xRwasKn6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LxAl0QEx; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LxAl0QEx"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd767d2d70so114831785a.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 07:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325297; cv=none;
        d=google.com; s=arc-20240605;
        b=bcpDChdRiT0g/QLDtPWBBooToVZi8gtDwu+JJnR59cXIkwTYZa0McOM8BuG+YKs0i8
         WgkuJfOWU5Naq0tW+8ljeWsW/q1RTgKBtH8h9sd7KzBvCJfL3DBsjOPJzll3wA/8ZFcn
         Q7V2WIaWsnYb3OPJaJCAIrODETv0WowKFdl84+vhli78Glsooih7XIky6LJR2vWqPtlI
         L3/Dnq/im18JS2Fw6HV/IlbPy+31HaLD5w0bOIJSIlSMRJmw0IdEJPySKsGpAf4y5XXs
         04qdVp90w38/bywph5WBM1pxx7VsDWwULeCqZ3Bs7qAi2/s2cqtI7tyyL3KPNV1InbFj
         MVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        fh=s8TnG5S3CzkdsPKA8kkzRNy1ebnmJqo9vcWTB/jXXkU=;
        b=T32Kv3tgvVRJtNHmu+j+zdIYHjU0OzndL9p2G3XcrXRNAZb3ch6DcJrheAgETKt8Y5
         8bICwFPpLRF7CJs++hE5AodA5kL1/CMzgKChihk/jnUvX9irU2O6oWg9QeNQCdVYI6IW
         /5g/WQC+5nnvivuFXIgh2IM/HRY7jjW7OiisPULcA9nUFsgKs6rixNNRG9tICa22bTXv
         baHN42tBV9qrQ4NSmArq1CbTyPymK3IMPwzQJWJiZw8lzINKRjNBOeSO12w8zKZ5p6He
         H4tzK1FkPUmMlnDs/2LkCA3CGBHJ8x8A5McJX7pdVWFbNUDh8R/ZKmcte+i1V+2lFlsR
         ZdmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773325297; x=1773930097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=LxAl0QExn9LUKBvucDG/jDlOrRgvhigExOy82otyL/5thJUswRid+ZfqpUAltkM4zN
         gZySjaCVuNbpoKQ/2a7rswJ0BtPlQwkn6oARJl/5OTiR6x7AnRv4f5+VIKIhlZWLRKG8
         /emupPBV70zIh1oC5VlOBtLYcDeNwk3yOZqaz87jKZZ5WUyzaFPqOesHKaGwwZo+SAhC
         BnvicX3I92kjcnzwmr/71H+bdHjf6h+oRY97Iq//KHFixTCH/cePr/vLa8G7LdADNE10
         Y6FKZBmP33s4G7oMDHtk0iQ7ds1SZIkKuLbAaHv5RY/jHOvoDy9JvfFB740W1kSO2zWS
         56uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325297; x=1773930097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niej5qkKc8N5xc0L2AmEIZoSaGSlXVWpm+rorTwVSs4=;
        b=tyKAy0yRsJbrKW/jUzOUV0AmyjcJe+Hv8f11ane9ZZ9PY2RkkeS1dnwl8RVRThkS/K
         ctGAZ9kWGnr/5ZLl4vFcaGmXLH5al11R9PJTMd5nkySIQq+O5uyHm1nHpoOuzSHFUslE
         ZYFUwI7Z07FEu4itEVnpFBn5rmrmk402uBNqi52kYc+5V6iAMe9xz82LuOCm9SfTtL4S
         nnlRW5kToAfQEgZoZ+75kbjvRELZQo0oSrBl1BibJkSY2qNJIc89BH5Q+LVn9PO9JKz+
         wHGsp7UV/RgU1qDUzn/ODYfCCT1eQCIfsPz8AeS+4MuQDNzlYpoM8A5jpOBAXwUdh1hj
         uGPA==
X-Forwarded-Encrypted: i=1; AJvYcCXzF0OAic7kQHtLAiBATAVdyuvGDHDNzKCYyYRv3TB9CHouWy3+K+MeBoTkdSiKgzZMs2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzrfRlzcDTMf5vjddCnHx7jragctqtHXNkMaEvB7iErvHZu1Pj
	GkKDXKbCrqwLIMl13ciJds13i5BzdKL+5NWebzsWgzCh0U8uzTKibYM+bBntNTaBvNjoykaVFlF
	DCcDKk/i7KqmvOMZri5DE12sUSSMvhm0Ra6SbIHo0
X-Gm-Gg: ATEYQzzd4zW4bjlcutX8riZ+v8QmfDE6ziVRcf6gBf66pReC5SdIiho4hb07dUL+uKk
	1M3sDr2ZZp6dPHYNsdzLtygAJpm14VkPu3/xpBMvxC0PzBKEQ9IQc87B5m7xyvUIEAUHcnz+UeK
	c4scnTgOUAjL3Tfo6BXbS69cBYI+/MkEYYyrmQb4nU1vILIO5B3oQRq8wMkvCh6WcojgdtTOZE6
	7cQCylFMtPuGlKKDIJPG+jnrwlDt3Vt4MVwK9SmBASv7SvUbMQ4VqSqb4ZeczLDe2CfetV0Hj1z
	ZjXeYToF
X-Received: by 2002:a05:622a:14c:b0:501:1795:9d52 with SMTP id
 d75a77b69052e-50939fc1863mr86449811cf.33.1773325296875; Thu, 12 Mar 2026
 07:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-4-simon.schippers@tu-dortmund.de> <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
 <20260312094447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260312094447-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 15:21:25 +0100
X-Gm-Features: AaiRm519R7QoAd18JWvrdvhH1ifA15H5AznmUpI-fEIpOmq2LTIYuzUlf4ZNyAg
Message-ID: <CANn89iLHwZ4foPEL2TdQhYx3Ps3zXiwygb=Qr7OTKW2R7Ldixg@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Mar 12, 2026 at 02:17:16PM +0100, Eric Dumazet wrote:
> > On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> > >
> > > This patch moves the check for available free space for a new entry i=
nto
> > > a separate function. As a result, __ptr_ring_produce() remains logica=
lly
> > > unchanged, while the new helper allows callers to determine in advanc=
e
> > > whether subsequent __ptr_ring_produce() calls will succeed. This
> > > information can, for example, be used to temporarily stop producing u=
ntil
> > > __ptr_ring_peek() indicates that space is available again.
> > >
> > > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > > ---
> > >  include/linux/ptr_ring.h | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> > > index 534531807d95..a5a3fa4916d3 100644
> > > --- a/include/linux/ptr_ring.h
> > > +++ b/include/linux/ptr_ring.h
> > > @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_rin=
g *r)
> > >         return ret;
> > >  }
> > >
> > > +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> > > +{
> > > +       if (unlikely(!r->size) || r->queue[r->producer])
> >
> > I think this should be
> >
> >        if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))
> >
> > And of course:
> >
> > @@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring=
 *r)
> >  static inline bool __ptr_ring_empty(struct ptr_ring *r)
> >  {
> >         if (likely(r->size))
> > -               return !r->queue[READ_ONCE(r->consumer_head)];
> > +               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]=
);
> >         return true;
> >  }
>
>
> I don't understand why it's necessary. consumer_head etc are
> all lock protected.
>
> queue itself is not but we are only checking it for NULL -
> it is fine if compiler reads it in many chunks and not all
> at once.
>
> > @@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
> > ptr_ring *r, int consumer_head)
> >          * besides the first one until we write out all entries.
> >          */
> >         while (likely(head > r->consumer_tail))
> > -               r->queue[--head] =3D NULL;
> > +               WRITE_ONCE(r->queue[--head], NULL);
> >
> >         r->consumer_tail =3D consumer_head;
> >  }
> >
> >
> > Presumably we should fix this in net tree first.
>
>
> Maybe this one yes but I am not sure at all - KCSAN is happy.
>

Hmmm.. what about this trace ?

BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue

write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
__ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
__ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
__ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
__skb_array_consume include/linux/skb_array.h:98 [inline]
pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
dequeue_skb net/sched/sch_generic.c:297 [inline]
qdisc_restart net/sched/sch_generic.c:402 [inline]
__qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
qdisc_run include/net/pkt_sched.h:120 [inline]
net_tx_action+0x379/0x590 net/core/dev.c:5793
handle_softirqs+0xb9/0x280 kernel/softirq.c:622
do_softirq+0x45/0x60 kernel/softirq.c:523
__local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
local_bh_enable include/linux/bottom_half.h:33 [inline]
bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
__ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
skb_array_produce include/linux/skb_array.h:44 [inline]
pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
dev_qdisc_enqueue net/core/dev.c:4144 [inline]
__dev_xmit_skb net/core/dev.c:4188 [inline]
__dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
dev_queue_xmit include/linux/netdevice.h:3384 [inline]
__bpf_tx_skb net/core/filter.c:2153 [inline]
__bpf_redirect_common net/core/filter.c:2197 [inline]
__bpf_redirect+0x862/0x990 net/core/filter.c:2204
____bpf_clone_redirect net/core/filter.c:2487 [inline]
bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
bpf_prog_53f18857bc887b09+0x22/0x2a
bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
__bpf_prog_run include/linux/filter.h:723 [inline]
bpf_prog_run include/linux/filter.h:730 [inline]
bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
__sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
__do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
__se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
__x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:322
do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff888104a93a00 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
PREEMPT(full)
Tainted: [W]=3DWARN
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/24/2026
