Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577657;
	b=FEX/+FTWV5WJpKwHQDyTEuddSTyuwwx0DFkwddQKydrKjGHQt8Mo8H5Xk6A6xOgBMcGc
	 woSoYW+RC8AsvTlxxJW3e4+IRjr4A0EDRKjeulxu3Fys4REA1wHEqiKw3AeJdKUz4qKHT
	 MBN98xwMkfuEE5mPyl3sjIOuFSq4dxfE6Z/XfIfSDU1payMIEX+2BAE3b+hEbd+aa8M7w
	 AwvpE3AHRzQTdzJG/pFmVSDyRwi9G5npjHSmPsPCKM1q3sTClEj8tonEGzV+6OD8x3ocg
	 8Xn+EWzVTn5xgrzhuAA5lDuOfmFp5vOU0O2u7u7hDFcdYkEPjD1oqqgShIZf6bnAMyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Uh3RNZiwQ8OEliQwz60GaSWCgjS92PjWqF45e5QPMWE=;
	b=3fiTc5nSY9KFPrSOfTcEATL11dG2r9U+GckVShze/IrnXHvmBA7zeUbhpqn5UFLy5j0o
	 LAeJogdPuuLImLmxbf0A1x8Drscrruw//vBE8VUxiUepZHu/8vgotyp1LXpBYnDM4C4IT
	 hOTExHu4ONFi3RrCNDjClMhh12oQpVs88ml4xNbi4Z0Z4TTlB9cH/QcLeZNDCAW3k++uv
	 sohDc8xMGgDKNIBJ5YF36JJIw3D+WcrVRq0BmdEpNRRpTHyqrZ0wX73LqBvRkOAU56+5u
	 QALFjZr5SknTiJQfUBJQd7LkwKZXWchEViG8DatrAzPerUej3sTx1oALuFGUsQ9LYXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mChKw73R;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1669C606A333
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1669C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mChKw73R
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so771606a91.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577656; x=1795182456; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uh3RNZiwQ8OEliQwz60GaSWCgjS92PjWqF45e5QPMWE=;
        b=mChKw73RMvMekalbwIWe8vJQeNvBuAqoFw9E6LWWYbcMqUuXDvVGlHTLU8n/PqxdKL
         j5K9gDqwD+/0CTMTFAtxDuqyu7cxgmBzY8Ju5hwgNLshJS4w/4lSN3SaYU3JEWz0+Xak
         da8uSjJJ10NkQfa73Hi//PBJluj78+H3S/po8W7LsqqH4uMBbF3g/iYIskDP2aKIdts9
         o7GQQLrvh2y8kGnXVLqcYJMCXCC9Jt9b8+0V65HBdYxpZFkn/ERRJ6MMZIMcrPOgV09m
         7eWINQ8gZ7gPfty3HBdvHYTcxr1IQD88TJYFrwZjM1pbJOzGg17meejlsNBHlIcEqiLo
         XdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577656; x=1795182456;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uh3RNZiwQ8OEliQwz60GaSWCgjS92PjWqF45e5QPMWE=;
        b=DQnPuNdZ76GJSvJLvZ/yJWOfE9E1bCPx3pPA9lxaG1T9gPrT2yiXwIqa9ZTXGnIvu6
         vtGg+M+6UR6MNdf65W/Ei9FkJUA2S3d4yI/ZK4tCkWXzkrX3G9gU355jBIfPjJq5C8fx
         7PyzXPjAewdjvRTLN6gL5RiWmhDLwlelx28WOjDgR+18dKgw6isR1sG0/Iu8aI8TIDIB
         jjZkLryQWjX4gQLuvA5bqP+TONklZPRhE/eQZcqkPNgfWt/9gknKBvnI3w5W86Bhxh+C
         +FsEDxE+TH0jHtjs6zMPbhXeu7HgeYE//iixuScVCltsulvUMuEfA2PE7Mq/2bbmAjFz
         hgCw==
X-Forwarded-Encrypted: i=1; AL+hErFdY/yP0J6qMacArgUBZelo3pp9oeFKVsWFVIUc8q3AAmWLxrDqX73lzHjrb+wawNp7WRM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ARzVmqJLh1DKr2mw62viSmsVBGp7ipfEIGnZdndqZ/P/5mJem
	seKw6eru7exWJ3DaqgPi9ooPYGIQ1IJ4iTnNUaFQgqtJDdFAehSmzkIGzptEzg30rybQF0B3uY8
	He6YTQg==
X-Received: from pjbgc19.prod.google.com ([2002:a17:90b:3113:b0:3b0:a379:b383])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a50:b0:3a8:c0cd:57f9
 with SMTP id 98e67ed59e1d1-3b1b0a0db23mr2345964a91.25.1794577656089; Fri, 13
 Nov 2026 05:47:36 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:14 -0800
In-Reply-To: <20260922071945.693714-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260922071945.693714-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441838666.82439.8379969006436543719.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Fix incremental build dependencies
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, James Houghton <jthoughton@google.com>, Will Deacon <will@kernel.org>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 22 Sep 2026 08:19:43 +0100, Fuad Tabba wrote:
> Changes since v1 [1]:
>   - Use FORCE for the sysreg header rule instead of duplicating the
>     generator's inputs. (Oliver)
>   - Added patch 2, the same class of bug in libcgroup.mk, found while
>     testing patch 1.
> 
> Two fixes for Makefile rules that name a directory where a file's mtime
> is what matters. The first is arm64-only: the sysreg header isn't
> regenerated on an incremental build when the sysreg table changes. The
> second is arch-independent: cgroup_util.o recompiles, and every test
> relinks, on the run after any rebuild in lib/. The two patches are
> independent.
> 
> [...]

Applied patch 1 to kvm-x86 fixes, thanks!

[1/2] KVM: selftests: Fix arm64 sysreg header dependencies
      https://github.com/kvm-x86/linux/commit/b2ddd6af0646

--
https://github.com/kvm-x86/linux/tree/next
