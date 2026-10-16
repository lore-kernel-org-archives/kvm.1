Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65937EFFC
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125859; cv=none; b=rGcTfspqx3OWnG+An4grMHccM9FGC849lCtNjE8Sd4WdI392Ssn785oDzDsof0nUS5pMI7CPXMATfQ4q/4Ddn75FXAiOGYbPC62C+7koMgC4O4v6Tony0eSZ7aQ6YeCNrlubRMB2cNYgGxoqlfzO9ibrt0l+Xv7PQeNi+DWPug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125859; c=relaxed/simple;
	bh=qijEVR3ZfwMQmmtpsAvdV+g1DfB4sbwoHiaGcv+TK9w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JHx+BMES3qz4fiu9yjxEmbkDMC5OVnbAN2phc0DWuinOPcUFMXLagEV/pz+a4Zrb6vqIb9Xju45Z0f4mziRT4PQBJZjuhZH/co8ebto1emeVXiI+41esAtJ2joOpenGsOKIaPWo+yTic/II3NtMsSjEdQc7XbdZkv8hyi15B3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dA+uWsOY; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dA+uWsOY"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e8e16d22d8so41280225ad.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125858; x=1792730658; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tmAk3Oh+oKVK8d5pqejtpcee3315xk02eIJBQpRYvbg=;
        b=dA+uWsOYF9UV0gz0oUyRhNNNnnlFRFTYTqfKLazQAexWUOBWQLqbdFv1hi7vi8+VMN
         NojVEbb/Qi3H1m/sJAdH26YXyoB4s7xxWOG2ZZkTOCX5/qg1RDxRoKaevzKEPRX+7Gip
         w5cLVGFzu2nRDAfV4ASTWERfQS1yAxEPUaFop6KSILEr391VsRO3o8bT01WgK4vGukAd
         ienYq84QlM4kwzrljDkqBUDokQHPoZT0k98dFX2NSs7avmN4TLhLJfd6b6EDkUcBgm8U
         lYHc5XJaE4esxWId13rqGOhGb4bi0MA2zm75WfhzyR1QXCr7Dd7M227pYY3BaRYlqIfe
         pMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125858; x=1792730658;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tmAk3Oh+oKVK8d5pqejtpcee3315xk02eIJBQpRYvbg=;
        b=EXowSMzA2LRLpakWTR6HfRcxn7NtbbnLl/wnC47G7AmKkOxCTUeVqSLoNNO+EWxulF
         mZ+odkyX0/uRcJVOu+eORa+Q9OXH2/t2CTZv4xcnsnPXIAjMNUT+qgIUqq9q9XJiAQiS
         x6aHseTvDht6kBTAy4FaskZfHx98d3xpz9+0vnyYT8VIDDc9P15cVoyvVhlAs4pjz2Uc
         OXC+Kcnurf63gJzwnNCYImMm4kaR//Ld813BDpAnugNB50GYw7UEpu7NGgba1qrl6UaL
         e5r7h3ItkYhtkvLInXLvFRQwUvOV456f5eWILXtPcC7xSEKwsEJ8I2drBYKem/1+c9zY
         /5/g==
X-Gm-Message-State: AFq9FYLCVyHKvj8FzYCR282F33Oe/XTa2UNen15n6NBd1zik5JqJhD9A
	ax4V1q/m9hXJmTbeuRRzbbgS8qEFbgup2aXULbyPi8OVi0TEzUoDVb32xCnGlcOY+Ano3Pf92lr
	Iqd9KIA==
X-Received: from plu15.prod.google.com ([2002:a17:903:368f:b0:2e5:d262:2f9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f92:b0:2e5:98d7:8202
 with SMTP id d9443c01a7336-2e842cd44b8mr191901645ad.13.1792125856508; Thu, 15
 Oct 2026 21:44:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:05 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Pull requests for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

This cycle is "fun", only the "mmu" and "svm" requests escaped without a conflict
or some other notable mess.  That said, I don't think there's anything particularly
thorny to deal with, just a lot of minor stuff.  Details in the individual pull
requests.

My apologies for not getting the guest_memfd in-place conversion changes sent
along sooner.  I really wanted to get you a pull request around 7.3-rc4, but we
simply could get the code ready in time.
