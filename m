Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFD4D990D
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192842; cv=pass; b=m0czvA1b08mtxjEXSI2IuV5zpUzkmIWXHvM2BEIjLqNANJiJwWWjoNgTcBlmIwZXEp28JzzL5NYrzE+f7Uxg87B1qjZltijba4E070zp21zwCvn9lxeSu8+SUfXGKUK4oGm+8QE4KWkV1uHcTA+dBy9L96RCoOFNTQTzQReRyUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192842; c=relaxed/simple;
	bh=7VWO4tOJZLIbfUwVyMsF0ej608m9OlSJbClLH5Q+eyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCF+Ea4yW66k45lWFXbtninnKZ/16g20dCVP5RkZ1hdvlYlJdC9byu2UEXXBNHh9p6N6M73t6GeVDPhANfQVEZrt5oJNFsSHd0CQnal3KLUusoNleGQXZopbIeF0uRqRU7VBdWn8SzhRDzgTU3hVeK2mza49cuvBu9vYZ//DtnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0eUIDoO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oSSZ/qsq; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0eUIDoO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oSSZ/qsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779192839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXWENuANe/jSGrQq2ukgBgZ/4H6cQmEOV8lkEUWmoMA=;
	b=h0eUIDoOEOrzplMCbVfrEh2sPliz/nPc284pHYoV+1d5BeabPcrFwQmAG82TSwVKk7mnxO
	Zq55prtxIjG71P6sTFtKdczqU++GF8T551QEktOYqN2ErTMLqCOCJF90Qh16CbugIaPRIR
	yH9lraUTOQkQzX4vhyHPwqnBB3m4rYY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-1QGjlYUqOo2IiBru6dD1NQ-1; Tue, 19 May 2026 08:13:56 -0400
X-MC-Unique: 1QGjlYUqOo2IiBru6dD1NQ-1
X-Mimecast-MFC-AGG-ID: 1QGjlYUqOo2IiBru6dD1NQ_1779192834
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e739bd2c3so2698820f8f.1
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 05:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779192834; cv=none;
        d=google.com; s=arc-20240605;
        b=Q8KfNWn9ntdlXb2FG9lq19zNjB/hPjaS3aWgABDdlN7j3I8+RjkxQ/gYt6orD8LLFi
         8kNquz54nV/KDGmk4/1DviwIevygFOYwajM708ggRZiKAoPvEpXcpTPItvV9fv0SELrr
         onsqNe+xmor4glFoP4eZU281S5fNtvY2bs2xK+jcHY7ahqIHI8pGDPLsAIQ1U1NyoCfD
         MalEQCx7VdE7Vk8J9KoBkqR0RL15RXJyo0UzrNXdra1G5EFHG2SM+NYfwrljD9UY/v4b
         OpdUBZirsE9SsMewBJvbBuiCfLLMXdCZF2c9Jryfy7lDPxUxmSsMcGrsxzurak8Ybq12
         DdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXWENuANe/jSGrQq2ukgBgZ/4H6cQmEOV8lkEUWmoMA=;
        fh=jUlc68IpSHMxwh+jqG/daQkKz/bJvkU5yv0FuDggx6A=;
        b=UDKy2BGfMy0mowH67ES+aV6qt1ZYPOt6XrOVAFb4D6j6VJVt9Fu/HX4ByPsA38b8kq
         NfoIlBXz+WZq1NsFRYGSF2t16tlMzeOCr+lb0lLyPR4ObV2yxaL0gjslNRW6bUMk7KCb
         EO1QOLyWi2bXpYWaUVaM0MZqqLSGIxBaetjvlNQv9cSbLfoNP+DIGq5AbV5oj4oBxTjn
         3DjBfiE2nzf/n3f++wEjJa7d3IueSz20bnfCNRMIPZy09rwcCnrAcIZwvJoUTE2u2Fyc
         kwOBTZzu/CQR3buAZbtY1i8bDHiBHJqS/SdeD8vw7kkBYOlfbj+2A28b1U39MEUnjyBm
         UNiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779192834; x=1779797634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXWENuANe/jSGrQq2ukgBgZ/4H6cQmEOV8lkEUWmoMA=;
        b=oSSZ/qsqcKkqKxC8ODU8GcNDRe+Uc7J4PKACXx0mFXW5Ue/v+2XS9uqt5QG39wfa6A
         s1uNo8VJF+DtmK0vKgJH1ChGkDzhN+0U88hzwRYIMdzrwjk8IjdbHWu12/RggeDksJf2
         hCAxcHoXDOQ/CvegmlSYedIEo5/KgrPA70XQUVmcYkCAG960RW4Ru8vwC6uHrk3/Dhci
         SZ8Wgp26VGsJU4Wu2DRahvV9ghVuxtFVvbS7NiAqj8G0qsLLDp8m/CwXKAKZlUPLhMVt
         SBDd39P2EHtTtQKRvcKdvjvrpgF+W1QZuCU8WG15MTENZFXWFpDnMYaYIzYTLXodnxOg
         N/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192834; x=1779797634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXWENuANe/jSGrQq2ukgBgZ/4H6cQmEOV8lkEUWmoMA=;
        b=WhbvzEuHhlcF81B3djludfwzZF2dP3lPyWu3ei46H56eJ4BXQFdVD2Wd5Dz1QEfUQn
         4ZXrROjVefkXoKgOA4rXBT8/khKnNtsvlWq+BX0AaejEs2FLW03KKFRXN6nAD9E7DaIE
         afcv2YNZlZTlPJL7XOzPMJ5/NQ4z7WEA9/pYFRuqVAtPKSNQVdVwlNEkI16UMHpb9uMG
         GdpheUtiXZMIfYQxbi+fJE2qvVkUpKsGu/yv4fK9c+ZY1Ya+8rJMMrDN/2grHLIPSc1C
         Uwp9vYnwpv1VhvmKI1jFscbQHwY9U94i0UKRFd+mNrg4Fnovf/C6jAPXsd4QGrfjrqPo
         2s5w==
X-Forwarded-Encrypted: i=1; AFNElJ/+MLuEFgzHeDG47ssm3ZwIoSWo56epwtWtbPVJCBYKDw9g/4r3OejWqNkYh1M//r/14ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxLKRMgnLlsD2hK0CEc4TSQhz86JlK7unItWBkG04eCRHWPcF
	n/cQ2U7smSTHCLMPn5ZkKR/Oq4n8DbdZptSgFfG9/VzSlIkDxcuFgOh6vJkBcuClq6DixrunhFO
	1oEEZCVNEUsSouz1BJhjmXtjiVFjcGKBGhv2ZBBkWdo2UX4Nlw3VWH/SyBcRNFoO8Qpy9sOoHYT
	pPofHpqR5nyF/UwFe3todbrDbfqL6B
X-Gm-Gg: Acq92OG2qtWFSUQHNKyLpLZ0Pe5XBjyq+b9JeZc5Mrrm5RKa6KQj91JTroxx3vctUFe
	3Qj1DtQkYHGfRT8nYhe3IZB1ZJ0d0gSfsBcsCHdcK6Ti3neyzc6QU0rsVHDLhTgfhx5Hov19g0K
	E8FNPxKixiAAQ48ftAkorXmDIQ+fGvrJdra4kf84gKNA5OT80T2DOflaI7SU1H3CAG4EiqHFlBi
	yaHDFOuCAYGq6O6zPwOd+IiK0fI59R8Gj30ZWUAZpWNL00UEG76YGstokzkgfuWQ66NVKCSMthi
	KWLp+A==
X-Received: by 2002:a05:6000:2207:b0:45e:73eb:2a75 with SMTP id ffacd0b85a97d-45e73eb2ab3mr19018192f8f.16.1779192834228;
        Tue, 19 May 2026 05:13:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2207:b0:45e:73eb:2a75 with SMTP id
 ffacd0b85a97d-45e73eb2ab3mr19018142f8f.16.1779192833807; Tue, 19 May 2026
 05:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6856b269d2af706eae397e0cf9c1231f89d9a932.camel@infradead.org>
 <6afc4b95-3c15-4d71-877d-19b84e91ce05@redhat.com> <57bc082f4824d6114d3156744c25986effc29aca.camel@infradead.org>
 <baff82ca-6321-4b16-aa61-b2d6d60b6535@redhat.com> <86h5obya2r.wl-maz@kernel.org>
 <48b06e5655d56ff6eda30e563b34894fa0eb2f07.camel@infradead.org>
 <ba08dfe9-932b-40c3-9fdf-fc891d52e1d8@redhat.com> <d9d4471a7f5ec1e297b3ca07f42a59090aa91e15.camel@infradead.org>
 <CABgObfaM-JtNn2MuYXaiadQnLfAhTEaoHAcTG9=J6LkMcQCJ3A@mail.gmail.com>
 <3f9d731c3d26b0367600f1069e6425099bc34eac.camel@infradead.org>
 <agxFbniU_6eQ98t2@willie-the-truck> <cf429f2082e863571595f74d1d3dedc3e6a82964.camel@infradead.org>
In-Reply-To: <cf429f2082e863571595f74d1d3dedc3e6a82964.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 May 2026 14:13:41 +0200
X-Gm-Features: AVHnY4KnZP7vwbtgqcU4-2-Suro94ZjhbnxjZ4Hm6Me_3CnnH2LMZ4Ptbe46Vgg
Message-ID: <CABgObfacAYexR25SMi1kSZMRnHx3EDGj8=E84V1DumER66ibnQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KVM: Document guest-visible compatibility expectations
To: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm <kvm@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Eric Auger <eric.auger@redhat.com>, Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	kvmarm@lists.linux.dev, linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:44=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> > > So... what next? Is one of the other KVM/arm64 maintainers going to
> > > speak up? Paolo would you consider taking the fixes through your tree
> > > directly?

I admit that my knowledge of Arm is really limited, and I do not
understand which IIDR values have architecturally allowed behaviors
and which (if any) were made up by KVM; but even if I cannot honestly
remark on the code or even the approach, a compatibility knob is the
right thing to have.  That's a userspace API design matter, not an Arm
or GIC matter.

I hope that Marc provides a better explanation of why he believes
https://lore.kernel.org/all/20260511113558.3325004-2-dwmw2@infradead.org/
shouldn't be accepted, because I am more than a bit puzzled about
*why* that patch is being rejected or (in v3) so far ignored. Marc in
this thread wrote: "If userspace is not a total joke, it will read all
the ID registers, and configure what it wants to see, assuming it is a
feature that can be configured (not everything can, because the
architecture itself is not fully backward compatible)". But in this
case there's an ID register that tells KVM if userspace wants the old
or the new behavior, independent of whether that old behavior is
architecturally valid or not.

I will certainly take this patch, but I won't override Marc. However
I'd like to better understand his point of view, because right now I
just don't get it.

> If KVM on arm64 doesn't aspire to maintain guest compatibility across
> host kernel changes =E2=80=94 regardless of whether the previous kernel's
> behaviour was "blessed" by the architecture specification or not =E2=80=
=94 then
> it does not meet the expectation that we have of KVM implementations in
> the Linux kernel.

I agree with the "aspire" wording. Even if it's not going to be 100%
achievable, KVM *needs* to aspire to maintain both guest compatibility
and architecture precision. Sometimes it's impossible, sometimes there
are constraints that require you to trade off one for another (e.g.
via quirks, or by breaking behavior that no sane guest would have
cared about). But in general as a maintainer you don't *get* to
choose.

Paolo

> Or indeed the standards that we've held for Linux kernel ABIs for the
> last 35 years.

