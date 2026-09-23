Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FF438488
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180812; cv=pass; b=p5+jV6MPb+PNAjlV+C6bzQwJSJOU57MFlauxvOC8otR8Tl/tTGKdJLqCXUkvQ0ZXdmDrho/9RslfzPfQGvKE5Ps+LxBA5t/B7FUz4q0GagDUM9i6znAIJMp+1dNZYcUm/h9BcZ7/KZh/73wRXYy51J23b3HsB5S4zJt2zIQi5UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180812; c=relaxed/simple;
	bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+XTLjpHMpEXjpw8nN1/VihPbMtyUX9CLHBfQKBiIg6V4lBq57g5iGXc6s9naXQY8QdQjE4U9peb97tT0Gs35co25jbOwMSf24U+9PEk1uwGO3kn+O087rn36HYb/y3YCDjsZBSTJMPPaw6ihO6WdLgoVpodMK/UsPEvkv0ROHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVtM0WXT; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVtM0WXT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso14515325e9.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180809; cv=none;
        d=google.com; s=arc-20260327;
        b=aAlJBpk4YJLJQn4RC88TLZBQ38v6FvvJh8nVCLUjtxBEtI/9k2cb8+oQv8HlVnvwO+
         J9JLN8z10A/G5f7fqZX/DIN1U47p3yPmOcB3DoPnY+vN6iwpeyr1eNP1HAA7KHJ+4rH/
         aBkF67DziVs1CGHWhqvSKpjOdMWBkQDxGh2B9/t6G0e38wcBfyNKrJAxXOlk9gY0UHwv
         9OIeWbIT1djLOmw6MY17i8U0TZ/PbdrKc19+rhqZwwu76vQNHFOzIHTuz3C5kkEdfBj0
         37bcqe7TcIdLyahYP9eqpJUxuoMDE017vsgD3cWtHCPXItG0QEYHiFOV2fA8jDPhwpdg
         1t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        fh=zzJOfGRijyGYdwXOURCHJRq4oXgzRyahSmM0vYT+qOE=;
        b=s5CiNcUjrs/VimGjqEUvHTPdMdc3KbBQQE3dtXRsofYyxF/o9spMWUeuxG2yVmXMxt
         pXOiuB48Hm3l/eADFfnEC0USpQy3zF1ZHJ8UT9kufaSw8eZLkxcTFRx+HhouI75wpNcU
         NoM0mIVmfY0M/MiwZHjYS3xhas6RdI84m3E0gKmOFTt9OeroHlSVEu/3eksB85DcykoA
         m966Kxcvih4kW0kKpIPj7b0aPfmZOLc+3v4sRFJRKwHRKxoEPQ41nTeMX4k81lCVetLC
         PSVQY0gFTZNure1Bb7RHZyBid2G5RGQ0smu1XLYcqD55AlmJLSo9qBR6IDoLxAO97g4x
         4Mcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180809; x=1790785609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        b=KVtM0WXTYvLW4EAI56QD2d2oXwXIgutE1WFkbx13JgsskMlBk4Te+52MNOtq7paHrL
         1vFqQ6XrRbHucUTiPSvPOIMASzP+A8cgjFo+pRpMybfSCEmbsq4qhGENed5V3+6ry9fR
         vBOG5MHgxNHjZutlIKzzEvi9VrSfO5QwUXYZWmzrd1XrJJfNRNunYfUS4O9DdsvkwoTi
         pB60AKhF+L9FMgFev08HOOl6oZ6FlGoXroxn8peiIcDYLLZWxOrvyUK95JD03lGdQxG1
         Dz1ZqE11dve+tv1ZCh4knAlID97kXYuK/1/oq5VTvf5r7Ar66RfgIIoJuTd7kNTiIEkc
         TuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180809; x=1790785609;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nikGN8S3nY6kcpfCNAE6HAbgdnxKqm3uFGyEPxB9Fj4=;
        b=e8QgY4aK/cWh6c5KxJ54fCNcXMLX6rwAaVhUrFb0kK3jmF5sxqGCxCv+GhzeF4UJUw
         Z/bFKf1HxfQBPTolHqm1oyohvbab29JaVE6kIzU42USQXbVHwL8fOkXdyC6D+fd2ZN1t
         QHljxtLOE+PjvziLnCfydFFHmoeNIziac33QZJMukK5+0vmK4AoPZGFYm92BTcouFnnB
         KtcFs1hO1pwrxaqfNN65FD/rk7bjlbEVfmZ9LI5FPGCT2MPHtbGUY/LasbRvUVrLc9Vw
         LYWC3mXjvFgw0iz9UypiskloESueML3GWZVTlrZF67aK2IKesHqO8Wphoh1d7gD8Hyw1
         LXPQ==
X-Gm-Message-State: AFuF++lFKlEq2S50T9ZonfGPKt4NyCjSlfKDHdjs8OEEBP04XGLBcAYt
	RicSBaMSw2bEC1DtC31oxdia0ubdmRWSD11isk2Rz37wn/n0+aeRi7vsfP5VU4JjsayIUKIOyq2
	v3nogrcgcVoxFg8LEAxtuogYYO4FlsJA=
X-Gm-Gg: AYBFou0YvCDzdYAiLLBsSRWNb3NwzCXmvliOupz/LJllNqCPVj7qkJlYGOeREhzHxIg
	QU5C0E1+bFifGJnO3+tqG+wHyvQitHufwK9AfW2C6Ov1qiO0HQQUb7chnj4XUeIFmWqi01XT/X1
	9jcRRZuIjTh4rA6wXjjjEPG4E1tkanymvJCRmV0AZsTptqnIeuUKvtsjK9GZtBcMhMP/6Vhfx4k
	ZNYsxwIYPl6QqPeCGmBxpbERcymottKOGQvJQAhYnku5C+/KyZANL3FDXqbnm3848y8A2MrA0Y2
	MKqAiWd/seG6vmbwq5i/+hti85d0TZHuAvtkT9o9OlZ+0riSNpbe+fiLX5O84tuVdHvWVmE7u2m
	icr1ZZJAmGJ9IUfdxTP9Q2O4=
X-Received: by 2002:a05:600c:4fc2:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fdf25367dmr45779865e9.30.1790180808596; Wed, 23 Sep 2026
 09:26:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923095435.591542-1-kunwu.chan@gmail.com> <7efbc8e2ecbf397fc8e44327d13e9a7021b97212.camel@infradead.org>
 <CAN_Opa-tDcZOEk=Mt5MAqUTkg2as5G79uBkxkUaJif8b5QpXYQ@mail.gmail.com> <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
In-Reply-To: <1cb9c1d40f246ddbe24c9fb930d6dce16aaa25a1.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 00:26:32 +0800
X-Gm-Features: AclHuK_j1ltAz7PGSRQQV9EaBOqpc5nh8k8vCMKlTaWE_EVcZVCxLKzcJIFegA8
Message-ID: <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 12:07=E2=80=AFAM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Wed, 2026-09-23 at 23:58 +0800, KunWu Chan wrote:
> >
> > You mentioned that the SRCU read side scales a lot better and avoids
> > cacheline bouncing. If you happen to have any existing measurements of
> > the reader side, such as throughput or reader-side latency, I would be
> > very interested in seeing them. That would be useful for understanding
> > the reader-side benefit you mentioned.
> >
> > Of course, no need to rerun anything just for this. I was mainly
> > wondering whether you already had such data from the existing testing.
>
> Most of the KVM gfn-to-pfn-cache usage is per-vCPU so doesn't get much
> parallelism. The main case is interrupt delivery to Xen guests' event
> channels, and I did some benchmarking of parallel interrupt delivery.
> I'll see if I still have those results, or tell my friend to go and
> repeat some meaningful tests.

Thanks David, that would be very helpful.

The parallel interrupt delivery case sounds particularly interesting.
Please don't go to any trouble if the old results are not available.
I really appreciate you checking, and I also appreciate your friend's
help with the measurements.

Thanks again,
Kunwu
