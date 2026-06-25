Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311A524F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426893; cv=pass; b=kY4Okmmb+kO2biykvWvCKJ+9nJXCJRDL7YhrJoK42VAt5wFNZEWfIaV2iDuB3bewCHccvjgGerQsvKGqHjA3UkwXRJi/4mLS0hTQK0VNdazs3tzXTFslYCBxuEy5mHb1Yhe2J/4ngcHBgHPTj8hIf9nR4erHSm7VOingnbBqTnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426893; c=relaxed/simple;
	bh=SK/9doAVjeaUXROyONWOwec6DM1U4xeSHOjmYLRHaX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jh1y0hnu+SQb3DmlHU7kQ1qO6gJMqxkz07iZX2IGSBIM+yCaDAcBccETbJOBDwbidiGOuzVCwqqzAvM50Ne8YN1PQG6SKX9hWZzne3KyPukMCul+gssuKZT4bl1ONjqmQUpHYP7LaPAM/vyOR5VQMaD9Rnn0eF5Yj55fv7DPt+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQWymUBK; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQWymUBK"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a11f19fcf6so253002eaf.3
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782426890; cv=none;
        d=google.com; s=arc-20260327;
        b=MPoiyZ4npkU9v2KcKQiYSzSUZBk9/GsnJRFO5nV/uJ9lb/acrCijsH7ey92C8sEep+
         VJ4CEYreP/AkeGf1ZncLBPGd9SFBnkn2aD/ty23+gjD4iX8ZxoNE7AThJvjsXaC1buER
         jXxkPhEM6SOFio2RWYEBZlaabvifMbrMxqLeml4BuipWTx1ZLkM/78PBbRlRBFXNo2hV
         cV4DCECXCgCqoZyKQYM4g4uR0D2UO9+ceGBZD3IqZCh8qxuZriS0DrlbREGiPG2/LUDM
         PwvKmrMHmBspDymApUi4Bo0iCoTOW5pM0XLuUQKpr9FJWOVeuDY+wvcY6mFNfhiDr48/
         I9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RsOe00D0dXCtOMeOq38Ryr/BClG0oOTSp27xViUjrz4=;
        fh=/PcHj+rvR0Ig1hSCj6FgIdJHkteeH/Pdj1GyRgWCnbg=;
        b=aVLsptVbcJ5fhSk7n+LEgRhgmTSmM1yiiJyhO0KkgekiYv1WDrObUJ71z1x7KMPmfg
         gyoJ9E+Snm8fEoaIR24frBweU4fnmunquPQEHiK80qnNCMmKwQ5Sy1BFNdP6QtMlT4sx
         aJq7wFTLevab9VDXErJHZQHqmMjARsX9QaAMhrFnhPNNLK+Cn2Dlf544aK5cjYURupAN
         mjwSU6QdQFyZiDX6XO6pVBvaQ09vpnozvK74X97teoIrlIorz6fQPHmzbch64gHK04BH
         U4YLBbcv0/HRb6v8i2GzhJsX5QBUnO7N+02DqAFTj37zt2rgp7VU59gf3DDTJGhQy8gN
         ZN4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426890; x=1783031690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsOe00D0dXCtOMeOq38Ryr/BClG0oOTSp27xViUjrz4=;
        b=RQWymUBKxZsmLvrcoT1kJOLFabDJG66sFTFklNgLLvuyCBmrlJmERRmkC90zLXN9a7
         Xcoy97LmkpuBlX5GUoes/y+142+2J+2MAQMvR9vAOLa2oKCYelFcT0tgNJ1kKqJRmk/r
         nruqyITVLzV+5LLFM8s4JXNSX/OkFKZgUgR6eUy2hLIQyVKbXRqjIzW3/0dJyyJJXc0Q
         Xz04UHfTKNV7Z9FkN0fBCMrBbHsN0cbMc4GeaYRMBxiMrUMkhm6TWAad4Svd6E15Neo7
         KsCNh+1e69W1mDMePlU9Ik511AOa2GwJ/x2xsquh/Ts97m7uAZK5BmsOLeOJJr7npMQD
         i4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426890; x=1783031690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsOe00D0dXCtOMeOq38Ryr/BClG0oOTSp27xViUjrz4=;
        b=FYrQWUu8OsgOA5KMBGNO2RlQJNFLU6mtxfcyTlwRvUwnRin8Cx75vowTNXgqsgMfui
         A61P92w39YDMvbd4e+Ajfro62rMPH6oAUvXP6yxyyE03EttoNA18vFKsw9yD8LQJIe50
         /h1USOGnPIy2x29Aeu+lEflADyYj7lqa4/7xC/gCFGvf75y+Cl3KtJr2YELzmgvDDL/N
         55Wsg41RfWTL6A90NqnWeGvHe9CCOkwnxAtbkyUFCjcP+Y3/8MsBVlcPDAcTiwvgelA1
         VVYjcE7Hosd0Gjbk53XJwAwp86+wOEd7ufLtr21Ou1AcYOV21Rr4U1CgJftb7jmvQhGc
         x0LA==
X-Forwarded-Encrypted: i=1; AFNElJ+5rvQ4xjMP3W8QG2/J8DZ6RpO3QaIudt15XqGBrpaAxJhDPKYnBoudAQEB6be4VIFE4pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJO7YD5EcH7QcfVoEYhRhnKgLGjc7jOe4XDzfUEXIpTOFZsOJc
	DVxgCIlA8DbaSgmNQjDJarXaUHnzRYI0XI9MNOKl7ivHCVVe9boZCiebZinCB/IE5F8lMpp+MpK
	H2vgnIb/Bgh38mNsziORvmhL4fhYmUoiFAqwxFxC4
X-Gm-Gg: AfdE7cnuKFQF5IqnbCNoVjeuEdV7m2LDrjvhcF1Yy9p8mGb648Mrgbniyj4lRVfLPw9
	GjVBTBYaqajzlggc1znevfBFMA/cVdwAtmBI9o5dWx1OGOGm2kcCeCTB0r9XUVXpynB7JoY0gQT
	SMsfdTcimiDFcDQ0Th/P0HIAz2X633Yk2Zl5bex82upOxgtEooQaBKAAw8lZf4gpKfkGYRiT/cn
	4px06kQdqPGPLrdMW2a7f3fOQN0rFeY+lWJIaBaiohbdyFXCfalUASX+OBcJDMFJE6T1t/gBEOT
	G7foCQ5a9168NfEQJPG6tI0DSyr5cU5XRaylV5CT1OxqqnfmH0PRIT8mHBz9PL8+8cVXl8oD98c
	o5b5jfaYW0gWIPKSwY6DGgfr7WO77Cv64w3C+a/j4jQ==
X-Received: by 2002:a05:6820:1885:b0:6a1:2295:f476 with SMTP id
 006d021491bc7-6a13517a372mr3771260eaf.13.1782426889451; Thu, 25 Jun 2026
 15:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org>
In-Reply-To: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 26 Jun 2026 00:34:38 +0200
X-Gm-Features: AVVi8CfShnwwCAYnttfgfOqUevBYm4PjZ8K74AoCZ3E8AuCUQnSiABH7Y7oHIxM
Message-ID: <CANp29Y7aiAeNCUPAYbym7_b7gxDsjweF+qssQ-VSussbZ1OGgw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Exempt in-kernel PIC from "disappearing"
 interrupt warning
To: syzbot <syzbot@kernel.org>
Cc: syzkaller-bugs@googlegroups.com, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 11:10=E2=80=AFPM 'syzbot' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> From: Alexander Potapenko <glider@google.com>
>
> A warning can be triggered in kvm_check_and_inject_events() when an
> interrupt disappears between the time it is checked via
> kvm_cpu_has_injectable_intr() and the time it is fetched via
> kvm_cpu_get_interrupt(). This occurs because the warning incorrectly
> assumes that if an interrupt is injectable, fetching it must always retur=
n
> a valid interrupt vector (i.e., not -1).
>
> However, this assumption is broken by level-triggered interrupts in the
> in-kernel PIC that are deasserted concurrently by another thread. For
> example, if a misconfigured PIT or a PCI device asserts and then
> immediately deasserts a level-triggered interrupt, the vCPU thread might
> see the pending interrupt during the check but find it gone during the
> fetch, resulting in kvm_cpu_get_interrupt() returning -1.
>
> The warning manifests as follows:
>
> ------------[ cut here ]------------
> irq =3D=3D -1
> WARNING: arch/x86/kvm/x86.c:10860 at kvm_check_and_inject_events
> arch/x86/kvm/x86.c:10860 [inline]
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_enter_guest
> arch/x86/kvm/x86.c:11356 [inline]
> WARNING: arch/x86/kvm/x86.c:10860 at vcpu_run+0x57ec/0x7950
> arch/x86/kvm/x86.c:11770
> RIP: 0010:kvm_check_and_inject_events arch/x86/kvm/x86.c:10860 [inline]
> RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:11356 [inline]
> RIP: 0010:vcpu_run+0x57ec/0x7950 arch/x86/kvm/x86.c:11770
> Call Trace:
>  <TASK>
>  kvm_arch_vcpu_ioctl_run+0x1193/0x2070 arch/x86/kvm/x86.c:12125
>  kvm_vcpu_ioctl+0xa61/0xfd0 virt/kvm/kvm_main.c:4470
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
>
> Since this is a legitimate Time-Of-Check to Time-Of-Use (TOCTOU) race
> condition for the in-kernel PIC, WARN_ON_ONCE() must not be used for this
> case. Update the warning to exempt the in-kernel PIC, while preserving it
> for other interrupt sources (e.g. APIC) as they are not expected to exhib=
it
> this behavior.
>
> Fixes: bf672720e83c ("KVM: x86: check the kvm_cpu_get_interrupt result be=
fore using it")
> Assisted-by: Gemini:gemini-3.1-pro-preview Gemini:gemini-3-flash-preview =
syzbot
> Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddd769db18693736eee89
> Link: https://syzkaller.appspot.com/ai_job?id=3D0b59ccd5-8820-460d-84d3-9=
4df6307bd6a
> Signed-off-by: Alexander Potapenko <glider@google.com>
>
> ---
> v2:
> - Restrict the warning exemption to the in-kernel PIC case.
> - Remove the pr_err_ratelimited() logging.
> - Preserve the WARN_ON_ONCE() for non-PIC interrupt sources.
>
> v1:
> https://lore.kernel.org/all/345e9d6c-d7d9-4bab-adb3-d6a7bd27599f@mail.ker=
nel.org/T/
> ---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0550359ed..f1681aa9f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10857,7 +10857,9 @@ static int kvm_check_and_inject_events(struct kvm=
_vcpu *vcpu,
>                 if (r) {
>                         int irq =3D kvm_cpu_get_interrupt(vcpu);
>
> -                       if (!WARN_ON_ONCE(irq =3D=3D -1)) {
> +                       WARN_ON_ONCE(irq =3D=3D -1 && !pic_in_kernel(vcpu=
->kvm));
> +
> +                       if (irq !=3D -1) {

Hmm, no, that looks weird.
Sorry for the noise, please ignore.


>                                 kvm_queue_interrupt(vcpu, irq, false);
>                                 kvm_x86_call(inject_irq)(vcpu, false);
>                                 WARN_ON(kvm_x86_call(interrupt_allowed)(v=
cpu, true) < 0);
>
>
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> --
> See https://goo.gle/syzbot-ai-patches for information about AI-generated =
patches.
> You can comment on the patch as usual, syzbot will try to address
> the comments and send a new version of the patch if necessary.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
