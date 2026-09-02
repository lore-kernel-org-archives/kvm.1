Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176D328B7B
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336604; cv=pass; b=dM7xgk93jfAtnNiD1zuBk+1Pf2JkO93PlpbOR1As3kRA5DfqKcXcJUtafmJgs3PrgJ04DzivL8GdkBng6yy/FdrVP18CGu1tlNP+3E/lFT785HcrbsIpl75mgjBfw1+llMhOvaAND3qhnzVnzfXdwFFbxGIHgqmTQmF3aQ2mm1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336604; c=relaxed/simple;
	bh=5z86ueeNESYqfuth+YiV/HHpOtts6JADyXguWkuV26I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeBVkEb3PHM4VO2gKW9/0yHOwlH5FXFdzyg/UjvvBmR+9HpJX0kbsxpuNUJ+gwIQ1E4mwonbUo9P3j8mBPfrMgra/AxzFHYCpkkGQZDe8X/Sc09glrT+i39K01EzrknEsPWnvpfRHQQ/tlWYtn4vHRRKrOXofQwuD+Gvgn6H8QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHcSzQ1z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJ2ogMSa; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHcSzQ1z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJ2ogMSa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788336601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOQfWI0DUWitu/auVtgTnyIa1BBzfCkSmPwoZvzPzN0=;
	b=HHcSzQ1zN10Ay2PCEqKRqmi33e8vXQSi5SU3nkeFXeoZIjaOO2HLlUvElxvz0xLj2ve+QW
	vKl+OsdO7McKAykwSDzDB0UGPckkYebp2mf9kxC6Fmj09cJeRb1mZHOdfgDdKdLwXnD2as
	n94FWYj1ih+0ME0CCgLzIzx3NB3K3Ug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-TIVynKamNa-lkKREh5XSAQ-1; Wed, 02 Sept 2026 04:10:00 -0400
X-MC-Unique: TIVynKamNa-lkKREh5XSAQ-1
X-Mimecast-MFC-AGG-ID: TIVynKamNa-lkKREh5XSAQ_1788336599
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso3979885e9.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 01:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788336599; cv=none;
        d=google.com; s=arc-20260327;
        b=gdlp3Iyv/PVbmTynM71I2S2NF0u3XMEa+7HqMWDyAsa0UTam8WeupscvmRX14StkF+
         R136WSMypTKDj1Nz7sEJBoAcMbRZG3xlyEWW/dO2gn8AIXR1NC5OY1t8UKeBEn6ff5j/
         lATOTZ6+sobEKs64Ai5LxmdoW4ARyiXHt7u1JBtqS3p3+IJg2mAeMt0hYkxjwZZMdzMn
         fws6C5vGM5HuM/gUPQfDl/ldDiR7g2IBo9pp2r+JY64DnuzBhNHnfiAWOyl1Hg6ZN23y
         9qfOIGsJyw4Sf9uYmEc5OvTHFco672xnBPlFXThNP7b5QVTUKnf8KErpJ6W2pzqTzpHF
         W1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOQfWI0DUWitu/auVtgTnyIa1BBzfCkSmPwoZvzPzN0=;
        fh=hrt8b5hA7Yw03rFISyJi+0RuKd1R8PEnsV3AOGowTfU=;
        b=kGKEWS2hrx8HUulg+8upb3XQTVD8qRwCLSspIsXVWUdlBaJgsvOiHh4KZDnwmfJFp2
         B/0/avte1rTdwTZose+Z7n6Wd8btNLRLR6sSfKbKnEk7ZykmGL3E17D/yBwBxjTZfEE9
         PcfxvFQ2zIDJyPcrMdWHradFMAMGz3Wpe0BavQEERSg0E0uHBXzCDCpJVv/sQzUZ/Y6x
         4svvXTdP0ZfESz4Nmp3zNy48N7F5EQm5P0Xyq9MK7Hk0gTymfXhstWwIZLL/KU3K4Lm3
         MTyS2BZ4kRZQYXvrIQACFZPPbg6jIj58OvK7uyAbarXygxv5W2Rh9jMzn8rLe7gsAXE8
         VZrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788336599; x=1788941399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOQfWI0DUWitu/auVtgTnyIa1BBzfCkSmPwoZvzPzN0=;
        b=LJ2ogMSaTCi/L19pqdgyiIiRnBQTev2CUjtN0KoKohSGtIBRlvU8jwaqRN9zxlIzvM
         yrUZEJMXOER5F5mqLYwGl/4UV8QwPcv13IvkS7XLB9lrc7G+5essC9kFP4Kvta7SAHhH
         86O8APUi8c9uOSjd39sGiE6mQ51HyiXsnMmP6qqFqI9Q2ZdkCkrAEaG9hO7bdgc/iiPx
         cQVQYjv5RccGNbaiUs8vmjzWN1mCYqrNIwn3O+yaJGZuBqhI+r1ckTp1K5X9PKAuIUov
         gvKli2RF4IURufV4UkI/GJ5RAm18UAw3H/ZlaNJPi5SDsNdURQaAttHQanadNPR/wEXY
         uJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336599; x=1788941399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOQfWI0DUWitu/auVtgTnyIa1BBzfCkSmPwoZvzPzN0=;
        b=KeNJMzttuX5Knm05LjVxaE3uNcQ0syKLvYRzi6+C3dJ4Skn98V+SLsF5tW4wHc1Dod
         CMcVfcBK1fW/38OtFxrMj9uGjaDj2DtY768D7Ldf5Dm/eQfLkm/5455kFsZllA0zbVS1
         8HGNCh7Y+hBMZxc3iFSiCs93FKuWcDTTxXm18CN+5kXQTi6vofAUCDIDuqGJBB1tPa3Q
         uZVXx60yRCBfxgOGiL0p5G2scao1sizjWy2nWlLKpHEyz2c2xM2aROYZyDj0R0MXrWoJ
         UJWYlnZ4CJr1brNJr5WFbgfuzkSh+RiuLFZEiNNS3PNRc/LdyQ7obhDcVvrfRCiQWZky
         O8rg==
X-Forwarded-Encrypted: i=1; AHgh+RqIP36i59Aipg9Wl7BnSLRXaYk73nWE7lD+DdDsguEQgfg4IfTA5q+/xV8CLfmyjx3f2jI=@vger.kernel.org
X-Gm-Message-State: AFuF++nvLBgGgtCdP72BDaauzsnKpwttWtbEu8NzeEpdrgM+1JgwULOI
	fStidCi5qLzjBM7UWrpSDECMcHiBq4T79jL2EYjDdaKokD2TpNuDnMekR0RxtUH7uoDua7Poj/Q
	DuEmC6FnQ5kk8WTFRsKCWy8GSDOMACfRjXVix7irbMpefDSMgiuOwd7GwGgXl4RTPkr9ij6KIoX
	/Ja7yxyfUvCPb0VGf8xnlqDtDMQ9El
X-Gm-Gg: AR+sD10sw+6TQcjFUFPNBwsImYVYBCOS6fkuv9o0gH2LUjqjII7RHcuCTeTd4KS0XMH
	egw4+3VF/SYXH1ki8cslUNRH3uZ26VMyp6IyAMthj1aUj1jLQ9qC14hsQrmBUH3w6EPV6rYMsPR
	KdvWLJqGo8MUUFSx5LT6asz7gqv3hamtwP+DYU/LBDdxB8HqZ4epoA9G6el8emyUgGfxLzHHX/t
	5zmho1x4xt3lnVrbAmLqi+SZeXoG5bwxv5/2Ib1NmKYAM3uqQUMy6AOda4e
X-Received: by 2002:a05:600c:56c7:b0:49c:dd28:ae35 with SMTP id 5b1f17b1804b1-49ce7b683aamr17744985e9.0.1788336598820;
        Wed, 02 Sep 2026 01:09:58 -0700 (PDT)
X-Received: by 2002:a05:600c:56c7:b0:49c:dd28:ae35 with SMTP id
 5b1f17b1804b1-49ce7b683aamr17744215e9.0.1788336598364; Wed, 02 Sep 2026
 01:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
 <apIf7eoMxdfV_7kE@google.com> <apYh4GDHD3Tdb8t4@google.com>
In-Reply-To: <apYh4GDHD3Tdb8t4@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 2 Sep 2026 10:09:46 +0200
X-Gm-Features: AcwNN1VEAGaQ7avbGtUDsE5-7MnLmxEhvllpLnTrXyA2AmjL1qyKVGRto5Xyyx8
Message-ID: <CABgObfZ_cOZiWAu++onwj90LbcQtVthvKTMOWZQ-yyfQ2sSiuA@mail.gmail.com>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in vmx.c
To: Sean Christopherson <seanjc@google.com>
Cc: Jean-Christophe Guillain <jean-christophe@guillain.net>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:52=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> So, rather than trying to come up with a scheme that is performant withou=
t being
> too complex, I'm planning on fixing this by simply holding kvm->lock for =
the entire
> duration of vCPU creation, so that KVM doesn't need to do extra tracking =
and can
> instead rely purely on the array of online vCPUs.  Then we can revert 97d=
65b544f48
> and do more cleanups on top.

Yeah considering kvm->lock is taken outside vcpu->mutex there's no
reason for all the complication. Thanks for doing the archaeological
work.

Paolo

