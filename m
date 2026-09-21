Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC594A4990
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999561; cv=none; b=dBies18IeEqMTZSP6BOwzPgNeE3Z9HI4oP2NYQ3LZJE9wpID/trx7TFHG12R2bVI5BHyx45bgVZhFPiAz1n4lb2W782Sr5rRaeVqbn/LOkFdBlRdf2X6FD+2ASpecOIk6IMLHPL3Yxr9bXekwX1Fkp7rsxxzfDx7Bkgu0eFjj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999561; c=relaxed/simple;
	bh=YCLS+GpysQVlR+Gg9J8dCevTLbKjdQeJbJnZ1IUK5DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PHWlqwgOVf4nYPRscYSUggXFJ2UAOmkYlof+K/hpzF3I7/WVS7FEOU4zpwQm90eo+W6sr+EeBvUDIAjiGdDDjSX9yDsPHyFT6Qi8U0N+NDS82ViSGP/R5PtIvodjPW3++RyrW1nHl4maq4LltPUFQ2cu3lvsqm3jduLZ6pjPnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT/GhguN; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT/GhguN"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a59faf521so5030794b3a.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999559; x=1790604359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o2Nhmlqu7ytTbKiYkM8wQ0H/blwuXmMtC635O5Am7vU=;
        b=nT/GhguN083dggGi7fyo7f1Xzerr0Y7cRRxRLJ1nQZzuqTeIdGcJQZ2c+fw/XP9d41
         YYDyreZRzRnbQNdMhC9ER/DDtr9vZThkrGVA6B9uonl65lK4Qst07XYvtb/9F99EXGpO
         YfeA/YNz7ivHQo3hyFNkUC2XmtPX6Vt/anksW06xH1lJUN328hSF/sdFl6qDhCLG1m1J
         dBSOthrdNrA3JEgKBJPXTH/8W1aRem9LWv9SdnEaypuDDc3/hedhFb9/E/8BykI09UKi
         kvvaRNis6HOMUtR/tbO3bgbdUXsdgLHJZNyaMoRjfXe3WvBLZ3m/apPPT4UXXz2eQ55F
         1maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999559; x=1790604359;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2Nhmlqu7ytTbKiYkM8wQ0H/blwuXmMtC635O5Am7vU=;
        b=i7256DPZruthFtg6mHRjY8bDbMQ69lBLLcb1wIxRJxGRLV9R8Ffplk5za2Ggh79rx/
         YfuwalY8C903iQsZilszeTvfIql9yxyCjj8zqsXRXQejHo9z+0X4MODDum9P4XO7S8RH
         uYQDJAlGTOmch6ZQ6gYQ5/XSdytf6Du3EhloIf05jtF0d2voab2L6Ft4YfrYQSPQ7O5x
         K9habwulAIkPjkBubF9iA3e0r0jusAV5Qb/eUpRZXsaynlnBYmoFzwuiY3uBFTpeBch/
         I8OKLp9eRBi0ulAHkOXdiRPWC8b5txlPp2w5HoNOcBuo0AF+oO65PaT0CdVKGFOTB4Da
         nu5w==
X-Gm-Message-State: AFuF++npuauoiwHF/xtPtr4zb7asx+9aDPNgkB25ZwhTVyOEKtchHBck
	Uk809HA3URL+z+ruIn27DExQbStQ8fXVCqpGH1KS56ZNRswH5/Q8Ghx0oW7rQ8RInF1sUKVYJth
	/xrU81g==
X-Received: from pgvm9.prod.google.com ([2002:a65:62c9:0:b0:cc5:284c:de35])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9086:b0:3dd:a196:9077
 with SMTP id adf61e73a8af0-3dda196af91mr11271682637.65.1789999559066; Mon, 21
 Sep 2026 07:05:59 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:04 -0700
In-Reply-To: <20260826161430.714316-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826161430.714316-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999853712.734513.7564161913562650394.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect
 actual glibc
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Aug 2026 09:14:30 -0700, Sean Christopherson wrote:
> Use __GLIBC__ in the hardware disable test to detect when selftests are
> being built/linked against glibc and thus pthread_attr_setaffinity_np() is
> (hopefully) available.  As pointed out by Sashiko and Hisam, _GNU_SOURCE is
> effectively a "request" macro to enable functionality, whereas __GLIBC__ is
> an announcement of support and selftests' idiomatic way of guarding code
> that's specific to glibc.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: Use __GLIBC__, not _GNU_SOURCE, to detect actual glibc
      https://github.com/kvm-x86/linux/commit/f13368e0acff

--
https://github.com/kvm-x86/linux/tree/next
