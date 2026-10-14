Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B984B4897
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016573; cv=pass; b=T3XJRiq140Hnyf2y+BBddISrT2cLw+cv38n/muHS4c4DwotixcpDsVubbEfBhq4WOxtBqfMTp/azDDWEMiIn+hlun8MbK0Ck/uVUuOEMsD6LPUnBazgXzf68JpIbxhHiA9BEyKR+n41KvIC0XW1PHUxsmPdkOR297Lj2I4+Iu0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016573; c=relaxed/simple;
	bh=659rxB8qF0PyHFwmXrqMLBeNoOW89CSuZ4MILSiw6W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwnWW7gX1PKpsXpOvGlm0jIJRcgzSaZO797JZ5E6wfIUbxPC27bJ3y62qtCdLQFsZqER8EWzbBw6ZLYOkkwLzPGIZdjbQX2Rap1GdVhwpAM02CZFUWmitkyoXoRRFOM499y98A6ORrw6J4j329ma3OqywmABzYQjwUiPgEKnuz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cByaM3ZQ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cByaM3ZQ"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so677a12.0
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792016569; cv=none;
        d=google.com; s=arc-20260327;
        b=bCVkIWczQXwfN55S4c0zVl0Cts1eBG7faelTWftFRuRy04pTncymsNQy7RyilnKByj
         MYC+XFC41BuLmYtGLizoaYc6BPA8O8Uyxq+LXhcRVdbOazwR4iY/cX0dKQATNf0OG2Ah
         94Ugy0BLW740jD4ZtiSby93ChFBzfhGacDOupITfz9pRAEannfkqzMkktMzMqtkaBJEy
         +0VgJ1rK34YuYfIQtL//H4KA9eRnMP31fyOGhbzFOng3hbJKt+/MlQQq4NGBVpEfK6c3
         MGzS9pM7iEALvy1FAwpRBStWAFIwc21IrmtKP1UquT4fYY/0akaJ4AxD9Si4YWWWocyS
         4Z2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FL0U2r+nt0Qijvo9WgkBvBQ6bZzc2yB8WX2jx5CtVnA=;
        fh=FZGNpL32U0Q4/ttS3rT/HmZNUXOb/Y7o4Vgk1VBOKWY=;
        b=j2r3FnXtk54qHkkCrLBeFgylKaQZ8M4xNCnubB3Hy/DImZHSiBHnLQYHZsBr392K1U
         3IjmHd4U+siQW8UtQr7a3egcTZA0Xbgb4gVHY5KLrsrA2OYGm7TA2h9hxHC1vI8gjGlk
         KGTQj0fJYjT3GvonAbvP72EH2lO4eupPwUxWLXUAtdvi338imrlcDHj5xg9HqaD+Gj2K
         Uijyd2hUhCC4hMXr6vL+c7b2+PiNovO9QkIfXEYAhdhgcQ6KXLjZKXiYn+65EX13Siq/
         GdUdYrFOfvYn5UP/nT4DMpZsaFd2yMeU91qXZoF1EqwSr8BXLdNaCk2kcnbols/6WIzB
         RGJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792016569; x=1792621369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FL0U2r+nt0Qijvo9WgkBvBQ6bZzc2yB8WX2jx5CtVnA=;
        b=cByaM3ZQKKZfO3wW5WWAzXkPLQAbg4MBCC/BfRVwj7imgr5ZrCN8f7IoQIqLQduNBX
         7JX/B+hAk7cIhrBvgK/03UarLpisi4dunmgk2hfw1ckxzH80yvqyFrGQIkslLgYyCDFy
         a/KaHs4c7eYvuMiJpJ95w6LxvGYFfirNf4jhX8j7gyzMwOu2M8QJHCof1NB6eUU5n0j1
         lhgWRa7L6lyJDqntQMjmkvWhNr0+xUjJCy9JayQ4zgC91jJ1N+FyJcgdpsP+loRF5T75
         nTNVZr23Zr3ai/uTZZURcZyP08IDKfxoicS4bwd4tSQU8GpC1L4CG06qZQ0inl19ovnq
         YFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016569; x=1792621369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FL0U2r+nt0Qijvo9WgkBvBQ6bZzc2yB8WX2jx5CtVnA=;
        b=BBFIRHVYyYs6aw3P//72u6yGwmHS5s5tseYbG05WL6MQJwxQAbD4qDgT9dQp1qKVh0
         +U7EvSLprm9UVEf6KQp+qZ6h/iJ4gZ6jsXeMk/v/t15foRB7cY4/DJ2lRwLj8hFL3Hh3
         z9QcNnwqCaldV7ieXTf5/byL/qaSfp1+qK/yWq+hqLeJi4fLn3PcHcOupg4Mwg46hGhT
         Xoyk7Denv6yza+U3i+3XUJbSLkpj/G3v+qHQQYsSO4eW0b797oNVmJ5FKu5qe8Mw+KcI
         AVOLuzirmeLkVE6tr32z8DYaNnUxZrGj5s+R+i/5C4dmUMaAcxGQ52NWIVN4G77EQNXH
         ZCcg==
X-Forwarded-Encrypted: i=1; AKwUvBzDUr+MTgcsP+ibE28/ZADrOLI+DQc6uMlWUuC+tLHl7qw+cSIjnoV2eONgc7p7SN0dA0M=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMcK889k4heshqAk89PvQA9QtLaWOXI8BNh8tONryzoU77Mz6M
	wlNlt9HXryYB5dchSuaF6sfQ9OaK/IEKGNkjbbBPjS088JltthO/o3PQRFbO1o1EkEumAwhIL3J
	tmE6Rb9bNzgXnM7c4MhZm2cBK2ThihJgmEosMXHc1
X-Gm-Gg: AYBFou0LvT+BuelmzKBXuV95c4sZth6bCbhW3P9fYXDJkygjbxB8fn8hTD8BcNfkvk1
	baaGEhoYL+1nhNcdVFHjeNj0a8KrxWIKLZrgp/aAFOuLQkasLqvONTIZS60n6tLGvpzTr0qPROq
	/49xu7S0kPONw2Q7Sn4aux/+uyWPDcz6v34c07pyrPRS657BnuIOp8WUgqWvlMhHOXY/URwxPIQ
	hsqaxiEbAYkZ2gl0+SxWxyRx7d9q6i/KnfKfacbHAgxHzZ3hJr6LSjSs4k6COAQ7KI6HEwj3Wms
	VfIo2RmQMBy/IstlbL4T3am59mbS+qapIXQ7A62/cZZyfyi77ulyw1w=
X-Received: by 2002:aa7:d5c5:0:b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b20aacf5d7mr30772a12.8.1792016568616; Wed, 14 Oct 2026
 15:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-6-yosry@kernel.org>
 <CALMp9eSWazT=0tXKvGb9UNWBv62di33QgugQHOa+Bo2sq0qUCQ@mail.gmail.com> <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com>
In-Reply-To: <CAO9r8zPPR9LMtcwhH=D8gJLjmC6800mJdyV+nKT83TnMti7wJw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 15:22:36 -0700
X-Gm-Features: AclHuK8zY_028QGyLFVl6ruOrvRrdz_5D5Cg9q6Chzm3VcD3FEl3g5nWoBYKnaE
Message-ID: <CALMp9eTyzxwjKnWXem=dAGiwJsUsArssQTcQhg56HVd+js5pSQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] KVM: SVM: Add helpers to set/clear ASID flush in VMCB
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 3:03=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 3:00=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > Introduce set/clear helpers to set tlb_ctl to
> > > TLB_CONTROL_FLUSH_ASID or TLB_CONTROL_DO_NOTHING. Incoming changes wi=
ll
> > > eliminate the use of TLB_CONTROL_FLUSH_ALL_ASID except as a fallback
> > > when FLUSHBYASID is not available, so the helpers will create a commo=
n
> > > path for this.
> >
> > No functional change intended? :)
> >
> > >
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/nested.c |  2 +-
> > >  arch/x86/kvm/svm/sev.c    |  2 +-
> > >  arch/x86/kvm/svm/svm.c    |  4 ++--
> > >  arch/x86/kvm/svm/svm.h    | 10 ++++++++++
> > >  4 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > [ ... ]
> > > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > > index 6d0242966dc87..ba5077b9838c0 100644
> > > --- a/arch/x86/kvm/svm/svm.h
> > > +++ b/arch/x86/kvm/svm/svm.h
> > > @@ -480,6 +480,16 @@ static inline void vmcb_set_gpat(struct vmcb *vm=
cb, u64 data)
> > >         vmcb_mark_dirty(vmcb, VMCB_NPT);
> > >  }
> > >
> > > +static inline void vmcb_set_flush_asid(struct vmcb *vmcb)
> > > +{
> > > +       vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ASID;
> > > +}
> > > +
> > > +static inline void vmcb_clr_flush_asid(struct vmcb *vmcb)
> >
> > The name of this function makes it sound like the inverse of
> > vmcb_set_flush_asid(), which it isn't. Maybe vmcb_clr_tlb_ctl()?
>
> Why not? vmcb_set_flush_asid() sets FLUSH_ASID and
> vmcb_clr_flush_asid() clears it, right?

Not exactly. The tlb_ctl field is not a boolean.

vmcb_set_flush_asid() sets tlb_ctl to 3 (flush current ASID).
vmcb_clr_flush_asid() sets tlb_ctl to 0 (do not flush).

Other legal values are 1 (flush entire TLB) and 7 (flush non-global
entries of current ASID).

And, in fact, these values were chosen so that older hardware would
see both 3 and 7 as "flush entire TLB."

So, it's a little more nuanced than set and clear "flush by ASID."

Maybe vmcb_set_flush_asid() and vmcb_set_flush_nothing()?
