Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577866;
	b=3vPInCssGEL6BWdoCTqZFmweSxFqqaCWhq0Q21Ap0zqwttNcHbCv+CWRCS5k1pCauO2O
	 dR7+Hrc8Qs30HuK/sdWjw0V0kks5xMNSgTPZB28DFXLzIewUwScAr04WJbkUQNs0KEw+G
	 C+Wvsx3IY6T2Sn0vZD11U/kdxUGhOTrThsXYzlr0sTY5v1N91w7pdMzYbGpmw2hBuP81G
	 5w5wD8mKeznCRbawNdgW2PaA+lwhhIhQIs/cnpVOzu4DC+ripjgSjxvLrmotFf+y1zZJ8
	 xjGfhqWQ7tRZHINPBLBEE6MSu9jKpUU8gYx4S22tMVCTi5sKgnWpTEE9F6lLxOFHQpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=kXcht9P+JlFAWDjvNBwE3nXsYUOs8z+TyJ2+cP3q9Yw=;
	b=H3t48e3E8z7LQCzMM9IvJyqm2gPX8PS5D57VFtsziNOXUIJzF/cYKE3iCBKVw3Jm5cR2
	 ywq5VRBtwi9WzQJuY+dgtAAVIyqnqBmT/gnAvwYCXyigY41Lpgo2mdtRhkuCoXszR3ylE
	 KjVBn82FgPaDE+nsP5qx37MOWJ22N1duFkYvYmZp3DTqKVyUin76MUos24cuHIt5QJjSJ
	 wmiXSLyWsCXL71M438gnMVE/BsNtZ9dg4ADNl83HeuSfGoiHTNtrG6tgyhyZxOAfwZn5P
	 6iiq2zEQvuQTIlFjv91U+9rrTzJTuGjFUsy5kMBc0dMXvcrNe+oCAizwaN6n+0DA3CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=omzjmy47;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E7606A330
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19E7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=omzjmy47
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b09a466295so721572a91.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577865; x=1795182665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXcht9P+JlFAWDjvNBwE3nXsYUOs8z+TyJ2+cP3q9Yw=;
        b=omzjmy47L2fSY2Y5fdXegm4426L+6ApFXYiWB6LN1Mc5oWkRVfyCO6E2LgqN9lQ7dL
         HI1q44cMbtFmX//vHoaDda0vaS6GzVkzcfgAyyv04Lim/nb8G8/nDgjF/u3urE+g3G5+
         ym63ZUYL3nHosUBKGwMw0gWSJ+fIOhWRwfOSSeNcz832T0OB5usjffeRL3HZd8oLnFE7
         Hajg1uoCmFMoN5Jg3TPtuCkH7PNd3+9gFHreuhCCRJ0u2CMtGswQpABzbPlJSIZtFVFp
         y/mBBMgT6z2Jf0yjOlxEAfDVeTs0aVY9li8mGbltauIjwQB/o/KA+tIQV9TizZPHveeu
         bUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577865; x=1795182665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXcht9P+JlFAWDjvNBwE3nXsYUOs8z+TyJ2+cP3q9Yw=;
        b=DAGTZi3n0ovpx2p9NWkSSH4OrHpKmsk8XJbO4Oko8o146ttfdjlV/ndT8STo5xeixm
         v1dEZFqgtMF4Dhrv1jT+5eNmjW5kgSxhd6rGPhiHir+71vXVwVim6X6qHyK+5EqIcSQC
         +SGHIm/hNYVRip9bHDVVyKF0lzsCe5FmWQU1GEKuvnR69x9DFXVvanJwyFaUiN2oAqAP
         K4isVV7IFWtxKr4yAcnUruD8SK7uXLK16S1A8vtUZezpHHCqG5vtBswXaXSEU92G29f0
         PknB0dU7WOpWdwtd6mEbjDXxruYtlIXwV7GzYiI4Bqbzs4S96Q2ktsYhTh5557H9Kiz5
         Ktgw==
X-Forwarded-Encrypted: i=1; AL+hErFwKBeUlCCQmLts9oNmte72T3jNrQEuUdCgMZQlzCq2y1tK0GILmhJlmLxPzVy7aO4FkOw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ye5+5NmhxQsIkl09dJmaZca/mSVXOB1IDAEItROOHMIV3m9EA
	MT6Cz+7KuYnNW86/3jdcq5TJsH57pt21UcZ/iqtqEsFP0/3JPyq2SL3m0XwU6+SSEk7edGDUSw/
	H+CNeVg==
X-Received: from pjbqd6.prod.google.com ([2002:a17:90b:3cc6:b0:3b0:979d:e867])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5906:b0:3b0:934c:5e41
 with SMTP id 98e67ed59e1d1-3b1b0b4acecmr2199158a91.29.1794577864940; Fri, 13
 Nov 2026 05:51:04 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:06 -0800
In-Reply-To: <eef6bc34bdf7391c5d3eb4b1ba5e97819e22ae8f.1791542392.git.priyankamani2100@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <eef6bc34bdf7391c5d3eb4b1ba5e97819e22ae8f.1791542392.git.priyankamani2100@gmail.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441834884.81867.15216676468170040644.b4-ty@b4>
Subject: Re: [PATCH] KVM: selftests: Fix ndata size check in test_mmio_during_vectoring
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Priyanka Mani <priyankamani2100@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Ivan Orlov <iorlov@amazon.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 09 Oct 2026 11:30:17 +0000, Priyanka Mani wrote:
> test_mmio_during_vectoring() verifies that KVM reports the faulting GPA in
> run->internal.data[3] when an emulated MMIO access occurs during event
> vectoring.  kvm_prepare_event_vectoring_exit() always fills five entries
> (info2, reason, info1, gpa, last_vmentry_cpu), i.e. internal.ndata is 5.
> 
> The test, however, checks "ndata != 4" before dereferencing data[3].  That
> predicate does not actually validate the array size: it passes for ndata ==
> 3, where data[3] is out of bounds yet is read just below, and it spuriously
> fails if ndata were ever exactly 4.  It only happens to work today because
> KVM returns 5.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix ndata size check in test_mmio_during_vectoring
      https://github.com/kvm-x86/linux/commit/509f344f9480

--
https://github.com/kvm-x86/linux/tree/next
