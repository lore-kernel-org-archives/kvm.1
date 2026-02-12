Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D475248176
	for <kvm@vger.kernel.org>; Thu, 12 Feb 2026 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930976; cv=none; b=gHimBgmGtBLPXqPZ4jWhWal2VjXQ9ljcGoRXyRzpIDhh+IHZrlwy/2nHqp5pBZsFgBgZGd7SCCOdDRCzNARQ/w/u6vPSZCDHxlNaoD6KkbSVP/XNK5QliyF0DGnynpDzNOZce8sddf6eapPdGQTLpPDb2esJAXN3pKn6aKIXMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930976; c=relaxed/simple;
	bh=RSWfWpGpbRWBApx+ZLjfLxtlxtxcLASQxHTXl2x+rn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kVM/qaE/8ykmDfT4oMLe8Ejb/csRt0pFVHagazmich+WcktLpev4JQo35rjwmoabZw/CdveNOT7ybNWsQITBrW/6IUDQNskacmIOmCJbVUC1tf+D166DMwbmMSj3XDQluQ0j0g5ZL+gEZF/lU5PQCoVe18OprX3J5reWcUsrVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b9u9yKc2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b9u9yKc2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a75ed2f89dso2322485ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Feb 2026 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770930975; x=1771535775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntbMRWd9O7mWHdd1+6mPGyqg89FrBxm9Fcl2fFR7Emc=;
        b=b9u9yKc2RWylriHX5/NmeNl2KUtXeYA+F34ULcTFmFW/F7wxXyA+w+kt3VckSuzl5f
         BirWvA3eMktD7AmR/jKKOPxzIF9nCkxXSHPGwE7mfdaoBe9kxTq1cq6+GkoImgc+T6yk
         aHnLpp87uvxonBGdPrunm+71roiK0lr7l7YCX+L1yz1cz54cJyIDWuj1YnFrcNLJwq/O
         VXsxDzBeqdJ2VX1YhwLM68GrjtefCM1emUBzUqCm3x+oqj7o2piJGcjdDSmFm3+DgAOn
         TfS12k79tMPhldauj3s1NjFGTfxyX7FjhC/ZO7/iIGcijjmS0Zm6cGjhZ4n14dU+Ou2m
         MnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930975; x=1771535775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntbMRWd9O7mWHdd1+6mPGyqg89FrBxm9Fcl2fFR7Emc=;
        b=G/Ujxedanphb+9eJa1KehOMX8UJQKXPYBH5s9186ESUoC+6px/m7M67NTtd87TWlCS
         NsqRCSRk7BE0ZAJNTAXAvTHoZQcn3WH6uNCCZTYkSCXMgLpv5Umd6SzYjzNddEGyMP9P
         7NawWw/aVLB6gOEUEgeFEXqptzG/iqaMpIONAxZs6vDSKZxGCetdDihIOaohVaB5H5Tt
         lkzKbfI3i2N/eh346hdbGeVKk5FDyG9xuSjtKbfcXIE2/RNOzchG+UeRQBuMTTXYEF8X
         DbjeEl4SNDwYVimouzUiAEh8Ko4Rm4sDvCDgu4CX2sV4g3YdwlOAxtyR+L99SmD615l2
         anXg==
X-Forwarded-Encrypted: i=1; AJvYcCWmBz+q0x8MIe5yOB98u9d0sx3YGm0YdsPiU7OPS9sT2udaCN1EY0iDup5yfl8y2lC0tRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLklE2J3cJ+SPoJ0j633Gc/4G2CSTjJmr6kFU+QrQMYS4lx8F
	QiNx8TQ0hu09HB51ft0zjUm2Pclmody7/jflAv3sKQ3U+CZ1c0DPUW3Hfatj/EE4crVuKh557FE
	6MKOz7Q==
X-Received: from plbki7.prod.google.com ([2002:a17:903:687:b0:29f:fca:3bd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18b:b0:2a9:4700:2a94
 with SMTP id d9443c01a7336-2ab4cf4ab54mr3274265ad.10.1770930974454; Thu, 12
 Feb 2026 13:16:14 -0800 (PST)
Date: Thu, 12 Feb 2026 13:16:13 -0800
In-Reply-To: <20260122045755.205203-3-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122045755.205203-1-chengkev@google.com> <20260122045755.205203-3-chengkev@google.com>
Message-ID: <aY5DHUQl3jWnk3TN@google.com>
Subject: Re: [PATCH V3 2/5] KVM: SVM: Inject #UD for STGI if EFER.SVME=0 and
 SVM Lock and DEV are not available
From: Sean Christopherson <seanjc@google.com>
To: Kevin Cheng <chengkev@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 22, 2026, Kevin Cheng wrote:
> The AMD APM states that STGI causes a #UD if SVM is not enabled and
> neither SVM Lock nor the device exclusion vector (DEV) are supported.
> Support for DEV is part of the SKINIT architecture. Fix the STGI exit
> handler by injecting #UD when these conditions are met.

This is entirely pointless.  SVML and SKINIT can never bet set in guest caps.
There are many things that are documented in the SDM/APM that don't have "correct"
handling in KVM, because they're completely unsupported.

_If_ this is causing someone enough heartburn to want to "fix", just add a comment
in nested_svm_check_permissions() stating that KVM doesn't support SVML or SKINIT.
