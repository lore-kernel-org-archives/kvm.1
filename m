Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECA55198F
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086848; cv=pass; b=gRLRKnCAwFPC0/GJ7jBHGlCHUwU1ozv3TseJlj12hsMwYW3J67s9u0ohxOFBVkToyXAF2Yt83INLC2bEO0jWzMZSRusB3eVoO5ZlaONnmG0JOcnPiIuhktx11BoSCQPDdr5hb7j+GGJ8Up5TfXhQze0U3QHaBby5dwsbQtkEBU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086848; c=relaxed/simple;
	bh=HxcTZBxIHlFg8VjYKTjraINQ4dfq1xbF20OsB84LKI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0nMGw1J9h8i3+2XIvz2QJ+FMYov4wwwppU10zOUur4u5KUX08PJAU+S8KAEDorZnD1cwOytobW/aukloCibKxTkdqQNAzLxZb3kUWOw7VUM+PiQR1ZSYwdA6/Aw6lmIBdtEkQEW1IDRoU7oXEGMHqdcyqfWiPwFaXMOox+Iu0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1KoOpR5; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1KoOpR5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53113d72966so286871cf.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 07:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790086843; cv=none;
        d=google.com; s=arc-20260327;
        b=i6bqbtaI029cnNJ/Gyjcg0oToTXHVe2EgsRwiNZQwnCFeIi/UG5JPyopMGxRosKf/U
         PJceR+vkGLSGlQMfi1u7lBz0MO6PX+uxZrflp+PPtilFVAXeUnQ1XFqu7ATaEFVe/dKL
         kz/PiF3NhSjWA/lsQSTO2zUFZ3sqhqm+VNF/MmlWz+5+FE9blW+OVPPgcS+6NQbNJwSK
         Bxp0QcXiPjkiET2FB4rFUxz49N4rT5bnk9z0iYHi8c1e2CWGyP+Mt7m6/29UOjf7YvWx
         WYDP8PDbsUR5NCZtDwV9LwRoun9R1yS939j+owksBLpa+lz8kjOwblgT8TsFQWj/1ZZA
         urTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7rTxuINz/tlh04A8Ubhtgy8qNqbLXxKs+YLLNkF7A1Q=;
        fh=weOj4SKLQxKnarPNK8uuolkvEsed/cL611AYXq5r1Ik=;
        b=k7BISa4AV5t1cRwGHtxlkCHeRFhnJdDLY7uT6ipUf7S28CQa34be87Mrww+1LpGsK9
         fARd7SYC7LnhpEqNTap8QORRsxaWLHy2f1ahjYPN8aOIJlNOvLB2x8VAacBSAR4lHGiT
         GY+xr7j1ckFd/fmJvu7EzsbwrFabI4UJmAOkGfkPSkiOywFCwj4mTXRGl4PsCMoKbg7/
         p3yiLxuExPSppThPUq9Knag992g7FUQfBKZo0ImtX/BbV6CkUTGRYSXrzWPrU3hqopLq
         wQWBUZazcF72n6/UBfP4IgHbSAGB6njpdnSM8xht74inK9fTftLE7fCAiRrIVIcy8BkS
         fefQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790086843; x=1790691643; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7rTxuINz/tlh04A8Ubhtgy8qNqbLXxKs+YLLNkF7A1Q=;
        b=e1KoOpR5ZJwSfd856hXAJLPpQC2V+VM9yxjF2XXfMNRsdGBd8usaQIep83nfXVjQSs
         lOoZT+aZBJZG9bJi9d1uOAEtY6qwYLdB4Lce+hcayraCIS3QtY1kjCkqYJFIi+nRZEXc
         vDxSFdGVFNz8Kupqhz2kHVuMD60g4b1vOaahVbtoaS0oIVU2qtZBSTIMP2E0FdzsjcWB
         /yb225mYESQo49wVb8uRYul8q418Fapm/VAaKQIF1IL2xE5AZwD6gnN5CwQpmwWj2pJx
         yiVCvPfoewCRmWfzsMI9j9nD/WRl0OM2nnzgIYPQwVpGo+JampyzPBGp6r2Fz/v5w1XU
         kqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790086843; x=1790691643;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rTxuINz/tlh04A8Ubhtgy8qNqbLXxKs+YLLNkF7A1Q=;
        b=PFgCx1wAdWCi6knazjCR3mSpFYku2QBv4BFZy32UXXjvWk0Ftr4+EAKDTQriMKltpV
         H2KeQL56gVBVivtpnBqiatnenyf/tw04GSWNUD6/6QmKJbU6PYhA7n95NCPJJDT8ie5K
         YKGlTuQVyfofy5i7lcHCKgY15uSpF2yziMyb0vILKcrdSXMgVYEYNl/0LKHfnB2JAmpG
         CDo1iISlBoGndjrKA9PXhH9SKS1pobEJjN1PRrQ5AIW3QYb3Ts6o3E77E4iGcYpj1lZ/
         K4UXe1Q4fLR/BQrrh+kU891uTkyU9RoZ7SFJFq10Uq0+bfe0HLlJINAbuCq/ulM+RBGo
         g7JA==
X-Forwarded-Encrypted: i=1; AKwUvBzyRYjYot+rdZMalG2j8G3FnzwQz0NIH+sGlrwY4bgxi6F+Hsq8Oc0e6AShi88K/3YPBT4=@vger.kernel.org
X-Gm-Message-State: AFuF++km02WSa0KkLy+jj/KmKu2VWC1ZnQmJRNN+PXf/U4OKBqTPUnwR
	DOslVRaZUNPBR9XkPUcaXJDnDCBB0+aTTQLQPu0+vOwWsoRcaV4Cr7ruySRKQZ2Mpj9jRH/1Ta6
	oLZBI3F5DQVzERmLgghUXTD1c7KTQP+RTR6kzHmFJ
X-Gm-Gg: AYBFou1EJgSa43jFhT1ZhyAX466rkOdKjO8oRyIzmA5m20CEi0zv5xenjCGBZMYkecB
	EJR5Hvb500rech2pvNmwiMTrM9VgWMgByEdGH8SCv/ScSUHd4CPn1Qqf9b6p4jxSzd+LW+6FBjS
	a6oqnvApVf533d3xJDLYVarLfOVAeC6InFp7CtV38UKB4kGCoRcmGP938rzLZ5HJharFIVpB1n+
	tJnAuYwMVjBv/mbykWUS4dD//w+V9DL7r1O8uYseFfefiSg9K6pCDjOig1Wq6EErAaG2Gp8EQQf
	S4pv1QIyQOMpAsOPJgLPcTrZy89v/XTcFbpiX/nhhnCWu4OrqQgpAKc=
X-Received: by 2002:a05:622a:a16:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-532e864756fmr2029421cf.12.1790086842237; Tue, 22 Sep 2026
 07:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com>
In-Reply-To: <arKJQwAPvApkeESD@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 22 Sep 2026 07:20:28 -0700
X-Gm-Features: AcwNN1UNSpjbx9ZFSib4LbupARY2BAqtFx868cZm8um8dHez9pT9JspsNfZWaLQ
Message-ID: <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> Gah, I hate the negative "feature" bits, I've gotten completely turned ar=
ound
> multiple times trying to sort through this.

Me too!

> IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_MBZ=3D0, =
but userspace
> configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko is right,=
 it needs to
> be declared with EMULATED_F().  I would even argue that technically this =
isn't a KVM
> bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPORTED_CPUI=
D on such
> hosts.

I'm trying to make it possible to run a Rome vCPU on Milan or later.

SInce this is a negative feature bit, it must be retained if the host
reports it. That blocks running a Rome vCPU on Milan or later.
However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be run
on Milan and later.

It's the same feature-hiding we do all of the time=E2=80=94just inverted.
