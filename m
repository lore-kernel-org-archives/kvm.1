Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929A3B95FF
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323505; cv=none; b=pG0bUsG3yCUBxSYVh3iSmVffXwlGEoVCoqMtzfcj70Px1pROTw/ProxVg+ulOCpl6/EmvlwkFh6Knedir7UFQxWJ8CbvJgCrNXp/GPaB+ig47Mzrd6xPUKGEeb1Kh2eIWkvJI7HVE1oobHfJkDjKEPj28o7uQ7WA2nHEXNntVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323505; c=relaxed/simple;
	bh=W1xQ7RR3f6W2gygq8YRntn2oji9dZ7t4CiasDB970Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg8Jho0wLFNaqSbKVcD/5y4FZ2mx/l99mC9CGW6tV11Q2ZE9aXjGx7aQzWVHTNKNctzCmpCVnZkKfqKvm7vENAmkzr/WeuV8ym2w0fSZA9ZgUY2qFGJf2TITNrRcwTWrd9R5Wk4ofZGUbpB4NJhg5Ak94Hqnv96k/hjCkZ8n4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahzTl8Jt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahzTl8Jt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf20f6be6bso18017045ad.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780323502; x=1780928302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1xQ7RR3f6W2gygq8YRntn2oji9dZ7t4CiasDB970Y0=;
        b=ahzTl8JtnOtAGdwVfWPYnEz4Y7keBb60tTuXNBGU/m6nVYPY5TaEnehVmvv9LQZCYq
         PbaOC2oVwIK3vpVGf9fli1FRakJlZGp+sOAEjvqzN0IzWp/aHOvgRC+WuBrrR1u39g4Z
         ah5N8u9sqRMtIKsvR2wKLjiKdFNySmKzqy+iyTWHch9nmlO6ORd0VttdJGSZjYvXt5WW
         nkh3cfGvleHLpmKhVNzFuGKDRGSQNIBZmPlCTR6Ld7sS1oY4WmoYnRzkEgNjFMRIxPB3
         FC4jOxREW5PHMxNEMKAO9nLQXksDRjtnX4xj0VVu+PTwMM3vPWgZc1FFYxh+tpE4XLwX
         p4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780323502; x=1780928302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1xQ7RR3f6W2gygq8YRntn2oji9dZ7t4CiasDB970Y0=;
        b=Vrqu/4PfnL58J5IK8IKNaK5FAZjfO3HFnjjZSWXDEuZYhfS9BMT+pIbfTJLDNFgs4x
         LKUsAkiTGICzR5uev/6CjNk2oZ7tqdUPC9oXwQ9NeMgRQHrhiKPurr8GG6tak07oU3Wr
         icRSMWyu1t321T/MDBzSNnFLHGI63tbxYkjmY2RDpRIfYyeXvD9DfgM3165Y3HHoln3t
         Baxh963B9mEv5dN+Tb/GkwugKLKkZZlG+QGprKERUsHbrMUNFfA4fArUTGubYH7DLJS/
         AmY5vot69/QMpfSQBtRQjrB5387FF4nbFSzsFvfiUPcRCHJIYtmTI6vgJmCjEPTz8w6O
         MfMw==
X-Forwarded-Encrypted: i=1; AFNElJ/D8B4Fzn2+lgPVeDIJq0ORSocnOsJ5W59s/qiOz4bLDeOmVFbed3MpUkSOqzVKmhO6OlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlqdZbsu3L9lmDyTIMulqBBI/XDy2K5HeJPkoOrS3jPI+ZkRG
	b17YtYR29vyoCjYxS2FGZVCsp6sWuO/Tou7z32oUex7nBEHi/7AKc194
X-Gm-Gg: Acq92OHUlldUko43oyGtyiNwPzIBPLAQCUUQUHkc8/HAPyvn9H8BmIJ0rzlGy/zAYm8
	2qGwWTxwC8eIWpdVF832reVqaVXEz9kc6JrtldfKglExtIM922J7YomxWLA7yjhds/B/E84YKLd
	HVTyB/ypGGP4BiuVCkB0yqswppKU6ecbj2psWeWQ19BY95E7L3xL1U1HmLrANJmOfR58N1jsATD
	UC+12OSW344+Hh+0RwA1oKWG6lNqjWSEdpPnwzT9TakzY5+BIAIvKaG5qFjeoAyOSSvxFnuU+a9
	l/oQU/CYdNx/h4pNfGhkoD/tcDsIarRkrrOswWbEWvSyt+nRKhrFjd2O21zbdP770tilMALQ237
	aeeyzZiS7zPRgzjUkGggIwgVuactHY8eq6JqPIv3rOUcOaczkEqaJ2hWMgAFp+b5F4eicKxXnpX
	gENBZMMSp6iQC7NEIH9xfC16xM91Br6j9Ddg==
X-Received: by 2002:a17:903:286:b0:2bf:2369:a131 with SMTP id d9443c01a7336-2bf368786bbmr133870415ad.34.1780323502187;
        Mon, 01 Jun 2026 07:18:22 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a305:4::40e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2da36sm134646855ad.69.2026.06.01.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 07:18:21 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>
Cc: Guodong Xu <docular.xu@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Zong Li <zong.li@sifive.com>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 03/10] riscv: Standardize extension capitalization
Date: Mon,  1 Jun 2026 22:11:50 -0400
Message-ID: <20260602021638.158707-1-docular.xu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAAhSdy0pHPAMRRR-Mri735zLu3ymr=ePQ7gA6zZ11BkHEXj+AA@mail.gmail.com>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com> <20260511-rva23u64-hwprobe-v2-v2-3-21c5a544f1dc@riscstar.com> <CAAhSdy0pHPAMRRR-Mri735zLu3ymr=ePQ7gA6zZ11BkHEXj+AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Anup,

> Acked-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks for the review.

> @Paul, This patch is independent of other changes
> in this series. If you are okay then I can take this single
> patch through KVM RISC-V tree.

There is a dependency ordering I should point out. Patch 08
("riscv: cpufeature: Introduce ISA bases bitmap and rva23u64 detection")
uses the upper-case RISCV_ISA_EXT_I/M/A... macros introduced in this patch,
so it won't build without patch 03. I mean, if patch 03 goes into a
different tree on its own.

But of course, I can rebase them onto your tree if patch 03 lands earlier
than the other patches.

Either way should be fine with me, your call.

Thanks,
Guodong Xu
docular.xu@gmail.com
