Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BB3C0A1A
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822897; cv=none; b=Y69wRJBCCUTYfgAN8v37Xe6hml357roVeRPR0J21oQ0GDfIbXWJsv1+oT0H8bxdakNrcVE5JOkq962uSeRGkduw48WtzJHSO1BcQNrxa2q1oXEbY4Vl18GTlhE0iQd0c9h8nyqwPjb6vIrqWWPzHIGb19m7iael5qiDYm0f7xcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822897; c=relaxed/simple;
	bh=dKF8dhPCpCOpz8wBx+QwX3wSntBAN0hT0/ziOW11cl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0rUKXqZ8rOZIvnsxg4tuqcxqv9kDtSiJL1+VoGWbDnJGZc4KqVRmfuXRuxiNE55v2NNGq4nyECxyLizbrQVpnf47T9HWei+QrNwzTQMyLfeJlRo057pU5osHAnb+WZQSmEUNz+9k86jc8yv3vb/ZVYmGo2rIHv5EuzvDaJjQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9Hb7E4l; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9Hb7E4l"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4678c6171so119286765ad.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779822895; x=1780427695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwn3Zsnn2yuB32x6MdgS3rMVrimBb61d0On2s1kwTYc=;
        b=I9Hb7E4lnhBMLAh1Pki01RhJmumzGYygpjyotfQp2ooYKEzn2bkrKeW6GW8jsVhSCd
         fY1iLviXPW8ZJWeew0X//IjjeKqUOixtntA5f2xEy3eQcKI9PJUHgJ9omIZRrbs8NV3S
         VEfe3Os5STDzzP9F+fkE+8HWieNHvSSkQo0mmpMpRzFZMqjHrEgKYd8NkovLs/KOjutq
         goBKMkThQKgZiV92ltTHEZIAe+LNEZpaxKE27pJR24UBB/fr/YFsdZzvmk2hAzMdRMKE
         qsToqPmyJzJziBtK1I9Txfi7gFzZbeWiniOF94SDcwY2QsL7FhYIkTol+XtYGDqNl6r+
         K8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779822895; x=1780427695;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwn3Zsnn2yuB32x6MdgS3rMVrimBb61d0On2s1kwTYc=;
        b=HW6ruSBgL/FkDbp61KtobIamlj9zRD9jZE0Xb6fU90NNzXXkUVhx+2645gT9BNuWSj
         PEh8yxhji1DWv9zAli2FF9/5oRLCUqm58tx0PNG3gyXO5Al/BSUVLLM3+YDH72R3FI+e
         O09D4AdflBir4kc70J8e4eRvlsX6VqgrHuPy+egTgcqpsUSjZTmYw8QdR8aqCs5qMirc
         zPlVrpi8ar0IqVCqfVreJZqVPsysD5SHc9xIkgy40SFs5orL7sNriT779S7Ar2v4J5xt
         LyI5+ME5TcDgqZzlcHPTnwtd3rVXHVR6otzwcPsrTOzvFZncAJXmTFFA9WhVqGD1KLiz
         6akg==
X-Gm-Message-State: AOJu0YywdGVujr2D6n8CLpRj8KcEQWXDe3AUnzO18NoaUZtagmia8eKz
	n7SNOvKQYspwjnY0HKaqZictWLtUr2vS+UkBC8eJFKjY7b4iRWw9bOX0LhU8On9oGMbxacm7vaU
	nvdXa1g==
X-Received: from plec21.prod.google.com ([2002:a17:902:f315:b0:2bc:ae06:63a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b84:b0:2bc:db35:96c7
 with SMTP id d9443c01a7336-2beb07ed803mr208583365ad.28.1779822895127; Tue, 26
 May 2026 12:14:55 -0700 (PDT)
Date: Tue, 26 May 2026 12:14:54 -0700
In-Reply-To: <b4dd2e22-2364-40ed-a06f-4082adb309d1.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ahBScosf2jUlKdAt@google.com> <b4dd2e22-2364-40ed-a06f-4082adb309d1.zhang_wei@open-hieco.net>
Message-ID: <ahXxLup2MZkyli1W@google.com>
Subject: Re: [PATCH] KVM: SVM: Disable AVIC IPI virtualization on Hygon Family
 18h (erratum #1235)
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?5byg5beN?=" <zhang_wei@open-hieco.net>
Cc: kvm <kvm@vger.kernel.org>, pbonzini <pbonzini@redhat.com>, 
	mlevitsk <mlevitsk@redhat.com>, naveen <naveen@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026, =E5=BC=A0=E5=B7=8D wrote:
> On Fri, May 22, 2026, Sean Christopherson wrote:
> > IIUC, family 18h is carved out entirely for Hygon, correct?  I.e.
> > there's no risk of disabling IPI virtualization on unaffected AMD CPUs?
>=20
> Yes, that is my understanding.
>=20
> The original Hygon enablement [1] uses Family 18h together with the
> HygonGenuine vendor ID to distinguish Hygon Dhyana from AMD Family 17h,
> and explicitly states that only Hygon is expected to use Family 18h.  So
> this should not affect unaffected AMD CPUs.
>=20
> I can add an X86_VENDOR_HYGON check too if you prefer making the
> dependency explicit.

No need, I just wanted to double check.  And this is already in Linus' tree=
,
commit 9a12fa5213cf ("KVM: SVM: Disable AVIC IPI virtualization on Hygon Fa=
mily
18h (erratum #1235)"), so what I would have preferred is irrelevant :-)

Thanks for the follow-up!
