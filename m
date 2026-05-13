Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D81862
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 00:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630612; cv=none; b=J7uOgs8bQiY/Pm8O3zzZk94kWukcEi3N5mDDOOLev2k2BixvFtBWqa4VyBuNBucsNEcfBmZQNR0SgH8JFNaNggubKWsO/OM4wwMc3I67Cajt6/9Y6EVhVmd8WEcUbCbWxh8BLYB8IMBPpbQfe6HhOTGrXeSUGHjafJOBA8lNaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630612; c=relaxed/simple;
	bh=+ch85OKLdj3Txg23okTv9mOTPbJG6XVn6Dgb465/Q64=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bKnV4A+1v37tZqUrRApi4N8ffbsPReuUvz5WZ2pjGE+UHVPTa4ZfCk5JwvHd2QMMChAIGXRpgD07wFSYHYzx3DKMnSUX/i7eUOpBo+hDlNCXnX05TraqBJ30NUApkcW7R4To7RekUiNsI5kkDKFE0v+PfjM6jInLPdZyZXvu6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aidBCEto; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aidBCEto"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so65219325ad.2
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778630610; x=1779235410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwPr9KzMTwvYnVjMUfpiwh1INt0dAKct26Q2oFZfRtE=;
        b=aidBCEto35rP0FYpFWX1KwOHOh68rbt5RZnJJMt55VbS/npdTkzBaXXzJ9QEYmSZoX
         +tXOXwBITqtTe0idtMTt02qotSe71HmiJ5Vgis45vg2z7CCJXk4+8OPjb95BfeFUgdF3
         meAuYF9Vbe15XRwBSYgKbqmTtSIzF37VsUG6Zx5ASfopLtgdyXFz8wyfDRKaphF12ksh
         STM0UtKd64HcCdd5BWjwUZwg2gysqgaDCR6/9doV9XIoAGSasFZ+WrG8xGC91i5+Eiei
         J0Zxt85C+kJ45mM1milJ240hMHM9gM0LGIIaGwYmn64Z70L9fWefIcC+LDCFTMSpxq8L
         PpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778630610; x=1779235410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwPr9KzMTwvYnVjMUfpiwh1INt0dAKct26Q2oFZfRtE=;
        b=M51e2YncyGvbuD1NZuuqmdAMZLJggwEJJcD0g9HD4TSdI3KHaxQ94PjJjaSzV+wiUM
         011S2Q3Oj6pF5vt22XWF8+JjM1xhSrmI7T0meMP5nUWC2PJ6wkCAyKbXSF51CXtJ6fw4
         QZHd1wS10bDjNdRXdm2v4ag6uaepImU4LjN1Q2bGjPocSNDYYp2fQEwoEOuNmujKlZzd
         hyctScWmDbwW4joYLbJjzmoNpP/sqIOGgRtbHDLylLzcmsGVgYw6kMjSL5b0jMHRhlYE
         mY7nTEnJ6DreB1MaxaY7KR+BWAYv16x05qMCCeySGe4NcHdhS0K5sIZHuqoGnTPdqtz/
         kEIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XJrbCR6wL/d2qfSa6yi/mPbxcjitRqWeHSPCHe7kA7fQlDUu7iMCWyBzvT7F0VVPPREA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwkjPWPK6gcI5Sosy3hlxK4nzjlCsyQ22m7JYf9GvQgT2k/z6
	oOngtawo5rYj59TfhLTYOdGD2muEsAYfjAk+ct4mQok4VwdjkTRgX8x6qMLlT0ERC03qDPkUs/4
	QZggUpg==
X-Received: from plhs10.prod.google.com ([2002:a17:903:320a:b0:2bc:bb08:92dc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8f:b0:2b4:5cb8:99eb
 with SMTP id d9443c01a7336-2bd276d98d1mr11087365ad.27.1778630609922; Tue, 12
 May 2026 17:03:29 -0700 (PDT)
Date: Tue, 12 May 2026 17:03:29 -0700
In-Reply-To: <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn> <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn>
Message-ID: <agO_0ejKd0x38_-E@google.com>
Subject: Re: [PATCH 1/3] KVM: selftests: Add unit to dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: wu.fei9@sanechips.com.cn
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, anup@brainfault.org, atish.patra@linux.dev, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, wu.fei9@sanechips.com.cn wrote:
> Currently dirty_log_test hardcodes usleep 1ms in each interval, which
> could be too short for guest to write and fault in enough pages, then
> there is less chance to test the write protection mechanism, especially
> in the case of (log_mode != LOG_MODE_DIRTY_RING).

But when log_mode != LOG_MODE_DIRTY_RING, the individual sleep time is largely
meaningless, because the test won't reap the bitmaps for iterations > 0.

			if (i && host_log_mode != LOG_MODE_DIRTY_RING)
				continue;

>
> Unit is introduced to replace the default 1ms if specified in command
> line. The following test can't trigger failure on my riscv vm:

Failure of what?  And does the failure really not reproduce with a higher interval?

> 
>   # ./dirty_log_test -m 21 -M clear-log
> 
> By enlarging unit, it fails every time:

"unit" is way too vague.   Even looking at the code, it's not clear to me what
you intended a "unit" to be.  I'm not entirely opposed to providing the user with
more control over the innards of the test, but the interface needs to be somewhat
intuitive.
