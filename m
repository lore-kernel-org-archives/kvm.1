Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D73FD970
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814535; cv=none; b=Ajw/KJvzXueLdKAGHwZS/rBLnWu6C9mFf5LG/dpNeGsy43VAe9BeMNzPjhqeNcY3hF7B2ihS8ZSvfh9x0mahXACUFbZZdMMpeYbbGEjvKZGlQC4DT1aiFTSy2eoLWH/UOYoXnIKNrNHDrTCVWjOvOxXBPR1sJfbmN+qThYJGMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814535; c=relaxed/simple;
	bh=lS88pgO4vl0WQoEIrTfiXdwjUHeGJQ0+p5JkXjqIuL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PnvAFp9xHcON2Ik2KG8JDgXCZOmPWaUlcFiSMP9pqZqhsd+DiiIAcW/VwROnCGhWHac95Jj6J1OzZKIv7QkSq54J5rGdpyAnFNj38WW39Nks6qLn2NnE00tKJm4VeIZHnlsBCB9yV9/AvlgCU4f3I0+5pPYEx83qZMmLUOCRQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j37vd0hP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j37vd0hP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso6940022b3a.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779814533; x=1780419333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZT31wOgcdRUmGTT5DQeYgf6s1URS8IbeXG7+gb+Vm8=;
        b=j37vd0hPHYczoNM5Gcznb5RSBUDWvyG3nNAnMaq8ZKy/cPbiFfgG60jYs5dJJgFwPC
         XTnv6SXr6o7QSvLnGGwxB+A58zuKGIWVRBThB1tpGqAeKceULrRcVhaeiea+UoCOHksV
         QdG6x8G6UVmzAnT9+vSeLcdCX8YRfmRDI8wKrp8OSRnZL5bK0KWQjyv9pzo7bYGEf+6i
         NzK4qIUc9qcEzNODJs1oTw7+HkJdiAF9LeOSIPygMkTqfs6Hq7MpZi7KEPP5HQYsHwWt
         o8ANiYhz4Aibu5fCXJkplfW/NfMED4ei2WKBDiGUTTDURsbEgnBIOWp889kFItbhlpaO
         MAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814533; x=1780419333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZT31wOgcdRUmGTT5DQeYgf6s1URS8IbeXG7+gb+Vm8=;
        b=iCkHW8D6znJ0GQoP5Ea3hOpEgqSVlVtoyVGWBLSX6DDaI0kQI5QcAMX7awWrfSFnbr
         evuNWYwMyj7n7oZ1Mcbl8ZPIuGkgX6bStSKf1KDMoXXBDuqOEmsmEyawSa6oUI9G9lVI
         cmbSbZpir0bc0I9JYL5mrm3kepdiFV0d6w0Wy+SlWrQP5N6HjcGL+AwyPVyYkFRkv392
         dB0Iklcp5fukTkhs/7KSOXTWHSjCj1PAfzzARK9w8tc+3XRVBwOm7VZU6Y0CHtQD8YPI
         ogZ2qrasu5HH6i/v74vCWGxhDo2praVQcluxaaeX1JX+Eyhm5EPH9n7iK9l+a0KnPwn2
         i9QQ==
X-Forwarded-Encrypted: i=1; AFNElJ8P4Rgei+xN/98YwzBMxDsKQEcbOwiPTW8MteU0Hc+8L1sl78uXXEpHyiG6VnqYdOGgp8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KcK7CkltZulN9zdfBB0mmbuolw2MDh0aZmf+tK+btYe6NUJ9
	rxrNXG4k+bK7t3xx9ImK5KRfsq7SWVd1/8j4ZXjUARXgm70Xlwus4ENhOHjcNpms95AXpEJN5s2
	zuCtWiQ==
X-Received: from pfbfx7.prod.google.com ([2002:a05:6a00:8207:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:298f:b0:835:3d5e:1dd3
 with SMTP id d2e1a72fcca58-8415f586b5bmr17521220b3a.42.1779814532656; Tue, 26
 May 2026 09:55:32 -0700 (PDT)
Date: Tue, 26 May 2026 09:55:32 -0700
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
Message-ID: <ahXQhE1EUzlyetq5@google.com>
Subject: Re: [PATCH v2 0/5] guest_memfd fixes for bind and populate
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, Ackerley Tng wrote:
> This series is a group of fixes for the bind and populate flows for
> guest_memfd, and fixes some issues reported by Sashiko after reviewing the
> guest_memfd in-place conversions series [1] and another fixup series Sean
> posted [3].

In the future, please don't bundle unrelated changes.  The SNP specific changes
are related and should be a series, but the signed integer thing and the lack of
error handling on xa_store_range() are completely unrelated, because the fact
that Sashiko kept complaining about pre-existing issues.

I totally understand why you bundled these together, but that obviously didn't
stop Sashiko from complaining about pre-existing issues, over and over.

Unnecessarily bundling can lead to exactly what's happening here: the three SNP
changes are ready to go, but the two unrelated guest_memfd changes need new
versions.  Which isn't hard to deal with, but it's extra friction that is easily
avoided.

I'll apply the SNP changes, and send a new version of the signed vs. unsigned
issue.  Please send a new version of the xa_store_range() error handling (or
prove that I'm wrong).

Thanks!
