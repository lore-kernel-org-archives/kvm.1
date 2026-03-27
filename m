Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B420C029
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579970; cv=none; b=h75Z+ffvBb9WFcR9HEf939sClfAA4zfibp/SlgFLDn7+oGAmyjCw8hTuZ65YCkcnQrjx7tAdPy5QVg5fHV6hdgsGE5qxi6RG8TM6Xi1KdGtDqYzpqvS+RVLoRBI54WQW7Mgqh++An6HmhpBTvAQpzgYOmtPizOJqxaaYdBiCH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579970; c=relaxed/simple;
	bh=vIlM3XWl5/+SsBHow1+ctgAWWaYcw1vAtlL/Ep3PTrw=;
	h=From:Date:Subject:To:Cc:In-Reply-To:References:Message-Id; b=Wg7L8H242Zo5zefL3GmiM/+7ljCRWxddOyW9JjRTRObx/RTVXXg6UGjEH1NS0r2+2KLMjPLC+aXO4DPgrvNg+nb3Nq11ChoKu4XzPP8o8z3QEApdy1nOUX50D/S8Rw6gbc+TYHXubOB2jXlWdukp4ptdn5QCQksrEGMYFQb3q94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehd0+lea; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehd0+lea"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35c206f0481so1296334a91.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 19:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579968; x=1775184768; darn=vger.kernel.org;
        h=message-id:references:in-reply-to:cc:to:subject:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjZF/plAApAJ5rw+kw5yej0Npygs8FHjmZQbsUjCob4=;
        b=ehd0+leaV4AMXd4Z0pWjoXCy6y8SfJSzmnqCyH9PLwUDWVIumI8uhKXXwYfot8jb5p
         T+mxgR15BccakRRKhhPUTXxthmHM5BiCusLLclyFV77fRyXpD/+d/h6WG71QtLQBhgA2
         qfvOH/DecqrlbDOu/SPybkaSLnmrjrHHHGKVnUq3gCXL/Q+pEk/0qx2TCJwCW4NjRdYm
         528ijL72YFRoJuACbGMRcQ8S3m2o77/Z3ox9+OSTV7TXVJQQ91PvewlRnqjDmWnBGldK
         M0jbBTCPjJrq+uEapUx/FsbpLyPQT807lJRv0+r2ZvqzvUMC7LZZujVGUe71QY/jUudc
         CFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579968; x=1775184768;
        h=message-id:references:in-reply-to:cc:to:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjZF/plAApAJ5rw+kw5yej0Npygs8FHjmZQbsUjCob4=;
        b=s25ALe+5c4I5f+lI6Dogj+PyT8oYf3/MLd9d/iGzeC3QSWSaiFwQ5VScECZD4zNNBF
         5FgV+hTI9ggKqPfKDTRH0KTu2KIuS3rOljkYZPmMX9VyYYoHfzMCzbTn0Z3Kg+gWlONl
         vzcXHPIe+D42ikpN74sWxgqpyFCpO3CbPvbNhrFmrn2sTv/oHquyCJcywXh8a6I/sCY3
         7fdXmf55miCZaVb2aWLXipewWK+Ip9TSm96aIEgx9y9NH41dwU2oafyjusrmVrvn+bVK
         oBOEhpqyk+C3qgSW/b7Ioz4q7m8zafpxr1jqTUP3UvMtH9FPpza55Zx1zMk/KIqds/1P
         JFpg==
X-Gm-Message-State: AOJu0YyY74spFb/eGHglrxWQEaSmcUHS7eXBb3T0uDNYigMN8vYRd1V7
	EKsruWvyqs9qoby2udF43f2z1mT233SzqQApomkqyjk4Rxf6b9nSs3FLtKd/btqpmXOpMA==
X-Gm-Gg: ATEYQzwWWRn+Ftcn0PMV08tZHlTuHedp3GbdKWkvgu3rVraSlw0fCfmrgB48RHg/ojx
	zHV/dqLJbPDAWvot+i+FwkFwS4iK9ajuyZaGQOFL86+/arH3T2KT1QwcynzmWRHcVZfCAbnQlc7
	ea6AIhLDwY+CkDLz//XM1UdoAXjb62x2lMA2FVk36BsshxJGCX4282dgN3GirrTj3TLQEdmYvW8
	Qa94FixHJK79DvcBhFXkOGcdWszLn3lDUFVqXVVBiXMH0xi9h4eXVjEcpc1z+wOTahYVFWr0QSE
	RFMfgBbPULJS/e30a27C2XDOwpd5TNMu7y/dCkEf1YYMjgjpufvVNQn2I0yJSQhRoG1dCoJHNQ1
	bCbJqBrAvgb9rWHTkYiv27s9bwsn4vZx++5nINPbv3jDmRQNQ4EylfK0QiBL4VxknjXGAoMCypn
	qUaxdQ41mbtp3ncmAkqOr/
X-Received: by 2002:a17:90a:e705:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35c300f42f9mr801520a91.23.1774579967927;
        Thu, 26 Mar 2026 19:52:47 -0700 (PDT)
Received: from [127.0.1.1] ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2d8d47c6sm381008a91.1.2026.03.26.19.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:52:47 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
Date: Fri, 27 Mar 2026 10:48:49 +0800
Subject: [PATCH v2 0/2] Add GDB stub and step-debug support for x86 and arm64
To: kvm@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260318154156.2064989-1-liuwf0302@gmail.com>
References: <20260318154156.2064989-1-liuwf0302@gmail.com>
Message-Id: <177457996500.86179.14991222733583648054@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

This series adds a built-in GDB remote stub for kvmtool on x86 and arm64,
including packet handling, architecture glue, and integration into the run loop.

It also adds basic documentation and test coverage so the feature can be
validated and maintained across both architectures.

Changes in v2:
- address review comments on the arm64 software breakpoint instruction
  visibility path
- split guest memory writes from guest instruction patching in the GDB stub
- synchronize arm64 guest instruction patches when inserting, removing, and
  stepping over software breakpoints
- drop the test-spec and security-notes documents to keep the series focused


vince (2):
  x86: Add GDB stub and step-debug support
  arm64: Add GDB stub and step-debug support

 Makefile                       |   13 +-
 README                         |   29 +
 arm/aarch64/gdb.c              |  752 ++++++++++++
 builtin-run.c                  |   13 +-
 docs/gdb-stub-architecture.md  |  142 +++
 gdb.c                          | 2104 ++++++++++++++++++++++++++++++++
 include/kvm/gdb.h              |  148 +++
 include/kvm/kvm-config.h       |    2 +
 kvm-cpu.c                      |    9 +-
 term.c                         |   18 +-
 tests/Makefile                 |    4 +
 tests/boot/Makefile            |   10 +-
 tests/gdb/Makefile             |    8 +
 tests/gdb/test-x86-gdb-stub.py |  178 +++
 x86/gdb.c                      |  577 +++++++++
 15 files changed, 3995 insertions(+), 12 deletions(-)
 create mode 100644 arm/aarch64/gdb.c
 create mode 100644 docs/gdb-stub-architecture.md
 create mode 100644 gdb.c
 create mode 100644 include/kvm/gdb.h
 create mode 100644 tests/gdb/Makefile
 create mode 100644 tests/gdb/test-x86-gdb-stub.py
 create mode 100644 x86/gdb.c

-- 
2.34.1

