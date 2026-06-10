Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A83451CC
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130200; cv=none; b=HiTBCe3RkzeDs3e/mO3fbPTflVnQ+/Lhyl8bjDnBIg5u/EmaFqQ5hLBUidfSCVdZL9UuPBu2sSoTtVDuRwpvzA1xxsGSBKtLJ17LKmN/kI62ZVBf+YUzAxTLdXaz8FJtcsMCu7XERtn6TwnYCsO1xnXqTwJ99mCqXzWFVTLQGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130200; c=relaxed/simple;
	bh=qAjd2/KUhCE05aLK86qBIKOiIpOhNXWGC/5z6iGv760=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZJmKBUHuSXYAIBQTU7QzVEhRlairulx3hRurZHI2KPGnIApMFCryPeuy5QMbqsOjnT6a2y2zhz7WST6F+/Z8sAN8FNcrxXQGISmEdwm8NF6IXJ2VADVlyETVjs2fj8mMvgaGUIyEEVIqBKvb2vOuDFwL8TJGX7GhsVx18kdyp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/y78KOp; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/y78KOp"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf55c3f44aso2207005ad.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781130198; x=1781734998; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=98nQEvZDyKKcPdn3AcVzWFv9XYmn8L+0P9K+2v5L7Fk=;
        b=v/y78KOpMM8Epdinj0Xd1ajiQGJ9nvLmAuLlvnNN5mC4ejiucVZcg1iGoZf/12aAoa
         ten+bmESuXsdcP+YVqnpO7vMWHm7dOm7LxSCrDZH9Qm/3AtgtBAVQhA7/N8RirUKtbxd
         wyiW5hY2MiniyOnEqEKUh6fBTZPo2FvpttmZylPFqs9nh9mE9EnwJ6LKdSSwItCt2xiF
         FBbGo4j9qn8cAH1sqgrtZ8Kfs6vyBwlVdV2l9LiYQskgBRd4w2or4xutpD/CTi+xGa6s
         riN21OgqjBNctSNpy/6f2xk4rYgNsXb8fGoIStUcoB31NggKGLXJVp71Om83RhR26I4E
         Qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130198; x=1781734998;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98nQEvZDyKKcPdn3AcVzWFv9XYmn8L+0P9K+2v5L7Fk=;
        b=ZidOSJJZK8v9kuuS4OnuVfCm7VcxfBQJf+IBPZdP9NuOXatf1dS9bmMmsSC4trZvx6
         sNqrGqWa/eG9cfD6JTllIkOkX3OrKklhITJIoEbT7tM0GpzdAmvDFWm1IliP0sy4WTmM
         HrnnQmbaV+0I28zQ9zJNoPSeTL3XoKI9ZENWHLzQ1pWoHJwU7G+RgI6gtABGaG7DOsJh
         JRV7ji4UFLsfejK/hJEGhgaxiSw+SAmbGMjNB70l6aBHcvCaGtQstdQ1WUHRS94OS69G
         INPUi9m7Ir70S157W82NL9qeY2tWtJne78ZLHDRADRibCxu5VPQ11lVZcCUPOfd7q34l
         bG9w==
X-Forwarded-Encrypted: i=1; AFNElJ8aViizJCO34AX2JUDkBf0Y5KZXuelXCe8DH9yF1MQZArZDzoJR+M2w3O+NY902rmjv3u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAA7oA+9yVWWUnWkCnwPeyIgumvVqN83QeJXgtAiJViuU/Gh9Q
	vVDJ/Qo8tDR8uPvew7bEi0fQjWMnPZPiyW7+/MCznbgZh2nq6owaCfyopjCwgi9vuqzdpaCVBYk
	wZ1MC/w==
X-Received: from plpv10.prod.google.com ([2002:a17:902:9a0a:b0:2bf:224f:daf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6f:b0:2bf:1aa9:6c8a
 with SMTP id d9443c01a7336-2c2dce83fd5mr4806375ad.12.1781130197572; Wed, 10
 Jun 2026 15:23:17 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:23:16 -0700
In-Reply-To: <20260522-gmem-inplace-conversion-v7-6-2f0fae496530@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com> <20260522-gmem-inplace-conversion-v7-6-2f0fae496530@google.com>
Message-ID: <ainj1B4jB_XihoHZ@google.com>
Subject: Re: [PATCH v7 06/42] KVM: guest_memfd: Update kvm_gmem_populate() to
 use gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, May 22, 2026, Ackerley Tng wrote:
> Update the guest_memfd populate() flow to pull memory attributes from the
> gmem instance instead of the VM when KVM is not configured to track
> shared/private status in the VM.
> 
> Rename the per-VM API to make it clear that it retrieves per-VM
> attributes, i.e. is not suitable for use outside of flows that are
> specific to generic per-VM attributes.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

We should squash this in with the previous patch, i.e. wire up PRIVATE to gmem
in a single patch (sans the ioctl support).  I had a hell of time figure out how
the range-based lookup was supposed to work when revisiting the "wire up" patch,
until I realized populate() was handled in the next patch.
