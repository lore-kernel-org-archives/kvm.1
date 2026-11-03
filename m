Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739372;
	b=bIvKQC755dvoqJBYzU+S4Q8tdW9/EYmpfYPm/l45NrrviZWtyqXjcxiG1d5cp1NsCIiz
	 IPNDvk9v3vchHZ5BKX17qr86/QxlBbYJSv8EG5AXnPUmh3/5LqcXm6z+5adm37njR+kIH
	 4RKEhuUChQ92/GjevtR8iQ/ql+8nxLLogO0PCp9B/2Zw5b7XISTHJaPLTojgYUbT4yq0Q
	 159B/wR8M+DJn5xGOu/c46mCOulQZfM+wVxEkgSSn6iTYMLwUtG/ZAcXpqYYrbr0Vqkb1
	 FTSpTJRJQYToMLuCGkPpRR2tScBA7X4Ly1dicfQL8J8PwxjO0rUe79YsdvwHFhY872g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739372;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
	b=lEIn4GgFsegMYxID9Cs1IQUEZ4rrElzaoCu9FeQQ3k+TBjwVIy4au9fLFV1iu/nPV9Ba
	 uiQ3hFhrkGyUISxJyB0a/0zNuqqhqjK7qzK/1lKma4ZgCIYWqn/OAbE6S/gP2Uv441Y8O
	 MryhU+YKukgHA/4lZd8dCiZ8zXa3rbWOQaNYsrEqvNKnR3BNu2aEkLhqMe0EMPKClUh1V
	 MSLRFoPh+4UXC4bJnzPIZI7s5D1SQnRTIYpOMTNuFXkg+AolEEAlVfDQ4a+Kiy650ZLE/
	 N2CEhKG9b+qnEfcfSqrxpChmfSc1aNSvj8EPNts4+JXa1SUHId1zg6icZFHi5LswOXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2U+Oy10;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EvRt06rc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA6606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 20:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AA6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2U+Oy10;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=EvRt06rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793739360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
	b=K2U+Oy10KM7Fc26c+kfydX9SUQLUfffKBND5sj+eSD0LEY9d9YqukUSYgwBvZBi+KxXuM+
	87vykFB79Bv01VmS7OQaMhjr7NcQaHvgky6swFzN7C6lyODuQGy9IqX9WliehVpLyd2btC
	0GGrxq5Cxr6fUedADKPHWhzuYJrrHjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Wl5UNATINwSighYXAmz4HA-1; Tue, 03 Nov 2026 15:55:59 -0500
X-MC-Unique: Wl5UNATINwSighYXAmz4HA-1
X-Mimecast-MFC-AGG-ID: Wl5UNATINwSighYXAmz4HA_1793739358
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48af5a07314so8794f8f.2
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 12:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739358; cv=none;
        d=google.com; s=arc-20260327;
        b=hsaV9jiAr76J2Bu6uJT2ybfCnjNJTvClEvvghEsQou8XRk+VybjhB4a9TSgQdHAFZP
         8QC/lLD2XJmUjPxyUYSxKvA+ZtSOygodbL1dZjwrf9r0zlKFycsuEUWNLBFr8E1B1x+g
         Q93DEvyjmpc94Sr0zmNU170HKj0awX4rsUoOnDEUHXG1Mgc3KRtL2v4SnnR3DHbvky8X
         uskDmkylXR2iFti9RRn1+/jK0K2GIzxpCO+IGoeiGGqqeelnfVzMGzYp1DGu9vWtw4pQ
         ppCjfggoDWhrkqbxhvU0bkB21lPkPrtPSsyoB5e6g3EKZB5qId2TpUraYhZRYC0Lcj9r
         ak5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        fh=iEIkph2cRxSC+Sn884Mz2bIiXVWbXPngMtDjczTeepk=;
        b=QaawTTUFcSY6E5DqZlEUw8/szmpXQzIobk0qp4W/+JEcLdBcSH0ie242+R0Kobeut9
         tSO2G08A9AEGCzVcRwMO/8LvUN02xB9SYAolbjSQAxRUcSWWWvfssuNZsa9gF/MjgcEo
         Y6F6YVgLO5HJW88f/PC9WCoXgMvq3xQ28FH7FFtuYwQiUq5Opuutj56qXhXl144Dlc3k
         kHI1w8dNoljXUd8JMfuFCkbtM/j6SDkqXc2Chc/5Z488VJz+RYLsAPGO6asLcNsYb9yZ
         CgccJx5OgXEGiWRbT7LGZwPG8NWLcSyGY0ZhzVzTvdLQTFJDNjaoicB+sJnq6yA8APWX
         djVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793739358; x=1794344158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        b=EvRt06rcENLPGZTISqugrXcti/3DIXMpcTLyZXzDagPNxAays0a7NDHqvSUKlLvkuG
         dtwiPancTukm9o29Jik0KyD/5j2pnfNEuT88IyFwbIpsrYwexGaOccAVHzpvcLvEUjhF
         qLgjuLFApK7lAfd5NNegmmGvpeeusEvbZfSQ8u/k/qODM8oTHxkzACvOdLPixBlZlDin
         ZtQgLJCWcCIrAAZGhydl1CeQNR01MV/wFfJmk7VpFb7RSwugdN/8u8dEeUM5g5/5Ns6B
         U1sTGln7qQHmzmEkBb/uG5Qrpb1wsj9GlG5rrGwULFuDwR7wJJPxkw1kNSs+IoMEt7Vw
         +qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739358; x=1794344158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wXKDb0shvTVmV3AagAoa11gS9VL7nY0cemZyFZyr2hY=;
        b=2yuy5XmtGclSyLUvAgw/p9ZjKlpZ2AR61wywv+BdBrO/IQLRi9o1jk7VMPrzehdtew
         ZJqegZ7lb3WGwA/JHjcF7OWL/zHc/sl5knwIFli6Z6629Ml8Ov5FSqTifeM8J+H7nIU+
         RGSrm0s2sMnolGFtRq/907acsvdgfPH4zfQrfwfW6vA+V0UMphgsfb3Gki7sf9jEVk/q
         50lgGSRKHgBMXl6EpeD2GHEE1igPgGsdQ4bL/ySQ8s3t98RIV+opzW2cunod6CjC5cHh
         OCp2IfWxTLdRWyf3pjK99KZSvRPpQkOm2Y6UIRxD/r7OK3BsLgU0SgHooG3702TMNlVa
         1qtg==
X-Forwarded-Encrypted: i=1; AKwUvBy3cYhma5gQrDa+j+V2dzErIlvxsSeRosBfxkrCrl8iVzI25JINtai4480W1CzXfo0n0Ck=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4tISSj1q9m3ke+LxwDosFT3trs9f8M1UlqBAhBPjBJGeASBcD
	JxxHsJo+/I09Ucbu9AH4Dd9ItMVAvtojUAtECGUwH7gtctcj+TXM6UFoCFJSCv4KY+fuUm0pZbQ
	i1jvl9PTDAZLw75dVkyRurY08qqx6F/qzvJ3SBsoh2cnxc3412DnbhmV+4apdNJkjih4xBBhOLn
	Cve1NoFu0TOgOIaNyIBaZSPx+Cmuzj
X-Gm-Gg: AYBFou3Gc8/qxiqc0plq8EQa7ArUv+cGqt/ZXGDkaA3Db3RTeB2yrMc3qsNwqQ9xPty
	KMleUJ4xIj3l7PJ/8GJMIVwywcA0141lOAyPgRQY8Ikbwtd+r2BLkhmUKdCa+EYgy1Sov+cppEF
	TgNfPtM9L2AGhc6giakl5MiWs8Y/Hc7frk0IuRcfO8+wL6SjggVv5dt4fOYt+gr9GpjQ+LASTdJ
	p72pUh3ED868ukWGxJPvtMTCZDJV/8XlERZYfj/phCYeDO2IYJlvasr0WSv
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id 5b1f17b1804b1-4ac18e5dac8mr298620525e9.34.1793739358099;
        Tue, 03 Nov 2026 12:55:58 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4ac18e5dac8mr298620325e9.34.1793739357803; Tue, 03 Nov 2026
 12:55:57 -0800 (PST)
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
 <aunzE4yywHJOqsk4@google.com>
In-Reply-To: <aunzE4yywHJOqsk4@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 3 Nov 2026 21:55:45 +0100
X-Gm-Features: AclHuK9NbLFeA4rOMmjWiElPvRKkJKekyTJisFXX1WKeTFZUAYkS3xpedGH9E5s
Message-ID: <CABgObfbvv-fQnC35EU+TxEtNMyYA0wgJ-nA_2B1eqKrZ_2qqkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: register asynchronous page fault waits with
 interrupts disabled
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mar 3 nov 2026, 15:43 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> > KVM cannot use a node on the stack like kvm_async_pf_task_wait_schedule() does
>
> Oh!  Yes, KVM can!  If we fully handle the PV async #PF in vcpu_enter_guest(),
> then the node can be put on the stack, right?  Juggling preemption and guest
> timing is heinous, but on the plus side it consolidates the PV async #PF code,
> so I think it's a net positive?  Especially when factoring in the node stuff.
>
> Fully handle PV async #PFs (when running as a KVM guest) before enabling
> IRQs so that it's impossible for the current task, i.e. the vCPU task, to
> be preempted before invoking kvm_async_pf_task_wait_schedule().  This will
> allow the guest-side async #PF code to eliminate its dummy allocation,
> which is needed only to handle the case where the page ready notification
> is delivered before handling the not-present #PF.
>
> Add dedicated handling for PV async #PFs instead of wrapping/piggybacking
> kvm_x86_ops.handle_exit_irqoff(), as the act of handling an async #PF may
> enable IRQs and schedule out the current task, i.e. needs to be done just
> before KVM itself explicitly enables IRQs, and needs to enable preemption
> before calling into the kernel's PV async #PF handler.
>
> Opportunistically wrap the code with CONFIG_KVM_GUEST to help document the
> context, and drop the CONFIG_KVM_GUEST=n stubs.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

More like Instigated-by. :)

The main advantage would be that it bypasses the missing lock issue
that Sashiko reported, but I don't know... That;s surely nice, but at
the same time it is not great having to add a new callback, and to
duplicate the guest_time_exit/preempt_enable code into
kvm_handle_pv_async_pf().

Not that the extra field in vcpu->arch is beautiful, I admit that, but
it seems extra unwarranted complexity.

Unless you insist I will send a v2 that takes the lock properly.

Paolo

