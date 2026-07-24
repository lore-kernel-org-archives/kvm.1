Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8033264E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906813; cv=none; b=hqLVpK5+OaskGXzynC8gedChL3J4uul7cXZJfNOrli8E8PMnqSKMBujruhZQJHBmNhUiJp1nkCue02NNR7qFJwzARXGUwp+N9nFV3tCQ1/C+ZTKshvs7Z/ev1HSnsq9zRKLw/IwXFMYrKFUJnfN0uGwBHRIU++rIHZsGPsBT6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906813; c=relaxed/simple;
	bh=d7avr/Q7zTbtBI2SbqHsaMMmw52aMIYVQ60kpDGNhFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeeHxw5E9376vxDfAlfW6NtU7qKKPLluFn9bzYbazdSh9/Kt+TvdmgmcQtcyIrE/v3UWiy6iG37BW1ylgCSOMoo4lONmeKcQc9o3/1mWskrd9134ndxKnTL1x54mCfObMn6OHzgY3InrlYc17pAHBnkdzdPvzEr3EnXqlbqLCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eC7eFMs4; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eC7eFMs4"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e4ef9a74aso313206b3a.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784906812; x=1785511612; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7avr/Q7zTbtBI2SbqHsaMMmw52aMIYVQ60kpDGNhFQ=;
        b=eC7eFMs4+UljHqa+sgm+3DpsF7nAfwaShVQZYh2xW3ptkZ1hDaTj7uZtZUSn3kmHmx
         R4zNm2oICbejvQ3qJPih5NsiV7mFlQ2mMr2+hoQDRAJk/IU4ikW+jixtabr1EHd32UZ4
         8yrATz8aiPNc/IVomNrUrW9xLygJkD25TcNsQK8/nEFMeCpq0L6+tqPIMJqW7i16ZBxu
         wKCSaILeTi2kGAQy93ZiUoUYt4hkVod14Aic+LdW2aJ/Jqr4kgcApe+3nteuzNgCxqpQ
         nI7ugcRbedeueJHrhuenImReoTte16UnumCvv7ITZ8g2P2VRapAVmBVxFU1BI+aXCMSr
         WpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906812; x=1785511612;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7avr/Q7zTbtBI2SbqHsaMMmw52aMIYVQ60kpDGNhFQ=;
        b=hbqHs1NxF0gqXFeQPCeZ0wdpvtwNkIIwWgQFxVANLzfW7eV13DZCmbFoafCfiscUSQ
         rz2zBCYmU6oIUfxz45DfAFlHY6l1561T8UFIGUSTGlqclVbbf/CRY8bbS/1wxGhGrsn0
         CUpyynRqWs5/FlHKNdpZqjrhGKjjjANxoccR/1mtzLQK/wkpCH/NoXnEi3enfVu7Kq/y
         LU74ip+BhoTlu6EWS8qFi6242hv7qy4k32jMWeYEtc6VINAgirRuchIjLulDgTh6Cd5W
         3ht45EJLFYbFbwrgWtnbqeHeXIVwfy2lvAJUVh40Y0r/t7oPOz6EF7q0Ehu8WMnj+lM2
         +plg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4+7Fj8ZIgTJF+gaOybg8FiEsMB7SCn7gd9p0p6SEeYyJ01AJUwSrR00YAYC3jhhb2AsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3hByHNZYc5CjF2foQxHPHcnFAkVq/pdBUYdG0AbZnU159rzb
	zCI3jTtxRv6LNdjciqD46+dv8l88ysc8tPrTaULMiT8eeowJ0x1Phm1rWh17NgJowLinjZCLiWy
	4fVr+2Q==
X-Received: from pfbhu26.prod.google.com ([2002:a05:6a00:699a:b0:84a:6b32:7768])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:84e:26c:f250
 with SMTP id d2e1a72fcca58-84e2c181cc6mr8405649b3a.41.1784906811605; Fri, 24
 Jul 2026 08:26:51 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:26:50 -0700
In-Reply-To: <20260629183746.699840-2-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-2-yosry@kernel.org>
Message-ID: <amOEOm2zgmKCC8Oj@google.com>
Subject: Re: [PATCH v3 01/10] KVM: selftests: Move STR() and XSTR()
 definitions to test_util.h
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> The macros are defined in two tests, and future changes will use them
> elsewhere. Move their definition into test_util.h to deduplicate them.

Even better, just include tools/include/linux/stringify.h and use __stringify().
