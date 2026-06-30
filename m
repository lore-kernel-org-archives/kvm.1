Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22D42AA6
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780304; cv=none; b=Yyzy5I1hrGY31zMxvuCOO425d/KXAyrjjySE/vutmc339WzxkdxoFrOaTkdt1jvp6vep7X+nrkYXf8YS6GbRlu3hupH/l4mOazmMV+3Wfdg3CYOA95FlhpN8150fU792lcXneKHg8wTeWtOpN0Y3j4y9PyQ24ttbU7YyJUCHMmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780304; c=relaxed/simple;
	bh=LFEtXrsP07lkbT+qoXoQ0MRqr+Jm2xtPU2x9es3aaTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=METrBwUwximS6uIl4kq8nBsOEQ4wXBLP5xi463zCRAfs9yT+gaxN62UhJ0TCna+1Ds4m0dWhpGIQvYIWpUXw6TxJgvhJsuoqbDY4RdJlNACSrxr64FO8yLphjuaJLxdfirhEmnrmZTNcmBVn1MJqAq816HOyPxL0fpb9re9oIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stFd/Eug; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stFd/Eug"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37c9127e316so2698639a91.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782780302; x=1783385102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFEtXrsP07lkbT+qoXoQ0MRqr+Jm2xtPU2x9es3aaTE=;
        b=stFd/Eugjkhmn8BkLvWgV0dnfNdYsaAb32V1qLlpg4DssoYhmYkYKUg1bvqukYQ1Lc
         j7FJjr3ioGoo7jzZGnOW3oAPJq+4EFg/GASBwV1bg/UYv0fTXioxoqAUdsLefLmeoYRy
         PBJ2n00v1MbYgQhujzKUPasFaKZgG3Oo0EQBCS463KL28E9XPSavfd0KaN7kAV88e7yJ
         /Hv89Vqgqwh9a34uZHH0j5XfuwerQmXNJHFGfy0WawIGWIkoBEc6bQPkLBrrfiiTL6CP
         eTEIRpnvDLjD2NH/lNY75PaGs7BmvWGwJgzLOpyCwW6yRc9+3jAzUduFkyBUMnXMw4Ta
         SFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780302; x=1783385102;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFEtXrsP07lkbT+qoXoQ0MRqr+Jm2xtPU2x9es3aaTE=;
        b=IHPcXyPcWzA3SOfxOANhaASbG654VznJFTxe0TRdzKvj6A406PiTuAQrEJ2TITsm9z
         0M5ZDIH1IqMRXv2ZDUVkjZDi9oHuhd3CfzfnsqDR2649Gv8YkXzjo4KXcP40rLP6xLuG
         +am15fx1OrFkAQxH98jU5IC0ty6D8UNzQzP7VCoRqcaXYxsRGj5wKRHhoovotXiTIIsD
         C2qW/wWjQAWlalJ4HKhR+C6QlZZ0SXYCcQwLPPIhLSgxQP+5p61v99oC9jHSwECWdwTN
         hf7S/XYL9Ghamqq+oqumhAmWkzqGFRRWIalRZ8jZDeSkmK0S5C56lsgxqNIbZBJhpsXW
         KWyw==
X-Gm-Message-State: AOJu0YzgUYQrDrS7jyNPI8AS59e4d0lhfYh3+K7WFRuL7cE8Yopjs6My
	75OzYmuXCrKXjOGiMaj3Ske0e5XgMY1iVwTbaVIn+5YZbnXlAn6limQmBChICtXeJiPJbOIq93W
	gUGVnoA==
X-Received: from pjbjx19.prod.google.com ([2002:a17:90b:46d3:b0:37f:6c08:3ef1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5251:b0:36d:8e49:d8
 with SMTP id 98e67ed59e1d1-380526df382mr944296a91.15.1782780302382; Mon, 29
 Jun 2026 17:45:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 29 Jun 2026 17:44:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630004455.120819-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2026.07.01 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled this week, as I expect many people will be offline for the US
holiday where we make bad/fun decisions.
