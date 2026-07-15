Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D783195FD
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123542; cv=pass; b=jxDHDeIJMWjOmSXNO6bX90vchSKg0NqfSo7pJgNmhsJnfM3I/XwXs//LCMyiSEDWD6ixXajWiwO06mO9k38dnK3blh3fLwf5rIge6in4l9iNv8Kd16tv0YEGznF2dtPUvAZLnBC44C8iAzOP6raRgXuDCFS4LK6kSXdsFVJ/Cfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123542; c=relaxed/simple;
	bh=FW104Yn0vU4ziR3QiwwF/Tc3uTUX6RTtPXAjGc7bIcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmKHAm17vaEltvduXat6LPugH8WPAAvKbzw4uMAOGi1ZYwjt+/ifnfUGSEoGKPJrJQyzsfYLUJRjoWbD02qENEMB3g+6uPSNpJ7/cwz9LCpFVRbHgyrusdmDLSpmsy/enVjsj6NtNc+T+6NfAxIsEpsSB2Nnp29oG2BgI2Set68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZN0CDow; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7TKj3mv; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZN0CDow";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7TKj3mv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784123539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEQR9a2ZwOoKfO74/7iDwCv+D8Y4eljlpUTeLzkGT4k=;
	b=HZN0CDow3dFyccPc9uqXnGnCLNHG5B+s2ikCfvVNgQyXP0/12I+uOKEVRErlAb6rx+tJpv
	30iHx7EyYJhZe23XlSMwn4+sZAWQ+qYdf1/6Ea9kCShrIX18NnlRtXPaFPXAhgU/sXNtHr
	wsjRmP8aN0FbqecDOqtc9Wl4awq0wBU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-UOQ4PupkNemsYuJpMTKacw-1; Wed, 15 Jul 2026 09:52:15 -0400
X-MC-Unique: UOQ4PupkNemsYuJpMTKacw-1
X-Mimecast-MFC-AGG-ID: UOQ4PupkNemsYuJpMTKacw_1784123534
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8894570b58so1729167a12.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 06:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784123534; cv=none;
        d=google.com; s=arc-20260327;
        b=cvMKiqnzmZxaAWZfkEmEoD2NMuAu16TpGGaVdYFXqa7dFLPqB7JWegcWeOPhFiEkMJ
         lAzR5hDeVCyOnWNVUeAj4ZHJRYGD+Tsd+0mng7vI3Rfn2JLgb5+RWJi2q50RyQ+kiqOF
         y+o7Dhvi28jtmKnPEPeIuSdQ6ktE8S9gFE9Ldq6GInAgqcnTsdT0uqB7/vRns8Lkn2ct
         rZ04OSTq3adLPu0pAxkg/MtVN/KfLC8OVgsFwZID7216qtK2MFv5nIy8WAlOJfwtXnJ3
         EYWrtVh63nNR0JUZbLhLwy4smFA5AoZiqnzyBQ2utBgsFGVYMumsxGQrcxcSUYEKxWlI
         zNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wEQR9a2ZwOoKfO74/7iDwCv+D8Y4eljlpUTeLzkGT4k=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=QDyFlmTkbjblVWBYagaX7kLn9mXD9QSyPQDupz/phK9LCchzVJjE9B8VqOFbe9ZM4q
         QXT5xx0Jk6iD3fNXh12ChN3wRbgRNzagytXInTG6aTgTcrS4uTiwTHBZjPmtB7hO6uXp
         KgPQmvee7cNdRdgmj+xN8+hEDDxV8CUPfoVmiI8C6+vaX8l17ZFSpTFfpDlnlKPMaB/o
         EQR27oPOTuDCkcSY0/PecvqTxiaoJ+l47wktIYo/SK/xbJug02vDhZaTYUAM9fcV70CZ
         qg0gP8XHQJswMhsUuy+j27zUJAYNvtW3qCZRz+QI7ZJcIb1Ym6Rll5Yk1gJnC/lIdN2M
         VdsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784123534; x=1784728334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wEQR9a2ZwOoKfO74/7iDwCv+D8Y4eljlpUTeLzkGT4k=;
        b=q7TKj3mvYHpua5bFCyUZ6cWbW7YTcO3/YrsZMsNHIf3e3S1l9ZvmsQBDiFkYqTSvaZ
         qLjRn6zTCkn5xhNH2KXvigpPNpbSTY+qG8yIiwBGd7uPgI+C7qu4zxtR3jznYHi7FREL
         q35E1fjaxFAqoPpVJpAlZPl7sYdqI4SE8TL1SY9lALXLeVVCN/j3lnER/bep5LvcaSLe
         eGcYGZ+wO1OTRa8+L6iU1BFBsjWYlT6u3lxFPe+mZFyAVZ/1IatpO741Lzcl2478whJB
         v0Isbje5xb2wcL6nIyzbWQN+ww/z4o4ktlKuQwp9LCGSEEGLWoj9ex6MwwCWt1Wy7Uyy
         kcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784123534; x=1784728334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEQR9a2ZwOoKfO74/7iDwCv+D8Y4eljlpUTeLzkGT4k=;
        b=MCHMCMcaTwvU4umD3pnmrxgINv5iOSyZIarLY/9CBPXP8kMKxiHa8bf2Pgh08wE6Cj
         pO7LRnCCAlSXhMaEFwFYwai4+xYdFPhxiALoDLe1BwCGww0+KEQqQ/9SHZ/IHtdRB++4
         pgYnjLkh4QbtXFeZhd+IBzUsiKjC9IweRF56vJp9yekSnkdwbIyhl3g7MrmOQXBAOOz+
         b5yS/fXrhsWYknljQ5AjTxP4s5hQTApEkggyoLAF33yXahKAog2P7JJWIG/ccpXCBFpG
         dWohVXe4906IzVXTaxOUGiAqAnrOHn4+6VuZRpYMUtj1tEl8pnmlSEqokb7Aupne8KMl
         tVTQ==
X-Gm-Message-State: AOJu0YzoqKCl9T3tzyPxcuU5C462eusgMTPAWG+6Ii4CDPpVAKEPkG01
	mrwqLvoBOmCvtnvA5tfbmFpIfyYbG4azfBLvr4ABMMk5xh5MqSmEFRFH68yBQsxTek1qpe53+oc
	eKO3mconl/omoMMxxv7Ab0IMBGQy6b14mMFw/n5bhzRBFlURz/pu0/RhHurZWZyOZ1vA8hQCRFL
	TeJRabH4VLnJ7SbP5ylxNXjMazJ8bDu0h4F20SXrc=
X-Gm-Gg: AfdE7cmgJkKXdhaITrCThEP4wXP/388qqa+NGogFotVeEo+b/xt1Cc3Q+ZWta8LqBtt
	Q0FqQbm2lNxWE8VCqETgXT7mqOKsPmhDg1MNK33O4s2xIYa+lYl3jMPCSUmif3iyHUlr/57GefS
	N3DgLsF/X/6YVMZP2kkXADnuQ4AWJ6TasV+ZWBtpAcyarl6GkyC9QuvIK8pQrDJ/kdw9VBR5AJQ
	Y1MQtC61smgN7jYN3ebimZpJGM=
X-Received: by 2002:a05:6a21:32a2:b0:3bf:9cbd:9a39 with SMTP id adf61e73a8af0-3c11076d85bmr20380463637.10.1784123533580;
        Wed, 15 Jul 2026 06:52:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:32a2:b0:3bf:9cbd:9a39 with SMTP id
 adf61e73a8af0-3c11076d85bmr20380437637.10.1784123533101; Wed, 15 Jul 2026
 06:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715124235.1444895-1-aharivel@redhat.com> <20260715124839.DCB811F000E9@smtp.kernel.org>
 <CACUOEi9wRzr2yJJiu1fAk1xYFuDu8NDbpKKzbhQ-9bZhxaKRpQ@mail.gmail.com>
In-Reply-To: <CACUOEi9wRzr2yJJiu1fAk1xYFuDu8NDbpKKzbhQ-9bZhxaKRpQ@mail.gmail.com>
From: Anthony Harivel <aharivel@redhat.com>
Date: Wed, 15 Jul 2026 15:52:02 +0200
X-Gm-Features: AUfX_mzBf6o7KTNkVIgVybdhZQDr47WvQdJ6_YsNIALK6hoAdctfeew4EC8r8T4
Message-ID: <CACUOEi-0LGCh0ZYnsABPb=yL9H7D4dF0gnw-gHv37gge_ZzndA@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLICY)
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review - both points are valid and I should have been
more precise in the proposed internal flow.

You're right that executing MWAIT inline in the exit handler has two
fundamental problems:

1. The VM exit clears the monitor armed state (SDM Vol 3, 27.5.5), so
a host-side MWAIT would fall through immediately as a NOP.

2. Bypassing schedule()/rcu_idle_enter() would break scheduler load
balancing and stall RCU grace periods.

The correct approach is to NOT execute MWAIT directly from the exit
handler. Instead, KVM should go through the existing kvm_vcpu_halt()
path ( which already handles scheduler and RCU correctly ) but enforce
a per-VM ceiling on the C-state the host cpuidle governor is allowed
to select.

So the refined flow becomes:

```
Guest issues MWAIT with C-state hint
    -> VM exit (MWAIT exiting =3D 1)
    -> KVM reads per-VM max_cstate from struct kvm
    -> enter kvm_vcpu_halt() with max_cstate constraint
    -> host cpuidle governor selects C-state <=3D max_cstate
    -> schedule() / rcu_idle_enter() as normal
```

The enforcement point moves from "execute a capped MWAIT" to
"constrain cpuidle state selection within the existing halt path."

I'll update the RFC with the corrected internal flow.

Anthony


On Wed, Jul 15, 2026 at 3:44=E2=80=AFPM Anthony Harivel <aharivel@redhat.co=
m> wrote:
>
> Thanks for the review - both points are valid and I should have been more=
 precise in the proposed internal flow.
>
> You're right that executing MWAIT inline in the exit handler has two fund=
amental problems:
>
> 1. The VM exit clears the monitor armed state (SDM Vol 3, 27.5.5), so a h=
ost-side MWAIT would fall through immediately as a NOP.
>
> 2. Bypassing schedule()/rcu_idle_enter() would break scheduler load balan=
cing and stall RCU grace periods.
>
> The correct approach is to NOT execute MWAIT directly from the exit handl=
er. Instead, KVM should go through the existing kvm_vcpu_halt() path ( whic=
h already handles scheduler and RCU correctly ) but enforce a per-VM ceilin=
g on the C-state the host cpuidle governor is allowed to select.
>
> So the refined flow becomes:
>
> ```
> Guest issues MWAIT with C-state hint
>     -> VM exit (MWAIT exiting =3D 1)
>     -> KVM reads per-VM max_cstate from struct kvm
>     -> enter kvm_vcpu_halt() with max_cstate constraint
>     -> host cpuidle governor selects C-state <=3D max_cstate
>     -> schedule() / rcu_idle_enter() as normal
> ```
>
> The enforcement point moves from "execute a capped MWAIT" to "constrain c=
puidle state selection within the existing halt path."
>
> I'll update the RFC with the corrected internal flow.
>
> Anthony
>
> On Wed, Jul 15, 2026 at 2:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>>
>> Thank you for your contribution! Sashiko AI review found 2 potential iss=
ue(s) to consider:
>> - [High] VM-Exits clear the CPU's monitor event pending flag, causing ho=
st-side MWAIT to immediately fall through (NOP).
>> - [High] Executing MWAIT synchronously within the KVM exit handler viola=
tes Linux scheduler and RCU invariants.
>> --
>>
>> --- Patch [1]: [RFC PATCH] KVM: x86: RFC for per-VM C-state policy enfor=
cement (KVM_CAP_CSTATE_POLICY) ---
>> commit ba053ea08a3b49a2e72662168226ef280171ed4d
>> Author: Anthony Harivel <aharivel@redhat.com>
>>
>> KVM: x86: RFC for per-VM C-state policy enforcement (KVM_CAP_CSTATE_POLI=
CY)
>>
>> This RFC proposes KVM_CAP_CSTATE_POLICY, a new VM-scoped capability
>> that lets the host set a per-VM maximum C-state ceiling. When active,
>> KVM intercepts MWAIT, inspects the requested C-state, and enforces
>> the ceiling by executing a capped MWAIT on behalf of the guest.
>>
>> > diff --git a/rfc/KVM_CAP_CSTATE_POLICY.txt b/rfc/KVM_CAP_CSTATE_POLICY=
.txt
>> > new file mode 100644
>> > index 0000000000000..15439e6e7ebbf
>> > --- /dev/null
>> > +++ b/rfc/KVM_CAP_CSTATE_POLICY.txt
>>
>> [ ... ]
>>
>> > @@ -60,18 +60,18 @@
>> >  3. Internal flow
>> >  ----------------
>> >
>> >  When max_cstate >=3D 0 (policy active):
>> >
>> >    1. VMCS "MWAIT exiting" =3D 1 (intercept MWAIT).
>> >    2. On VM exit for MWAIT:
>> >       a. Extract the C-state hint from the MWAIT operand.
>> >       b. Map the hint to a logical C-state level (MWAIT sub-states
>> >          are CPU-family-specific; a translation table is needed).
>> >       c. If requested_cstate <=3D max_cstate: execute native MWAIT wit=
h
>> >          the guest's original hint.
>> >       d. If requested_cstate > max_cstate: execute MWAIT with the
>> >          capped hint, or return to guest immediately (C0).
>>
>> [Severity: High]
>> Does executing native MWAIT on the host side work as intended here?
>>
>> According to the Intel SDM (Vol 3, 27.5.5 Updates to Non-Register State)=
,
>> a VM-Exit unconditionally clears the state of the monitor hardware.
>>
>> Since the state established by the guest's preceding MONITOR instruction
>> is wiped out by the VM-Exit, won't the subsequent host-side MWAIT find n=
o
>> armed monitor and immediately fall through as a NOP, resulting in a busy
>> wait loop instead of entering an idle power state?
>>
>> [Severity: High]
>> If we execute MWAIT synchronously within the KVM exit handler, how does
>> this interact with the Linux scheduler and RCU?
>>
>> If the CPU successfully enters a deep sleep state via an inline host
>> MWAIT, it seems the KVM vCPU thread would remain in the TASK_RUNNING
>> state without yielding via schedule() or notifying RCU via
>> rcu_idle_enter().
>>
>> Could this hide the CPU's true idle status from the scheduler, break loa=
d
>> balancing, and stall RCU grace periods by bypassing the host cpuidle
>> framework?
>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715124235.1=
444895-1-aharivel@redhat.com?part=3D1
>>

