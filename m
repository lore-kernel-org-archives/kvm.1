Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840A52ED34
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914101; cv=pass; b=oNcL6FuYhuGsyqIGsAhHsl0y6yHMcisa/4H0LYqui2wQ4kDnDXw2dH7pOgHVymRE/ElKU9ckTF5e/gttILlggbKNK2/ObZObuDYS914W16WlmEP31XsTcmKp0q1XUP7Y/bCglyCZBxx5ParuuEFdjN4ddlUkzzqlALv3FFx59Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914101; c=relaxed/simple;
	bh=BMSS1jckBQ2e870f/uI3vrk/j+iBZv6E/rBVCsIo22k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz5B+kk2BiQ+GxnSo6+CkGeMQES/YSPiIEEWTOSpnyxUaUoMMsVHR+tWnjV7AK1zBSKYkxp4ep6DkJrQ+RzUgOa+TtYucgNGtHs4lMfGcfEL4EhbwiSnwfQZliSDBg05tL+c9v86dXmq3q8YO+c4KO3wWQf1K5iwy2/sDIrfNSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdzfnWTJ; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdzfnWTJ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so28735a12.0
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 10:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791914098; cv=none;
        d=google.com; s=arc-20260327;
        b=WZxCM5ClyHwJJ/7FzhgS0A7KZLLhad/AFNtPKgYSSM7jyX4XnrOQVX2oIwggGsYCCt
         gt4cbv72UmeHDyxW0msTS595CwvqTb9pFGpX0zQLtZEEju0MeaTpQBwFfl7VpKRQucoF
         +woeB2d7l945B5DGjXlZUDb4yeX01AIXscSkrVrLuU1CWb0y7cu+zXEu9/2qJxe4ZQlR
         wfOBMYvyidN4C2EyNvIjvl2QHpeEbxzSBnvjqycM+6fIr43yD2WFmoBcz3QAbEl5Qm6J
         7TqMovrVB1P3NRI9VYyWgXhuWOYt7jaBnHKEXZ3xybVuDkLVWAZvEDLQICcY7wARm4Rr
         N0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        fh=jVhk0Se/m4VVi3M/SlyXMqJJaF3n0g3aI8fXF/fePJk=;
        b=JG2gyTmUCxXkFDG5KxfPZEbxirCg0N6chGF/YMWAXnsMQ9/lIDzCZqxTTS2LpXmKY3
         RzIO2rcZogjULuq+tPeque4Acu5IQh7vkuEHLJxog26soJNnm0Fwg96gsSerqRVoTNxx
         paVelb7Eko307sbaiSMiM5lmMLQ44brI6m76WOc5Hh219kXEqe57hue4hdmMtiGU512l
         d8272LoKUX2ASRx4zsufM+z6MwAh1rgokBiGxmqyr+c6d3hhLtDYRQWZEVZywD57AaOJ
         xgetw5rl7TmjjGTn0nX9DD5zeskVkYUvUvROkcWLafjkZm3EUQx5Yc/2Ryd3xCyrDyh/
         YcOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791914098; x=1792518898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        b=TdzfnWTJ0JE4/RKyDdhY635Wlr0PdD+bTTKkJhom5yLAE/BFvIk2t5NwioHKhupKQJ
         Sfp+OcN2pW4OI1AEHHMoVEAs8vvAgMX7MDKKy7RKj2Oo13oEDrgj2+PbgmW49ppQyiIz
         NVqVlu6s6A/VgYlcZlqPS8CW2WLnr202X9VMSCnS2flGKOvd3eIZ5hX2quvDMqR8smEJ
         YdHQCl3mRnjZwyt5CkulHrslCszA2udgoU5PGQyUhY9CaOUZ1/oPx7xdzcde3qwTVEln
         2SX4/8G9SZu9gRhq2n15tsjDrYy+6lt43T0obPvRKoSU9ropeaESFA3BnfsRa8y0O3Vh
         af3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914098; x=1792518898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRtjnC1p7Gi1e00oi/1sIVluDFzpjss9Zq5iLpeEpPQ=;
        b=qLMIi1xYWNhNcwUqVjC2kO3uElt55N0s/EhC7NKzhDMetcVIHmFsC6+QkRn3Dxm+hq
         uOkBLCqPh/co/FHgvV8AetiFeydCUN8Nuc8VNyGLJInyEG4CSNSkoXTkr32RQneuvLcM
         FIEvl+RqN8mUUflUYMxCQuPsY88gl9NqO1dTWi3IQifqRdA6h+/oP7p/YD+6ZZYoGzOR
         HC81TO8rfxxDeknnPu/TU9MOPqs2GHcUpOnZ0k4L/yAouvKSyErhS93qCG7okjGpAYIz
         h32/J+Lzd3wy8EFAK15BjvCkQ4ld81YJj7qOOtKq9wfqjCAhiv9XaQp1Nia/8e2Hacqx
         yukw==
X-Forwarded-Encrypted: i=1; AKwUvBx+t+6ZQvksnGENRjqxZM9opN1a46JJObaj5GsleuW/pWfxEWrQnfBH5SmoivqLEQfT3jM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9F3BJTfBFhsGc++IPt4N070GIv7SySwhQrDYbdvsZ9YkkJBhn
	9NHMWg2dpuz77y4pUqn6U0tuTccG9PSt88ZDPfoxJgY3OwS/UbraXpzp6WE1t5z+nQbvkNE9NjW
	YzkdHEC/cREzaWyjU7vSolkEfl9SclXcgqDX4lqjM
X-Gm-Gg: AYBFou0y4vhBp1b5XQd5c7bXXC3yG5VTfhetYAaBLgMCn9/Av0S0BflPhLf8b1mgHh0
	aHOGao3rZkOWHEaTbZzpelL9YPzmh2edo0guwpimmTZ/RjbwKtKv0j+pVqe6cybNaGkg4+s88Ws
	1qKiFKNbljLQZ6vKtpoe7uHrOLDxXKqktbdp3DEHqo0mm7bMOIczIolj60c0mUF0Gw9AzOX/QCu
	/yOTwCZtR4q7nHQTH0BFE/5xjDgXn7ZM2RjXpdUv2qFL6Y/NV9sCyfipOrANwd2ZDr0ul791Vcx
	B3zoWygkJXFCLiNGP0oFfHpvSd3ETd4cLKi09/P7F2p4PgVhPF1sPwc=
X-Received: by 2002:a05:6402:150a:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b1b3bd200fmr133982a12.8.1791914097201; Tue, 13 Oct 2026
 10:54:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
In-Reply-To: <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 10:54:44 -0700
X-Gm-Features: AclHuK8WC6fCM25ehSI8d6hZUp_f28nDxtHAyGF1VNE9tdU9vNWCl9URQ28bhU0
Message-ID: <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
[ ... ]
> > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> > >          * - The new VMCB does not detect a pCPU change and runs on p=
CPU A with
> > >          *   the new ASID allocated on pCPU B, which is potentially u=
sed by
> > >          *   another vCPU/VM.
> > > +        *
> > > +        * Note that dirtying both VMCBs is not strictly needed, but =
the per-CPU
> > > +        * tracking is shared for both ASID and clean bits, and that =
CPU must
> > > +        * match where the ASID was allocated.
> >
> > Is dirtying both VMCBs not strictly needed?
> >
> > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> >
> > > The hypervisor must clear the entire VMCB [Clean] field to 0 for a gu=
est, under the following circumstances:
> > > ...
> > >  - The hypervisor executes the guest on a different CPU core than one=
 used the last time that guest was executed.
> > > ...
> > > Failure to clear the VMCB Clean bits to zero in these cases may resul=
t in undefined behavior.
> >
> > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, and
> > then migrates back to pCPU A with some clean bits set. At the next
> > VMRUN, pCPU A will happily load stale state for anything marked clean.
> >
> > At some point before that VMRUN, something has to clear the clean bits!
>
> Dirtying both VMCBs is not needed in all cases covered with the new
> code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> which is shared.
>
> Because ASID is shared, we have to reset the ASID generation for both
> VMCBs when a new ASID is allocated through either, and update the cpu
> variable tracking which pCPU allocated that ASID. Since that cpu
> variable is also shared for tracking which pCPU ran the VMCB last, we
> also need to clear the clean bits every time we updated. IOW, if we
> had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> update asid_cpu on pCPU migration for both VMCBs, but only update
> vmcb_run_cpu for the current VMCB.
>
> This is all annoying and confusing, but that should go away in the
> static ASIDs series, and we should go back to only updating pCPU
> tracking, flushing the ASID, and clearing the clean bits only for the
> current VMCB.

I haven't read the static ASIDs series, but in any case, this patch
should stand on its own, in case that series never gets committed or
gets committed much later.

My complaint is with the claim, "dirtying both VMCBs is not strictly
needed," which seems to imply that dirtying the inactive VMCB here is
optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn't
later miss a pCPU switch.
