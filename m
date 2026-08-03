Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F53B388B
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746156; cv=pass; b=ZsHodw2rsKocNw8LZlRKbBYY+CREE11IzpesJGegHbMQrVnYrvKe+nhX9Q4Q+2XkFpMhJDFXAh9/wMTNwnmbR5/b7B4NCuUGBAowWse+Xx2zlxJvMxro5rr7SoqwhO9K4tOF86OI5MDzoPyhoq+Akx6vuJfiZJ4dMJjatxOjLXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746156; c=relaxed/simple;
	bh=u10O9NC/rij3glHz/EjjuZT5qI3hBkn9PYPtapLT1U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msPvqMRAZ6tB9u9/p3YnPnEbLrfAKpkLuLpCKQhMR/Zjw2pJVuIfSwD92Y3GeDE9rwGbzpYNjlTLPqQvbidf9wnpGi4PY/0fECyTykZfrTuSDpbYHWFtRGBYNThFZp6ofy2lSaxtqK/wDzCCM1CbN1r6e9q7sbHsF08TWyLAQPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=uTwSIuId; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="uTwSIuId"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so14354215e9.1
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 01:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785746153; cv=none;
        d=google.com; s=arc-20260327;
        b=Cq8MfUunWYPczLzACieivZcWyYQd4Bwk6EFRhOaB7kd3lcZQeNaSLMn7OQ3QAKEcrK
         5dDCf7axs9MgTobCRyZ62UEf7RWM9dU+X+wDYOd+62pYTVwv0aMV/3Zo+O3RvdwOWFgq
         X/l3qfWfYsGzaFT1wzy5TAmMjvVbDT66f/0lmGke8nqmRrI1NQU+0xzJIVWnps0/iJ/W
         salNF1CFpBaj2W42uv/aQGPfOc5+YKAhyAvYDCIPTQZtZ1XWVqOwBmUipMHw6QelWIre
         rtceHhSNbuP1KVZXkV3bw8K3YVSnRJrEaRI1uO2Bb4TcSDzlzO+IcKQuAoHIvb3t41Bj
         LpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2b3sh69xdSzjSrfH8s+FeaJsrsV8d8F8OUjAmV+ubp4=;
        fh=KCN+lvE1GRsTEZndfPRrDzotBR0IQ/Ql0f5ARgT4QCI=;
        b=R8cPTocDug0oAKZc+yfNnjjxVZvBRY0LMEDUQQ++OSJ5mN0gC/aJY8voeCcTTHP6a8
         aGTv54W+0zI+EOuVz1ABaU27XmAlgCK0rbR7GVuILjyh4d8hUCPPhBW1uDrlLXCp1DDV
         s05RpUcNxHSCl5TiDHcvHqcKydJrY5OQaivWAJo+67BKm0UfJs1TrrXNUoZsqQIpIORq
         CYyuhCML4SJZsqnoaAKe9ppOhhk+SBF8voMxZXCMuyYJiipm2ySubNHOTdXPiOz+QpCK
         lYL4VM6yMeWZc55ojmHHGOVlLZ51pzkd5yhgVzbHx+P524tlDOHsjpEyAd7285qipUK8
         xvzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1785746153; x=1786350953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2b3sh69xdSzjSrfH8s+FeaJsrsV8d8F8OUjAmV+ubp4=;
        b=uTwSIuIdakG8YTJCOj0XX7F1lQ9MtIaitn4V7aKau/w12DWWMUennpEdv/VsFNCXLS
         s7HmgYefmIbD97qNkoaccbH7HgVo93tCbTsD0AJU++K+UdCybURuN0mhvTfkkB/R7VTz
         fpcYgRfeyOxSbyL5wUQrQPcOjSswSCXA3F71qfjhWNzw1TZlR0otKARqc7XsoD/bBdCk
         2tk98XpYN528FItui80zOAZe1znoLHHfxeGIQsyE6fQgPIn/Z/ITd2nuiT4AM0Cdp4Ul
         bRrOPkyKcfBtJuFOgLcYvqX6SwR0L//QVDymIWl0pPEKwVjPEXEcTACFAidmFkNvW9PC
         UM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785746153; x=1786350953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2b3sh69xdSzjSrfH8s+FeaJsrsV8d8F8OUjAmV+ubp4=;
        b=F5Z2dbdY/IU+bgQXeZH+rlyqK5kUEIDtH187HlI+KncCwD2qLUhxbYWHl1+Fng547l
         l2QEoxt6LNWeLa1lb6XerGqtCfhsWDK66qhpwUxjo9v3922W//YxcG7p9wz25zwvGQC2
         37dP8RuxUlrBSSODDPf44wSFEOyrF26fNqd2CkTaUAn3iGD5dDQOA4QD4eRcQJoUO4S3
         2n35KDX2ykUWZTn7/FHXZwpv5sSVzDV/QmJgTMqcr/mo3RHA3bwYLnFsEBqyS1/zNnTe
         rJuw5ypHouh5cf7Mp5vYlMXM/zXxdGqI/+IVEr5LkOAu1qEfVgps9LQqLsbocQTft9M/
         9/Nw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4GvTFe1ub4nmBx4wBmpht4s5xfs5HMAE7zku96KfwhwWQ8CIHXdL0xC7lXSlRIu6yVzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZW87Q4N5rAztma4MqPdji0jGkdUV2gC0wjxCcwcrfCRdMEwV5
	FOEOva5EddRJD4/pT3ME4JDZmHx7rllSzXt0qcDYZ8I6In4ow4ikf8hqRH5GLsD2Vqu3LAa9PSb
	40hKdP45AABFagtN2OHQfXp7haMe/AfUFajeR612GFw==
X-Gm-Gg: AR+sD12Z50CFX/E10NJUFYF/YhiP5BEE+SVbrbZW5bbM7V5RUB1kJz0uqfWbveWWdv5
	fflUK3ZmmCiVijlwlPpmYYwA/Y9g5npFE+/3u8nU3H2f6iz3EilAg8+vpJbD2/HAz3Fx8Yx52qG
	/q3i6/SmbRjOxARfIWSGI0Ohw3RJvDAq5vhqqEOicolHydFHjAkvASD5pkz1F5F+c3BLZuhDOQO
	2c2hwY8ibqNbPCJ5xNIv4erjzSQeaAR08rruGYV9Crit8vVTCV9PiOV+/mgLyPGetYFdZJR+jsC
	hm7wg8ArVOIWRt1YdU7wJcKof/0gn/k4cl8L2Bv64P8yDYTWJQjR8QvCQ5U9nlLiFIoQmM1w+kH
	3s7/7gOkHDmWiuVM08JJS7MGIr8AM3ZbMvAMPd5HhKl0eoF1pACgx16WIeqcnLd4=
X-Received: by 2002:a05:600d:8653:20b0:495:636b:e50b with SMTP id
 5b1f17b1804b1-4980eb9f521mr148832365e9.6.1785746152670; Mon, 03 Aug 2026
 01:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731173842.2649391-1-seanjc@google.com> <20260731173842.2649391-6-seanjc@google.com>
In-Reply-To: <20260731173842.2649391-6-seanjc@google.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 3 Aug 2026 14:05:40 +0530
X-Gm-Features: AUfX_mw3p99BYxmA7OwCpgt-JkGQWwjbawqg_zxESY20IalJO5o-DK48K02q5og
Message-ID: <CAAhSdy1t8GSY03vGO7xp8sSDMgjYSDfszt1L3DkWi1Gon0bMKw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in
 the main KVM entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:08=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Add myself as a reviewer for overall KVM, as I have been helping shepherd
> a decent chunk of the virt/kvm commits into the kernel over the last few
> years, and I expect to continue doing so.  Of the 270 non-merge commits
> that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
> and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
> coming from non-KVM folks, e.g. from treewide changes.
>
> Note, this intended to purely be an efficiency and quality of life
> improvement, for both contributors and myself.  There is no implied right
> of succession or anything of the sort.
>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oupton@kernel.org>
> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
