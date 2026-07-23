Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81384734C5
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826484; cv=pass; b=UVd48ICy9iU7hPA6SHpGEqfcU2PMxD/0lGb2QWVrMQF5v3pUBsGcqxRXZshFCnH4gt7DRoA1tE5ImKVZ0c8WSYt9/vLobP8PFkd4Gzxqortj8jbClYMZipEV8oo8bkR/pE3L4B15f0oass6gz67ScgTwwZZttzMuoJW+0WBhlbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826484; c=relaxed/simple;
	bh=EE3EaiwrmI51Lgbrcpazt9QraHinVDFsRM3RHTUOla4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+iudk12+rGVW9RgUs+1A7vNPkZlyYQ/ffyIpYoPXXHpfx45ue0yWLy5qWZDRdeCg81ylbF00DxpDO+96HDxJadeEOTXqs76LdNa/18mMhspZxsqEqR1P8NZL8VN7QjKQ1JHv5AQcsY+m++ScphSXV6UlBVfRztQSUewepoOgyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hycyCmaa; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hycyCmaa"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso271a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784826477; cv=none;
        d=google.com; s=arc-20260327;
        b=qKd1hSGhKEH9+9lOTyzAY936e2kZsv72OZN4uRYpqKvJKKj+Tbn9C96Yjsc9lQsRUR
         c/Z0yJjrZZGl7OXwfy7rDW9mhRY86H8JkRrcDHSBPaCo5BTepaBNWCR3qr3DCWawuO0B
         lcxeSwnX2GtsWoeMAMFUc00Wzz7Mrn42Zw3xIG2O6NvbX/2Cp7fHb+HdNp860XMSHUg+
         i4IYaHcEHLZzfhBBGue2vdLZ1ylsngmiE3qPM75bocyknqjb82gIfHzg6W2Lh8mOshF2
         Y4NmAKT3DFPQAhINqagEjGOHJTr2qB5VOtoqPqHV31EP8tsfj78Z7nvE/o1S+CnOt19q
         IV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h7HcIvVxXuyHdKd5y8FV8u9F1vFmQ9UmRDFA/SFyfQ8=;
        fh=rQPSiWWhUVfbt4iy4A9xWav7+yCpcrMosw4asug5u80=;
        b=qpdtL9VG8JReN5NCjhcZM9zwxQumkEe4VhqzGPP9Ykx/DwvqFGE5351NhZk4QvDwy/
         +PCabBRA81qQN8s3ps1Mkz2cSCZfrdHwDo2EtOllK8dI5op64pnBP7ZOmVUWHlko1K3H
         hYv/U1J25Yj8iKOf0HQ8AaSwT2tx+K/HkkdRwHXsol1ul1xq6GM3ukMoT8A2kAfcNiq4
         XKqxtNdfzLVLZWRBVVBFxlpl5TzdITXsr2vJnV2NnS4vUUKjgHbxTFO9MeMCizwABb0X
         7tZS5bls50zp/ROOvGcIRqTH6DSrAxUFzX4+MVn64jn4NGqEVhwIP7M49o3YtSXP57gO
         G3Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784826477; x=1785431277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h7HcIvVxXuyHdKd5y8FV8u9F1vFmQ9UmRDFA/SFyfQ8=;
        b=hycyCmaaKmqrm8pUAH/LMdH2gSzwtf4zGcI9q9MLxNKGck/Yab0dI8cLlMp0MCUwnX
         XoKx0XkLh0I/7SaNQcULGc2xYFM0WMLVb1vGD9pQWB9sXVBP48styz5NtRnIaZtEYXZb
         zvN240pfKe3jCef75AbChPKC2AyBHd/E8uSo3PEkJgJFfwY9k6dCopW/6KFf+JbheMmM
         jKqEtMzQ7aLYb6Ffkeyzrlp2eSrowNoMEFetDCU+OVJjr1XcuX3phzx2h17Hv4WZJW/t
         LKJgZXU2C+XZzN8NaUUgoo/rTc3YvCThcx/h+9FvA1EJtIu3GdHC3dWguOP0uRaJGbB5
         TdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826477; x=1785431277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7HcIvVxXuyHdKd5y8FV8u9F1vFmQ9UmRDFA/SFyfQ8=;
        b=MhabX+CwHFkLmub1if35NyE6x26axOGei8N3JCK2oJH589zINZt40OGUbtRX7o14vR
         mgXa19rgpbWrHMWbCbiFLMR/mtIFhV4+NK7QvGA/5cfk26ICawO3NV8zX1UIs5QnpMFC
         r3cFPTHTSNZHLgoYdKFiAjsViCIaQl936Xq+ajBslF4tMzjbBvF0P5iDGcvWBorigtHY
         qYJBHCYlX6X1n2wpQKXbm61Vil7Byxbnk/KKru7BMMyKhG+i2A9GWMjHy3KYyIRN6JyV
         v1Ss+6hBK8P9vVikQuPmBH3DtbddO/Mb3dLnLLbLdqS0gmy0bcxK17NhteFimJJIGFCn
         Lyog==
X-Forwarded-Encrypted: i=1; AHgh+Rq8Z3MbYHjeWEmechhGkcLg1poxljmJEFZ3/2RznUnqZpBIRZyba8LrGkUHxq7V12XaDto=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2Qpv7fSPumEPjdcLhViCwSIfLzMgzmnUzl9JP4vM3OSJyooJ
	JtmSKCoewrup/RUMbK35QJiLkEq4DLptlZ78lerg5ST+TbAFnRDFARvKVE4MwkM7Wip1Ftrp2C4
	bq7uNbwhSfWRCqtRDlPEH/dnhzLIiCO4AtfA8Ktai
X-Gm-Gg: AR+sD11IirC5nkYp6yE1/+wpIDBdCI1BdBSb+BZqhPfjKeRWXlemaOTszQC5KMcvysF
	wfc+6jYcbO8CGdArDIImOoKgv+K+7x7YY6VbPkyhyvdXp8nh/1txGvpQhOSUriS8bewsBRINFg6
	TR0/IqLWXiUwyFgwSSLwJqsc+/pe9vqrjo4p1sqf2tazCFLdeJQAC74YKOtHi3AwDQ1I1VfoXaq
	Nq6wQMOZ9F/JZTdNoXDKcCFb7uYEJLrasTv7R5eE3DuXE9OGEbVWPMjmoGmTQ==
X-Received: by 2002:aa7:c795:0:b0:69c:39f5:7e36 with SMTP id
 4fb4d7f45d1cf-69f8ec1a904mr2915a12.0.1784826476144; Thu, 23 Jul 2026 10:07:56
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com>
 <amIgLeMCAH2vB4ot@google.com> <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
 <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
 <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com> <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com>
In-Reply-To: <CAO9r8zOtzSscMx_PFuABkXzZ=xgGOcioegKzgYscXa9WiobySg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 10:07:43 -0700
X-Gm-Features: AUfX_mz5yGWzO0PPFIkPfr5J3GTVbVTyfxQBFqnr-SvmEY14sV_q5eQRndDbSCI
Message-ID: <CALMp9eR2XffG3pQL_pjGphSqMGfpJ9vRJi45Hd9RuCSd5EwU6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:57=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Jul 23, 2026 at 9:54=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Thu, Jul 23, 2026 at 9:32=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@google.=
com> wrote:
> > > >
> > > > On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > > > > However, since KVM completely ignores NASID, it would be sad if
> > > > > > migration were blocked because the target has a lower NASID val=
ue than
> > > > > > the source.
> > > > > >
> > > > > > That's an argument against changing it without some kind of use=
rspace
> > > > > > opt-in. Increasing it seems safe, but if userspace just reflect=
s the
> > > > > > value into KVM_SET_CPUID2, then an increase would block kernel
> > > > > > rollback.
> > > > > >
> > > > > > In any case, I think the new value should be a constant so it d=
oesn't
> > > > > > imply a migration constraint. Perhaps we should adopt the highe=
st
> > > > > > value reported on a physical CPU to date? I think that would be
> > > > > > Bulldozer's 0x10000.
> > > > >
> > > > > Or keep KVM's enumeration at 8, then find somewhere in KVM's docu=
mentation to
> > > > > describe KVM's behavior and provide guidance for userspace, but o=
therwise make
> > > > > it userspace's problem to solve?  I'd be a-ok with that.
> > > >
> > > > That sounds best to me. Document that KVM ignores the guest NASID a=
nd
> > > > commits to always supporting 2^32 ASIDs. Advise userspace to popula=
te
> > > > NASID with a power of 2, and perhaps mention that hardware has only
> > > > reported three different values over the last 20 years: 0x40, 0x100=
00,
> > > > and 0x8000.
> > >
> > > I agree that documenting that KVM supports any NASID value from
> > > userspace is needed here, so that VMMs can set reasonable values and
> > > migration pools are sane.
> > >
> > > That being said, I still think KVM's enumeration should be increased
> > > from 8. If KVM's enumeration is just a hint, then it should be a good
> > > one imo. Current L1 KVM will flush everything (L1 + L2) every time it
> > > runs out of ASIDs and pumps the generation, so advertising a small
> > > number of ASIDs leads to L1 unnecessarily hurting its performance.
> > > Newer KVM (with this series) won't suffer as much.
> > >
> > > I think we probably want to pump KVM enumeration (e.g. to 0x8000 or
> > > even 0x40) *and* document that it's just a hint and KVM effectively
> > > allows any value.
> >
> > How do you do that without breaking rollback?
>
> KVM's enumeration is just a hint :)

Yes, but existing userspace VMMs do not know that.

> Also, in practice, even if you rollback the CPUID presented to an
> existing VM by userspace should never change, right?

Today's KVM claims support for only 8 ASIDs. If tomorrow's KVM
supports 0x8000 ASIDS, and we start a VM on tomorrow's KVM with a
userspace that copies NASID from KVM_GET_SUPPORTED_CPUID, that VM will
look like it can't be supported on the old KVM if we have to roll
back.

Hence, until you get an ACK from *all* userspace VMMs that they
understand that KVM's reported NASID is just a hint, you can't change
the reported ASID=E2=80=94unless, of course, you make that change an opt-in=
.
But any VMM that opts in already knows that the value is just a hint,
that it can set any NASID value it wants in the guest CPUID, and that
all values are actually supported by all versions of KVM that report
any non-zero value. So, then, what's the point of the opt-in? What's
the point of changing the hint at all? Documentation solves the
problem completely.
