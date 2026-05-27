Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732A47D940
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905689; cv=none; b=FBpMlOdERwVMYCu0DYSjdPb09ZGcE7U8GHGP3JaEByn/ahSm/xAZDRsqiHuN7KCXokUi0hYqQBQHRj2ItOLAOjVWBZXw2Mf0Jma340BrtJ3A3Rt90cT5AV3IkauzxV7IX8SN2fnrJrUGyp8ERG0Lac7u4p7cru0PA2Cqkjdo/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905689; c=relaxed/simple;
	bh=IplCgbMoYoBtOUyigsKH8IsGcZbhJr+wSJ8fQtP1dJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDh3iNEwzHl+ZtXFmMTUr57hqsj7ZHdeYJjaBtD4H9crVaDmvVSppzrCGij0ZjEtOEI1gThysxO53Vv2/FYp6EcVl18uZCzfmp8V6jaIcPTWXRJ6o/fb8GDxyjX6U8FLn5cHrH8/wm8mWpc8zdjHn+sJxckxNQxTdREUgcsxTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjUgFqAm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjUgFqAm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82751074c8so16803851a12.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905688; x=1780510488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MatwPqcyh7jWbCNLmZA3y8WH5LgIs06Tvk5cdrc6N8=;
        b=IjUgFqAm8wKNbC8RVDVm9oQu587TAErQYF1zaAD7o5AUayeljZ47d7Aa5yeBb1VcGH
         nJ5+QGfaif/hA9P0zTEzsC31OOzhgBMXuBQvzaCGTM/L7pqwUBmZ3lzl+wcrtfUfWSGf
         /UhsHAK+MPSHadjQj/N80Gdtwg4fqctdSkTMvFSE9uezJF3cISyh1o4s8i95tKqpk7+P
         Ln+T1KQiOek7Cxp+EFNNR4cBDefLa+t++0DOt+wCujuYgqOXAUpyC3dWeBe21oRS5Pcp
         ZlxqSMVopRmb6PhnPSt5C8bjw7UWFJJOhqVk8lfwb/VvCjwCt+8/V4b0FZUBL8En9xpq
         sLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905688; x=1780510488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MatwPqcyh7jWbCNLmZA3y8WH5LgIs06Tvk5cdrc6N8=;
        b=aVzBgem5Q08L8ZLGLujUpIjlaIIzbuI2K8ufqDoD2RnwjMcEXO3vg3Q/yUmtOFcN9V
         LM+HObJymhegO1PnqBhF5Y/npewAxrK4EmOjPY1WnNdheCq51OIl9IwNcfQrtgnIAKEp
         ZBkIC2cQgjrdZ3dm76wXp8eDQf9XKoSXpAR0TBuptSuVSUST55hy0INeMMJ2jI9aWvLW
         OvIR3hYQkEHBKhKgCIsZy4tSc8hFUBTQ8092Oi7mM/HWvCSH+H06f2ns6FYFtvXvs/sG
         rKgETWRr1W9yUB1Ea0NJEi/Wrsi1nYm+6t8A9GMArG+i4svGTJIdMTcKSbW+vUXSsX0T
         UWvA==
X-Gm-Message-State: AOJu0Yz42P3FyClhgH0OYVjE5xO6qmVePI7auo71jJew07rEykQxaJxh
	kaiRZm85MfxEnivZfnB8P8Yxh/BgMw5yY5IYKEr5ojOIzYNkOXaKSjO8q/1xMRmd3fwEb0kUNTx
	JtAK00A==
X-Received: from pgtk13.prod.google.com ([2002:a65:68cd:0:b0:c76:1d9:8c20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6cd:b0:3a2:ccb5:abc7
 with SMTP id adf61e73a8af0-3b328d15b0amr24521248637.13.1779905687643; Wed, 27
 May 2026 11:14:47 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:18 -0700
In-Reply-To: <20260522170230.3518669-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522170230.3518669-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990523920.4120987.9255714954792808956.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Randomize dirty_log_test's delay before
 reaping the bitmap
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wu Fei <wu.fei9@sanechips.com.cn>, Wu Fei <atwufei@163.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 10:02:30 -0700, Sean Christopherson wrote:
> In the dirty log test, randomize the delay before the initial call to get
> the dirty log bitmap for a given iteration, so that the amount of memory
> dirtied by the guest varies from iteration to iteration, and so that the
> user can effectively control the duration (by increasing the interval).
> 
> Always waiting 1ms effectively hides a KVM RISC-V bug as the test reaps the
> dirty bitmap before the guest has a chance to trigger the problematic flow
> in KVM.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Randomize dirty_log_test's delay before reaping the bitmap
      https://github.com/kvm-x86/linux/commit/4e0fdd9b0d7d

--
https://github.com/kvm-x86/linux/tree/next
