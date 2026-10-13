Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D94AC143
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918013; cv=pass; b=PEOqT+ygP/iPI0PNwNTfogjB9wyCuPpaKcix7uY/htJ6pBa4Vy5Q9h4RIPuCLxkw0N8Okf62zAS8g9BzRjvCqFXglyntCJg6v7hgByOmnZHl5Q6fmuzIdntAlKS68O1Aeojwu7hH3324OquMHWU9X/HIIaMwkLlOtDf0O+pCtm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918013; c=relaxed/simple;
	bh=fZ4uddyq93kdUrPDDPzN84geaPqliQDSF+n3XASEkPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3aAm2OjxBYEmIyGVloJFyas4yUsBv3yrOPa8EA6qPdj/fCJFwMOrgp/aEhYaMvM6Lg0nguA4+accM8+X3LhteyqQJyBIV3mEr+Ug4EY+qXE8Z1aCqkKSjwqOsc8n0a5AjdBdJYLtO2uv2CUwnGjZCCml3XEmhUH+xG9JbL5zuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2hzQUNk; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2hzQUNk"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso29480a12.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 12:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791918010; cv=none;
        d=google.com; s=arc-20260327;
        b=XKg5FVtMcxUjvTrmUrDVXNm1Bu4zWixgS3Bj/z61RAbhtvtB8b8V2D9+3UTGltJ1wx
         lcMt06EDHFfvNNf+9KK2dgdBX2vVVcCSMEqfM0Gdinxi0yXnR8v/q2qQOHThZsW27Oxw
         AA1dMdD1TuD3N/3WirIMNpSmtuye6DFCt7+jmmiDgbJ2MbHd/DKtnXnVqi269jqNA673
         z1+9PrHBcOq+YPpW4lEP4JuW22biFvAZkIQCCZzt+nXL27gc+82tcXAIUzXnf5XR2Dgo
         2vl0ucV6OPBjbR/wpoUQQi0OxVgtE8buCtsY2qqfRPLmZLyZtDlj2rcPSBH9Lt8WA+UU
         66KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        fh=6hYrCKxg3/97jiHKhZy5gc/7WwpMpwnU1n5fm6F6QDo=;
        b=aiG4zN1Pu8gyE+XeK+tQw9YW4X99vxeJm92ezu22R3K/40y5PWkciP3WpSbVf9U31j
         9LW6F6MwAk+9Sm/tXCTBv7M7FFDtMGJwxvZUw2kx9FIaUrsP+0G3mgAAVZiDEw0DId4m
         fLedyr/HL7lYy7IvS7i9b5wwyN8tAlDhwXxLJIWTRB7GiIgM+hObFW2mSEpNrG5cLxwD
         dKX7aNGi2A1cka+INWNiDcwwLSurolev9PFDNZE52WrPa/cO5zCj9GN5hIJRLWxE4dIo
         QKWTGMjD5kp1h2ALTg6B5NxmSgr4Y6UMXOGbwkU5+jPicjbdsx1QsUeCGBcUFfp+VMMc
         1Yrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791918010; x=1792522810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        b=v2hzQUNkuIvEveZpIsJ77vpV3lCuvmGKnXBClwSqlxxY0m2WCvdYquUZIq4OIhqpue
         7/xbp9EZ5P/avWFl5g3JzhyOqJv6mpx59BAy2P8/0XBTaV5Tl3ycS9SunIUt/+8qJeDx
         knMATjY2CPFNPRhdLrEjLlJFSnsJ5OavXWIjsiRFNTIamZMd2D/cfrXdWGxJX+kgzu3D
         WZinIhLuKh3m7OiTRCUG6Vd+qACky2PlqzwzcxE0zAezglew/hPKp+pN4twF9toAeoVn
         7xh+Jf7rtiEECFKZZYgV1uP6RtLgIRNS5+dBL93l8kyqJaqsKbOwQLV1Ql1huz8phxqc
         3LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918010; x=1792522810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2TmVY4407RNY3aYogF/mtX0taIxsikxKl2uKNeM1jE=;
        b=qVe7LoW7RSzcWj4uVXuXw7Zlgbx+PgIDwBV8BK2fBpLDIKsju62nR7/6+bKk+5ntKl
         iyeqoXZycl4vMA0xkoDEG18qZJ5nonruopCngpdF6zPH6kur3XyBVVncY0OeXLAGi1sD
         X6SRAH4nxXaW+9LQAelJO7XjeofB0lmkdZQK/QYyctne3+HW5erOP0LiM9Baw7iKlYcO
         9XhM5vYIBNgkrSXYzzQn8xL6Vz8OhOYI/40Gh7QDVgi09xh+nVklq0AiHCnSw3Zf+Des
         W3WJpDjAuHWQIHDS5NsaS1unHFTIk4DKTrZGIIKBFMmORMjV4NWIJ0oDid1Saey3CymN
         fabA==
X-Forwarded-Encrypted: i=1; AKwUvBzIu5Z25s++36crJiTSXZv3TrGJFR7JhEfDAmC40dEyr3FCvuE08F8D/ck8Tc+TaWjb/5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVAZB8KvhKV9UQxz9grvDvU31lt0RxWjKjUMzaT6rSTBYWGU+O
	qR56y5+vcG1TQDq/og98aDv6SgAVW99zXmklUSN2cxbZ9A606um1FT5ybC2j5GL6mRqT5nDDl5m
	VTi87wB5m7ZoVfEme6dWU9fKQVXGF/goWPFNQp6TV
X-Gm-Gg: AYBFou1rNTgo1niOHg9QwrdFRK8k/wehnp20iC3YKigRxSKTsADjHbVh1dopJZ532Jv
	oXmrDNCvdFwWtuvaWkYqsPvWKPV3n6r/dl/ElbdQ31MYacEmJL5SgwGE+QfKjNpSJzVW7uK68Yx
	NcM28A77UFC5aDJQLxLbGPbdEMXDZR1TANY0y2I8VKZ7lebFLIq/uBnem+M9P4WfnWGTLb2Fnys
	dqWsydPXKtcrgm9Brcwov9VRvLJRXw14I/UgvFTiwozOp7nkqlcEp/kz9VmUYMMAaWxQ78KSoFl
	ZtqfV7+FwYmXPl4YrntP4A9sf0nDSle6veUXR3B23/eFct7cikeqXFfzgPlel390kY4=
X-Received: by 2002:a05:6402:c4d2:10b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b199a6f8c9mr124512a12.10.1791918009269; Tue, 13 Oct 2026
 12:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
 <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
 <CALMp9eRRb_8vbm3YM9dw7XbDsnjQ1wRYK10oNq4JAgkUZdpFLg@mail.gmail.com> <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
In-Reply-To: <CAO9r8zMBxWT=A7+tFUTtDiTu0GNodQEiGw+EKRLesQghk9aBSg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 11:59:56 -0700
X-Gm-Features: AclHuK_85A6WrUV9oaB4jqIb4cM1YcK9_2Ebbr94ohiYvgrV5gIw2KetiZ5wyYM
Message-ID: <CALMp9eTqEWczivrxr06hhGg=519-POMRiSTg5WzRieuXZzTK6Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 11:11=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Tue, Oct 13, 2026 at 10:55=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.=
com> wrote:
> > > >
> > > > On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.o=
rg> wrote:
> > [ ... ]
> > > > > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *v=
cpu)
> > > > >          * - The new VMCB does not detect a pCPU change and runs =
on pCPU A with
> > > > >          *   the new ASID allocated on pCPU B, which is potential=
ly used by
> > > > >          *   another vCPU/VM.
> > > > > +        *
> > > > > +        * Note that dirtying both VMCBs is not strictly needed, =
but the per-CPU
> > > > > +        * tracking is shared for both ASID and clean bits, and t=
hat CPU must
> > > > > +        * match where the ASID was allocated.
> > > >
> > > > Is dirtying both VMCBs not strictly needed?
> > > >
> > > > Per APM vol. 2 (rev. 3.45), section 15.15.2:
> > > >
> > > > > The hypervisor must clear the entire VMCB [Clean] field to 0 for =
a guest, under the following circumstances:
> > > > > ...
> > > > >  - The hypervisor executes the guest on a different CPU core than=
 one used the last time that guest was executed.
> > > > > ...
> > > > > Failure to clear the VMCB Clean bits to zero in these cases may r=
esult in undefined behavior.
> > > >
> > > > Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, an=
d
> > > > then migrates back to pCPU A with some clean bits set. At the next
> > > > VMRUN, pCPU A will happily load stale state for anything marked cle=
an.
> > > >
> > > > At some point before that VMRUN, something has to clear the clean b=
its!
> > >
> > > Dirtying both VMCBs is not needed in all cases covered with the new
> > > code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
> > > which is shared.
> > >
> > > Because ASID is shared, we have to reset the ASID generation for both
> > > VMCBs when a new ASID is allocated through either, and update the cpu
> > > variable tracking which pCPU allocated that ASID. Since that cpu
> > > variable is also shared for tracking which pCPU ran the VMCB last, we
> > > also need to clear the clean bits every time we updated. IOW, if we
> > > had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
> > > update asid_cpu on pCPU migration for both VMCBs, but only update
> > > vmcb_run_cpu for the current VMCB.
> > >
> > > This is all annoying and confusing, but that should go away in the
> > > static ASIDs series, and we should go back to only updating pCPU
> > > tracking, flushing the ASID, and clearing the clean bits only for the
> > > current VMCB.
> >
> > I haven't read the static ASIDs series, but in any case, this patch
> > should stand on its own, in case that series never gets committed or
> > gets committed much later.
>
> It does. I just didn't spend time trying to improve things beyond the fix=
.
>
> >
> > My complaint is with the claim, "dirtying both VMCBs is not strictly
> > needed," which seems to imply that dirtying the inactive VMCB here is
> > optional. In fact, once you update vmcb02.cpu/vmcb01.cpu for both
> > VMCBs, dirtying both *is* strictly needed so the inactive VMCB doesn't
> > later miss a pCPU switch.
>
> Yeah I guess it can be verbed more accurately, something like this:

I don't understand your prevarication. The comment, as written, isn't
"inaccurately verbed." It's wrong. With the current implementation,
dirtying both VMCBs *is* strictly needed.

> Dirtying both VMCBs is generally not required if only one VMCB
> switches pCPUs, but since the pCPU tracking is shared between ASID and
> VMCB clean bits, it must be done once pCPU tracking is updated.

Clear as mud. :)
