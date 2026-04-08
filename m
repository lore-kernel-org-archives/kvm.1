Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C553187346
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 00:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607345; cv=none; b=gakSE5z4DQ3NcJbf0wXqADdJnRv6hgTPngAXLUL9GfGmTz6nZVl5Dz3kVyxPfdrvkijATdKGrn0XwULYv2eefn7zD1PDeEICXswWqFDEEa/sQskGKsFBaBps1M5RT0gJcEaYf/IMZawAGODn9Dx6y3YV9W2BQXL7XjY6aHsdiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607345; c=relaxed/simple;
	bh=0znJrYjvCQG1pTkK1jGXLvlNAbNa2nYLKo91Wtn6lyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lINz1CWNtM/NyL9Q0dXP/w0QbjqCnJ5XV2MQ+IgXm/1Q442UAfJ0H88RO7C6GxGgHlAYQdgW3TpEkxXzlkUC7sg2WLmrkz5ZmyHWC+zZ+RFiQ/5RLN3E2r9VfoPh+Ehy8HPhhnW5qdbLsSkGYndw83LI4p3uQEHxvfOX/55hQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f7205h9g; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7205h9g"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso9030769a12.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775607343; x=1776212143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgIJb1V3vT7GN0oyHj5tFQZZtxJZbHWkMCgOqejkkVU=;
        b=f7205h9g+7HmpA//Ol2Ao/QVkqxaeaY712Iq6aqL3oElcB9f9Y926urx3tOwGH6ib0
         hylyy9aaaD0ymG1wdHLgeougTgcsHjfArabb4HzzbAg0e5Kr/UNW2siMvwpoa5sf54ay
         9WhSy7R1x33iqFuRD2HZSmTGR1MmnfgwfmthM24Qs48dNjDiDXa62AZC22l1fJxRiDtu
         ylLCfoSZ4JXa8wW8qH0wX9bMOgSF6jkLRt99vci3E6jGsKqu5h/V8y7Gx0buvJ6/GMxP
         Cd/O42emtY3vD5qXEBYtCywhUBkvqNHEsQLEyrWaS6GWu3l20zW6vlB3cWRmxUnMiyZL
         Pqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607343; x=1776212143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgIJb1V3vT7GN0oyHj5tFQZZtxJZbHWkMCgOqejkkVU=;
        b=nXulzjE/WCSO8gZ/2QYqf3mTajf0LXFRnTb/BO2f4BI6zYgI5C0Bw/ZkzM0cTgD/HF
         HrhJpMH655i1Oq4/nDZJqXe/OghKodph1s7lhzWEXDDKk8yjVjhabiNgSGZZkAngIbh+
         iv77k1zwyz2AfKZOytg3M2Zixoj7YNONTs9cAZ+Gz8hL/B4WZdwoSSWbz1h1e7St/hGO
         yaEE9m0oqqsBBGbXUd98PrJQlW+lGxUae6PV2K+TCEpGz4znnPkhXQJMq0t0yUq0hskn
         Y7emO4ggveaGgY1ew043RbtDWCX9FjgA4ogtrL0qK0HbFEGzbVUKDsGu5HRKVXq9HPvB
         D+Cw==
X-Gm-Message-State: AOJu0Yx9qvej8iQTkjFDWapZuUZfsw/BuTKNEuzmF+13DsIE0cw/GARy
	K1W7QNVNrbboiqw8j3BBwUueWapv59nt3geMp6A2bBqkTPROAGK7zIh539kHnu0SOORYJ6zymSn
	aLQEWSQ==
X-Received: from pfx26.prod.google.com ([2002:a05:6a00:a45a:b0:82c:6a93:7b28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e85:b0:82c:6aee:b21a
 with SMTP id d2e1a72fcca58-82d0dba215cmr18974021b3a.45.1775607343141; Tue, 07
 Apr 2026 17:15:43 -0700 (PDT)
Date: Tue,  7 Apr 2026 17:14:42 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <177560710937.1573084.15200109469710775935.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: SEV: Drop user-triggerable WARN clean up REG_REGION
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 12 Mar 2026 17:32:57 -0700, Sean Christopherson wrote:
> Drop a WARN in sev_pin_memory() that is comically easy to trigger, and then
> clean up the code a bit.
> 
> *** WARNING ***
> 
> The last patch impacts KVM's ABI due to a size restriction that's applied to
> kvmalloc() but not vmalloc().  If my math is correct (definitely a big "if),
> it will only impact VMMs that attempt to do KVM_MEMORY_ENCRYPT_REG_REGION with
> a single region of ~1TiB+.
> 
> [...]

Applied to kvm-x86 svm.  Like the other large set of SEV fixes, I'll omit this
from the pull request if there are any problems.

[1/5] KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      https://github.com/kvm-x86/linux/commit/8acffeef5ef7
[2/5] KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
      https://github.com/kvm-x86/linux/commit/12a8ff869ddc
[3/5] KVM: SEV: Disallow pinning more pages than exist in the system
      https://github.com/kvm-x86/linux/commit/6d71f9349d9b
[4/5] KVM: SEV: Use PFN_DOWN() to simplify "number of pages" math when pinning memory
      https://github.com/kvm-x86/linux/commit/7ad02ff1e4a4
[5/5] KVM: SEV: Use kvzalloc_objs() when pinning userpages
      https://github.com/kvm-x86/linux/commit/a7f53694d591

--
https://github.com/kvm-x86/linux/tree/next
