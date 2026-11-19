Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795127802;
	b=TM9bNodyqt7cdG87DpWexgmjsBKkOcqdm6wmQ6YW9dTVpPKacw+M637dpQT+RNG4uvxl
	 uBtlqo625cPSNCx7vTTr1xv4+HQBEjMGlAvFN+ur9toLgE5V7LNX5P9wU5fYAA4wrIT3W
	 hHW3OyljhRrq9KjM+oHnUb9/5sgGKASq26jVMV56nc0TiR0Bmt2JwZgihN7/H4MujEQ9h
	 ceufyGq8owQuTiJ+Fgt36TO0zUKxCARERTQhpUPcG3uOqRGANUkvgYaBYhmYxQ2N1Nguc
	 ENF3CaRhgOgxw1n4RLoKq3gOQKU4Kt3R9Zkx86q4vA4DHK1PquX4ESBx9EJrPkuVKAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vm1Xggef21FFhVVRJr8Gw21MyLFEoXYAO2V+bkXqunQ=;
	b=Ts2arBCA+aOUS6GXk8gKz32h4JUcm/7MVjk0nmYIgafqZy8tQPnI0wUVKuAoIyDnY3dS
	 xCBTZfpqttvsg9KVA9cg/xtRxvrndT8VL11eCOqDPllvZINpsdNdPqvYNF0/nuKzt5RbJ
	 tYeDd2w1IpXm7hdrMFiRkM+VcUbQwaz2RcPTCkFsAZOI/ou/7uBbZ5DbKMCpFFM7Kd4HF
	 zkYzQ/0jIdCSjKCoCS76g9098BYfXzAHxjt1Jw1lGfFuYm+PwStRy9cmIIpD8bd9iT3z2
	 y37NFU5URBXYBEqJ/2Ff+fsUbpgwFO2g0jA6p2zS1p6uTBE8GJq4KLeHZBEyLqxQ2kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXEhT0pl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479EF606A337
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 22:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 479EF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RXEhT0pl
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ba2bd43dd8so1905a12.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 14:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795127801; cv=none;
        d=google.com; s=arc-20260327;
        b=FWsElmrN6Q73svSCriWzqdCiE+e/QQdBQ6hMUyMhI89ZN5usAGjHGslFam+8mTnDhy
         9jkRSqUQN+NYR1UKe1MJON3xIH33I7oBL20lvhDhL2ieWw/gGU0cnlVgTNwnZ1VITULI
         n/zRIcVGR9izwxV3vB6JtPj+L54tKYLvVm0VTkt95/lXaXjpDSKLP5+9NHkp3CXd9NnB
         hXIGwZRzRQQEmKMi4JShVju06TXD1244nWoDsxJXWi9AsF5X8a/i4fTE5olW2UcjXP8M
         JntgQ2aKr6uXXJKrPuEjKMVzXPSZDtaBmng/kaFxlrMY6ntmBjaRE2UqQb249yQV3srF
         FUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vm1Xggef21FFhVVRJr8Gw21MyLFEoXYAO2V+bkXqunQ=;
        fh=jy9b9TIUhEGl2VaKTRB1/2/0H66muDu67sGrZ2B5nQk=;
        b=MgW9BuQuhKRy9PSrhr2PwF9yxof+AfXyEjsaEGSHi4cLwmOLnx3FCUyIj4x84fcI/X
         AnHnbkIigrU8AkaKpeHXKlpQaVzr8byb9voXMqkzzpW5nA6Rjw8eAl9AMy2suF2Tl8IY
         Wrig/PVkh2U4/+AGgqgUh1FkH1oOzUzLMWCv49dngZsopStMHusP/DXbOceS7aB6m/pB
         QLgL/mYklvqBPG1Cqfp82QB43Oj8prmmQDA4HDfzesKlL3gQNaVVuiqS8fJTeZd9vAEw
         RHPI/Hxv/aBHma3qsTjZ0sziUsX+uMIiF9+CZBd6MlPfb4OTwLfs1XZJtJXfAzJu2ifd
         7kxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795127801; x=1795732601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vm1Xggef21FFhVVRJr8Gw21MyLFEoXYAO2V+bkXqunQ=;
        b=RXEhT0plXkn3AdQum7MiLXCIvTGAIOr4yEaPZ3MzJ8JOaxk1V3+pwEIwcTBsT8SB/D
         W15L0Nq9UWdEPv6UZN1utcQNUjNqQcqnJGRV4aDWPM4ePL/zva0RMDP14KddpBbkKCPj
         fkTpxyKFR7MZ4wk0W48TJR4KgR5CXsaF6g1Nz9ab2DsLMQyRURIYMIZx6/8A6CQFg0dH
         VDLK+oc4q9SC/Wz61rfAR64NFUgffHWXq10895FznA6lGE2CXX5PDh/++Ch5MbC3PQZa
         dcttRl98J3YejFLgV+cbxgkAjaJUGOhVAHAfRNuUI9s9Ue+k1VAoM3OuLZXxu2uxs5fo
         lyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795127801; x=1795732601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vm1Xggef21FFhVVRJr8Gw21MyLFEoXYAO2V+bkXqunQ=;
        b=A/3SsAFlUK7d9f+39s5iZUWNDuTVHgRE3dZO9zrVFgvSp4kGg+Tm4VOb7p3xHnl86T
         8jmfH7CYA7194MK096lMPytnJwYoicN7nBVZM1xi+SaOHOZPfWDGS5RBowryvAr3AmwK
         2GadtPJK49mWLciZKdeHQdY0Fo+SbU+qigi/hwEatGc4WootRQRG0Fu2jFJzdJLPpyrE
         xpAmp39ACABJDAFq4h8TCdOz7ksvjH/rWxCMQU1aIyk/JpN7X9N3EryDHL/6SIl/ldex
         uwA7vl0agb3nj74866a43ZOmSaDVz16J5lh7/w/aayZ88UUE1uxx2q++ExuqihO9GxUs
         b7Wg==
X-Forwarded-Encrypted: i=1; AL+hErGtLPoTDmfnu3QEggqT+e8G82Yr52Rg/amSHyA3Oes8Tfd1UpCyZDCQRwOlc1b+DU3AqE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NL3SrLPRwXWtn5srDsdUfw1ehaBwy+3lhQ9BfwfbnUlFsybbO
	/tsxsy7OzYHG2vxdvK0aQEzo/Q9YHU2lQsvDEUVNbeks+q3BQEdXK2JKUsW4QtwRITzNIc1sBvi
	wx6jhrbrprkfICxifXyCeJpTa/YqnTxiPbG1I9PiW
X-Gm-Gg: AZFdTZeOHe5hRKNNgi9rdK4jt9sHFfFBKNicNgJaZdhDzb22c+qjPBsW1FahZdfI9z7
	r3T76cinGdP0R/FwSmtO0xUgLbegBubbkNLkwCaxV2Y4u72erhBZaqDZqyNUwNvAn/Ucm63qLNL
	vWlgoJpMbqQd3ve9OYyzRzLYbPI6Or06bhYh4sy2u27Z+w+QanUYzzE1dQGbsZYEcfEFK4V+Is/
	DUj7QTEdMo89E0pcDw3J7UuOOd02R6qHptv3qkrufkNrSB4QdTQbeJ9spPuinkDDihaBm3fbcPk
	DL6JWeqURApgj3+TV+hEq1ciMwTs37SZzrnHgzBp4TZ0DGddeTgurvMhANmVXdVi8IsXk+vXTKo
	LbgrURjZgf58PTYfUKTWc5XHIU4yXcvjIjvETsysILSFk3Fotni7TPvAN9mQ7+1rsDQbuPmfYMH
	AIRPdIT7hxBZFDvVSCcz8NMo2aVVyvgzdq6J0HrXPhmdHyzlpnbPeEbA==
X-Received: by 2002:aa7:d155:0:b0:6b7:7598:67f9 with SMTP id
 4fb4d7f45d1cf-6ba3d4d761fmr11184a12.8.1795127800271; Thu, 19 Nov 2026
 14:36:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-12-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-12-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 14:36:27 -0800
X-Gm-Features: Aa3M54rIx69mqx_bcZgWUQFRTJzOQnVb9GX5k2DrbhvJwVsL5RoulXdsSWhW67o
Message-ID: <CALMp9eRSN21gJbRPzsp6x0Tag=d6RF4_tJS8+bvHOEmu7XYD3Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] KVM: SVM: Add LBR/PMC freeze support
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:09=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> Add support for the LBR and PMC freeze-on-PMI feature (CPUID
> 0x80000022.EAX[2]). This feature is very often used with LBRv2. Permit
> the guest to enable freezing via DEBUGCTL only when the feature is
> advertised to it, and advertise it accordingly.

What about software-incremented events with the mediated PMU
(kvm_pmu_instruction_retired() and kvm_pmu_branch_retired())? In
arch/x86/kvm/pmu.c, kvm_pmu_trigger_event() doesn't check
GLOBAL_STATUS_COUNTERS_FROZEN before incrementing counters, and
kvm_pmu_incr_counter() doesn't set GLOBAL_STATUS_COUNTERS_FROZEN or
GLOBAL_STATUS_LBRS_FROZEN in pmu->global_status when a counter with PMI
enabled wraps to zero while FPMCI or FLBRI is set in guest DEBUGCTL.
