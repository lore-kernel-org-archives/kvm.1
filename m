Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793704746;
	b=5C4CymbNad867TKzM//sGvNwXn0EAxM8cOFBDCuxsdAgZrvs/tDjXNYY7ey673ulq9Qd
	 FbMmztL7JB6xez6zvxvysV8Nr87uOi9PfV6ElyI7HTZSJxQvrzFhRa1e2+0m3XUmw6IV5
	 VTUNlCvjwg/VE2XIRlwku0GYojqwLV6AjTjCBYEqUIqNUq7+vNoK6IlQAMkkJJ7cSBDPP
	 EaV3INt4HUx1ee2UD80RsLch8dxM1PQkUTWHE0ShPRLJeIIaLuj3k7dvY9tvvwOtIc7Ng
	 2ooPO+pKkIEgBN3zkR9GAZB2dokEHNlrqPvB0yM6vp4e5kIzpdEx7QzAgv6M6pluJEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704746;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
	b=5D1UQv27QhtWD3w/X3gikFCiaG0VPBbnJ/TvL9GmpO85VkaqFZGhAXO1sThBO8pECqSK
	 D4swnKHnhAV7iBxBQPSNrnvULSeoKqCwj4l3f/MfAfx7/lFYvbl6w2sjR9SXyUEWIbgM3
	 n9lxmCZ5d+UX3Y6QEH/zbUdBOh6YGM1j7e5I5n6HWqWEqVVJ+Bb7996bwOtdDQvbFfufw
	 Rv+eenqVhn/oLCHy68B09e/JEXBH12duFnnf8LN/GwvOwjctcEG9TW4uRUbjbYbP+Jm0Z
	 eX8MthZzRxG5LafMZP2puFIfwDL1nbJdwGwP+ChnWovw+6tuJHIr3mAhp4/J6y0kORg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUJ4cqvg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SnJgLk0D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECD606C580
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60ECD606C580
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JUJ4cqvg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SnJgLk0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793704745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
	b=JUJ4cqvg7HIxCd1RC5B4xEyWu5aBvq6keFe4Xvk50F1l1aVZuibSrLf8HMQ2a7WjLljRo2
	b5G1vwTLHUEJxa7Ybp0QRRw3kKP8N52kIc5a0XaHn6kqqun6j2WeLsNN8tDfXz7Ehd2SV+
	IVtfr5GsHCsWrVGSO/ZbeVySJ15V274=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3coi8Q2iP6yZ55QTXWGGKw-1; Tue, 03 Nov 2026 06:19:04 -0500
X-MC-Unique: 3coi8Q2iP6yZ55QTXWGGKw-1
X-Mimecast-MFC-AGG-ID: 3coi8Q2iP6yZ55QTXWGGKw_1793704743
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso2857697f8f.3
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 03:19:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793704743; cv=none;
        d=google.com; s=arc-20260327;
        b=nxDZcRkab6A61CMiT0zd6IwwmlGXhRuJGL/cvum/yH54FCPPO4MWrg0Bhj/prYGaG3
         6c4ay6GVAwrDNIFTUET56QyfvMS4i9EJ2oIXoDeTpwM27gpB1+6qjVmnZ8MUb00OLoEs
         W2qvoMWQ5pvuDTA34lQMyFzIKBOwYmkhbK2jqEDqJM5KE39bNpECECYmhRWPDTWjUJzk
         y7rLA9fHXcGf5I/U1hxzJbS83jX1oDPJxrkSyKFVXkZGeLFmEf1F1qCth7Z2pwDN6dW6
         0+F3QzzEFwKb08i6DW7vw4IjoGCGaAqPBfxn5sthpK2oZN/k2TlJ2Xvp9VThDMzahEoL
         JMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
        fh=OKnIc42KuFi7BE6ck5JmuRd78xQ9E1Wf9YShR0jzpOU=;
        b=khRvJm8sbiPPue1P4Y6wQWnT8GZtHZAc+UXtU4jijq6Q4gr901CxyEHwn0XVn0NzYZ
         aUGG//bsS9/7w2/KmO5YXo82CO00bF71ZnRcK1QbG7r45A7euzwmdDkRlegWKcumInI+
         d9IyJPVslpcwd29jjYg4r5UzwHAaI+Mh27+4xBJQoagSSVc8G2J08ml7Mx99IJOYaE+u
         +wdQKKH2eV/N+/P6qM+d8HyA8l8LkapPU0ef099YQ79LQMjgZHE3LcYVPQ300hG1Te4i
         GH7ETGPLi40KbwLw+YC/SBC3JljDEmyGuQN4J45+7Jencj5d71wd93xs6qKy9IV6tkg7
         brLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793704743; x=1794309543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
        b=SnJgLk0DGMT/nVwT1Q+Xp55G0e+t9TTD8b3sE5b6/KVMciUxNSqZVxQY2GCxCgjvpF
         TPlLpGcUDzhoNZdR/rHgpk3ZirH4n4N1a2W8q2bKG+EqZrK7mlJtayK3T+JzU/JSF5PH
         otKrybmqSSYMG0gEpunrCnPSmLQsC0WE8glx1amR3gLmdCMI64IrxHQo3dFjeL24sUD3
         MPVo1Y24NsjSQAVIV2L1OtpGEJk94ap/8UewTJfvasG1VvLSVtwgvb5VFt9KZIfo/V4M
         YzZVpgdbuCqG+3FP49f15GPAUhoQHvHI6PKWtoB1q6BnEOdDUZgoz+Ny4hiH6J+jJTEg
         hWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704743; x=1794309543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoGPgCpYCXIZ2TVcCltrAuHOCg1Xoc0aHaKBD0ahpDY=;
        b=kLodaAq7qMwpsS8JUfQlKvKrA2kClLK93A38qc2wbIs0OvlyNOdxOEactnSgpaNwcI
         k9aXXvomoYW+OaHqdPRbweFoF7Hrk9gBkI8ygHw6LrMTn2ppdHGomUrt4el5K1XyUzWW
         IVMT4uBMX9T3hcKaLFh5zxVgxl8BtPsPQl529Lj7qmhMbyxwrkZhH7+yPX2oAzI1HZhE
         oGTTRf1+UoRn/yajV69XCS1WJ6qV/zY/7oQK5/avFv1Wbz3Zx8KLLnQpX/hZXiCwnoUZ
         Np59nlcniK2MDiwGhyReWp5+zIywSZI614I7p6AnsojDgvx1sM0F3xJ/6JVv6ZSyi7cl
         gHPg==
X-Forwarded-Encrypted: i=1; AKwUvBzimtx6Sf6KJJzlDBtwpQnvM5M18dyM+KJ9/eZhvxFHjLklje8mZ7MHp6T6fQTRhrWOSk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Hlm8xBVdNUDgFy/gcU2NoKUKkBp1TbeGkhNP+BLr24/lH5juX
	LFla5+LdZkmITHkv6wrsLoaVttz4Pzew9u4QS1DYMHk02nvAZMlYMlnSo0PibEIP6SQn/vYvDkh
	sm3CgKEUApaup+tCqzQ0Ba2/XCBDP0bQ6TyOGJ38cB7aPpbQqNnC33GpmORcl2MoxWoQQ1XcTHw
	j5uS+aLLmuvgRF2oBukMShpdC/wRZh
X-Gm-Gg: AYBFou12Mc6kEcgeZi3fTaCTlvLuKGMS41pzw8jOysuvnGgEtBkf1g6mE1uTDEhegaC
	Zqxa4c1lTXkWd1wIuC0I4adD5lELub6UtIFUo0VFrYWy6tpPXRp5vRck7WbtsWa+C4iSdiRJFs+
	p2Nq7Zh2PjV+ZAx50xjRKWv/K1PZBg0jSQrmVhHE7Xh/qWINxE9bG006dC3pwKbm5hlhkOXKIAN
	WCxAtehPGHopDtZEu8RwKeAh3n23x3G9RAkalS5jyVoL0uC4csgMK/+vZp9
X-Received: by 2002:a05:6000:41c2:b0:48e:6f76:de9d with SMTP id ffacd0b85a97d-48e6f76f5e8mr28351839f8f.46.1793704742874;
        Tue, 03 Nov 2026 03:19:02 -0800 (PST)
X-Received: by 2002:a05:6000:41c2:b0:48e:6f76:de9d with SMTP id
 ffacd0b85a97d-48e6f76f5e8mr28351800f8f.46.1793704742539; Tue, 03 Nov 2026
 03:19:02 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com> <20261026224305.1254-1-hdanton@sina.com>
 <auCucDdZb8mig7UZ@google.com> <auDvUyfzg6nLtVox@thinkstation>
 <20261027163929.2bb28d5b@gandalf.local.home> <aujLx1FOc12E72rF@google.com>
In-Reply-To: <aujLx1FOc12E72rF@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2026 12:18:50 +0100
X-Gm-Features: AclHuK9TCKz_SldDuFHKUBahl0dpObHDrm8b0qWMqlbehXg4DMpHhR2Dfu-OUko
Message-ID: <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 6:43=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > If so, we need to make that a thread for RT kernels if you want to call
> > kzalloc_obj().
>
> Eww.  I can't imagine there's a sane usecase for memory overcommitting a =
real-time
> guest.

While I agree with the feeling, the dummy allocation path should be
mostly dead, because page fault should never (?) enable interrupts
before waiting:

#PF interrupt gate
  exc_page_fault()
    kvm_handle_async_pf()
      __kvm_handle_async_pf()
        irqentry_enter()
        kvm_async_pf_task_wait_schedule()
          kvm_async_pf_queue_task() <- registers waiter
          prepare_to_swait_exclusive()
          local_irq_enable()

The dummy allocation path is only reachable if it's an L1 hypervisor
that is getting an async page fault while L2 is running, because it
enables irq before the call to kvm_async_pf_task_wait_schedule(). I
think we can drop the dummy allocation for good, which would be even
better.

Whether you would still want to disable APF for RT kernels is up to you.

Paolo

