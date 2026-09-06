Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C6305E1F
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712422; cv=pass; b=VNbI7iQxhTunP0hZy6VfE0RvrZ6blSF9e0XYHjePJiu04caApLHYGYehfNJsVlQM10IdTdupwzSthjOLLnxnULTE/i6LGmvUt8+T1vsjM/W1U07b3v0h5z8X0ugafA7HHKlADKOSe+w/Bkh27sjWixagtYogjYNldNv/EBi4gyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712422; c=relaxed/simple;
	bh=ACLX00MYnd5B2zZS8+Hc6cEObWQxmMwBk/e3V73tefo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvPbzs3PADSRZiKyqP6I8HjSqYyFUftxGD0W17Ff/JCZ4y6t1m0VkN0JjBogQpJTjClTFpndbmMs38XWQOaxmRybm77mMtLSv0ilgn82spXRfd0jhQQG9HoNEfWNPDbQSIO7MvN507GfosyKQmczN17M4cBiBKkNLBDluoODvRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGCkXp2D; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tGCkXp2D"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so6955a12.0
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 09:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788712419; cv=none;
        d=google.com; s=arc-20260327;
        b=eNPwzw96sDrpG/tNbwc4ZtRZgA+2TTHkSZjOlotzDpyMbzan5OtuGIOXG/TqPNlUx+
         tiUb+UFAFs9EzpKTN8bPWL14UEgliQwbHqBQAQO/LXfGPJgn30WjyLst3iLDhXi0tNhf
         O6cAL9tBiIy5fASMLCfnpCFCNiwKqR1XkrAE4vCJcZt5APHmqf2Umbx05BWRZxPMr8KI
         YxKrZqyFfUO3I3CJeiPZkvYe8nU9iJ+hthGc2uSGahA4Io35xqtu+C1knfymMrHEG93u
         Y0x2LuHVR8qhi5GCRH6vyKzr+jRFG1lt3tQAcsFTg1CB83Cxwy8TfIaGuAFOtCjBEkEP
         RuGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CrpB/OwY6AJF8JL9/jLG6IYpsoLmLyv+fZHJUH/lclg=;
        fh=MSu7TQtVA8CIQGu2leflyiNNxG2Mtg6/SxAxk9aFTXM=;
        b=BJE1+8PQDdf4bOGwZkCfcv5OXlz8/EPigLlO+HOA67/YlqU4pQiMp4fOhYfAu4jqkM
         Hk9IzMyZvkxcdmnAVOSFMoa4muQ8kXE4lev9aT5XafpGIeZtPKXOwLMuFmADxYPm2Jmp
         kL/sN/+7SFZd0OqMC1CXggglnNfJR3+E+YJEU+k3xw09d+1vOukUw3DeAYN9GZrcxWOP
         l8Asu4OIlqJWSfYmlqupy+L9DPPLE1W4C+lCZYgbn0MZWJLb0SqRY0YB1I83/TQcvXU8
         nIgMOvSb4M3qwmnrldIRaZ4kbKuIxP3iLFP2JQClFvLSFVaCdEd44KFD6mwzpljPE4eD
         EP1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788712419; x=1789317219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CrpB/OwY6AJF8JL9/jLG6IYpsoLmLyv+fZHJUH/lclg=;
        b=tGCkXp2Dh03oKHWoitx7dHVWG04OfANTSA/vQF4+PbEffbotdL5Zh/Zx7K3XGUZpz9
         sZrxSGzeFT0FL2lEN53ieKYl0FAJ2o2cfeAMoT8TzBLRwAWg8lWDk8SBXZzoCzuouKS5
         s9wBjUCS+5BT74mw32CcMFsVKDx/unXYbS8COAyGhPqmkWTBTHObmHEmVmUpsvRWcBA8
         ry0fg5KJv4c8DzQ1O7XnE5ZAYxCUzSn5MLEEa2vkXFRZZ8H/kt2cOIJA0aq7SUqbOVg0
         2u7vo2xET3d7PoQhGsEazni+OzmWyOoCAhcISHlLC19OhbqV3AkduJgB5f27QCvXNCsE
         VP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788712419; x=1789317219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrpB/OwY6AJF8JL9/jLG6IYpsoLmLyv+fZHJUH/lclg=;
        b=msXzJvYVQOmKvrIYH1kVFGtfwPAQ18Kt1g3YFso2sLeN7kMF97IL+SQT2m/KXrh4ZY
         KYaoAnZNnxOS/ZNHVtau34aQy2eeJsoqsyQNrmOit9A7bT4mNnpe54/IEDyJ1ieknbA0
         OUT1Pau2jGFCoJGy90+DBwJH+nH/EoGfWBh1+mkT8bny3HU39L5bf0E5mC2qCfojADXg
         hQbKO+CDAq7PsMYzEAwFcdCzvANY85wqFnMRX8+n+RJA9c7LX2LkgTAg98HBZRAAfnol
         iTtRom/+7AHZun44xHTauSLByrJu54pTfc8negm1xfNDGQzyGQsYvsh7gCecAK9qAxol
         DJWg==
X-Forwarded-Encrypted: i=1; AKwUvBy8Y9t9wfUGik5DuV0eSRmkgxBwHCRb/mlK7QssU3MVYwwv+W+6A2zHvZ3yGGijxDNPmAY=@vger.kernel.org
X-Gm-Message-State: AFuF++l5ayUtXlJ+dIhidKeFI+jde3aip4afN3fFKg44R16nk4TDnNpj
	JIt39KjES2iKXzWsyYqiPkTZ6xThU8qye9bkZQ7UosBKfEtNH9yWPq23tBDpdVCNDEv8m392/Dy
	lBo+2wZLL3bWigiC4NgDQgExK+2s9L6V1bFfjHEfe
X-Gm-Gg: AYBFou3Hupzcdxczt0uJkLyHHnljfpCwnfGdt0TCY8dBwcP/i5Cs81OToQBGERrmiXw
	yX7bNq4hav6cjjgpizpr9X3KP9b/1jxa7hUABuTlM75NFhi4bz9pT8aaJ+HtKfWoSs0ZNBFhNYI
	0XrDwMqRAVNtttw9wnVedTSQ+/XY12mHCysOv0m60WRbwBq9x4OcyJKpf/Wot5DcNdvXuJDLyvn
	FW7mqY/FYlF2TKB7PizJh3yoBV7sBFahaNMaFmEH/SCHzn6gpKM75FjeTNVw43KASvjgYoKSE6F
	QQxJElw2TH1iInd+VOUsBSkePJSKsaLrhwVKh4wYsOrh
X-Received: by 2002:aa7:d8d6:0:b0:6a6:6ded:b4b6 with SMTP id
 4fb4d7f45d1cf-6a7f689d0femr33485a12.13.1788712418519; Sun, 06 Sep 2026
 09:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-7-zhang_wei@open-hieco.net> <CALMp9eSoLMx6DLH=Ve5_r7y=0EOmxjZgJWE_fLM_CAYxOvJdkA@mail.gmail.com>
 <f187e4d1-9d31-4e54-a75b-b724ed5d0e9a@open-hieco.net>
In-Reply-To: <f187e4d1-9d31-4e54-a75b-b724ed5d0e9a@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Sun, 6 Sep 2026 09:33:23 -0700
X-Gm-Features: AcwNN1WeNE2aRN_GHL9nwnL0ZDXpzLpawxwnNQXYe6q75jXTytwFkMh9kfGuDBU
Message-ID: <CALMp9eQQY-Tu3C0QLMe2kxvt=__Fq91dLtzA=fbTDNc_Av7Gew@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] KVM: nSVM: Fetch missing DecodeAssist bytes for
 synthesized #NPF/#PF
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 11:40=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
>
>
> On 9/5/2026 8:39 AM, Jim Mattson wrote:
> > On Mon, Aug 24, 2026 at 5:40=E2=80=AFAM Tina Zhang <zhang_wei@open-hiec=
o.net> wrote:
> >>
> >> For a synthesized #NPF, the emulator fetch cache is not guaranteed to
> >> contain the full architected 15-byte DecodeAssist window, e.g. it may
> >> contain only the bytes needed to decode the instruction.
> >>
> >> Keep preparation of synthesized state limited to capturing a matching
> >> emulator fetch cache for #NPF.  When constructing VMCB12, copy those b=
ytes
> >> and fetch any missing tail through L2 guest page tables.  If no emulat=
or
> >> bytes are available, fetch the full window from L2 RIP, including for =
a
> >> queued or synthesized #PF VM-Exit.  Stop at a translation fault, read
> >> failure, non-canonical address, or CS limit overrun.
> >>
> >> For a non-64-bit L2, truncate each incremented linear address to 32 bi=
ts
> >> so that a fetch whose CS.base makes it cross the 4GB boundary wraps as
> >> required.
> >>
> >> Do not perform tail or fallback reads for SEV guests.  KVM cannot read
> >> plaintext instruction bytes from encrypted guest memory, and the exist=
ing
> >> SEV emulation path treats missing hardware DecodeAssist bytes as
> >> unavailable instead of decoding guest memory.  For nested SEV, report =
only
> >> matching emulator bytes already captured for a synthesized #NPF,
> >> potentially a zero instruction-byte count.
> >>
> >> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> >> ---
> >>   arch/x86/kvm/svm/nested.c | 58 +++++++++++++++++++++++++++++++++++++=
+-
> >>   1 file changed, 57 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> >> index 635ff20cc431..c677ad5df8d6 100644
> >> --- a/arch/x86/kvm/svm/nested.c
> >> +++ b/arch/x86/kvm/svm/nested.c
> >> @@ -87,6 +87,54 @@ static void nested_svm_clear_synthesized_insn_bytes=
(struct vcpu_svm *svm)
> >>          svm->nested.synthesized_insn_bytes.insn_len =3D 0;
> >>   }
> >>
> >> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *byte=
s,
> >> +                                     u8 count, u8 max_bytes)
> >> +{
> >> +       struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
> >> +       u64 access =3D PFERR_FETCH_MASK;
> >> +       gva_t rip =3D kvm_get_linear_rip(vcpu);
> >> +       struct x86_exception e;
> >> +
> >> +       if (kvm_x86_call(get_cpl)(vcpu) =3D=3D 3)
> >> +               access |=3D PFERR_USER_MASK;
> >> +
> >> +       if (!is_64_bit_mode(vcpu)) {
> >> +               u32 eip =3D kvm_rip_read(vcpu);
> >> +               u32 limit =3D to_svm(vcpu)->vmcb->save.cs.limit;
> >> +
> >> +               if (eip > limit)
> >> +                       return 0;
> >> +               max_bytes =3D min_t(u64, max_bytes, (u64)limit - eip +=
 1);
> >> +       }
> >> +
> >> +       count =3D min(count, max_bytes);
> >
> > Ugh. Pasting together two partial reads performed at different times
> > is egregious. This function should read all 15 bytes in one go. That
> > pretty much renders the emulator's fetch cache useless, except when it
> > contains the necessary 15 bytes.
>
> This patch was based on the discussion from the first version of this
> series[1].  My understanding from that exchange was that preserving the
> bytes used by the emulator and fetching the missing tail later was the
> intended approach, as it retains the bytes actually used to decode the
> instruction.
>
> Did I misunderstand the conclusion of that discussion?  If the
> preference is now to avoid combining reads performed at different times,
> I can change the next version to use the emulator fetch cache only when
> it contains the full 15-byte window, and otherwise fetch all 15 bytes in
> one operation.
>
> [1]
> https://lore.kernel.org/kvm/20260629125205.52394-1-zhang_wei@open-hieco.n=
et/T/#m3fa3f64ddd3284b312d3ddb44fd30a2e26708037

I still don't like it, but Sean overruled me, so I will be quiet now. :)
