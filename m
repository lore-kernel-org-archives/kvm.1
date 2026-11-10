Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794338309;
	b=fN9yXHiIeJjk5bpMN/Q42I3mQ4SPqrEgZ39H9A3CX1i07pYPYn4Oxqe8P5Mwx2C0dbP+
	 FQh1ZlU/G91niX8PXsQVQyP9Cw0mcsShn5Ddo7j/jmHATGPzwX7inikJwi8vuCTqRkhiW
	 NSj3si/fw4yziqHS/J9UkWiT/yRvrEDAJxHLAVl1xe8ydK2G+BaCQDF1yJ/AkH7Lk6GPK
	 PFGd/gif67icTAL+r04GpT7v6vqImLKjaVSVLIuonX7tq9RhnkKQ4UzcXzWiOYNbQdM+P
	 w+Vgl4Emofx4YZWviijImLEglEd7AwOrNs/1c72kZZAMEEdb1aOAdNuOwM+oy7P6AzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bbKNwN70bb9RlNiCImh5gAr765/eNXsrDR4TFosl/go=;
	b=DGGZNySvdVO9Z6dcpGUPqRk4zfoBYRXw3gWZmtQ8T1wshMa0IWHXEx0bjCeKcjy6kpOB
	 PzWpmrD645OEwvOLPhrtjEoUXDgFGhhCa1/tzyHVZXPf/8eGPPdVjrdHbr6pgpqge2PSg
	 OryrLv9N4jLC0z/pYLm45D36gX+T6zWJTY4MLJGkRM4iMdh4k3NlxeonO14645lQ8XaJc
	 WiUywR55UPrS9KWbTujCngBaCCDY+b+JwLyAgliROw5hO192KtuRoe7ExfqanPPSz0STA
	 xdhwMvloSoGQ5o3T6fbko4QRnmjaQ0p/AJmwC2iJFICLsGf9qJloj32ympAuNQLEhBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fb5CkZn8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA441606A321
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 19:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA441606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Fb5CkZn8
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b579ed8da6so1264a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 11:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794338307; cv=none;
        d=google.com; s=arc-20260327;
        b=Xam+Jfzt+FES4CU3ckmZorG7gnF+1q/OrWG0g4vYuWfFVNSBYxp9Ha1sWhK+oKfMrU
         ZJjyf6k3i98A9IANl7nW5BTrDoRuluqM00Syg2ODTVpdu9Xlv2X9yviqFIECzpHmSQ2Q
         xuedIIafteS0nlbEYSw9SkVfkvfAYSr4t67a+svSPuzil/M8QTQ5UC3+1155K2bOF+Qp
         SfljOesLfCITKQeBH08ItPWTP3pBbh4Lpx4RYsnTMwj7DsD3BJK2hUByxS9Oc4xzvh+p
         +gYyHdOPaCpQgS9eNjkPk213OICi6wHPw2DDY3Sul9CUhnFU+9iOE+XgdAkvM4iotGMp
         twZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bbKNwN70bb9RlNiCImh5gAr765/eNXsrDR4TFosl/go=;
        fh=dlouwAAX8pqsdq4Fw2W3AekcHb0cPx9vypU0h/jcw0c=;
        b=J2lFocDlXw4fiw05HtCvWhjId/GPof6Vcnwh7sBUPyC00llnNqMBFGQz3/bjamfnvH
         80/hnxzkXYhBdB7ueE5pmOmfZAHj57wJl4zNbGiFhMiC5AbB3txDkFjk8qJRYm4K/FoM
         yqhanpaxB9g3IzeMsdzGQFu1xLxTnHszC/PJuwfThTanf55XkY5+3gxySFgnmqTHW1Zm
         8RVPCL+5SAvQ7jM3jFalDLFVDYrvsxqkc9dpP3meOFj56Eor9CqOKj1hAu3pGj4iGHhA
         TzrujW87vQQ69iL1fhm+tRrkIw/8WYUfAYbdi6XiLgfhLOE/dfgjPEq07c0pVTsgVd2L
         Pp5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794338307; x=1794943107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbKNwN70bb9RlNiCImh5gAr765/eNXsrDR4TFosl/go=;
        b=Fb5CkZn8cnlba1M9AzMPVlWVe9hCWLJaZXx4jCfQNplJdtXJQbQAgQoe7th0jyBMeo
         ubEPlFtyCICt7oeG34mpOY38A+b0dCtz8r3GnOYdYzaDbuCuJsqBCFsBAYWs4Ow2BZn2
         1SLgIr78QmyPFd+8i8Ue2gW5kEEdFh2+2rjs0OSKihT4Fvck8650c4EAanDxp8IapiUc
         HsC2LC/qC2AMamLSEp67W7Kcri0Cp3dv6m4ccBAWk4YA9QxapGXisdt6ueLBxNO9aIfA
         O7lO4A2RuiTSNN1OPMDvK2OvakiIWlx5HjgiwrvWnhgG1ChTlNWe29ZZKw7PdvQmNuZH
         +FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794338307; x=1794943107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbKNwN70bb9RlNiCImh5gAr765/eNXsrDR4TFosl/go=;
        b=nspzDIuBsDvF+rPudm8Jyvi6FHNMXd1MZtpZhzkQOyERh2L2lhZ1AGbV1a/vii4AAv
         CfK3DNv3A+X0TqryAkiHGjgbMJ62STuhBE5geWMYg4CaeZAmBRnuEMjTxbLsq2NysnWm
         tLo40v2kYv0X10luaU3XixvPFkB7MacXefTRMXMh5vligx2KlI923IkxRGEl0DnrjbZz
         2Ohjt+EBVnmoJIN/7UGFeS+lXorbX+Ef0szIP38XPvIIriaMaugji/qYq3WAtrmQtAHJ
         hZhFoaL84DcBiVgwB4JtKK5DXTKBG3PBER6D7QWAMb2hxqkIZZJSwGAwB1fjb6OIAQ5T
         V01w==
X-Forwarded-Encrypted: i=1; AL+hErFxFqnW61q9D+0b5TcWQaC7KRAyQPMMy11yQI6Xa2RO37C+jBAA1FHpBTYQ6tu4auM+mnM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tdVWB0c1WZQT296ks4gSw8QfUrA8ECXtFZmQBanf436WUGV5j
	ikFYsk9w5iUpaK+xGuTUI55KrzpMJBfH+MnDAtUkcqlxL2D5BA1E6nMOlsB+mP1N558HUxld5K+
	hmXIE8XGG50R6c4eT54+39PFQIiAeEyGRDBZ0dDIT
X-Gm-Gg: AYBFou06utgojbdVhuCKg5W6RKqW45Odu88qbkGVEILl8jsRfrrc9PCHFw5SP5e21o4
	49Pus60WTqoBj3XbwlQrJMzjM/t7nkq/nSuy4otci1U5kakVIT1B3+XH6bjE/y86CWbUtwEfm/4
	hn3cyzrPbw3PhT5yfXKKhgGVuc/jgQBroTjBgcrLRCrsOcIR3aqZh8gnscEtaSkwHGHHBckZSn4
	oOKBoHhe5q2unr/i1xnUUW+EsxYAG9l2vXrvfu/YlZB+ODc0rRm6HPqHsigLR7mXos90/zqVgp4
	qAmuw8Wzoi97/B/7mx5KKPStHa1CSTg9z8tVwLPWl/bEUroQIAeIbiVAbBd67zWR5YLfeG6sItg
	XZ4KFMRdu3+gTgjHyyHObAHtDX153g2+ikCRVBCxuUTL+CRFhbY2Oy8FtIZnrqi6WxqhvTXk5kK
	EQgGDT0Fs4yejYZcV6XA==
X-Received: by 2002:a05:6402:a20e:20b0:6b3:b648:314d with SMTP id
 4fb4d7f45d1cf-6b777eb5cc3mr6144a12.6.1794338306508; Tue, 10 Nov 2026 11:18:26
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
References: <20261110004037.125692-1-jmattson@google.com> <avNYjOevOv5s2o5k@google.com>
In-Reply-To: <avNYjOevOv5s2o5k@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 10 Nov 2026 11:18:14 -0800
X-Gm-Features: AclHuK-Ld1Gchzb01Fm0YtLo-9CmGcGk_lAVK4ne9i34kKI8Zz7QGeRNBrUyoNc
Message-ID: <CALMp9eQAxDhnJGrxt8MquPKE2jsUzezn+nbRXV7E_OiATFhsow@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	John Allen <john.allen@amd.com>, Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:56=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Nov 09, 2026 at 04:40:37PM -0800, Jim Mattson wrote:
> > Per the APM, "Canonicalization and Consistency Checks,"
> >
> >   [t]he following conditions are considered illegal state combinations:
> >
> >    - CR4.CET=3D1 when CR0.WP=3D0
> >    - Any reserved bit set in S_CET
> >    - CR4.CET=3D1 and U_CET.SS=3D1 when EFLAGS.VM=3D1
> >
> > Check these conditions in software before trying to VMRUN vmcb02, so th=
at
> > the illegal states result in a #VMEXIT to L1 rather than an exit to
> > userspace with KVM_EXIT_FAIL_ENTRY.
> >
> > Fixes: c5ba49458513 ("KVM: nSVM: Save/load CET Shadow Stack state to/fr=
om vmcb12/vmcb02")
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index af0ef678433d..20ede403b62d 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu=
 *vcpu,
> >       if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
> >               return false;
> >
> > +     if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
> > +             return false;
>
> Why aren't we checking X86_FEATURE_SHSTK here as well? Do we know if
> older CPUs that didn't support CET had the consistency check?

CR4.CET is reserved if an AMD CPU doesn't have X86_FEATURE_SHSTK.
Hence, older CPUs without CET support cannot fail the consistency
check.

> > +
> > +     if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> > +         CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
> > +             return false;
> > +
> > +     if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) =
{
> > +             u64 u_cet =3D 0;
> > +
> > +             if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet)=
 &&
>
> If X86_FEATURE_SHSTK is not enumerated by the vCPU, then whether or not
> the consistency check is done depends on ignore_msr. If ignore_msr=3D0,
> the MSR read will fail and we won't do the consistency check, but if
> ignore_msr=3D1 the MSR read will silently return 0, so the consistency
> check will be done but will always succeed.

If X86_FEATURE_SHSTK is not enumerated by the vCPU, then CR4.CET =3D=3D 0
and this entire block is skipped.

> Instead of this implicit dependency, should we check for
> X86_FEATURE_SHSTK explicitly?

That seems superfluous.

> Also, if X86_FEATURE_SHSTK is enumberated by the vCPU, and the MSR read
> fails, the consistency check will silently be skipped. But I don't think
> this can/should happen. Maybe we should WARN in this case.

You're right; failure to read the MSR should result in a failed VMRUN,
and a warning would help triage the failure.

> One last question, in the restore path, the MSR may have not been
> restored yet, right? Can the consistency check mistakenly fail in this
> case?

Not with a legal snapshot. Note that on the restore path, the 'save'
area holds L1 state. Hence, RFLAGS.VM must be clear, because VMRUN
raises #UD in V8086 mode.
