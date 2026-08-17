Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706743E9584
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005492; cv=none; b=YxsZcR65f1dgCFP9QRBPrWcFMvt33gQ/bariNGU5GJKKnkPQljRHQ3wiqF2729B96VVtRqc0XNLMhf+oeMwgC6Zh4/G1qOY9/EcrXfZ2pefwEd6ixYOdRyjm7D9hIP9KG2pnrAFDRtxG2W3E9Nq8lqguohdvr0Xtbd3ijAnUu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005492; c=relaxed/simple;
	bh=d9LhXpnY6UtXvjqVCNv3ykiw7EdflqUxoMYWCThIQyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BSLZ3dsn3vld99hTwrOTbwNJmwK9tqgCNbUgAyXoNa3kQaHB5ryA50qn28/VXwaJZPKd9OlrvD3hrgJvk+bYOKkDFIY27E3jbhQL/g8jEv9JI7FsEgX0hVVuCH5j7c6EBYu6tFWouF+jnAtCMXJzY2LjMGHZ8ogEZUchJg5UGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXGIEQm3; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXGIEQm3"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso4406900a91.1
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787005491; x=1787610291; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCgiatqMkEQJ9JsWA1Fu0ZG6UKepMYZLO5k8sAdfDUI=;
        b=PXGIEQm3V+Ky4syIw8FD46X79anXF20ZMOC2vaYfmWV6kS0kyHTNOGOgNjWAD9mO9Q
         0GiqT/ZtP8cYiBX2DzgBXimNzmd3hBhSaGfiSpCpAHejYu/4nkAQV6x/OtTcqUL2hSEK
         i82xhgMbjjNBkxXefu66f15RZmTVLn6/D0TSFaHgJpR4K7dRsV7ml3PQ2Mr/olPdmw7y
         GXdl/b5orotT5gz9R2y9ypK0Umx4AB+jiIFZ+C2YSFObI3/f+R2sgE1HzGAWIKCTNOjR
         hNgekVa/xq5Sw3DjpJL8WE8i7Jno+Sg1MNf6WhsrgN8qqyPpI1YXP3KizM/XJXpw1RMM
         dIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005491; x=1787610291;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LCgiatqMkEQJ9JsWA1Fu0ZG6UKepMYZLO5k8sAdfDUI=;
        b=D3OLhtqYMRRnaHF+Qc7naTaX+GlcbCjy2zJFsij5F9i5/Fms/4snKVdImdRNHGG1G2
         3Ia5KJqScCK+sFrCu9urnCN3Nz1ob4E1GijPGpCWGrNyPCKtVqXjwFRYd/kyhUhHiTv4
         TwE9reYX+eS6QP0OQ62l/3l34GKYtfpXvqrZDIWCNBraXWxMN5JJhl5Xcewu5jhdvpX1
         dbsIGrrivBVPDdkbJIzni/U5Qb5jrqMlYn6D9bKarcjZQVj1o+dvPhGSqZDj80XNa875
         cfIKqGsfUS24QDflke2hDgm04a+sp3V/rxSR54zX5hoCwt3D2JOsddPfSZ/JJAtT51XZ
         tytA==
X-Gm-Message-State: AOJu0YxSeEtFsOjQDSDPIBxpLyIT6BO842ywNXjw4nzrPc2pIvr0w7br
	zbWqdlVka5ozRo8dOr+cGwCAxBdAKWwgKQLGxrUUHfhg9vuqnedAHV7HnUoBFuMe1wrMzhJzASG
	ON9hhdA==
X-Received: from pjbdw4.prod.google.com ([2002:a17:90b:944:b0:38d:ed16:8b30])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3843:b0:36d:9e0b:3801
 with SMTP id 98e67ed59e1d1-3955a5ee17cmr3105430a91.8.1787005490535; Mon, 17
 Aug 2026 15:24:50 -0700 (PDT)
Date: Mon, 17 Aug 2026 15:24:49 -0700
In-Reply-To: <20260817220457.554823-3-hisamshar@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803170825.925561-4-hisamshar@gmail.com> <20260817220457.554823-3-hisamshar@gmail.com>
Message-ID: <aoOKMeua-cNeTxXT@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
From: Sean Christopherson <seanjc@google.com>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Hisam Mehboob wrote:
> Gentle ping on this patch; it has been on the list since Aug 3 without
> any comments.

Patience, please.  This is on my list of things to grab for 7.4.  You posted right
at the end of a cycle, shortly before the merge window, and the code in question
has existed for years, i.e. it didn't seem urgent enough to squeeze into 7.3.

If this is the very last thing needed to unblock musl builds of KVM selftests,
than that changes things, but IIRC there are other "fix selftests builds with musl"
patches floating around.

> The musl build failure it fixes is still present in current trees, and
> the v1 feedback was addressed in this version. Could it be queued in
> kvm-next?
> 
> Thanks,
> Hisam
