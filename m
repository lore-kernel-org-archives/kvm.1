Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06547ECF7
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049312; cv=none; b=RtFHnQOeAVFqw2Z2UWspgV/H8YclA8aFOoy1veOYcpuflMcEsL+b3lwcHL10RVEGy6qLRQv2TncKW7ipv3rnD3Wir+O2KRW6DNMCfueY8SYu6k9GdJnk9XbjCQM0HRJutyWsDEOQCo4msiawVM5j9Mq9ModPBpKDZ83xzqJZ91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049312; c=relaxed/simple;
	bh=hQ6Z1OLWujQfQtTRcEJqCSKaF8/G0Pn/TQJRUImGWLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u44xhUdANQ8q9sKVSaONZex9WFJptumRd/dXZKT9YEM4Tygiif+NEOXZfxsyLUOIWkMU2l9ssraHv1oPwp6EFxG9BZKDHR0Ni9/ijJkorE34Dj+BksFmJPTkWWkdJqPFmsIeHtTBh1MjvpiMpQsPDAiZ9IUiMqbxPMS+mOwlOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk0oRshm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk0oRshm"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38e04a53a7aso2367277a91.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784049310; x=1784654110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wn3k5OTUiXTuz3xj+tITXJguX1e83QRFO8TCDAY6qhs=;
        b=gk0oRshmh0J9JUAAGttVKf9hsu9shaKO8oE+08uWVoKtb/xC/3AYHz2GmxbixI8ZQx
         S+3ZSNeR2210+3KUjcOpnunu+E1u1cYBfdtTZgUVOt5Uq2LwM4ZQ9jgEwTmTXJrBRnV+
         ktRKSULSULry2gkm51F+p+WBVC4kOFauXcr2MeJ99wBGPmy9t41yko1cKwUwTYS/3Tn5
         /d/dZpECG7G710Towyv/Ae0JCsqWImRdDIazeYVJ3VeplzO5osW+KhLITvHy10MzFO+B
         viuYvgdHgfED6qW0ANsK8UJXtbxhmBp44+EkgzG40FFcoSkzER/ty3Lx/fBkKrYQhjzZ
         tGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049310; x=1784654110;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wn3k5OTUiXTuz3xj+tITXJguX1e83QRFO8TCDAY6qhs=;
        b=Y+gisAeE87jhNqeJBf8c/jcSlAOKP84M6bSIhjnlHNowBsCPd7gRKAIanY9RxOkwfV
         zvv2xc7Awa9PkjZYq5V4UH2k0Je4AmLDxglzfAtUkUEfTAnpUzA/Ah8iVAhZ3tRYx+54
         1K2XQtQUceKBLSaeXHiUF5Z/9F1Prh/aJMn+4C9sP8IgtJyDaxbFh8Pt+tA5lAJLAKXF
         122vJ/JP81yWl+CAFOpWZwJzF8vJT2c9uC1xBGltglUG7fnLm4kYEi0VlQ9JR5BcBfTA
         K9c/Tc3P8k2CioXKwkGRB55qAiT/S1Jgo0wwZf/ynnNOgJ1dK+Q/kL5bPbe3qvQqM7KE
         D6fw==
X-Gm-Message-State: AOJu0YyTOfgCsPMYF4SdU1N4cHUpbVOITqJe46Vc6UVYompOzkWtiiCx
	BT/P7gUKABJGKI23sbXuaUhp+i6rItwnOs4/hfPWZTffVYTFN3XFrgtgT5sjNU/oybpQyXz8Bkk
	4rYtJuQ==
X-Received: from pjbfz8.prod.google.com ([2002:a17:90b:248:b0:381:2550:5683])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc3:b0:37f:ef32:d444
 with SMTP id 98e67ed59e1d1-38dc78227a6mr13258961a91.1.1784049309760; Tue, 14
 Jul 2026 10:15:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Jul 2026 10:15:07 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714171507.3050951-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2026.07.15 - CANCELED
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

PUCK is canceled this week as I'll be offline.  Apologies for the late notice.
