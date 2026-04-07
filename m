Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFC3D16F6
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580873; cv=none; b=VVDJ0tIcHFrkNZ3UfgYSNEqToWZMDlZoEx/EXfqHvzVRKYWKbnLVOn4b7NDtEVhm+XEO39eaxD4TvqfP55PLgANfqk2il3G4XECkfk0WnCD+kRJhAtkDApfhLIK44LfCvemeo5S6vL9EgIIQcfp9zkG4ByWEpWqhu8y8eVNTeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580873; c=relaxed/simple;
	bh=kKNZqL6F8RmDQOYiNMBKcBJ96UMj7k7Q/A0Lt+EFUqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O5PlTWcTZ02lczt/lRP4aGhgVRwlp95Gy1aCOFzlkeSAc2CcFx+7wIBr72yivnkJ7Soad8cQ12lg+3pYpZpvcWhB+XObObJudKD3Oq9iLUTj+0XXzlxf1iZa8AXmfYOm3t74ppbz6sdnwaOBV1MS0W2HxpUerynhi5k/YWqm0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cu1tGU4E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cu1tGU4E"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354bc535546so5062553a91.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775580870; x=1776185670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxK8eLm+ve82UzYFQ5zdW5woECKhYE33nt75jf47tb4=;
        b=cu1tGU4Ei9bmbDaX+6/BWORctJ2puqjuFu5h4ghR49yhPbn284VlJJluhvqlgIoUxL
         kOe2eYP/0alb2ljjwzJqxj1Dmg3BrWHhRkioQuEkur6w4GfpnNsXYLey9SiImSBb0d8O
         jVUUKaWPf7PX7tB0qwszq5DgMJPdspFhhzNkiOotj2hJFKYHzPq/L4VEF3HJ/ltGP8oA
         oB2k5fvCsWNe4q+4XevSPmnBWwIluLIqEPO8Jzo83gSf87W/AnLJSPMTeaU7yg9RJljl
         j+pVXCSk+pqfxr3qSCDYl0lAl2nwajyo8gkjA7oqvvdXoUbjbJEluzHGp0fYhgsblktJ
         +axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580870; x=1776185670;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FxK8eLm+ve82UzYFQ5zdW5woECKhYE33nt75jf47tb4=;
        b=bLfIkc5cjRtrNDjCkQSCYqqAZEYfhwgddu+WY3odZK/YXFBP+O401nTqkyOUM6RjSy
         w3KrJwVac1yvyUi90pEa+VFdIkPoOQCKEEzbh5VzV6iswJ1H6TomLqiNhwcaqJL4/Glu
         SPC4ROCxCQQEvgb4ZnAz2teZtI0SToExiRvYz/bmzCiXUuC4W5CPLiYEv7KJH2gZ8Qd+
         vXuIToUTevzcENf3DAiEdSTfCl42T4yzXdnQ9tpHdDlvRUFrdAdgIt5mgKLTZ2tlUS69
         hSaK2bG2OuNANtXHmgMIy6ogFTSzXGPSeX5EZWVcosR5M+GoPiGizVaYcHGpFJJoQPdN
         u0YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbdBVwspyyUeIiDi5bt9ADRL1nLnofS1X+v04DU2KBeawuPLUNpFgjdfWCrfnvC9/w5gM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UGELFjojs/PnhbayEFJ3o+g2mFGX0WOQM0j9SFwJC/5mwqD+
	doU5U8gj4pbcuOuX5/ZCU5CmorNQngswKEQD0BFV3mbHU+5yKVygJtn9B0ibyKZBMRVueZKa+M6
	m3RE/OA==
X-Received: from pjbgb12.prod.google.com ([2002:a17:90b:60c:b0:359:7aaf:b9c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b92:b0:35b:e4d8:e21d
 with SMTP id 98e67ed59e1d1-35de678f2c8mr16629462a91.2.1775580869789; Tue, 07
 Apr 2026 09:54:29 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:54:28 -0700
In-Reply-To: <CALMp9eSysKOVGF_xakbT59tVsgER6oEYpJuK9=hQutjY=ZpM-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-9-jmattson@google.com>
 <adRGLPrmBpX-3DdX@google.com> <CALMp9eQsd0fRuDE_R57Mn6-N6jCtbmoPAh7Y7CBdMEZJaNSUGQ@mail.gmail.com>
 <adURPZJEDs50NPkB@google.com> <CALMp9eSysKOVGF_xakbT59tVsgER6oEYpJuK9=hQutjY=ZpM-A@mail.gmail.com>
Message-ID: <adU2xHUvZJVHtNlV@google.com>
Subject: Re: [PATCH v7 8/9] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026, Jim Mattson wrote:
> On Tue, Apr 7, 2026 at 7:14=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > > >         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENA=
BLE_NP);
> > > >         if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM=
_SHARED_PAT))
> > > >                 use_separate_l2_pat =3D false;
> > >
> > > Wow. I really have no idea how to predict what you're going to want
> > > the code to look like. How is this better than the original?!?
> >
> > It doesn't immediately wrap after the "=3D".  Similar to my view on wra=
pping before
> > function names[*], I find wrapping immediately after an assignment oper=
ator to be
> > unnecessarily difficult to read as it doesn't provide any context for s=
ingle-line
> > searches.
>=20
> That's actually a good argument to *never* wrap a line. If a line is
> broken at all, the interesting context might follow the line break.

Don't let perfect be the enemy of good. :-)

> > I'm pretty darn consistent in my dislike for that style: I count 26 ins=
tances in
> > arch/x86/kvm that match "\s=3D\n", and only two of those carry my SoB o=
r R-b.  I
> > simply missed the wrap in kvm_vcpu_apicv_activated() that was added by =
commit
> > 896046474f8d ("KVM: x86: Introduce kvm_x86_call() to simplify static ca=
lls of
> > kvm_x86_ops"), and I'll give myself a pass for commit 8764ed55c970 ("KV=
M: x86:
> > Whitelist port 0x7e for pre-incrementing %rip") as that predates treati=
ng
> > checkpatch's 80 char limit as a soft limit.
>=20
> Might I suggest that you should provide a tool=E2=80=94something like
> checkpatch.pl=E2=80=94that flags style violations?

Or maybe extend checkpatch with an optional "feature"?  Or subsystem-specif=
ic
rules?
