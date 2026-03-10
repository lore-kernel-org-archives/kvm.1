Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69076026
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101306; cv=pass; b=M7xvRMyPb/soDcbF4v8jU+2g+jj0JGPec9wTzlktj5PWYTvsfSY5aM6T8NP2Tgh28ufiQve4UK/44yxtHMnWKsfw4ENGdHRXDHzdVvRqJFe3UlaypzI9qK5DErHkzKpm+s3ti+blV439WIdGUIXM6EnSY9AtyEubTu+VoVsZhxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101306; c=relaxed/simple;
	bh=xswRCTTbxTBQKYqPjZfpdn6HN2uOawYOTdwy1gmnm8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl2+wU5iQIwlrwejeRJghl7QkPq7K4IBfXshzSwCJ4LODbU0qOLDzVBjKyF73vajHnUZm5sJzqIqYXGD4flra9PgzGNUU6w3VJiy/eb9Q5z5Ly5AaosN+rNCDG3xPvyeCr5KxL9IGfic4XBAMU2Tg3QamCNI4HwCxeHMu/xhQBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQb1n/q3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQb1n/q3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-661ce258878so5759a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Mar 2026 17:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773101303; cv=none;
        d=google.com; s=arc-20240605;
        b=f1fdEHDlUI49vGQ788VK7k6a8LsWD1nEXbLpEPFPdg5EibsOPvhm3RsVi9kcmSWBOT
         OBkyACBxOxpW1rDPcJTLMRVge/FVkk8FL94kAXOLHtIse53xmDC2Cp3pMsAtKPHpce6A
         SrPtmMupT8olslw4PbIKAproKZI+ARCvW1eiyL5ievpHzit85HKQKywXcxTXxRyHt6Qq
         2gxQNhJcJahGejYhA0a+IXdAHkuIn2hoRBWZN2bMtW20HsAp1YbMTVseeyBNsRqy79vp
         vEcPlcZoWxj+3MD95av5Utp/rrk9lhCB/BHXTqS7PRrpwW8lssKktHcHURZQlcW0j1Xd
         emwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xswRCTTbxTBQKYqPjZfpdn6HN2uOawYOTdwy1gmnm8Y=;
        fh=8FLQvpeAt40uwSNejFOMAweao4NRCcoZ17d3OhpahJ0=;
        b=DUe5RY4Q0EofcGoeYTpon6dNqJY68WTMfMKcj8x5M4ajAPEFASkLY1SAncF1V9EiAr
         S6LadYHur4xQfh2HN0kbcXPjIr1jM6YQJMBwiw3Vb9zB8yBTAXseWhBSTdhjCmrlK/l6
         5QM8uJj5ZSpOtL34hUrPGbQ4mIeHOtQff44YCc/KYr0thqjS+wygLZv74rRkC5PF4Jgn
         AwfU+ICwKEAzK71UOBENo2iiL4GVA2gBE/Jdh7tycZnEZ0iPz7rEka/EJlRzbyu/Obhg
         aFnKCplYeZZAYZwYpzR0SWEwCNCbNxykHRU6YCdzwYMc63e3JXCuNYxiniA1tozQlKjI
         yaPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773101303; x=1773706103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xswRCTTbxTBQKYqPjZfpdn6HN2uOawYOTdwy1gmnm8Y=;
        b=PQb1n/q3Bz3JNW3ayNe7Of0d51KMxqFo/V2WE+c8MAXUlONe18zyaUvgQzQhQfr1Un
         R8xDs4QAWeruRB01bOLeBO9FN02IrTW+WQPHU39PjrRYggrcaEpH5I+9/7bxIWUgrUWx
         VJhyVv6r6wwq3HmWwAVjyiFkR7n9/ERn3s2IGjjzewBJmc2aOY0AiT3ahCsf4/qAU/kU
         aGjsCu+jTlT2Um68h/sZx3gvU6ZqyV7ThG//DPThua/ARtfKxlH1bqFc+7sQwyygKZ1y
         NOhnMYNYegXQbvB9+zF0yamLtrrzsoZk3PaGPvLuHryM17k4pU9zIdRBu2cyRsPDwDzG
         OZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101303; x=1773706103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xswRCTTbxTBQKYqPjZfpdn6HN2uOawYOTdwy1gmnm8Y=;
        b=Magi4HwUApvbz5mOF6V3BTR5I5vXx2ATbqFYIMSG75O8NnOO2hsA9tGPBkJpjmPNwU
         wYAbbglUMEf9HefDdK55MxTK8r7jA2ZevcqL0JSSWd8wFIe+pt8RqQx5SdcfyKsTITqI
         5oY8VdCy0HQptsu8fpVhvfgH/C0FBpFDuv11BgQR4v8apv4yZSx8hBJgG4H6MCLNbAxv
         u1TYanbQeCTGYh92HXQUd/MulLZ0nI/isMgRCd1JhXCFH/YzUmef+PKHYivtqpQb+caS
         uQUiBuT8y1We3Z7h9DT5ooMqcpJCxkpMesDquvrEXJxy2PtqjjzWVDavv9q1XT7GsRrF
         IAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9RxxIdmWoSp9hzzTSeX7WrnLyiVWmKyPaheCarJD83Eoze6sGaXGC+PO7NiRagKJQgpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypx+ssfhjWnzdBBGcuUgLng2st3QhJ+GbPdmNQNlQJqX750W02
	rjBXODlWuBYWzB+wKHBmQoyenilNSd+OjzqL3koyqtlbKAObeI+JNqvWkoirQq1ICbFxdqGjrLi
	0lo9x6GV6FbDlWLErjUZjqe2D/iJfg5oZCFnQ4qiv
X-Gm-Gg: ATEYQzx40l7tvwbw6Hf+FcAg6RClpZJxRXKNpQkkytbsc68jQWX9SywCFrgWXjwdXYk
	mQ341RQ2AnNyR8JYM9cJBMkDVZwXSlrydGKpLUKqs7ozIE68yk5W9RCbqhctpNWrqhfgQi5b/B0
	ud4h/6vw/Ri49cAy/HOsNl3QRqgsyNp3D6i89G5+wiLRcKRlBrt+rZkga7Sb5HszGEMySvLDVPX
	53cAgH+eFj0O0ZHmDf/GEXKvr2JJ8SaLq55MqZWI3wjYgjvPNpeaF/mn4RSXIYFWeQ3ghNKpYiD
	O3JIHd5ZhNlbPGO4OA==
X-Received: by 2002:a05:6402:22e4:b0:64b:2faa:d4e8 with SMTP id
 4fb4d7f45d1cf-662c5951374mr8734a12.1.1773101302516; Mon, 09 Mar 2026 17:08:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306223225.l2beapz3nvmqefou@desk> <CALMp9eQoE13d1cqD3PNJtvdKUGZeVm1g-9TWh+M+MJj_sm9CzA@mail.gmail.com>
 <20260306232920.dja5n7cngrsyj6tk@desk> <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
 <20260307010051.u4ugg3nyvsu6hwbg@desk> <CALMp9eQGZcekQ3QtL=J7TqHJ9YfZ+SbrgY5P8fp14p4KNThYmw@mail.gmail.com>
 <20260307024132.wleqtpovzd6wtvm7@desk> <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>
 <20260309222935.2wu6xhydsgikkjpn@desk> <CALMp9eRu1YYFiqzMbNKOOhwwy-FqrSOvw-ddTuNtiSZbNs7JLg@mail.gmail.com>
 <20260310000020.pxig2fy7tjfex7jh@desk>
In-Reply-To: <20260310000020.pxig2fy7tjfex7jh@desk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Mar 2026 17:08:09 -0700
X-Gm-Features: AaiRm53ShvG4cOljQo-M-ziHx-NkbkeROsimCISGlTMpnhNLljMBg74ji8I-OwU
Message-ID: <CALMp9eRC4Sq8Kj=uiP=qaG0RtnUB8GhmLSTeu2Jh7pSMcw7hAw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, David Kaplan <david.kaplan@amd.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>, 
	Tao Zhang <tao1.zhang@intel.com>, David Dunn <daviddunn@google.com>, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 5:00=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Mar 09, 2026 at 04:05:55PM -0700, Jim Mattson wrote:
> > On Mon, Mar 9, 2026 at 3:29=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > Is it reasonable to assume that without the presence of BHI_CTRL, t=
he
> > > > non-Linux OS we've been discussing will (ironically) only use the l=
ong
> > > > sequence if the hypervisor advertises BHB_CLEAR_SEQ_S_SUPPORT? That
> > > > is, without BHB_CLEAR_SEQ_S_SUPPORT, does it assume the short seque=
nce
> > > > is adequate?
> > >
> > > I don't know. But, it doesn't seem logical to assume short sequence i=
s
> > > adequate when the guest can't ensure that VMM would do BHI_DIS_S for =
it. It
> > > should be the other way around.
> >
> > Assuming BHI_NO is clear...
> >
> > If the hypervisor offers to enable BHI_DIS_S for you, then the
> > migration pool may contain SPR+, so you need the long sequence if
> > you're going to clear the BHB in software rather than accept the
> > hypervisor's offer.
> > You are saying that if the hypervisor does not offer to enable
> > BHI_DIS_S for you, then you know nothing, so you need the long
> > sequence.
>
> This is all when MSR_VIRTUAL_MITIGATION_* is enumerated by the VMM.
>
> > How would a guest that refuses BHI_DIS_S ever be able to use the short =
sequence?
>
> Without those MSRs a guest could ignore the migration case, and use the
> short sequence.

Ah. So, a hypervisor only advertises MSR_VIRTUAL_MITIGATION_* when the
migration pool spans the change in BHB size?

Why not just declare that explicitly? This whole mechanism seems to be
an exercise in obfuscation.
