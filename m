Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F12173
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155963; cv=none; b=SnznseRTKMMN9cEAA0J5fmmnslxXSDLd0ZwQLSBcv37zkV6o0VBSEpXwsO9sc6OUT6iX7DQ0Zm69604JYNuvewU0K0ocPEjucshouOpSx4h1AZAlk066vp5xQ3xKOPEREWbgyi0vu1h6PY2VPGKQ0Kwh0cIzxNStrgGquQU1iVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155963; c=relaxed/simple;
	bh=S8e1vECuRYnJIqPpX2t85ktJdPDlfOAafAMB9yQyadA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5p9z6TncfecLb/hh+nniKVV8m29nyVeJRkCQHfEqW7oHqq8hLiyVpiHyYbT9tqqKiwAvjCZLnl56ablcqb/jC3/REZMaYxaXH4EjUKibT4fQs64pkEnASN4nr+JwuJpQHLGZW51CX3ljdvH6WdHHAXBqs6+FQcXWe0+/K0p6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+01WtO0; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+01WtO0"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so1590903a12.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155962; x=1785760762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rHRV5gwUjVGQwdFF5biWwFHxQewlnY4tVqU7C1q5tGI=;
        b=p+01WtO01b5bB6djROWYxsO/r/ABNoNhPDLcL0zYxueh8bLpMUaog+ZXVa1IpgZHpJ
         4fafuPQz4ZJoND9A1kCC1VHgtFvbt7CecR0XN+VYNwwEE9AL5GFC/gxa3sDouFl9Wt6h
         me07ucHZ6BkN1/eteoVTzT1BqNN+OGnASJjrCcEzxsafQ5eLQ/KFeem0oSK+KOuug9hd
         WqxSyvWgfHBw8xEIARdEMKYyCc4rhN5NCuc8hEhlNLrC4UnPxH3OoPEs5EYJOBUY2xHQ
         XojdIFyQGN7cifRGkRVwjYvB1IaHJ5eO+GTIm0u44h+5KCZZW5PL4ctT2h4QYf/6NIzL
         hgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155962; x=1785760762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rHRV5gwUjVGQwdFF5biWwFHxQewlnY4tVqU7C1q5tGI=;
        b=nGRJJIT+Jat3e6qTvLf1ch7caftnNVf8HWt5oRBHgci9hbE0BxQSvMXPWyyQ8ATpPA
         +Z0QttVA4S63Lpki+pOgDpG8ruDRCeree19909ixcDayErrfMBapjcn9oSZmugMKND3U
         T2ouHURodYqRsPuT8DWB6U1+D6ZbV4gxlD8g7wkJyJr/mh9WHZaujbF7UolJrJhDGOas
         zMifaIe7//HGokvEXFFCgCJJ5BfOC2hiMcf0DVcjmF97NANgnHQFBh4XhhPJfuFbe0xj
         KF1hWk3B9rRl8cmIAHN2cqu5mJSfNLaC/kFF+s1gw9yxDpHNgVnZaC5Ujilhxu4ep1yl
         V/gQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+2Ipcb4V9STdaIDdqgQ9vJ1sAVHKPTbsMqX1/gWzVJtgvma7vceu3n/fPsUgvjSC9UsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIK8XE3fXKVIOFQtgA5vlSpENq0Vw82kjXd6hDaWW73/3a0UGS
	F6QzVNvaK3iL6jaDTa48WhnlqJl3ilDavmW2hSBemmuX4akv4Qritc8q
X-Gm-Gg: AR+sD10GKQVuERcTHnjmmS6RG6eJfKBBN1GYAIKevwW7v7g4Uwoi/HrJrdX2Z/iJpO0
	jzTt3vWj9C/0xTTV3zISbMwDzeOgWyhD3B+FxWIuR6Xetg5h/7kB3S99jLk+5LsXpPNwUnK9Tap
	134hM32/7ouufQAnVTJMExu/Jpi6jptydlE61nvQHVG0fc80l04v0OJ5PlVQ1J4040rBp9SnHs3
	khB7PwEvvd1Gloe5nRkAgyfducqRXS2JRZ2Q7RooGk2B98O/HCga/TrvqciHC6Hr6Y0yC93rXqC
	z/arTKxPgM0P2MHA9jsL9lFF3GqWBP07vgQwoNi+Xb1gk3KJqit4CirphEpXBzADIxsFkRJG4Pl
	Lc58mWVZqCzHBO9R7nfxN39N3do7UeXX18F3N+RkG2k3A/1bn+WFq/Bos8J4aXJJQmUdQ8/g=
X-Received: by 2002:a05:6a00:983:b0:848:4123:68ff with SMTP id d2e1a72fcca58-84e5958eeb8mr6476053b3a.65.1785155961592;
        Mon, 27 Jul 2026 05:39:21 -0700 (PDT)
Received: from wud.. ([218.194.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1386sm3036732b3a.36.2026.07.27.05.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:39:21 -0700 (PDT)
From: "Dylan.Wu" <fredwudi0305@gmail.com>
To: pjw@kernel.org
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	zhouquan@iscas.ac.cn,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: ptdump: Move pagetable definitions to common header
Date: Mon, 27 Jul 2026 08:39:15 -0400
Message-Id: <20260727123915.119650-1-fredwudi0305@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
References: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

Thank you very much for taking the time to review this patch and for
the helpful suggestion.

I have split the patch as you requested and sent v2:

  https://lore.kernel.org/linux-riscv/20260727122745.118764-1-fredwudi0305@gmail.com/

Changes in v2:
  - Patch 1/3: Create ptdump.h, move declarations there, and export note_page()
  - Patch 2/3: Make attribute parsing use per-level bits, rename
               pg_level[] to kernel_pg_levels[]
  - Patch 3/3: KVM gstage ptdump

I would greatly appreciate any further feedback you may have.

Best regards,
Dylan
