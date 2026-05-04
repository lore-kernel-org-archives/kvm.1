Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B33E123A
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920660; cv=pass; b=vBJXHiZf/V4L6hL3KH/VFAfGP6hp40U054VepFQnC+kaJx/cJ9CBGcfZWpO3ITfNqFLcklRyMhPvVeD4dGnX3m+2tBMl2NH2HaotJ+Xjatf41mAbsBqCvJXx9A54lMnBI+KJ707ehmdaY2h2J8L2b6R3wHzbS27GMKFEy/e7Qq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920660; c=relaxed/simple;
	bh=WFwN+Wgh0NtNG8yxylw5yYzCOPx4Vj/DeeMIuhH/y74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXfZyQDPr2f9oD540mtzSnkMXbG9dG4SU77zj5J2XENIL7eAVp1S9988e3ggAqDr8UkmS51bKjUGYNwO6LvXaQYQ2Jdvle/lY6YuiLOa0qHEY9L1M02BiT7H4GbDuxK3mj5yYcrLOV1sEj9Xrv8JVqTDfTdg9ygUfzayxk25baw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZM7b5fT; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZM7b5fT"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd89701acso4190631a34.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 11:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777920658; cv=none;
        d=google.com; s=arc-20240605;
        b=h88HenI9CMuCqI/BniMF3CEz2EpiWavwHbCTX6I6mn38yTEEpGJPVORMQCuiD0k5qx
         qcZABkKACPMpPT1V0uXjF66bYiZun5h5ep44kfDpMeeDsVRG8I89JuaAByJ3zcZa4oaM
         mKi1hHS+WXLZzoeWfGDAoq6jeh/VXpyROoXNBXOPAKj8wM9Msq+HV4HOV8cZmvGaVJEE
         zH0GrZRKkWqWflfB+l9yr0kAR+WVeXhIX9eFqqMXEC6iAg52FWHWU1ebf0zu0rIS7Rpo
         L+APNlWd4ga5tmCBJV1/K8ufjQv/xmQ7M8DWWEyOpO5hQghuBxwCQy3dr0jx5T8BAk20
         EVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/k9XzcJNhM8ywmPnBuWkWoz/ZfLZiQHln4TiRKv62M=;
        fh=JZvX+rkkcQsyFTVh0raw7yGloh0QN22IjMuiyOE1iEY=;
        b=IGuHTZyG04YpXYly3j2l3smmVzPUtzTunzK4U336l7JAYjxUofkr5XRZnNtc2zqkqy
         g2g4LWqKkJtNwKOBUbpMdPG6H+uVwocN1aMygzE/le3hqGZp9Hhn12BD3MbK2Hsx4X8O
         WAjvRQebpG0gJZUc8bt0hYCkfEk3EI9fdDlFpnLTqRopmJd81yoBUY5k4SzR6MWRB7La
         06u0j877WETp3o/KRH8ZGKFV/Dic3dZ1fSxb7Z1a+FQ9gWPTap3yXHH6WevDAU4EcqdX
         0j5lLpUEurg30+clwa4UJVKX3bit1hb6SnaZBGlvzodcV9HuznmWYIvFlY1UrL8sJydZ
         1sKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920658; x=1778525458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/k9XzcJNhM8ywmPnBuWkWoz/ZfLZiQHln4TiRKv62M=;
        b=GZM7b5fTTmr99cxZOlNdlzZ3rLygd3hUPA5gdYc85TY0OJNDQbOIPe4Eur4MWLDrmf
         75upXTx/wOWsZCWX7KlBtkaqxY2uiTLO/pJu/TvXxHEAJqbkUgKigV+lhAr2dR+HF+XU
         spDY/K4eUHKq1jZ87AkcMeMAl40q+yWVKeU7hTyowTgztX2+WOsBvXaV/qkrppa3jgac
         BW6ch1Lvjp0xECgGTWHQR2XEFOo5dZwLK0SK3fiXIsAfbKub4E817cT3XsrrlgHroiYd
         zWi7Bb2JTHBUi0Ind9WsffzlWZ51I5NAlFYwu222BRJUymZP1KlMmMllDUDJC4H9g4lW
         vZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920658; x=1778525458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/k9XzcJNhM8ywmPnBuWkWoz/ZfLZiQHln4TiRKv62M=;
        b=FHh6yHjpNcVL4Q/w54Rm9ror+87iGMvWcTjdluYAq/8WlSR/JFWmxmjh1STCT9wCK8
         lB4IQq1xzqASVn9I5kD1wBqRKRi+E0jSEMGTCp0gUwBIvxF20HKzDFO7MsK5ski2VPne
         X2ztDwNidMaWxghqc2hkAHAWcYs6uTxOV4sfcHSjofgBD6eqRZEix6iFyMEtZSPBDMzp
         VoalDaCKZzGk+eXeHmT5RIc40UckonzGRXLqHpLZJPVHVIzR5UMPAjKrcKi4f+O129SE
         v4ub+jH3PcrpWeqpiS6wUf/Aws1fFATEwfPpStSKY4tUC+4gVNY5kUgu8Qa6mGTyjufr
         7zmg==
X-Forwarded-Encrypted: i=1; AFNElJ/Cdw+OntWgr8/c+ladt9TJLC+uXvXrFYHhfi1m1n8oS6QegzWzrZTngd65a4iHacAksas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDIZ5ut3N5re7dcnxwoL0a2kw39CK1Vhom5XVgoaH+hsGQoOn
	GIww4o3aajomguj/pOxmQZfoNEjk96cl55oXYbVLmKXD07nOuf3XKMZnC4xPxV7wd1O44m1JUlp
	NKZi5DeeucP233yvNdRXzmUV156TZEJ4=
X-Gm-Gg: AeBDieugwQXz26eq3KkC3SI+LSXowH1HrzIUhXhUVSWXcNGTM9iT9X1L/RaDgp3RXWN
	9eSiFvR26Dp9slgf9a4etSM+P1hmvGpWgt6HJGI3o+ALttFoF1zM+wECsKl4tQduKtPfVofZe00
	H9Hxz3nvmSL7uUvIb5mGzDy6MYCkxq97eB7zGIbMyuflNyjJuzrofPBI+LGM7GJbVOuWxpzlKBQ
	aepoKmKnuvCVqiFEX/MCmTU9NNj2LSK/7Pb0LgusQ+KWiLGhvRPGHCuKdk5Oc77pvyTlFpWp3ay
	9VY63zZFgqhO/UwCtPC/IVBwLTbMQC0=
X-Received: by 2002:a05:6830:6616:b0:7dd:91cd:2b19 with SMTP id
 46e09a7af769-7dee13c1841mr7143978a34.14.1777920658269; Mon, 04 May 2026
 11:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com> <afjcCBGzuZU2iON9@google.com>
In-Reply-To: <afjcCBGzuZU2iON9@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 4 May 2026 23:50:46 +0500
X-Gm-Features: AVHnY4JpLV8TW3QXgd33Dm6Y0B2vguMOGlcRW8WNYYnY-37DO7FNpuRQP2R6RmE
Message-ID: <CABXGCsPTbCdfrwWAtXOb7wOMUOgtL=hpsYYXXQrosoUjj_WkYw@mail.gmail.com>
Subject: Re: [PATCH] x86/virt: Fix RCU lockdep splat in emergency virt
 callback path
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Dan Williams <djbw@kernel.org>, Chao Gao <chao.gao@intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:48=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This feels wrong.  If RCU truly isn't watching this CPU, then isn't RCU a=
llowed
> to ignore this CPU when synchronizing?
>

You're correct that irqs_disabled() doesn't imply RCU is watching, and
in the general case that would be a real concern. However, on the
emergency virt callback path the practical situation is narrower:

  1. The reader (x86_virt_invoke_kvm_emergency_callback) only runs from
     panic/kexec/reboot via x86_virt_emergency_disable_virtualization_cpu()
     and machine_crash_shutdown().

  2. The writer (x86_virt_unregister_emergency_callback) calls
     synchronize_rcu(), which would observe an RCU read-side critical
     section started by rcu_read_lock(). But on the panic path we don't
     have rcu_read_lock() =E2=80=94 we just have IRQs disabled. So even wit=
h my
     patch, a concurrent unregister could in principle free the callback
     out from under us.

  3. In practice, the writer can only run from KVM module unload. By
     the time we're in panic context, all CPUs except the crashing one
     have been NMI'd into x86_svm_emergency_disable_virtualization_cpu
     too =E2=80=94 a kvm_amd unload happening concurrently with panic seems
     extraordinarily unlikely, and the system is going down regardless.

So the splat is technically a real issue, but the underlying race is
already so vanishingly small that I'm not sure what the right fix
shape is. Some options:

  a) Treat this as "panic context can't be RCU-correct anyway" and
     use rcu_dereference_raw() with a comment.

  b) Convert kvm_emergency_callback away from RCU (it's only set/cleared
     once per KVM module lifetime; a regular pointer with smp_store_release=
/
     smp_load_acquire would suffice).

  c) Keep my patch but document that it's a minor lockdep silencer for
     a path where the use-after-free window is closed by other means
     (panic-time module unload being unrealistic).

What direction would you prefer? I'm happy to spin v2 as needed.

--=20
Best Regards,
Mike Gavrilov.
