Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21C375AA1
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261590; cv=none; b=TCAxewEz1RZEoGTwg67XVtb/UUSwvWojcbtpMwlIbQEnBA9tTHi4XcerD0TS6BSuuGEEpDvAzmX4yYpQHmyYfZkHG2a/bRlB04vyyoL6b7We+H6XheKBmiJl7HMCv+utOdZdldGRhOuMB1VPHtx2znnCcDXQL/B+jA3PklLZc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261590; c=relaxed/simple;
	bh=b1ij5ojudxPQ4MrM3erUSopKMsyGIJMdB2/8HZ0TgcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbn1yZKN6tVkWDKWcF1XsjUn0rEaRtF9rvn3LkLLmTrtL8myvlR7/mDTP3AXDrwRMi+ZPOhvAbdekYqgSvfjR+w1tHOXFgfduHJrDYyIMS09FqIYmf30rWUCipQRSmDG4+q5y3bDYu67q7FxaJBzdf2e1kfyCUeSgNPCApCLRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDszMOK2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDszMOK2"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c738662b963so132573a12.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773261589; x=1773866389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3HOkdcLG90LMu9eWu5nSl7gFsZupm2HYXBVIRPJRLk=;
        b=UDszMOK2BKG1kxas+5KjTQYN0CmkiDvzfGDohufRhLLnMeYlQMNSEDSa3VRYhpAyFD
         sQt44z8oXvddZZkuMbJP2xdp8WAX4UusRQ/vHxQrjX9YeEMgjoUP1/3xrY2JrbkCaaf8
         fZ4hGc/1oDq/WqxL8XPUXBeGmG7EHsXBqiNHIQM1ahsqwW7Ef5LSO3MroYqGof5uLFmU
         DxTk1WhVQ+uhu9ay3WhIMAGGsX9pRSuURAbcs+cMdAISfD1xECMf/DfljsU1Djskg1a0
         8nAp0sd5Vh4gNbhCDaWjwzQ37gb2L96+stvzy2SXt9wLxNxF2D//qBkM7FugMxhKV7Gq
         C3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261589; x=1773866389;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a3HOkdcLG90LMu9eWu5nSl7gFsZupm2HYXBVIRPJRLk=;
        b=M+1pKg8JFDkf2friBR4+HyqTzHQWMy3q7olWh6Q8n18C8y78W/+HRh2ywEBQIMtkqV
         Fy0CbV0oNAab0rWSl9J156rDW5hYXRkagK161E0UnY7fIimSJSt3sAu5wKZXpdY75B+P
         22FZlhXD9W5adGgi+/sTFxWfxfxOnryK8slqGDw2Lon/QDxbIacFnYZcV9fCSidVyV2n
         WSUC67fBJmSNh4K5MC9XqhIKauxHBVuqb35qWPdYcpiNOL9NSCGU1P6Ww+OQ8Y2cUtjI
         gZpn7rUvSNgCAkfkOVq6bgL5VWH2r3hI9FAH8CFyuLcnovAtpAfWUsTKytwMUgC8kfXA
         1TjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSG1kk7Ka1M2/c+SXWTgTR7vRBeVSKMxSdaTV/6o6N+Mh5v6TH9s6fVCXYIP2CWTz/fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtVNbC2YyoX/2k6IAY/obVgJnAwgXm4gcu3UM6zXJdhEICDTg
	GDeAPjJgWssA5JfqtgM56ddw+ycJPguF6KH7B60Q8BJtqDgdLdeQt1c4p9EX5ciKzsMAPj30pjI
	DWS7nIw==
X-Received: from pgbdp14.prod.google.com ([2002:a05:6a02:f0e:b0:c73:84bb:9d81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4307:b0:398:a7e6:1e2b
 with SMTP id adf61e73a8af0-398c618aed2mr3675306637.66.1773261588623; Wed, 11
 Mar 2026 13:39:48 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:39:47 -0700
In-Reply-To: <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306210900.1933788-1-yosry@kernel.org> <20260306210900.1933788-2-yosry@kernel.org>
 <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
Message-ID: <abHTE5uyEZ4cW-fc@google.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026, Yosry Ahmed wrote:
> On Wed, Mar 11, 2026 at 11:31=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > On Fri, Mar 6, 2026 at 4:32=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > > > > > Right, but I am trying to have the #GP check for VMLOAD/VMSAVE =
behave
> > > > > > consistently with vls=3D1, whether it's done by the hardware or=
 the
> > > > > > emulator.
> > > > >
> > > > > Consistency should not be an issue, since VLS cannot be enabled w=
hen
> > > > > the MAXPHYADDRs differ. VLS doesn't work in that scenario.
> > > >
> > > > Why? It's only broken if VMLOAD/VMSAVE is executed with a GPA that
> > > > exceeds the guest's MAXPHYADDR, but not the host's, right? So only
> > > > broken if the guest is misbehaving.
> > > >
> > > > Taking a step back, I am not disagreeing that VLS should not be use=
d
> > > > with different MAXPHYADDRs, I am just saying it might be.
> > >
> > > KVM straight up doesn't support that (see my other reply).
> >
> > Sean, I intend to send a new version today with 2 main diffs:
> > - Use cpuid_maxphyaddr() here instead of  kvm_host.maxphyaddr.
> > - Use a common helper for checking RAX for SVM instructions for both
> > the emulator and gp_interception() (see response on patch 4).
> >
> > Holler if you want me to wait for further feedback.
>=20
> I just realized I cannot just do cpuid_maxphyaddr(ctxt->vcpu) in
> check_svme_pa(), because vcpu is defined as a void pointer in
> x86_emulate_ctxt. Looking at commit c9b8b07cded5 ("KVM: x86:
> Dynamically allocate per-vCPU emulation context"), I cannot tell why.

To prevent dereferencing the vcpu object in emulator code.  It's kinda sill=
y
because common KVM is tightly coupled to the emulator, but we try to contai=
n
what the emulator can do.

> I was going to move emul_to_vcpu() to arch/x86/kvm/kvm_emulate.h, but
> maybe we should just make this a normal struct kvm_vpcu pointer and
> drop emul_to_vcpu() completely?

Heh, talk about scope creep, that'll open a much bigger can of worms and su=
bsequent
discussion.

Honestly, why bother keeping check_svme_pa()?  Can't we just do the checks =
in
svm_check_intercept()?  E.g. vmx_check_intercept() already "injects" #UD fo=
r RDTSCP.

Ha!  And dropping check_svme_pa() would technically be a bug fix, because t=
he #GP
is supposed to have lower priority than the #UD due to EFER.SVME=3D0.
