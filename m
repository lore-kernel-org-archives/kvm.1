Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794522150;
	b=QHvc51P0hu8LP0eo3Z9CKpbT8DHtawthQcdB23sgG9e8sgxsry5W4XoeUvvS22xEnawE
	 7wK5zWw6FWzjg4vZz5FmG1nfnxYS+QAbH6IhsoVt/L6AMDuit850+LfytJXGvD7FeKBPg
	 Iwf6lA+kiU+kM4ItnQC5O+FmY8a1PutNF3akNI2UaxetZw8Zi4sKQG4iOZ3xZLrSG29K7
	 pxVtd69ZYw+h4ao364Z3VKmh8R99aCYYfiktC0DBYDQbwrRJwsT46i+X9i/STi9gzWLS9
	 ZK6VuX7drvadddgYZ++kIIWNgFbUTS1c243QTMUr9rWy8kWkeDEc9Y6AgGvJ+h+j6Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QrgIfCS7YStc9wryNUO5eUzghFQY2XE+PPHAxJEeCS4=;
	b=b1ODV8X2KTFHeLCug6AphLvApIWSUm4JRvym31UAqT2Za8rjcxy/FDNp8+26IRdHc/vJ
	 r62QSIOdMqrF/4V6M1T30d2lpKjwgywLYvb4EjRYo8xmNV57AU1fhnpa2tiB4FE1vR7lp
	 YYPDEZABkLZxRpiXzIi/STed6/4+zmHdJdHfEdVTk08/iEB4cMrVwYcYEoRY+nBgDdwsj
	 AO9qkwz0Ijidq2iKb6qQCI4oyMVQas1jLeH+nhttd5jpacdGYnJ27XFhyQ+txOyYdlMUL
	 krDlRlKdo2JgxI/BPBOLz+adZw+PgcDuFBO7Zzc5EnOngtlCZuN3VRGzYJqAteeilQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y5hgE3vK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28233606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28233606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y5hgE3vK
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so1714a12.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 14:22:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794522148; cv=none;
        d=google.com; s=arc-20260327;
        b=llBtVBpjKghm9noCa8D8VHh91MHKR0/VU+c/2bTnAQTUN1WC5cIrc2YECXsPiSVp3Z
         2xuMg1LqopDjmTsPG1YExVhJasZ12y17CBd2Gu6ScFxaRfBKwGuZRjYUooeO1L5Ueota
         +zMf6TRrw/K35Ff7+b83oplEVbmmsQOkqMOIhlVXkkkohIEIl3+6vXR/C6k4wyyz7XNk
         5DKT5+JA3lFszGyhQgJoW597t3dFtYuZp/xlyRsbYJ/3/1i+3qBBUBPwOGRRlffGjBxZ
         tRyNWePNV2IlFR/Ae9JwRGL0RwAttua6918t1OaIzQRuTsD/tYHwEAAynsVvI3G8rIL1
         Qhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrgIfCS7YStc9wryNUO5eUzghFQY2XE+PPHAxJEeCS4=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=iW/LgjarM3hoB0X5Eg0/cfVbd/VJEmY7wgo1KvKUl/+lhuq7EsjK6cwdOmCwhFYoUE
         VqjfKQrlzfJp+TWv1Ux0gUiG4MU3sbKRs5QKiXrE91rUrFoReEQ37vm8vpoEuUp/KzaZ
         hVHBCQ7ZUl89F3GLSRJuh0b4fHWkYG5aoMi7yX9XRimmp7rYM1/c7Oaow7nQkSehFhi1
         Npq40O5vFpHtqS+bydVyV8d4yigjUiapfxz6QqU4/HC7IkymyUOTkeAaTCDhrriFmp/6
         axoK9YbyDbPCn1IpN8tAww0HSbpkwnBXvswrzoLkL+moyrXbWI808GlFF8ee2SMmR48B
         xZ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794522148; x=1795126948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrgIfCS7YStc9wryNUO5eUzghFQY2XE+PPHAxJEeCS4=;
        b=Y5hgE3vKttPPkVmtDtDb2sfF2uF8q0MoLrCJ2JEF5RNgxA9RNSugE6RYV88by9kuOU
         19t97nLUNAGvadKueOneLu9y4OmJapv8Yb3Hdq4OoMuYTDAQdKG3dt7/F8fqWlPVMqzd
         EPrwnUxtGRkCSplvGl160DeA2gzIXVJBX1MhdXE7mzAdi5dPOTgSd7v6kzB5ev91vKLs
         E3YZcOCeRBXnFSVB63f0Bhy0gC5Jjoej+ZeMqFXzoLzHRgJ7Ze7yKDlATyKi9nzAqaai
         3yS4FXE5bUHtO4QHm2/5jRLsJeaQYEuWrG072yTTqlTKm3bDjT+O6P0yfv4djHzBoGkW
         41Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522148; x=1795126948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrgIfCS7YStc9wryNUO5eUzghFQY2XE+PPHAxJEeCS4=;
        b=glRVwnc7917RGj1C23AreDjulDEGMF1CqounHMvRNLW+RFMKMR/PAAZsqP9dhAMq0k
         qNc0TaZRZOm+k1pEfGjLOpPiOMZbhXLdMWGU9r9tA9dGUJwBNDlQLDT8ElA73Mar3Qfj
         XGnd6hIIcdObvLLm+2Bp63DYow9OlD9seXYVNw2SMNupfMVVOigokbmQ6D6WpqArmwFS
         Wb2NCU4s8EM/S8jFomuqnTjHxwrDa3RSeRMPJlKckzM0piFC+1r5CX1ulmiJD79gqEMP
         UaQ1rcfINoww/3HIwMgYj6zM8VlaZhCD1PGbet3uRNjvHP7o7ic30yq/L6v+Gta/2eKV
         uzzA==
X-Gm-Message-State: APuU4Z/9WmidrfJ9m89iFNjIx2rilZD6lnJVI5u8j/ocXenwnQ6Z7n/6
	rfkOyfyS8Jb2O/Is2lpMgLxBxf3L5BFGuNQJ+TWNz9rVDqx6XhPAKJGOJ0ROWvk4j3Lx6GxmDHV
	KCAgMEcYYxN7lodlKf4+ZYNKLjv9nRdxFyvTgS8Gw
X-Gm-Gg: AYBFou2OVIWwb8vLgermOU/Va6jy4sZLlstGOF1DG+quRHQzw8/E6r6a9wJc+GcNYrP
	JI4Ud5JlZaFOWJaICPdlh8ibOkmTsZXEu8GnO+NTULIa+knqrfUez1Jdk9l4XUr2zbjMHSLvb7M
	egi7RTrCuRjZY1I653m2JUp2+qNUkghLgQ0x2ecLHPwWz9lyvsAfJWMgC8fKJg4Q2vA7EFd26Dz
	/HJL09+QpWeKQkr9NtJIQnLKCfYyLu8bvnFgvkAN+r2Rke2WdiTm9uZ+2LCwJv3bSVAVPr57Uuu
	EeafGr2V28qMVLonGryYpkFrm/fGAHP8M6hJD33KalB+0cC1TSxsGUwzna67PZTJm9zwmED/9+1
	ORcqhlESSaLqm/qG2hN9LLj4oWZXjRzhburcc7lXBAgXeZjaifSZ+Fbg9/+AqDNbZ5fSY0QV9
X-Received: by 2002:a05:6402:a306:b0:6b5:5d24:5d90 with SMTP id
 4fb4d7f45d1cf-6b7c33b4044mr33238a12.3.1794522148143; Thu, 12 Nov 2026
 14:22:28 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112212628.265262-1-jmattson@google.com> <sashiko-outbox-211867@kernel.org>
In-Reply-To: <sashiko-outbox-211867@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 12 Nov 2026 14:22:15 -0800
X-Gm-Features: AclHuK9ee6Z7MEJHoBdy4dj0b2KNlvJa6JYEsQ4nMaHf-mKBUBV3DO4EK52PSLU
Message-ID: <CALMp9eQWBoeroBs1oXCYVH59ZX0P2kEaWxOYeLFHMN1vjPESfQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state()
 on guest SHSTK
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:32=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] KVM: nSVM: undeclared vcpu in svm_copy_vmrun_state() breaks
>   build
> --
>
> commit 11b89023661c173dccf1cc07088879a6b4ff0bef
> Author: Jim Mattson <jmattson@google.com>
>
> KVM: nSVM: Gate CET state copy in svm_copy_vmrun_state() on guest SHSTK
>
> This commit changes svm_copy_vmrun_state() to check
> guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) instead of
> kvm_cpu_cap_has(X86_FEATURE_SHSTK) before copying CET shadow stack fields=
.
>
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index f9090b601efaa..2a1c279bd54a1 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -1218,7 +1218,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *=
to_save,
> >       to_save->rip =3D from_save->rip;
> >       to_save->cpl =3D 0;
> >
> > -     if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> > +     if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK)) {
> >               to_save->s_cet  =3D from_save->s_cet;
> >               to_save->isst_addr =3D from_save->isst_addr;
> >               to_save->ssp =3D from_save->ssp;
>
> [Severity: High]
> Does this fail to build because vcpu is undeclared in
> svm_copy_vmrun_state()?  The function only takes to_save and from_save, s=
o
> its signature and callers in svm_set_nested_state(), svm_enter_smm(), and
> svm_leave_smm() need to pass vcpu as well.

I should have mentioned that the base-commit is
dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4.

Commit cd0e6f4d7cec ("KVM: SVM: Add a vCPU-aware helper to get
supported DEBUGCTL bits") changed the signature of
svm_copy_vmrun_state().

Odd that you quote me as writing:

@@ -1218,7 +1218,7 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_s=
ave,

when, in fact, I wrote:

@@ -1248,7 +1248,7 @@ void svm_copy_vmrun_state(struct kvm_vcpu *vcpu,
struct vmcb_save_area *to_save,
