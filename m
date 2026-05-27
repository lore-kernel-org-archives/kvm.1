Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE12566F7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904224; cv=none; b=gxXy/OvPAxoQWU/R0wXAexw1+4XQIn5vzv2iM90nGIeYwqKotDpSzcV1kkh+6HctzJfVGZPlFlp23oAGpM0dH1zCxgX0iCaPns9D5jtRl/WAap14K5BEjfZSVaWqVBZAo001fSiQB5bBOy+p8tP45gS7aGOOaeXD7nAqmznF5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904224; c=relaxed/simple;
	bh=HFQ+YmtRWyafBmsUUPaGNhS732tE/OQkAjdWcOvuEis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LSPLJ2NGy85LvRgPtJbWlvv34dQzBNUOGv3ev9zRNfZY2GCoOdxzRfv+qFr3A0RI2+/lDc14bLugjLYH8GZQpmYlfT7GoNKmch/h5z/IFOqODpt6z7pTtsIrZ5DgEZ0ka7xkG571kXhCeYbOGI7yKFJ8YhR8FayTzpAl3VST6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8KtNWT+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8KtNWT+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso11255849a91.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779904222; x=1780509022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wax2Dw1E0A1qPLvvHdm66ELuhSDP0n4TovpAaoZ8XU=;
        b=X8KtNWT+EVyiCdoj8BTTKZgri6rYEClZKtB9pMX5acmQYf9Gik9348/nvonTtWXjin
         wIN89+ZmphJn1aTcrLMQBf6MnBtAkbvEAruFnvOXKr030ubtTTij5JA9fPVI4NYT21AT
         EN+Xv92zbZOiXYnrD0EsrqnmDbHygPurGXZyhXosfeC2L89YuPO7JO3OxWlu3+Ltmat8
         CX0H1laDS0g5aDpTNXwbNrMU4LG2zki9JH6sEpNhH3G63jFqgAVqIexhHLb9v9fliHcW
         aY9EXHcbIhcEA4zubt7gUJwKz9ndpQZdzYkNsXfxist6KVbBVVz011a9fTRJhkXDVXfN
         1Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904222; x=1780509022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Wax2Dw1E0A1qPLvvHdm66ELuhSDP0n4TovpAaoZ8XU=;
        b=kxjzNYZyHdgR6m3ekTEL5B3Mmpx5yWWWUH832V1jxAORK3YXcXsuVt6GiZ4/qfxpg1
         VN7/7JpsCIV1v5qT+O+hF3MJZGCSP0QcK270MI8wN4CI+0nw8zqCSVgQWrj753Eo4N7f
         KMLHjPeKbwHN+pFAkRV4vYtPr47plN2n3vvBVvLPNQj17/zp9lOrZHTQXFVK48444cfs
         /ij47EMDfZBG2pSzey5WFZd5qdy/W8Ngx1fxeW1KZfwbHbJgVXhv8CLZ4+JwD/IRauHT
         UPz0LgGWS6SJQE48gTRwAyOH7isv4ge6Ym6AAHi1rc2MA6hplmpQEfmyGROucXAy7DXn
         +2og==
X-Gm-Message-State: AOJu0Yw8utcBT5qTB9jhZyr45sCt5ImW+gAyhHb+kXQS4rPeseMrKrZK
	UnZfNJhgYAqS3uTsRigeti5ygxS+PyHT63zLhawNFzo78q8EZgCilmHu1POCcYiYTJqzesq0Gos
	DrwJ2Ww==
X-Received: from pjbkb16.prod.google.com ([2002:a17:90a:e7d0:b0:369:2603:1a94])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5343:b0:368:b01c:85a0
 with SMTP id 98e67ed59e1d1-36a677fd392mr21670324a91.14.1779904222106; Wed, 27
 May 2026 10:50:22 -0700 (PDT)
Date: Wed, 27 May 2026 10:49:18 -0700
In-Reply-To: <20260527152333.4062942-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527152333.4062942-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177989758986.4078221.13423482968166907141.b4-ty@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/vmx: Remove the superfluous vmx_cet
 config entry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 27 May 2026 08:23:33 -0700, Sean Christopherson wrote:
> Drop the dedicated configuration entry for vmx_cet as the test is NOT
> excluded from the main "vmx" config, i.e. it's already being run by the
> main config (and thus obviously doesn't need a timeout of 240 seconds).

Applied to kvm-x86 next.

[1/1] x86/vmx: Remove the superfluous vmx_cet config entry
      https://github.com/kvm-x86/kvm-unit-tests/commit/c10d4616e2ad

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
