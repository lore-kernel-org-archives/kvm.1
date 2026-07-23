Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688D38E5DF
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825671; cv=pass; b=f14X4i9+anK+0FdG8JGAgi57Lc4YbVGtiXqg5pifc893axCd735LbO9O1Rp/GsEFSA2n2c45U2UXNt3qU/7jghDKy7ES0Tdt0ghHxcoWtAJiP3blNdm56F14Ua2FBpuAsSf2cxQSYfBmbi0NwMC+VVVkjDoshurvqCd5mn3Smrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825671; c=relaxed/simple;
	bh=Ae14EyieU6YPBM8MQSMTo3jnKaBHhCFkLSpI+pKApJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYrrJnN+Qdc08AD/xXhfxWMrTA71rchGX4fhXjA40IM70PCJorGRx+jLWHV2fDwLWltwFAlgs5tDCFXTHII6NjStF/BniIdute0OBc3eg9WhiLBPqdLvbhN9zvXQE/SJ633a0tgtaZqT+O0PSvT2JFi95yWD00S4v2k/rOSjE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecFgxcCq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecFgxcCq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so12196a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784825668; cv=none;
        d=google.com; s=arc-20260327;
        b=Hguab6SP+cCm7tdIufyKZ7ZysqQ5P4xHV6FTZE4XPIqxsmhjzf3z3hznJ78p0e8aXY
         kZiVo7j5Hg6tifXz4c7wUJOHiXeoMiggVtdDeqtqx5cBerTKdxKxx0XfulaE0Pxijekx
         t0bEjlNmYpKcYyMIZgiCJVcOzfUPEsDvjNtQg9jegHZ/a3LWhH+kin9KvPfPey8JsEQL
         gJLSAmw6mUF/27NWsvhEaAjXjcFehgx+Bw9DtfILkyKEPC0cwl6Aah/YyW8izovtw7xk
         5lBBVmQ4+Y16qCsv4ARMrT8N2+/BPZwNsWo9yG4tOT9eNlFyTfsKv+7szUkaLNdCWE3i
         pCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3RtGMIqgRo3wC47sn5LGumhgXfQ9z9yNzbqLulmGFA=;
        fh=A56nexgvnzrPPP1s5iAUyBmBUSfLqBjCzIvTiLoNavg=;
        b=qBsaFppa2Lgp6cSJSeg7o/1D/jM/dwajH1SdSKW0d4tn6eKZzeSmOP+107LcBc9MRt
         xPUmV+6sf0fmDV41+QRRYdcVVZ76jTeN6QeQUVuuZGZdzqjKfIdjpmQibb65LIbmmmqv
         mWzV+SbMczOKPnV7+R85sQ4pumd13ELkzrC9JGtdo6a7M/xg3Hcpep1YK2u5c7SWqQ7U
         B3FTzUfY7LKANGrXRrR5a6R+Sts6+M+XfoBvKpXnu86j2tIdseZXyLDQUmZWtxoXuvwj
         9cFi6MXSPtUBbsrrvOka/N7606devMO2AhAQBz4+xTcXWZOGd+HCUyS1lAOUUTM4smn+
         Retg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784825668; x=1785430468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3RtGMIqgRo3wC47sn5LGumhgXfQ9z9yNzbqLulmGFA=;
        b=ecFgxcCqRn7Qo2t3q0+V6OJtawgeWhHciKn1otbCU4SzYd9lt3//3smuWCWRvbMDBX
         SkFijd8qOBbB+M5OVqd6YUq/2YzInO/HTKgPy+WIZ29cwHFDWsEHFc+w9gFueSuaVfyq
         EQ8CDqPjaBw0vLq1mKxZKSQGMWRPTI+7PjxX3AiglcD/jrLuQYSkKzEXLEiRC2qrxkAD
         k6ASg1KSm+vbKWy5sDGy3BqtJ3RjBwAjRGZpewFeSX35yXqJNZvSRxuseIzoFbqYh5ax
         YOE4BxJvLfHAyPCK/c49UqCBYEiNO41oOljdG7spE825KV5R/iXVlqRawY9FId0/SJh3
         Qd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784825668; x=1785430468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3RtGMIqgRo3wC47sn5LGumhgXfQ9z9yNzbqLulmGFA=;
        b=KvbKKetKEfA+NHd6gAI0+N6IRmlUWepxm7Vxi/3K2U+i9AVtrg/q2NLro9jI8+n3xJ
         CQ8iv46z5CsGgYORE2A0N+ROH0zZx2QGjKktDUT2kewsutqB/KgVkd3xRwGJIoxB9drW
         RCDEYnmaNy4CzTqjfXhVHzxX730ZITTiGCKYuUlf0tx+D626Slm0y1C8xuOAI5HOm0p2
         MOCbPgG2+CsAqID8pQkkokx0ROHme2se164kpKGJWEtnIf52qKa1rqF3yw8SiciqKNxX
         IbE/I0Dj3LvXBfPyvDdDn7w1wEULs7Jvefo06ZKrZZQvP6cvEB4iaqWhdPth/04j4X/C
         eK4A==
X-Forwarded-Encrypted: i=1; AHgh+RoeiPpjCZkc6anUatt+3OXsEBP2Fzuhhr/TA/go3rKr1AamHbLyM/9ODrjvngCDUyvqcxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDp/a5I2gwnAv4pazJKy0Qxx/DS5iZycC4sLD05NB/qOzsr3Ra
	+WrPwLsZH/Xd3AgLdNijaxMXKd0XlAyHimeoNHhIgvPco9UMwKXztvhogYgJ/zBI++cOecG5yGh
	JjZczhABhWULgNv3ubrhUpYGpQVBQ31ZfnmrVBi13
X-Gm-Gg: AR+sD11uctovDouwU/PXttmnX7RUOz3o53Q7oDY8uxBLAynYUmqAi2I+j4/2kvhNp6G
	D1sOY3WZWxnTiZ1j5LOAu9/osccY/qwP+Zj8PzyXXj4wh0BVGAWBMSMW5Qh7JIhjVtcaag9Wfy0
	kRDd9XqzvqgWMbJ/DvO5tVRupP677FAyCvkpF403YHjRF99tjMGDHCVQ1yKf1QdDcCYilmFiScz
	IUDPG93n2jd4uoJfAu4ryh7IqXX7+yNmIIZ3ak7EBnwcdnSRLNkhBs26ZXh1Q==
X-Received: by 2002:a05:6402:22f4:b0:697:df76:63f8 with SMTP id
 4fb4d7f45d1cf-69f6c60e86amr54353a12.3.1784825667344; Thu, 23 Jul 2026
 09:54:27 -0700 (PDT)
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
In-Reply-To: <CAO9r8zMukfW2b5tjYarpkpPH0osA_+QEEMRq8k5R8B_WFG_yYQ@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 09:54:15 -0700
X-Gm-Features: AUfX_mwz8MES2iMH4IA0Cv_UKU7jpPDKEjD7yzysWyR2-PSV3zr8KSP-ASnTCrg
Message-ID: <CALMp9eRsJeByu4U8NZQhnKM7BaKziyLUix6J3XGCEMZyiar=vA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:32=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Jul 23, 2026 at 8:57=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, Jul 23, 2026, Jim Mattson wrote:
> > > > However, since KVM completely ignores NASID, it would be sad if
> > > > migration were blocked because the target has a lower NASID value t=
han
> > > > the source.
> > > >
> > > > That's an argument against changing it without some kind of userspa=
ce
> > > > opt-in. Increasing it seems safe, but if userspace just reflects th=
e
> > > > value into KVM_SET_CPUID2, then an increase would block kernel
> > > > rollback.
> > > >
> > > > In any case, I think the new value should be a constant so it doesn=
't
> > > > imply a migration constraint. Perhaps we should adopt the highest
> > > > value reported on a physical CPU to date? I think that would be
> > > > Bulldozer's 0x10000.
> > >
> > > Or keep KVM's enumeration at 8, then find somewhere in KVM's document=
ation to
> > > describe KVM's behavior and provide guidance for userspace, but other=
wise make
> > > it userspace's problem to solve?  I'd be a-ok with that.
> >
> > That sounds best to me. Document that KVM ignores the guest NASID and
> > commits to always supporting 2^32 ASIDs. Advise userspace to populate
> > NASID with a power of 2, and perhaps mention that hardware has only
> > reported three different values over the last 20 years: 0x40, 0x10000,
> > and 0x8000.
>
> I agree that documenting that KVM supports any NASID value from
> userspace is needed here, so that VMMs can set reasonable values and
> migration pools are sane.
>
> That being said, I still think KVM's enumeration should be increased
> from 8. If KVM's enumeration is just a hint, then it should be a good
> one imo. Current L1 KVM will flush everything (L1 + L2) every time it
> runs out of ASIDs and pumps the generation, so advertising a small
> number of ASIDs leads to L1 unnecessarily hurting its performance.
> Newer KVM (with this series) won't suffer as much.
>
> I think we probably want to pump KVM enumeration (e.g. to 0x8000 or
> even 0x40) *and* document that it's just a hint and KVM effectively
> allows any value.

How do you do that without breaking rollback?
