Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5FA39B97A
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381055; cv=none; b=QB+T2sJkBg36dcohRxx6JO47IZ1lWSzjA6dDm4ESb7ZITHgLvGFs8AeqsRslkLBz0VN+C3jArN3nmdTsDrSnctb8znCJGlKdrTDZZp6VZ8FcVN3QVLYiYFt/4TVkk7/r2h4Y0nw8ARDJmBHdl6TrXYNIhla9Jq7UFboln/xBkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381055; c=relaxed/simple;
	bh=Q9UIEcAvPJORPTWD41cpIOjdp7/S4AQkA2+wGNagTA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5YBrutU7KWU0GiHV+3fvJhx2imkymPTgWwlP5QzQ/1uDqPGtm2Fi3JbNZ+EB2Na1ARXttDuX4MgquzFFH2eXbRev/RU6EmM6uaDq9quzwEY7y98arq18UQRa/q5iXbgKSjcbeGzUzJAXRcdeBHTlab97PWra5G5Av9mt183AJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QJTlx4tw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QJTlx4tw"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9278587bso104823a91.2
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381053; x=1776985853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RgRlvg9Y1LaNRx+SazWupXuWPbXqEY3tEnJHpSwHv0E=;
        b=QJTlx4twRmhfrEGatktSQvd4X4v7FY/LZNnGi2n2AeU8uQ348hlrKM2le9swV5yvKh
         1unkrrxesMrfjLfRGSUie0CUI7JM4Z7nLE87N3FTeGl0+xMWZXPhFGxCP3XSoOMVVj/H
         7zSduyRegCDnZPaFc9cKeyiSznk+uJybE/H6i9TIOnIU7ye27rcFIJGyqAR8vMbg/psD
         2qanLZfFVGBThDu/57jbYczCHHiF9zkn2NnRQtRKAOdYckpatWElzJe4VSXZViVxn/9X
         XScfXlNwG0C+1PZqEzGyZHI0pnuyJwC8hSIWXcXmKgNTMv+GReTyfjUsGb4tmaLAsjpD
         8QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381053; x=1776985853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgRlvg9Y1LaNRx+SazWupXuWPbXqEY3tEnJHpSwHv0E=;
        b=g6Sy+pcM7kkykgSBo3VQj8/9o+SoJ0ihRQT+sWkCVurzW3DQCPl1PIVI5gf3wklYzk
         a4Ga3qctMfSMXXytYHGLAKbRLTFnYamKniws0HcvGGAcLLsnhEJEQAylfqJTkGWrRqJ8
         ywVFFuSdkxGa/PhwmYgUP1qjveQOYWrlJiZYStT8xslgKDnoGvgR016cevYCgMgqSMi+
         er+bLRlCGbO4bRFJ7SaIEToFEZG0+woFYGCtJpeouvGG2zo+NotAiJwkdNiborMD0jOR
         gbbXcb0ZRePSkkHlmS7UqHg74H/eAMMl5tfl6vDjE0xJHuJlFkVSU4D0L7YtJ1JdM6U7
         g+/w==
X-Gm-Message-State: AOJu0YxrSj1xkkgYpIz4PnNIXlJBP1c03Sj9LNBU2fooj5Yl9eZ7a1ne
	uHA8i90I383st+bQONS2Qqc5ty/Jyavk2YzvLaJAjgZJKlHLb3aDHtAr+Wje9q/6KjK5I2/9jwT
	RRn1Taw==
X-Received: from pldt10.prod.google.com ([2002:a17:903:40ca:b0:2b2:4611:5de2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5845:b0:35f:c46f:2b0
 with SMTP id 98e67ed59e1d1-36140473f70mr272112a91.14.1776381053296; Thu, 16
 Apr 2026 16:10:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:40 -0700
In-Reply-To: <20260416231043.3402410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416231043.3402410-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-4-seanjc@google.com>
Subject: [PATCH v2 3/6] KVM: SEV: Explicitly validate the dst buffer for debug operations
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When encrypting/decrypting guest memory, explicitly check that the
destination is non-NULL and doesn't wrap instead of subtly relying on
sev_pin_memory() to perform the check.  This will allow adding and using
a more focused single-page pinning helper.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b9d7bd868e0b..9d2044fd910d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1357,9 +1357,11 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	if (copy_from_user(&debug, u64_to_user_ptr(argp->data), sizeof(debug)))
 		return -EFAULT;
 
-	if (!debug.len || debug.src_uaddr + debug.len < debug.src_uaddr)
+	if (!debug.len || !debug.src_uaddr || !debug.dst_uaddr)
 		return -EINVAL;
-	if (!debug.dst_uaddr)
+
+	if (debug.src_uaddr + debug.len < debug.src_uaddr ||
+	    debug.dst_uaddr + debug.len < debug.dst_uaddr)
 		return -EINVAL;
 
 	vaddr = debug.src_uaddr;
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

