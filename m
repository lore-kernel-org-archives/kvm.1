Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99793D34AC
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371828; cv=pass; b=Ua5f7IHY+ipD5KBO85CI8enlqvU6OnsSBWzw5+9fyuL9ek12qm+IUHyWAAS7MxUpplCPg6Hach1SdA7vMhb7J88+cm5stKdzb1zL8P73tRxsCNpuTMZ9p561Y0vmMqrfCGpxJOYmosLYgfQPG1QFsfNeSCuLPx6hvpq01dcSy6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371828; c=relaxed/simple;
	bh=+4PsRC5hwApRTiXF310NHGd95lX5jYUr3TuG57fBErE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5uLFduM78P2edSskG/uoy7PBtLCK14uPvjNLjpTtKFSIY+RldyzY4rGpdjRP/0xWWsR5B03jzlfV7QifrHrhfJIKYkjCR2UVXSE6mL+/5N6OvfMOaulVkiNQmuBG2c2iWZRr9Z/Q9qaIkJ3XSNXkFzlNu8AwegtV2MZxmdDeDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZkSJob/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9+xyB2c; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZkSJob/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9+xyB2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791371809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftNKrZBb3omsflv+0RPcB0t0Zctu/BbQgYe6snK9jBc=;
	b=BZkSJob/lALGUsUbfQtvqVUaNPVakY8hmjhpRw948L3Qlop9G/TvnNuC/YqVeNkIaYq5By
	PAY5vB9vDGD7hzeDnmeEIaOTbnPsLIz8O3qNv6nFQ7szas1ZxUDPbrrxcos39uWhzMwkl3
	nEwChsAcOMIti4TLj7kb8OrZ+82PuJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-zm9IHRt5N56fWeCxyoRkVg-1; Wed, 7 Oct 2026 11:16:45 +0000
X-MC-Unique: zm9IHRt5N56fWeCxyoRkVg-1
X-Mimecast-MFC-AGG-ID: zm9IHRt5N56fWeCxyoRkVg_1791371804
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so30037835e9.3
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791371804; cv=none;
        d=google.com; s=arc-20260327;
        b=eS9Qs3me3483hppuR+Qoauz9NJUzFl/GjdJGDQjyJ7minlo/SxUDK5kcEYnU00xU/x
         LI4EbxrSJlic2vJ+Fd7pjLxY01pvmYLm12w8vVg3Nj8BnMDSyjlt5VJ+3HqHeB/kSXlQ
         t4xezK0x9yf66Zf0TSeWZ9TKwCHwsDOev0KOff2kw/1UJvnZ72s6t3PMl4MEc16IZEdS
         QMyLx/iMqMqXvlw1ygNyd7tZA42STeTAx7VBIn8lXNlOMptaBYyn6/RA5SWjteXG1bwc
         pBPVOexV6ddKX/PPkKqlZ5kmWZvhJgNRHcf8TpWeBe1gfy7g3wgjHn916KdRAd+9YfOz
         FmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftNKrZBb3omsflv+0RPcB0t0Zctu/BbQgYe6snK9jBc=;
        fh=8AEInnEZ3CTJGOErfCaSXzzUVpIw7VJ5FG2sFEoFGFo=;
        b=kNUstZOuvTFb6BbcLpKMqx/UQH5IJ4GUA6QFD7sP0efiYSJFnz1M+OeGsDWX/bH6qF
         rxw0SDw7mA0Bw8i+YmTGAykgmJDscUeN18VEzAoCm1t7VV9nzz5MJx9HIgmU4Z/sgAN4
         7XjGG16+L5PFfRYx77B7FRwuCnXw046xH8+qom3YUm0WSvwtUOLc9QVilCrD+UgcmLRL
         /udepkliv7XIOfrSaKGNT4Kq1vrC/vDMCpye9nNBclKa2qkBimxo46kFBZT+iALJYaA2
         48IalNaKRtwsXbT415wbBU5fp/0t87gtL2ToHKRTb9/sEPVbYBw/wudOsWu5iNStBcqc
         kwvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791371804; x=1791976604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftNKrZBb3omsflv+0RPcB0t0Zctu/BbQgYe6snK9jBc=;
        b=a9+xyB2cJhqpWW+EDIbjeT80l+WBYu2lwSbm18UrvYy2IbVuv4nIXDJerxhK6H0dAt
         5NQs5l5S1ftqnOcVp35kymeAWXDTnm7bWbVkJnxw19ulTOaprinY7rhMXHSDLQMdplzd
         oRF1EGL3piafWS1Iaytm6owlQ9ZcMOTAXW4AxqIKzBuNqGd4LkqZoHvPCP6aRQywdT93
         J4hIwQLLEZYjA6kmWUSP+89ejfF7oy0noWHfImIsnYQx4pEhu1FWcfWW9uG/ENo8XZju
         +83e1btqFW5ZAjmozT4mgU2C02NICJt065Igo+/1pwUleV1zdXhCDYLgriKLA29kvs5y
         PM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791371804; x=1791976604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftNKrZBb3omsflv+0RPcB0t0Zctu/BbQgYe6snK9jBc=;
        b=ikG5GBsWSHdPf6UlC8jopgh2039o62v1s+lszLwAboTytbbID3L/nA1hLLQSk5ez6H
         zvfrHNRBMYXgcNoZ74EeCqXbsAAugbnOnwEqTDCddEE2N/lN0kpCzI1mdXyOkcu4jj7L
         B0FwU/+F/TJGPh1gvPAoIoIal3gY0QcqZjwg0pIF0l1dUpvRGtQCrRIr33T23uY7kE66
         IpzPlCyvbvgI2RJfXRHEojfnYrP+ldPQ0kdck1kxSc9QYhDehoFrItgLLK3sa1LfAQz6
         qGBEt+e9KxASXwewrfZ/wKDNNU6kWVVoYUFZUhJEW57H8nCGxYNwoGENOXHtSd+o+JHK
         w9rA==
X-Forwarded-Encrypted: i=1; AKwUvBxq0pWpSyFEV/Uyr6UmV1yrUxG+531g0XzTBOKRCjClp/rZP8Mmptuk7hDEEMOvPiFjYDg=@vger.kernel.org
X-Gm-Message-State: AFuF++k88jn+9RSr9ZNyzhfhlxGm0qxEv7RiJ9KCmLooKy6nn/36lRXn
	3pqaXoQ8gJdLCKZSeDv0f/OdLceax/d2fio05X0F24/8w5TdHfxT5XiJuNMXlnX+TWOeJu8cVqp
	nDR+oLAGOa0Hj0KbApuRxzPacOxP6tVFdEz1zykJcYn2d2v90LZpCciG08f7fHWX/YnNVOj2Q2i
	bfq9uGwnPDFjAfrbiYaX7G8Cy5+thU
X-Gm-Gg: AYBFou0UhHTbanwTUd3mZIO0rrHW1yaPA/3BvWpPc841LbcHUJbkylsCnfioQwWidIa
	O7nh4ZWKmehUC/wCXDCkcvGoQfKqbZ+Esk3qK0H/EJXgD/sDz7hunDfZPB0fMXy/RlWooTA+tUq
	Q33Jpj7wFMQZwO8BsTlBAaaOgH6ROJEINtDk+SybQDBl1waOLH2YdBBLYS+a6zpc108c6kIxLMp
	Kv5QYJ1NeUHcgjKOWg24VGlZL5PPHtRAdYf3DMYvbA6
X-Received: by 2002:a05:600c:c166:b0:49f:ce73:5e94 with SMTP id 5b1f17b1804b1-4a18065ab85mr31209375e9.34.1791371804318;
        Wed, 07 Oct 2026 04:16:44 -0700 (PDT)
X-Received: by 2002:a05:600c:c166:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-4a18065ab85mr31208635e9.34.1791371803742; Wed, 07 Oct 2026
 04:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
In-Reply-To: <asUqYEisPp9MJ8mQ@rika.bernkas.tel>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Oct 2026 13:16:32 +0200
X-Gm-Features: AclHuK9Slk3gctaSaS0LjdFJQOpyljBfhJsLfaH_2ah-IlScG4_me5or_-r55N4
Message-ID: <CABgObfah3a03qwB8vsVNA67ffiHAYRHGjgCxydZzgqpWeXqduA@mail.gmail.com>
Subject: Re: [REGRESSION 7.2, BISECTED] KVM: x86: Starting Windows guest
 triggers UBSAN: array-index-out-of-bounds
To: SimonP <simonp.git@mailbox.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 7:37=E2=80=AFPM SimonP <simonp.git@mailbox.org> wrot=
e:
> Hello,
>
> See subject. Happens in permission_fault() on line:
>
>         fault =3D (mmu->permissions[index] >> pte_access) & 1;
>
> Some output from a printk I added, not spammed but keeps happening:
>
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0

Can you confirm you are using nested virtualization, and if so what is
the L1 hypervisor and L2 guest combination? Also what is the processor
model?

The issue is weird; it is caused by the SS bit which is apparently set
in the #NPF exitcode; but it shouldn't be unless bit 4 is set in the
misc_ctl field, and KVM never sets it. Can you check if the attached
patch fixes it (modulo the fact that it shouldn't happen in the first
place)?

Thanks,

Paolo

> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 35, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 68, index =3D 34, not_smap =3D 0
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
> kvm: permission_fault(): pfec =3D 70, index =3D 39, not_smap =3D 1
>
> Full dmesg spew below. The guest works but this seems not great. Not
> fixed as of 7.2.9.
>
> I bisected the bad commit to 687ee95c1b6d7509a25bbc661e62801aa06cc2ae
> but as this is just an enablement commit it seems more likely that
> something is incomplete or went wrong in other commits in the series.
>
> Regards,
> Simon
>
> dmesg:
>
> kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
> kernel: index 34 is out of range for type 'u16 [16]'
> kernel: CPU: 7 UID: 64055 PID: 13695 Comm: CPU 12/KVM Not tainted 7.2.9+d=
eb14-amd64-simonp #1 PREEMPT(lazy)  Debian 7.2.9-1sp
> kernel: Hardware name: To Be Filled By O.E.M. X570 Taichi/X570 Taichi, BI=
OS P5.80 03/24/2026
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  dump_stack_lvl+0x4d/0x70
> kernel:  ubsan_epilogue+0x5/0x2b
> kernel:  __ubsan_handle_out_of_bounds.cold+0x4e/0x58
> kernel:  paging64_walk_addr_generic+0xc24/0xce0 [kvm]
> kernel:  paging64_page_fault+0x84/0x9a0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __pfx_paging64_page_fault+0x10/0x10 [kvm]
> kernel:  kvm_mmu_do_page_fault+0x140/0x240 [kvm]
> kernel:  kvm_mmu_page_fault+0x9c/0x880 [kvm]
> kernel:  ? kvm_vcpu_read_guest+0x52/0xa0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? nested_svm_merge_msrpm+0xc8/0x1c0 [kvm_amd]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __svm_vcpu_run+0x145/0x240 [kvm_amd]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? rcu_note_context_switch+0x57/0x530
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  npf_interception+0xb2/0x2c0 [kvm_amd]
> kernel:  kvm_arch_vcpu_ioctl_run+0x69b/0x20e0 [kvm]
> kernel:  kvm_vcpu_ioctl+0x367/0xac0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? select_task_rq_fair+0x9b5/0x2670
> kernel:  __x64_sys_ioctl+0xb9/0x100
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  do_syscall_64+0xdd/0x5f0
> kernel:  ? __smp_call_single_queue+0xd6/0x190
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? ttwu_queue_wakelist+0x144/0x230
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? try_to_wake_up+0x300/0x8b0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? kvm_on_user_return+0x1e/0xe0 [kvm]
> kernel:  ? __x64_sys_ioctl+0xd4/0x100
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? wake_up_q+0x4c/0xa0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? futex_wake+0x117/0x270
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x116/0x5f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __seccomp_filter+0x86/0x6e0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x31e/0x5f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? write_ibpb+0x21/0x50
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x94/0x5f0
> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> kernel: RIP: 0033:0x7f38d6202f5b
> kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00=
 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 =
3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> kernel: RSP: 002b:00007f359d9fe280 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
> kernel: RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f38d6202f5b
> kernel: RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000003a
> kernel: RBP: 00005575017a2550 R08: 0000000000000000 R09: 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> kernel:  </TASK>
> kernel: ---[ end trace ]---
> kernel: ------------[ cut here ]------------
> kernel: WARNING: arch/x86/kvm/mmu.h:227 at paging64_walk_addr_generic+0x8=
e4/0xce0 [kvm], CPU#7: CPU 12/KVM/13695
> kernel: Modules linked in: vhost_net vhost vhost_iotlb tap tun nft_masq n=
f_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_tftp nft_fib_ine=
t nft_fib_ipv4 nft_fib_ipv6 bridge nft_fib stp llc nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 snd_seq_dummy nft_reject snd_hrtimer nft_ct snd_seq s=
nd_seq_device nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ip=
v4 nf_tables uinput btrfs libblake2b nfsd auth_rpcgss nls_ascii nfs_acl nls=
_cp437 lockd raid6_pq xor vfat grace fat binfmt_misc xfs sunrpc snd_hda_cod=
ec_alc882 amdgpu snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_co=
dec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl intel_rapl_msr intel_r=
apl_common drm_buddy vfio_pci amdxcp vfio_pci_core drm_ttm_helper edac_mce_=
amd vfio_iommu_type1 ttm jc42 vfio drm_exec snd_intel_dspcfg drm_panel_back=
light_quirks kvm_amd snd_hda_codec gpu_sched drm_suballoc_helper ee1004 wmi=
_bmof snd_hda_core joydev kvm evdev igb drm_display_helper snd_hwdep irqbyp=
ass i2c_algo_bit snd_pcm cec dca rapl sg pcspkr k10temp
> kernel:  snd_timer video snd soundcore i2c_piix4 button wmi i2c_smbus nvm=
e_fabrics efi_pstore configfs ext4 crc16 mbcache jbd2 crc32c_cryptoapi dm_c=
rypt hid_generic sd_mod usbhid hid ahci libahci xhci_pci nvme libata xhci_h=
cd nvme_core nvme_keyring scsi_mod usbcore nvme_auth sp5100_tco scsi_common=
 ccp usb_common watchdog dm_mirror dm_region_hash dm_log dm_mod nct6775 nct=
6775_core ntsync hwmon_vid i2c_dev msr efivarfs autofs4 aesni_intel gf128mu=
l
> kernel: CPU: 7 UID: 64055 PID: 13695 Comm: CPU 12/KVM Not tainted 7.2.9+d=
eb14-amd64-simonp #1 PREEMPT(lazy)  Debian 7.2.9-1sp
> kernel: Hardware name: To Be Filled By O.E.M. X570 Taichi/X570 Taichi, BI=
OS P5.80 03/24/2026
> kernel: RIP: 0010:paging64_walk_addr_generic+0x8e4/0xce0 [kvm]
> kernel: Code: f9 1f 0f 87 d6 ad 01 00 44 89 c2 d3 ea 23 54 24 18 83 e2 03=
 89 d1 f7 d9 83 e1 20 83 c9 01 85 d2 0f 95 c2 09 d0 e9 3f fe ff ff <0f> 0b =
e9 26 fe ff ff 8b 44 24 20 45 8b 7e 04 4c 89 64 24 18 4c 89
> kernel: RSP: 0018:ffffc98d85b9b5f0 EFLAGS: 00010202
> kernel: RAX: 0000000000000000 RBX: 60000001274000e3 RCX: 000000000000000b
> kernel: RDX: 0000000000000022 RSI: 0000000000000001 RDI: ffffffffa5ad965d
> kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: ffff892f725bd5f0
> kernel: R10: 00000000274000e3 R11: e000000100000023 R12: ffff892f725bd1d8
> kernel: R13: ffff892f725bd760 R14: ffffc98d85b9b6b8 R15: 0000000000118c71
> kernel: FS:  00007f359d9ff6c0(0000) GS:ffff893b97d6b000(0000) knlGS:00000=
00000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000000 CR3: 00000001c382b000 CR4: 0000000000f50ef0
> kernel: PKRU: 55555554
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  paging64_page_fault+0x84/0x9a0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __pfx_paging64_page_fault+0x10/0x10 [kvm]
> kernel:  kvm_mmu_do_page_fault+0x140/0x240 [kvm]
> kernel:  kvm_mmu_page_fault+0x9c/0x880 [kvm]
> kernel:  ? kvm_vcpu_read_guest+0x52/0xa0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? nested_svm_merge_msrpm+0xc8/0x1c0 [kvm_amd]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __svm_vcpu_run+0x145/0x240 [kvm_amd]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? rcu_note_context_switch+0x57/0x530
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  npf_interception+0xb2/0x2c0 [kvm_amd]
> kernel:  kvm_arch_vcpu_ioctl_run+0x69b/0x20e0 [kvm]
> kernel:  kvm_vcpu_ioctl+0x367/0xac0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? select_task_rq_fair+0x9b5/0x2670
> kernel:  __x64_sys_ioctl+0xb9/0x100
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  do_syscall_64+0xdd/0x5f0
> kernel:  ? __smp_call_single_queue+0xd6/0x190
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? ttwu_queue_wakelist+0x144/0x230
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? try_to_wake_up+0x300/0x8b0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? kvm_on_user_return+0x1e/0xe0 [kvm]
> kernel:  ? __x64_sys_ioctl+0xd4/0x100
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? wake_up_q+0x4c/0xa0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? futex_wake+0x117/0x270
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x116/0x5f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? kvm_vcpu_ioctl+0x2ed/0xac0 [kvm]
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __x64_sys_futex+0x12a/0x220
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __seccomp_filter+0x86/0x6e0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x31e/0x5f0
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? write_ibpb+0x21/0x50
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? do_syscall_64+0x94/0x5f0
> kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> kernel: RIP: 0033:0x7f38d6202f5b
> kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00=
 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 =
3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> kernel: RSP: 002b:00007f359d9fe280 EFLAGS: 00000246 ORIG_RAX: 00000000000=
00010
> kernel: RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f38d6202f5b
> kernel: RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 000000000000003a
> kernel: RBP: 00005575017a2550 R08: 0000000000000000 R09: 0000000000000000
> kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> kernel:  </TASK>
>

