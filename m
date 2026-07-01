Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1525B0A4
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914991; cv=none; b=iyEnas+tKujCeIyw2/9JqOzy9Ez8OnylQ/K56+wm9JQ407N2OA/PEh2YZEjRqJMw8Wgbp36O7VgYbBiX9zcThCsTb6G34XGLiDDjUGbU1LpE2f1GmwHA2gSMKELZtjBIf4GbOYa9IEpayhnIufLYh+bEv36Vxh3HwC4xttQ2QLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914991; c=relaxed/simple;
	bh=/sr91loe9W4RvifNHYj9UGLWSj3pbwpvuFkrlANxfpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PTNbpsvgZVNOPAp/7oJ6fjqPhwCe9Z4xIlF4P4f3nRghes6fSMm+wKWSyuoY4Aib5oVl9C0eUWLY5rrtosDiW6L/sOMZNkQEq0m/JMV63ErkT/xq47jF/JYju7XKh0TZjvfucKITaBkJsrnfqvR1DMeoAgNG0tjqy6QzpinY0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1LKeBZR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1LKeBZR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f544944so556636b3a.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782914989; x=1783519789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldpJ+7aHm0XYAwJiaAWIKE/KAgfqi1hCGBrBocGC8Tw=;
        b=f1LKeBZRTsl+ziPyxIHZv5EAyQhKWhFu5lx3F7MlyVDwbXQBGVlLPrAD1xokoxNUS8
         +S/cY61vQsy94ch0Kc5NSwb+OlxhXx8fIvz4GSupyaF/s/os+eOOw5NqgVdtdQMSI9sW
         6IpYSPP8UZEbvHbSsiYac9FbopH5xb0ZKYY3nyzqGYnJ70mYrEsKGp+6bAX2cPkZrHkC
         p/whFIAI3AgT1TSUova4Bnul2jVStMPx/lTMAl6zAXMTJs93wo2eQsGsulEGJIb1i1jY
         2zrhvd0rKRYMaGJGcyOu5wLvm4AeEA7YWMnlJ7R9F2o4eiZv2ZJorXKfup2zx5zJMNfi
         D6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914989; x=1783519789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldpJ+7aHm0XYAwJiaAWIKE/KAgfqi1hCGBrBocGC8Tw=;
        b=WCMpQBxzp+ltR/gOm8CzopByyw4Xg8IQRqHF58oeWePkKf74BmrmOFrQu8i9jmrfKD
         HazE4uA9dNnGZNW2erRjGm9InnAPsX69zX9AIgpDJfQ0E3iC737YwYyXkkWS4v/57U6G
         EOgtzuNbokpfrCLtX7YBIjlixpXS7R65fXAXeT0OHVaUJOsMPJw6V95anqww3QtdQhvD
         3JwlU2XI6jYyhS8eipYEH1w5AR9WIMW/R2YYyEOOaqf7W/L8cHTeymMMI5sS3J51JUyV
         UE96Eaj8KY8/QayDNaCSLA7W/0Dv2ie856WA/4WR/tEXx5hs+NvJtJiGi4u05x+ywqhN
         mJ3g==
X-Forwarded-Encrypted: i=1; AFNElJ8W0T60DcUDMeYq35xSO+2ltDatqxvas6rexhzFn9NRbQWRsNti0F5yUCvtZL5TRG5iFvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfhGz0lbfVA6kIyTGTt+TwGZDT3qdv36jzebzJM6TDsVJ3z6+
	adzDwFGA9C+pnyakXHTIMAtrEVAVgtuhIHQRxiobX9JMctFSZuWh2ohN2+NDA45eXDtccKCWqqf
	6exPgpw==
X-Received: from pfbc4.prod.google.com ([2002:a05:6a00:ad04:b0:845:a3d5:fed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4291:b0:845:eb7d:8aac
 with SMTP id d2e1a72fcca58-847c51b7032mr877367b3a.47.1782914988872; Wed, 01
 Jul 2026 07:09:48 -0700 (PDT)
Date: Wed, 1 Jul 2026 07:09:48 -0700
In-Reply-To: <20260701024521.kffehv7bxcjc5f3y@ewan-server>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com> <20260701024521.kffehv7bxcjc5f3y@ewan-server>
Message-ID: <akUfrLPAAUuD8zRZ@google.com>
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
From: Sean Christopherson <seanjc@google.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com, 
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 01, 2026, Ewan Hai-oc wrote:
> Gentle ping. Any further comments on this series?

LGTM, I'm just waiting for -rc2 to start applying anything for 7.3.  The only
question is if Boris is ok exposing all of these via /proc/cpuinfo.
