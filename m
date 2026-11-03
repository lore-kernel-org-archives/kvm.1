Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793746379;
	b=VHgICBS/oQ1zzbU2MCPyWpFK8hKtkc+ESHJhyTDzQN/AGbn/F5WpBYEmI8iobPjKE8es
	 Nz455WenYNO0SYQ2CjM37e7ObJ1S4uuJB4nlNOJ4dXvabm0/63VMqPmzbLFxKOXlRVAaO
	 1Or4MxlHiOF0vVZrK7uCU4Plc2BLL+kW41d79xnMKIN4U8WkvfZ7Y+OJf+kdnQShj3UT9
	 JMcLFC84f/Axi5Fc6WCI6icT2cOspCacIfAOg0k8xWd7kNxsGxtk26UGuDUXELPy2J8HD
	 7r+HLhdLury+pLi968yz55d5jzYaWskSQuG6E6cO/UFcpG8Jac0YxQn7CHiKfFMK65w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
	b=M+HbRdvn0ef3nsbTUWgYk6b1zuqnkyf98rRhSD2GgPJzK1fUpmQLMGWWfZURCwvxgqQ7
	 s3jPLht+Yhe2bfmloelj9v1N5D+Xr5ujHiiG6fZ31Nt2NC+/XPUmBwD3xRIfC7h8hUNAf
	 9CBgG58iqXMok9m/dVauYCvshtN8ZmKJtCX5KvVshRmxDMtJVuGqhWMuHmdtcZ9/F4GeY
	 8H4zWJ1U7pv6ctCozf9LsqcOi4mNGmm0OwMXa64HH9zHk/HVjbRqPNtn1TDUoi6tg+99o
	 OmGPyb9W6VCWnpNz1ObC7uVEQD9GtTSNGFPYqdXQ/bNWgQYK88gOi2xiNorTu1Hkz7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eNGImLt6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69F606A336
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 22:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D69F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eNGImLt6
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso1720a12.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 14:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793746378; cv=none;
        d=google.com; s=arc-20260327;
        b=LTA3oLD1Q5dkbM/3Q3EloE8qvE/1CM1o9noqK6tLyNqwOGiaFSrmAy3Alw6apiYIRj
         SHQyhNQMQmsMVQBrE9Fpj3RDwvmccNFjfhdwoAWOq21k96kCvxtt2fTDREtR4BBARzGN
         2AOqbKdgu9XXlLmXuEzhSTzSJa6IjiDxADZEtizUYfORJryPj5cu953xNsJf+S3pZbUX
         +kSS/yP/8oJfoB40MAqbbmUjUgSMTkKIr+mQawXkdJF2GfGVPyz2hga2JBBGPJ1b3cFu
         eyh9ctelbZiMi0i0N6G57uU9iyYi2u4h7cxwZbaAZxD8GkxbgTHB35fFowfwhSn0//2F
         R0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        fh=2NRBKq7Y9nWKI4itTHoiKNYWuST5hwEkqHnb0H68c3I=;
        b=dTvTgRxhdnMpq5ps9siHOskTYxTbt9k/k17X4Z8jYOd1T0Qw9KEN1J1/jtrn2a0twk
         1kW8pCol0m68XIRrh5tR+LXqw7/GM/pYwC+x4UmtV6Ef6EYnIuBv4ii2X/kvvGsWYnl/
         tBZeP7xATvFQOgqvRNs+PEHJbCzqC1MdIaUjsR5jE1KJUCypsV2mxq0t263idD44Poy+
         E7IaD7A9quvAlGrB1HQopSfYIOFZQzxLL+kpOKuqXC8l8bsNYaVibBXeEeQ//+XBTG1G
         kh30ulq+6aabYawVc2atdGOk7dwHiHu7Nv/96+J/IG2vyw3GbhKcJdOSUZq+Nxsdz/Nc
         wCAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793746378; x=1794351178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        b=eNGImLt609/blukDHj+qIScHQh00PJevkjX3mOAgLa5iI/zNT/9ZVwf7BvzZ3MWt9E
         UGNWsaFthxVOeBQOZmvYjIqQtaWMKVFtVBHnJJHEfOhPJ4TQIOh4hwZCCNkEgzGFQNny
         iAyfqYKaBvouXJOxXlq/xRAzQBYVxsVVa1NvpILAnHkCORsuj13nMGb4GsOhCnRKx0Li
         UPqngc+U18phoHm9bPxQDopmqX/WqOMgvZCW0bb5kxfLQ4xupEeOZT4Q6q4BsQxuBX0V
         TsA9YPykslpZNErJZCYVnQNxm4L8C4nF2XEkCvdMQ6bgUFSXsu1kfQ5r8YBQAiWKQz36
         YvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746378; x=1794351178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wU8VIKFjJ28dxbK4Nnp3pL9e9+Uyw+0nyAWTkSUuFuQ=;
        b=GIvR2ls93Dv8ywoQv18cRyHfpZ2NiAMpEGZsTOoMYEOkNR8D8xVTvtdQnfSM7AXorS
         RXdKoQmk3Xe69KG9dX9ubDLDZe4ouXQ3BQIh/Ve0GOdt7rVft7DyBi3TG8C56GAd5/ma
         7N6rKkU19CSu03vb+ELF5Bw/j+uKqNZX/dn5P4uT5FuP7Ke6deM9gNvVeCvn2Qfo/c4z
         PcaoiSfCS1ylwNQ5+91rjDsl+uygwL8K9ZHGlCETT/D11R4up4wc9aD3FUIJ3irzS7oH
         6RjRVQ1GhqeKvWNR37CtNdApr8mPOyVSna/atK6BuSgf7e9hgRI/DbNvBjpM9rNKeWfS
         KmGw==
X-Forwarded-Encrypted: i=1; AKwUvByNVMelP1OOjVayrQMqJSmiTqgAgciDEJOqB392UVgjBjGdCNaWiQr/xEs4Zia0w1GFpmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Su0pmLL62/GOOrerW2m+cEq9HXivywHx7lzPrSNvpN1aI02au
	zToTx5o8cJlke2A0LWCRzIDLZQqNf1PIXQLC31X58iJ+p/JxxLbyMxKBkm0DcyOVjzLkDWoeDlN
	XRbhga6QA7OKUr+jf7ftjVjIgn5i2T/M8A38qz9DmfdDvS1aSeYg5t2iYXuc=
X-Gm-Gg: AYBFou3dxh3FQaIL3UIO6z+cfKGfvNzvz/9qTSd4XvZDuVKcEwszXT+KEbiw733CAvx
	OV3yN8FMS7XFfpRpfYTdTR8gMPgI3EqA/CzjF+k1FylAOtZW7CrrsU6gmIjvp9JPTiW4WfO3HZY
	ghNfT59kC+VjzRvQtm7Mk/slpFfMliT6BcyTPuxCb1o36GPjzFAa7Lrfu+Dgc7xBom2d6MhvTYE
	R4UBVG19epgPNvlWKZTewEBIEYGHoMCDfwUN+7tQ/k+ar2bgXQway0lAfbmRR0+f5PRKpYBzgZZ
	JgKbu9n4d8RuNba2+qCzILHcApgaJH/bcFuzsqihJEsKfztNXkOsRREc5w/jrdM5sa04uBB/L0T
	MwfpgQzdz/hilNvamzgmvUE7VTo57wQsdxbnU
X-Received: by 2002:a05:6402:c103:b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b55ab86764mr7858a12.9.1793746377460; Tue, 03 Nov 2026 14:52:57
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
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
 <aukmeb9mV8b504T6@google.com> <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
 <aupLRleTJSIDTE9M@google.com>
In-Reply-To: <aupLRleTJSIDTE9M@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 3 Nov 2026 14:52:45 -0800
X-Gm-Features: AclHuK-Z7OQBlFOF2zRwnhwZ_UDz9nzcNqJTQa47B2hjAbqqScBEB0lSSXwokYA
Message-ID: <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Nov 03, 2026, Jim Mattson wrote:
> > On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Mon, Nov 02, 2026, Jim Mattson wrote:
> > > > KVM needs to do better.
> > >
> > > Meh, KVM is doing pretty darn good, all things considered.  Yeah, thi=
s code sucks.
> > > But I'm not convinced the alternatives suck less.  We've gotten the s=
et of missed
> > > consistency checks down to effectively zero, module the TPR mess that=
 I do test
> > > by running warn_on_missed_cc=3Dtrue.
> >
> > I don't understand the TPR mess. The SDM says, "With the exception of
> > fields corresponding to virtualized APIC registers (defined in Section
> > 32.1.1), software may modify the virtual-APIC page referenced by the
> > current VMCS of a logical processor in VMX non-root operation. (This
> > is an exception to the general requirement given in Section 27.11.4.)"
>
> Oh, I wasn't aware of that.  I agree, that gives us an "out" for vTPR, mo=
stly.
>
> > I would argue that this prohibits changes to VTPR between KVM's
> > software VM-entry checks and hardware VM-entry to VMCS02. If the
> > hardware VM-entry fails because VTPR has changed, section 27.11.4
> > gives KVM the freedom to implement whatever "unpredictable behavior"
> > we like. Yes, that probably does include loading MSR values from the
> > VM-exit MSR-load list, but why complicate things?
> >
> > Something like returning to userspace with
> > KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
> > VTPR seems far easier--and cleaner. What am I missing?
>
> My biggest concern is that KVM could kill L1 if an L2 coerces L1 into try=
ing
> VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an un=
expected
> VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it's =
possible
> for the vTPR to be "restored" to a good value.

The only way that I can see for L2 to coerce L1 into trying VM-entry
with invalid control fields or invalid host-state fields is by
exploiting an L1 nested virtualization bug (i.e. L2 is running an L3).
In any case, if L0 has already performed the checks in software, then
failure of the checks in hardware implies either (a) misbehavior on
the part of L1 or (b) an emulation error in L0.

> I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then th=
ere's a
> non-zero chance of a false positive.  KVM could exit to userspace if and =
only if
> it caught the guest red-handed, but then we'd still need this horrific co=
de for
> the other cases, so that seems rather pointless.

Let's go back to the Xen example, since by your argument any L1 can be
victimized. If an L2 VM somehow coerced L1 Xen into trying VM-entry
with invalid control fields or invalid host-state fields, and somehow
L0's software checks passed, but the hardware checks on VMCS02 failed,
you would continue to run the L1 VCPU with L2's SPEC_CTRL MSR. Surely,
the possibility of a malicious L2 exfiltrating data from L1 with the
assistance of L0 has to be worse than the abnormal termination of L1?

(Note that I'm just playing devil's advocate here. I don't actually
buy your argument.)

> warn_on_missed_cc helps, but in practice it can't detect cases for which =
we don't
> have test coverage.  So *if* there was a bug that could be exploited by L=
2 to DoS
> L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug ei=
ther.
>
> Maybe with AI we can be 100% confident that KVM performs all of the VM-Fa=
il
> consistency checks?  Again, I'm not opposed to alternative approaches, bu=
t at the
> same time I don't feel a sense of urgency.

KVM *must* perform all of the control field and host-state field
consistency checks. Otherwise, we risk priority inversion with
"illegal guest state." If KVM is missing any of these checks, then it
has an "internal error."
