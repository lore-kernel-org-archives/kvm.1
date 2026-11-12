Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794443346;
	b=3EURYEhLoZbbbk3UbgwV3V5WiRu78ZqVpkAjKP1omA7FMysbHjgUryYzTYTImJ25RQJ9
	 JyzUyOUQqkMus5da3tqQMVHhUwtQZnJLMspUc3YeBvZUVfjt7onCwXOsWptj0G6+HRhF6
	 68bJukRB31wCuCJ1A2cMAaG62N5wv8CCE8abfd6V3dt6blMzfl+v1r+aK2xCSePt1o1Fh
	 cF1b0lkABNCA9oe66lu49A9hMR88IvYjYLGEbCEX0suH14rU+/g5mn4v4Pm4HFP/wOMRi
	 EV5YKxuRi0MuJxoaRy6GPpaSaZBLjJmHsfAnVa4JLyXPj82tpKui7sEd9cShUE8qqvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GO/HzhqW9y47Gumkhuy8EImU/3z+JleZsJUrX3HvkHk=;
	b=eNrv3fecMHRJMOAdc3wioXPTdDE5kQ9r40ntMvjRqXDHn8GDcuUpfFdFejB9jauaWA1q
	 aI2kFEVzMCe2DzY7Afhfy7sblG0ZaZE4EcdvI6Z7g5l+LhKQtPdEo/JrH6c0adJ03SJa3
	 341MLORZ8bC/8hiiIoU1BD2cS6JB9TQlb1x/LNNq73tDW+YdNWeXclqNp8xtmEowOIcWX
	 QKJayYjghYx5UQ5+u8zrdvE+gQanJDTq1l84IOrCvpkieK6hgF+hqMVxKdyoojz7J/8jB
	 lMhKtVa0C0quw7a084I2uRLOU5iejT8zGZ2I2D8D+PnY7DT8SOcQoP9jicMp6mh/lDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWqQT3ss;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67139606A333
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 00:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67139606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dWqQT3ss
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso2789a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 16:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794443345; cv=none;
        d=google.com; s=arc-20260327;
        b=P770UEovPjetPj36JBMC06A48PFyHO7dQDOorr3tGv+nVlv07sseJ9sErEMk4+VfCg
         K7Dgz3IisNd+KoBiXiBFigVLkv6vLtenwOJS9QuJawaCzH8R6K2VOGOQTawhqGRdUhYz
         QE9n6/46i3sH9AdZ1lm3uWgRN3oc4udD1o8jJxKWbLnzcQPLcVPdEQ/ITjM/NYjShZSm
         ShOg0ND2u/M3aONDoWZhWNwnLdmvxAvY6ZgEIdENJgC7hsUQndno7YgvBebZRmxCt7yt
         XKn5hB5x3FgiXINFI4t3c6jwPhYu17Fs5ub1O8xt9kY7jbZjkxXGCWMsLbR1nEhfuPPn
         uHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GO/HzhqW9y47Gumkhuy8EImU/3z+JleZsJUrX3HvkHk=;
        fh=BfcRgvUM1/MOQgHalhAw7pAP3Y61lzABbXybcv0ElMM=;
        b=FxJypRNi8zXJgsG0X6iuSRHlLDwJzliD55MqhtEjfCe+lVgHD5L6jtDzinImqjhU4I
         uDbP1WUuHMk9v1LLVrMEMGFsWSEGZYdHhPj8+RF6J86XDz0tTySgfcDmNTdQMuxK3gQL
         11tl/10kjrwNKaDlPJ/qaKzTR+Jz5tmIh6lpnwhsRE+YNlEKm/2C6qPHBS6sWI9kPOq/
         V4Ye3QI4ryskJgxVgtB+xyVf9PdYDvfngXXIXiwWTrmczAMShk1fjbCtSDh9+3oS3KI4
         MCU4ehbdd5ieMUnG8G9gO9IE81hc3nw5wM8gWyg2U6IOoFWmv66MUlTU/m1ZFhteq9UL
         6Nlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794443345; x=1795048145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GO/HzhqW9y47Gumkhuy8EImU/3z+JleZsJUrX3HvkHk=;
        b=dWqQT3ssiqROBYD0HYMwG3O5nPjjOo5IjwINBmN5oc7CzXL85oVF14ngDDeicTy27d
         2Es7j4TbUyeAsRFZ5LMNnbcN6tngmqEe37zn6zQam7R70nrWKaO/Io0i8c3OltCnsjrW
         p6kxiLytSyLd/PDkEK8KyflKBQgFd5eZ+7Vk3JxF7KDwCDXijnylYtGY7rHNOWZiqOcp
         g1mevQ9evlsKf2tijEuVEGuTdiNRZH72IvJodG8cb1HsC1pBtbwAHx8rVIB42/gu/2Ui
         o/UP7aEJoLE4r5bEJX62xrTK6lyiZm7IFZ4+kqgjV9sNylagHLcMQXlzr13PdXPhKm0w
         LkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443345; x=1795048145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GO/HzhqW9y47Gumkhuy8EImU/3z+JleZsJUrX3HvkHk=;
        b=fIIKLtzLR8TQ0xpiz0IFtLRwDB7fuT7r4iC2iZlV86cffeR4o2D6gY+kDGKsagkVBx
         yXPNyOVUfojHs871eqEkXcPYZVtWmVCP7W4/uzAyXaT3FgdZDZWfdittoQ+41BGG+4C/
         S2pceM99bh+SDpCHs2zf7F+zsSz9JM9eSdDMdEROoNDzvQVejPeIUS+EVgzk2n/8IgjR
         p3ekdozXb1ZihXeKeGw7jSY3+0tb8LUlK1nulVyEIZpNUA2/LZR0bN1kwzYm8wQZyNu2
         iVKIAqB5D7W4xdF7BXrLwglom4w4ruMCH6dBSomDoectWUwC1UQR09Dj6uLNgazT/Lgn
         aN2w==
X-Forwarded-Encrypted: i=1; AL+hErFek8fYX9b65DY+xD2AL7T65GAlqeASIHdxPgp+n1lJPHkXxE9ud/hURYLdFCpgfmtd4D8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+disDH/T3/Mcd5AjsUoG6GxaGMcyQMP2afgGmsg9QHzXOZIdMU
	elEQJucIuVv4kCS6KnwXflYUF3YsFE4Ag/L9ISqSdIq6K9Ch2hEqpZLoBWVhTOjx9T43ZQCmRxb
	LxFO0jB4nyyT1wRjbVZsU7evxYrNbvt7UmhrSK3ta
X-Gm-Gg: AYBFou1R2mkwllbLwsMGejQK8qyAlWboaevUBvMH6DM3ccIv0nX6TImeEQBTycWAdtd
	M2hEmF02mZ2U8urYjec3kEb7Ev5e4qwUVf+sI662+6uXLQri3xVj/xh2LlOYjMBFEm664Mcljhz
	8Kz8bWxu/B2rQ8lGcg+nduwCJxvDhKQ2JRj3ev1sGUZHJMKWu1Wwc8esUBEScpUu+RhjfDV82Yj
	jLZwppZADRBG9rQm1Jh+/pwcmGnZRMJ55GEGNL3J9SaVcnLtHVBnP+Hbl7h99I7Xm2VBHZxxlVL
	NbfqaMs7PiQIMAB0c1TcTuhRhnflNiaIKoZ+8g/uwgcIa3+wGJvdYLKx9VSeHnuOAXUK7kPzE3z
	R4aoissHc5CAjfFBgIauUIvOOqO36350Avbx/o0V9/qrX31NZ4r6k7oiAjczCSmP2xMx5n3do
X-Received: by 2002:a05:6402:4022:b0:6b3:f12d:7405 with SMTP id
 4fb4d7f45d1cf-6b7a2a2458amr26083a12.14.1794443344422; Wed, 11 Nov 2026
 16:29:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 11 Nov 2026 16:28:52 -0800
X-Gm-Features: AclHuK9Fp7q_BxQtLzb7tD29UbrmuAxqzi1HMzLWvRd49RzuQMFPjipCoyh1bWA
Message-ID: <CALMp9eR2tm=RkNk_cYsYj0SZmcUBTfxpYiqtLbtCE4TJ4H6jzg@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:05=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Add KVM_VMWARE_ENABLE_HYPERCALL.  When it is enabled, exit to userspace
> with KVM_EXIT_VMWARE when an L1 vCPU executes VMCALL or VMMCALL with
> VMware's magic value in EAX, and let userspace complete the call by
> updating the guest's registers or by having KVM inject #UD, #GP or #PF.
>
> VMware guests reach the hypervisor through the "backdoor": either the
> I/O-port interface that KVM already emulates or, on newer guests,
> VMCALL or VMMCALL, with the same commands and register conventions.
> VMware's userspace implements the roughly one hundred commands, and
> reviewing the command list on the mailing list found none that needs
> to be handled in KVM (see the Links), so leave them in userspace.
>
> Only claim calls that carry the magic value, so that the same VM can
> still use Xen, Hyper-V or KVM hypercalls.  Never claim a call from L2:
> the only L2 hypercall that L0 handles itself is Hyper-V's L2 TLB flush,
> which doesn't use RAX as an input.
>
> Pass operands and results through KVM_SYNC_X86_REGS instead of defining
> a second register ABI; KVM_EXIT_HYPERCALL returns a single value in
> RAX, while backdoor commands use RAX through RBP.  Report the CPL and
> leave the privilege policy to userspace, as VMware Tools call the
> backdoor from user mode.  Instead of completing the call, userspace can
> have KVM inject a validated #UD, #GP or #PF at the hypercall, and may
> update the registers as well to keep the partial progress of a
> high-bandwidth transfer.
>
> Don't forward hypercalls of vCPUs whose state is protected, as KVM
> can't access their registers: reject the flag for VMs with protected
> state, omit it from their VM-scoped KVM_CHECK_EXTENSION result, and
> ignore it once a vCPU of a VM set up with the legacy KVM_SEV_ES_INIT
> becomes protected.
>
> Link: https://lore.kernel.org/r/c60b32a3-e699-4a8c-8d52-09b34c4d5269@redh=
at.com
> Link: https://lore.kernel.org/r/CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=3D0YZ3j2=
gGhgmaFRdCFg@mail.gmail.com
> Link: https://lore.kernel.org/r/CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8cc=
xYzk3aFzCA@mail.gmail.com
> Link: https://lore.kernel.org/r/aIEmawm9gLflg8zt@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

[ ... ]

> +static int complete_vmware_hypercall_exit(struct kvm_vcpu *vcpu)
> +{
> +       struct kvm_vmware_exit *vmware =3D &vcpu->run->vmware;
> +       u32 pad1 =3D READ_ONCE(vmware->pad1);
> +       u32 inject =3D READ_ONCE(vmware->hcall.exception.inject);
> +       u32 pad2 =3D READ_ONCE(vmware->hcall.exception.pad2);
> +       u32 vector =3D READ_ONCE(vmware->hcall.exception.vector);
> +       u32 error_code =3D READ_ONCE(vmware->hcall.exception.error_code);
> +       u64 address =3D READ_ONCE(vmware->hcall.exception.address);
> +
> +       if (pad1 || pad2 || inject > 1)
> +               return -EINVAL;
> +

Should this check kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip),
like the fast PIO completions do?
