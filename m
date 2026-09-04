Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB94F0550
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536253; cv=pass; b=Rnz4doMwQj5iDbELMgq3fa3HaaEnc7RATEoNLXokqoM6Vp4q3Nb1D+3MdP/D4qRqlJ+W/zhujdaw9q05lPHzmVK9uXnlQxWKqcEOFVFUm5SPfKhcawvi67wTQUcbOpRTz7EJFb8nfQES2ORN1Ci3qrDwxk10EB4JQ1frzSf5u/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536253; c=relaxed/simple;
	bh=sCBkffF/x+6ivWSUBWyD8pLivoWQ//A01/hYzFbxjrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVyLJ84up+ip2sqVInt9SC/+p53d4vrJ5RLHzj7MrKk9e8B6ou9WbMF+lIICVCmAzMrcvFSI5U6XL5lbloQhUfZm2QZDUV2vb5v9MgkwiW/ma5h/a0u9RdTCF2RA/OETn4vpiUwTEqLjb1hGB9LidqLF0drftAWHU6jcoxQ6pac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6ztyx5H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQ2d/Qrs; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6ztyx5H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ2d/Qrs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788536251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrK07pcEfzHDfc8s9dAeUAxX5iBfU+4JJI3XH4xHwd4=;
	b=O6ztyx5HTPlGBvNEiQ+PGyYnXbg+D8RJgzUuc1Aitw0+MEtMFyTXg968OBcuIMyjBSkmRP
	T8+xMh+scCWtfKAIKNkqxjCfjJOQjG9LpOEPeds7jxq7UCI0X0qBXswJqloJYuORmdb5Gz
	U2d6QXowb2Fn0Z86K1AJDS7WiPStk2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-4jLJbLTdPLWLylcV4qo0nQ-1; Fri, 04 Sep 2026 11:37:29 -0400
X-MC-Unique: 4jLJbLTdPLWLylcV4qo0nQ-1
X-Mimecast-MFC-AGG-ID: 4jLJbLTdPLWLylcV4qo0nQ_1788536249
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495569acf8dso7593385e9.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 08:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536248; cv=none;
        d=google.com; s=arc-20260327;
        b=PBLBsx6K5/bbM2kdgBDzO6aeznqHU2IIL2WQ4CFNDO95qvVL1+Ljj2iAomCb6odms6
         WQaN8SCUvxtCSCyk/vWe9nMbXM3mX2jU7XnYhoFMnhwKpO3ITYGhxiellqDZWV8U2xNC
         xjDe8hz95/dV9SbMgO5aVNXYNNpXRlPhpThy6hySfAPaWSgfkV/hATSmvCO0rjg4Rlxx
         dFXEZeArQmnFguFe4+AkK7I+rzx67fIOHjFUuZXbaygyT2XXUUqONL/1wyem7EV1fXv8
         Ru55nvfGu3xxQ0BJmS5DQ2nZs2SOLz/9HbERxgU7fgtsPazy+svdj3iBDxk/52Gb+vyd
         Xm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rrK07pcEfzHDfc8s9dAeUAxX5iBfU+4JJI3XH4xHwd4=;
        fh=3sk59ukVivFBWCnKHotH8vn2Cqv5XsUG2G6NvdGlfG4=;
        b=Xhp6yuQnSvHZcSnfi6vEc85XaaxFxo8S/LwEJUVyGD8oRkS1SAFVdpGyOzQOoxUM1S
         xr85+tw6v2bSMyffwWTREt5nifrvVqdneWbhQjqsPDBdTRCx2NOQ6yzzTTlobA+lxymY
         9Hewj5TIVN50VM5dDyLwKlP9B+9XgnmV6eXetuwJOdDKg4kl+6Ig1OocvfOFBxNDkl0Q
         gKfHVKRUhyvPocEWInCNFnXuF3kriGs29Prn8q8TVzA2ONjdcRmtT3rK+aqcYD3GF8TJ
         aGXjrXBrmswMf3nwsEvq+KHAYi2dd8yeQGulWPwkXtBlF3jCrQsIO78r3aSUdcDiM7Wf
         hUAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788536248; x=1789141048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rrK07pcEfzHDfc8s9dAeUAxX5iBfU+4JJI3XH4xHwd4=;
        b=KQ2d/QrsoL1mKs3o9CNAIkCZwP7sOlNuKP11sfuv2c/zzIj3Xx99RhYNmRtnh/KV4N
         Yxoj688aFpWtuvq+DxZ9nfo3se09bdmW77HhLnyKoUqDAoUJLW/A/N75esf4goPvxz0B
         3Mkqe2OqoubvG9mZ60QpGLPLG1WEjez8A49LefC3mYcS54SK1d6YCM1wg1mxyowbbalS
         LMw30Hne/v5wQBEdADkn7odaJvyIU7UHWEG0czDW81vlFxfVd2E4z4b3uh/KdZ4bNEbq
         TZ6UZjg1UT1d3bISfdYu1cRVB6eNhqnawxPFqE95cZIaj4RqKbk3YOChr97KiSs7G5vz
         ndiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536248; x=1789141048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rrK07pcEfzHDfc8s9dAeUAxX5iBfU+4JJI3XH4xHwd4=;
        b=HnqutEdGNYMa4sBDgc58KCthUrM8KrMBONMmeiB/BjprF4BvsUoxq3ikEjHkXknTrf
         grupWzcLfpiToo9tE5U1HsjlB74TNu4gE8PI8w6J9fdQRoaRqaLq60OUC1yhogGSEqbp
         8VSXwfEEZ/VSzSEO+xXf7YEwJh8Itly+64lQJ+XVqEP1dQVL4+UiOIFk425rg/j6BOMo
         fmmDTJqAqtd9s0XLSzevjnhda+2zHk7hw6i3Twi3b3gbFUlukYzb4KBLWSDeDQuSkeiH
         t8mQgQ0yzkrkLpA3gZedFOCfojF6Xdg85vjScz0gWION+VJxEl6hm5rRnIaPxoE6xAgF
         Ff/g==
X-Forwarded-Encrypted: i=1; AKwUvBzWtdstpMCdR1xA2DXF6Fy5HA/yT3R0glIk0WlluYbiJjoMCL1mK5nOclOKubFfsz4YC9I=@vger.kernel.org
X-Gm-Message-State: AFuF++nQed6GX+L/9kfGsJzZMXybs8PIjhnnOlfEY+wRr44MDKsdGFIr
	9Fo4PqRXxYvZ+ciWEhktkLvjgG9JquWbFHvU3Pu6AuKFlUzBnSom67mfnz9PWWzGH/tohGHQLng
	Vx6fhjITy13onmItOswHXpN+zel2m6WLZ9/fmAqzgfkzoa/7ZhRB4LcSLV/UXFx7UmxmeE4XRGD
	WaoqdBlHU8of4Qvnige/5BQfzeS+oJ
X-Gm-Gg: AYBFou3pXW+ovTu/uSYqA9xJudeX2xfMmWTaXj9lVI0z/CNS282wmGXhqE2XqmmJbO+
	bp3hElBctl+zD5AgPzNfUolQfHNYWqsrE0VOa+5ywTgMCe3dylWHIXucG6dK/tJCYWqU+SPRsxV
	zA1NYevmYoktDx2354XJrESP/cdXIYuO0HPJPOtkS2qYn5ZUWUs22OsO/Fs8G6Ht9Q0VUU0M1vX
	4XpISBwooYWmlnQiADjfw7rL98Nyrxv7cB4c0uKaMhBiEC4Zs8Afrz1Tcd5lQ==
X-Received: by 2002:a05:600c:468b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49cf8214eaemr97285975e9.8.1788536248623;
        Fri, 04 Sep 2026 08:37:28 -0700 (PDT)
X-Received: by 2002:a05:600c:468b:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49cf8214eaemr97285005e9.8.1788536248224; Fri, 04 Sep 2026
 08:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831213632.81023-1-dwmw2@infradead.org>
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Sep 2026 17:37:08 +0200
X-Gm-Features: AcwNN1XbrXQRdBqaPVwlG8lJe2LjPmHbNMIXKEiTmO74fasedEPvKI1EXe7LwZE
Message-ID: <CABgObfYgYrjf2xbvyvLVmX0iJgUjoZ4N84aNiBgW9_oshaSh5A@mail.gmail.com>
Subject: Re: [PATCH v3 0/13] KVM: x86/xen: Bug fixes and long_mode cleanup
To: David Woodhouse <dwmw2@infradead.org>
Cc: seanjc@google.com, paul@xen.org, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, ankur.a.arora@oracle.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	x86@kernel.org, syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, suryasaimadhu369@gmail.com, lkp@intel.com, 
	nicoyip.dev@gmail.com, frn1furkan10@gmail.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imv4bel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:36=E2=80=AFPM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> Clean up the handling of vcpu->arch.xen.long_mode to be consistent and
> correctly handle 32-bit/64-bit alignment. And various other bug fixes
> that have accumulated over the months since v1.

Applied to kvm/next, thanks.

Paolo

> v3:
>  - Rebase onto kvm/next (7.3 merge window).
>  - Add poll_evtchn READ_ONCE/WRITE_ONCE annotation (Chengfeng Ye).
>  - Add evtchn_ports IDR to XArray conversion (Furkan Caliskan).
>
> v2: https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.or=
g/
>  - Take kvm->srcu in __kvm_xen_has_interrupt().
>  - Add dedicated invalidation sequence for HVA-based caches.
>  - Take Sean's version of the 32-bit atomics patch, and his follow-up
>    replacing the remaining asm blobs with atomic*() APIs.
>  - Use GEN_BINARY_RMWcc() rather than open-coding the btsl.
>  - Explain why the pending_bits access in kvm_xen_set_evtchn_fast() does
>    not need the same treatment as the vcpu_info one (it is in the page
>    aligned per-VM shared_info).
>  - Don't require 8-byte alignment of vcpu_info in 64-bit mode; always
>    accept 4-byte alignment, so as not to break migration of guests which
>    registered while in 32-bit mode.
>  - Add Closes: links for the reported issues.
>  - Cast to u64 before the >> 32 in the unaligned evtchn_pending_sel
>    handling; evtchn_pending_sel is unsigned long, so the shift was
>    undefined on 32-bit even though the branch is unreachable there
>    (kernel test robot).
>  - Rebase onto kvm-x86/next; the mode-aware kvm_<reg>_read() helpers whic=
h
>    landed in the meantime subsume most of what patch 1 was doing by hand.
>
> v1: https://lore.kernel.org/all/20260605143034.3603-1-dwmw2@infradead.org=
/
>
> Chengfeng Ye (1):
>       KVM: x86/xen: Mark poll_evtchn accesses with READ_ONCE()/WRITE_ONCE=
()
>
> David Woodhouse (8):
>       KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
>       KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
>       KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
>       KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
>       KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
>       KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_se=
l
>       KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
>       KVM: pfncache: use a dedicated invalidation sequence for cache refr=
esh
>
> Furkan Caliskan (1):
>       KVM: x86/xen: Convert evtchn_ports from IDR to XArray
>
> Hyunwoo Kim (1):
>       KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()
>
> Sean Christopherson (2):
>       KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't=
 aligned
>       KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents
>
>  arch/x86/include/asm/kvm_host.h |   3 +-
>  arch/x86/kvm/xen.c              | 212 ++++++++++++++++++++++++----------=
------
>  arch/x86/kvm/xen.h              |   5 +
>  include/linux/kvm_host.h        |   2 +
>  virt/kvm/kvm_main.c             |  10 ++
>  virt/kvm/pfncache.c             |  18 ++--
>  6 files changed, 157 insertions(+), 93 deletions(-)
>

