Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243434D382
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778191171; cv=none; b=G+y0JvicGEchDjSP9qS2fSnfmbZYDPmmE2bjmVqXxx3NHpZSvAfXpR4IZOJ3b8Ouwc+QjYNPh9/7GIRkOW/SK0fKLszKqKRpKn/2vLjFYkg11UUnbB5TDYKUVv1VvJQM8Z3oih8Ul9O1XvuwuqO3pbieGmzcXG4WrwvEnRcYdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778191171; c=relaxed/simple;
	bh=1YRd41fEFbY+a83nU8GaPMNuby91viU+z5FrzN8MGkc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OojsxwoDdWYLhTkkQOX/tq0wTH5H+iioLoJg5mP9ZypyS/vGtmSWxdBrdxQG3F2UqZJ4dAVDfVzUEiDl+4F0XzerDvhvfcb/oua3sbNcr1G1t0ZhfdLqIHxvOjatn9QLFG4ZoLZT3OPsMVTIyF3Ic1ya/iYk7KX0weU3n5jLkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h84sMev/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h84sMev/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso34042155ad.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778191169; x=1778795969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHU90gqvYifnkG2RCuPg/6CsVL3m7MdxSFaqpK8rgG0=;
        b=h84sMev/xs1Z2OMWlrj8iU8OrJlZuMgbeVgS5Ie0NWgdYhKvKKa6MdfTJsxRhbdXQU
         ZzR0e3acfC8xqGmc8ND1SHmJ0bvyGs+yh1gFWgcVijizZoluKDPAgw1i2oM+Jm88BRP/
         OY5vRkWEk9nFO0y2oqntXd+MEJ6ErjHsWAKX/ykzPO0vQVghmPxx8SSG7Q44F4h4ligL
         7l3vAZiwE73xpfLWAiYqXsUCwLX3jJg7YpD8owwSQJbZwECdcYgSL9YN66zKVUPhZSX3
         HdpbdqpzW2v1ycw3nFYwTTlsdt8O7W6BBgJrgm0h+vtEwtpV13e32E0HGsMx07VHdjqh
         jE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778191169; x=1778795969;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHU90gqvYifnkG2RCuPg/6CsVL3m7MdxSFaqpK8rgG0=;
        b=WEDrOy96a7NBLyOgKk/9JV6JajrTh2ARALQr2kqxuqNZXzIlw7Icc+MBp4OE7JjD+o
         PWf2a1Ro97AXnocFZtfMax9zvsHfgSSR/GCetr8XRuoB54IClMYFGkCzEpQ39x/I4CBx
         BN1ecKC4s1/wpcBnPxOxdmH+8OzTjAhrvk6DjMgaSY8Nbd1E+3pe/n6Fz/GeUdGw5czy
         KmFfdGjmlyI957JYJ9o/FNueZiRQjonlfqgZ1HvqGK23Rvn1eaIP9/ehTQMqjt2VboO0
         0nQRexpS7p+8tJzGpdP4qKNRGFQ/VGIx43fD47ffLCaAwPglysWFMvdzTj72Hd7a44cN
         Vjuw==
X-Forwarded-Encrypted: i=1; AFNElJ9h1///U5zL5OVVOlULoa4FdeqM2tA1D366bYfWmlNaDjkq4jJcfHWiEXNPhPsBYfHqzDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1qcCtr9q2z+eA64nJW0uFn3Oglu2CK2yCMCRmgdnrjnPwOs+
	SdlGAmv5aBRR0v+5YuEqiEohVrSFAKgHxQJjGo1j6gLyvd+FWGWN4hf8GQH3YdmXRz/jmvh82UL
	Xp61Vog==
X-Received: from plblh8.prod.google.com ([2002:a17:903:2908:b0:2ba:47cc:61b3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fa07:b0:2b2:549f:7d2b
 with SMTP id d9443c01a7336-2ba794b9766mr66362135ad.11.1778191169247; Thu, 07
 May 2026 14:59:29 -0700 (PDT)
Date: Thu, 7 May 2026 14:59:28 -0700
In-Reply-To: <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com> <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com>
Message-ID: <af0LQNY6IhB0NEWy@google.com>
Subject: Re: [PATCH v2] x86/virt: Silence RCU lockdep splat in emergency virt
 callback path
From: Sean Christopherson <seanjc@google.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, djbw@kernel.org, 
	chao.gao@intel.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026, Mikhail Gavrilov wrote:
> x86_virt_invoke_kvm_emergency_callback() reaches rcu_dereference()
> through machine_crash_shutdown() with IRQs disabled but with RCU not
> necessarily watching the crashing CPU, which triggers a suspicious
> RCU usage splat on debug kernels (CONFIG_PROVE_RCU=3Dy) during
> panic/kdump:
>=20
>   WARNING: suspicious RCU usage
>   arch/x86/virt/hw.c:52 suspicious rcu_dereference_check() usage!
>=20
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   1 lock held by tee/11119:
>    #0: ffff8881fa32c440 (sb_writers#3){.+.+}-{0:0}, at: ksys_write
>=20
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x84/0xd0
>    lockdep_rcu_suspicious.cold+0x37/0x8f
>    x86_virt_invoke_kvm_emergency_callback+0x5f/0x70
>    x86_svm_emergency_disable_virtualization_cpu+0x2a/0x30
>    x86_virt_emergency_disable_virtualization_cpu+0x6b/0x90
>    native_machine_crash_shutdown+0x72/0x170
>    __crash_kexec+0x137/0x280
>    panic+0xce/0xd0
>    sysrq_handle_crash+0x1f/0x20
>    __handle_sysrq.cold+0x192/0x335
>    write_sysrq_trigger+0x8c/0xc0
>    proc_reg_write+0x1c3/0x3c0
>    vfs_write+0x1d0/0xf80
>    ksys_write+0x116/0x250
>    do_syscall_64+0x11c/0x1480
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
>=20
> A truly correct fix is non-trivial: the RCU usage genuinely is wrong in
> panic context (RCU may ignore the crashing CPU during synchronization),
> and a concurrent KVM module unload could in principle race with the
> callback read; see commit 2baa33a8ddd6 ("KVM: x86: Leave user-return
> notifier registered on reboot/shutdown") which notes that nothing
> prevents module unload during panic/reboot.
>=20
> However, the alternatives are worse:
>=20
>   - smp_store_release()/smp_load_acquire() handles ordering but not
>     liveness; the kernel still needs to keep the module text alive
>     while the callback is in flight.
>   - Taking a lock in the panic path is risky =E2=80=94 any lock could be =
held
>     by a CPU that has already been NMI'd to a halt.
>=20
> Use rcu_dereference_raw() to silence the splat and accept the
> vanishingly small remaining race. Panic context inherently cannot
> guarantee complete correctness; the goal here is to keep debug builds
> quiet on the kdump path so the splat doesn't obscure the actual
> kernel state being captured.
>=20
> Reproducible on a debug kernel (CONFIG_PROVE_LOCKING=3Dy, CONFIG_PROVE_RC=
U=3Dy)
> with kvm_amd or kvm_intel loaded by triggering kdump:
>=20
>   echo c > /proc/sysrq-trigger
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Fixes: 428afac5a8ea ("KVM: x86: Move bulk of emergency virtualizaton logi=
c to virt subsystem")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

(I can also take this through kvm-x86; I have no preference whatsoever)
