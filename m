Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664635;
	b=benKFQ3bgMTjooYLXTXKjNF7d44a7c8sj3bvMtvn2MlXIbU3wOiL8DX+NENaEkhPHJmw
	 Ng/UEpKW+6NgpZWHXInjJXm4C28PJoAlDlNBAYOQG61atm5+Fnkb4Wcy6KmCn0/3EWiu0
	 KMo6aCNxHuLoSMwVDt+C9SrGHY6BHY36I+KN4MG3TVs9g2SRcYZkH9CFMO/iu8CCzT1Wo
	 0W/sPvJ99vyHIZvvbLI28ppuDwwkEm/w9zPhesZoEHLLZB5L+JLCKsJb9GfeVVjz6+mgX
	 ZGahllEGqiex7asdjdkRpY5+QLA1anM1cZHY8HhzGJMdsDqGjkdwLc/zVRRiAKk0G7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
	b=4gJ9+5wwgyblCoypR73yMAwuaQQvWCFKg39XKhU1UgGtpRxKs29byVDo+6HIjUgHmfZD
	 T5NyuW3b9dJJaCNnWX+VtXWS+9uOtP2amCkwWRBP4jRwY0+kdFfbBBRRAtCEuDoSHN7fn
	 J2EKsBkjj0nnwQ8OxM1tHyCDlOWB7cCso8nZqBq1Cq/Jbbm70KH9ef9brOSlak5dSvpTc
	 MQD0OBvyhTyFffJ8PqT/qntcOv+9DBg2MLiU9q84D37oq62j+9YBY+xv3HJ2vGVVxfyvR
	 51zpY5j8Nm0HfATnJ++2ZSlNXM3Kb5+EbAOpigDad+JRU0VhmJGvifk18z+SyWdVO2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehVpHByY;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C5606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 199C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ehVpHByY
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e96c03cd0so2940236b3a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793664634; x=1794269434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
        b=ehVpHByYYF2DK9rR/bSPBeu58DBwDQ4nrUyGNi9vI0lfJ7BQa41cOtPIazX8pL4Q7x
         U4kKinUUgvsFQDFBkmqv9T14DpG3DG5iPDfjEQX4geYGzX0SNEyA/ZMvnKAltqaRKvbM
         AbAtm3VMq+LfszI+ln2vBRayeWn7xX/cT/ioXUaEvIXpHBD2zOMDcjRtV+4/pAdvLZs7
         HDR1BPNFlvYgnoDcTnkNm+K40M2ojo+mJGYX9/Ei5p82ARUgcYcY0EmjtiEkwXdEL9xX
         NlaqjSQ7VlXc9mbhexOQC5Ji0NE/Y37yvdPT1z10f9EI4xII66hJL1hsRS1mUaRWPQLD
         YNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793664634; x=1794269434;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J6L8mY31MNtz95VGUAtfNyYMcOeErTGfjG4txWKjWTE=;
        b=FOMtKt2Ismjbdt8t5BF9mMVGUpSerhVR5MQh+f97g0uTkNdE/7BcSAfmxj1kfALtHI
         SO5g+3cRS9qOzALACpot3is6HXda6SKfyDd5x9oidAESRWziI83SXXbOKa/qC/4GvobF
         A13fi6FcDvT0lX+KvT/7/QjhYn9UUcLsyp9HxyqjRUvBSewXctpa+rbIpn5vD3v6fceh
         GyXPVaP45ztVGl1I8Ac4wBJBkYeJbma8QrOiAbkavSbt84BIY5B4o/D/+jZlMStqHwKk
         Nz7BQDFZ6BwGec5VVWekV2ELg2MTdMehbs1hx+pi/sl+0wJrvjLWpAME7VFhkI6SK4J4
         OWuw==
X-Forwarded-Encrypted: i=1; AKwUvBxMSZ/nwz13mpYsrfSsQhF3J/VCBmcRTYUjHtnTThityPwNJoevBAOl2eIfTY4Lg2j/VNw=@vger.kernel.org
X-Gm-Message-State: APuU4Z98P9qA7qIn4mvI4DfqWCse6Z3JHw/huWCiiq67P6tN2eg9DvKk
	V0NV1qZgkrZHOxKwlGrRUmqT7ocX/lUAcG86KhFMigbjm5I4LQ9+BN6wNujGju8p1lxWi37RC8/
	fO842wQ==
X-Received: from pfhx5.prod.google.com ([2002:a05:6a00:1885:b0:8a0:9321:5329])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab05:b0:886:9078:546
 with SMTP id d2e1a72fcca58-8a9be96509amr9968061b3a.26.1793664634176; Mon, 02
 Nov 2026 16:10:34 -0800 (PST)
Date: Mon, 2 Nov 2026 16:10:33 -0800
In-Reply-To: <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
Message-ID: <aukmeb9mV8b504T6@google.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026, Jim Mattson wrote:
> On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Add a missing "break" in the inner for-loop of the open coded mess that
> > unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM-F=
ails
> > due to a consistency check that is caught by hardware but missed by KVM=
.
>=20
> That sentence does not accurately describe what the code does.

"attempts to unwind MSRs back to the pre-VM-Enter state"

> > I.e. move on to the next MSR in the VM-Entry load list after performing=
 a
> > write using a value found in the VM-Exit load list.  Processing *every*
> > matching entry in the VM-Exit load list makes the processing quadratic,
> > which is problematic if the load lists are full of MSRs that are expens=
ive
> > to emulate.  E.g. writing APIC_BASE triggers kvm_recalculate_apic_map()=
 and
> > a whole pile of unnecessary work.
> >
> > Functionally, arbitrarily restoring the value of the first matching ent=
ry
> > is "fine", because none of this is architecturally correct: the load li=
sts
> > are never supposed to have been used in the first place.  In practice, =
it's
> > likely a moot point as no well-behaved VMM will have multiple, divergin=
g
> > entries in the load lists.
>=20
> This isn't "fine." This is disgusting.

The "fine" here refers to what is being changed in *this* patch, which is t=
o
load each MSR at most once, and to use the first value encountered, e.g. ve=
rsus
the last value.  IMO, that claim stands: in the context of the existing cod=
e,
this change is "fine".

> The assumption that the VM-exit MSR-load list will "undo" every
> assignment made by the VM-entry MSR-load list is misguided and wrong.

No one is assuming that.  The comment even says *exactly* what you're sayin=
g:

	/*
	 * This nasty bit of open coding is a compromise between blindly
	 * loading L1's MSRs using the exit load lists (incorrect emulation
	 * of VMFail), leaving the nested VM's MSRs in the software model
	 * (incorrect behavior) and snapshotting the modified MSRs (too
	 * expensive since the lists are unbound by hardware).  For each
	 * MSR that was (prematurely) loaded from the nested VMEntry load
	 * list, reload it from the exit load list if it exists and differs
	 * from the guest value.  The intent is to stuff host state as
	 * silently as possible, not to fully process the exit load list.
	 */

> Xen, for instance, puts SPEC_CTRL on the VM-entry MSR-load list, but
> it does not put it on the VM-exit MSR-load list. Instead, after a
> normal VM-exit, it restores the host value in
> vmx_asm_vmexit_handler():

...

> KVM needs to do better.

Meh, KVM is doing pretty darn good, all things considered.  Yeah, this code=
 sucks.
But I'm not convinced the alternatives suck less.  We've gotten the set of =
missed
consistency checks down to effectively zero, module the TPR mess that I do =
test
by running warn_on_missed_cc=3Dtrue.

E.g. for Xen to run afoul of a misbehaving guest, Xen would have botch its
handling of vTPR.

I'm not opposed to trying to figure out a not-horrible way to snapshot a li=
mited,
hardcoded number of MSRs to make KVM less wrong.  But I sure as hell ain't =
going
to spend cycles on it at this point, because potentially clobbering L1 MSRs=
 when
L1 itself has already screwed up is firmly in "don't care" territory right =
now.
