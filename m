Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F34D37CB
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583660; cv=none; b=rmU1/dtwFGEvCXyHmWQG+Jw/Lxj6mKf0NyHIRFMcoUqKuuP30M7fAYJbtJZU8gcrFJlCI51NGaGvzgICrReH/arEXnKiWu4WqvuqR3mLJRN8hM7/YYZ/N0LSYMdbX/J0Fw7d2jv+G5Rl0/hjhmwdgy5F1+3i0bme09K8cw65aso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583660; c=relaxed/simple;
	bh=Ykk92tDV9M7kvVoJsqecVU31W9ystDedudQnlhM9OB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KhcpP5270/8F+5s0/2DmR9cJFTutvf9R4GOxk27qXbJ+YSN/smyfHSDcFZ9ro9/0t7NcYSJpw0p0+GUV1vjiJM/rt0N05f47gPwaPRbQZew28IdcX66kVg5HZhpqvNNiAVGvswLbJQ/KTzYuHaSxP7RHyWnGvW5WykkISc5DvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClBD6ywo; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClBD6ywo"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088202so5346572a12.3
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789583639; x=1790188439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1/boOQor9JLExDk92cynKiJhAwGiEff2rVhXxeRxqi4=;
        b=ClBD6yworE6thdWh7eCBA3FhIDrUN4fB14lIbr6Txofs8xI3/Z8QgpSotcUZJQczgV
         U5dt2rzsc/fBmI+Nbk4fEEwvTqgt6OE9pjJWdMx1szoylxvmGntWnIjrd2EAQwtO4c3H
         6seUeQW8sR6IjVIy8qjQT4Q9caop8+Q6McB0PAPQfuIxiUWhuqHNUf8GO4REBWg/jQzy
         xHksPON/HFZNUFAUDPpdLDmc5fnQQLiVlDctw3Cf+2zplA0XfxJfImlVNFA4jbVM2mqm
         HnoNRHkGfdM9DGowcamU8eMu5dBXI4xcyS8AgoiVuFZRG0Eis+Qnpm1hkV2KteIK92wq
         59fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789583639; x=1790188439;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/boOQor9JLExDk92cynKiJhAwGiEff2rVhXxeRxqi4=;
        b=Ra8hqyepNJPdnm4zYLtEUQzYLtX174ntFrSnDfn+jvy5xyvhTywAWcLfSuNLkQdExq
         9AVrXUD39gV4Cp3faalKndSSfPsg+ZA1IzgsgFg1SZgV8ji+zcyZhDOo/P/OWtQBjDEW
         OLLXkwwsklhBxPjZX/iOt771PDl2HSnHfEvrQHSv8MooGz7o4pwBzu4K8atq+4JXRwuq
         TxINnBXtKystM8l8SGHTtdiwP9t8rbD1xSVNalwpULcjbEttKpb5KCnNj5joLIJCWI3e
         zd7i68pnsVRmGYN5NZMImnPSBlUsxLlkAqSW1eFYJQ2r/dov7hTWuQn0mnvL+tijXJhQ
         KrHA==
X-Forwarded-Encrypted: i=1; AKwUvBwrrYrWZdDQ3iOaNApclFu3zP4I0A+XM1TjlA8try32VESBQEOiEgIxM2QXNvdwrMqDcd0=@vger.kernel.org
X-Gm-Message-State: AFuF++lRv4HNfshYE1Y5dHiOMB+EHzmcpD3zanMVsi5HfoIBmje0LTjN
	ybWrOWhmldOm70FD8ZxTZUtpZGyu0WuW5OXxgkvOxVrc8s1qpOz7AdvNk/WqBttQiiHF0pTLEzJ
	ThbzKVQ==
X-Received: from pffj7-n2.prod.google.com ([2002:a05:6a00:c2c7:20b0:86b:491c:9006])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f8b:b0:871:e76a:2a35
 with SMTP id d2e1a72fcca58-87238f95cf6mr8223777b3a.19.1789583638744; Wed, 16
 Sep 2026 11:33:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:33:58 -0700
In-Reply-To: <CAJxe5ctcVxmhRSw3Gt0POQTzRKoxXo7+Y3CPDe7cUZvC0QPK+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
 <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com> <aqlWt4jb4CSPnecN@google.com>
 <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com> <CAJxe5ctcVxmhRSw3Gt0POQTzRKoxXo7+Y3CPDe7cUZvC0QPK+g@mail.gmail.com>
Message-ID: <aqrhFvwFJsQTaEkz@google.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
From: Sean Christopherson <seanjc@google.com>
To: Jacky Li <jackyli@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026, Jacky Li wrote:
> On Tue, Sep 15, 2026 at 8:21=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd=
.com> wrote:
> >
> > On 9/15/26 09:31, Sean Christopherson wrote:
> > > What if we keep this one as -EIO (or better, change it to -EFAULT in =
a separate
> > > patch?), but add a comment explaning why KVM needs to exit to userspa=
ce in this
> > > particular case?  That would be a good compromise; if the guest is at=
tempting to
> > > access non-existent memory, the initial READ will fail, i.e. we still=
 get most
> > > of the behavior Jacky wants.  The only fatal case would be where eith=
er userspace
> > > really did screw up, or the guest managed to find read-only memory (t=
hough I
> > > would probably argue that's likely also a userspace bug?).
> >
> > That sounds good to me.
>=20
> Thinking through the sequence number and VMM bug concerns, I'd still argu=
e
> that returning INVALID_INPUT on kvm_write_guest() failure is preferable t=
o
> exiting to userspace:
>=20
> 1. req_gpa and resp_gpa are two independent guest inputs, so a guest can =
pass
>    a valid req_gpa and a resp_gpa that isn't backed by any memslot to sai=
l
>    through the initial read and fail only on the write.  Exiting to users=
pace
>    on write failure therefore still lets a guest kill the VM at will.

Drat, I missed that.

> 2. Comparing the two outcomes after a kvm_write_guest() failure:
>=20
>    - Case 1 (exit to userspace with -EFAULT/-EIO): unrecoverable.  The PS=
P's
>      response is lost, and userspace can't rewind the PSP's sequence numb=
er,
>      so retrying KVM_RUN would just fail that check.  There is nothing
>      userspace can do other than kill the VM.
>=20
>    - Case 2 (return INVALID_INPUT to the guest): the guest disables the V=
MPCK
>      and moves on to the next one, as Tom mentioned.  The worst case, onc=
e all
>      four VMPCKs are exhausted, is that the guest can no longer issue gue=
st
>      requests, but the VM keeps running.
>=20
>    Neither is ideal, but Case 2 seems to be better: a localized loss of
>    functionality instead of the entire VM dying over a single bad request=
.
>    It also leaves the decision to the guest, which can carry on with what=
ever
>    doesn't depend on attestation, wind down cleanly, and shut itself down=
 on
>    its own terms instead of being killed abruptly.

The problem is, I don't see how the guest can know when it needs to discard=
 the
VMPCK (post-request failures) versus when the VMPCK is still "fine" (pre-re=
quest
errors).=20

> 3. More generally, when KVM can't tell a guest error apart from a VMM bug=
 at a
>    hypercall boundary, reporting the error to the guest seems to be the s=
afer
>    default: failing the guest request degrades one service while keeping =
the
>    VM alive and debuggable, whereas exiting to userspace turns a single f=
ailed
>    request into a dead VM, and hands an untrusted guest a way to terminat=
e it.

Well, ideally KVM never has to make a choice.

>    And in the context of SNP the guest doesn't trust the VMM anyway, so a=
 VMM
>    that fails to deliver a response is indistinguishable from one that re=
fuses
>    to, and the guest already deals with that by disabling the VMPCK on a
>    VMGEXIT error.  Letting a host problem bleed into the guest is arguabl=
y
>    "fine" here, since the guest is designed to cope with it regardless.

FWIW, I'm not terribly concerned about bleeding host issues into the guest,=
 I'm
more concerned about ending up with deferred fatalities and a mess of an "A=
BI"
between the guest and KVM with respect to handling failures.

What if we "tickle" the resp_gpa before doing the request?  Similar to how =
CPUs
probe bytes early in XSAVE/XRSTOR to avoid having to unwind later on.  In t=
his
case, the response is restricted to a single page, so we only need to tickl=
e a
single byte.  E.g.

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2da61843a6f2..b2e74a407c2b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4207,6 +4207,7 @@ static int snp_handle_guest_req(struct vcpu_svm *svm,=
 gpa_t req_gpa, gpa_t resp_
 	struct kvm *kvm =3D svm->vcpu.kvm;
 	struct kvm_sev_info *sev =3D to_kvm_sev_info(kvm);
 	sev_ret_code fw_err =3D 0;
+	u8 tickle =3D 0;
 	int ret;
=20
 	if (!is_sev_snp_guest(&svm->vcpu))
@@ -4219,6 +4220,11 @@ static int snp_handle_guest_req(struct vcpu_svm *svm=
, gpa_t req_gpa, gpa_t resp_
 		return 1;
 	}
=20
+	if (kvm_write_guest(kvm, resp_gpa, &tickle, sizeof(tickle))) {
+		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
+		return 1;
+	}
+
 	data.gctx_paddr =3D __psp_pa(sev->snp_context);
 	data.req_paddr =3D __psp_pa(sev->guest_req_buf);
 	data.res_paddr =3D __psp_pa(sev->guest_resp_buf);
@@ -4232,10 +4238,9 @@ static int snp_handle_guest_req(struct vcpu_svm *svm=
, gpa_t req_gpa, gpa_t resp_
 	if (ret && !fw_err)
 		return ret;
=20
-	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE)) {
-		svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_INPUT);
-		return 1;
-	}
+	/* Comment goes here. */
+	if (kvm_write_guest(kvm, resp_gpa, sev->guest_resp_buf, PAGE_SIZE))
+		return -EIO;
=20
 	/* No action is requested *from KVM* if there was a firmware error. */
 	svm_vmgexit_no_action(svm, SNP_GUEST_ERR(0, fw_err));

