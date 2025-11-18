Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E831327A
	for <kvm@vger.kernel.org>; Tue, 18 Nov 2025 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508507; cv=none; b=uGOOIbjzR3fJA3hVbXAYi49jqUoEKFRkaIPuG6CKEWhVJKBRZbo3wby12OgKDy4LBcjoXW6csy5gN44ROpCM9k7W+Ah9UQ1bMr2ILZBBlYhv++yo6SRQXRup5odjlZiot7ein1xL2gWlZOzg9qFh8KhQdrQu+eE5l9q4bDUgNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508507; c=relaxed/simple;
	bh=RKdmMC42/iIVW4UaIPvvt7Lznoqyt8RCKocFexndvlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G9Fqbq64Ltpg3EOpi6H5rxnK7hJbV1VMwfFcjRkNiGyB7wjD5JGtphOl+1dvuCScX9P9nrP7SpnIr7PGq8gFc2hhZdo1O3Qtx/ubI03t6KSA3UgWDrCoafICKCodexaRB4CZYxCsMvFUjkbKYjRLbZlAvkzF31ENZHWr5Oy6YMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tsiYycA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tsiYycA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29846a9efa5so162411645ad.0
        for <kvm@vger.kernel.org>; Tue, 18 Nov 2025 15:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763508504; x=1764113304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDLwWg9J1rvmjJToyLqj0Znttc1W1NHhLEmVjPp5KVk=;
        b=2tsiYycAEdq7/qodl+/DbeIFb+mxEbHXDxtBaScQdo6Nydy/cDVfpv2fmB9qMw/F6A
         BRJgmks8mYOAQRI+0N7fS59qC+J1SnZLXnjgv2g5e9Kpok5qhlrT1vrL/3FvN99NMR99
         uN6C43eIEiNutsaczjjIob3Coaq85RGZBu7c5KKpKPv8ZNOQaEjZX1KA11/D9PjhvbLK
         wQSjod7uuGmEChD+xgY5X6WUdaQCEQG7+kPpRvcxg0/geeDT3VgLMh6hsbBzLpzCHYyr
         KFRZ4HCqphcAI/qvz+Dc+KDXWGdjZQjQz9o793wTSREAcrrS/EuTbeozhz6nmw+Z020R
         Kkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763508504; x=1764113304;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDLwWg9J1rvmjJToyLqj0Znttc1W1NHhLEmVjPp5KVk=;
        b=MDMf6J30d5hlGeuUzud1tFD7pWQFInRDNZz0N/RQNZ8H13sPLerp1r0exQkAlBdt1V
         2v+V92ShVqJUhbN09PqLJ+I+a1lruZJ1Llr/9q2+N8jh62b9gvMQrquFZIMyTIrc/lsJ
         cjQlcRAXVaf+AIq5QYmzbWNa2UsU0BelucsMMSIroXlOXvNuJtbdGHGeLQ3tG19VTU2+
         MdLCDjHQN+JHjuevCbIMdwXRrfx7qTZsqx4qREVrFbDsAAZ1JaorN9uGV2yxNSigwvvu
         AGP6YafRfiwD6nWqi/Mb8sJA3echuYJHTYENY4zZXDaEj6pcuI3YFo/u1oyOxU2YPNLh
         e2Og==
X-Forwarded-Encrypted: i=1; AJvYcCWaqSNeg0b3cHa9n/1UCfZBwkLcXZ/geuuqpnHuyNbPZGKmjKetNeGo8OTUdjPbfc/kqIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy493lJ3teW2App1axnDhnPJvgxsKuRMQgQFlWMGY+0yoe1Hi/V
	P78q+mtBH3U2aJ8zSjEa/JFm7n1f+X2vvwIpNrfgNHgsRSSCVKQfeR136T6BYS+U4EepnX+bwdP
	5wLnmqQ==
X-Google-Smtp-Source: AGHT+IH0bu0OBswoopYcZzWlNO7RR5DVt2xehpznuFywGpO6c6WAdcd0Fqy753Gyg7xe4xkiody224xp/pI=
X-Received: from plhz15.prod.google.com ([2002:a17:902:d9cf:b0:298:3e35:3e78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c03:b0:297:f2d6:17b2
 with SMTP id d9443c01a7336-29a054a622dmr8506545ad.40.1763508503765; Tue, 18
 Nov 2025 15:28:23 -0800 (PST)
Date: Tue, 18 Nov 2025 15:27:50 -0800
In-Reply-To: <20251030223757.2950309-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030223757.2950309-1-yosry.ahmed@linux.dev>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <176350814750.2284663.7850374301770413168.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Document a virtualization gap for GIF on AMD CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2025 22:37:57 +0000, Yosry Ahmed wrote:
> According to the APM Volume #2, Section 15.17, Table 15-10 (24593=E2=80=
=94Rev.
> 3.42=E2=80=94March 2024), When "GIF=3D=3D0", an "Debug exception or trap,=
 due to
> breakpoint register match" should be "Ignored and discarded".
>=20
> KVM lacks any handling of this. Even when vGIF is enabled and vGIF=3D=3D0=
,
> the CPU does not ignore #DBs and relies on the VMM to do so.
>=20
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: x86: Document a virtualization gap for GIF on AMD CPUs
      https://github.com/kvm-x86/linux/commit/9f4ce4878878

--
https://github.com/kvm-x86/linux/tree/next
