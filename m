Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653B3939B9
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450606; cv=pass; b=DZoyixSA/nc25fRVxBsewguiSgRlBG4VVv4SZHBKu3+GIOD+PVkMr5X8MWklnPa8JmBLN+ea7V0sTU9nSEbIgdPUkcmrlg4dakbFcriiIN5k7rCd7hjPOLUACRA0x9NyCSUPwcjWERf5OQREfNF0EKBpF8kUNiG2BPMpwk008GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450606; c=relaxed/simple;
	bh=Igs+/mf1Qm/Jdq/UV2XGaSEccSOZ0Mcwbq3G8sJTIaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHCFMIzZI0obX5e/jGwA1b9dIEcHji3McCfOzGxeu+tgspcRUTZU/y3CEthZecvljCnej5CTTKwiPkLj33dJhSABqUeM5sUorGXJ34w/ZyV0ZYGP2rlMNaTlLWJR+GxIyLTJrqNbWzxhf8fh6wmkd89wVTWOMWzPx5cAlKWY9bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVjgczHY; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVjgczHY"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1596a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 11:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450603; cv=none;
        d=google.com; s=arc-20260327;
        b=SQ5lUxQw6PrqJMk+5CVzhYRmdDbZuG4ZJoUxBwE19Ob5IklG2DIQq3uphcg5HGtNzk
         vyXnvTwNFh9l7fGayQhSRtS781BNy9Hr3JwnTkCNbq47kZVullVYzeDewi9Lzifxtmkx
         vNR0usqF70O4AtU5n9Fyly1LU/grKB/n9XXTbYEhvptf4DrgONk/uj2qYdBIeV0ipxqD
         QxQn6Z2quh1B9Qp9lxA+n5VYPtO6aiiYa6rkQoanUeCId0R1iTdub2NMCCIap2ocPqzB
         VBEGugF1n6FyCL4+pTv3A48fKeCgoWeTGv1IAwCpaoX2DE0mDmHRFZ6IdEfCUvlvtSMC
         3ZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHEkf5rCiewzBADWuxq4aeYbW814Bkh0YqaKOSrf95g=;
        fh=Q/iwwC/rqm3/CfYe2H4PKYj1sTkyRYYHitolDBeocrY=;
        b=D2YpGUQ97wUWTYexC3QRQZM7X0cWOaOtZuKhmLH9VHHDB2TmEFo5TV/3dunH8hoNCD
         YLk6Z/lFc2cq4djNK1Nu+/4HcSUW4q9OOcAE+DY6p2QlhNHXQ3incmT43xLBo+4VFF9A
         zjcpadkhTjtACwlP0ae6dbLiL6ltJoo9SRKYgjfzHN3aUMFlMX1KOZBmwxoRD2WFTvb3
         4OTrN+nSCh7trwxUPHs3p6M4fPxZeiOVa9urMv5RHddM68+ADv8YH1gc9/tgb35ZrTV4
         jPWbICCmilVPifZYchZdrPvYCMULTpQTqgx9dR4BRDozhUL3IwjaSzQOhiD+RIUkUMK7
         Txeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783450603; x=1784055403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHEkf5rCiewzBADWuxq4aeYbW814Bkh0YqaKOSrf95g=;
        b=wVjgczHYXOMviVYUeoFpLymNSS/21Ahe0KEAiOl7Kh/aFoyqoaLuaDSkIIJNGezGq3
         /2XPq4uoAuExWuUUdFRTVrfRiXQl/SLiNgryYdrg1d3CFzgQLTPdwURC/KYvqRdxTfts
         b6c/q8bxdVq7dkm/8qw04c0r7HAYkyZmS/s5ttKCWGECzXDCyg+H0/IIXAEop0z+JYfr
         SroVsgZbFLI66Np0fnYCCiO85COMhNsGX1FTACkKuSmxYIE3HhO7bm5TLsuHRxOzu9Hl
         HhIOyeLptgFlUDJI7yyb8uI5NRSuOruE0PBSVbvJgpBOCD1zLQcIKEvMwlOQdKrNlP6z
         uplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450603; x=1784055403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHEkf5rCiewzBADWuxq4aeYbW814Bkh0YqaKOSrf95g=;
        b=eiDd5TVz4PClcQQQOxoWWUzFqCev/kZj7YD9LCDmZ/9jLwsRXH/lY09T3Eft5/pkpr
         i6fR35IjgI/HctHWq1mNmpoanG9ICl1hNSRqgY30a7SPI4QJL8a5M9VzR0GPIi7BUqlS
         2AseSqTljfKwBVucmkSTbGWkdLiiRyhe1elG2CVLQK6xnxINDypu3Nr7MRSkKadEBsiv
         YQ0rnXbSIldCeOYcEAs3sK+2YRdtCBWK0Dx4WIt6TgG40r+Ab+3MnnHU49bX90c0YNvy
         bmCNnMr+xJnBH0cY6qF+qPoOzNVu01aHYAC3WJ/AW9MLkubJe7QlD/8h1Ke3zc9PgXao
         7dlw==
X-Forwarded-Encrypted: i=1; AHgh+RqTHOW1iW1m/oLZWmaPeQ0FUbsDl+WrwH8fhq1F1Zw1o7Y+/E8BrqvdvmF9fllibljvmL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8CmB/V+NZ1OYjCsoQ9EocBXMDfidaqYkXdyFy0sj8c64jqWa
	9zq0lxkAszDRgYaqrqa7ISq5Juo1BmqipRrJSiBGLJ5bGodq0RIcpc2wpqecRY4nV4b2UoZRDOj
	D9FrQL7iBqAHC0j/b96y/19RWXRLZm8aT3TbeV4tA
X-Gm-Gg: AfdE7ckOmUAtKNx1t3GcCQltkyGf3MANYC+2XWGTZD4Ql2vnDSQeAtJbGRGvzfBb76R
	V4EBRJRE9moK2R0hHjOo4RAbIKW6zYK6Zlxufyk+VVwXoGQAJn3iafN6bIWin1W/uF/Cpt2dFSQ
	l0SgMYAyonpdliE5N3UxMi7/IzrBUmCNFGr9tjXHZUU5ATMwDiZoVTugEJ5uLuSSrnSt41dT4pO
	QvoG6Jle3TEk3Xvd16otC21ErWU0iEmtnJdqLiurXz8GvRBKGHlt8DH/MdSIPWLAn0VcpvqWxTd
	GmqgeRQ=
X-Received: by 2002:a05:6402:21ce:b0:697:6207:bad9 with SMTP id
 4fb4d7f45d1cf-69a9129fabemr94852a12.2.1783450602781; Tue, 07 Jul 2026
 11:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
 <CALMp9eQXGYevLQJnEV+Kx6hvp84vPQ=2U8AfZHiZrZj=CVM2hQ@mail.gmail.com>
 <ak0QYnYvchKTnwxS@google.com> <CALMp9eTK-Dg24geFN6tnkoD3rc4ct6eZcHCBv3EvPYOhBvaFaw@mail.gmail.com>
 <ak0frVw7GZ3HTwJV@google.com>
In-Reply-To: <ak0frVw7GZ3HTwJV@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Jul 2026 11:56:30 -0700
X-Gm-Features: AVVi8CfoOWabuW23otSrJFrdN-eeDtK9MNIudaSZ-7KRgXBFb1zgV3EH5k609DA
Message-ID: <CALMp9eTqVciHZXw+PSvbHWChDpAwjAoH1=f62DcyoqgneAku9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:47=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jul 07, 2026, Jim Mattson wrote:
> > On Tue, Jul 7, 2026 at 7:42=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Mon, Jul 06, 2026, Jim Mattson wrote:
> > > > On Mon, Jul 6, 2026 at 8:25=E2=80=AFPM Jim Mattson <jmattson@google=
.com> wrote:
> > > > >
> > > > > On Mon, Jul 6, 2026 at 8:21=E2=80=AFPM Sean Christopherson <seanj=
c@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 07, 2026, Tina Zhang wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > > > > > > > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_we=
i@open-hieco.net> wrote:
> > > > > > > >
> > > > > > > > > I will take another look for the next version and try to =
handle the
> > > > > > > > > remaining pieces properly, while also making sure we don'=
t expose stale
> > > > > > > > > or incorrectly synthesized decode-assist state for emulat=
ed exits.
> > > > > > > >
> > > > > > > > Naples erratum 1096 seems to imply that the instruction byt=
es stored
> > > > > > > > in the VMCB are not necessarily the same instruction bytes =
that were
> > > > > > > > fetched and decoded to lead to the #PF/#NPF. Hence, in the =
case of
> > > > > > > > emulation, it might be sufficient to read the instruction b=
ytes quite
> > > > > > > > late in nested_svm_vmexit(). That would certainly simplify =
the
> > > > > > > > plumbing.
> > > > > >
> > > > > > The plumbing doesn't seem all that complex though.
> > > >
> > > > What about the case of a userspace-injected #PF while running L2, w=
hen
> > > > L1 intercepts #PF?
> > >
> > > That can/will be handled by the fallback logic of reading the code st=
ream on-demand?
> >
> > Could be, but I would prefer consistency.
>
> Not sure I follow.  Consistency with what?  If userspace injects a #PF in=
 response
> to an exit from emulator proper, the emulator context will still be valid=
.  If the
> #PF is injected for something like X86_WRMSR, X86_RDMSR, or MEMORY_FAULT,=
 KVM will
> fetch the bytes on-demand, same as it would if KVM itself synthesized a #=
PF that
> didn't originate in hardware.

I was thinking about pre- and post- suspend/resume. But I didn't think
it through. Any KVM exit where userspace can synthesize a #PF is one
where the VPCU can't be suspended. So, I retract my concern.
