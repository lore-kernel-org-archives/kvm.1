Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB137A485
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052328; cv=pass; b=KbWVtmhgNPOFOHJarG5hWAA5o5l+XYqT1lR9bDpQ8JRo3sb7nW0gIxyqrvdJmffHdu5La6QD94iII3rRn0f3khP4Ozmvevks7M2Fqnl6VMayPsAFfqnWmUrVaDplGHigWzOukTnCjU2AlDs+LVN7BZ4EetR45gGNEtcV0r+UY2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052328; c=relaxed/simple;
	bh=2LYAV4fuZ1tbwjOb3W9wEDiEfJb27Qf7UjQnImgDOmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0OXAycRISqd74w9nua0w7ao5HNgf3BLFcU26foYZWp8AimZ0d/BfOHAaZsUzhDICJB6PzyKGw+Mp4Oh1/Vv8G+UmcpEu2L5aLQT4GjakoymwuRVVqrrK1WKt2sp5TNEkYlpGi2X6yzMXtN0Jh6Hrc7lu+SqaQym83D0D2Krnk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Npm/XiEk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFb2tmlS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Npm/XiEk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFb2tmlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787052326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFCXkxUDJ7AjGDkUMEzgfCz0otECFPLoLo4KyaY7rCU=;
	b=Npm/XiEkyTHYtB319Bc10W3bTlDO+kDs91LLX9eziBcD1Qgrs/v5ZXl+SS2m3UKSaTp5J2
	qjPZGAHdStoe4CiLJJtNirTlbilK5Ph3J/fGCO0C8m47O9f1cAxhV+W34NLf5M7ZMLzZe2
	pbCT+ztWK61vNbqjCAzq76MuzJkFxwI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-gbNwX4N8NdiXGhmvx5J-mg-1; Tue, 18 Aug 2026 07:25:24 -0400
X-MC-Unique: gbNwX4N8NdiXGhmvx5J-mg-1
X-Mimecast-MFC-AGG-ID: gbNwX4N8NdiXGhmvx5J-mg_1787052324
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso25946285e9.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787052323; cv=none;
        d=google.com; s=arc-20260327;
        b=n424p4fOixYw7LmsBQJit2GG5Su5PXmgJXM0mjvaSlSl6KPqG+CnoFh6CXKZgeruL+
         6HD/t91xWLz8P0AhaP7Zle0TV9wTVg6V34C6lD5+CTNqov57oEk6eF2p5yyfra6PakyR
         wBkOcXG6/9GsfTc0tS4DV5q5afqIhOxsiYySVmowBvrPVBh5587qU2WlcnlGj1cXuSEw
         wEn9U2XMvoq/RNv0gS3UnmorRO1MdXozhjPvuwvxPrR8FhwnHpQ2mSChkR3LPw3XsVYj
         BOI00EEscAD8X2KLT2gPHq0KBkLaSsquItBtSBT9P+jmLsl9KWz9K8fDdg9hS5uzSdQp
         u29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NFCXkxUDJ7AjGDkUMEzgfCz0otECFPLoLo4KyaY7rCU=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=lOYQoK8aO9jWUmsntEKHTe/5UqdqjETGHXuNN/jblomswREyX2ikVtmMU6e7CSHCyp
         Jlc+ob+qtNmSckN6dnQhjVnAURmnSiFNz717N+K9qLa7GcPmGxEbfAXcBDv1nJz9Iftz
         byq7ccq5e9ARtYyRHlvKgiPcYFK+IdEqI9fA+WmF5UMztD96TtRJCRonjIx63BN/MIr2
         mKtnFHdQcevP/itdpCV49bjXRbVe6q8bBDuMJfGwvu5NX+LFOgWCEBhVTqA+78PfRzGB
         RHdHl3PGft0J1JZVUmJVK2kC76PlrmO/XUZujmj8k/yRCl8hGa7NGtw+qqpGMpCIIs2J
         a43w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787052323; x=1787657123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFCXkxUDJ7AjGDkUMEzgfCz0otECFPLoLo4KyaY7rCU=;
        b=EFb2tmlS3SIXTM50jkKW1G11Ibfb7FfQivrV4Mdtuy6QvhBodDrK3PoYpla8a/Fq87
         dqhtNStcslr08Tx7Nz+U0Lm6CJb0m+QTHhPPGw/YhVoxHARdj3Q8qOX91uyLR/NscyTK
         TuV9VQUxpEwr0OSB+Pilz95+VPBQi66PXjTlTojsSpO/3J1Y3sJamnVER2wDUJjctPXB
         Zs0ZPp6DlU6pXSI8nVPNgJXfgUr+rf0v3bzzguxdFzqgh8cVI3RGwznurKSL7gHXQhUB
         ewPMnnOyqKHCrAkRnefEWBY4LNyAp3kLdseyRKvX2HtXcmTC+kVhymeGK3rvzPjwOv+d
         t7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052323; x=1787657123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFCXkxUDJ7AjGDkUMEzgfCz0otECFPLoLo4KyaY7rCU=;
        b=BrARW4bDZEm6zg9J3qkuPucD312CMtjGiBAy+fZ52/kX2/cl8m8bVhBWo71HnbaNhw
         5TOQvdilyWql3l2Qa18NLTTr7/+kh2Diq8Danx1VC8Xer1Mi2W3vlvXmriapjKwVsT1j
         EDjfXJv6BD7wpS89Ar49zDryeRBTzf8jQXlqTpBtKqb18ZtGYnQdBtxMSrP4/y5BkqPL
         oj0VcDkB6HA1HAjuPbjXsKxbGeFi6mKvvHatOnGEkZT7ahy4K6NfQzsSpdJOv6ceGner
         0BTXwjAP+JVuRVrirlfxauQYzxPnVjFMBmTpLEsKBP/j+xIwe9FESH+Mmg/Mga3S5695
         f6Fw==
X-Gm-Message-State: AOJu0YyuYFXG3HcnmzDx7RPM8I3A7cZx2xzSHDF5EfkmfL+HbmsBKsc3
	xReWPs0mWXosvZCdmL86aoSGNSoMa4131pgZpgMveU76epXcwOocyv8Z9g/UGZBb5Pf1z5MZgWC
	Ot9tGwpLi2FJhW6oEzvC7LOhoU4eSnTX8AJ5zAVRmgJ9I1Oa+EmvmcyJoo0wF2YJR4Ka7Wwa5Lq
	cF3mH/S7lXS3NR8IkSfaVQBGkOVaA5
X-Gm-Gg: AR+sD13lKKKuOJ6mTiX6h08iOncSIhg+6yr7CQPzBDm9nchBQgcu8gM/8oVoy+EkezD
	/93JI6Gue3TqO5yclBFykj6uOOaHs3QFai4zhoC1UbZqpkjOtBpUd8e3GAV/MDh6KEQlVCEv0M+
	hk0rmF7SYkwhAa9gr2mHtXSWmnv76cg7CN6icZD82HKIy+pQgqzhKLPY6EHh1VdURLX0oq28tt7
	qc+ff+BZXTdDi7IEwTZlLCZ1hpuDJmdZIX6U4/9IwRgr92KNsnEDfH/ukg=
X-Received: by 2002:a05:600c:3b92:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4999faf5569mr136047135e9.5.1787052323591;
        Tue, 18 Aug 2026 04:25:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3b92:b0:496:c18c:f9a3 with SMTP id
 5b1f17b1804b1-4999faf5569mr136046335e9.5.1787052323306; Tue, 18 Aug 2026
 04:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <20260812213206.1564354-9-seanjc@google.com>
In-Reply-To: <20260812213206.1564354-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:25:11 +0200
X-Gm-Features: AcwNN1U1xcN_GgNm9TjcHMsSPSeVFvnNSgXTJ06Y08md_FGs9tX8iOaF544L-6c
Message-ID: <CABgObfawY=G8_p_rMyCaVONAKMqce_HQJWRSeBUi=x=KV6mM9A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: KVM: Selftests change for 7.3, part 2
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 11:32=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Selftests, part 2.  This was originally just the irq_test from David and =
Josh,
> but I piled on fixes for hardware_disable_test and pmu_counters_test that=
 rely
> on the pRNG changes/enhancements.
>
> There have been a few hiccups with linking to the VFIO selfest library, b=
ut I
> think they're all sorted out.  I.e. this should Just Work on your end.
>
> As mentioned in the cover letter, this will conflict with part 1.  Part 2=
 just
> adds syscall wrappers, i.e. keep the functional test changes from part 1,=
 but
> use the newfangled wrappers from part 2.
>
> diff --cc tools/testing/selftests/kvm/steal_time.c
> index 92e7ffcd68b7,83a1e3aa15cf..6e9cc0e34ec0
> --- tools/testing/selftests/kvm/steal_time.c
> +++ tools/testing/selftests/kvm/steal_time.c
> @@@ -553,11 -553,7 +548,11 @@@ int main(int ac, char **av
>
>                 /* Steal time from the VCPU. The steal time thread has th=
e same CPU affinity as the VCPUs. */
>                 run_delay =3D get_run_delay();
> -               pthread_create(&thread, NULL, do_steal_time, NULL);
> -               pthread_getaffinity_np(thread, sizeof(cpuset), &cpuset);
>  -              kvm_pthread_create(&thread, &attr, do_steal_time, NULL);
> ++              kvm_pthread_create(&thread, NULL, do_steal_time, NULL);
> ++              kvm_pthread_getaffinity_np(thread, sizeof(cpuset), &cpuse=
t);

kvm_pthread_getaffinity(thread, &cpuset);

I suppose.  Fixed and pulled, thanks.

Paolo

