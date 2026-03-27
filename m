Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691363033FF
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574043; cv=pass; b=jWSvURu3P3PrsnLvCKjH4TUY+7/ZF8Jc6ShpkEq6KXf+rxxvp4LhGkRQEAG3x/mCIH2+9F2xBkpmBo9RoYkLsPqp7EcjRGcLEx7q9GKu3VUewd+EgZycw7pOSTr2m+MTqadoB7pAelSB8EAw82GCd8E+nM8ltRs51axMsfsR7SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574043; c=relaxed/simple;
	bh=K9BdomJ0oyd/P8kHvACnjRTj74BOP1zpB7Ajzk4ly5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK5Co2D+zBLY6LP+R3LxiE4X+0Kwvq0iKHCbExjBJL9GRMIww7WL4+RH/kG5F1OYU6QxrliMsgRFzN6OfoVb52G/9Bm2Zm3IWemw9f5I0UhCm1ofGfwoxjE8bomLOJKyy1rFNbaZgoYOR9BXFV0BJwoOFYYlXmJR3q078PCLHIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnLmiNSG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFqso8by; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnLmiNSG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFqso8by"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774574040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jItjwJJuANgTXGr+5yBvT6YAOU5YWaNA37h+VHMmew=;
	b=KnLmiNSGWWdq+BL2j/h3+4XhE6nHlk9WVeL+w+BaCU4Xi/MnGLBCV9+Sz2fyieAfyChjMH
	X0tI3Pueh4CtNKUVdakA5CnaHJK/LzULiyMY6tBaA0zBQaditN0mrv+hBTXyCHeQTnJ6K/
	e7sjLgppUtsX3Rt/hVn8HVGSQMyLQ6s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-YTnNQQqCM1yn45PzCpCadg-1; Thu, 26 Mar 2026 21:13:58 -0400
X-MC-Unique: YTnNQQqCM1yn45PzCpCadg-1
X-Mimecast-MFC-AGG-ID: YTnNQQqCM1yn45PzCpCadg_1774574038
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7380305a9aso1855746a12.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774574038; cv=none;
        d=google.com; s=arc-20240605;
        b=jgFP9H3BLVVEQuIJQfnAIRMkGXOw6m5coyI/cacRuNjPWd3FP0nzG0lclhMDEztHsv
         CzmoecGqKVTlnk4RSyPkZEd+Nzi4kllqNu22glM/z7i4KfYEwcOs5OlVrmb/V0BCglRO
         7rIu6jGgtfeZ1W883A9WIQ+uxRxPD+ac6NwQQAI9J9t/urhn4rnjMMci9kLYWiWFWPbb
         1jwwrVh0WwoKWVsiOUPdyAv3Uh0H4dFIVXLLr91KtrBAqFHfhL3j7c1bWcr8uoSiKw65
         DqqhjWtyRo2SHgeCj2cRhymNKVS6Uw6u1r4puebOf+lge9omHWwuN0RS/z/EQ5Wofp1I
         r7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6jItjwJJuANgTXGr+5yBvT6YAOU5YWaNA37h+VHMmew=;
        fh=pqSXGpE6mH6HwjmyztkRRx33jyBkWnhVjHmSXdgE5mA=;
        b=JnEYDjmamgX1iDymdIXTyEIrD7je3OFVkt4uKQHJfSltc370NIwjHDUaxUB+KW+rA5
         tptJDvHps7ISSAoLHpRaNefpTVEGLWHTnPzdl+CnMpqKYjEibCYhbTYyVm7wMPsuzamv
         AWA+ltIKQ9w1CEm/RY7Ugy0gIt1R5CQ+rdvhzZ4HimR1W9t6qaZpTGVSVSebpEMOwJoM
         P9TIwX5E+8h4SPjfF8fgRDv4F8WvaEYe0cYR6KxT9F0v3PNMUREQpgofm7mOukJs3TdN
         vY52vDBlGlq5uSEREWl0KLW1wapCRN0TNuZ5+lZBvNSbMlWYF8DtaLSIuDYsA3LzczdG
         d3Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774574038; x=1775178838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jItjwJJuANgTXGr+5yBvT6YAOU5YWaNA37h+VHMmew=;
        b=iFqso8byqtZv2QaQvyLZfnSyTUBrOwduLRF8MoUFfuN9oDWJm8WETESKA7QuzLp44i
         S1g9lSWd+g5pI3mkw12rIEg8KALw+A6cVoffZZFQCrMCJBFRoD6HeT7CGTS5TuMONpcN
         K24UpUSggTJ1jZIzN8s8xUDWkFVC/D9tUBa+4E0Icql+FhdFhdOxQKtifGn0t3aeAiA9
         /mkZC15eoHwP02C+9QPKLCBtH3ZsRkTmGjWvcJtriIThM8awOxGkY4X+koJp+PqSxtdy
         btbzj/FjbberdF3S6DJX3eE4Inh1+77S1PY+TVqpbMrrb+rG/WBIja5PAqYPX9Ep+Dyg
         Tk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774574038; x=1775178838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jItjwJJuANgTXGr+5yBvT6YAOU5YWaNA37h+VHMmew=;
        b=WENbI0om7/ddqdmlD6B4wpV/MLFZGOAMlGCUiHPv66y/T4hQhfpI4Xfm1KLNWGyXQi
         WgxO9LwYSohybXoyZVfuBOSnArcK0brYbgH+HrdmIBxN97etXnsHhNx2ci+VGf0ltVA/
         jnEyUSOssyJVLPbBf6t1smJfgqaKkhwQeKOCMBOP4dPLSf37VoPKWeAUqTSRZV8ZLBE5
         b4J72V8AquGSSqRHzFW3y5H89A0GRV1dWni4ooZ+u18TqjpOxOd85zpvv8598j09z+Kb
         CC8GlFxuInYqlfl4Dq4LzlSNeYVOPiskXUpi33bgDFUMPP+dnWygm6W4P9S9Mm+nXxPW
         Exsw==
X-Forwarded-Encrypted: i=1; AJvYcCUBn9FNVEd2f0TGWQpcP/6NibmxZLfOKf3oUxl5qxyz2Ff+Ih+uyRhbGAmb7Syi5FEsegE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy59zGZJrnNqdrZlLg0gPmLhViMAy5Xs8yCASsTgX/7BVQuMZpD
	ZJ54aQcsMzF2jZXwAYcsXwOm73mxrIHxsgbpxkpGwhD61k+GkbRWvq2/fsNKr6kLgKpV/jPaD4z
	8C/tTjuv9L/sPBLMxs2DOJgifBIs5FxEEhKJ4Tqfh+ns3121T3sIXmC2iJP9Icd8W6Bfx76Bsms
	pHKx5YsIykD3+4qSx+MJKW7/0kEg52
X-Gm-Gg: ATEYQzyQnf6YB1CXMAJFx/qbieyrZQvN7IXd6T0D/WI2AW3o7ZNbw8dwsrDshFPNwZ4
	FZDPUudakwAPpjWLKgF8myVp0XIK+R8VRKg8t50gblqIpFIzFtazEu9AU75Sa8W8jb2ENro5sPG
	SDMNeYDuEqTi1oHX0Ih4Dz0ZEWM2ewp5HUg6bBWyWuPl1EZRHpZIlOwo8y9QS5Kl3yuow42D+JX
	AuGw4M=
X-Received: by 2002:a05:6a20:1582:b0:394:505d:fcf8 with SMTP id adf61e73a8af0-39c73809298mr3587316637.30.1774574037565;
        Thu, 26 Mar 2026 18:13:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:1582:b0:394:505d:fcf8 with SMTP id
 adf61e73a8af0-39c73809298mr3587271637.30.1774574036896; Thu, 26 Mar 2026
 18:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de> <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de> <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com> <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
In-Reply-To: <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 09:13:44 +0800
X-Gm-Features: AQROBzCm0eJyvWEdhgKck6Ldr_rdZXEPK0YJuDBmFmgznfSwGMPNb_QymFWCZlc
Message-ID: <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 11:31=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 3/26/26 03:41, Jason Wang wrote:
> > On Wed, Mar 25, 2026 at 10:48=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 3/24/26 11:14, Simon Schippers wrote:
> >>> On 3/24/26 02:47, Jason Wang wrote:
> >>>> On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
> >>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>
> >>>>> This commit prevents tail-drop when a qdisc is present and the ptr_=
ring
> >>>>> becomes full. Once an entry is successfully produced and the ptr_ri=
ng
> >>>>> reaches capacity, the netdev queue is stopped instead of dropping
> >>>>> subsequent packets.
> >>>>>
> >>>>> If producing an entry fails anyways due to a race, tun_net_xmit ret=
urns
> >>>>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected beca=
use
> >>>>> LLTX is enabled and the transmit path operates without the usual lo=
cking.
> >>>>>
> >>>>> The existing __tun_wake_queue() function wakes the netdev queue. Ra=
ces
> >>>>> between this wakeup and the queue-stop logic could leave the queue
> >>>>> stopped indefinitely. To prevent this, a memory barrier is enforced
> >>>>> (as discussed in a similar implementation in [1]), followed by a re=
check
> >>>>> that wakes the queue if space is already available.
> >>>>>
> >>>>> If no qdisc is present, the previous tail-drop behavior is preserve=
d.
> >>>>
> >>>> I wonder if we need a dedicated TUN flag to enable this. With this n=
ew
> >>>> flag, we can even prevent TUN from using noqueue (not sure if it's
> >>>> possible or not).
> >>>>
> >>>
> >>> Except of the slight regressions because of this patchset I do not se=
e
> >>> a reason for such a flag.
> >>>
> >>> I have never seen that the driver prevents noqueue. For example you c=
an
> >>> set noqueue to your ethernet interface and under load you soon get
> >>>
> >>> net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >>>                                            dev->name);
> >>>
> >>> followed by a -ENETDOWN. And this is not prevented even though it is
> >>> clearly not something a user wants.
> >>>
> >>>>>
> >>>>> Benchmarks:
> >>>>> The benchmarks show a slight regression in raw transmission perform=
ance,
> >>>>> though no packets are lost anymore.
> >>>>>
> >>>>> The previously introduced threshold to only wake after the queue st=
opped
> >>>>> and half of the ring was consumed showed to be a descent choice:
> >>>>> Waking the queue whenever a consume made space in the ring strongly
> >>>>> degrades performance for tap, while waking only when the ring is em=
pty
> >>>>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>>>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>>>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>>>> tun/tap+vhost-net.
> >>>>>
> >>>>> Test setup:
> >>>>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>>>> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
> >>>>> mitigations disabled.
> >>>>>
> >>>>> Note for tap+vhost-net:
> >>>>> XDP drop program active in VM -> ~2.5x faster, slower for tap due t=
o
> >>>>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in pe=
rf)
> >>>>>
> >>>>> +--------------------------+--------------+----------------+-------=
---+
> >>>>> | 1 thread                 | Stock        | Patched with   | diff  =
   |
> >>>>> | sending                  |              | fq_codel qdisc |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1% =
   |
> >>>>> |            +-------------+--------------+----------------+-------=
---+
> >>>>> |            | Lost/s      | 3.606 Mpps   | 0 pps          |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3% =
   |
> >>>>> |            +-------------+--------------+----------------+-------=
---+
> >>>>> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>>
> >>>>> +--------------------------+--------------+----------------+-------=
---+
> >>>>> | 2 threads                | Stock        | Patched with   | diff  =
   |
> >>>>> | sending                  |              | fq_codel qdisc |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1% =
   |
> >>>>> |            +-------------+--------------+----------------+-------=
---+
> >>>>> |            | Lost/s      | 8.269 Mpps   | 0 pps          |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0% =
   |
> >>>>> |            +-------------+--------------+----------------+-------=
---+
> >>>>> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |       =
   |
> >>>>> +------------+-------------+--------------+----------------+-------=
---+
> >>>>>
> >>>>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kerne=
l.org/
> >>>>>
> >>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>>> ---
> >>>>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>>> index b86582cc6cb6..9b7daec69acd 100644
> >>>>> --- a/drivers/net/tun.c
> >>>>> +++ b/drivers/net/tun.c
> >>>>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >>>>>         struct netdev_queue *queue;
> >>>>>         struct tun_file *tfile;
> >>>>>         int len =3D skb->len;
> >>>>> +       bool qdisc_present;
> >>>>> +       int ret;
> >>>>>
> >>>>>         rcu_read_lock();
> >>>>>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> >>>>> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_b=
uff *skb, struct net_device *dev)
> >>>>>
> >>>>>         nf_reset_ct(skb);
> >>>>>
> >>>>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>>>> +       queue =3D netdev_get_tx_queue(dev, txq);
> >>>>> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >>>>> +
> >>>>> +       spin_lock(&tfile->tx_ring.producer_lock);
> >>>>> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> >>>>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_prese=
nt) {
> >>>>
> >>>> So, it's possible that the administrator is switching between noqueu=
e
> >>>> and another qdisc. So ptr_ring_produce() can fail here, do we need t=
o
> >>>> check that or not?
> >>>>
> >>>
> >>> Do you mean that? My thoughts:
> >>>
> >>> Switching from noqueue to some qdisc can cause a
> >>>
> >>> net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >>>                                            dev->name);
> >>>
> >>> followed by a return of -ENETDOWN in __dev_queue_xmit().
> >>> This is because tun_net_xmit detects some qdisc with
> >>>
> >>> qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >>>
> >>> and returns NETDEV_TX_BUSY even though __dev_queue_xmit() did still
> >>> detect noqueue.
> >>>
> >>> I am not sure how to solve this/if this has to be solved.
> >>> I do not see a proper way to avoid parallel execution of ndo_start_xm=
it
> >>> and a qdisc change (dev_graft_qdisc only takes qdisc_skb_head lock).
> >>>
> >>> And from my understanding the veth implementation faces the same issu=
e.
> >>
> >> How about rechecking if a qdisc is connected?
> >> This would avoid -ENETDOWN.
> >>
> >> diff --git a/net/core/dev.c b/net/core/dev.c
> >> index f48dc299e4b2..2731a1a70732 100644
> >> --- a/net/core/dev.c
> >> +++ b/net/core/dev.c
> >> @@ -4845,10 +4845,17 @@ int __dev_queue_xmit(struct sk_buff *skb, stru=
ct net_device *sb_dev)
> >>                                 if (is_list)
> >>                                         rc =3D NETDEV_TX_OK;
> >>                         }
> >> +                       bool qdisc_present =3D !qdisc_txq_has_no_queue=
(txq);
> >>                         HARD_TX_UNLOCK(dev, txq);
> >>                         if (!skb) /* xmit completed */
> >>                                 goto out;
> >>
> >> +                       /* Maybe a qdisc was connected in the meantime=
 */
> >> +                       if (qdisc_present) {
> >> +                               kfree_skb(skb);
> >> +                               goto out;
> >> +                       }
> >> +
> >>                         net_crit_ratelimited("Virtual device %s asks t=
o queue packet!\n",
> >>                                              dev->name);
> >>                         /* NETDEV_TX_BUSY or queue was stopped */
> >>
> >
> > Probably not, and we likely won't hit this warning because qdisc could
> > not be changed during ndo_start_xmit().
>
> Okay.
>
> >
> > I meant something like this:
> >
> > 1) set noqueue to tuntap
> > 2) produce packets so tuntap is full
> > 3) set e.g fq_codel to tuntap
> > 4) then we can hit the failure of __ptr_ring_produce()
> >
> > Rethink of the code, it looks just fine.
>
> Yes, in this case it just returns NETDEV_TX_BUSY which is fine with a
> qdisc attached.
>
> >
> >>
> >>>
> >>>
> >>> Switching from some qdisc to noqueue is no problem I think.
> >>>
> >>>>> +               netif_tx_stop_queue(queue);
> >>>>> +               /* Avoid races with queue wake-ups in __tun_wake_qu=
eue by
> >>>>> +                * waking if space is available in a re-check.
> >>>>> +                * The barrier makes sure that the stop is visible =
before
> >>>>> +                * we re-check.
> >>>>> +                */
> >>>>> +               smp_mb__after_atomic();
> >>>>
> >>>> Let's document which barrier is paired with this.
> >>>>
> >>>
> >>> I am basically copying the (old) logic of veth [1] proposed by
> >>> Jakub Kicinski. I must admit I am not 100% sure what it pairs with.
> >>>
> >>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.=
org/
> >
> > So it looks like it implicitly tries to pair with tun_ring_consume():
> >
> > 1) spinlock(consumer_lock)
> > 2) store NULL to ptr_ring // STORE
> > 3) spinunlock(consumer_lock) // RELEASE
> > 4) spinlock(consumer_lock) // ACQURE
> > 5) check empty
> > 6) spinunlock(consumer_lock)
> > 7) netif_wakeup_queue() // test_and_set() which is an RMW
> >
> > RELEASE + ACQUIRE implies a full barrier
>
> Thanks.
>
> >
> > I see several problems
> >
> > 1) Due to batch consumption, we may get spurious wakeups under heavy
> > load (we can try disabling batch consuming to see if it helps).
>
> I assume that you mean the waking in the recheck of the producer happens
> too often and then wakes too often. But this would just take slightly
> more producer cpu as the SOFTIRQ runs on the producer cpu and not slow
> down the consumer?
>
> Why would disabling batch consume help here?

We could end up with.

1) consumer wakes up the producer but the slot is not cleaned
2) producer is woken up but see the ring is full, so it need to drop the pa=
cket

This probably defeat the goal of zero packet loss.

> Wouldn't it just decrease the consumer speed?

Not sure, we probably need a benchmark.

>
> Apart from that I do not see a different method to do this recheck.
> The ring producer is only safely able to do a !produce_peek (so a check
> for !full).
>
> The normal waking (after consuming half of the ring) should be fine IMO.
>
> > 2) So the barriers don't help but would slow down the consuming
> > 3) Two spinlocks were used instead of one, this is another reason we
> > will see a performance regression
>
> You are right, I can change it to a single spin_lock. Apart from that
> I do not see how the barriers/locking could be reduced further.
>
> > 4) Tricky code that needs to be understood or at least requires a comme=
nt tweak.
> >
> > Note that due to ~IFF_TX_SKB_SHARING, pktgen can't clone skbs, so we
> > may not notice the real degradation.
>
> So run pktgen with pg_set SHARED?

Probably (as a workaround).

> I am pretty sure that the vhost
> thread was always at 100% CPU so pktgen was not the bottleneck. And when
> I had perf enabled I always saw that in my patched version not the
> creation of SKB's took most CPU in pktgen but a different unnamed
> function (I assume this is a waiting function).

Let's try and see.

Thanks

>
>
> Thank you!
>
> >
> >>>
> >>>>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>>>> +                       netif_tx_wake_queue(queue);
> >>>>> +       }
> >>>>> +       spin_unlock(&tfile->tx_ring.producer_lock);
> >>>>> +
> >>>>> +       if (ret) {
> >>>>> +               /* If a qdisc is attached to our virtual device,
> >>>>> +                * returning NETDEV_TX_BUSY is allowed.
> >>>>> +                */
> >>>>> +               if (qdisc_present) {
> >>>>> +                       rcu_read_unlock();
> >>>>> +                       return NETDEV_TX_BUSY;
> >>>>> +               }
> >>>>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>>>                 goto drop;
> >>>>>         }
> >>>>>
> >>>>>         /* dev->lltx requires to do our own update of trans_start *=
/
> >>>>> -       queue =3D netdev_get_tx_queue(dev, txq);
> >>>>>         txq_trans_cond_update(queue);
> >>>>>
> >>>>>         /* Notify and wake up reader process */
> >>>>> --
> >>>>> 2.43.0
> >>>>>
> >>>>
> >>>> Thanks
> >>>>
> >>
> >
> > Thanks
> >
>

