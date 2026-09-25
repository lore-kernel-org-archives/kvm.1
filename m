Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264E364044
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376318; cv=none; b=mTiwdMfM04HW5V7tMFPd2hBSNTitaYIGM/DyGKrZRByBTcSqRnhSrdwN4TbKlIZWvhd6qamulXaqS6MtXDqOpwfyumOsWqdAozmgWqh4HUShl/L98VTLr+ApRB5uNKNAhV6+rwpFGgt/G1+pM1OPP2Fe4mBSehxIKRQn0OKAAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376318; c=relaxed/simple;
	bh=T6F7uHcNkJdyO9Ib2RhrZCO27uWF53XXXaZaiu9/lbo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V3nO6+qbKqEF+CDwtPq79HV/xC/2rvjJ9QSEM2EuYVtdWGUne2qdjEFX+BRzIQXQJhlpJZ15Vty3A+6yG/PFSTJPYdcY4WpCjicmgVTgcxPJRtRkd4ANzH+wFHDOW0J5P8arnQpj8opj+wjhMMKqBosI8esuVy2/Uq8RAWD7COE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8nG1pW/; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8nG1pW/"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d55d8cd938so19099935ad.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376316; x=1790981116; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gx9LeIS7ritRQsrqMLcd4L/zxjAWNu+QKFz+8zjLY2Y=;
        b=o8nG1pW/7P7ATEQTAg0MR/nS6mZed0aoj2b+g1CT6uHlhUVifSQsNkyINaTqlaxjk+
         CBdPKNoO64TKJn+LvS73cWTL7yzvvTtX3oLmSABVW3v1roq/ndKrnOr4uoQJ8PkxfjiZ
         5q8bpcKZ61Rid4j2QhLIwKwgWm+AcPvpKU9+SN2lyf10E8b+x7/CVr1TC4cMWjBr+rXk
         WgxxP0co8N5KcXd9nfwpJqxmesnRY09ioDZ8aC+XzzCnuaweiC/kUN4f8fOk1FSLREud
         1KTbI06NbRjTS+Q217gyH0FbZ9qVCyLmb6nmXaFW/kV4J2mnPDFdgP4HqrsvD9iXdUfK
         T+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376316; x=1790981116;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gx9LeIS7ritRQsrqMLcd4L/zxjAWNu+QKFz+8zjLY2Y=;
        b=wIhHeT2QSBmVKhx5xw9t1K9aYb6/XkqKQ/NGm3j2N8/yYuEq7cBvZgHM8hWyeBDgoi
         F21fHDSnlvOwjNYLjb1dhFAQRrwcyIahpT3N8s2QNIVfnXjWvPmkL8L5j3TVhWdjO0m3
         WdVFPc+D8Mfk6Lmgu2T0sd4QG1SvV4QZGu6ZaPd9KUMM/RybTfO2pMtolLk7lzWUMjGF
         PJFNqBpu1lxre6g2vTtXU0fO3ogjGaLOwEP0vNK/+AaV8a9tBDR3EwhQgc5HJBkry8aL
         n+WunDuqnXXjk7t1I77q2zD7jXjzFsf5prT67/K8rCIuwxXO77Uugvp5luDz3rlQ/XjZ
         UdRg==
X-Forwarded-Encrypted: i=1; AKwUvBzbsXk1l2qDsqACE2xsikAHxleLpuClzvKtE9JJcBt6kFwFexV8f1C8cZ1d20Lcjc5vTF0=@vger.kernel.org
X-Gm-Message-State: AFuF++lUAKc8cK58o66OnqJWiH7pjCx7CheHJNdP4DUpulYmX9+kILgI
	R87ulDGqPkO7okCl57B3QFGVLFU9vMAZwyVuaX7frxuy2N5+u8CFtGxWO7rVbRPTu7kmRPpR2aS
	GIF661g==
X-Received: from plcx4.prod.google.com ([2002:a17:903:c4:b0:2df:ab17:418b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2347:b0:2dd:ad74:ac7d
 with SMTP id d9443c01a7336-2df9499fa93mr29964265ad.24.1790376315955; Fri, 25
 Sep 2026 15:45:15 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:53 -0700
In-Reply-To: <20260917172651.3322899-1-jmcrey@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917172651.3322899-1-jmcrey@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037627254.2353663.6279505707782779751.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH] x86/msr: Disable PMU for MSR tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Jeremiah McReynolds <jmcrey@google.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 17 Sep 2026 17:26:51 +0000, Jeremiah McReynolds wrote:
> QEMUv11 introduced a check when PMU is enabled to ensure that the
> virtualized CPU is the same as the underlying host CPU[1]. The MSR test
> always runs under GenuineIntel with the max CPU model, so PMU is
> implicitly enabled. However, when run on AMD, this new check in QEMU
> causes the test to fail with the log: "host doesn't support requested
> feature: vPMU".
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/msr: Disable PMU for MSR tests
      https://github.com/kvm-x86/kvm-unit-tests/commit/8a6e3be3745f

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
