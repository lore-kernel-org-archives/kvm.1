Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDF372ECA
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869904; cv=none; b=JmUg2+pOJIgxJp7DL/qAlmmTNnGFaPUgfq/p6mPP4ET6f81lAfg66LLhiEefqYr9hphcnu8auEFPESE2W0qUtlEoSvtysSDSik8xYNhXJRa7tt3yCrURHiD22bYqfF53KLWnTeJk0Oownla1wdfXZIPhAaMHOo7G4wR3c71LXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869904; c=relaxed/simple;
	bh=MnaL2juFBIzZpHllXA1PhuDbHaeHWPtqxmlaIne4D2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNcAy5/edxqtTPZawICg0N4DDthrboQVrZPxVGjODlE5NbiQy+yAB1qyXDFtHDqFnNOaVn2rs50epF+n/Qn4TSPD1SojOnQRyyToB2sINUb7wEIBkzON/U/Ri1jXF/SpiGrhXuQjdUwxSnjO6zVBS2jrkk6qC9iRGxFD1vzwMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ub9PKCos; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ub9PKCos"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836cfd84728so21799b3a.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778869900; x=1779474700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hw5jloQawziddDYmkqU/RP2qgURiMQ5GP8Bs+BRVUA=;
        b=ub9PKCosN0Vmu6WW5RadqLxMLwQeTr9pUFB/5BNi+ysnwauQjB6+6zMk1GKvACTfIA
         ibmFRn3ZWj0l0eJGlmotdMqTXmG/8UvwDXEspwCx1S6AFbk2fBtt9+zDDFOtF4CLYHf6
         G6OPgi98C7AfmbO6Otn5KCTuGxtXxzVAKieKyK7pgeCTqqP+CVLH+rg21XeHgo3Rr4YO
         zHl79xcbf3L0p43/X87nva0qk5QVHn1i7RziyCRE6oMZBtocgFKp1znYgb4YT8MPZnRU
         NLhTgh670juwx35ecazDPxJmRX+nJOXmi62oQ8RlmtLmFK/u0wPxR5m59JefUqvSm4oy
         pFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778869900; x=1779474700;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hw5jloQawziddDYmkqU/RP2qgURiMQ5GP8Bs+BRVUA=;
        b=ErUxvpDt7hSOh12wgdNhDn/Vl1Kqs7pf2SdTdtwRaT6k2gKqORvlVY+AeM9De9w81Z
         1+VA6VQ8F00ZVY4aLHgby9eiZpEwr43LbQ9dMeVXMg/oRLkV+7rRS8fl9iDe0Ew9Q+gc
         0Xd+G+DweUm6Fn9XIOYM5oSzogIIEDVKyi+ORb4WnApr06RKUc/eA+oJ+gQenplksNbj
         /4IezQMw2E3e9lxfFykYCvxgglc4zwSMr2gU0Jz+OwsZn9wsB2OqDpUvYwRChNasjlfB
         dkhVibYmwZ5kcSUNWIaLgBlVU9ly57v8VKExAUoNRiJIFNBHO3sWfk4V6Zn2uZbVlKse
         fc/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+p4zL7A+Bpplq86WY8wau0tKDIxrl6U0lJpuDWmt3YM20gpQgGPwfT7bYHdHlgeVkG8MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7owUSBvnzR8nb9px5UEzWQmBpBsyCtqeHcI46gRB5sdiWN1RK
	281VspOqGkrh7fEn1vl623OBNb1laR2JQ6JijvBeJssdycl4Y3YnyTmLes0Ej3dcq9qRRzpomVX
	wErRxtg==
X-Received: from pfblx15.prod.google.com ([2002:a05:6a00:754f:b0:82f:7833:9aa9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1908:b0:838:5145:c1c5
 with SMTP id d2e1a72fcca58-83f18e76d73mr8331271b3a.21.1778869899947; Fri, 15
 May 2026 11:31:39 -0700 (PDT)
Date: Fri, 15 May 2026 11:31:39 -0700
In-Reply-To: <c5b71519-a129-4711-8f98-f05b3178a96d@proxmox.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505195226.563317-1-pbonzini@redhat.com> <85548beb-1486-40f9-beb4-632c78e3360b@proxmox.com>
 <CABgObfZ-UOjO4q3e9o5JGXXCO8VZ50vEZkjNMB44rdcCVxEHxg@mail.gmail.com> <c5b71519-a129-4711-8f98-f05b3178a96d@proxmox.com>
Message-ID: <agdmi9wv8yOpgTpb@google.com>
Subject: Re: [PATCH v6 00/28] KVM: combined patchset for MBEC/GMET support
From: Sean Christopherson <seanjc@google.com>
To: David Riley <d.riley@proxmox.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	jon@nutanix.com, chao.gao@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026, David Riley wrote:
> Hi Paolo, Hi Chao, Hi Sean,
>=20
> I have been testing the v6 patchset (up to 22/28) this time on Arrow
> Lake hardware. My results suggest a kernel version dependent regression
> regarding host stability.
>=20
> Environment:
> * Host CPU: Intel(R) Core(TM) Ultra 7 265K (Arrow Lake)
> * Motherboard: Gigabyte Z890 EAGLE (BIOS F18)
> * Host OS: Proxmox VE based on Debian Trixie
> * Host Kernel: mainline with patches 1-22/28 applied.
> * Guest OS: Windows Server 2026 (24H2, Build 26100.1742) with VBS/Hyper-V
> =C2=A0 enabled.
> * QEMU Command: -cpu host,level=3D30,+vmx-mbec,+cet-ss,+cet-ibt
>=20
> Results for Kernel 7.1.0-rc3 + v6 patches 1-22:
> I can reproduce the guest failing to boot. This setup causes host lockups=
 on
> my Arrow Lake machine. In some cases, the guest manages to reach Windows
> Recovery, but most of the time it does not.
>=20
> @Chao, in the first line you can see the hard lockup. Also have a look at=
 the
> hrtimer trap I tested below.
>=20
> dmesg output:
> [Fri May 15 13:07:37 2026] watchdog: CPU1: Watchdog detected hard LOCKUP =
on cpu 1

...

> If I run:
> sudo modprobe -r kvm_intel
> sudo modprobe kvm_intel preemption_timer=3D0
>=20
> I am able to boot into windows sometimes.

Hmm, this probably confirms its the hrtimer issue?  When using the VMX pree=
mption
timer, KVM (on Intel) doesn't use an hrtimer to emulate L1's APIC timer.  I=
 _think_
forcing KVM to use an hrtimer would cause result in hrtimers being reprogra=
mmed
in response to KVM's usage, and thus mask the deferred reprogramming bug?  =
That
sounds plausible-ish?

> Results for Kernel 7.1.0-rc3 + v6 patches 1-22 + hrtimer trap:
>=20
> I used the mentioned trap from [0]

Can you try Peter's fixes?  AIUI, the reporter's hack-a-fix was very far fr=
om a
complete fix.  Note, there's a v3 of patch 1 (b4 should take care of that f=
or you,
if you're using b4).

https://lore.kernel.org/all/20260423155611.216805954@infradead.org
