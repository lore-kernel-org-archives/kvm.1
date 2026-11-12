Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794509591;
	b=BvxtncWJmfAqegvH96OQmcq3ZCd4UN6QpDLj0u6tsE+CtlSmQTtp35xoxCD9D/Av7gVN
	 +6qcHx96TOgp+DtgY6ay7ECveT5kqefKL7oAJ8IiiTxgeN2/+M4u9Pa78xhH7epW+CQhG
	 UisMlBhtDhlGu+/UaA3KgoVWdtOALOBIwB6gQ27LUdIASRYCQDeKQd9KuMIaI4HZ57rOp
	 okFcgCp+EI2cu2c/VF4MvqC45z1NltVuQBdElAd1e+kmZk0x+R8yMqxfGXk8/KGak9CUw
	 h2PgwRqQwKfXVYwKJgSyGuyOgFcP2s5fCBT10BB5PGMrj5J7omWog8wI8ZYeYtQYYCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F3Tw9p9m98nVDXDhiISUHwXl/bWsyTWQBoH+O8XaA5U=;
	b=mUh6bwWuLCJc1Xw3UGk5eoothgl8UhQKtUm4oYJMHJAKsv2BJUTd/Sh+/2ezz8eL89UG
	 Wf/khtV3fk7s0Sv4fFcZzDNoJYpqS1SPWwuW624YgUd2w4tr+NcDgd1EnbcXzeETJHGle
	 Y8AcvESViVLJ0eo7yD17iFGduwy+Xd64RtJgyOSn8rPvJbtjGwLo4Pp0FOTLj72bniV48
	 zOgEhIwu5Igfc29jl3L792dB75dZgz58UpOLnR31CLUXPcCZGVysXTgZsTZOdhzzsNhcA
	 3YyplojuKvTc7zW2a4ouwscR6Vym76hXq3Fyf0msWfdjaMeP91T2Un1wJ4w8lui4Izg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZrXABmQC;
	arc=fail smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A556606A339
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 18:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A556606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZrXABmQC
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso714a12.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794509590; cv=none;
        d=google.com; s=arc-20260327;
        b=R31sxBD3j3gbnba1jcL7JeojR9WwO16aiYt8TtWHGMywK44XDNM6uvUGPqlYp1A5/L
         4y8vbrQecZha/n1f16pC7KZYbf3idCVAFhvdlMSPwplt2HeGjFKEryQrCeaTvJgiC6w9
         518/n+i5sOoRH2UuS0zyjFnTSOCUvAV2FVuIQ+1IJ993HfUFmUDH/pGzK7X3/Z6L/Evr
         myvY1DDulcjwxzvVZ11eOBRB5BZsjitf5a6Ry6fcMnKYpMrwTFZscp47Tke9HCXTS+lM
         Hyd24hFyGqwbGSFb+oDe/kycn4qKk3OyjRzWqqbKOSSS4g27WZ6HJGgF4DPXL5SE94to
         PAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F3Tw9p9m98nVDXDhiISUHwXl/bWsyTWQBoH+O8XaA5U=;
        fh=9dA+m4NdRieBkxaIlr9pcLCLR3ATLIGVoMOzJ6zkIRk=;
        b=MgRCHL5LR/HMOpjSYzkHoROBQpzEYpPExl8L6tDYW1jb06amdnrTSgyxYRAbWxZqhC
         Nc3skmhCNP8Vu6myylnmDt1i0YdoR5vPttspod0HTaMHbQWRMHwHseizqf0KiCnpAwoT
         YU0cTFBtYbBDdG3bb2dV+sKSvhCqc7WnnSs+4U1tmtngZPjoJYJYgIuEAT+b3IKqissJ
         Y89B23wXUmDJBcNZqK5Dqb4LX/sNm4SbIaUjZlqQG/B59GNcmP6h83+RBK6BSrCWzglI
         v1DB9dnAfREaYAlxF0ekePzcEdqokXFCXyuXvg/6BaBd/2uyC5STZFXATWTto86PAVZn
         VF1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794509590; x=1795114390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F3Tw9p9m98nVDXDhiISUHwXl/bWsyTWQBoH+O8XaA5U=;
        b=ZrXABmQCJ3w7fpvZ4karrFrjqd/K0rpSVTywmX4rQzivW0jGhC03EBEcz4x1rZkt8Q
         xZcs/BuI8zU80KvjKJSKuYtuGN5mjG+fjxgyYY1zzVeneVge+I4spJNx2yu2QvsTT+3z
         TvPQqMAGvHx2vUpd9qW4OU+W5Fry9rR5vNkLu1Dh44916sm5TAsfKFS63IqtWkHs77h7
         R3bLVHvSuDoXdeOb4Sqv80Gbk7hHPfx1g7wqwZXqG6wIyCH+p+vTXKO0uHUqslp9hEqy
         9SA57J0VwZZvrWjkKS5FzZu1G0+tHoMzzkIWcR9t7JMe3BPtICsD7vMYb+uUx9TrZQEC
         uAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509590; x=1795114390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3Tw9p9m98nVDXDhiISUHwXl/bWsyTWQBoH+O8XaA5U=;
        b=bGmEfUPvxv/IpZmgxIqbQq8O5hOpYUMkhqNFgAbABCl5/mZFLd/yLSg2qrOc+RvaPO
         1fHXjl/3WQNo49YaqR70qTWa0SXu7CwoCCsW6aTWOx+ssVOd6sWSFgZBezg38m8k61ls
         tpjQ56z2SmAkqFwIQb/kBMvJmp5AI2DbV10QYghGCQwhAxciC1qORj6ZL7m7T6KCRHte
         w+BCmU20Wscewo6mf6hDPWe3PBH0zgI1Crvcp5CsWAXuDXumqaZhSNfIt4sCa/+LY2FL
         53KGjBDkHTmm9GxLgunQCdV4Tnt6FYHy2mXXQ9jd13GgZOiUCiL29ovpyQwyjWUnAzxL
         o53w==
X-Forwarded-Encrypted: i=1; AL+hErEGDMwZ2LWFYeoQWN49U8UgK34Rl6/cAu8zVCVCD1P+lV3NF487H4CmwD0Lg5xTfIemcGQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TjnVoFgg5AYH6Pn0pJAlF7o5NxMyT3ihGjjXJYGqfkkiElpY4
	PbNdA7XyvgkdWa4Gz8M/wfwdgt33QY2VIZmHAv+4pP+bwwhelmFQ3YBzbfq1fxSwBrt3ZAyKFBo
	+xvFFRF2TCkleSYaNrfIM1ec3Apsi8yg+YBXKXzTg
X-Gm-Gg: AYBFou1jNkEH7p8ExPeUfuqWqbOWKtA/MKcbJlE8poWx7qpV/22KUgpWXfomlcdXswf
	1vdpEZNHIkNImH4PiEchQPWAUrexJC4Vx7qtg1juhNLgBZbsMd8XI8KJq+EffoGIzZpCPyiiETD
	btxWaycNzogwIwx6D12h/c+lRtpSK+VGNfBmuXF09DpfvMgIicEBuajZn2BsiOof70Ix0btzSGe
	OWlk/TSJR3mO5Jp2wyQ5GfRPE8K3ule5nOm8i8a1lfKBaYsmNqxQs7Pis0l7DuYzIW658w4KaPN
	7ettB/KL8j1rlEn0TW8n4yqwQpuNi3V1l4R/0fWxp79fTAWimN7iOkEvBlQtbRvNbnDbCXXLfYD
	8Pw5Ke2E8giLGrZ6QuWAIQycR0zZPK/5Ji/ig85FwQvxMlcegT8QJnrUOqyA+yzM3oBaB8qDG
X-Received: by 2002:aa7:d85a:0:b0:6b5:66cf:eaa4 with SMTP id
 4fb4d7f45d1cf-6b7c278a457mr7058a12.0.1794509588955; Thu, 12 Nov 2026 10:53:08
 -0800 (PST)
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
Date: Thu, 12 Nov 2026 10:52:56 -0800
X-Gm-Features: AclHuK_9mvODzBgQFtLS_Gtq_h9EB7DHS-Em7YexSsSAbzFwFzuvZxGvVdZTuHU
Message-ID: <CALMp9eTF3WtzGGaV=sCYLqm=8oHNbqg2pYUr_qtcXJaAKjc9bQ@mail.gmail.com>
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

It's not clear to me if this paragraph implies that VMCALL and VMMCALL
are supported cross-vendor. If so, it may not be true.

In arch/x86/kvm/emulate.c, group7_rm0[1] (VMCALL) has the Priv flag
set. When an AMD guest executes VMCALL at CPL > 0, x86_emulate_insn()
sees Priv && cpl > 0 and injects #GP(0) before ever reaching
em_hypercall(). The other direction should be fine, since
group7_rm3[3] (VMMCALL) does not have the Priv flag set.

In any case, if cross-vendor hypercall instructions are supposed to be
supported, you should add them to the selftests.
